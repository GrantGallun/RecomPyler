"""Conservative source provenance, independent of representations and backends.

Facts describe possible origins, never permission to bypass Python operations.
In particular an operation or a path may invoke user code. Unknown must decline.
Summaries retain only primitive descriptors and weak dependency witnesses.
"""
import ast
import dis
import inspect
import io
import linecache
import tokenize
import struct
import textwrap
import types
import weakref
from dataclasses import dataclass, field


@dataclass(frozen=True)
class Origin:
    kind: str
    key: tuple = ()
    parents: tuple = ()
    scope: int = 0  # compile-scoped original code witness, never a durable object recipe


@dataclass(frozen=True)
class Value:
    origins: frozenset
    children: tuple = ()
    contained: frozenset = frozenset()

    @property
    def unknown(self):
        return any(o.kind == 'unknown' for o in self.origins)


UNKNOWN = Value(frozenset((Origin('unknown'),)))
NONE = Value(frozenset((Origin('singleton', ('None',)),)))


def argument(index):
    return Value(frozenset((Origin('argument', (index,)),)))


def exempt_number(value):
    t=type(value)
    return t is int or t is float or t is complex


def site(node):
    return (node.lineno, node.col_offset, node.end_lineno, node.end_col_offset, type(node).__name__)


def join(left, right):
    if left == right:
        return left
    # Structural children of different possible aggregate owners cannot be
    # paired without a correlated tag; do not invent that correlation.
    return Value(left.origins | right.origins, contained=frozenset(descendants(left) | descendants(right)))


def descendants(value):
    result = set(value.origins) | set(value.contained)
    pending=list(result)
    while pending:
        for parent in pending.pop().parents:
            if parent not in result:
                result.add(parent);pending.append(parent)
    for child in value.children:
        result.update(descendants(child))
    return result


def substitute(value, actuals):
    """Substitute original formal facts; callee allocations need dynamic tags.

    Existing actual values retain their owners. A callee allocation site alone
    cannot identify distinct invocations, so substitution returns unknown for
    those producers instead of inventing a per-call freshness certificate.
    """
    if len(value.origins)==1 and not value.children and not value.contained:
        only=next(iter(value.origins))
        if only.kind=='argument':
            return actuals.get(only.key[0],UNKNOWN)
    reachable=set()
    def origin(o):
        if o.kind == 'allocation':return UNKNOWN.origins
        if o.kind == 'argument':
            actual=actuals.get(o.key[0], UNKNOWN)
            reachable.update(descendants(actual))
            return actual.origins
        parents = []
        for parent in o.parents:
            parents.extend(origin(parent))
        return frozenset((Origin(o.kind, o.key, tuple(parents), o.scope),))
    origins = frozenset(p for o in value.origins for p in origin(o))
    contained=frozenset(p for o in value.contained for p in origin(o)) | frozenset(reachable)
    return Value(origins, tuple(substitute(v, actuals) for v in value.children), contained)


def resolve_constant(fn, path):
    value = fn.__code__
    for index in path:
        value = value.co_consts[index] if type(value) is types.CodeType else value[index]
    return value


def resolve_origin(fn, origin):
    """Resolve a constant only with its still-guarded original function."""
    if origin.kind!='constant' or origin.scope!=id(fn.__code__):
        raise ValueError('constant origin belongs to another original code scope')
    return resolve_constant(fn,origin.key)


def _code_key(code):
    def key(value):
        t = type(value)
        if t is types.CodeType:
            return _code_key(value)
        if t is float:
            return ('float', struct.pack('!d', value))
        if t is complex:
            return ('complex', struct.pack('!dd', value.real, value.imag))
        if t is slice:
            return ('slice', key(value.start), key(value.stop), key(value.step))
        if t is tuple:
            return ('tuple', tuple(map(key, value)))
        if t is frozenset:
            return ('frozenset', tuple(sorted(map(key, value), key=repr)))
        if t is str or t is bytes or t is int or t is bool or value is None or value is Ellipsis:
            return (t.__name__, value)
        raise ValueError('unsupported application code constant')
    return (code.co_code, code.co_names, code.co_varnames, code.co_cellvars,
            code.co_freevars, code.co_flags, code.co_stacksize, getattr(code,'co_exceptiontable',b''), code.co_argcount, code.co_posonlyargcount,
            code.co_kwonlyargcount, tuple(map(key, code.co_consts)),
            code.co_name, getattr(code,'co_qualname',code.co_name), code.co_filename,
            code.co_firstlineno, code.co_nlocals, code.co_linetable,
            tuple(code.co_positions()) if hasattr(code,'co_positions') else None)


