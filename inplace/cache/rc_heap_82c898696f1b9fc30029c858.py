import math

import numpy as np
from numba import njit


@njit(cache=True, error_model="numpy")
def alloc(I, top, st, slots):
    start = top[0]
    if start + slots > len(I):
        st[0] = 2
        return 0
    top[0] = start + slots
    return start


@njit(cache=True, error_model="numpy")
def list_new(I, top, st, length, capacity):
    data = alloc(I, top, st, capacity)
    h = alloc(I, top, st, 3)
    if st[0]:
        return 0
    I[h] = length
    I[h + 1] = capacity
    I[h + 2] = data
    return h


@njit(cache=True, error_model="numpy")
def list_fill(I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        I[data + k] = value
    return h


@njit(cache=True, error_model="numpy")
def list_fill_f(F, I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        F[data + k] = value
    return h


@njit(cache=True, error_model="numpy")
def list_room(I, top, st, h):
    length = I[h]
    if length == I[h + 1]:
        bigger = 4 if length == 0 else length * 2
        data = alloc(I, top, st, bigger)
        if st[0]:
            return 0
        old = I[h + 2]
        for k in range(length):
            I[data + k] = I[old + k]
        I[h + 1] = bigger
        I[h + 2] = data
    I[h] = length + 1
    return I[h + 2] + length


@njit(cache=True, error_model="numpy")
def list_slice(I, top, st, h, low, high, has_low, has_high):
    size = I[h]
    if not has_low:
        low = 0
    elif low < 0:
        low = low + size if low + size > 0 else 0
    elif low > size:
        low = size
    if not has_high:
        high = size
    elif high < 0:
        high = high + size if high + size > 0 else 0
    elif high > size:
        high = size
    count = high - low if high > low else 0
    out = list_new(I, top, st, count, count)
    if st[0]:
        return 0
    source, target = I[h + 2] + low, I[out + 2]
    for k in range(count):
        I[target + k] = I[source + k]
    return out


@njit(cache=True, error_model="numpy")
def add_i(st, a, b):
    r = a + b
    if ((a ^ r) & (b ^ r)) < 0:
        st[0] = 1
    return r


@njit(cache=True, error_model="numpy")
def sub_i(st, a, b):
    r = a - b
    if ((a ^ b) & (a ^ r)) < 0:
        st[0] = 1
    return r


@njit(cache=True, error_model="numpy")
def mul_i(st, a, b):
    estimate = float(a) * float(b)
    if estimate >= 9.2e18 or estimate <= -9.2e18:
        st[0] = 1
        return 0
    return a * b


@njit(cache=True, error_model="numpy")
def floordiv_i(st, a, b):
    if b == 0 or (b == -1 and a == -a and a != 0):
        st[0] = 1
        return 0
    return a // b


@njit(cache=True, error_model="numpy")
def mod_i(st, a, b):
    if b == 0 or b == -1:
        if b == 0:
            st[0] = 1
        return 0
    return a % b



@njit(cache=True, error_model="numpy")
def str_new(I, top, st, n):
    h = alloc(I, top, st, n + 2)
    if st[0]:
        return 0
    I[h] = n
    I[h + 1] = 0
    return h


@njit(cache=True, error_model="numpy")
def str_hash(I, h):
    v = I[h + 1]
    if v != 0:
        return v
    v = np.int64(-3750763034362895579)
    for k in range(I[h]):
        v = (v ^ I[h + 2 + k]) * np.int64(1099511628211)
    if v == 0:
        v = np.int64(1)
    I[h + 1] = v
    return v


@njit(cache=True, error_model="numpy")
def str_eq(I, a, b):
    if a == b:
        return True
    if a < 0 or b < 0:
        return False
    n = I[a]
    if n != I[b]:
        return False
    if I[a + 1] != 0 and I[b + 1] != 0 and I[a + 1] != I[b + 1]:
        return False
    for k in range(n):
        if I[a + 2 + k] != I[b + 2 + k]:
            return False
    return True


@njit(cache=True, error_model="numpy")
def str_cmp(I, a, b):
    n, m = I[a], I[b]
    size = n if n < m else m
    for k in range(size):
        x, y = I[a + 2 + k], I[b + 2 + k]
        if x != y:
            return -1 if x < y else 1
    if n == m:
        return 0
    return -1 if n < m else 1


@njit(cache=True, error_model="numpy")
def str_concat(I, top, st, a, b):
    n, m = I[a], I[b]
    h = str_new(I, top, st, n + m)
    if st[0]:
        return 0
    for k in range(n):
        I[h + 2 + k] = I[a + 2 + k]
    for k in range(m):
        I[h + 2 + n + k] = I[b + 2 + k]
    return h


@njit(cache=True, error_model="numpy")
def str_slice(I, top, st, h, low, high, has_low, has_high):
    size = I[h]
    if not has_low:
        low = 0
    elif low < 0:
        low = low + size if low + size > 0 else 0
    elif low > size:
        low = size
    if not has_high:
        high = size
    elif high < 0:
        high = high + size if high + size > 0 else 0
    elif high > size:
        high = size
    count = high - low if high > low else 0
    out = str_new(I, top, st, count)
    if st[0]:
        return 0
    for k in range(count):
        I[out + 2 + k] = I[h + 2 + low + k]
    return out


@njit(cache=True, error_model="numpy")
def str_char(I, top, st, cp):
    out = str_new(I, top, st, 1)
    if st[0]:
        return 0
    I[out + 2] = cp
    return out


@njit(cache=True, error_model="numpy")
def str_find(I, h, sub, start):
    n, m = I[h], I[sub]
    for k in range(start, n - m + 1):
        same = True
        for j in range(m):
            if I[h + 2 + k + j] != I[sub + 2 + j]:
                same = False
                break
        if same:
            return k
    return -1


@njit(cache=True, error_model="numpy")
def str_starts(I, h, part, at):
    m = I[part]
    if at < 0 or at + m > I[h]:
        return False
    for j in range(m):
        if I[h + 2 + at + j] != I[part + 2 + j]:
            return False
    return True


@njit(cache=True, error_model="numpy")
def str_from_int(I, top, st, v):
    # Digits of the value made negative, so the smallest int needs no special case.
    m = v if v < 0 else -v
    count = 1
    t = m // -10
    while t != 0:
        count += 1
        t = t // 10
    size = count + (1 if v < 0 else 0)
    out = str_new(I, top, st, size)
    if st[0]:
        return 0
    if v < 0:
        I[out + 2] = 45
    for k in range(count):
        q = m // -10
        I[out + 1 + size - k] = 48 - (m + q * 10)
        m = -q
    return out


@njit(cache=True, error_model="numpy")
def str_join(I, top, st, sep, items):
    count = I[items]
    data = I[items + 2]
    size = 0
    for k in range(count):
        size += I[I[data + k]]
    if count > 1:
        size += I[sep] * (count - 1)
    out = str_new(I, top, st, size)
    if st[0]:
        return 0
    at = out + 2
    for k in range(count):
        if k:
            for j in range(I[sep]):
                I[at + j] = I[sep + 2 + j]
            at += I[sep]
        part = I[data + k]
        for j in range(I[part]):
            I[at + j] = I[part + 2 + j]
        at += I[part]
    return out


@njit(cache=True, error_model="numpy")
def str_space(cp):
    # Whitespace as str.isspace() has it, for code points below 128; -1 above.
    if cp >= 128:
        return -1
    return 1 if cp == 32 or 9 <= cp <= 13 or 28 <= cp <= 31 else 0


@njit(cache=True, error_model="numpy")
def str_strip(I, top, st, h, left, right):
    low, high = 0, I[h]
    while left and low < high:
        space = str_space(I[h + 2 + low])
        if space < 0:
            st[0] = 1
            return 0
        if space == 0:
            break
        low += 1
    while right and high > low:
        space = str_space(I[h + 1 + high])
        if space < 0:
            st[0] = 1
            return 0
        if space == 0:
            break
        high -= 1
    return str_slice(I, top, st, h, low, high, True, True)


@njit(cache=True, error_model="numpy")
def str_case(I, top, st, h, upper):
    n = I[h]
    out = str_new(I, top, st, n)
    if st[0]:
        return 0
    for k in range(n):
        cp = I[h + 2 + k]
        if cp >= 128:
            st[0] = 1
            return 0
        if upper and 97 <= cp <= 122:
            cp -= 32
        elif not upper and 65 <= cp <= 90:
            cp += 32
        I[out + 2 + k] = cp
    return out


@njit(cache=True, error_model="numpy")
def str_split(I, top, st, h, sep):
    # sep < 0: runs of whitespace, as str.split() with no argument.
    out = list_new(I, top, st, 0, 0)
    if st[0]:
        return 0
    n = I[h]
    if sep < 0:
        k = 0
        while True:
            while k < n:
                space = str_space(I[h + 2 + k])
                if space < 0:
                    st[0] = 1
                    return 0
                if space == 0:
                    break
                k += 1
            if k >= n:
                return out
            start = k
            while k < n:
                space = str_space(I[h + 2 + k])
                if space < 0:
                    st[0] = 1
                    return 0
                if space == 1:
                    break
                k += 1
            part = str_slice(I, top, st, h, start, k, True, True)
            at = list_room(I, top, st, out)
            if st[0]:
                return 0
            I[at] = part
    m = I[sep]
    if m == 0:
        st[0] = 1
        return 0
    start = 0
    while True:
        found = str_find(I, h, sep, start)
        end = found if found >= 0 else n
        part = str_slice(I, top, st, h, start, end, True, True)
        at = list_room(I, top, st, out)
        if st[0]:
            return 0
        I[at] = part
        if found < 0:
            return out
        start = found + m


@njit(cache=True, error_model="numpy")
def str_count(I, h, sub):
    n, m = I[h], I[sub]
    if m == 0:
        return n + 1
    count, k = 0, 0
    while True:
        found = str_find(I, h, sub, k)
        if found < 0:
            return count
        count += 1
        k = found + m


@njit(cache=True, error_model="numpy")
def str_replace(I, top, st, h, old, new):
    n, m, r = I[h], I[old], I[new]
    if m == 0:
        st[0] = 1
        return 0
    count = str_count(I, h, old)
    out = str_new(I, top, st, n + count * (r - m))
    if st[0]:
        return 0
    k, at = 0, out + 2
    while True:
        found = str_find(I, h, old, k)
        end = found if found >= 0 else n
        for j in range(k, end):
            I[at] = I[h + 2 + j]
            at += 1
        if found < 0:
            return out
        for j in range(r):
            I[at] = I[new + 2 + j]
            at += 1
        k = found + m


@njit(cache=True, error_model="numpy")
def str_repeat(I, top, st, h, count):
    n = I[h]
    if count < 0:
        count = 0
    if n * count > 1 << 40:
        st[0] = 1
        return 0
    out = str_new(I, top, st, n * count)
    if st[0]:
        return 0
    for c in range(count):
        for k in range(n):
            I[out + 2 + c * n + k] = I[h + 2 + k]
    return out


@njit(cache=True, error_model="numpy")
def mix_i(x):
    x = (x ^ (x >> 31)) * np.int64(-7046029254386353131)
    return x ^ (x >> 29)


@njit(cache=True, error_model="numpy")
def mix_t(acc, x):
    return (acc ^ x) * np.int64(1000003) + np.int64(97531)


@njit(cache=True, error_model="numpy")
def dict_new(I, top, st, stride, made):
    h = alloc(I, top, st, 9)
    if st[0]:
        return 0
    I[h] = 0
    I[h + 1] = 0
    I[h + 2] = 0
    I[h + 3] = 0
    I[h + 4] = 0
    I[h + 5] = 0
    I[h + 6] = stride
    I[h + 7] = -1
    I[h + 8] = made
    return h


@njit(cache=True, error_model="numpy")
def set_log(I, top, st, h, op, key):
    log = I[h + 7]
    if log < 0:
        log = list_new(I, top, st, 0, 0)
        if st[0]:
            return
        I[h + 7] = log
    at = list_room(I, top, st, log)
    if st[0]:
        return
    I[at] = op
    at = list_room(I, top, st, log)
    if st[0]:
        return
    I[at] = key


@njit(cache=True, error_model="numpy")
def set_pristine(I, h):
    return I[h + 8] == 0 and (I[h + 7] < 0 or I[I[h + 7]] == 0)


@njit(cache=True, error_model="numpy")
def dict_copy(I, top, st, h, made):
    out = alloc(I, top, st, 9)
    if st[0]:
        return 0
    stride = I[h + 6]
    alive = I[h]
    cap = alive if alive > 0 else 1
    entries = alloc(I, top, st, cap * stride)
    if st[0]:
        return 0
    old, m = I[h + 3], 0
    for e in range(I[h + 1]):
        at = old + e * stride
        if I[at + 2] == 0:
            continue
        for k in range(stride):
            I[entries + m * stride + k] = I[at + k]
        m += 1
    I[out] = alive
    I[out + 1] = alive
    I[out + 2] = cap
    I[out + 3] = entries
    I[out + 4] = 0
    I[out + 5] = 0
    I[out + 6] = stride
    I[out + 7] = -1
    I[out + 8] = made
    return out


@njit(cache=True, error_model="numpy")
def dict_clear(I, h):
    I[h] = 0
    I[h + 1] = 0
    I[h + 4] = 0
@njit(cache=True, error_model="numpy")
def f0_draw(F, I, top, st, v_board, v_base):
    v_total_0 = 0.0
    v_total_1 = True
    t1 = v_base
    _sr_call_t2_0_I0, _sr_call_t2_0_I1 = sr2_f2___add__(F, I, top, st, t1, I[0])
    if st[0]:
        return (0.0, False, 0, 0, 0, 0.0, 0)
    _sr_t3_I0 = np.int64(0)
    _sr_t3_I1 = np.int64(0)
    if st[0]:
        return (0.0, False, 0, 0, 0, 0.0, 0)
    _sr_t3_I0, _sr_t3_I1 = sr0_f4___init__(F, I, top, st, _sr_t3_I0, _sr_t3_I1, 1, 1)
    if st[0]:
        return (0.0, False, 0, 0, 0, 0.0, 0)
    pass
    _sr_call_t5_0_I0, _sr_call_t5_0_I1 = sr5_f17___sub__(F, I, top, st, _sr_call_t2_0_I0, _sr_call_t2_0_I1, _sr_t3_I0, _sr_t3_I1)
    if st[0]:
        return (0.0, False, 0, 0, 0, 0.0, 0)
    pass
    t6 = I[np.uint64(v_board + 4)]
    t7 = t6
    for t8 in range(t7):
        v_at = t8
        t9_0, t9_1, t9_2, t9_3, t9_4, t9_5 = f6_guarded(F, I, top, st, v_board)
        if st[0]:
            return (0.0, False, 0, 0, 0, 0.0, 0)
        v_colour_0 = t9_0
        v_colour_1 = t9_1
        v_colour_2 = t9_2
        v_colour_3 = t9_3
        v_colour_4 = t9_4
        v_colour_5 = t9_5
        t10 = v_board
        f21_paint(F, I, top, st, t10, v_at, v_colour_0, v_colour_1, v_colour_2, v_colour_3, v_colour_4, v_colour_5)
        if st[0]:
            return (0.0, False, 0, 0, 0, 0.0, 0)
        v_amount_0 = 0.0
        v_amount_1 = True
        t11 = I[np.uint64(v_board + 3)]
        t12 = t11
        t13 = 0
        while True:
            if t13 >= I[np.uint64(t12)]:
                break
            t14 = I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 0]
            t15 = F[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 1]
            t16 = I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 1 + 1] != 0
            t13 += 1
            v_spot = t14
            v_t_0 = t15
            v_t_1 = t16
            if not not v_t_1:
                if not v_t_1:
                    st[0] = 1
                    top[3] = 10
                    return (0.0, False, 0, 0, 0, 0.0, 0)
                v_amount_0 = v_amount_0 + v_t_0
                v_amount_1 = False
        t17 = 1.0
        t18 = True
        t19 = v_amount_0
        t20 = v_amount_1
        t21 = t19 < t17
        t22 = t19 if t21 else t17
        t23 = t20 if t21 else t18
        t24 = v_total_0 + t22
        t25 = v_total_1 and t23
        if t25:
            if t24 >= 9007199254740992.0 or t24 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 11
                return (0.0, False, 0, 0, 0, 0.0, 0)
            t24 += 0.0
        t26 = v_at
        if t26 > 9007199254740992 or t26 < -9007199254740992:
            st[0] = 1
            top[3] = 11
            return (0.0, False, 0, 0, 0, 0.0, 0)
        t27 = float(t26)
        t28 = True
        t29 = 0.25
        t30 = False
        t31 = t29 > t27
        t32 = t29 if t31 else t27
        t33 = t30 if t31 else t28
        t34 = t24 + t32
        t35 = t25 and t33
        if t35:
            if t34 >= 9007199254740992.0 or t34 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 11
                return (0.0, False, 0, 0, 0, 0.0, 0)
            t34 += 0.0
        v_total_0 = t34
        v_total_1 = t35
    t36 = _sr_call_t5_0_I0
    t37 = _sr_call_t5_0_I1
    t38 = I[I[np.uint64(v_board + 1)] + 0]
    t39 = F[I[np.uint64(v_board + 1)] + 1]
    t40 = I[I[np.uint64(v_board + 1)] + 2]
    t41 = v_total_0
    t42 = v_total_1
    t43 = t36
    t44 = t37
    t45 = t38
    t46 = t39
    t47 = t40
    return (t41, t42, t43, t44, t45, t46, t47)
    return (0.0, False, 0, 0, 0, 0.0, 0)


