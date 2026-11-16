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
def f0_run(F, I, top, st, v_self, v_iterations):
    t1 = v_iterations
    for t2 in range(t1):
        v_i = t2
        I[np.uint64(I[0] + 0)] = 0
        I[np.uint64(I[0] + 1)] = 0
        t3 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t3] = 4
        f2___init__(F, I, top, st, t3)
        if st[0]:
            return False
        t4 = t3
        t5_0 = f4_running(F, I, top, st, t4)
        if st[0]:
            return False
        t6 = alloc(I, top, st, 7)
        if st[0]:
            return False
        I[t6] = 3
        f6___init__(F, I, top, st, t6)
        if st[0]:
            return False
        t7 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t7] = 3
        f28___init__(F, I, top, st, t7, 1, 1, 10000, t5_0, t6)
        if st[0]:
            return False
        t8 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f9___init__(F, I, top, st, t8, -1, 0, 1001)
        if st[0]:
            return False
        v_wkq = t8
        t9 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f29___init__(F, I, top, st, t9, v_wkq, 0, 1001)
        if st[0]:
            return False
        v_wkq = t9
        t10 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t10] = 4
        f2___init__(F, I, top, st, t10)
        if st[0]:
            return False
        t11 = t10
        t12_0 = f12_waitingWithPacket(F, I, top, st, t11)
        if st[0]:
            return False
        t13 = alloc(I, top, st, 7)
        if st[0]:
            return False
        I[t13] = 2
        f14___init__(F, I, top, st, t13)
        if st[0]:
            return False
        t14 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t14] = 2
        f30___init__(F, I, top, st, t14, 2, 1000, v_wkq, t12_0, t13)
        if st[0]:
            return False
        t15 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f9___init__(F, I, top, st, t15, -1, 5, 1000)
        if st[0]:
            return False
        v_wkq = t15
        t16 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f29___init__(F, I, top, st, t16, v_wkq, 5, 1000)
        if st[0]:
            return False
        v_wkq = t16
        t17 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f29___init__(F, I, top, st, t17, v_wkq, 5, 1000)
        if st[0]:
            return False
        v_wkq = t17
        t18 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t18] = 4
        f2___init__(F, I, top, st, t18)
        if st[0]:
            return False
        t19 = t18
        t20_0 = f12_waitingWithPacket(F, I, top, st, t19)
        if st[0]:
            return False
        t21 = alloc(I, top, st, 7)
        if st[0]:
            return False
        I[t21] = 1
        f17___init__(F, I, top, st, t21)
        if st[0]:
            return False
        t22 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t22] = 1
        f31___init__(F, I, top, st, t22, 3, 2000, v_wkq, t20_0, t21)
        if st[0]:
            return False
        t23 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f9___init__(F, I, top, st, t23, -1, 6, 1000)
        if st[0]:
            return False
        v_wkq = t23
        t24 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f29___init__(F, I, top, st, t24, v_wkq, 6, 1000)
        if st[0]:
            return False
        v_wkq = t24
        t25 = alloc(I, top, st, 5)
        if st[0]:
            return False
        f29___init__(F, I, top, st, t25, v_wkq, 6, 1000)
        if st[0]:
            return False
        v_wkq = t25
        t26 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t26] = 4
        f2___init__(F, I, top, st, t26)
        if st[0]:
            return False
        t27 = t26
        t28_0 = f12_waitingWithPacket(F, I, top, st, t27)
        if st[0]:
            return False
        t29 = alloc(I, top, st, 7)
        if st[0]:
            return False
        I[t29] = 1
        f17___init__(F, I, top, st, t29)
        if st[0]:
            return False
        t30 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t30] = 1
        f31___init__(F, I, top, st, t30, 4, 3000, v_wkq, t28_0, t29)
        if st[0]:
            return False
        v_wkq = -1
        t31 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t31] = 4
        f2___init__(F, I, top, st, t31)
        if st[0]:
            return False
        t32 = t31
        t33_0 = f20_waiting(F, I, top, st, t32)
        if st[0]:
            return False
        t34 = alloc(I, top, st, 7)
        if st[0]:
            return False
        I[t34] = 0
        f22___init__(F, I, top, st, t34)
        if st[0]:
            return False
        t35 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t35] = 0
        f32___init__(F, I, top, st, t35, 5, 4000, v_wkq, t33_0, t34)
        if st[0]:
            return False
        t36 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t36] = 4
        f2___init__(F, I, top, st, t36)
        if st[0]:
            return False
        t37 = t36
        t38_0 = f20_waiting(F, I, top, st, t37)
        if st[0]:
            return False
        t39 = alloc(I, top, st, 7)
        if st[0]:
            return False
        I[t39] = 0
        f22___init__(F, I, top, st, t39)
        if st[0]:
            return False
        t40 = alloc(I, top, st, 10)
        if st[0]:
            return False
        I[t40] = 0
        f32___init__(F, I, top, st, t40, 6, 5000, v_wkq, t38_0, t39)
        if st[0]:
            return False
        f25_schedule(F, I, top, st)
        if st[0]:
            return False
        t41 = I[np.uint64(I[0] + 0)]
        t42 = (t41 == 9297)
        if t42:
            t43 = I[np.uint64(I[0] + 1)]
            t42 = (t43 == 23246)
        if t42:
            pass
        else:
            return False
    return True
    return False


