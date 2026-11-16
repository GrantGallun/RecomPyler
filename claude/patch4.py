p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new):
    global s
    assert s.count(old)==1,(old,s.count(old)); s=s.replace(old,new)
rep('''        cell = _find(cell)
        joined = self.join(cell.elem, kind)
        if not _same(joined, cell.elem):''','''        cell = _find(cell)
        if kind == MIXED and cell.elem in (BOTTOM, FLOAT):
            # A number whose type is only known when it runs, put in a list with no
            # ints: the list is taken to hold floats, and storing an int there hands
            # the call back (_Gen._coerce).
            kind = FLOAT
        joined = self.join(cell.elem, kind)
        if not _same(joined, cell.elem):''')
rep('''        if target == MIXED and kind != MIXED:
            return list(self.as_mixed(kind, codes))''','''        if target == MIXED and kind != MIXED:
            return list(self.as_mixed(kind, codes))
        if target == FLOAT and kind == MIXED:
            # Only a list of floats takes an int-or-float (widen_cell).
            if codes[1] != "False":
                self.fail(codes[1])
            return [codes[0]]''')
open(p,'w',encoding='utf-8').write(s)