@njit(cache=True, error_model="numpy")
def f2___add__(F, I, top, st, v_self, v_other):
    t1 = v_other
    f8_isSpot(F, I, top, st, t1)
    if st[0]:
        return -1
    t2 = I[np.uint64(v_self + 0)]
    t3 = I[np.uint64(v_other + 0)]
    t4 = add_i(st, t2, t3)
    if st[0]:
        return -1
    t5 = I[np.uint64(v_self + 1)]
    t6 = I[np.uint64(v_other + 1)]
    t7 = add_i(st, t5, t6)
    if st[0]:
        return -1
    t8 = alloc(I, top, st, 2)
    if st[0]:
        return -1
    f10___init__(F, I, top, st, t8, t4, t7)
    if st[0]:
        return -1
    return t8
    return -1


@njit(cache=True, error_model="numpy")
def f4___init__(F, I, top, st, v_self, v_x, v_y):
    I[np.uint64(v_self + 0)] = v_x
    I[np.uint64(v_self + 1)] = v_y
    return


@njit(cache=True, error_model="numpy")
def f17___sub__(F, I, top, st, v_self, v_other):
    t1 = I[np.uint64(v_self + 0)]
    t2 = I[np.uint64(v_other + 0)]
    t3 = sub_i(st, t1, t2)
    if st[0]:
        return -1
    t4 = I[np.uint64(v_self + 1)]
    t5 = I[np.uint64(v_other + 1)]
    t6 = sub_i(st, t4, t5)
    if st[0]:
        return -1
    t7 = alloc(I, top, st, 2)
    if st[0]:
        return -1
    f10___init__(F, I, top, st, t7, t3, t6)
    if st[0]:
        return -1
    return t7
    return -1