@njit(cache=True, error_model="numpy")
def f2___init__(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = True
    I[np.uint64(v_self + 9)] = False
    I[np.uint64(v_self + 8)] = False
    return


@njit(cache=True, error_model="numpy")
def f4_running(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = False
    I[np.uint64(v_self + 9)] = False
    I[np.uint64(v_self + 8)] = False
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f6___init__(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = 1
    I[np.uint64(v_self + 4)] = 10000
    return


@njit(cache=True, error_model="numpy")
def f28___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_s, v_r):
    t1 = v_self
    f34___init__(F, I, top, st, t1, v_i, 0, -1, v_s, v_r)
    if st[0]:
        return 
    return


@njit(cache=True, error_model="numpy")
def f9___init__(F, I, top, st, v_self, v_l, v_i, v_k):
    I[np.uint64(v_self + 4)] = -1
    I[np.uint64(v_self + 2)] = v_i
    I[np.uint64(v_self + 3)] = v_k
    I[np.uint64(v_self + 1)] = 0
    t1 = list_fill(I, top, st, 4, 0)
    if st[0]:
        return 
    I[np.uint64(v_self + 0)] = t1
    return


@njit(cache=True, error_model="numpy")
def f29___init__(F, I, top, st, v_self, v_l, v_i, v_k):
    I[np.uint64(v_self + 4)] = v_l
    I[np.uint64(v_self + 2)] = v_i
    I[np.uint64(v_self + 3)] = v_k
    I[np.uint64(v_self + 1)] = 0
    t1 = list_fill(I, top, st, 4, 0)
    if st[0]:
        return 
    I[np.uint64(v_self + 0)] = t1
    return


@njit(cache=True, error_model="numpy")
def f12_waitingWithPacket(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = True
    I[np.uint64(v_self + 9)] = True
    I[np.uint64(v_self + 8)] = False
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f14___init__(F, I, top, st, v_self):
    I[np.uint64(v_self + 5)] = 3
    I[np.uint64(v_self + 4)] = 0
    return


@njit(cache=True, error_model="numpy")
def f30___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_s, v_r):
    t1 = v_self
    f35___init__(F, I, top, st, t1, v_i, v_p, v_w, v_s, v_r)
    if st[0]:
        return 
    return


@njit(cache=True, error_model="numpy")
def f17___init__(F, I, top, st, v_self):
    I[np.uint64(v_self + 3)] = -1
    I[np.uint64(v_self + 2)] = -1
    return


@njit(cache=True, error_model="numpy")
def f31___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_s, v_r):
    t1 = v_self
    f36___init__(F, I, top, st, t1, v_i, v_p, v_w, v_s, v_r)
    if st[0]:
        return 
    return


@njit(cache=True, error_model="numpy")
def f20_waiting(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = False
    I[np.uint64(v_self + 9)] = True
    I[np.uint64(v_self + 8)] = False
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f22___init__(F, I, top, st, v_self):
    I[np.uint64(v_self + 1)] = -1
    return


@njit(cache=True, error_model="numpy")
def f32___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_s, v_r):
    t1 = v_self
    f37___init__(F, I, top, st, t1, v_i, v_p, v_w, v_s, v_r)
    if st[0]:
        return 
    return


@njit(cache=True, error_model="numpy")
def f25_schedule(F, I, top, st):
    t1 = I[np.uint64(I[0] + 2)]
    v_t = t1
    while True:
        if not (not (v_t < 0)):
            break
        if v_t < 0:
            st[0] = 1
            top[3] = 15000007
            return 
        t2 = v_t
        t3_0 = f56_isTaskHoldingOrWaiting(F, I, top, st, t2)
        if st[0]:
            return 
        if t3_0:
            if v_t < 0:
                st[0] = 1
                top[3] = 15000008
                return 
            t4 = I[np.uint64(v_t + 5)]
            v_t = t4
        else:
            if v_t < 0:
                st[0] = 1
                top[3] = 15000012
                return 
            t5 = v_t
            t6_0 = f39_runTask(F, I, top, st, t5)
            if st[0]:
                return 
            v_t = t6_0
    return


@njit(cache=True, error_model="numpy")
def f34___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_initialState, v_r):
    t1 = I[np.uint64(I[0] + 2)]
    I[np.uint64(v_self + 5)] = t1
    I[np.uint64(v_self + 2)] = v_i
    I[np.uint64(v_self + 7)] = v_p
    I[np.uint64(v_self + 3)] = -1
    t2 = v_initialState
    t3_0 = f41_isPacketPending(F, I, top, st, t2)
    if st[0]:
        return 
    I[np.uint64(v_self + 6)] = t3_0
    t4 = v_initialState
    t5_0 = f43_isTaskWaiting(F, I, top, st, t4)
    if st[0]:
        return 
    I[np.uint64(v_self + 9)] = t5_0
    t6 = v_initialState
    t7_0 = f45_isTaskHolding(F, I, top, st, t6)
    if st[0]:
        return 
    I[np.uint64(v_self + 8)] = t7_0
    I[np.uint64(v_self + 1)] = v_r
    I[np.uint64(I[0] + 2)] = v_self
    t8 = I[np.uint64(I[0] + 3)]
    t9 = I[np.uint64(t8)]
    t10 = v_i
    if t10 < 0:
        t10 += t9
    if t10 < 0 or t10 >= t9:
        st[0] = 1
        top[3] = 16000014
        return 
    t11 = I[np.uint64(t8 + 2)] + t10
    I[np.uint64(t11)] = v_self
    I[np.uint64(v_self + 4)] = -1
    return


