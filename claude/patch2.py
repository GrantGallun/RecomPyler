p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
old='''        if self.container_loop(node, iterable):
            return
        kind, codes = self.expr(iterable)
        if isinstance(kind, RangeT):
            if name is None:
                self.unsupported("unpacking a number from range()", node)
            held = self.copy_codes(kind, codes)'''
new='''        if self.paired_loop(node, iterable):
            return
        if self.container_loop(node, iterable):
            return
        kind, codes = self.expr(iterable)
        if isinstance(kind, RangeT):
            if name is None:
                self.unsupported("unpacking a number from range()", node)
            held = self.copy_codes(kind, codes)'''
assert s.count(old)==1; s=s.replace(old,new)
old='''    # Generators

    def peek_or_none(self, node):'''
new='''    def paired_loop(self, node, iterable):
        """``for ... in enumerate(xs[, start])`` and ``for ... in zip(xs, ys, ...)`` over
        lists and ranges. Neither builds its tuples: every source is read by position,
        its length checked each time round as its own iterator would, and the loop
        ends at the first source that has run out, in argument order."""
        if not (isinstance(iterable, ast.Call) and isinstance(iterable.func, ast.Name)
                and iterable.func.id in ("enumerate", "zip") and not iterable.keywords and iterable.args
                and not any(isinstance(arg, ast.Starred) for arg in iterable.args)):
            return False
        which = iterable.func.id
        if (which in self.info.locals or which in self.namespace or which in self.cells()
                or self.builtins.get(which) is not getattr(builtins, which)):
            return False
        if which == "enumerate" and len(iterable.args) > 2:
            return False
        sources = iterable.args[:1] if which == "enumerate" else iterable.args
        for arg in sources:
            kind = self.peek_or_none(arg)
            if kind is None or not (kind == BOTTOM or type(kind) is ListT or isinstance(kind, RangeT)):
                return False
        self.program.guard("builtin", self.namespace, which, self.builtins, getattr(builtins, which))
        held = []
        for arg in sources:
            kind, codes = self.expr(arg)
            if kind == BOTTOM:
                kind, codes = ListT(), ["-1"]
            if isinstance(kind, RangeT):
                bounds = self.copy_codes(kind, codes)
                held.append((kind, bounds, self.temp(bounds[0])))
            else:
                held.append((kind, [self.temp(codes[0])], self.temp("0")))
        count = None
        if which == "enumerate":
            start = "0"
            if len(iterable.args) == 2:
                start_kind, start_codes = self.expr(iterable.args[1])
                if start_kind not in (INT, BOOL, BOTTOM):
                    self.unsupported(f"enumerate() from {_describe(start_kind)}", node)
                start = self.as_int(start_kind, start_codes) if start_kind != BOTTOM else "0"
            count = self.temp(f"np.int64({start})")
            self.program.arrays_used = True
        self.emit("while True:")
        self.depth += 1
        for kind, codes, position in held:
            if isinstance(kind, RangeT):
                self.emit(f"if ({position} >= {codes[1]}) if {codes[2]} > 0 else ({position} <= {codes[1]}):")
            else:
                self.emit(f"if {position} >= I[{self.physical_index(codes[0], True)}]:")
            self.emit("    break")
        kinds, items = [], []
        if count is not None:
            # Python's counter has no upper limit.
            self.fail(f"{count} == {INT_MAX}")
            kinds.append(INT)
            items.append(self.temp(count))
            self.emit(f"{count} += 1")
        for kind, codes, position in held:
            if isinstance(kind, RangeT):
                kinds.append(INT)
                items.append(self.temp(position))
                self.emit(f"{position} += {codes[2]}")
                continue
            elem = kind.elem
            self.check_item(elem, node)
            data = self.physical_index(f"{codes[0]} + 2", True)
            read = [self.temp(code) for code in self.slot(elem, f"I[{data}] + {position}", nonnegative=True)]
            self.emit(f"{position} += 1")
            if which == "enumerate":
                kinds.append(elem)
                items += read
            else:
                kinds.append(elem)
                items += read
        self.bind(node.target, (TupT(kinds), items), node)
        self.body(node.body)
        self.depth -= 1
        return True

    # Generators

    def peek_or_none(self, node):'''
assert s.count(old)==1; s=s.replace(old,new)
open(p,'w',encoding='utf-8').write(s)