@njit(cache=True, error_model="numpy")
def f6_guarded(F, I, top, st, v_board):
    t1 = I[np.uint64(v_board + 2)]
    if t1 > 2:
        t2 = 0
        t3 = 0
        t4 = 0
        t5 = t2
        t6 = t4
        return (float(t5), True, t3, float(t6), True, True)
    t7 = I[np.uint64(v_board + 2)]
    t8 = add_i(st, t7, 1)
    if st[0]:
        return (0.0, False, 0, 0.0, False, False)
    I[np.uint64(v_board + 2)] = t8
    t9 = list_new(I, top, st, 0, 0)
    if st[0]:
        return (0.0, False, 0, 0.0, False, False)
    v__c0_list = t9
    t10 = I[np.uint64(v_board + 3)]
    t11_0 = f13_enumerate_items(F, I, top, st, t10)
    if st[0]:
        return (0.0, False, 0, 0.0, False, False)
    t12 = t11_0
    t13 = 0
    while True:
        if t13 >= I[np.uint64(t12)]:
            break
        t14 = I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 0]
        t15 = I[I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 1] + 0]
        t16 = F[I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 1] + 1]
        t17 = I[I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 1] + 1 + 1] != 0
        t13 += 1
        v__c0_i = t14
        v__c0_spot = t15
        v__c0_t_0 = t16
        v__c0_t_1 = t17
        t18 = not v__c0_t_1
        if not t18:
            if not v__c0_t_1:
                st[0] = 1
                top[3] = 4000006
                return (0.0, False, 0, 0.0, False, False)
            t18 = v__c0_t_0 > 0.0
        if t18:
            t19_0, t19_1 = f20_hit(F, I, top, st, v__c0_i)
            if st[0]:
                return (0.0, False, 0, 0.0, False, False)
            t20 = v__c0_spot
            t21 = t19_0
            t22 = t19_1
            t23 = list_room(I, top, st, v__c0_list)
            if st[0]:
                return (0.0, False, 0, 0.0, False, False)
            t24 = alloc(I, top, st, 3)
            if st[0]:
                return (0.0, False, 0, 0.0, False, False)
            I[t24 + 0] = t20
            F[t24 + 1] = t21
            I[t24 + 1 + 1] = t22
            I[t23] = t24
    t25_0, t25_1, t25_2, t25_3 = f15_nearest(F, I, top, st, v__c0_list)
    if st[0]:
        return (0.0, False, 0, 0.0, False, False)
    v_found_0 = t25_0
    v_found_1 = t25_1
    v_found_2 = t25_2
    v_found_3 = t25_3
    if not v_found_3:
        t26 = 0
        t27 = 0
        t28 = 0
        t29 = t26
        t30 = t28
        t31 = float(t29)
        t32 = True
        t33 = t27
        t34 = float(t30)
        t35 = True
        t36 = True
        t37 = I[np.uint64(v_board + 2)]
        t38 = sub_i(st, t37, 1)
        if st[0]:
            return (0.0, False, 0, 0.0, False, False)
        I[np.uint64(v_board + 2)] = t38
        return (t31, t32, t33, t34, t35, t36)
    else:
        if not v_found_3:
            st[0] = 1
            top[3] = 4000010
            return (0.0, False, 0, 0.0, False, False)
        v_spot = v_found_0
        v_t_0 = v_found_1
        v_t_1 = v_found_2
        t39 = I[np.uint64(v_spot + 0)]
        if not v_t_1:
            st[0] = 1
            top[3] = 4000011
            return (0.0, False, 0, 0.0, False, False)
        t40 = float(t39) * v_t_0
        t41 = 1
        t42 = v_t_0
        t43 = v_t_1
        t44 = t40
        t45 = False
        t46 = t41
        t47 = t42
        t48 = False
        t49 = t43
        t50 = I[np.uint64(v_board + 2)]
        t51 = sub_i(st, t50, 1)
        if st[0]:
            return (0.0, False, 0, 0.0, False, False)
        I[np.uint64(v_board + 2)] = t51
        return (t44, t45, t46, t47, t48, t49)
    return (0.0, False, 0, 0.0, False, False)


