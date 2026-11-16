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

from numba import carray, types as _heap_types
from numba.core import cgutils as _heap_cgutils
from numba.extending import intrinsic as _heap_intrinsic

@_heap_intrinsic
def _heap_data(typingctx, array):
    signature = _heap_types.CPointer(array.dtype)(array)
    def codegen(context, builder, sig, args):
        view = context.make_array(sig.args[0])(context, builder, value=args[0])
        return view.data
    return signature, codegen

@_heap_intrinsic
def _heap_context_pack(typingctx, heap_F, heap_I, heap_top, heap_st, heap_len):
    fields = (heap_F, heap_I, heap_top, heap_st, heap_len)
    if not all(isinstance(field, _heap_types.CPointer) for field in fields[:4]) or heap_len != _heap_types.int64:
        return
    record = _heap_types.Tuple(fields)
    signature = _heap_types.CPointer(record)(*fields)
    def codegen(context, builder, sig, args):
        # This intrinsic emits into the public adapter's frame, which remains
        # live until every synchronous borrowed call has returned. The pointer
        # never becomes a returned user value or part of retained native state.
        model = context.data_model_manager[record]
        value = context.make_tuple(builder, record, args)
        return _heap_cgutils.alloca_once_value(builder, model.as_data(builder, value))
    return signature, codegen

@_heap_intrinsic
def _heap_context_unpack(typingctx, pointer):
    if not isinstance(pointer, _heap_types.CPointer) or not isinstance(pointer.dtype, _heap_types.BaseTuple):
        return
    record = pointer.dtype
    if (len(record) != 5 or not all(isinstance(field, _heap_types.CPointer) for field in record.types[:4])
            or record.types[4] != _heap_types.int64):
        return
    signature = record(pointer)
    def codegen(context, builder, sig, args):
        # The immutable descriptor retains each actual pointer type. Its arena
        # pointees can alias and mutate; no disjointness/readonly promise is made.
        model = context.data_model_manager[sig.return_type]
        return model.from_data(builder, builder.load(args[0]))
    return signature, codegen

@njit(cache=True, error_model="numpy")
def f0_build_tree_borrowed(_heap_ctx, v_keys):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_keys)]
    t2 = 0
    if t2 < 0:
        t2 += t1
    if t2 < 0 or t2 >= t1:
        st[0] = 1
        top[3] = 2
        return (0, 0)
    t3 = I[np.uint64(v_keys + 2)] + t2
    t4 = I[np.uint64(t3)]
    _sr_t5_I0 = np.int64(0)
    _sr_t5_I1 = np.int64(0)
    _sr_t5_I2 = np.int64(0)
    _sr_t5_I3 = np.int64(0)
    if st[0]:
        return (0, 0)
    _sr_t5_I0, _sr_t5_I1, _sr_t5_I2, _sr_t5_I3 = sr0_f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t5_I0, _sr_t5_I1, _sr_t5_I2, _sr_t5_I3, t4)
    if st[0]:
        return (0, 0)
    pass
    t6 = list_slice(I, top, st, v_keys, 1, 0, True, False)
    if st[0]:
        return (0, 0)
    t7 = t6
    t8 = 0
    while True:
        if t8 >= I[np.uint64(t7)]:
            break
        t9 = I[np.uint64(I[np.uint64(t7 + 2)] + t8)]
        t8 += 1
        v_key = t9
        pass
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4
            return (0, 0)
        _sr_t5_I0, _sr_t5_I2, _sr_t5_I3 = sr1_f4_insert_borrowed(_heap_ctx, _sr_t5_I0, _sr_t5_I1, _sr_t5_I2, _sr_t5_I3, np.int64(v_key))
        if st[0]:
            return (0, 0)
        top[1] -= 1
    pass
    top[1] += 1
    if top[1] > top[2]:
        st[0] = 1
        top[3] = 5
        return (0, 0)
    t12_0 = sr2_f6_total_borrowed(_heap_ctx, _sr_t5_I0, _sr_t5_I1, _sr_t5_I2, _sr_t5_I3)
    if st[0]:
        return (0, 0)
    top[1] -= 1
    pass
    top[1] += 1
    if top[1] > top[2]:
        st[0] = 1
        top[3] = 5
        return (0, 0)
    t14_0 = sr3_f8_depth_borrowed(_heap_ctx, _sr_t5_I0, _sr_t5_I1, _sr_t5_I2, _sr_t5_I3)
    if st[0]:
        return (0, 0)
    top[1] -= 1
    t15 = t12_0
    t16 = t14_0
    return (t15, t16)
    return (0, 0)


@njit(cache=True, error_model="numpy")
def f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_key):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    I[np.uint64(v_self + 1)] = v_key
    I[np.uint64(v_self + 2)] = -1
    I[np.uint64(v_self + 3)] = -1
    I[np.uint64(v_self + 0)] = 1
    return


