p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''class ArrT(ListT):
    """An array.array('B'): a list of ints from 0 to 255."""

    def __init__(self, cell=None):
        super().__init__(cell)
        if cell is None:
            self.cell.elem = INT
''','''# array.array typecodes held in a region: the item type, the range an int item must
# be in (array raises OverflowError outside it), and the numpy type of its buffer.
def _array_codes():
    out = {"d": (FLOAT, None, None, "float64")}
    for code in "bBhHiIlLqQ":
        size = array.array(code).itemsize
        signed = code.islower()
        low, high = (-(1 << (8 * size - 1)), (1 << (8 * size - 1)) - 1) if signed else (0, (1 << (8 * size)) - 1)
        if high <= INT_MAX:
            out[code] = (INT, low, high, f"{'int' if signed else 'uint'}{8 * size}")
    return out


class ArrT(ListT):
    """An array.array of typecode ``code``: a list of floats ('d') or of ints within
    the typecode's range."""

    def __init__(self, cell=None, code="B"):
        super().__init__(cell)
        self.code = code
        if cell is None:
            self.cell.elem = ARRAY_CODES[code][0]

    def __eq__(self, other):
        return type(other) is ArrT and other.code == self.code and super().__eq__(other)

    __hash__ = None
''')
rep('''class ObjT:''','''ARRAY_CODES = _array_codes()


class ObjT:''')
rep('''    if isinstance(kind, ArrT):
        return "array('B')"''','''    if isinstance(kind, ArrT):
        return f"array('{kind.code}')"''')
rep('''        elif isinstance(a, ListT) and isinstance(b, ListT) and type(a) is type(b):
            self.unify(a.cell, b.cell)
            return a''','''        elif (isinstance(a, ListT) and isinstance(b, ListT) and type(a) is type(b)
              and getattr(a, "code", None) == getattr(b, "code", None)):
            self.unify(a.cell, b.cell)
            return a''')
rep('''        if isinstance(list_kind, ArrT):
            if kind not in (INT, BOOL):
                self.unsupported(f"storing {_describe(kind)} in an array('B')", node)
            item = self.temp(self.as_int(kind, codes))
            # array('B') raises OverflowError outside 0..255.
            self.fail(f"{item} < 0 or {item} > 255")
            cell.mutated = True
            self.store(INT, where, [item], nonnegative=nonnegative)
            return''','''        if isinstance(list_kind, ArrT):
            elem, low, high, _ = ARRAY_CODES[list_kind.code]
            cell.mutated = True
            if elem == FLOAT:
                # array('d') takes any real number and keeps it as a float.
                if kind not in (INT, BOOL, FLOAT, MIXED):
                    self.unsupported(f"storing {_describe(kind)} in an {_describe(list_kind)}", node)
                self.store(FLOAT, where, [self.as_float(kind, codes)], nonnegative=nonnegative)
                return
            if kind not in (INT, BOOL):
                self.unsupported(f"storing {_describe(kind)} in an {_describe(list_kind)}", node)
            item = self.temp(self.as_int(kind, codes))
            # An int array raises OverflowError outside its item's range.
            if (low, high) != (INT_MIN, INT_MAX):
                self.fail(f"{item} < {low} or {item} > {high}")
            self.store(INT, where, [item], nonnegative=nonnegative)
            return''')
rep('''        if type(value) is not array.array or value.typecode != "B":
            raise _Mismatch
        root = _find(kind.cell)''','''        if type(value) is not array.array or value.typecode != kind.code:
            raise _Mismatch
        root = _find(kind.cell)''')
rep('''            self.blocks.append((data, np.frombuffer(value, dtype=np.uint8).astype(np.int64)))''',
'''            raw = np.frombuffer(value, dtype=ARRAY_CODES[kind.code][3])
            self.blocks.append((data, raw.view(np.int64) if kind.code == "d" else raw.astype(np.int64)))''')
rep('''            made = self.made[handle] = array.array("B", self.items(kind, handle))''',
'''            made = self.made[handle] = array.array(kind.code, self.items(kind, handle))''')
rep('''                if value.tolist() != new:
                    value[:] = array.array("B", new)
                continue''','''                if len(value) != len(new) or array.array(kind.code, new).tobytes() != value.tobytes():
                    value[:] = array.array(kind.code, new)
                continue''')
rep('''        if value.typecode != "B":
            raise Unsupported(f"an array of typecode '{value.typecode}'")
        made = seen[id(value)] = ArrT()''','''        if value.typecode not in ARRAY_CODES:
            raise Unsupported(f"an array of typecode '{value.typecode}'")
        made = seen[id(value)] = ArrT(code=value.typecode)''')
open(p,'w',encoding='utf-8').write(s)
