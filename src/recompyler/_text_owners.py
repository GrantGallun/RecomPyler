"""Positive immutable-owner certificates for newly admitted text units.

This module has no Numba dependency: saved AOT wrappers rebuild certificates
against their current original Python function, including its exact constants.
Unknown provenance is never recovered from equality or a native data pointer.
"""
import ast
import dis
import inspect
import struct
import sys
import textwrap
import types as pytypes
from . import provenance
from dataclasses import dataclass, field

PREDICATES=frozenset(('isidentifier','islower','isnumeric','isprintable','isspace','istitle','isupper','isascii','isalnum','isalpha','isdecimal','isdigit'))
SEARCHES=frozenset(('find','index','rfind','rindex','count','startswith','endswith'))
_BUILTINS={'len':len,'range':range,'enumerate':enumerate}
# Retain APIs once; checking a warm call performs no imports or replaceable
# module attribute lookup that could itself invoke an application callback.
_GETTRACE, _GETPROFILE = sys.gettrace, sys.getprofile
_MONITORING=getattr(sys,'monitoring',None)
_EVENTS = _MONITORING.get_events if _MONITORING is not None else lambda tool:0
_LOCAL_EVENTS = _MONITORING.get_local_events if _MONITORING is not None else lambda tool,code:0

def observers_clear(functions):
    if _GETTRACE() is not None or _GETPROFILE() is not None:return False
    for tool in range(6):
        if _EVENTS(tool):return False
        if any(_LOCAL_EVENTS(tool,fn.__code__) for fn in functions):return False
    return True

@dataclass(frozen=True)
class Owner:
    kind:str
    key:tuple=()
    children:tuple=()
    value:object=field(default=None,compare=False,repr=False)

UNKNOWN=Owner('unknown')

@dataclass
class Certificate:
    result:Owner=UNKNOWN
    valid:bool=False
    reason:str='immutable owner provenance is unknown'
    methods:tuple=()
    globals:dict=field(default_factory=dict,repr=False)
    builtins:dict=field(default_factory=dict,repr=False)
    analysis:object=field(default=None,repr=False)


def inert_arguments(values):
    pending=list(values);budget=4096
    while pending:
        budget-=1
        if budget<0:return False
        value=pending.pop();kind=type(value)
        if kind is str or kind is int or kind is float or kind is bool or value is None:continue
        if kind is tuple:pending.extend(value)
        else:return False
    return True


def _constant(value):
    return Owner('constant',(id(value),),value=value)


def analyze(fn,node):
    """Text policy over the shared original-source solver; no private dataflow."""
    namespace=fn.__globals__;builtins=fn.__builtins__
    if type(namespace) is not dict or type(builtins) is not dict or any(type(k) is not str for d in (namespace,builtins) for k in d):
        return Certificate(reason='text unit requires inert string-keyed namespaces')
    methods=[];valid=True
    for part in ast.walk(node):
        if isinstance(part,(ast.Subscript,ast.Attribute)) and isinstance(part.ctx,ast.Store):valid=False
        if isinstance(part,(ast.Raise,ast.Try,ast.With,ast.AsyncWith,ast.NamedExpr)):valid=False
        if isinstance(part,ast.Call):
            target=part.func
            if isinstance(target,ast.Name):
                expected=_BUILTINS.get(target.id)
                if expected is None or namespace.get(target.id,builtins.get(target.id)) is not expected:valid=False
            elif isinstance(target,ast.Attribute) and target.attr in PREDICATES|SEARCHES:
                methods.append(target.value)
            else:valid=False
        if isinstance(part,ast.Attribute):
            parents=[item for item in ast.walk(node) if isinstance(item,ast.Call) and item.func is part]
            if not parents:valid=False
    if not valid:return Certificate(reason='text unit is not a proved read-only scalar operation')
    # These are assumptions, not neutral-layer inferences: inert_arguments,
    # exact dependency guards and safe()'s all-receiver/type proof discharge them.
    pure=frozenset(provenance.site(part) for part in ast.walk(node) if hasattr(part,'lineno'))
    summary=provenance.analyze(fn,node,pure_sites=pure)
    if not summary.valid:return Certificate(reason=summary.reason)
    by_site={provenance.site(part):part for part in ast.walk(node) if hasattr(part,'lineno')}
    def owner(value):
        if value.unknown or len(value.origins)!=1:return UNKNOWN
        origin=next(iter(value.origins))
        if origin.kind=='argument':return Owner('argument',origin.key)
        if origin.kind=='constant':return _constant(provenance.resolve_origin(fn,origin))
        if origin.kind=='singleton':return _constant({'None':None,'True':True,'False':False}[origin.key[0]])
        if origin.kind=='global':
            scope,name=origin.key
            selected=(namespace if scope=='global' else builtins).get(name)
            kind=type(selected)
            if kind is str or kind is bytes or kind is int or kind is float or kind is bool or selected is None:
                return _constant(selected)
            return UNKNOWN
        if origin.kind=='allocation' and origin.key[-1]=='Tuple' and not value.contained:
            return Owner('tuple',origin.key,tuple(owner(child) for child in value.children))
        if origin.kind=='operation':return Owner('number',origin.key)
        if origin.kind=='element':
            expr=next((part for part in ast.walk(node) if isinstance(part,ast.Subscript) and provenance.site(part.slice)==origin.key),None)
            if expr is not None and not isinstance(expr.slice,ast.Slice):
                return Owner('character',origin.key,value=expr.value)
        return UNKNOWN
    return Certificate(owner(summary.result),True,'',tuple(methods),namespace,builtins,summary)


