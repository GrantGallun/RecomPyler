p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''    return a % b


\'\'\'

# Strings, dicts and sets''','''    return a % b


@njit(error_model="numpy")
def mod_f(st, a, b):
    # Python's float %: the remainder takes the divisor's sign.
    if b == 0.0:
        st[0] = 1
        return 0.0
    m = math.fmod(a, b)
    if m != 0.0:
        if (b < 0.0) != (m < 0.0):
            m += b
    else:
        m = math.copysign(0.0, b)
    return m


@njit(error_model="numpy")
def floordiv_f(st, a, b):
    # Python's float //, as float_divmod works it out.
    if b == 0.0:
        st[0] = 1
        return 0.0
    m = math.fmod(a, b)
    div = (a - m) / b
    if m != 0.0 and (b < 0.0) != (m < 0.0):
        div -= 1.0
    if div != 0.0:
        whole = math.floor(div)
        if div - whole > 0.5:
            whole += 1.0
        return whole
    return math.copysign(0.0, a / b)


@njit(error_model="numpy", inline="always")
def lshift_i(st, a, b):
    # A negative count is Python's ValueError; a result past 64 bits goes back too.
    if b < 0 or (b >= 63 and a != 0):
        st[0] = 1
        return 0
    if b >= 63:
        return 0
    r = a << b
    if (r >> b) != a:
        st[0] = 1
        return 0
    return r


@njit(error_model="numpy", inline="always")
def rshift_i(st, a, b):
    if b < 0:
        st[0] = 1
        return 0
    return a >> (b if b < 63 else 63)


\'\'\'

# Strings, dicts and sets''')
rep('''        if op in (ast.FloorDiv, ast.Mod) and whole:
            helper = "floordiv_i" if op is ast.FloorDiv else "mod_i"
            value = self.temp(f"{helper}(st, {self.as_int(lk, lc)}, {self.as_int(rk, rc)})")
            self.check()
            return INT, [value]''','''        if op in (ast.FloorDiv, ast.Mod) and whole:
            helper = "floordiv_i" if op is ast.FloorDiv else "mod_i"
            value = self.temp(f"{helper}(st, {self.as_int(lk, lc)}, {self.as_int(rk, rc)})")
            self.check()
            return INT, [value]
        if op in (ast.FloorDiv, ast.Mod) and FLOAT in (lk, rk):
            # With a float on either side the other is converted and the result is a float.
            helper = "floordiv_f" if op is ast.FloorDiv else "mod_f"
            value = self.temp(f"{helper}(st, {self.as_float(lk, lc)}, {self.as_float(rk, rc)})")
            self.check()
            return FLOAT, [value]
        if op in (ast.LShift, ast.RShift) and whole:
            helper = "lshift_i" if op is ast.LShift else "rshift_i"
            value = self.temp(f"{helper}(st, np.int64({self.as_int(lk, lc)}), np.int64({self.as_int(rk, rc)}))")
            self.check()
            return INT, [value]''')
open(p,'w',encoding='utf-8').write(s)
