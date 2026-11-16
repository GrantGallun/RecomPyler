p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
old='''    def isinstance_test(self, node):
        wanted = self.class_named(node.args[1])
        if wanted is None:
            self.unsupported("isinstance() with something other than one class", node)
        kind, codes = self.expr(node.args[0])
'''
new='''    def builtin_class(self, node):
        """The built-in class a bare name refers to, or None."""
        if (isinstance(node, ast.Name) and node.id in _BUILTIN_CLASSES and node.id not in self.info.locals
                and node.id not in self.namespace and node.id not in self.cells()
                and self.builtins.get(node.id) is _BUILTIN_CLASSES[node.id]):
            self.program.guard("builtin", self.namespace, node.id, self.builtins, _BUILTIN_CLASSES[node.id])
            return _BUILTIN_CLASSES[node.id]
        return None

    def isinstance_builtin(self, kind, codes, wanted, node):
        """Code for isinstance() of a value against a built-in class: the value's
        type here says what Python type it has."""
        if wanted is object:
            return "True"
        if kind in (NONE, BOTTOM) or isinstance(kind, (ObjT, ArrT, RangeT, FnT, RngT, NdT)) or _is_np(kind):
            if _is_np(kind) or isinstance(kind, (RangeT, NdT, FnT)):
                # numpy scalars subclass Python numbers; a range, function or class is one too.
                self.unsupported(f"isinstance() of {_describe(kind)} and '{wanted.__name__}'", node)
            # Objects in a region never subclass a built-in type (_object_problem).
            return "False"
        if isinstance(kind, OptT):
            inner = self.isinstance_builtin(kind.base, codes[:-1], wanted, node)
            return "False" if inner == "False" else f"({codes[-1]} and {inner})"
        if kind == MIXED:
            return codes[1] if wanted is int else f"(not {codes[1]})" if wanted is float else "False"
        if isinstance(kind, str):
            actual = {INT: int, FLOAT: float, BOOL: bool}[kind]
        else:
            actual = (tuple if isinstance(kind, TupT) else str if isinstance(kind, StrT) else dict
                      if isinstance(kind, DictT) else set if isinstance(kind, SetT) else list)
        if not issubclass(actual, wanted):
            return "False"
        return self.none_test(kind, codes).replace("(not ", "(", 1) if self.none_test(kind, codes).startswith(
            "(not ") else ("True" if self.none_test(kind, codes) == "False" else f"(not {self.none_test(kind, codes)})")

    def isinstance_test(self, node):
        choices = node.args[1].elts if isinstance(node.args[1], ast.Tuple) else [node.args[1]]
        builtin = [self.builtin_class(choice) for choice in choices]
        if choices and all(found is not None for found in builtin):
            kind, codes = self.expr(node.args[0])
            if kind == BOTTOM:
                raise _Pending
            codes = [self.temp(code) for code in codes]
            tests = [self.isinstance_builtin(kind, codes, wanted, node) for wanted in builtin]
            if "True" in tests:
                return BOOL, ["True"]
            tests = [test for test in tests if test != "False"]
            return BOOL, [self.temp(" or ".join(tests)) if tests else "False"]
        wanted = self.class_named(node.args[1])
        if wanted is None:
            self.unsupported("isinstance() with something other than one class", node)
        kind, codes = self.expr(node.args[0])
'''
assert s.count(old)==1; s=s.replace(old,new)
old='''_ARITHMETIC = {ast.Add:'''
new='''_BUILTIN_CLASSES = {name: getattr(builtins, name) for name in
                    ("int", "float", "bool", "str", "tuple", "list", "dict", "set", "object")}
_ARITHMETIC = {ast.Add:'''
assert s.count(old)==1; s=s.replace(old,new)
open(p,'w',encoding='utf-8').write(s)
