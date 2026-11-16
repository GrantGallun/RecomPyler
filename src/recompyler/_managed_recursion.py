"""Conservative size-change proof for native calls over read-only owner graphs."""
import ast
import sys
import types

_GETFRAME = sys._getframe
_GETLIMIT = sys.getrecursionlimit
_BUDGET_BUILTINS = all(type(fn) is types.BuiltinFunctionType and fn.__self__ is sys
    and fn.__name__ == name for fn, name in
    ((_GETFRAME, '_getframe'), (_GETLIMIT, 'getrecursionlimit')))


def recursion_budget_clear():
    """Keep bounded native descent away from Python's recursion boundary.

    Admitted owner graphs have at most128 edges. Reserve512 Python frames for
    the original helper and AST iterator/protocol frames; near that boundary
    only the interpreter can give the exact RecursionError.
    """
    if not _BUDGET_BUILTINS:return False
    remaining=_GETLIMIT()-512
    frame=_GETFRAME()
    try:
        while frame is not None:
            remaining-=1
            if remaining<=0:return False
            frame=frame.f_back
        return True
    finally:del frame


def recursive_descent(node, parameters, recursive, descendant_iterator=lambda target:False, *, root_calls=False):
    """Return physical field obligations, or None if progress is unproved.

    The consumer must guard an acyclic bounded graph and ensure these field
    reads are instance dictionary/slot reads, never class values or properties.
    """
    fields=set();valid=True;has_recursion=False
    initial={name:0 if root_calls or index==0 else None for index,name in enumerate(parameters)}

    def merge(a,b):
        return {name:min(a[name],b[name]) if a.get(name) is not None and b.get(name) is not None else None for name in a.keys()|b.keys()}

    def expression(part,env):
        nonlocal valid,has_recursion
        if part is None:return None
        if isinstance(part,ast.Name):return env.get(part.id)
        if isinstance(part,ast.Attribute):
            base=expression(part.value,env)
            if base is not None:fields.add(part.attr);return base+1
            return None
        if isinstance(part,ast.Subscript):
            base=expression(part.value,env);expression(part.slice,env)
            return base+1 if base is not None else None
        if isinstance(part,(ast.List,ast.Tuple)):
            values=[expression(item,env) for item in part.elts]
            return min(values)-1 if values and all(value is not None for value in values) else None
        if isinstance(part,ast.ListComp):
            inner=dict(env)
            for generator in part.generators:
                value=expression(generator.iter,inner)
                if isinstance(generator.target,ast.Name):inner[generator.target.id]=value+1 if value is not None else None
                else:valid=False
                for condition in generator.ifs:expression(condition,inner)
            result=expression(part.elt,inner)
            return result-1 if result is not None else None
        if isinstance(part,ast.Call):
            values=[expression(arg,env) for arg in part.args]
            for key in part.keywords:expression(key.value,env)
            if recursive(part.func):
                has_recursion=True
                if (not root_calls and len(parameters)!=1) or len(values)!=1 or part.keywords or values[0] is None or values[0]<(0 if root_calls else 1):valid=False
            else:
                expression(part.func,env)
                if descendant_iterator(part.func) and len(values)==1 and not part.keywords:return values[0]
            return None
        for child in ast.iter_child_nodes(part):
            if isinstance(child,ast.expr):expression(child,env)
        return None

    def block(statements,env):
        env=dict(env)
        for part in statements:
            if isinstance(part,ast.Assign):
                value=expression(part.value,env)
                for target in part.targets:
                    if isinstance(target,ast.Name):env[target.id]=value
                    else:expression(target,env)
            elif isinstance(part,ast.If):
                expression(part.test,env)
                env=merge(block(part.body,env),block(part.orelse,env))
            elif isinstance(part,ast.For):
                value=expression(part.iter,env);inner=dict(env)
                if isinstance(part.target,ast.Name):inner[part.target.id]=value+1 if value is not None else None
                else:expression(part.target,inner)
                env=merge(env,block(part.body,inner));env=merge(env,block(part.orelse,env))
            elif not isinstance(part,(ast.FunctionDef,ast.ClassDef)):
                for child in ast.iter_child_nodes(part):
                    if isinstance(child,ast.expr):expression(child,env)
        return env
    block(node.body,initial)
    if has_recursion and '__class__' in fields:return None
    return (fields,has_recursion) if valid and (root_calls or not has_recursion or len(parameters)==1) else None