@njit(cache=True, error_model="numpy")
def f21_paint(F, I, top, st, v_self, v_at, v_r_0, v_r_1, v_g, v_b_0, v_b_1, v_b_2):
    if not (v_b_1 or v_r_1):
        _kf_f21_paint(F, I, top, st, v_self, v_at, v_r_0, v_r_1, v_g, v_b_0, v_b_1, v_b_2)
        return
    else:
        t1 = v_r_0 * 255.0
        t2 = v_r_1 and True
        if t2:
            if t1 >= 9007199254740992.0 or t1 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 5000002
                return
            t1 += 0.0
        t3 = t1
        if not -9.223372036854776e+18 < t3 < 9.223372036854776e+18:
            st[0] = 1
            top[3] = 5000002
            return
        t4 = np.int64(t3)
        t5 = add_i(st, t4, v_g)
        if st[0]:
            return
        if not v_b_2:
            st[0] = 1
            top[3] = 5000002
            return
        t6 = v_b_0
        if not -9.223372036854776e+18 < t6 < 9.223372036854776e+18:
            st[0] = 1
            top[3] = 5000002
            return
        t7 = np.int64(t6)
        t8 = add_i(st, t5, t7)
        if st[0]:
            return
        t9 = 255
        t10 = t8
        t11 = t10 if t10 < t9 else t9
        t12 = 0
        t13 = t11
        t14 = t13 if t13 > t12 else t12
        t15 = I[np.uint64(v_self + 0)]
        t16 = I[np.uint64(t15)]
        t17 = v_at
        if t17 < 0:
            t17 += t16
        if t17 < 0 or t17 >= t16:
            st[0] = 1
            top[3] = 5000002
            return
        t18 = I[np.uint64(t15 + 2)] + t17
        t19 = t14
        if t19 < 0 or t19 > 255:
            st[0] = 1
            top[3] = 5000002
            return
        I[np.uint64(t18)] = t19
        return


