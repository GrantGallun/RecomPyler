import re,sys
p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,count=1):
    global s
    assert s.count(old)==count, (old, s.count(old))
    s=s.replace(old,new)
rep('''class RngT:''','''class FnT:
    """A plain function used as a value. Which function it is belongs to the type, so
    a call of the value is a direct call and each callee is compiled per function it
    is handed. Its one machine value is unused."""

    def __init__(self, fn):
        self.fn = fn

    def __eq__(self, other):
        return type(other) is FnT and other.fn is self.fn

    __hash__ = None


class RngT:''')
rep('''    if isinstance(kind, RangeT):
        return "range"
''','''    if isinstance(kind, RangeT):
        return "range"
    if isinstance(kind, FnT):
        return f"function '{kind.fn.__qualname__}'"
''')
rep('''    if isinstance(kind, RangeT):
        raise Unsupported("a range stored in the heap")
    if isinstance(kind, OptT):
        return _slots(kind.base) + 1''','''    if isinstance(kind, RangeT):
        raise Unsupported("a range stored in the heap")
    if isinstance(kind, FnT):
        raise Unsupported("a function stored in the heap")
    if isinstance(kind, OptT):
        return _slots(kind.base) + 1''')
rep('''        elif isinstance(a, RangeT) and isinstance(b, RangeT):
            return a
''','''        elif isinstance(a, RangeT) and isinstance(b, RangeT):
            return a
        elif isinstance(a, FnT) and a == b:
            return a
''')
rep('''        if isinstance(kind, RangeT):
            raise Unsupported("a range in a container")
''','''        if isinstance(kind, RangeT):
            raise Unsupported("a range in a container")
        if isinstance(kind, FnT):
            raise Unsupported("a function in a container")
''')
rep('''        if isinstance(kind, (TupT, ArrT, RangeT, RngT, NdT) + _HANDLES):
            raise _NoNative''','''        if isinstance(kind, (TupT, ArrT, RangeT, FnT, RngT, NdT) + _HANDLES):
            raise _NoNative''')
rep('''        if isinstance(kind, (TupT, ArrT, OptT, RangeT, RngT, NdT) + _HANDLES):
            return False''','''        if isinstance(kind, (TupT, ArrT, OptT, RangeT, FnT, RngT, NdT) + _HANDLES):
            return False''')
rep('''            if isinstance(kind, (RangeT, RngT, NdT)):
                return True
            if isinstance(kind, TupT):
                return all(plain(item, seen) for item in kind.items)''','''            if isinstance(kind, (RangeT, FnT, RngT, NdT)):
                return True
            if isinstance(kind, TupT):
                return all(plain(item, seen) for item in kind.items)''')
rep('''            elif isinstance(kind, TupT):
                # Tuples of different lengths can never share a copy.
                parts.append(("t", len(kind.items)))''','''            elif isinstance(kind, FnT):
                parts.append(("fn", id(kind.fn)))
            elif isinstance(kind, TupT):
                # Tuples of different lengths can never share a copy.
                parts.append(("t", len(kind.items)))''')
rep('''        if isinstance(kind, RangeT):
            raise Unsupported("a range boxed into the heap")''','''        if isinstance(kind, (RangeT, FnT)):
            raise Unsupported(f"{_describe(kind)} boxed into the heap")''')
rep('''        if isinstance(kind, RangeT):
            raise Unsupported("a range stored in the heap")
        at = self.physical_index(where, nonnegative)''','''        if isinstance(kind, (RangeT, FnT)):
            raise Unsupported(f"{_describe(kind)} stored in the heap")
        at = self.physical_index(where, nonnegative)''',2)
rep('''        if any(isinstance(kind, RangeT) for kind, _ in items):
            self.unsupported("a range in a tuple", node)''','''        if any(isinstance(kind, RangeT) for kind, _ in items):
            self.unsupported("a range in a tuple", node)
        if any(isinstance(kind, FnT) for kind, _ in items):
            self.unsupported("a function in a tuple", node)''')
rep('''        if isinstance(ik, (ListT, TupT, RangeT)) or ik == MIXED:''','''        if isinstance(ik, (ListT, TupT, RangeT, FnT)) or ik == MIXED:''')
# expr_Name: a module-level plain function as a value
rep('''            made = self.global_constant(node, value)
            if made is not None:
                return made
            if type(value) in (list, dict, set)''','''            made = self.global_constant(node, value)
            if made is not None:
                return made
            if type(value) is FunctionType:
                self.program.guard("item", self.namespace, node.id, value)
                return FnT(value), ["0"]
            if type(value) in (list, dict, set)''')
rep('''        if base[0] == NONE:
            self.fail("True")
            return BOTTOM, ["0"]
        if not isinstance(base[0], ObjT):
            self.unsupported("a call of something that is not a named function, class or callable object", node)''','''        if base[0] == NONE:
            self.fail("True")
            return BOTTOM, ["0"]
        if isinstance(base[0], FnT):
            callee = self.program.function(_unwrap(base[0].fn))
            args = self.call_args(node.args)
            return self.call(callee, args, node, self.call_keywords(node))
        if not isinstance(base[0], ObjT):
            self.unsupported("a call of something that is not a named function, class or callable object", node)''')
# loader / unloader: a function never crosses the boundary
rep('''    def value(self, kind, where):
        if isinstance(kind, RangeT):
            raise _Mismatch''','''    def value(self, kind, where):
        if isinstance(kind, (RangeT, FnT)):
            raise _Mismatch''')
rep('''    def reference(self, kind, handle):
        if isinstance(kind, RangeT):
            raise _Mismatch''','''    def reference(self, kind, handle):
        if isinstance(kind, (RangeT, FnT)):
            raise _Mismatch''')
rep('''    def result(self, kind, codes):
        if isinstance(kind, RangeT):
            raise _Mismatch''','''    def result(self, kind, codes):
        if isinstance(kind, (RangeT, FnT)):
            raise _Mismatch''')
open(p,'w',encoding='utf-8').write(s)
