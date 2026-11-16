p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''@njit(error_model="numpy")
def list_assign(I, top, st, h, source):''','''@njit(error_model="numpy")
def list_repeat(I, top, st, h, count):
    # ``xs * count``: a new list (or array) of xs's items, count times over.
    size = I[h]
    if count < 0:
        count = 0
    if size and count > len(I) // size:
        st[0] = 2
        return 0
    out = list_new(I, top, st, size * count, size * count)
    if st[0]:
        return 0
    source, target = I[h + 2], I[out + 2]
    for k in range(size * count):
        I[target + k] = I[source + k % size]
    return out


@njit(error_model="numpy")
def array_from(F, I, top, st, h, to_float, checked, low, high):
    # array(code, xs): xs's numbers as the array's items. An int outside an int
    # array's range is Python's OverflowError.
    size = I[h]
    out = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    source, target = I[h + 2], I[out + 2]
    for k in range(size):
        if to_float:
            F[target + k] = float(I[source + k])
        else:
            if checked and (I[source + k] < low or I[source + k] > high):
                st[0] = 1
                return 0
            I[target + k] = I[source + k]
    return out


@njit(error_model="numpy")
def list_assign(I, top, st, h, source):''')
rep('''        left = self.expr(node.left)
        if op is ast.Pow:''','''        left = self.expr(node.left)
        if op is ast.Mult and (isinstance(left[0], ListT) or self.peek_list(node.right)):
            right = self.expr(node.right)
            for (lk, lc), (ck, cc) in ((left, right), (right, left)):
                if isinstance(lk, ListT) and ck in (INT, BOOL):
                    # A new list (or array) of the same items: it shares their type.
                    self.check_item(lk.elem, node)
                    made = self.temp(f"list_repeat(I, top, st, {lc[0]}, {self.as_int(ck, cc)})")
                    self.check()
                    return lk, [made]
            if BOTTOM in (left[0], right[0]):
                return BOTTOM, ["0"]
            self.unsupported(f"operator Mult on {_describe(left[0])} and {_describe(right[0])}", node)
        if op is ast.Pow:''')
rep('''    def repeated(self, item, count, node, item_first):''','''    def peek_list(self, node):
        kind = self.peek_or_none(node)
        return isinstance(kind, ListT)

    def array_new(self, node):
        """``array(code)`` or ``array(code, numbers)``: a new array in the heap."""
        if node.keywords or not 1 <= len(node.args) <= 2 or not (
                isinstance(node.args[0], ast.Constant) and type(node.args[0].value) is str):
            self.unsupported("this call of array()", node)
        code = node.args[0].value
        if code not in ARRAY_CODES:
            self.unsupported(f"an array of typecode '{code}'", node)
        elem, low, high, _ = ARRAY_CODES[code]
        made = ArrT(code=code)
        if len(node.args) == 1:
            value = self.temp("list_new(I, top, st, 0, 0)")
            self.check()
            return made, [value]
        kind, codes = self.expr(node.args[1])
        if kind == BOTTOM:
            raise _Pending
        if not isinstance(kind, ListT) or (isinstance(kind, ArrT) and kind.code != code):
            self.unsupported(f"array('{code}') from {_describe(kind)}", node)
        source = kind.elem
        if source == BOTTOM and not isinstance(kind, ArrT):
            # A list no pass has put anything in.
            source = elem
        if source not in (INT, BOOL, FLOAT) or (source == FLOAT and elem != FLOAT):
            self.unsupported(f"array('{code}') from {_describe(kind)}", node)
        to_float = elem == FLOAT and source != FLOAT
        checked = elem == INT and not isinstance(kind, ArrT) and (low, high) != (INT_MIN, INT_MAX)
        value = self.temp(f"array_from(F, I, top, st, {codes[0]}, {to_float}, {checked}, {low or 0}, {high or 0})")
        self.check()
        return made, [value]

    def repeated(self, item, count, node, item_first):''')
rep('''            member = self.module_member(func)
            if member is not None:
                return self.call_value(member[1], f"{member[0].__name__}.{func.attr}", node)''','''            member = self.module_member(func)
            if member is not None:
                if member[1] is array.array:
                    return self.array_new(node)
                return self.call_value(member[1], f"{member[0].__name__}.{func.attr}", node)''')
rep('''            if isinstance(target, type):
                self.program.guard("item", self.namespace, name, target)
                return self.construct(target, node)
            if isinstance(target, FunctionType):
                self.program.guard("item", self.namespace, name, target)
                callee = self.program.function(_unwrap(target))''','''            if target is array.array:
                self.program.guard("item", self.namespace, name, target)
                return self.array_new(node)
            if isinstance(target, type):
                self.program.guard("item", self.namespace, name, target)
                return self.construct(target, node)
            if isinstance(target, FunctionType):
                self.program.guard("item", self.namespace, name, target)
                callee = self.program.function(_unwrap(target))''')
open(p,'w',encoding='utf-8').write(s)
