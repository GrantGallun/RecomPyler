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
def f0___call__(F, I, top, st, v_self, v_u):
    t1 = v_self
    t2_0, t2_1 = f2_GetDomain(F, I, top, st, t1)
    if st[0]:
        return -1
    v_dom_0 = t2_0
    v_dom_1 = t2_1
    t3 = v_u < v_dom_0
    if not t3:
        t3 = v_u > v_dom_1
    if t3:
        st[0] = 1
        top[3] = 5
        return -1
    if v_u == v_dom_0:
        t4 = I[np.uint64(v_self + 2)]
        t5 = I[np.uint64(t4)]
        t6 = 0
        if t6 < 0:
            t6 += t5
        if t6 < 0 or t6 >= t5:
            st[0] = 1
            top[3] = 7
            return -1
        t7 = I[np.uint64(t4 + 2)] + t6
        t8 = I[np.uint64(t7)]
        return t8
    if v_u == v_dom_1:
        t9 = I[np.uint64(v_self + 2)]
        t10 = I[np.uint64(t9)]
        t11 = -1
        if t11 < 0:
            t11 += t10
        if t11 < 0 or t11 >= t10:
            st[0] = 1
            top[3] = 9
            return -1
        t12 = I[np.uint64(t9 + 2)] + t11
        t13 = I[np.uint64(t12)]
        return t13
    t14 = v_self
    t15_0 = f4_GetIndex(F, I, top, st, t14, v_u)
    if st[0]:
        return -1
    v_I = t15_0
    t16 = list_new(I, top, st, 0, 0)
    if st[0]:
        return -1
    v__c0_list = t16
    t17 = I[np.uint64(v_self + 0)]
    t18 = add_i(st, t17, 1)
    if st[0]:
        return -1
    t19 = t18
    for t20 in range(t19):
        v__c0_ii = t20
        t21 = I[np.uint64(v_self + 2)]
        t22 = I[np.uint64(v_self + 0)]
        t23 = sub_i(st, v_I, t22)
        if st[0]:
            return -1
        t24 = add_i(st, t23, 1)
        if st[0]:
            return -1
        t25 = add_i(st, t24, v__c0_ii)
        if st[0]:
            return -1
        t26 = I[np.uint64(t21)]
        t27 = t25
        if t27 < 0:
            t27 += t26
        if t27 < 0 or t27 >= t26:
            st[0] = 1
            top[3] = 11
            return -1
        t28 = I[np.uint64(t21 + 2)] + t27
        t29 = I[np.uint64(t28)]
        t30 = list_room(I, top, st, v__c0_list)
        if st[0]:
            return -1
        I[t30] = t29
    v_d = v__c0_list
    t31 = I[np.uint64(v_self + 1)]
    v_U = t31
    t32 = 1
    t33 = I[np.uint64(v_self + 0)]
    t34 = add_i(st, t33, 1)
    if st[0]:
        return -1
    t35 = t34
    for t36 in range(t32, t35):
        v_ik = t36
        t37 = I[np.uint64(v_self + 0)]
        t38 = sub_i(st, v_I, t37)
        if st[0]:
            return -1
        t39 = add_i(st, t38, v_ik)
        if st[0]:
            return -1
        t40 = add_i(st, t39, 1)
        if st[0]:
            return -1
        t41 = t40
        t42 = add_i(st, v_I, 2)
        if st[0]:
            return -1
        t43 = t42
        for t44 in range(t41, t43):
            v_ii = t44
            t45 = I[np.uint64(v_self + 0)]
            t46 = add_i(st, v_ii, t45)
            if st[0]:
                return -1
            t47 = sub_i(st, t46, v_ik)
            if st[0]:
                return -1
            t48 = I[np.uint64(v_U)]
            t49 = t47
            if t49 < 0:
                t49 += t48
            if t49 < 0 or t49 >= t48:
                st[0] = 1
                top[3] = 16
                return -1
            t50 = I[np.uint64(v_U + 2)] + t49
            t51 = I[np.uint64(t50)]
            v_ua = t51
            t52 = sub_i(st, v_ii, 1)
            if st[0]:
                return -1
            t53 = I[np.uint64(v_U)]
            t54 = t52
            if t54 < 0:
                t54 += t53
            if t54 < 0 or t54 >= t53:
                st[0] = 1
                top[3] = 17
                return -1
            t55 = I[np.uint64(v_U + 2)] + t54
            t56 = I[np.uint64(t55)]
            v_ub = t56
            t57 = sub_i(st, v_ua, v_u)
            if st[0]:
                return -1
            t58 = sub_i(st, v_ua, v_ub)
            if st[0]:
                return -1
            t59 = t57
            if t59 > 9007199254740992 or t59 < -9007199254740992:
                st[0] = 1
                top[3] = 18
                return -1
            t60 = t58
            if t60 > 9007199254740992 or t60 < -9007199254740992:
                st[0] = 1
                top[3] = 18
                return -1
            t61 = float(t60)
            if t61 == 0.0:
                st[0] = 1
                top[3] = 18
                return -1
            v_co1 = float(t59) / t61
            t62 = sub_i(st, v_u, v_ub)
            if st[0]:
                return -1
            t63 = sub_i(st, v_ua, v_ub)
            if st[0]:
                return -1
            t64 = t62
            if t64 > 9007199254740992 or t64 < -9007199254740992:
                st[0] = 1
                top[3] = 19
                return -1
            t65 = t63
            if t65 > 9007199254740992 or t65 < -9007199254740992:
                st[0] = 1
                top[3] = 19
                return -1
            t66 = float(t65)
            if t66 == 0.0:
                st[0] = 1
                top[3] = 19
                return -1
            v_co2 = float(t64) / t66
            t67 = sub_i(st, v_ii, v_I)
            if st[0]:
                return -1
            t68 = I[np.uint64(v_self + 0)]
            t69 = add_i(st, t67, t68)
            if st[0]:
                return -1
            t70 = sub_i(st, t69, v_ik)
            if st[0]:
                return -1
            t71 = sub_i(st, t70, 1)
            if st[0]:
                return -1
            v_index = t71
            t72 = I[np.uint64(v_d)]
            t73 = v_index
            if t73 < 0:
                t73 += t72
            if t73 < 0 or t73 >= t72:
                st[0] = 1
                top[3] = 21
                return -1
            t74 = I[np.uint64(v_d + 2)] + t73
            t75 = I[np.uint64(t74)]
            t76 = t75
            t77 = add_i(st, v_index, 1)
            if st[0]:
                return -1
            t78 = I[np.uint64(v_d)]
            t79 = t77
            if t79 < 0:
                t79 += t78
            if t79 < 0 or t79 >= t78:
                st[0] = 1
                top[3] = 21
                return -1
            t80 = I[np.uint64(v_d + 2)] + t79
            t81 = I[np.uint64(t80)]
            t82_0 = f6_linear_combination(F, I, top, st, t76, t81, v_co1, v_co2)
            if st[0]:
                return -1
            t83 = I[np.uint64(v_d)]
            t84 = v_index
            if t84 < 0:
                t84 += t83
            if t84 < 0 or t84 >= t83:
                st[0] = 1
                top[3] = 21
                return -1
            t85 = I[np.uint64(v_d + 2)] + t84
            I[np.uint64(t85)] = t82_0
    t86 = I[np.uint64(v_d)]
    t87 = 0
    if t87 < 0:
        t87 += t86
    if t87 < 0 or t87 >= t86:
        st[0] = 1
        top[3] = 22
        return -1
    t88 = I[np.uint64(v_d + 2)] + t87
    t89 = I[np.uint64(t88)]
    return t89
    return -1