@njit(cache=True, error_model="numpy")
def f8_isSpot(F, I, top, st, v_self):
    return False
    return False


@njit(cache=True, error_model="numpy")
def f10___init__(F, I, top, st, v_self, v_x, v_y):
    I[np.uint64(v_self + 0)] = v_x
    I[np.uint64(v_self + 1)] = v_y
    return


@njit(cache=True, error_model="numpy")
def f13_enumerate_items(F, I, top, st, v_items):
    t1 = list_new(I, top, st, 0, 0)
    if st[0]:
        return -1
    v_out = t1
    v_i = 0
    t2 = v_items
    t3 = 0
    while True:
        if t3 >= I[np.uint64(t2)]:
            break
        t4 = I[I[np.uint64(I[np.uint64(t2 + 2)] + t3)] + 0]
        t5 = F[I[np.uint64(I[np.uint64(t2 + 2)] + t3)] + 1]
        t6 = I[I[np.uint64(I[np.uint64(t2 + 2)] + t3)] + 1 + 1] != 0
        t3 += 1
        v_item_0 = t4
        v_item_1 = t5
        v_item_2 = t6
        t7 = v_i
        t8 = v_item_0
        t9 = v_item_1
        t10 = v_item_2
        t11 = list_room(I, top, st, v_out)
        if st[0]:
            return -1
        t12 = alloc(I, top, st, 2)
        if st[0]:
            return -1
        I[t12 + 0] = t7
        t13 = alloc(I, top, st, 3)
        if st[0]:
            return -1
        I[t13 + 0] = t8
        F[t13 + 1] = t9
        I[t13 + 1 + 1] = t10
        I[t12 + 1] = t13
        I[t11] = t12
        t14 = add_i(st, v_i, 1)
        if st[0]:
            return -1
        v_i = t14
    return v_out
    return -1


