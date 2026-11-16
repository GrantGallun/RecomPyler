"""Immutable entry layout and private reusable native-call storage."""
import ast
from types import FunctionType


class EntryPlan:
    def __init__(self, fn):
        code = fn.__code__
        self.positional = code.co_argcount
        self.simple = not (code.co_kwonlyargcount or code.co_flags & 4)
        count = code.co_argcount + code.co_kwonlyargcount
        self.names = code.co_varnames[:count + bool(code.co_flags & 4)]
        self.supported = not code.co_flags & 8 and all(type(name) is str for name in self.names)
        self.binder_code = None
        if self.supported:
            self.supported = len(set(self.names)) == len(self.names)
        if not self.supported:
            return
        # Let CPython bind the uncommon keyword/default/varargs paths. This code
        # has no user body, annotations, defaults or inspect hooks to execute.
        parameters = [ast.arg(arg=name) for name in self.names[:count]]
        signature = ast.arguments(
            posonlyargs=parameters[:code.co_posonlyargcount],
            args=parameters[code.co_posonlyargcount:code.co_argcount],
            vararg=ast.arg(arg=self.names[count]) if code.co_flags & 4 else None,
            kwonlyargs=parameters[code.co_argcount:],
            kw_defaults=[None] * code.co_kwonlyargcount,
            kwarg=None, defaults=[])
        node = ast.FunctionDef(name='_bind', args=signature,
            body=[ast.Return(value=ast.Tuple(elts=[ast.Name(id=name, ctx=ast.Load())
                for name in self.names], ctx=ast.Load()))], decorator_list=[], type_params=[])
        namespace = {}
        exec(compile(ast.fix_missing_locations(ast.Module(body=[node], type_ignores=[])),
                     '<recompyler entry binding>', 'exec', dont_inherit=True), namespace)
        self.binder_code = namespace['_bind'].__code__

    def bind(self, fn, args, kwargs, scratch):
        defaults, keywords = fn.__defaults__, fn.__kwdefaults__
        if (defaults is not None and type(defaults) is not tuple
                or keywords is not None and type(keywords) is not dict):
            return None
        if keywords and any(type(key) is not str for key in keywords):
            return None
        if self.simple and not kwargs and len(args) == self.positional:
            return args
        if any(type(key) is not str for key in kwargs):
            return None
        binder = scratch.binder
        binder.__defaults__, binder.__kwdefaults__ = defaults, keywords
        try:
            try:
                return binder(*args, **kwargs)
            except TypeError:
                # Original function owns argument-error text and context.
                return None
        finally:
            binder.__defaults__ = binder.__kwdefaults__ = None


class CallScratch:
    __slots__ = ('counts', 'results', 'binder')

    def __init__(self, plan, counter_slots):
        import numpy as np
        self.counts = np.zeros(counter_slots, dtype=np.int64)
        self.results = []
        self.binder = FunctionType(plan.binder_code, {}) if plan.binder_code else None