@njit(cache=True, error_model="numpy")
def f2_GetDomain(F, I, top, st, v_self):
    t1 = I[np.uint64(v_self + 1)]
    t2 = I[np.uint64(v_self + 0)]
    t3 = sub_i(st, t2, 1)
    if st[0]:
        return (0, 0)
    t4 = I[np.uint64(t1)]
    t5 = t3
    if t5 < 0:
        t5 += t4
    if t5 < 0 or t5 >= t4:
        st[0] = 1
        top[3] = 1000003
        return (0, 0)
    t6 = I[np.uint64(t1 + 2)] + t5
    t7 = I[np.uint64(t6)]
    t8 = I[np.uint64(v_self + 1)]
    t9 = I[np.uint64(v_self + 1)]
    t10 = I[np.uint64(t9)]
    t11 = I[np.uint64(v_self + 0)]
    t12 = sub_i(st, t10, t11)
    if st[0]:
        return (0, 0)
    t13 = I[np.uint64(t8)]
    t14 = t12
    if t14 < 0:
        t14 += t13
    if t14 < 0 or t14 >= t13:
        st[0] = 1
        top[3] = 1000003
        return (0, 0)
    t15 = I[np.uint64(t8 + 2)] + t14
    t16 = I[np.uint64(t15)]
    t17 = t7
    t18 = t16
    return (t17, t18)
    return (0, 0)


