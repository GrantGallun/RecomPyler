p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''class FnT:
    """A plain function used as a value. Which function it is belongs to the type, so
    a call of the value is a direct call and each callee is compiled per function it
    is handed. Its one machine value is unused."""''','''class FnT:
    """A plain function or a class used as a value. Which one it is belongs to the
    type, so a call of the value is a direct call (or builds an object) and each
    callee is compiled per function it is handed. Its one machine value is unused."""''')
rep('''        return f"function '{kind.fn.__qualname__}'"''','''        return f"{'class' if isinstance(kind.fn, type) else 'function'} '{kind.fn.__qualname__}'"''')
rep('''            if type(value) is FunctionType:
                self.program.guard("item", self.namespace, node.id, value)
                return FnT(value), ["0"]''','''            if type(value) is FunctionType or (type(value) is type and value.__module__ != "builtins"):
                self.program.guard("item", self.namespace, node.id, value)
                return FnT(value), ["0"]''')
rep('''        if isinstance(base[0], FnT):
            callee = self.program.function(_unwrap(base[0].fn))''','''        if isinstance(base[0], FnT):
            if isinstance(base[0].fn, type):
                return self.construct(base[0].fn, node)
            callee = self.program.function(_unwrap(base[0].fn))''')
rep('''        if isinstance(kind, OptT):
            if value is None:
                return [{"f": 0.0, "i": 0, "b": False}[letter] for letter in _machine_types(kind)[:-1]] + [False]
            return self.argument(kind.base, value) + [True]''','''        if isinstance(kind, FnT):
            if value is not kind.fn:
                raise _Mismatch
            return [0]
        if isinstance(kind, OptT):
            if value is None:
                return [{"f": 0.0, "i": 0, "b": False}[letter] for letter in _machine_types(kind)[:-1]] + [False]
            return self.argument(kind.base, value) + [True]''')
rep('''    signature = repr(([_describe(kind) for kind in kinds], classes))''','''    signature = repr(([_describe(kind) + (f"@{id(kind.fn)}" if isinstance(kind, FnT) else "") for kind in kinds],
                      classes))''')
rep('''    if kind in (dict, set, str, bytes) or kind.__module__ in ("builtins", "array"):
''','''    if kind is FunctionType or (kind is type and value.__module__ != "builtins"):
        return FnT(value)
    if kind in (dict, set, str, bytes) or kind.__module__ in ("builtins", "array"):
''')
open(p,'w',encoding='utf-8').write(s)