@njit(cache=True, error_model="numpy")
def f20_hit(F, I, top, st, v_t):
    if v_t > 2:
        return (0.0, False)
    return (float(v_t) * 0.5, True)
    return (0.0, False)


@njit(cache=True, error_model="numpy")
def f15_nearest(F, I, top, st, v_pairs):
    v_best_0 = -1
    v_best_1 = 0.0
    v_best_2 = False
    v_best_3 = False
    t1 = v_pairs
    t2 = 0
    while True:
        if t2 >= I[np.uint64(t1)]:
            break
        t3 = I[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 0]
        t4 = F[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 1]
        t5 = I[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 1 + 1] != 0
        t2 += 1
        v_pair_0 = t3
        v_pair_1 = t4
        v_pair_2 = t5
        v_t_0 = v_pair_1
        v_t_1 = v_pair_2
        t6 = not not v_t_1
        if t6:
            t7 = not v_best_3
            if not t7:
                if not v_best_3:
                    st[0] = 1
                    top[3] = 10000005
                    return (-1, 0.0, False, False)
                if not v_t_1:
                    st[0] = 1
                    top[3] = 10000005
                    return (-1, 0.0, False, False)
                if not v_best_2:
                    st[0] = 1
                    top[3] = 10000005
                    return (-1, 0.0, False, False)
                t7 = v_t_0 < v_best_1
            t6 = t7
        if t6:
            v_best_0 = v_pair_0
            v_best_1 = v_pair_1
            v_best_2 = v_pair_2
            v_best_3 = True
    return (v_best_0, v_best_1, v_best_2, v_best_3)
    return (-1, 0.0, False, False)


