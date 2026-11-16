p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''@njit(error_model="numpy", inline="always")
def add_i(st, a, b):''','''@njit(error_model="numpy")
def list_assign(I, top, st, h, source):
    # ``a[:] = b``: a keeps its identity and takes b's items.
    if h == source:
        return
    count = I[source]
    if count > I[h + 1]:
        data = alloc(I, top, st, count)
        if st[0]:
            return
        I[h + 1] = count
        I[h + 2] = data
    target, start = I[h + 2], I[source + 2]
    for k in range(count):
        I[target + k] = I[start + k]
    I[h] = count


@njit(error_model="numpy", inline="always")
def add_i(st, a, b):''')
rep('''            if node.slice.step is not None or isinstance(kind, ArrT):
                self.unsupported("a slice with a step, or of an array", node)''','''            if node.slice.step is not None:
                self.unsupported("a slice with a step", node)
            self.check_item(kind.elem, node)''')
rep('''            if not isinstance(base[0], ListT) or isinstance(target.slice, ast.Slice):
                self.unsupported("this item assignment", node)''','''            if (isinstance(base[0], ListT) and isinstance(target.slice, ast.Slice) and target.slice.lower is None
                    and target.slice.upper is None and target.slice.step is None):
                # ``a[:] = b`` with b a list (or an array of a's typecode).
                if kind == BOTTOM:
                    raise _Pending
                if not isinstance(kind, ListT) or type(kind) is not type(base[0]) or (
                        getattr(kind, "code", None) != getattr(base[0], "code", None)):
                    self.unsupported(f"{_describe(base[0])}[:] = {_describe(kind)}", node)
                cell = _find(base[0].cell)
                if not isinstance(base[0], ArrT):
                    self.program.unify(base[0].cell, kind.cell)
                    cell = _find(base[0].cell)
                    self.check_item(cell.elem, node)
                cell.mutated = True
                self.emit(f"list_assign(I, top, st, {base[1][0]}, {codes[0]})")
                self.check()
                return
            if not isinstance(base[0], ListT) or isinstance(target.slice, ast.Slice):
                self.unsupported("this item assignment", node)''')
open(p,'w',encoding='utf-8').write(s)