@njit(cache=True, error_model="numpy")
def f4_GetIndex(F, I, top, st, v_self, v_u):
    t1 = v_self
    t2_0, t2_1 = f2_GetDomain(F, I, top, st, t1)
    if st[0]:
        return 0
    v_dom_0 = t2_0
    v_dom_1 = t2_1
    t3 = False
    t4 = I[np.uint64(v_self + 0)]
    t5 = sub_i(st, t4, 1)
    if st[0]:
        return 0
    t6 = t5
    t7 = I[np.uint64(v_self + 1)]
    t8 = I[np.uint64(t7)]
    t9 = I[np.uint64(v_self + 0)]
    t10 = sub_i(st, t8, t9)
    if st[0]:
        return 0
    t11 = t10
    for t12 in range(t6, t11):
        v_ii = t12
        t13 = I[np.uint64(v_self + 1)]
        t14 = I[np.uint64(t13)]
        t15 = v_ii
        if t15 < 0:
            t15 += t14
        if t15 < 0 or t15 >= t14:
            st[0] = 1
            top[3] = 2000004
            return 0
        t16 = I[np.uint64(t13 + 2)] + t15
        t17 = I[np.uint64(t16)]
        t18 = v_u >= t17
        if t18:
            t19 = I[np.uint64(v_self + 1)]
            t20 = add_i(st, v_ii, 1)
            if st[0]:
                return 0
            t21 = I[np.uint64(t19)]
            t22 = t20
            if t22 < 0:
                t22 += t21
            if t22 < 0 or t22 >= t21:
                st[0] = 1
                top[3] = 2000004
                return 0
            t23 = I[np.uint64(t19 + 2)] + t22
            t24 = I[np.uint64(t23)]
            t18 = v_u < t24
        if t18:
            v_I = v_ii
            t3 = True
            break
    if not t3:
        t25 = sub_i(st, v_dom_1, 1)
        if st[0]:
            return 0
        v_I = t25
    return v_I
    return 0


@njit(cache=True, error_model="numpy")
def f6_linear_combination(F, I, top, st, v_self, v_other, v_l1, v_l2):
    t1 = F[np.uint64(v_self + 0)]
    t2 = F[np.uint64(v_other + 0)]
    t3 = F[np.uint64(v_self + 1)]
    t4 = F[np.uint64(v_other + 1)]
    t5 = F[np.uint64(v_self + 2)]
    t6 = F[np.uint64(v_other + 2)]
    t7 = alloc(I, top, st, 3)
    if st[0]:
        return -1
    f8___init__(F, I, top, st, t7, t1 * v_l1 + t2 * v_l2, t3 * v_l1 + t4 * v_l2, t5 * v_l1 + t6 * v_l2)
    if st[0]:
        return -1
    v_v = t7
    return v_v
    return -1


@njit(cache=True, error_model="numpy")
def f8___init__(F, I, top, st, v_self, v_x, v_y, v_z):
    F[np.uint64(v_self + 0)] = v_x
    F[np.uint64(v_self + 1)] = v_y
    F[np.uint64(v_self + 2)] = v_z
    return