@njit(cache=True, error_model="numpy")
def f4_insert_borrowed(_heap_ctx, v_self, v_key):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 1)]
    if v_key == t1:
        t2 = v_self
        t3 = I[np.uint64(t2 + 0)]
        t4 = add_i(st, t3, 1)
        if st[0]:
            return
        I[np.uint64(t2 + 0)] = t4
    else:
        t5 = I[np.uint64(v_self + 1)]
        if v_key < t5:
            t6 = I[np.uint64(v_self + 2)]
            if t6 < 0:
                t7 = alloc(I, top, st, 4)
                if st[0]:
                    return
                f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, v_key)
                if st[0]:
                    return
                I[np.uint64(v_self + 2)] = t7
            else:
                t8 = I[np.uint64(v_self + 2)]
                if t8 < 0:
                    st[0] = 1
                    top[3] = 2000008
                    return
                t9 = t8
                top[1] += 1
                if top[1] > top[2]:
                    st[0] = 1
                    top[3] = 2000008
                    return
                f4_insert_borrowed(_heap_ctx, np.int64(t9), np.int64(v_key))
                if st[0]:
                    return
                top[1] -= 1
        else:
            t10 = I[np.uint64(v_self + 3)]
            if t10 >= 0:
                t11 = I[np.uint64(v_self + 3)]
                if t11 < 0:
                    st[0] = 1
                    top[3] = 2000011
                    return
                t12 = t11
                top[1] += 1
                if top[1] > top[2]:
                    st[0] = 1
                    top[3] = 2000011
                    return
                f4_insert_borrowed(_heap_ctx, np.int64(t12), np.int64(v_key))
                if st[0]:
                    return
                top[1] -= 1
            else:
                t13 = alloc(I, top, st, 4)
                if st[0]:
                    return
                f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t13, v_key)
                if st[0]:
                    return
                I[np.uint64(v_self + 3)] = t13
    return


@njit(cache=True, error_model="numpy")
def f6_total_borrowed(_heap_ctx, v_self):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 1)]
    t2 = I[np.uint64(v_self + 0)]
    t3 = mul_i(st, t1, t2)
    if st[0]:
        return 0
    v_result = t3
    t4 = I[np.uint64(v_self + 2)]
    if not t4 < 0:
        t5 = I[np.uint64(v_self + 2)]
        if t5 < 0:
            st[0] = 1
            top[3] = 3000004
            return 0
        t6 = t5
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000004
            return 0
        t7_0 = f6_total_borrowed(_heap_ctx, np.int64(t6))
        if st[0]:
            return 0
        top[1] -= 1
        t8 = add_i(st, v_result, t7_0)
        if st[0]:
            return 0
        v_result = t8
    t9 = I[np.uint64(v_self + 3)]
    if not t9 < 0:
        t10 = I[np.uint64(v_self + 3)]
        if t10 < 0:
            st[0] = 1
            top[3] = 3000006
            return 0
        t11 = t10
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000006
            return 0
        t12_0 = f6_total_borrowed(_heap_ctx, np.int64(t11))
        if st[0]:
            return 0
        top[1] -= 1
        t13 = add_i(st, v_result, t12_0)
        if st[0]:
            return 0
        v_result = t13
    return v_result
    return 0


@njit(cache=True, error_model="numpy")
def f8_depth_borrowed(_heap_ctx, v_self):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t2 = I[np.uint64(v_self + 2)]
    if t2 >= 0:
        t3 = I[np.uint64(v_self + 2)]
        if t3 < 0:
            st[0] = 1
            top[3] = 4000002
            return 0
        t4 = t3
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000002
            return 0
        t5_0 = f8_depth_borrowed(_heap_ctx, np.int64(t4))
        if st[0]:
            return 0
        top[1] -= 1
        t1_0 = t5_0
    else:
        t1_0 = 0
    v_left = t1_0
    t7 = I[np.uint64(v_self + 3)]
    if t7 >= 0:
        t8 = I[np.uint64(v_self + 3)]
        if t8 < 0:
            st[0] = 1
            top[3] = 4000003
            return 0
        t9 = t8
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000003
            return 0
        t10_0 = f8_depth_borrowed(_heap_ctx, np.int64(t9))
        if st[0]:
            return 0
        top[1] -= 1
        t6_0 = t10_0
    else:
        t6_0 = 0
    v_right = t6_0
    if v_left > v_right:
        t11_0 = v_left
    else:
        t11_0 = v_right
    t12 = add_i(st, 1, t11_0)
    if st[0]:
        return 0
    return t12
    return 0


@njit(cache=True, error_model="numpy")
def sr0_f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_key):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    v_sr0_I1 = v_key
    v_sr0_I2 = -1
    v_sr0_I3 = -1
    v_sr0_I0 = 1
    return (v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3)


