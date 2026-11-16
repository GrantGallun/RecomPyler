p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''        whole = math.floor(div)
        if div - whole > 0.5:''','''        whole = np.floor(div)
        if div - whole > 0.5:''')
rep('''        sources = iterable.args[:1] if which == "enumerate" else iterable.args
        for arg in sources:
            kind = self.peek_or_none(arg)
            if kind is None or not (kind == BOTTOM or type(kind) is ListT or isinstance(kind, RangeT)):
                return False
        self.program.guard("builtin", self.namespace, which, self.builtins, getattr(builtins, which))
        held = []
        for arg in sources:
            kind, codes = self.expr(arg)
            if kind == BOTTOM:
                kind = ListT()''','''        sources = iterable.args[:1] if which == "enumerate" else iterable.args

        def direct(arg):
            # ``range(...)`` written in place: never a value of its own.
            return (isinstance(arg, ast.Call) and isinstance(arg.func, ast.Name) and arg.func.id == "range"
                    and "range" not in self.info.locals and "range" not in self.namespace
                    and "range" not in self.cells() and self.builtins.get("range") is range
                    and not arg.keywords and 1 <= len(arg.args) <= 3
                    and not any(isinstance(part, ast.Starred) for part in arg.args))

        for arg in sources:
            if direct(arg):
                continue
            kind = self.peek_or_none(arg)
            if kind is None or not (kind == BOTTOM or isinstance(kind, (ListT, RangeT))):
                return False
        self.program.guard("builtin", self.namespace, which, self.builtins, getattr(builtins, which))
        held = []
        for arg in sources:
            if direct(arg):
                self.program.guard("builtin", self.namespace, "range", self.builtins, range)
                bounds = []
                for part in arg.args:
                    part_kind, part_codes = self.expr(part)
                    if part_kind in (NPI, NPIQ):
                        part_kind, part_codes = self.present(part_kind, part_codes)
                    if part_kind not in (INT, BOOL, BOTTOM):
                        self.unsupported(f"range() of {_describe(part_kind)}", node)
                    bounds.append((INT, [self.temp(self.as_int(part_kind, part_codes) if part_kind != BOTTOM
                                                   else "0")]))
                kind, codes = self.range_value(bounds, node, first_class=False)
            else:
                kind, codes = self.expr(arg)
            if kind == BOTTOM:
                kind = ListT()''')
open(p,'w',encoding='utf-8').write(s)