@njit(cache=True, error_model="numpy")
def f35___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_initialState, v_r):
    t1 = I[np.uint64(I[0] + 2)]
    I[np.uint64(v_self + 5)] = t1
    I[np.uint64(v_self + 2)] = v_i
    I[np.uint64(v_self + 7)] = v_p
    I[np.uint64(v_self + 3)] = v_w
    t2 = v_initialState
    t3_0 = f41_isPacketPending(F, I, top, st, t2)
    if st[0]:
        return 
    I[np.uint64(v_self + 6)] = t3_0
    t4 = v_initialState
    t5_0 = f43_isTaskWaiting(F, I, top, st, t4)
    if st[0]:
        return 
    I[np.uint64(v_self + 9)] = t5_0
    t6 = v_initialState
    t7_0 = f45_isTaskHolding(F, I, top, st, t6)
    if st[0]:
        return 
    I[np.uint64(v_self + 8)] = t7_0
    I[np.uint64(v_self + 1)] = v_r
    I[np.uint64(I[0] + 2)] = v_self
    t8 = I[np.uint64(I[0] + 3)]
    t9 = I[np.uint64(t8)]
    t10 = v_i
    if t10 < 0:
        t10 += t9
    if t10 < 0 or t10 >= t9:
        st[0] = 1
        top[3] = 17000014
        return 
    t11 = I[np.uint64(t8 + 2)] + t10
    I[np.uint64(t11)] = v_self
    I[np.uint64(v_self + 4)] = -1
    return


@njit(cache=True, error_model="numpy")
def f36___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_initialState, v_r):
    t1 = I[np.uint64(I[0] + 2)]
    I[np.uint64(v_self + 5)] = t1
    I[np.uint64(v_self + 2)] = v_i
    I[np.uint64(v_self + 7)] = v_p
    I[np.uint64(v_self + 3)] = v_w
    t2 = v_initialState
    t3_0 = f41_isPacketPending(F, I, top, st, t2)
    if st[0]:
        return 
    I[np.uint64(v_self + 6)] = t3_0
    t4 = v_initialState
    t5_0 = f43_isTaskWaiting(F, I, top, st, t4)
    if st[0]:
        return 
    I[np.uint64(v_self + 9)] = t5_0
    t6 = v_initialState
    t7_0 = f45_isTaskHolding(F, I, top, st, t6)
    if st[0]:
        return 
    I[np.uint64(v_self + 8)] = t7_0
    I[np.uint64(v_self + 1)] = v_r
    I[np.uint64(I[0] + 2)] = v_self
    t8 = I[np.uint64(I[0] + 3)]
    t9 = I[np.uint64(t8)]
    t10 = v_i
    if t10 < 0:
        t10 += t9
    if t10 < 0 or t10 >= t9:
        st[0] = 1
        top[3] = 18000014
        return 
    t11 = I[np.uint64(t8 + 2)] + t10
    I[np.uint64(t11)] = v_self
    I[np.uint64(v_self + 4)] = -1
    return


@njit(cache=True, error_model="numpy")
def f37___init__(F, I, top, st, v_self, v_i, v_p, v_w, v_initialState, v_r):
    t1 = I[np.uint64(I[0] + 2)]
    I[np.uint64(v_self + 5)] = t1
    I[np.uint64(v_self + 2)] = v_i
    I[np.uint64(v_self + 7)] = v_p
    I[np.uint64(v_self + 3)] = v_w
    t2 = v_initialState
    t3_0 = f41_isPacketPending(F, I, top, st, t2)
    if st[0]:
        return 
    I[np.uint64(v_self + 6)] = t3_0
    t4 = v_initialState
    t5_0 = f43_isTaskWaiting(F, I, top, st, t4)
    if st[0]:
        return 
    I[np.uint64(v_self + 9)] = t5_0
    t6 = v_initialState
    t7_0 = f45_isTaskHolding(F, I, top, st, t6)
    if st[0]:
        return 
    I[np.uint64(v_self + 8)] = t7_0
    I[np.uint64(v_self + 1)] = v_r
    I[np.uint64(I[0] + 2)] = v_self
    t8 = I[np.uint64(I[0] + 3)]
    t9 = I[np.uint64(t8)]
    t10 = v_i
    if t10 < 0:
        t10 += t9
    if t10 < 0 or t10 >= t9:
        st[0] = 1
        top[3] = 19000014
        return 
    t11 = I[np.uint64(t8 + 2)] + t10
    I[np.uint64(t11)] = v_self
    I[np.uint64(v_self + 4)] = -1
    return


@njit(cache=True, error_model="numpy")
def f56_isTaskHoldingOrWaiting(F, I, top, st, v_self):
    t1 = (I[np.uint64(v_self + 8)] != 0)
    t2 = t1
    if not t2:
        t3 = (I[np.uint64(v_self + 6)] != 0)
        t4 = (not t3)
        if t4:
            t5 = (I[np.uint64(v_self + 9)] != 0)
            t4 = t5
        t2 = t4
    return t2
    return False