@dataclass(frozen=True)
class Store:
    location: Value
    previous: Value
    value: Value
    at: tuple


@dataclass
class Summary:
    valid: bool = False
    reason: str = 'source provenance is unknown'
    result: Value = UNKNOWN
    expressions: dict = field(default_factory=dict)
    before: dict = field(default_factory=dict)
    after: dict = field(default_factory=dict)
    stores: list = field(default_factory=list)
    escaped: set = field(default_factory=set)
    observations: list = field(default_factory=list)
    dependencies: tuple = ()
    assumptions: frozenset = frozenset()
    _function: object = field(default=None, repr=False)
    _code: object = field(default=None, repr=False)
    _witnesses: dict = field(default_factory=dict, repr=False)

    def at(self, point, name, *, after=False):
        return (self.after if after else self.before).get(point, {}).get(name, UNKNOWN)

    def may_alias(self, left, right):
        if not self.valid or left.unknown or right.unknown:
            return True
        for a in left.origins:
            for b in right.origins:
                if a == b:
                    return True
                # Only distinct, single-execution allocations prove disjointness.
                if a.kind == b.kind == 'allocation' and a != b:
                    continue
                return True
        return False

    def may_escape(self, value):
        if not self.valid or value.unknown or any(o.kind in ('attribute','element','operation') for o in value.origins):
            return True
        return bool(descendants(value) & self.escaped) or any(o.kind == 'unknown' for o in self.escaped)

    def identity_observable(self, value, *, exact_type=None):
        if exact_type is int or exact_type is float or exact_type is complex:
            return False  # S49: only external result identity is exempt.
        return self.may_escape(value) or any(o.kind in ('argument','global','attribute','element','constant') for o in value.origins)

    def naturally_rooted(self, value):
        """A source fact cannot establish a physical runtime/journal root."""
        return None

    def identity_safe(self, argument_types):
        if not self.valid:
            return False
        def kind(value):
            kinds = []
            for o in descendants(value):
                if o.kind == 'argument':
                    kinds.append(argument_types.get(o.key[0]))
                elif o.kind == 'singleton':
                    kinds.append(type(None) if o.key == ('None',) else bool)
                elif o.kind == 'allocation':
                    kinds.append(tuple if o.key[-1] == 'Tuple' else list)
                else:
                    kinds.append(None)
            return kinds
        for left, right in self.observations:
            if right is None:
                return False  # unresolved callback may inspect an unseen numeric descendant
            # 'is None/True/False' is safe even when other side is a number.
            if right is not None and (all(o.kind == 'singleton' for o in left.origins)
                                     or all(o.kind == 'singleton' for o in right.origins)):
                continue
            def nonnumber(value):
                return all(t is not None and t is not int and t is not float and t is not complex for t in kind(value))
            if right is not None and (nonnumber(left) or nonnumber(right)):
                continue
            for value in (left,) if right is None else (left, right):
                if any(t is None or t is int or t is float or t is complex for t in kind(value)):
                    return False
        return True

    def dependencies_match(self, fn):
        # Weak witnesses avoid retaining graphs; an expired witness cannot be
        # revived by allocator ID reuse. Non-weak global/default owners need a
        # consumer's live pins; this method declines them.
        if not self.valid or self._function is None or self._function() is not fn:
            return False
        if self._code() is not fn.__code__ or fn.__defaults__ is not None or fn.__kwdefaults__ is not None or fn.__closure__ is not None:
            return False
        if not _inert_namespaces(fn):
            return False
        for scope, name, identity in self.dependencies:
            ns = fn.__globals__ if scope == 'global' else fn.__builtins__
            value = ns.get(name)
            witness = self._witnesses.get((scope, name))
            if witness is None or witness() is not value or id(value) != identity:
                return False
        return True


