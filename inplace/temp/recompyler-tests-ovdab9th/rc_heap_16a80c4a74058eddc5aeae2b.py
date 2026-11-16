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
def mt_twist(I, h):
    for kk in range(624):
        y = (I[h + kk] & 0x80000000) | (I[h + (kk + 1) % 624] & 0x7fffffff)
        v = I[h + (kk + 397) % 624] ^ (y >> 1)
        if y & 1:
            v ^= 0x9908b0df
        I[h + kk] = v


@njit(cache=True, error_model="numpy")
def mt_next(I, h):
    i = I[h + 624]
    if i >= 624:
        mt_twist(I, h)
        i = 0
    y = I[h + i]
    I[h + 624] = i + 1
    y ^= y >> 11
    y ^= (y << 7) & 0x9d2c5680
    y ^= (y << 15) & 0xefc60000
    y ^= y >> 18
    return y


@njit(cache=True, error_model="numpy")
def mt_random(I, h):
    a = mt_next(I, h) >> 5
    b = mt_next(I, h) >> 6
    return (a * 67108864.0 + b) * (1.0 / 9007199254740992.0)


@njit(cache=True, error_model="numpy")
def mt_bits(I, h, k):
    if k <= 0:
        return 0
    if k <= 32:
        return mt_next(I, h) >> (32 - k)
    low = mt_next(I, h)
    high = mt_next(I, h) >> (64 - k)
    return low | (high << 32)


@njit(cache=True, error_model="numpy")
def mt_below(I, h, n):
    k = 0
    while (n >> k) != 0:
        k += 1
    r = mt_bits(I, h, k)
    while r >= n:
        r = mt_bits(I, h, k)
    return r


@njit(cache=True, error_model="numpy")
def mt_shuffle(I, h, lst):
    data = I[lst + 2]
    i = I[lst] - 1
    while i >= 1:
        j = mt_below(I, h, i + 1)
        held = I[data + i]
        I[data + i] = I[data + j]
        I[data + j] = held
        i -= 1


@njit(cache=True, error_model="numpy")
def mt_sample(I, top, st, h, lst, k):
    n = I[lst]
    if k < 0 or k > n:
        st[0] = 1
        return 0
    setsize = 21
    if k > 5:
        power = math.ceil(math.log(float(k * 3)) / math.log(4.0))
        size = 1
        for _ in range(power):
            size *= 4
        setsize += size
    out = list_new(I, top, st, k, k)
    if st[0]:
        return 0
    source, target = I[lst + 2], I[out + 2]
    if n <= setsize:
        pool = alloc(I, top, st, n if n > 0 else 1)
        if st[0]:
            return 0
        for p in range(n):
            I[pool + p] = I[source + p]
        for i in range(k):
            j = mt_below(I, h, n - i)
            I[target + i] = I[pool + j]
            I[pool + j] = I[pool + n - i - 1]
    else:
        chosen = alloc(I, top, st, n)
        if st[0]:
            return 0
        for p in range(n):
            I[chosen + p] = 0
        for i in range(k):
            j = mt_below(I, h, n)
            while I[chosen + j] != 0:
                j = mt_below(I, h, n)
            I[chosen + j] = 1
            I[target + i] = I[source + j]
    return out


@njit(cache=True, error_model="numpy")
def mt_seed(I, h, a):
    if a < 0:
        a = -a
    low, high = a & 0xffffffff, (a >> 32) & 0xffffffff
    length = 2 if high else 1
    I[h] = 19650218
    for m in range(1, 624):
        prev = I[h + m - 1]
        I[h + m] = (1812433253 * (prev ^ (prev >> 30)) + m) & 0xffffffff
    i, j = 1, 0
    for _ in range(624):
        prev = I[h + i - 1]
        key = low if j == 0 else high
        I[h + i] = ((I[h + i] ^ (((prev ^ (prev >> 30)) * 1664525) & 0xffffffff)) + key + j) & 0xffffffff
        i += 1
        j += 1
        if i >= 624:
            I[h] = I[h + 623]
            i = 1
        if j >= length:
            j = 0
    for _ in range(623):
        prev = I[h + i - 1]
        I[h + i] = ((I[h + i] ^ (((prev ^ (prev >> 30)) * 1566083941) & 0xffffffff)) - i) & 0xffffffff
        i += 1
        if i >= 624:
            I[h] = I[h + 623]
            i = 1
    I[h] = 0x80000000
    I[h + 624] = 624
    I[h + 625] = 1