@njit(cache=True, error_model="numpy")
def sr1_f4_insert_borrowed(_heap_ctx, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_key):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_I1
    if v_key == t1:
        pass
        t3 = v_sr0_I0
        t4 = add_i(st, t3, 1)
        if st[0]:
            return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
        v_sr0_I0 = t4
    else:
        t5 = v_sr0_I1
        if v_key < t5:
            t6 = v_sr0_I2
            if t6 < 0:
                t7 = alloc(I, top, st, 4)
                if st[0]:
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, v_key)
                if st[0]:
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                v_sr0_I2 = t7
            else:
                t8 = v_sr0_I2
                if t8 < 0:
                    st[0] = 1
                    top[3] = 2000008
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                t9 = t8
                top[1] += 1
                if top[1] > top[2]:
                    st[0] = 1
                    top[3] = 2000008
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                f4_insert_borrowed(_heap_ctx, np.int64(t9), np.int64(v_key))
                if st[0]:
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                top[1] -= 1
        else:
            t10 = v_sr0_I3
            if t10 >= 0:
                t11 = v_sr0_I3
                if t11 < 0:
                    st[0] = 1
                    top[3] = 2000011
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                t12 = t11
                top[1] += 1
                if top[1] > top[2]:
                    st[0] = 1
                    top[3] = 2000011
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                f4_insert_borrowed(_heap_ctx, np.int64(t12), np.int64(v_key))
                if st[0]:
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                top[1] -= 1
            else:
                t13 = alloc(I, top, st, 4)
                if st[0]:
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t13, v_key)
                if st[0]:
                    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)
                v_sr0_I3 = t13
    return (v_sr0_I0, v_sr0_I2, v_sr0_I3)


@njit(cache=True, error_model="numpy")
def sr2_f6_total_borrowed(_heap_ctx, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_I1
    t2 = v_sr0_I0
    t3 = mul_i(st, t1, t2)
    if st[0]:
        return 0
    v_result = t3
    t4 = v_sr0_I2
    if not t4 < 0:
        t5 = v_sr0_I2
        if t5 < 0:
            st[0] = 1
            top[3] = 3000004
            return 0
        t6 = t5
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000004
            return 0
        t7_0 = f6_total_borrowed(_heap_ctx, np.int64(t6))
        if st[0]:
            return 0
        top[1] -= 1
        t8 = add_i(st, v_result, t7_0)
        if st[0]:
            return 0
        v_result = t8
    t9 = v_sr0_I3
    if not t9 < 0:
        t10 = v_sr0_I3
        if t10 < 0:
            st[0] = 1
            top[3] = 3000006
            return 0
        t11 = t10
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000006
            return 0
        t12_0 = f6_total_borrowed(_heap_ctx, np.int64(t11))
        if st[0]:
            return 0
        top[1] -= 1
        t13 = add_i(st, v_result, t12_0)
        if st[0]:
            return 0
        v_result = t13
    return v_result
    return 0


@njit(cache=True, error_model="numpy")
def sr3_f8_depth_borrowed(_heap_ctx, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t2 = v_sr0_I2
    if t2 >= 0:
        t3 = v_sr0_I2
        if t3 < 0:
            st[0] = 1
            top[3] = 4000002
            return 0
        t4 = t3
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000002
            return 0
        t5_0 = f8_depth_borrowed(_heap_ctx, np.int64(t4))
        if st[0]:
            return 0
        top[1] -= 1
        t1_0 = t5_0
    else:
        t1_0 = 0
    v_left = t1_0
    t7 = v_sr0_I3
    if t7 >= 0:
        t8 = v_sr0_I3
        if t8 < 0:
            st[0] = 1
            top[3] = 4000003
            return 0
        t9 = t8
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000003
            return 0
        t10_0 = f8_depth_borrowed(_heap_ctx, np.int64(t9))
        if st[0]:
            return 0
        top[1] -= 1
        t6_0 = t10_0
    else:
        t6_0 = 0
    v_right = t6_0
    if v_left > v_right:
        t11_0 = v_left
    else:
        t11_0 = v_right
    t12 = add_i(st, 1, t11_0)
    if st[0]:
        return 0
    return t12
    return 0


@njit(cache=True, error_model="numpy")
def f0_build_tree(F, I, top, st, v_keys):
    if (F.ndim != 1 or I.ndim != 1 or top.ndim != 1 or st.ndim != 1
            or len(F) != len(I) or len(top) != 4 or len(st) != 1
            or F.strides[0] != 8 or I.strides[0] != 8
            or top.strides[0] != 8 or st.strides[0] != 1):
        raise ValueError("invalid heap context")
    _heap_F = _heap_data(F)
    _heap_I = _heap_data(I)
    _heap_top = _heap_data(top)
    _heap_st = _heap_data(st)
    _heap_len = np.int64(len(F))
    _heap_ctx = _heap_context_pack(_heap_F, _heap_I, _heap_top, _heap_st, _heap_len)
    return f0_build_tree_borrowed(_heap_ctx, v_keys)