def _inert_namespaces(fn):
    return (type(fn.__globals__) is dict and type(fn.__builtins__) is dict
            and all(type(k) is str for ns in (fn.__globals__,fn.__builtins__) for k in ns))


# Source acquisition happens during explicit analysis/compilation. Public text
# entrypoints retain the resulting certificate and do not re-read source.
_RAW_OPEN = io.open
_SOURCE_ENCODING = tokenize.detect_encoding
_LINECACHE_NAMESPACE = linecache.__dict__
_MISSING_SOURCE = object()


def _source_context(code):
    """Read inert cached lines or a local file, never an application loader."""
    filename=code.co_filename
    if type(filename) is not str:raise ValueError('non-inert source filename')
    namespace=dict.copy(_LINECACHE_NAMESPACE)
    if any(type(key) is not str for key in namespace):raise ValueError('non-inert linecache namespace')
    cache=namespace.get('cache')
    if type(cache) is not dict:raise ValueError('non-inert source cache')
    # Copy before checking keys: subsequent application mutations cannot insert
    # a colliding __eq__ callback between validation and the filename lookup.
    snapshot=dict.copy(cache)
    if any(type(key) is not str for key in snapshot):raise ValueError('non-inert source cache key')
    entry=snapshot.get(filename,_MISSING_SOURCE)
    if entry is not _MISSING_SOURCE:
        if (type(entry) is not tuple or len(entry)!=4
                or type(entry[0]) is not int
                or not (entry[1] is None or type(entry[1]) is int or type(entry[1]) is float)
                or type(entry[2]) is not list or type(entry[3]) is not str):
            raise ValueError('lazy or non-inert source cache entry')
        lines=list.copy(entry[2])
        if any(type(line) is not str for line in lines):raise ValueError('non-inert source line')
    else:
        if not filename or filename.startswith(('<','\\\\','//')) or '\x00' in filename:
            raise ValueError('source is not an ordinary local file')
        with _RAW_OPEN(filename,'rb') as stream:
            encoding,_=_SOURCE_ENCODING(stream.readline)
            stream.seek(0)
            lines=stream.read().decode(encoding).splitlines(keepends=True)
    tree=ast.parse(''.join(lines),filename=filename)
    candidates=[]
    for node in ast.walk(tree):
        if isinstance(node,(ast.FunctionDef,ast.AsyncFunctionDef)) and node.name==code.co_name:
            first=min([node.lineno]+[part.lineno for part in node.decorator_list])
            if first==code.co_firstlineno:candidates.append((node,first))
    if len(candidates)!=1:raise ValueError('original function span is not unique')
    node,first=candidates[0]
    return lines,node,first


def _source_lines(code):
    lines,node,first=_source_context(code)
    return lines[first-1:node.end_lineno],first


def _bound_source_lines(code):
    # Recompile the original complete module, but execute none of it. Class
    # flags, closure layout, pooled constants and raw positions stay exact.
    lines,node,first=_source_context(code)
    module=compile(''.join(lines),code.co_filename,'exec',dont_inherit=True)
    pending=[module];matches=[]
    while pending:
        candidate=pending.pop()
        if (candidate.co_name==code.co_name
                and getattr(candidate,'co_qualname',candidate.co_name)==getattr(code,'co_qualname',code.co_name)
                and candidate.co_firstlineno==code.co_firstlineno):
            matches.append(candidate)
        pending.extend(value for value in candidate.co_consts if type(value) is types.CodeType)
    if len(matches)!=1 or _code_key(matches[0])!=_code_key(code):
        raise ValueError('original module context differs from original code')
    return lines[first-1:node.end_lineno],first


class _PositionsUnavailable(ValueError):
    pass


@dataclass
class SourceBinding:
    node: object
    constants: dict
    first: int
    nested_codes: dict = field(default_factory=dict)
    definition_defaults: dict = field(default_factory=dict)
    definition_keywords: dict = field(default_factory=dict)