@njit(cache=True, error_model="numpy")
def f0_mixed_draws(F, I, top, st, v_rng, v_n, v_top):
    t1 = list_new(I, top, st, 0, 0)
    if st[0]:
        return -1
    v_out = t1
    t2 = v_n
    for t3 in range(t2):
        v_i = t3
        t4 = v_rng
        t5 = v_top
        if t5 <= 0:
            st[0] = 1
            top[3] = 4
            return -1
        t6 = mt_below(I, t4, t5)
        t7 = v_rng
        t8 = -5
        t9 = v_top
        t10 = sub_i(st, t9, t8)
        if st[0]:
            return -1
        if t10 <= 0:
            st[0] = 1
            top[3] = 4
            return -1
        t11 = t8 + mt_below(I, t7, t10)
        t12 = add_i(st, t6, t11)
        if st[0]:
            return -1
        t13 = mul_i(st, 7, v_top)
        if st[0]:
            return -1
        t14 = add_i(st, 3, t13)
        if st[0]:
            return -1
        t15 = v_rng
        t16 = 3
        t17 = t14
        t18 = sub_i(st, t17, t16)
        if st[0]:
            return -1
        t19 = 7
        if t19 == 0:
            st[0] = 1
            top[3] = 4
            return -1
        t20 = add_i(st, t18, t19 - 1) if t19 > 0 else add_i(st, t18, t19 + 1)
        if st[0]:
            return -1
        t21 = floordiv_i(st, t20, t19)
        if st[0]:
            return -1
        if t21 <= 0:
            st[0] = 1
            top[3] = 4
            return -1
        t22 = mul_i(st, t19, mt_below(I, t15, t21))
        if st[0]:
            return -1
        t23 = add_i(st, t16, t22)
        if st[0]:
            return -1
        t24 = add_i(st, t12, t23)
        if st[0]:
            return -1
        t25 = list_room(I, top, st, v_out)
        if st[0]:
            return -1
        I[t25] = t24
        t26 = mul_i(st, v_top, 9)
        if st[0]:
            return -1
        t27 = v_rng
        t28 = t26
        t29 = -4
        t30 = sub_i(st, t29, t28)
        if st[0]:
            return -1
        t31 = -3
        if t31 == 0:
            st[0] = 1
            top[3] = 5
            return -1
        t32 = add_i(st, t30, t31 - 1) if t31 > 0 else add_i(st, t30, t31 + 1)
        if st[0]:
            return -1
        t33 = floordiv_i(st, t32, t31)
        if st[0]:
            return -1
        if t33 <= 0:
            st[0] = 1
            top[3] = 5
            return -1
        t34 = mul_i(st, t31, mt_below(I, t27, t33))
        if st[0]:
            return -1
        t35 = add_i(st, t28, t34)
        if st[0]:
            return -1
        t36 = list_room(I, top, st, v_out)
        if st[0]:
            return -1
        I[t36] = t35
        t37 = v_rng
        t38 = -3
        t39 = v_i
        if t39 < t38:
            st[0] = 1
            top[3] = 6
            return -1
        t40 = sub_i(st, t39, t38)
        if st[0]:
            return -1
        t41 = add_i(st, t40, 1)
        if st[0]:
            return -1
        t42 = t38 + mt_below(I, t37, t41)
        t43 = list_room(I, top, st, v_out)
        if st[0]:
            return -1
        I[t43] = t42
        t44 = mod_i(st, v_i, 64)
        if st[0]:
            return -1
        t45 = v_rng
        t46 = t44
        if t46 < 0 or t46 > 63:
            st[0] = 1
            top[3] = 7
            return -1
        t47 = mt_bits(I, t45, t46)
        t48 = list_room(I, top, st, v_out)
        if st[0]:
            return -1
        I[t48] = t47
    return v_out
    return -1