@njit(cache=True, error_model="numpy")
def f39_runTask(F, I, top, st, v_self):
    t1 = v_self
    t2_0 = f47_isWaitingWithPacket(F, I, top, st, t1)
    if st[0]:
        return -1
    if t2_0:
        t3 = I[np.uint64(v_self + 3)]
        v_msg = t3
        if v_msg < 0:
            st[0] = 1
            top[3] = 21000004
            return -1
        t4 = I[np.uint64(v_msg + 4)]
        I[np.uint64(v_self + 3)] = t4
        t5 = I[np.uint64(v_self + 3)]
        if (t5 < 0):
            t6 = v_self
            t7_0 = f57_running(F, I, top, st, t6)
            if st[0]:
                return -1
        else:
            t8 = v_self
            t9_0 = f59_packetPending(F, I, top, st, t8)
            if st[0]:
                return -1
    else:
        v_msg = -1
    t10 = v_self
    t11 = I[np.uint64(v_self + 1)]
    t13 = I[t10]
    if t13 == 0:
        t14_0 = f60_fn(F, I, top, st, t10, v_msg, t11)
        if st[0]:
            return -1
        t12_0 = t14_0
    elif t13 == 1:
        t15_0 = f61_fn(F, I, top, st, t10, v_msg, t11)
        if st[0]:
            return -1
        t12_0 = t15_0
    elif t13 == 2:
        t16_0 = f62_fn(F, I, top, st, t10, v_msg, t11)
        if st[0]:
            return -1
        t12_0 = t16_0
    elif t13 == 3:
        t17_0 = f63_fn(F, I, top, st, t10, v_msg, t11)
        if st[0]:
            return -1
        t12_0 = t17_0
    else:
        st[0] = 1
        top[3] = 21000012
        return -1
    return t12_0
    return -1


@njit(cache=True, error_model="numpy")
def f41_isPacketPending(F, I, top, st, v_self):
    t1 = (I[np.uint64(v_self + 6)] != 0)
    return t1
    return False


@njit(cache=True, error_model="numpy")
def f43_isTaskWaiting(F, I, top, st, v_self):
    t1 = (I[np.uint64(v_self + 9)] != 0)
    return t1
    return False


@njit(cache=True, error_model="numpy")
def f45_isTaskHolding(F, I, top, st, v_self):
    t1 = (I[np.uint64(v_self + 8)] != 0)
    return t1
    return False


@njit(cache=True, error_model="numpy")
def f47_isWaitingWithPacket(F, I, top, st, v_self):
    t1 = (I[np.uint64(v_self + 6)] != 0)
    t2 = t1
    if t2:
        t3 = (I[np.uint64(v_self + 9)] != 0)
        t2 = t3
    if t2:
        t4 = (I[np.uint64(v_self + 8)] != 0)
        t2 = (not t4)
    return t2
    return False