def bind_source(fn):
    """Bind original source/constants without imposing a consumer control-flow policy."""
    if type(fn) is not types.FunctionType or not _inert_namespaces(fn):
        raise ValueError('requires an exact function with inert namespaces')
    lines, first = _bound_source_lines(fn.__code__)
    node = ast.parse(textwrap.dedent(''.join(lines))).body[0]
    if not isinstance(node, ast.FunctionDef):
        raise ValueError('not an ordinary function')
    constants = {}
    nested_codes = {}
    definition_defaults = {}
    definition_keywords = {}
    code_spans = {}
    spans = {}
    for n in ast.walk(node):
        if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef,ast.ClassDef,ast.Lambda,ast.GeneratorExp)) and n is not node:
            code_spans.setdefault(site(n)[:4],[]).append(n)
        if isinstance(n,ast.expr):
            spans.setdefault(site(n)[:4],[]).append(n)
    indent = len(lines[0]) - len(lines[0].lstrip())
    def foldable(n):
        if isinstance(n,ast.Constant):return True
        if isinstance(n,ast.Tuple):return all(foldable(x) for x in n.elts)
        if isinstance(n,ast.Slice):return all(x is None or foldable(x) for x in (n.lower,n.upper,n.step))
        if isinstance(n,ast.BinOp):return foldable(n.left) and foldable(n.right)
        if isinstance(n,ast.UnaryOp):return foldable(n.operand)
        return False
    def constant(n,path):
        constants[site(n)] = Value(frozenset((Origin('constant',path,scope=id(fn.__code__)),)))
        value = resolve_constant(fn,path)
        if isinstance(n,ast.Tuple) and type(value) is tuple and len(n.elts)==len(value):
            for index,item in enumerate(n.elts):
                constant(item,path+(index,))
    try:
        for ins in dis.get_instructions(fn):
            if ins.opname not in ('LOAD_CONST','LOAD_SMALL_INT'):
                continue
            pos = getattr(ins,'positions',None)
            if pos is None or pos.lineno is None or pos.col_offset is None:
                raise _PositionsUnavailable('instruction positions unavailable')
            span = (pos.lineno-first+1,pos.col_offset-indent,pos.end_lineno-first+1,pos.end_col_offset-indent)
            if ins.opname == 'LOAD_CONST':
                for n in code_spans.get(span,()):
                    if not isinstance(n,ast.FunctionDef):continue
                    if type(ins.argval) is tuple and n.args.defaults and all(foldable(value) for value in n.args.defaults):
                        definition_defaults.setdefault(site(n),ins.argval)
                    elif type(ins.argval) is str:
                        definition_keywords.setdefault(site(n),[]).append(ins.argval)
            if ins.opname == 'LOAD_CONST' and type(ins.argval) is types.CodeType:
                for n in code_spans.get(span,()):
                    key=site(n)
                    if key not in nested_codes:nested_codes[key]=ins.argval
                    elif nested_codes[key] is not ins.argval:nested_codes[key]=None
            for n in spans.get(span,()):
                if not foldable(n):continue
                if ins.opname == 'LOAD_CONST':
                    constant(n,(ins.arg,))
                elif type(ins.argval) is int:
                    constants[site(n)] = Value(frozenset((Origin('operation',site(n),scope=id(fn.__code__)),)))
    finally:
        # Break temporary recursive helper cycles, including their source owner.
        constant = foldable = None
    return SourceBinding(node, constants, first, nested_codes, definition_defaults, definition_keywords)