@njit(cache=True, error_model="numpy")
def sr0_f4___init__(F, I, top, st, v_sr0_I0, v_sr0_I1, v_x, v_y):
    v_sr0_I0 = v_x
    v_sr0_I1 = v_y
    return (v_sr0_I0, v_sr0_I1)


@njit(cache=True, error_model="numpy")
def sr2_f2___add__(F, I, top, st, v_self, v_other):
    t1 = v_other
    f8_isSpot(F, I, top, st, t1)
    if st[0]:
        return (np.int64(0), np.int64(0))
    t2 = I[np.uint64(v_self + 0)]
    t3 = I[np.uint64(v_other + 0)]
    t4 = add_i(st, t2, t3)
    if st[0]:
        return (np.int64(0), np.int64(0))
    t5 = I[np.uint64(v_self + 1)]
    t6 = I[np.uint64(v_other + 1)]
    t7 = add_i(st, t5, t6)
    if st[0]:
        return (np.int64(0), np.int64(0))
    _sr_t8_I0 = np.int64(0)
    _sr_t8_I1 = np.int64(0)
    if st[0]:
        return (np.int64(0), np.int64(0))
    _sr_t8_I0, _sr_t8_I1 = sr3_f10___init__(F, I, top, st, _sr_t8_I0, _sr_t8_I1, t4, t7)
    if st[0]:
        return (np.int64(0), np.int64(0))
    return (_sr_t8_I0, _sr_t8_I1)
    return (np.int64(0), np.int64(0))