@njit(cache=True, error_model="numpy")
def f57_running(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = False
    I[np.uint64(v_self + 9)] = False
    I[np.uint64(v_self + 8)] = False
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f59_packetPending(F, I, top, st, v_self):
    I[np.uint64(v_self + 6)] = True
    I[np.uint64(v_self + 9)] = False
    I[np.uint64(v_self + 8)] = False
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f60_fn(F, I, top, st, v_self, v_pkt, v_r):
    v_d = v_r
    t1 = v_d
    t2 = (I[t1] == 0)
    if not t2:
        st[0] = 1
        top[3] = 28000003
        return -1
    t3 = v_self
    f65_fn(F, I, top, st, t3, v_pkt, v_r)
    if st[0]:
        return -1
    if (v_pkt < 0):
        if not (I[np.uint64(v_d)] == 0):
            st[0] = 1
            top[3] = 28000006
            return -1
        t4 = I[np.uint64(v_d + 1)]
        v_pkt = t4
        if (v_pkt < 0):
            t5 = v_self
            t6_0 = f67_waitTask(F, I, top, st, t5)
            if st[0]:
                return -1
            return t6_0
        else:
            if not (I[np.uint64(v_d)] == 0):
                st[0] = 1
                top[3] = 28000010
                return -1
            I[np.uint64(v_d + 1)] = -1
            t7 = v_self
            t8_0 = f69_qpkt(F, I, top, st, t7, v_pkt)
            if st[0]:
                return -1
            return t8_0
    else:
        if not (I[np.uint64(v_d)] == 0):
            st[0] = 1
            top[3] = 28000013
            return -1
        I[np.uint64(v_d + 1)] = v_pkt
        t9 = v_self
        t10_0 = f71_hold(F, I, top, st, t9)
        if st[0]:
            return -1
        return t10_0
    return -1


@njit(cache=True, error_model="numpy")
def f61_fn(F, I, top, st, v_self, v_pkt, v_r):
    v_h = v_r
    t1 = v_h
    t2 = (I[t1] == 1)
    if not t2:
        st[0] = 1
        top[3] = 29000003
        return -1
    t3 = v_self
    f72_fn(F, I, top, st, t3, v_pkt, v_r)
    if st[0]:
        return -1
    if (not (v_pkt < 0)):
        if v_pkt < 0:
            st[0] = 1
            top[3] = 29000006
            return -1
        t4 = I[np.uint64(v_pkt + 3)]
        if (t4 == 1001):
            t5 = v_h
            t7 = I[t5]
            if t7 == 1:
                t8_0 = f74_workInAdd(F, I, top, st, t5, v_pkt)
                if st[0]:
                    return -1
                t6_0 = t8_0
            else:
                st[0] = 1
                top[3] = 29000007
                return -1
        else:
            t9 = v_h
            t11 = I[t9]
            if t11 == 1:
                t12_0 = f76_deviceInAdd(F, I, top, st, t9, v_pkt)
                if st[0]:
                    return -1
                t10_0 = t12_0
            else:
                st[0] = 1
                top[3] = 29000009
                return -1
    if not (I[np.uint64(v_h)] == 1):
        st[0] = 1
        top[3] = 29000010
        return -1
    t13 = I[np.uint64(v_h + 3)]
    v_work = t13
    if (v_work < 0):
        t14 = v_self
        t15_0 = f77_waitTask(F, I, top, st, t14)
        if st[0]:
            return -1
        return t15_0
    if v_work < 0:
        st[0] = 1
        top[3] = 29000013
        return -1
    t16 = I[np.uint64(v_work + 1)]
    v_count = t16
    if (v_count >= 4):
        if v_work < 0:
            st[0] = 1
            top[3] = 29000015
            return -1
        t17 = I[np.uint64(v_work + 4)]
        if not (I[np.uint64(v_h)] == 1):
            st[0] = 1
            top[3] = 29000015
            return -1
        I[np.uint64(v_h + 3)] = t17
        t18 = v_self
        t19_0 = f78_qpkt(F, I, top, st, t18, v_work)
        if st[0]:
            return -1
        return t19_0
    if not (I[np.uint64(v_h)] == 1):
        st[0] = 1
        top[3] = 29000018
        return -1
    t20 = I[np.uint64(v_h + 2)]
    v_dev = t20
    if (v_dev < 0):
        t21 = v_self
        t22_0 = f77_waitTask(F, I, top, st, t21)
        if st[0]:
            return -1
        return t22_0
    if v_dev < 0:
        st[0] = 1
        top[3] = 29000022
        return -1
    t23 = I[np.uint64(v_dev + 4)]
    if not (I[np.uint64(v_h)] == 1):
        st[0] = 1
        top[3] = 29000022
        return -1
    I[np.uint64(v_h + 2)] = t23
    if v_work < 0:
        st[0] = 1
        top[3] = 29000023
        return -1
    t24 = I[np.uint64(v_work + 0)]
    t25 = I[np.uint64(t24)]
    t26 = v_count
    if t26 < 0:
        t26 += t25
    if t26 < 0 or t26 >= t25:
        st[0] = 1
        top[3] = 29000023
        return -1
    t27 = I[np.uint64(t24 + 2)] + t26
    t28 = I[np.uint64(t27)]
    if v_dev < 0:
        st[0] = 1
        top[3] = 29000023
        return -1
    I[np.uint64(v_dev + 1)] = t28
    t29 = add_i(st, v_count, 1)
    if st[0]:
        return -1
    if v_work < 0:
        st[0] = 1
        top[3] = 29000024
        return -1
    I[np.uint64(v_work + 1)] = t29
    t30 = v_self
    t31_0 = f78_qpkt(F, I, top, st, t30, v_dev)
    if st[0]:
        return -1
    return t31_0
    return -1


@njit(cache=True, error_model="numpy")
def f62_fn(F, I, top, st, v_self, v_pkt, v_r):
    v_w = v_r
    t1 = v_w
    t2 = (I[t1] == 2)
    if not t2:
        st[0] = 1
        top[3] = 30000003
        return -1
    t3 = v_self
    f80_fn(F, I, top, st, t3, v_pkt, v_r)
    if st[0]:
        return -1
    if (v_pkt < 0):
        t4 = v_self
        t5_0 = f81_waitTask(F, I, top, st, t4)
        if st[0]:
            return -1
        return t5_0
    if not (I[np.uint64(v_w)] == 2):
        st[0] = 1
        top[3] = 30000008
        return -1
    t6 = I[np.uint64(v_w + 5)]
    if (t6 == 3):
        v_dest = 4
    else:
        v_dest = 3
    if not (I[np.uint64(v_w)] == 2):
        st[0] = 1
        top[3] = 30000013
        return -1
    I[np.uint64(v_w + 5)] = v_dest
    if v_pkt < 0:
        st[0] = 1
        top[3] = 30000014
        return -1
    I[np.uint64(v_pkt + 2)] = v_dest
    if v_pkt < 0:
        st[0] = 1
        top[3] = 30000015
        return -1
    I[np.uint64(v_pkt + 1)] = 0
    t7 = 0
    t8 = 4
    t9 = 1
    if t9 == 0:
        st[0] = 1
        top[3] = 30000017
        return -1
    for t10 in range(t7, t8, t9):
        v_i = t10
        t11 = v_w
        if not (I[np.uint64(t11)] == 2 or I[np.uint64(t11)] == 3):
            st[0] = 1
            top[3] = 30000018
            return -1
        t12 = I[np.uint64(t11 + 4)]
        t13 = add_i(st, t12, 1)
        if st[0]:
            return -1
        if not (I[np.uint64(t11)] == 2 or I[np.uint64(t11)] == 3):
            st[0] = 1
            top[3] = 30000018
            return -1
        I[np.uint64(t11 + 4)] = t13
        if not (I[np.uint64(v_w)] == 2 or I[np.uint64(v_w)] == 3):
            st[0] = 1
            top[3] = 30000019
            return -1
        t14 = I[np.uint64(v_w + 4)]
        if (t14 > 26):
            if not (I[np.uint64(v_w)] == 2 or I[np.uint64(v_w)] == 3):
                st[0] = 1
                top[3] = 30000020
                return -1
            I[np.uint64(v_w + 4)] = 1
        if not (I[np.uint64(v_w)] == 2 or I[np.uint64(v_w)] == 3):
            st[0] = 1
            top[3] = 30000021
            return -1
        t15 = I[np.uint64(v_w + 4)]
        t16 = add_i(st, 65, t15)
        if st[0]:
            return -1
        t17 = sub_i(st, t16, 1)
        if st[0]:
            return -1
        if v_pkt < 0:
            st[0] = 1
            top[3] = 30000021
            return -1
        t18 = I[np.uint64(v_pkt + 0)]
        t19 = I[np.uint64(t18)]
        t20 = v_i
        if t20 < 0:
            t20 += t19
        if t20 < 0 or t20 >= t19:
            st[0] = 1
            top[3] = 30000021
            return -1
        t21 = I[np.uint64(t18 + 2)] + t20
        I[np.uint64(t21)] = t17
    t22 = v_self
    t23_0 = f82_qpkt(F, I, top, st, t22, v_pkt)
    if st[0]:
        return -1
    return t23_0
    return -1


@njit(cache=True, error_model="numpy")
def f63_fn(F, I, top, st, v_self, v_pkt, v_r):
    v_i = v_r
    t1 = v_i
    t2 = (I[t1] == 3)
    if not t2:
        st[0] = 1
        top[3] = 31000003
        return -1
    t3 = v_self
    f83_fn(F, I, top, st, t3, v_pkt, v_r)
    if st[0]:
        return -1
    t4 = v_i
    if not (I[np.uint64(t4)] == 2 or I[np.uint64(t4)] == 3):
        st[0] = 1
        top[3] = 31000005
        return -1
    t5 = I[np.uint64(t4 + 4)]
    t6 = sub_i(st, t5, 1)
    if st[0]:
        return -1
    if not (I[np.uint64(t4)] == 2 or I[np.uint64(t4)] == 3):
        st[0] = 1
        top[3] = 31000005
        return -1
    I[np.uint64(t4 + 4)] = t6
    if not (I[np.uint64(v_i)] == 2 or I[np.uint64(v_i)] == 3):
        st[0] = 1
        top[3] = 31000006
        return -1
    t7 = I[np.uint64(v_i + 4)]
    if (t7 == 0):
        t8 = v_self
        t9_0 = f84_hold(F, I, top, st, t8)
        if st[0]:
            return -1
        return t9_0
    else:
        if not (I[np.uint64(v_i)] == 3):
            st[0] = 1
            top[3] = 31000008
            return -1
        t10 = I[np.uint64(v_i + 6)]
        if ((t10 & 1) == 0):
            t11 = v_i
            if not (I[np.uint64(t11)] == 3):
                st[0] = 1
                top[3] = 31000009
                return -1
            t12 = I[np.uint64(t11 + 6)]
            t13 = floordiv_i(st, t12, 2)
            if st[0]:
                return -1
            if not (I[np.uint64(t11)] == 3):
                st[0] = 1
                top[3] = 31000009
                return -1
            I[np.uint64(t11 + 6)] = t13
            t14 = v_self
            t15_0 = f86_release(F, I, top, st, t14, 5)
            if st[0]:
                return -1
            return t15_0
        else:
            if not (I[np.uint64(v_i)] == 3):
                st[0] = 1
                top[3] = 31000012
                return -1
            t16 = I[np.uint64(v_i + 6)]
            t17 = floordiv_i(st, t16, 2)
            if st[0]:
                return -1
            if not (I[np.uint64(v_i)] == 3):
                st[0] = 1
                top[3] = 31000012
                return -1
            I[np.uint64(v_i + 6)] = (t17 ^ 53256)
            t18 = v_self
            t19_0 = f86_release(F, I, top, st, t18, 6)
            if st[0]:
                return -1
            return t19_0
    return -1


@njit(cache=True, error_model="numpy")
def f65_fn(F, I, top, st, v_self, v_pkt, v_r):
    I[np.uint64(v_self + 4)] = v_pkt
    return


@njit(cache=True, error_model="numpy")
def f67_waitTask(F, I, top, st, v_self):
    I[np.uint64(v_self + 9)] = True
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f69_qpkt(F, I, top, st, v_self, v_pkt):
    t1 = v_self
    if v_pkt < 0:
        st[0] = 1
        top[3] = 34000002
        return -1
    t2 = I[np.uint64(v_pkt + 2)]
    t3_0 = f88_findtcb(F, I, top, st, t1, t2)
    if st[0]:
        return -1
    v_t = t3_0
    t4 = I[0]
    t5 = I[np.uint64(t4 + 1)]
    t6 = add_i(st, t5, 1)
    if st[0]:
        return -1
    I[np.uint64(t4 + 1)] = t6
    if v_pkt < 0:
        st[0] = 1
        top[3] = 34000004
        return -1
    I[np.uint64(v_pkt + 4)] = -1
    t7 = I[np.uint64(v_self + 2)]
    if v_pkt < 0:
        st[0] = 1
        top[3] = 34000005
        return -1
    I[np.uint64(v_pkt + 2)] = t7
    if v_t < 0:
        st[0] = 1
        top[3] = 34000006
        return -1
    t8 = v_t
    t9_0 = f97_addPacket(F, I, top, st, t8, v_pkt, v_self)
    if st[0]:
        return -1
    return t9_0
    return -1


@njit(cache=True, error_model="numpy")
def f71_hold(F, I, top, st, v_self):
    t1 = I[0]
    t2 = I[np.uint64(t1 + 0)]
    t3 = add_i(st, t2, 1)
    if st[0]:
        return -1
    I[np.uint64(t1 + 0)] = t3
    I[np.uint64(v_self + 8)] = True
    t4 = I[np.uint64(v_self + 5)]
    return t4
    return -1


@njit(cache=True, error_model="numpy")
def f72_fn(F, I, top, st, v_self, v_pkt, v_r):
    I[np.uint64(v_self + 4)] = v_pkt
    return


@njit(cache=True, error_model="numpy")
def f74_workInAdd(F, I, top, st, v_self, v_p):
    if v_p < 0:
        st[0] = 1
        top[3] = 37000002
        return -1
    t1 = v_p
    t2 = I[np.uint64(v_self + 3)]
    t3_0 = f90_append_to(F, I, top, st, t1, t2)
    if st[0]:
        return -1
    I[np.uint64(v_self + 3)] = t3_0
    t4 = I[np.uint64(v_self + 3)]
    return t4
    return -1


@njit(cache=True, error_model="numpy")
def f76_deviceInAdd(F, I, top, st, v_self, v_p):
    if v_p < 0:
        st[0] = 1
        top[3] = 38000002
        return -1
    t1 = v_p
    t2 = I[np.uint64(v_self + 2)]
    t3_0 = f90_append_to(F, I, top, st, t1, t2)
    if st[0]:
        return -1
    I[np.uint64(v_self + 2)] = t3_0
    t4 = I[np.uint64(v_self + 2)]
    return t4
    return -1


@njit(cache=True, error_model="numpy")
def f77_waitTask(F, I, top, st, v_self):
    I[np.uint64(v_self + 9)] = True
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f78_qpkt(F, I, top, st, v_self, v_pkt):
    t1 = v_self
    if v_pkt < 0:
        st[0] = 1
        top[3] = 40000002
        return -1
    t2 = I[np.uint64(v_pkt + 2)]
    t3_0 = f92_findtcb(F, I, top, st, t1, t2)
    if st[0]:
        return -1
    v_t = t3_0
    t4 = I[0]
    t5 = I[np.uint64(t4 + 1)]
    t6 = add_i(st, t5, 1)
    if st[0]:
        return -1
    I[np.uint64(t4 + 1)] = t6
    if v_pkt < 0:
        st[0] = 1
        top[3] = 40000004
        return -1
    I[np.uint64(v_pkt + 4)] = -1
    t7 = I[np.uint64(v_self + 2)]
    if v_pkt < 0:
        st[0] = 1
        top[3] = 40000005
        return -1
    I[np.uint64(v_pkt + 2)] = t7
    if v_t < 0:
        st[0] = 1
        top[3] = 40000006
        return -1
    t8 = v_t
    t9_0 = f98_addPacket(F, I, top, st, t8, v_pkt, v_self)
    if st[0]:
        return -1
    return t9_0
    return -1


@njit(cache=True, error_model="numpy")
def f80_fn(F, I, top, st, v_self, v_pkt, v_r):
    I[np.uint64(v_self + 4)] = v_pkt
    return


@njit(cache=True, error_model="numpy")
def f81_waitTask(F, I, top, st, v_self):
    I[np.uint64(v_self + 9)] = True
    return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f82_qpkt(F, I, top, st, v_self, v_pkt):
    t1 = v_self
    if v_pkt < 0:
        st[0] = 1
        top[3] = 43000002
        return -1
    t2 = I[np.uint64(v_pkt + 2)]
    t3_0 = f94_findtcb(F, I, top, st, t1, t2)
    if st[0]:
        return -1
    v_t = t3_0
    t4 = I[0]
    t5 = I[np.uint64(t4 + 1)]
    t6 = add_i(st, t5, 1)
    if st[0]:
        return -1
    I[np.uint64(t4 + 1)] = t6
    if v_pkt < 0:
        st[0] = 1
        top[3] = 43000004
        return -1
    I[np.uint64(v_pkt + 4)] = -1
    t7 = I[np.uint64(v_self + 2)]
    if v_pkt < 0:
        st[0] = 1
        top[3] = 43000005
        return -1
    I[np.uint64(v_pkt + 2)] = t7
    if v_t < 0:
        st[0] = 1
        top[3] = 43000006
        return -1
    t8 = v_t
    t9_0 = f99_addPacket(F, I, top, st, t8, v_pkt, v_self)
    if st[0]:
        return -1
    return t9_0
    return -1


@njit(cache=True, error_model="numpy")
def f83_fn(F, I, top, st, v_self, v_pkt, v_r):
    I[np.uint64(v_self + 4)] = v_pkt
    return


@njit(cache=True, error_model="numpy")
def f84_hold(F, I, top, st, v_self):
    t1 = I[0]
    t2 = I[np.uint64(t1 + 0)]
    t3 = add_i(st, t2, 1)
    if st[0]:
        return -1
    I[np.uint64(t1 + 0)] = t3
    I[np.uint64(v_self + 8)] = True
    t4 = I[np.uint64(v_self + 5)]
    return t4
    return -1


@njit(cache=True, error_model="numpy")
def f86_release(F, I, top, st, v_self, v_i):
    t1 = v_self
    t2_0 = f95_findtcb(F, I, top, st, t1, v_i)
    if st[0]:
        return -1
    v_t = t2_0
    if v_t < 0:
        st[0] = 1
        top[3] = 46000003
        return -1
    I[np.uint64(v_t + 8)] = False
    if v_t < 0:
        st[0] = 1
        top[3] = 46000004
        return -1
    t3 = I[np.uint64(v_t + 7)]
    t4 = I[np.uint64(v_self + 7)]
    if (t3 > t4):
        return v_t
    else:
        return v_self
    return -1


@njit(cache=True, error_model="numpy")
def f88_findtcb(F, I, top, st, v_self, v_id):
    t1 = I[np.uint64(I[0] + 3)]
    t2 = I[np.uint64(t1)]
    t3 = v_id
    if t3 < 0:
        t3 += t2
    if t3 < 0 or t3 >= t2:
        st[0] = 1
        top[3] = 47000002
        return -1
    t4 = I[np.uint64(t1 + 2)] + t3
    t5 = I[np.uint64(t4)]
    v_t = t5
    if (v_t < 0):
        st[0] = 1
        top[3] = 47000004
        return -1
    return v_t
    return -1


@njit(cache=True, error_model="numpy")
def f97_addPacket(F, I, top, st, v_self, v_p, v_old):
    t1 = I[np.uint64(v_self + 3)]
    if (t1 < 0):
        I[np.uint64(v_self + 3)] = v_p
        I[np.uint64(v_self + 6)] = True
        t2 = I[np.uint64(v_self + 7)]
        t3 = I[np.uint64(v_old + 7)]
        if (t2 > t3):
            return v_self
    else:
        if v_p < 0:
            st[0] = 1
            top[3] = 48000008
            return -1
        t4 = v_p
        t5 = I[np.uint64(v_self + 3)]
        t6_0 = f90_append_to(F, I, top, st, t4, t5)
        if st[0]:
            return -1
    return v_old
    return -1


@njit(cache=True, error_model="numpy")
def f90_append_to(F, I, top, st, v_self, v_lst):
    I[np.uint64(v_self + 4)] = -1
    if (v_lst < 0):
        return v_self
    else:
        v_p = v_lst
        if v_p < 0:
            st[0] = 1
            top[3] = 49000007
            return -1
        t1 = I[np.uint64(v_p + 4)]
        v_next = t1
        while True:
            if not (not (v_next < 0)):
                break
            v_p = v_next
            if v_p < 0:
                st[0] = 1
                top[3] = 49000010
                return -1
            t2 = I[np.uint64(v_p + 4)]
            v_next = t2
        if v_p < 0:
            st[0] = 1
            top[3] = 49000011
            return -1
        I[np.uint64(v_p + 4)] = v_self
        return v_lst
    return -1


@njit(cache=True, error_model="numpy")
def f92_findtcb(F, I, top, st, v_self, v_id):
    t1 = I[np.uint64(I[0] + 3)]
    t2 = I[np.uint64(t1)]
    t3 = v_id
    if t3 < 0:
        t3 += t2
    if t3 < 0 or t3 >= t2:
        st[0] = 1
        top[3] = 50000002
        return -1
    t4 = I[np.uint64(t1 + 2)] + t3
    t5 = I[np.uint64(t4)]
    v_t = t5
    if (v_t < 0):
        st[0] = 1
        top[3] = 50000004
        return -1
    return v_t
    return -1


@njit(cache=True, error_model="numpy")
def f98_addPacket(F, I, top, st, v_self, v_p, v_old):
    t1 = I[np.uint64(v_self + 3)]
    if (t1 < 0):
        I[np.uint64(v_self + 3)] = v_p
        I[np.uint64(v_self + 6)] = True
        t2 = I[np.uint64(v_self + 7)]
        t3 = I[np.uint64(v_old + 7)]
        if (t2 > t3):
            return v_self
    else:
        if v_p < 0:
            st[0] = 1
            top[3] = 51000008
            return -1
        t4 = v_p
        t5 = I[np.uint64(v_self + 3)]
        t6_0 = f90_append_to(F, I, top, st, t4, t5)
        if st[0]:
            return -1
    return v_old
    return -1


@njit(cache=True, error_model="numpy")
def f94_findtcb(F, I, top, st, v_self, v_id):
    t1 = I[np.uint64(I[0] + 3)]
    t2 = I[np.uint64(t1)]
    t3 = v_id
    if t3 < 0:
        t3 += t2
    if t3 < 0 or t3 >= t2:
        st[0] = 1
        top[3] = 52000002
        return -1
    t4 = I[np.uint64(t1 + 2)] + t3
    t5 = I[np.uint64(t4)]
    v_t = t5
    if (v_t < 0):
        st[0] = 1
        top[3] = 52000004
        return -1
    return v_t
    return -1


@njit(cache=True, error_model="numpy")
def f99_addPacket(F, I, top, st, v_self, v_p, v_old):
    t1 = I[np.uint64(v_self + 3)]
    if (t1 < 0):
        I[np.uint64(v_self + 3)] = v_p
        I[np.uint64(v_self + 6)] = True
        t2 = I[np.uint64(v_self + 7)]
        t3 = I[np.uint64(v_old + 7)]
        if (t2 > t3):
            return v_self
    else:
        if v_p < 0:
            st[0] = 1
            top[3] = 53000008
            return -1
        t4 = v_p
        t5 = I[np.uint64(v_self + 3)]
        t6_0 = f90_append_to(F, I, top, st, t4, t5)
        if st[0]:
            return -1
    return v_old
    return -1


@njit(cache=True, error_model="numpy")
def f95_findtcb(F, I, top, st, v_self, v_id):
    t1 = I[np.uint64(I[0] + 3)]
    t2 = I[np.uint64(t1)]
    t3 = v_id
    if t3 < 0:
        t3 += t2
    if t3 < 0 or t3 >= t2:
        st[0] = 1
        top[3] = 54000002
        return -1
    t4 = I[np.uint64(t1 + 2)] + t3
    t5 = I[np.uint64(t4)]
    v_t = t5
    if (v_t < 0):
        st[0] = 1
        top[3] = 54000004
        return -1
    return v_t
    return -1