def analyze(fn, node=None, *, pure_sites=frozenset()):
    """Analyze original source. pure_sites are explicit consumer proof obligations.

    An adapter using pure_sites must independently prove exact types, effects
    and dependency guards for those original sites before applying any fact.
    Such assumptions are exposed on the returned summary, never inferred.
    """
    out = Summary()
    if type(fn) is not types.FunctionType or not _inert_namespaces(fn):
        out.reason = 'requires an exact function with inert namespaces'
        return out
    try:
        binding = bind_source(fn)
        original = binding.node
        if node is not None and ast.dump(node, include_attributes=True) != ast.dump(original, include_attributes=True):
            out.reason = 'supplied AST differs from original source'
            return out
        node = original
    except _PositionsUnavailable:
        out.reason = 'instruction positions unavailable'
        return out
    except (OSError,TypeError,SyntaxError,ValueError,StopIteration,IndentationError) as exc:
        out.reason = 'cannot bind original source/bytecode: ' + type(exc).__name__
        return out
    if fn.__code__.co_freevars and fn.__code__.co_freevars!=('__class__',):
        out.reason='control flow or closure requires an explicit provenance transfer'
        return out
    if node.args.vararg is not None or node.args.kwarg is not None:
        out.reason='variadic parameters require an explicit provenance binding'
        return out
    out._function, out._code = weakref.ref(fn), weakref.ref(fn.__code__)
    # No partial certificate for control flow not modeled by this first solver.
    unsupported = (ast.AsyncFunctionDef,ast.Try,getattr(ast,'TryStar',ast.Try),ast.With,ast.AsyncWith,
                   ast.Yield,ast.YieldFrom,ast.Await,ast.Lambda,ast.Global,ast.Nonlocal,
                   ast.ListComp,ast.SetComp,ast.DictComp,ast.GeneratorExp,ast.Match,
                   ast.NamedExpr,ast.Delete,ast.ClassDef)
    if any(isinstance(n,unsupported) or (isinstance(n,ast.FunctionDef) and n is not node) for n in ast.walk(node)):
        out.reason = 'control flow or closure requires an explicit provenance transfer'
        return out
    constants = binding.constants
    known_sites={site(n) for n in ast.walk(node) if hasattr(n,'lineno')}
    if not set(pure_sites)<=known_sites:
        out.reason='pure transfer refers to a foreign source site'
        return out
    out.assumptions=frozenset(pure_sites)
    deps = {}
    returns = []
    loop_depth = 0
    # An unresolved callback may replace globals/attributes. Source location
    # paths remain descriptive; no adapter may use them as callback-free loads.
    effects = False
    local_names = {n.id for n in ast.walk(node) if isinstance(n,ast.Name) and isinstance(n.ctx,ast.Store)}
    params = [a.arg for a in node.args.posonlyargs+node.args.args+node.args.kwonlyargs]
    local_names.update(params)
    def escape(value):
        out.escaped.update(descendants(value))
    def callback(n,*values):
        nonlocal effects
        if site(n) in out.assumptions:return
        effects=True
        for value in values:
            escape(value);out.observations.append((value,None))
    def remember(n,value):
        key=site(n)
        out.expressions[key]=join(out.expressions[key],value) if key in out.expressions else value
        return value
    def path(kind,key,base):
        return Value(frozenset((Origin(kind,key,tuple(sorted(base.origins,key=repr)),id(fn.__code__)),)))
    def invalidate_mutable(value):
        children=tuple(invalidate_mutable(child) for child in value.children)
        if any(o.kind=='allocation' and o.key[-1] in ('List','Set','Dict') for o in value.origins):
            return Value(value.origins,contained=frozenset(descendants(value)|{Origin('unknown')}))
        return Value(value.origins,children,value.contained)
    def sanitize(env):
        if effects:
            for name,value in list(env.items()):env[name]=invalidate_mutable(value)
    def expr(n,env):
        nonlocal effects
        if n is None:
            return NONE
        sanitize(env)
        key=site(n)
        out.before[key]=dict(env)
        if isinstance(n,ast.Constant) and (n.value is None or type(n.value) is bool):
            return remember(n,Value(frozenset((Origin('singleton',('None' if n.value is None else str(n.value),)),))))
        if key in constants:
            return remember(n,constants[key])
        if isinstance(n,ast.Name):
            if n.id in env:
                value=env[n.id]
            elif n.id in local_names or n.id in fn.__code__.co_freevars or effects:
                value=UNKNOWN
            else:
                scope='global' if n.id in fn.__globals__ else 'builtin'
                ns=fn.__globals__ if scope=='global' else fn.__builtins__
                if n.id not in ns:
                    value=UNKNOWN
                else:
                    obj=ns[n.id];deps[(scope,n.id)]=id(obj)
                    try:out._witnesses[(scope,n.id)]=weakref.ref(obj)
                    except TypeError:pass
                    value=Value(frozenset((Origin('global',(scope,n.id),scope=id(fn.__code__)),)))
            return remember(n,value)
        if isinstance(n,(ast.Tuple,ast.List,ast.Set)):
            members=[]
            for item in n.elts:
                member=expr(item,env);members.append(member)
                if isinstance(n,ast.Set):callback(n,member)
            children=tuple(members)
            if any(isinstance(item,ast.Starred) for item in n.elts):
                value=UNKNOWN if loop_depth else Value(frozenset((Origin('allocation',key,scope=id(fn.__code__)),)),contained=frozenset(o for child in children for o in descendants(child)))
            else:
                value=UNKNOWN if loop_depth else Value(frozenset((Origin('allocation',key,scope=id(fn.__code__)),)),children)
        elif isinstance(n,ast.Dict):
            members=[]
            for key_expr,value_expr in zip(n.keys,n.values):
                if key_expr is None:
                    value=expr(value_expr,env);members.append(value);callback(n,value)
                else:
                    key_value=expr(key_expr,env);value=expr(value_expr,env)
                    members.extend((key_value,value));callback(n,key_value)
            children=tuple(members)
            value=UNKNOWN if loop_depth else Value(frozenset((Origin('allocation',key,scope=id(fn.__code__)),)),children)
        elif isinstance(n,ast.Attribute):
            base=expr(n.value,env)
            value=path('attribute',(n.attr,)+key,base)
            callback(n,base)
        elif isinstance(n,ast.Subscript):
            base=expr(n.value,env);index=expr(n.slice,env)
            callback(n,index)
            value=path('element',site(n.slice),base)
            callback(n,base)
        elif isinstance(n,ast.Starred):
            callback(n,expr(n.value,env));value=UNKNOWN
        elif isinstance(n,ast.IfExp):
            callback(n.test,expr(n.test,env));value=join(expr(n.body,env),expr(n.orelse,env))
        elif isinstance(n,ast.BoolOp):
            values=[]
            for child in n.values:
                value=expr(child,env);values.append(value);callback(child,value)
            value=values[0]
            for other in values[1:]:value=join(value,other)
        elif isinstance(n,ast.Compare):
            left=expr(n.left,env)
            for op,other in zip(n.ops,n.comparators):
                right=expr(other,env)
                if isinstance(op,(ast.Is,ast.IsNot)):out.observations.append((left,right))
                else:
                    callback(n,left,right)
                left=right
            value=Value(frozenset((Origin('operation',key,scope=id(fn.__code__)),)))
        elif isinstance(n,ast.Call):
            target=expr(n.func,env)
            actuals=[expr(x,env) for x in n.args]
            for keyword in n.keywords:
                value=expr(keyword.value,env);actuals.append(value)
                if keyword.arg is None:callback(n,value)
            # Generic calls may inspect identity, retain and mutate arguments.
            # A capability-specific consumer must prove and guard a call summary.
            callback(n,target,*actuals)
            value=Value(frozenset((Origin('operation',key,scope=id(fn.__code__)),))) if key in out.assumptions else UNKNOWN
        elif isinstance(n,(ast.BinOp,ast.UnaryOp)):
            for child in ast.iter_child_nodes(n):
                if isinstance(child,ast.expr):
                    operand=expr(child,env);callback(n,operand)
            value=Value(frozenset((Origin('operation',key,scope=id(fn.__code__)),)))
        elif isinstance(n,ast.Constant):
            value=UNKNOWN  # inert literal with no executable LOAD_CONST (e.g. docstring)
        else:
            # Every unmodeled expression may invoke a Python protocol. Unknown
            # means callback/escape too, not just an unmaterializable result.
            values=[expr(child,env) for child in ast.iter_child_nodes(n) if isinstance(child,ast.expr)]
            callback(n,*(values or [UNKNOWN]));value=UNKNOWN
        return remember(n,value)
    def merged(a,b):
        if a is None:return b
        if b is None:return a
        return {name:join(a.get(name,UNKNOWN),b.get(name,UNKNOWN)) for name in a.keys()|b.keys()}
    def assign(target,value,env):
        nonlocal effects
        if isinstance(target,ast.Name):
            env[target.id]=value
        elif isinstance(target,(ast.Tuple,ast.List)):
            if not value.children:callback(target,value)
            ordered=all(o.kind=='allocation' and o.key[-1] in ('Tuple','List') for o in value.origins)
            if len(value.origins)==1 and next(iter(value.origins)).kind=='constant':
                try:ordered=type(resolve_constant(fn,next(iter(value.origins)).key)) is tuple
                except (IndexError,TypeError):ordered=False
            members=value.children if ordered and not value.contained and len(value.children)==len(target.elts) else (UNKNOWN,)*len(target.elts)
            for item,member in zip(target.elts,members):assign(item,member,env)
        else:
            previous=expr(target,env)
            out.stores.append(Store(previous,previous,value,site(target)))
            escape(value);effects=True
    def block(statements,env):
        nonlocal loop_depth
        env=dict(env)
        for n in statements:
            sanitize(env)
            out.before[site(n)]=dict(env)
            if isinstance(n,ast.Assign):
                value=expr(n.value,env)
                for target in n.targets:assign(target,value,env)
            elif isinstance(n,ast.AnnAssign):
                if n.value is not None:assign(n.target,expr(n.value,env),env)
            elif isinstance(n,ast.AugAssign):
                callback(n,expr(n.target,env),expr(n.value,env))
                assign(n.target,Value(frozenset((Origin('operation',site(n),scope=id(fn.__code__)),))),env)
            elif isinstance(n,ast.Assert):
                # Truth conversion may call/retain user objects. The message
                # belongs to the failing edge and may escape in AssertionError.
                callback(n,expr(n.test,env))
                if n.msg is not None:callback(n,expr(n.msg,dict(env)))
            elif isinstance(n,ast.Return):
                value=expr(n.value,env);returns.append(value);escape(value)
                out.after[site(n)]={};return None
            elif isinstance(n,ast.If):
                callback(n.test,expr(n.test,env));env=merged(block(n.body,env),block(n.orelse,env))
            elif isinstance(n,(ast.For,ast.While)):
                loop_depth+=1
                callback(n.iter if isinstance(n,ast.For) else n.test,expr(n.iter if isinstance(n,ast.For) else n.test,env))
                loop_depth-=1
                stores={x.id for part in n.body for x in ast.walk(part) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store)}
                if isinstance(n,ast.For):stores.update(x.id for x in ast.walk(n.target) if isinstance(x,ast.Name))
                widened=dict(env)
                for name in stores:widened[name]=UNKNOWN
                loop_depth+=1
                block(n.body,widened)
                loop_depth-=1
                if isinstance(n,ast.While):
                    loop_depth+=1;callback(n.test,expr(n.test,widened));loop_depth-=1
                other=block(n.orelse,widened)
                can_break=any(isinstance(x,ast.Break) for part in n.body for x in ast.walk(part))
                env=merged(widened,other) if can_break else other
            elif isinstance(n,(ast.Break,ast.Continue)):
                return None
            elif isinstance(n,ast.Expr):
                expr(n.value,env)
            elif isinstance(n,ast.Raise):
                callback(n,expr(n.exc,env),expr(n.cause,env));return None
            elif not isinstance(n,ast.Pass):
                out.reason='unmodeled statement: '+type(n).__name__
                return None
            if env is not None:sanitize(env)
            out.after[site(n)]=dict(env) if env is not None else {}
            if env is None:return None
        return env
    tail=block(node.body,{name:argument(i) for i,name in enumerate(params)})
    if tail is not None:
        returns.append(NONE);escape(NONE)
    result=returns[0] if returns else UNKNOWN
    for value in returns[1:]:result=join(result,value)
    # Callback-capable operations can mutate any aliased mutable descendants.
    # No old structural member certificate survives without a typed effect fact.
    if effects:result=invalidate_mutable(result)
    out.result=result
    out.dependencies=tuple((scope,name,identity) for (scope,name),identity in sorted(deps.items()))
    if out.reason.startswith('unmodeled'):
        out.result=UNKNOWN
        return out
    out.valid=True;out.reason=''
    return out