@njit(cache=True, error_model="numpy")
def sr3_f10___init__(F, I, top, st, v_sr0_I0, v_sr0_I1, v_x, v_y):
    v_sr0_I0 = v_x
    v_sr0_I1 = v_y
    return (v_sr0_I0, v_sr0_I1)


@njit(cache=True, error_model="numpy")
def sr5_f17___sub__(F, I, top, st, v_sr0_I0, v_sr0_I1, v_sr1_I0, v_sr1_I1):
    t1 = v_sr0_I0
    t2 = v_sr1_I0
    t3 = sub_i(st, t1, t2)
    if st[0]:
        return (np.int64(0), np.int64(0))
    t4 = v_sr0_I1
    t5 = v_sr1_I1
    t6 = sub_i(st, t4, t5)
    if st[0]:
        return (np.int64(0), np.int64(0))
    _sr_t7_I0 = np.int64(0)
    _sr_t7_I1 = np.int64(0)
    if st[0]:
        return (np.int64(0), np.int64(0))
    _sr_t7_I0, _sr_t7_I1 = sr3_f10___init__(F, I, top, st, _sr_t7_I0, _sr_t7_I1, t3, t6)
    if st[0]:
        return (np.int64(0), np.int64(0))
    return (_sr_t7_I0, _sr_t7_I1)
    return (np.int64(0), np.int64(0))


@njit(cache=True, error_model="numpy")
def _kf_f21_paint(F, I, top, st, v_self, v_at, v_r_0, v_r_1, v_g, v_b_0, v_b_1, v_b_2):
    t1 = v_r_0 * 255.0
    t2 = False
    t3 = t1
    if not -9.223372036854776e+18 < t3 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 5000002
        return
    t4 = np.int64(t3)
    t5 = add_i(st, t4, v_g)
    if st[0]:
        return
    if not v_b_2:
        st[0] = 1
        top[3] = 5000002
        return
    t6 = v_b_0
    if not -9.223372036854776e+18 < t6 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 5000002
        return
    t7 = np.int64(t6)
    t8 = add_i(st, t5, t7)
    if st[0]:
        return
    t9 = 255
    t10 = t8
    t11 = t10 if t10 < t9 else t9
    t12 = 0
    t13 = t11
    t14 = t13 if t13 > t12 else t12
    t15 = I[np.uint64(v_self + 0)]
    t16 = I[np.uint64(t15)]
    t17 = v_at
    if t17 < 0:
        t17 += t16
    if t17 < 0 or t17 >= t16:
        st[0] = 1
        top[3] = 5000002
        return
    t18 = I[np.uint64(t15 + 2)] + t17
    t19 = t14
    if t19 < 0 or t19 > 255:
        st[0] = 1
        top[3] = 5000002
        return
    I[np.uint64(t18)] = t19
    return