def safe(certificate,signature,typemap,types):
    """A type-sensitive certificate; selected owner type must be unchanged."""
    if not certificate.valid:return False
    def exact_type(ty):
        if isinstance(ty,types.Literal):ty=ty.literal_type
        if isinstance(ty,types.Boolean):return bool
        if isinstance(ty,types.Integer):return int
        if isinstance(ty,types.Float):return float
        if isinstance(ty,types.Complex):return complex
        if isinstance(ty,types.UnicodeType):return str
        if isinstance(ty,types.BaseTuple):return tuple
        if ty==types.none:return type(None)
        return None
    kinds={i:exact_type(ty) for i,ty in enumerate(signature.args[1:])}
    if not certificate.analysis.identity_safe(kinds):return False
    def unliteral(ty):return ty.literal_type if isinstance(ty,types.Literal) else ty
    def unicode(ty):return isinstance(unliteral(ty),types.UnicodeType)
    def variable(name):
        found=[unliteral(ty) for key,ty in typemap.items() if key==name or key.startswith(name+'.')]
        return found[0] if found and all(ty==found[0] for ty in found) else None
    def receiver(expr):
        if isinstance(expr,ast.Name):
            ty=variable(expr.id)
            return unicode(ty) if ty is not None else type(certificate.globals.get(expr.id)) is str
        return isinstance(expr,ast.Constant) and type(expr.value) is str
    if not all(map(receiver,certificate.methods)):return False
    def constant(ty,value):
        ty=unliteral(ty);kind=type(value)
        if kind is str:return unicode(ty)
        if kind is bool:return isinstance(ty,types.Boolean)
        if value is None:return ty==types.none
        if kind is int:return isinstance(ty,types.Integer) and not isinstance(ty,types.Boolean)
        if kind is float:return isinstance(ty,types.Float)
        return kind is tuple and isinstance(ty,types.BaseTuple) and len(ty.types)==len(value) and all(constant(t,v) for t,v in zip(ty.types,value))
    def visit(ty,owner):
        ty=unliteral(ty)
        if isinstance(ty,(types.Boolean,types.Integer,types.Float,types.Complex)) or ty==types.none:return True
        if owner.kind=='constant':return constant(ty,owner.value)
        if owner.kind=='argument':return ty==unliteral(signature.args[owner.key[0]+1])
        if owner.kind=='tuple':return isinstance(ty,types.BaseTuple) and len(ty.types)==len(owner.children) and all(visit(t,o) for t,o in zip(ty.types,owner.children))
        if owner.kind=='number':return isinstance(ty,(types.Integer,types.Float))
        if owner.kind=='counter':return isinstance(ty,types.Integer) and not isinstance(ty,types.Boolean)
        if owner.kind=='character':return unicode(ty) and receiver(owner.value)
        if isinstance(ty,types.Optional):return visit(ty.type,owner)
        return False
    return visit(signature.return_type,certificate.result)


def materialize(owner,value,arguments):
    """Restore only proved owners; fresh aliases share one per-call memo entry."""
    memo={}
    def visit(plan,result):
        if plan.kind=='argument':return arguments[plan.key[0]]
        if plan.kind=='constant':return plan.value
        if plan.kind=='unknown':return result # only singleton bool/None is certified
        token=(plan.kind,plan.key)
        if token in memo:return memo[token]
        if plan.kind=='tuple':result=tuple(visit(p,v) for p,v in zip(plan.children,result))
        memo[token]=result
        return result
    return visit(owner,value)
