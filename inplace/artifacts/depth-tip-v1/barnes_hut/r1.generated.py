import math

import numpy as np
from numba import njit


@njit(error_model="numpy", inline="always")
def alloc(I, top, st, slots):
    start = top[0]
    if start + slots > len(I):
        st[0] = 2
        return 0
    top[0] = start + slots
    return start


@njit(error_model="numpy", inline="always")
def list_new(I, top, st, length, capacity):
    data = alloc(I, top, st, capacity)
    h = alloc(I, top, st, 3)
    if st[0]:
        return 0
    I[h] = length
    I[h + 1] = capacity
    I[h + 2] = data
    return h


@njit(error_model="numpy", inline="always")
def list_fill(I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        I[data + k] = value
    return h


@njit(error_model="numpy", inline="always")
def list_fill_f(F, I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        F[data + k] = value
    return h


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
def add_i(st, a, b):
    r = a + b
    if ((a ^ r) & (b ^ r)) < 0:
        st[0] = 1
    return r


@njit(error_model="numpy", inline="always")
def sub_i(st, a, b):
    r = a - b
    if ((a ^ b) & (a ^ r)) < 0:
        st[0] = 1
    return r


@njit(error_model="numpy", inline="always")
def mul_i(st, a, b):
    estimate = float(a) * float(b)
    if estimate >= 9.2e18 or estimate <= -9.2e18:
        st[0] = 1
        return 0
    return a * b


@njit(error_model="numpy", inline="always")
def floordiv_i(st, a, b):
    if b == 0 or (b == -1 and a == -a and a != 0):
        st[0] = 1
        return 0
    return a // b


@njit(error_model="numpy", inline="always")
def mod_i(st, a, b):
    if b == 0 or b == -1:
        if b == 0:
            st[0] = 1
        return 0
    return a % b



@njit(error_model="numpy", inline="always")
def str_new(I, top, st, n):
    h = alloc(I, top, st, n + 2)
    if st[0]:
        return 0
    I[h] = n
    I[h + 1] = 0
    return h


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
def str_char(I, top, st, cp):
    out = str_new(I, top, st, 1)
    if st[0]:
        return 0
    I[out + 2] = cp
    return out


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
def str_starts(I, h, part, at):
    m = I[part]
    if at < 0 or at + m > I[h]:
        return False
    for j in range(m):
        if I[h + 2 + at + j] != I[part + 2 + j]:
            return False
    return True


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
def str_space(cp):
    # Whitespace as str.isspace() has it, for code points below 128; -1 above.
    if cp >= 128:
        return -1
    return 1 if cp == 32 or 9 <= cp <= 13 or 28 <= cp <= 31 else 0


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
def mix_i(x):
    x = (x ^ (x >> 31)) * np.int64(-7046029254386353131)
    return x ^ (x >> 29)


@njit(error_model="numpy", inline="always")
def mix_t(acc, x):
    return (acc ^ x) * np.int64(1000003) + np.int64(97531)


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
def set_pristine(I, h):
    return I[h + 8] == 0 and (I[h + 7] < 0 or I[I[h + 7]] == 0)


@njit(error_model="numpy", inline="always")
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


@njit(error_model="numpy", inline="always")
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

@njit(error_model="numpy")
def f0_advance_system_borrowed(_heap_ctx, v_particles, v_theta, v_time_step, v_width, v_height):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if not (v_height < -9007199254740992 or v_height > 9007199254740992 or v_width < -9007199254740992 or (v_width > 9007199254740992)):
        _kf_f0_advance_system_borrowed(_heap_ctx, v_particles, v_theta, v_time_step, v_width, v_height)
        return
    else:
        t1 = v_width
        if t1 > 9007199254740992 or t1 < -9007199254740992:
            st[0] = 1
            top[3] = 4
            return
        t2 = 2.0
        if t2 == 0.0:
            st[0] = 1
            top[3] = 4
            return
        t3 = v_height
        if t3 > 9007199254740992 or t3 < -9007199254740992:
            st[0] = 1
            top[3] = 4
            return
        t4 = 2.0
        if t4 == 0.0:
            st[0] = 1
            top[3] = 4
            return
        t5 = v_width
        if t5 > 9007199254740992 or t5 < -9007199254740992:
            st[0] = 1
            top[3] = 4
            return
        t6 = 2.0
        if t6 == 0.0:
            st[0] = 1
            top[3] = 4
            return
        t7 = v_height
        if t7 > 9007199254740992 or t7 < -9007199254740992:
            st[0] = 1
            top[3] = 4
            return
        t8 = 2.0
        if t8 == 0.0:
            st[0] = 1
            top[3] = 4
            return
        t9 = alloc(I, top, st, 4)
        if st[0]:
            return
        f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t9, float(t1) / t2, float(t3) / t4, float(t5) / t6, float(t7) / t8)
        if st[0]:
            return
        v_boundary = t9
        _sr_t10_F9 = 0.0
        _sr_t10_I0 = np.int64(0)
        _sr_t10_I1 = np.int64(0)
        _sr_t10_I2 = np.int64(0)
        _sr_t10_I3 = np.int64(0)
        _sr_t10_I4 = np.int64(0)
        _sr_t10_I5 = np.int64(0)
        _sr_t10_I6 = np.int64(0)
        _sr_t10_I7 = np.int64(0)
        _sr_t10_I8 = np.int64(0)
        _sr_t10_I10 = np.int64(0)
        if st[0]:
            return
        _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10 = sr0_f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10, v_boundary, 4)
        if st[0]:
            return
        pass
        t11 = v_particles
        t12 = 0
        while True:
            if t12 >= I[np.uint64(t11)]:
                break
            t13 = I[np.uint64(I[np.uint64(t11 + 2)] + t12)]
            t12 += 1
            v_particle = t13
            if False:
                st[0] = 1
                top[3] = 9
                return
            pass
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 9
                return
            t15_0, _sr_t10_F9, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10 = sr1_f23_insert_borrowed(_heap_ctx, _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10, np.int64(v_particle))
            if st[0]:
                return
            top[1] -= 1
        t16 = v_particles
        t17 = 0
        while True:
            if t17 >= I[np.uint64(t16)]:
                break
            t18 = I[np.uint64(I[np.uint64(t16 + 2)] + t17)]
            t17 += 1
            v_particle = t18
            if False:
                st[0] = 1
                top[3] = 13
                return
            pass
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 13
                return
            t20_0, t20_1, t20_2, t20_3 = sr4_f24_calculate_force_borrowed(_heap_ctx, _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10, np.int64(v_particle), np.float64(v_theta))
            if st[0]:
                return
            top[1] -= 1
            v_fx_0 = t20_0
            v_fx_1 = t20_1
            v_fy_0 = t20_2
            v_fy_1 = t20_3
            if v_particle < 0:
                st[0] = 1
                top[3] = 14
                return
            t21 = v_particle
            f21_apply_force_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t21, v_fx_0, v_fx_1, v_fy_0, v_fy_1)
            if st[0]:
                return
        t22 = v_particles
        t23 = 0
        while True:
            if t23 >= I[np.uint64(t22)]:
                break
            t24 = I[np.uint64(I[np.uint64(t22 + 2)] + t23)]
            t23 += 1
            v_particle = t24
            if v_particle < 0:
                st[0] = 1
                top[3] = 18
                return
            t25 = v_particle
            f12_update_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t25, v_time_step)
            if st[0]:
                return
        return


@njit(error_model="numpy", inline="always")
def f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_x, v_y, v_w, v_h):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if v_self < 0:
        st[0] = 1
        top[3] = 1000002
        return
    F[np.uint64(v_self + 2)] = v_x
    if v_self < 0:
        st[0] = 1
        top[3] = 1000003
        return
    F[np.uint64(v_self + 3)] = v_y
    if v_self < 0:
        st[0] = 1
        top[3] = 1000004
        return
    F[np.uint64(v_self + 1)] = v_w
    if v_self < 0:
        st[0] = 1
        top[3] = 1000005
        return
    F[np.uint64(v_self + 0)] = v_h
    return


@njit(error_model="numpy", inline="always")
def f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_boundary, v_capacity):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    I[np.uint64(v_self + 0)] = v_boundary
    I[np.uint64(v_self + 1)] = v_capacity
    t1 = list_new(I, top, st, 0, 0)
    if st[0]:
        return
    I[np.uint64(v_self + 6)] = t1
    I[np.uint64(v_self + 3)] = False
    t2 = alloc(I, top, st, 4)
    if st[0]:
        return
    f14___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, 0, 0)
    if st[0]:
        return
    I[np.uint64(v_self + 2)] = t2
    F[np.uint64(v_self + 9)] = 0.0
    I[np.uint64(v_self + 9 + 1)] = True
    I[np.uint64(v_self + 4)] = -1
    I[np.uint64(v_self + 5)] = -1
    I[np.uint64(v_self + 7)] = -1
    I[np.uint64(v_self + 8)] = -1
    return


@njit(error_model="numpy", inline="always")
def f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_particle):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(v_self), np.int64(v_particle), np.int64(-1))[0]


@njit(error_model="numpy")
def f24_calculate_force_borrowed(_heap_ctx, v_self, v_particle, v_theta):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 9)]
    t2 = I[np.uint64(v_self + 9 + 1)] != 0
    if t1 == 0.0:
        t3 = 0
        t4 = 0
        t5 = t3
        t6 = t4
        return (float(t5), True, float(t6), True)
    t7 = I[np.uint64(v_self + 6)]
    t8 = I[np.uint64(t7)]
    t9 = t8 == 1
    if t9:
        t10 = I[np.uint64(v_self + 6)]
        t11 = I[np.uint64(t10)]
        t12 = 0
        if t12 < 0:
            t12 += t11
        if t12 < 0 or t12 >= t11:
            st[0] = 1
            top[3] = 4000006
            return (0.0, False, 0.0, False)
        t13 = I[np.uint64(t10 + 2)] + t12
        t14 = I[np.uint64(t13)]
        t9 = t14 == v_particle
    if t9:
        t15 = 0
        t16 = 0
        t17 = t15
        t18 = t16
        return (float(t17), True, float(t18), True)
    t19 = I[np.uint64(v_self + 2)]
    if t19 < 0:
        st[0] = 1
        top[3] = 4000010
        return (0.0, False, 0.0, False)
    t20 = F[np.uint64(t19 + 0)]
    t21 = I[np.uint64(t19 + 0 + 1)] != 0
    if v_particle < 0:
        st[0] = 1
        top[3] = 4000010
        return (0.0, False, 0.0, False)
    t22 = I[np.uint64(v_particle + 2)]
    if t22 < 0:
        st[0] = 1
        top[3] = 4000010
        return (0.0, False, 0.0, False)
    t23 = F[np.uint64(t22 + 0)]
    t24 = I[np.uint64(t22 + 0 + 1)] != 0
    t25 = t20 - t23
    t26 = t21 and t24
    if t26:
        if t25 >= 9007199254740992.0 or t25 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000010
            return (0.0, False, 0.0, False)
        t25 += 0.0
    v_dx_0 = t25
    v_dx_1 = t26
    t27 = I[np.uint64(v_self + 2)]
    if t27 < 0:
        st[0] = 1
        top[3] = 4000011
        return (0.0, False, 0.0, False)
    t28 = F[np.uint64(t27 + 2)]
    t29 = I[np.uint64(t27 + 2 + 1)] != 0
    if v_particle < 0:
        st[0] = 1
        top[3] = 4000011
        return (0.0, False, 0.0, False)
    t30 = I[np.uint64(v_particle + 2)]
    if t30 < 0:
        st[0] = 1
        top[3] = 4000011
        return (0.0, False, 0.0, False)
    t31 = F[np.uint64(t30 + 2)]
    t32 = I[np.uint64(t30 + 2 + 1)] != 0
    t33 = t28 - t31
    t34 = t29 and t32
    if t34:
        if t33 >= 9007199254740992.0 or t33 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000011
            return (0.0, False, 0.0, False)
        t33 += 0.0
    v_dy_0 = t33
    v_dy_1 = t34
    t35 = v_dx_0 * v_dx_0
    t36 = v_dx_1 and v_dx_1
    if t36:
        if t35 >= 9007199254740992.0 or t35 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t35 += 0.0
    t37 = v_dy_0 * v_dy_0
    t38 = v_dy_1 and v_dy_1
    if t38:
        if t37 >= 9007199254740992.0 or t37 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t37 += 0.0
    t39 = t35 + t37
    t40 = t36 and t38
    if t40:
        if t39 >= 9007199254740992.0 or t39 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t39 += 0.0
    t41 = t39
    if t41 < 0.0:
        st[0] = 1
        top[3] = 4000012
        return (0.0, False, 0.0, False)
    t42 = math.sqrt(t41)
    v_distance = t42
    t43 = I[np.uint64(v_self + 3)] != 0
    t44 = not t43
    if not t44:
        t45 = I[np.uint64(v_self + 0)]
        if t45 < 0:
            st[0] = 1
            top[3] = 4000015
            return (0.0, False, 0.0, False)
        t46 = F[np.uint64(t45 + 1)]
        t47 = v_distance
        if t47 == 0.0:
            st[0] = 1
            top[3] = 4000015
            return (0.0, False, 0.0, False)
        t44 = t46 * 2.0 / t47 < v_theta
    if t44:
        if v_distance < 5.0:
            v_distance = 5.0
        if v_particle < 0:
            st[0] = 1
            top[3] = 4000021
            return (0.0, False, 0.0, False)
        t48 = F[np.uint64(v_particle + 1)]
        t49 = F[np.uint64(v_self + 9)]
        t50 = I[np.uint64(v_self + 9 + 1)] != 0
        t51 = v_distance * v_distance
        if t51 == 0.0:
            st[0] = 1
            top[3] = 4000021
            return (0.0, False, 0.0, False)
        v_f = 6.6743e-11 * t48 * t49 / t51
        t52 = v_distance
        if t52 == 0.0:
            st[0] = 1
            top[3] = 4000024
            return (0.0, False, 0.0, False)
        v_fx_0 = v_f * v_dx_0 / t52
        v_fx_1 = False
        t53 = v_distance
        if t53 == 0.0:
            st[0] = 1
            top[3] = 4000025
            return (0.0, False, 0.0, False)
        v_fy_0 = v_f * v_dy_0 / t53
        v_fy_1 = False
        t54 = v_fx_0
        t55 = v_fx_1
        t56 = v_fy_0
        t57 = v_fy_1
        return (t54, t55, t56, t57)
    t58 = 0
    t59 = 0
    t60 = t58
    v_fx_0 = float(t60)
    v_fx_1 = True
    t61 = t59
    v_fy_0 = float(t61)
    v_fy_1 = True
    t62 = I[np.uint64(v_self + 4)]
    if t62 >= 0:
        t63 = I[np.uint64(v_self + 4)]
        if t63 < 0:
            st[0] = 1
            top[3] = 4000033
            return (0.0, False, 0.0, False)
        t64 = t63
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000033
            return (0.0, False, 0.0, False)
        t65_0, t65_1, t65_2, t65_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t64), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_ne_0 = t65_0
        v_fx_ne_1 = t65_1
        v_fy_ne_0 = t65_2
        v_fy_ne_1 = t65_3
        t66 = v_fx_0 + v_fx_ne_0
        t67 = v_fx_1 and v_fx_ne_1
        v_fx_0 = t66
        v_fx_1 = t67
        t68 = v_fy_0 + v_fy_ne_0
        t69 = v_fy_1 and v_fy_ne_1
        v_fy_0 = t68
        v_fy_1 = t69
    t70 = I[np.uint64(v_self + 5)]
    if t70 >= 0:
        t71 = I[np.uint64(v_self + 5)]
        if t71 < 0:
            st[0] = 1
            top[3] = 4000038
            return (0.0, False, 0.0, False)
        t72 = t71
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000038
            return (0.0, False, 0.0, False)
        t73_0, t73_1, t73_2, t73_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t72), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_nw_0 = t73_0
        v_fx_nw_1 = t73_1
        v_fy_nw_0 = t73_2
        v_fy_nw_1 = t73_3
        t74 = v_fx_0 + v_fx_nw_0
        t75 = v_fx_1 and v_fx_nw_1
        v_fx_0 = t74
        v_fx_1 = t75
        t76 = v_fy_0 + v_fy_nw_0
        t77 = v_fy_1 and v_fy_nw_1
        v_fy_0 = t76
        v_fy_1 = t77
    t78 = I[np.uint64(v_self + 7)]
    if t78 >= 0:
        t79 = I[np.uint64(v_self + 7)]
        if t79 < 0:
            st[0] = 1
            top[3] = 4000043
            return (0.0, False, 0.0, False)
        t80 = t79
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000043
            return (0.0, False, 0.0, False)
        t81_0, t81_1, t81_2, t81_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t80), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_se_0 = t81_0
        v_fx_se_1 = t81_1
        v_fy_se_0 = t81_2
        v_fy_se_1 = t81_3
        t82 = v_fx_0 + v_fx_se_0
        t83 = v_fx_1 and v_fx_se_1
        v_fx_0 = t82
        v_fx_1 = t83
        t84 = v_fy_0 + v_fy_se_0
        t85 = v_fy_1 and v_fy_se_1
        v_fy_0 = t84
        v_fy_1 = t85
    t86 = I[np.uint64(v_self + 8)]
    if t86 >= 0:
        t87 = I[np.uint64(v_self + 8)]
        if t87 < 0:
            st[0] = 1
            top[3] = 4000048
            return (0.0, False, 0.0, False)
        t88 = t87
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000048
            return (0.0, False, 0.0, False)
        t89_0, t89_1, t89_2, t89_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t88), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_sw_0 = t89_0
        v_fx_sw_1 = t89_1
        v_fy_sw_0 = t89_2
        v_fy_sw_1 = t89_3
        t90 = v_fx_0 + v_fx_sw_0
        t91 = v_fx_1 and v_fx_sw_1
        v_fx_0 = t90
        v_fx_1 = t91
        t92 = v_fy_0 + v_fy_sw_0
        t93 = v_fy_1 and v_fy_sw_1
        v_fy_0 = t92
        v_fy_1 = t93
    t94 = v_fx_0
    t95 = v_fx_1
    t96 = v_fy_0
    t97 = v_fy_1
    return (t94, t95, t96, t97)
    return (0.0, False, 0.0, False)


@njit(error_model="numpy", inline="always")
def f21_apply_force_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_fx_0, v_fx_1, v_fy_0, v_fy_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if not (v_fx_1 or v_fy_1):
        _kf_f21_apply_force_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_fx_0, v_fx_1, v_fy_0, v_fy_1)
        return
    else:
        if v_self < 0:
            st[0] = 1
            top[3] = 5000003
            return
        t1 = I[np.uint64(v_self + 0)]
        if t1 < 0:
            st[0] = 1
            top[3] = 5000003
            return
        t2 = t1
        t3 = F[np.uint64(t2 + 0)]
        t4 = I[np.uint64(t2 + 0 + 1)] != 0
        if v_self < 0:
            st[0] = 1
            top[3] = 5000003
            return
        t5 = F[np.uint64(v_self + 1)]
        t6 = t5
        if t6 == 0.0:
            st[0] = 1
            top[3] = 5000003
            return
        F[np.uint64(t2 + 0)] = t3 + v_fx_0 / t6
        I[np.uint64(t2 + 0 + 1)] = False
        if v_self < 0:
            st[0] = 1
            top[3] = 5000004
            return
        t7 = I[np.uint64(v_self + 0)]
        if t7 < 0:
            st[0] = 1
            top[3] = 5000004
            return
        t8 = t7
        t9 = F[np.uint64(t8 + 2)]
        t10 = I[np.uint64(t8 + 2 + 1)] != 0
        if v_self < 0:
            st[0] = 1
            top[3] = 5000004
            return
        t11 = F[np.uint64(v_self + 1)]
        t12 = t11
        if t12 == 0.0:
            st[0] = 1
            top[3] = 5000004
            return
        F[np.uint64(t8 + 2)] = t9 + v_fy_0 / t12
        I[np.uint64(t8 + 2 + 1)] = False
        return


@njit(error_model="numpy", inline="always")
def f12_update_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_time_step):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if v_self < 0:
        st[0] = 1
        top[3] = 6000003
        return
    t1 = I[np.uint64(v_self + 3)]
    if t1 < 0:
        st[0] = 1
        top[3] = 6000003
        return
    t2 = t1
    t3 = F[np.uint64(t2 + 0)]
    t4 = I[np.uint64(t2 + 0 + 1)] != 0
    if v_self < 0:
        st[0] = 1
        top[3] = 6000003
        return
    t5 = I[np.uint64(v_self + 0)]
    if t5 < 0:
        st[0] = 1
        top[3] = 6000003
        return
    t6 = F[np.uint64(t5 + 0)]
    t7 = I[np.uint64(t5 + 0 + 1)] != 0
    F[np.uint64(t2 + 0)] = t3 + t6 * v_time_step
    I[np.uint64(t2 + 0 + 1)] = False
    if v_self < 0:
        st[0] = 1
        top[3] = 6000004
        return
    t8 = I[np.uint64(v_self + 3)]
    if t8 < 0:
        st[0] = 1
        top[3] = 6000004
        return
    t9 = t8
    t10 = F[np.uint64(t9 + 2)]
    t11 = I[np.uint64(t9 + 2 + 1)] != 0
    if v_self < 0:
        st[0] = 1
        top[3] = 6000004
        return
    t12 = I[np.uint64(v_self + 0)]
    if t12 < 0:
        st[0] = 1
        top[3] = 6000004
        return
    t13 = F[np.uint64(t12 + 2)]
    t14 = I[np.uint64(t12 + 2 + 1)] != 0
    F[np.uint64(t9 + 2)] = t10 + t13 * v_time_step
    I[np.uint64(t9 + 2 + 1)] = False
    if v_self < 0:
        st[0] = 1
        top[3] = 6000007
        return
    t15 = I[np.uint64(v_self + 2)]
    if t15 < 0:
        st[0] = 1
        top[3] = 6000007
        return
    t16 = t15
    t17 = F[np.uint64(t16 + 0)]
    t18 = I[np.uint64(t16 + 0 + 1)] != 0
    if v_self < 0:
        st[0] = 1
        top[3] = 6000007
        return
    t19 = I[np.uint64(v_self + 3)]
    if t19 < 0:
        st[0] = 1
        top[3] = 6000007
        return
    t20 = F[np.uint64(t19 + 0)]
    t21 = I[np.uint64(t19 + 0 + 1)] != 0
    F[np.uint64(t16 + 0)] = t17 + t20 * v_time_step
    I[np.uint64(t16 + 0 + 1)] = False
    if v_self < 0:
        st[0] = 1
        top[3] = 6000008
        return
    t22 = I[np.uint64(v_self + 2)]
    if t22 < 0:
        st[0] = 1
        top[3] = 6000008
        return
    t23 = t22
    t24 = F[np.uint64(t23 + 2)]
    t25 = I[np.uint64(t23 + 2 + 1)] != 0
    if v_self < 0:
        st[0] = 1
        top[3] = 6000008
        return
    t26 = I[np.uint64(v_self + 3)]
    if t26 < 0:
        st[0] = 1
        top[3] = 6000008
        return
    t27 = F[np.uint64(t26 + 2)]
    t28 = I[np.uint64(t26 + 2 + 1)] != 0
    F[np.uint64(t23 + 2)] = t24 + t27 * v_time_step
    I[np.uint64(t23 + 2 + 1)] = False
    if v_self < 0:
        st[0] = 1
        top[3] = 6000011
        return
    t29 = I[np.uint64(v_self + 0)]
    if t29 < 0:
        st[0] = 1
        top[3] = 6000011
        return
    F[np.uint64(t29 + 0)] = 0.0
    I[np.uint64(t29 + 0 + 1)] = True
    if v_self < 0:
        st[0] = 1
        top[3] = 6000012
        return
    t30 = I[np.uint64(v_self + 0)]
    if t30 < 0:
        st[0] = 1
        top[3] = 6000012
        return
    F[np.uint64(t30 + 2)] = 0.0
    I[np.uint64(t30 + 2 + 1)] = True
    return


@njit(error_model="numpy", inline="always")
def f14___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_x, v_y):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if v_self < 0:
        st[0] = 1
        top[3] = 7000002
        return
    t1 = v_x
    if t1 > 9007199254740992 or t1 < -9007199254740992:
        st[0] = 1
        top[3] = 7000002
        return
    F[np.uint64(v_self + 0)] = float(t1)
    I[np.uint64(v_self + 0 + 1)] = True
    if v_self < 0:
        st[0] = 1
        top[3] = 7000003
        return
    t2 = v_y
    if t2 > 9007199254740992 or t2 < -9007199254740992:
        st[0] = 1
        top[3] = 7000003
        return
    F[np.uint64(v_self + 2)] = float(t2)
    I[np.uint64(v_self + 2 + 1)] = True
    return


@njit(error_model="numpy", inline="always")
def f25_contains_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_point):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if v_point < 0:
        st[0] = 1
        top[3] = 8000002
        return False
    t1 = F[np.uint64(v_point + 0)]
    t2 = I[np.uint64(v_point + 0 + 1)] != 0
    t3 = F[np.uint64(v_self + 2)]
    t4 = F[np.uint64(v_self + 1)]
    t5 = t1 >= t3 - t4
    if t5:
        if v_point < 0:
            st[0] = 1
            top[3] = 8000002
            return False
        t6 = F[np.uint64(v_point + 0)]
        t7 = I[np.uint64(v_point + 0 + 1)] != 0
        t8 = F[np.uint64(v_self + 2)]
        t9 = F[np.uint64(v_self + 1)]
        t5 = t6 < t8 + t9
    if t5:
        if v_point < 0:
            st[0] = 1
            top[3] = 8000002
            return False
        t10 = F[np.uint64(v_point + 2)]
        t11 = I[np.uint64(v_point + 2 + 1)] != 0
        t12 = F[np.uint64(v_self + 3)]
        t13 = F[np.uint64(v_self + 0)]
        t5 = t10 >= t12 - t13
    if t5:
        if v_point < 0:
            st[0] = 1
            top[3] = 8000002
            return False
        t14 = F[np.uint64(v_point + 2)]
        t15 = I[np.uint64(v_point + 2 + 1)] != 0
        t16 = F[np.uint64(v_self + 3)]
        t17 = F[np.uint64(v_self + 0)]
        t5 = t14 < t16 + t17
    return t5
    return False


@njit(error_model="numpy", inline="always")
def f26_update_mass_distribution_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_particle):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 9)]
    t2 = I[np.uint64(v_self + 9 + 1)] != 0
    if v_particle < 0:
        st[0] = 1
        top[3] = 9000003
        return
    t3 = F[np.uint64(v_particle + 1)]
    v_total_mass_new = t1 + t3
    if v_total_mass_new > 0.0:
        t4 = I[np.uint64(v_self + 2)]
        if t4 < 0:
            st[0] = 1
            top[3] = 9000007
            return
        t5 = F[np.uint64(t4 + 0)]
        t6 = I[np.uint64(t4 + 0 + 1)] != 0
        t7 = F[np.uint64(v_self + 9)]
        t8 = I[np.uint64(v_self + 9 + 1)] != 0
        t9 = t5 * t7
        t10 = t6 and t8
        if t10:
            if t9 >= 9007199254740992.0 or t9 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 9000007
                return
            t9 += 0.0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000007
            return
        t11 = I[np.uint64(v_particle + 2)]
        if t11 < 0:
            st[0] = 1
            top[3] = 9000007
            return
        t12 = F[np.uint64(t11 + 0)]
        t13 = I[np.uint64(t11 + 0 + 1)] != 0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000007
            return
        t14 = F[np.uint64(v_particle + 1)]
        t15 = v_total_mass_new
        if t15 == 0.0:
            st[0] = 1
            top[3] = 9000007
            return
        t16 = I[np.uint64(v_self + 2)]
        if t16 < 0:
            st[0] = 1
            top[3] = 9000007
            return
        F[np.uint64(t16 + 0)] = (t9 + t12 * t14) / t15
        I[np.uint64(t16 + 0 + 1)] = False
        t17 = I[np.uint64(v_self + 2)]
        if t17 < 0:
            st[0] = 1
            top[3] = 9000009
            return
        t18 = F[np.uint64(t17 + 2)]
        t19 = I[np.uint64(t17 + 2 + 1)] != 0
        t20 = F[np.uint64(v_self + 9)]
        t21 = I[np.uint64(v_self + 9 + 1)] != 0
        t22 = t18 * t20
        t23 = t19 and t21
        if t23:
            if t22 >= 9007199254740992.0 or t22 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 9000009
                return
            t22 += 0.0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000009
            return
        t24 = I[np.uint64(v_particle + 2)]
        if t24 < 0:
            st[0] = 1
            top[3] = 9000009
            return
        t25 = F[np.uint64(t24 + 2)]
        t26 = I[np.uint64(t24 + 2 + 1)] != 0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000009
            return
        t27 = F[np.uint64(v_particle + 1)]
        t28 = v_total_mass_new
        if t28 == 0.0:
            st[0] = 1
            top[3] = 9000009
            return
        t29 = I[np.uint64(v_self + 2)]
        if t29 < 0:
            st[0] = 1
            top[3] = 9000009
            return
        F[np.uint64(t29 + 2)] = (t22 + t25 * t27) / t28
        I[np.uint64(t29 + 2 + 1)] = False
    F[np.uint64(v_self + 9)] = v_total_mass_new
    I[np.uint64(v_self + 9 + 1)] = False
    return


@njit(error_model="numpy", inline="always")
def f20_subdivide_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    s0_f23_insert_borrowed(_heap_ctx, np.int64(1), np.int64(-1), np.int64(-1), np.int64(v_self))
    return


@njit(error_model="numpy", inline="always")
def sr0_f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_boundary, v_capacity):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    v_sr0_I0 = v_boundary
    v_sr0_I1 = v_capacity
    t1 = list_new(I, top, st, 0, 0)
    if st[0]:
        return (v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    v_sr0_I6 = t1
    v_sr0_I3 = False
    t2 = alloc(I, top, st, 4)
    if st[0]:
        return (v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    f14___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, 0, 0)
    if st[0]:
        return (v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    v_sr0_I2 = t2
    v_sr0_F9 = 0.0
    v_sr0_I10 = True
    v_sr0_I4 = -1
    v_sr0_I5 = -1
    v_sr0_I7 = -1
    v_sr0_I8 = -1
    return (v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)


@njit(error_model="numpy")
def sr1_f23_insert_borrowed(_heap_ctx, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_particle):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_I0
    if t1 < 0:
        st[0] = 1
        top[3] = 3000002
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t2 = t1
    if v_particle < 0:
        st[0] = 1
        top[3] = 3000002
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t3 = I[np.uint64(v_particle + 2)]
    t4_0 = f25_contains_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, t3)
    if st[0]:
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    if not t4_0:
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t5 = v_sr0_I6
    t6 = I[np.uint64(t5)]
    t7 = v_sr0_I1
    t8 = t6 < t7
    if t8:
        t9 = v_sr0_I3 != 0
        t8 = not t9
    if t8:
        t10 = v_sr0_I6
        t11 = list_room(I, top, st, t10)
        if st[0]:
            return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
        I[t11] = v_particle
        pass
        v_sr0_F9, v_sr0_I10 = sr2_f26_update_mass_distribution_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_particle)
        if st[0]:
            return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
        return (True, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t13 = v_sr0_I3 != 0
    if not t13:
        pass
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000011
            return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
        v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8 = sr3_f20_subdivide_borrowed(_heap_ctx, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
        if st[0]:
            return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
        top[1] -= 1
    t15 = v_sr0_I4
    if t15 < 0:
        st[0] = 1
        top[3] = 3000013
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t16 = t15
    top[1] += 1
    if top[1] > top[2]:
        st[0] = 1
        top[3] = 3000013
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t17_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t16), np.int64(v_particle))
    if st[0]:
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    top[1] -= 1
    if t17_0:
        return (True, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t18 = v_sr0_I5
    if t18 < 0:
        st[0] = 1
        top[3] = 3000014
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t19 = t18
    top[1] += 1
    if top[1] > top[2]:
        st[0] = 1
        top[3] = 3000014
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t20_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t19), np.int64(v_particle))
    if st[0]:
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    top[1] -= 1
    if t20_0:
        return (True, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t21 = v_sr0_I7
    if t21 < 0:
        st[0] = 1
        top[3] = 3000015
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t22 = t21
    top[1] += 1
    if top[1] > top[2]:
        st[0] = 1
        top[3] = 3000015
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t23_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t22), np.int64(v_particle))
    if st[0]:
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    top[1] -= 1
    if t23_0:
        return (True, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t24 = v_sr0_I8
    if t24 < 0:
        st[0] = 1
        top[3] = 3000016
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t25 = t24
    top[1] += 1
    if top[1] > top[2]:
        st[0] = 1
        top[3] = 3000016
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    t26_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t25), np.int64(v_particle))
    if st[0]:
        return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    top[1] -= 1
    if t26_0:
        return (True, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)
    return (False, v_sr0_F9, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10)


@njit(error_model="numpy", inline="always")
def sr2_f26_update_mass_distribution_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_particle):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_F9
    t2 = v_sr0_I10 != 0
    if v_particle < 0:
        st[0] = 1
        top[3] = 9000003
        return (v_sr0_F9, v_sr0_I10)
    t3 = F[np.uint64(v_particle + 1)]
    v_total_mass_new = t1 + t3
    if v_total_mass_new > 0.0:
        t4 = v_sr0_I2
        if t4 < 0:
            st[0] = 1
            top[3] = 9000007
            return (v_sr0_F9, v_sr0_I10)
        t5 = F[np.uint64(t4 + 0)]
        t6 = I[np.uint64(t4 + 0 + 1)] != 0
        t7 = v_sr0_F9
        t8 = v_sr0_I10 != 0
        t9 = t5 * t7
        t10 = t6 and t8
        if t10:
            if t9 >= 9007199254740992.0 or t9 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 9000007
                return (v_sr0_F9, v_sr0_I10)
            t9 += 0.0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000007
            return (v_sr0_F9, v_sr0_I10)
        t11 = I[np.uint64(v_particle + 2)]
        if t11 < 0:
            st[0] = 1
            top[3] = 9000007
            return (v_sr0_F9, v_sr0_I10)
        t12 = F[np.uint64(t11 + 0)]
        t13 = I[np.uint64(t11 + 0 + 1)] != 0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000007
            return (v_sr0_F9, v_sr0_I10)
        t14 = F[np.uint64(v_particle + 1)]
        t15 = v_total_mass_new
        if t15 == 0.0:
            st[0] = 1
            top[3] = 9000007
            return (v_sr0_F9, v_sr0_I10)
        t16 = v_sr0_I2
        if t16 < 0:
            st[0] = 1
            top[3] = 9000007
            return (v_sr0_F9, v_sr0_I10)
        F[np.uint64(t16 + 0)] = (t9 + t12 * t14) / t15
        I[np.uint64(t16 + 0 + 1)] = False
        t17 = v_sr0_I2
        if t17 < 0:
            st[0] = 1
            top[3] = 9000009
            return (v_sr0_F9, v_sr0_I10)
        t18 = F[np.uint64(t17 + 2)]
        t19 = I[np.uint64(t17 + 2 + 1)] != 0
        t20 = v_sr0_F9
        t21 = v_sr0_I10 != 0
        t22 = t18 * t20
        t23 = t19 and t21
        if t23:
            if t22 >= 9007199254740992.0 or t22 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 9000009
                return (v_sr0_F9, v_sr0_I10)
            t22 += 0.0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000009
            return (v_sr0_F9, v_sr0_I10)
        t24 = I[np.uint64(v_particle + 2)]
        if t24 < 0:
            st[0] = 1
            top[3] = 9000009
            return (v_sr0_F9, v_sr0_I10)
        t25 = F[np.uint64(t24 + 2)]
        t26 = I[np.uint64(t24 + 2 + 1)] != 0
        if v_particle < 0:
            st[0] = 1
            top[3] = 9000009
            return (v_sr0_F9, v_sr0_I10)
        t27 = F[np.uint64(v_particle + 1)]
        t28 = v_total_mass_new
        if t28 == 0.0:
            st[0] = 1
            top[3] = 9000009
            return (v_sr0_F9, v_sr0_I10)
        t29 = v_sr0_I2
        if t29 < 0:
            st[0] = 1
            top[3] = 9000009
            return (v_sr0_F9, v_sr0_I10)
        F[np.uint64(t29 + 2)] = (t22 + t25 * t27) / t28
        I[np.uint64(t29 + 2 + 1)] = False
    v_sr0_F9 = v_total_mass_new
    v_sr0_I10 = False
    return (v_sr0_F9, v_sr0_I10)


@njit(error_model="numpy")
def sr3_f20_subdivide_borrowed(_heap_ctx, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if False:
        st[0] = 1
        top[3] = 10000002
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t1 = v_sr0_I0
    if t1 < 0:
        st[0] = 1
        top[3] = 10000002
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t2 = F[np.uint64(t1 + 2)]
    v_x = t2
    if False:
        st[0] = 1
        top[3] = 10000003
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t3 = v_sr0_I0
    if t3 < 0:
        st[0] = 1
        top[3] = 10000003
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t4 = F[np.uint64(t3 + 3)]
    v_y = t4
    if False:
        st[0] = 1
        top[3] = 10000004
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t5 = v_sr0_I0
    if t5 < 0:
        st[0] = 1
        top[3] = 10000004
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t6 = F[np.uint64(t5 + 1)]
    t7 = 2.0
    if t7 == 0.0:
        st[0] = 1
        top[3] = 10000004
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_w = t6 / t7
    if False:
        st[0] = 1
        top[3] = 10000005
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t8 = v_sr0_I0
    if t8 < 0:
        st[0] = 1
        top[3] = 10000005
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t9 = F[np.uint64(t8 + 0)]
    t10 = 2.0
    if t10 == 0.0:
        st[0] = 1
        top[3] = 10000005
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_h = t9 / t10
    t11 = alloc(I, top, st, 4)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t11, v_x + v_w, v_y - v_h, v_w, v_h)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_ne = t11
    if False:
        st[0] = 1
        top[3] = 10000008
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t12 = v_sr0_I1
    t13 = alloc(I, top, st, 11)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t13, v_ne, t12)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    if False:
        st[0] = 1
        top[3] = 10000008
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sr0_I4 = t13
    t14 = alloc(I, top, st, 4)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t14, v_x - v_w, v_y - v_h, v_w, v_h)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_nw = t14
    if False:
        st[0] = 1
        top[3] = 10000011
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t15 = v_sr0_I1
    t16 = alloc(I, top, st, 11)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t16, v_nw, t15)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    if False:
        st[0] = 1
        top[3] = 10000011
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sr0_I5 = t16
    t17 = alloc(I, top, st, 4)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t17, v_x + v_w, v_y + v_h, v_w, v_h)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_se = t17
    if False:
        st[0] = 1
        top[3] = 10000014
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t18 = v_sr0_I1
    t19 = alloc(I, top, st, 11)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t19, v_se, t18)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    if False:
        st[0] = 1
        top[3] = 10000014
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sr0_I7 = t19
    t20 = alloc(I, top, st, 4)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t20, v_x - v_w, v_y + v_h, v_w, v_h)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sw = t20
    if False:
        st[0] = 1
        top[3] = 10000017
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t21 = v_sr0_I1
    t22 = alloc(I, top, st, 11)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t22, v_sw, t21)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    if False:
        st[0] = 1
        top[3] = 10000017
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sr0_I8 = t22
    if False:
        st[0] = 1
        top[3] = 10000019
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sr0_I3 = True
    if False:
        st[0] = 1
        top[3] = 10000022
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    t23 = v_sr0_I6
    t24 = t23
    t25 = 0
    while True:
        if t25 >= I[np.uint64(t24)]:
            break
        t26 = I[np.uint64(I[np.uint64(t24 + 2)] + t25)]
        t25 += 1
        v_particle = t26
        if False:
            st[0] = 1
            top[3] = 10000023
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t27 = v_sr0_I4
        if t27 < 0:
            st[0] = 1
            top[3] = 10000023
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t28 = t27
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 10000023
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t29_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t28), np.int64(v_particle))
        if st[0]:
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        top[1] -= 1
        if False:
            st[0] = 1
            top[3] = 10000024
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t30 = v_sr0_I5
        if t30 < 0:
            st[0] = 1
            top[3] = 10000024
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t31 = t30
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 10000024
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t32_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t31), np.int64(v_particle))
        if st[0]:
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        top[1] -= 1
        if False:
            st[0] = 1
            top[3] = 10000025
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t33 = v_sr0_I7
        if t33 < 0:
            st[0] = 1
            top[3] = 10000025
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t34 = t33
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 10000025
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t35_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t34), np.int64(v_particle))
        if st[0]:
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        top[1] -= 1
        if False:
            st[0] = 1
            top[3] = 10000026
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t36 = v_sr0_I8
        if t36 < 0:
            st[0] = 1
            top[3] = 10000026
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t37 = t36
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 10000026
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        t38_0 = f23_insert_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t37), np.int64(v_particle))
        if st[0]:
            return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
        top[1] -= 1
    t39 = list_new(I, top, st, 0, 0)
    if st[0]:
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    if False:
        st[0] = 1
        top[3] = 10000029
        return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)
    v_sr0_I6 = t39
    return (v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8)


@njit(error_model="numpy")
def sr4_f24_calculate_force_borrowed(_heap_ctx, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_particle, v_theta):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if not v_sr0_I10 != 0:
        _kf_result0, _kf_result1, _kf_result2, _kf_result3 = _kf_sr4_f24_calculate_force_borrowed(_heap_ctx, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_particle, v_theta)
        return (_kf_result0, _kf_result1, _kf_result2, _kf_result3)
    else:
        t1 = v_sr0_F9
        t2 = v_sr0_I10 != 0
        if t1 == 0.0:
            t3 = 0
            t4 = 0
            t5 = t3
            t6 = t4
            return (float(t5), True, float(t6), True)
        t7 = v_sr0_I6
        t8 = I[np.uint64(t7)]
        t9 = t8 == 1
        if t9:
            t10 = v_sr0_I6
            t11 = I[np.uint64(t10)]
            t12 = 0
            if t12 < 0:
                t12 += t11
            if t12 < 0 or t12 >= t11:
                st[0] = 1
                top[3] = 4000006
                return (0.0, False, 0.0, False)
            t13 = I[np.uint64(t10 + 2)] + t12
            t14 = I[np.uint64(t13)]
            t9 = t14 == v_particle
        if t9:
            t15 = 0
            t16 = 0
            t17 = t15
            t18 = t16
            return (float(t17), True, float(t18), True)
        t19 = v_sr0_I2
        if t19 < 0:
            st[0] = 1
            top[3] = 4000010
            return (0.0, False, 0.0, False)
        t20 = F[np.uint64(t19 + 0)]
        t21 = I[np.uint64(t19 + 0 + 1)] != 0
        if v_particle < 0:
            st[0] = 1
            top[3] = 4000010
            return (0.0, False, 0.0, False)
        t22 = I[np.uint64(v_particle + 2)]
        if t22 < 0:
            st[0] = 1
            top[3] = 4000010
            return (0.0, False, 0.0, False)
        t23 = F[np.uint64(t22 + 0)]
        t24 = I[np.uint64(t22 + 0 + 1)] != 0
        t25 = t20 - t23
        t26 = t21 and t24
        if t26:
            if t25 >= 9007199254740992.0 or t25 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 4000010
                return (0.0, False, 0.0, False)
            t25 += 0.0
        v_dx_0 = t25
        v_dx_1 = t26
        t27 = v_sr0_I2
        if t27 < 0:
            st[0] = 1
            top[3] = 4000011
            return (0.0, False, 0.0, False)
        t28 = F[np.uint64(t27 + 2)]
        t29 = I[np.uint64(t27 + 2 + 1)] != 0
        if v_particle < 0:
            st[0] = 1
            top[3] = 4000011
            return (0.0, False, 0.0, False)
        t30 = I[np.uint64(v_particle + 2)]
        if t30 < 0:
            st[0] = 1
            top[3] = 4000011
            return (0.0, False, 0.0, False)
        t31 = F[np.uint64(t30 + 2)]
        t32 = I[np.uint64(t30 + 2 + 1)] != 0
        t33 = t28 - t31
        t34 = t29 and t32
        if t34:
            if t33 >= 9007199254740992.0 or t33 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 4000011
                return (0.0, False, 0.0, False)
            t33 += 0.0
        v_dy_0 = t33
        v_dy_1 = t34
        t35 = v_dx_0 * v_dx_0
        t36 = v_dx_1 and v_dx_1
        if t36:
            if t35 >= 9007199254740992.0 or t35 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 4000012
                return (0.0, False, 0.0, False)
            t35 += 0.0
        t37 = v_dy_0 * v_dy_0
        t38 = v_dy_1 and v_dy_1
        if t38:
            if t37 >= 9007199254740992.0 or t37 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 4000012
                return (0.0, False, 0.0, False)
            t37 += 0.0
        t39 = t35 + t37
        t40 = t36 and t38
        if t40:
            if t39 >= 9007199254740992.0 or t39 <= -9007199254740992.0:
                st[0] = 1
                top[3] = 4000012
                return (0.0, False, 0.0, False)
            t39 += 0.0
        t41 = t39
        if t41 < 0.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t42 = math.sqrt(t41)
        v_distance = t42
        t43 = v_sr0_I3 != 0
        t44 = not t43
        if not t44:
            t45 = v_sr0_I0
            if t45 < 0:
                st[0] = 1
                top[3] = 4000015
                return (0.0, False, 0.0, False)
            t46 = F[np.uint64(t45 + 1)]
            t47 = v_distance
            if t47 == 0.0:
                st[0] = 1
                top[3] = 4000015
                return (0.0, False, 0.0, False)
            t44 = t46 * 2.0 / t47 < v_theta
        if t44:
            if v_distance < 5.0:
                v_distance = 5.0
            if v_particle < 0:
                st[0] = 1
                top[3] = 4000021
                return (0.0, False, 0.0, False)
            t48 = F[np.uint64(v_particle + 1)]
            t49 = v_sr0_F9
            t50 = v_sr0_I10 != 0
            t51 = v_distance * v_distance
            if t51 == 0.0:
                st[0] = 1
                top[3] = 4000021
                return (0.0, False, 0.0, False)
            v_f = 6.6743e-11 * t48 * t49 / t51
            t52 = v_distance
            if t52 == 0.0:
                st[0] = 1
                top[3] = 4000024
                return (0.0, False, 0.0, False)
            v_fx_0 = v_f * v_dx_0 / t52
            v_fx_1 = False
            t53 = v_distance
            if t53 == 0.0:
                st[0] = 1
                top[3] = 4000025
                return (0.0, False, 0.0, False)
            v_fy_0 = v_f * v_dy_0 / t53
            v_fy_1 = False
            t54 = v_fx_0
            t55 = v_fx_1
            t56 = v_fy_0
            t57 = v_fy_1
            return (t54, t55, t56, t57)
        t58 = 0
        t59 = 0
        t60 = t58
        v_fx_0 = float(t60)
        v_fx_1 = True
        t61 = t59
        v_fy_0 = float(t61)
        v_fy_1 = True
        t62 = v_sr0_I4
        if t62 >= 0:
            t63 = v_sr0_I4
            if t63 < 0:
                st[0] = 1
                top[3] = 4000033
                return (0.0, False, 0.0, False)
            t64 = t63
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 4000033
                return (0.0, False, 0.0, False)
            t65_0, t65_1, t65_2, t65_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t64), np.int64(v_particle), np.float64(v_theta))
            if st[0]:
                return (0.0, False, 0.0, False)
            top[1] -= 1
            v_fx_ne_0 = t65_0
            v_fx_ne_1 = t65_1
            v_fy_ne_0 = t65_2
            v_fy_ne_1 = t65_3
            t66 = v_fx_0 + v_fx_ne_0
            t67 = v_fx_1 and v_fx_ne_1
            v_fx_0 = t66
            v_fx_1 = t67
            t68 = v_fy_0 + v_fy_ne_0
            t69 = v_fy_1 and v_fy_ne_1
            v_fy_0 = t68
            v_fy_1 = t69
        t70 = v_sr0_I5
        if t70 >= 0:
            t71 = v_sr0_I5
            if t71 < 0:
                st[0] = 1
                top[3] = 4000038
                return (0.0, False, 0.0, False)
            t72 = t71
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 4000038
                return (0.0, False, 0.0, False)
            t73_0, t73_1, t73_2, t73_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t72), np.int64(v_particle), np.float64(v_theta))
            if st[0]:
                return (0.0, False, 0.0, False)
            top[1] -= 1
            v_fx_nw_0 = t73_0
            v_fx_nw_1 = t73_1
            v_fy_nw_0 = t73_2
            v_fy_nw_1 = t73_3
            t74 = v_fx_0 + v_fx_nw_0
            t75 = v_fx_1 and v_fx_nw_1
            v_fx_0 = t74
            v_fx_1 = t75
            t76 = v_fy_0 + v_fy_nw_0
            t77 = v_fy_1 and v_fy_nw_1
            v_fy_0 = t76
            v_fy_1 = t77
        t78 = v_sr0_I7
        if t78 >= 0:
            t79 = v_sr0_I7
            if t79 < 0:
                st[0] = 1
                top[3] = 4000043
                return (0.0, False, 0.0, False)
            t80 = t79
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 4000043
                return (0.0, False, 0.0, False)
            t81_0, t81_1, t81_2, t81_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t80), np.int64(v_particle), np.float64(v_theta))
            if st[0]:
                return (0.0, False, 0.0, False)
            top[1] -= 1
            v_fx_se_0 = t81_0
            v_fx_se_1 = t81_1
            v_fy_se_0 = t81_2
            v_fy_se_1 = t81_3
            t82 = v_fx_0 + v_fx_se_0
            t83 = v_fx_1 and v_fx_se_1
            v_fx_0 = t82
            v_fx_1 = t83
            t84 = v_fy_0 + v_fy_se_0
            t85 = v_fy_1 and v_fy_se_1
            v_fy_0 = t84
            v_fy_1 = t85
        t86 = v_sr0_I8
        if t86 >= 0:
            t87 = v_sr0_I8
            if t87 < 0:
                st[0] = 1
                top[3] = 4000048
                return (0.0, False, 0.0, False)
            t88 = t87
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 4000048
                return (0.0, False, 0.0, False)
            t89_0, t89_1, t89_2, t89_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t88), np.int64(v_particle), np.float64(v_theta))
            if st[0]:
                return (0.0, False, 0.0, False)
            top[1] -= 1
            v_fx_sw_0 = t89_0
            v_fx_sw_1 = t89_1
            v_fy_sw_0 = t89_2
            v_fy_sw_1 = t89_3
            t90 = v_fx_0 + v_fx_sw_0
            t91 = v_fx_1 and v_fx_sw_1
            v_fx_0 = t90
            v_fx_1 = t91
            t92 = v_fy_0 + v_fy_sw_0
            t93 = v_fy_1 and v_fy_sw_1
            v_fy_0 = t92
            v_fy_1 = t93
        t94 = v_fx_0
        t95 = v_fx_1
        t96 = v_fy_0
        t97 = v_fy_1
        return (t94, t95, t96, t97)
        return (0.0, False, 0.0, False)


@njit(error_model="numpy")
def _kf_f0_advance_system_borrowed(_heap_ctx, v_particles, v_theta, v_time_step, v_width, v_height):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_width
    t2 = 2.0
    if t2 == 0.0:
        st[0] = 1
        top[3] = 4
        return
    t3 = v_height
    t4 = 2.0
    if t4 == 0.0:
        st[0] = 1
        top[3] = 4
        return
    t5 = v_width
    t6 = 2.0
    if t6 == 0.0:
        st[0] = 1
        top[3] = 4
        return
    t7 = v_height
    t8 = 2.0
    if t8 == 0.0:
        st[0] = 1
        top[3] = 4
        return
    t9 = alloc(I, top, st, 4)
    if st[0]:
        return
    f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t9, float(t1) / t2, float(t3) / t4, float(t5) / t6, float(t7) / t8)
    if st[0]:
        return
    v_boundary = t9
    _sr_t10_F9 = 0.0
    _sr_t10_I0 = np.int64(0)
    _sr_t10_I1 = np.int64(0)
    _sr_t10_I2 = np.int64(0)
    _sr_t10_I3 = np.int64(0)
    _sr_t10_I4 = np.int64(0)
    _sr_t10_I5 = np.int64(0)
    _sr_t10_I6 = np.int64(0)
    _sr_t10_I7 = np.int64(0)
    _sr_t10_I8 = np.int64(0)
    _sr_t10_I10 = np.int64(0)
    if st[0]:
        return
    _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10 = sr0_f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10, v_boundary, 4)
    if st[0]:
        return
    pass
    t11 = v_particles
    t12 = 0
    while True:
        if t12 >= I[np.uint64(t11)]:
            break
        t13 = I[np.uint64(I[np.uint64(t11 + 2)] + t12)]
        t12 += 1
        v_particle = t13
        pass
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 9
            return
        t15_0, _sr_t10_F9, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10 = sr1_f23_insert_borrowed(_heap_ctx, _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10, np.int64(v_particle))
        if st[0]:
            return
        top[1] -= 1
    t16 = v_particles
    t17 = 0
    while True:
        if t17 >= I[np.uint64(t16)]:
            break
        t18 = I[np.uint64(I[np.uint64(t16 + 2)] + t17)]
        t17 += 1
        v_particle = t18
        pass
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 13
            return
        t20_0, t20_1, t20_2, t20_3 = sr4_f24_calculate_force_borrowed(_heap_ctx, _sr_t10_F9, _sr_t10_I0, _sr_t10_I1, _sr_t10_I2, _sr_t10_I3, _sr_t10_I4, _sr_t10_I5, _sr_t10_I6, _sr_t10_I7, _sr_t10_I8, _sr_t10_I10, np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return
        top[1] -= 1
        v_fx_0 = t20_0
        v_fx_1 = t20_1
        v_fy_0 = t20_2
        v_fy_1 = t20_3
        if v_particle < 0:
            st[0] = 1
            top[3] = 14
            return
        t21 = v_particle
        f21_apply_force_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t21, v_fx_0, v_fx_1, v_fy_0, v_fy_1)
        if st[0]:
            return
    t22 = v_particles
    t23 = 0
    while True:
        if t23 >= I[np.uint64(t22)]:
            break
        t24 = I[np.uint64(I[np.uint64(t22 + 2)] + t23)]
        t23 += 1
        v_particle = t24
        if v_particle < 0:
            st[0] = 1
            top[3] = 18
            return
        t25 = v_particle
        f12_update_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t25, v_time_step)
        if st[0]:
            return
    return


@njit(error_model="numpy", inline="always")
def _kf_f21_apply_force_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_fx_0, v_fx_1, v_fy_0, v_fy_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if v_self < 0:
        st[0] = 1
        top[3] = 5000003
        return
    t1 = I[np.uint64(v_self + 0)]
    if t1 < 0:
        st[0] = 1
        top[3] = 5000003
        return
    t2 = t1
    t3 = F[np.uint64(t2 + 0)]
    t4 = I[np.uint64(t2 + 0 + 1)] != 0
    if v_self < 0:
        st[0] = 1
        top[3] = 5000003
        return
    t5 = F[np.uint64(v_self + 1)]
    t6 = t5
    if t6 == 0.0:
        st[0] = 1
        top[3] = 5000003
        return
    F[np.uint64(t2 + 0)] = t3 + v_fx_0 / t6
    I[np.uint64(t2 + 0 + 1)] = False
    if v_self < 0:
        st[0] = 1
        top[3] = 5000004
        return
    t7 = I[np.uint64(v_self + 0)]
    if t7 < 0:
        st[0] = 1
        top[3] = 5000004
        return
    t8 = t7
    t9 = F[np.uint64(t8 + 2)]
    t10 = I[np.uint64(t8 + 2 + 1)] != 0
    if v_self < 0:
        st[0] = 1
        top[3] = 5000004
        return
    t11 = F[np.uint64(v_self + 1)]
    t12 = t11
    if t12 == 0.0:
        st[0] = 1
        top[3] = 5000004
        return
    F[np.uint64(t8 + 2)] = t9 + v_fy_0 / t12
    I[np.uint64(t8 + 2 + 1)] = False
    return


@njit(error_model="numpy")
def _kf_sr4_f24_calculate_force_borrowed(_heap_ctx, v_sr0_F9, v_sr0_I0, v_sr0_I1, v_sr0_I2, v_sr0_I3, v_sr0_I4, v_sr0_I5, v_sr0_I6, v_sr0_I7, v_sr0_I8, v_sr0_I10, v_particle, v_theta):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_F9
    t2 = False
    if t1 == 0.0:
        t3 = 0
        t4 = 0
        t5 = t3
        t6 = t4
        return (float(t5), True, float(t6), True)
    t7 = v_sr0_I6
    t8 = I[np.uint64(t7)]
    t9 = t8 == 1
    if t9:
        t10 = v_sr0_I6
        t11 = I[np.uint64(t10)]
        t12 = 0
        if t12 < 0:
            t12 += t11
        if t12 < 0 or t12 >= t11:
            st[0] = 1
            top[3] = 4000006
            return (0.0, False, 0.0, False)
        t13 = I[np.uint64(t10 + 2)] + t12
        t14 = I[np.uint64(t13)]
        t9 = t14 == v_particle
    if t9:
        t15 = 0
        t16 = 0
        t17 = t15
        t18 = t16
        return (float(t17), True, float(t18), True)
    t19 = v_sr0_I2
    if t19 < 0:
        st[0] = 1
        top[3] = 4000010
        return (0.0, False, 0.0, False)
    t20 = F[np.uint64(t19 + 0)]
    t21 = I[np.uint64(t19 + 0 + 1)] != 0
    if v_particle < 0:
        st[0] = 1
        top[3] = 4000010
        return (0.0, False, 0.0, False)
    t22 = I[np.uint64(v_particle + 2)]
    if t22 < 0:
        st[0] = 1
        top[3] = 4000010
        return (0.0, False, 0.0, False)
    t23 = F[np.uint64(t22 + 0)]
    t24 = I[np.uint64(t22 + 0 + 1)] != 0
    t25 = t20 - t23
    t26 = t21 and t24
    if t26:
        if t25 >= 9007199254740992.0 or t25 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000010
            return (0.0, False, 0.0, False)
        t25 += 0.0
    v_dx_0 = t25
    v_dx_1 = t26
    t27 = v_sr0_I2
    if t27 < 0:
        st[0] = 1
        top[3] = 4000011
        return (0.0, False, 0.0, False)
    t28 = F[np.uint64(t27 + 2)]
    t29 = I[np.uint64(t27 + 2 + 1)] != 0
    if v_particle < 0:
        st[0] = 1
        top[3] = 4000011
        return (0.0, False, 0.0, False)
    t30 = I[np.uint64(v_particle + 2)]
    if t30 < 0:
        st[0] = 1
        top[3] = 4000011
        return (0.0, False, 0.0, False)
    t31 = F[np.uint64(t30 + 2)]
    t32 = I[np.uint64(t30 + 2 + 1)] != 0
    t33 = t28 - t31
    t34 = t29 and t32
    if t34:
        if t33 >= 9007199254740992.0 or t33 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000011
            return (0.0, False, 0.0, False)
        t33 += 0.0
    v_dy_0 = t33
    v_dy_1 = t34
    t35 = v_dx_0 * v_dx_0
    t36 = v_dx_1 and v_dx_1
    if t36:
        if t35 >= 9007199254740992.0 or t35 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t35 += 0.0
    t37 = v_dy_0 * v_dy_0
    t38 = v_dy_1 and v_dy_1
    if t38:
        if t37 >= 9007199254740992.0 or t37 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t37 += 0.0
    t39 = t35 + t37
    t40 = t36 and t38
    if t40:
        if t39 >= 9007199254740992.0 or t39 <= -9007199254740992.0:
            st[0] = 1
            top[3] = 4000012
            return (0.0, False, 0.0, False)
        t39 += 0.0
    t41 = t39
    if t41 < 0.0:
        st[0] = 1
        top[3] = 4000012
        return (0.0, False, 0.0, False)
    t42 = math.sqrt(t41)
    v_distance = t42
    t43 = v_sr0_I3 != 0
    t44 = not t43
    if not t44:
        t45 = v_sr0_I0
        if t45 < 0:
            st[0] = 1
            top[3] = 4000015
            return (0.0, False, 0.0, False)
        t46 = F[np.uint64(t45 + 1)]
        t47 = v_distance
        if t47 == 0.0:
            st[0] = 1
            top[3] = 4000015
            return (0.0, False, 0.0, False)
        t44 = t46 * 2.0 / t47 < v_theta
    if t44:
        if v_distance < 5.0:
            v_distance = 5.0
        if v_particle < 0:
            st[0] = 1
            top[3] = 4000021
            return (0.0, False, 0.0, False)
        t48 = F[np.uint64(v_particle + 1)]
        t49 = v_sr0_F9
        t50 = False
        t51 = v_distance * v_distance
        if t51 == 0.0:
            st[0] = 1
            top[3] = 4000021
            return (0.0, False, 0.0, False)
        v_f = 6.6743e-11 * t48 * t49 / t51
        t52 = v_distance
        if t52 == 0.0:
            st[0] = 1
            top[3] = 4000024
            return (0.0, False, 0.0, False)
        v_fx_0 = v_f * v_dx_0 / t52
        v_fx_1 = False
        t53 = v_distance
        if t53 == 0.0:
            st[0] = 1
            top[3] = 4000025
            return (0.0, False, 0.0, False)
        v_fy_0 = v_f * v_dy_0 / t53
        v_fy_1 = False
        t54 = v_fx_0
        t55 = v_fx_1
        t56 = v_fy_0
        t57 = v_fy_1
        return (t54, t55, t56, t57)
    t58 = 0
    t59 = 0
    t60 = t58
    v_fx_0 = float(t60)
    v_fx_1 = True
    t61 = t59
    v_fy_0 = float(t61)
    v_fy_1 = True
    t62 = v_sr0_I4
    if t62 >= 0:
        t63 = v_sr0_I4
        if t63 < 0:
            st[0] = 1
            top[3] = 4000033
            return (0.0, False, 0.0, False)
        t64 = t63
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000033
            return (0.0, False, 0.0, False)
        t65_0, t65_1, t65_2, t65_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t64), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_ne_0 = t65_0
        v_fx_ne_1 = t65_1
        v_fy_ne_0 = t65_2
        v_fy_ne_1 = t65_3
        t66 = v_fx_0 + v_fx_ne_0
        t67 = v_fx_1 and v_fx_ne_1
        v_fx_0 = t66
        v_fx_1 = t67
        t68 = v_fy_0 + v_fy_ne_0
        t69 = v_fy_1 and v_fy_ne_1
        v_fy_0 = t68
        v_fy_1 = t69
    t70 = v_sr0_I5
    if t70 >= 0:
        t71 = v_sr0_I5
        if t71 < 0:
            st[0] = 1
            top[3] = 4000038
            return (0.0, False, 0.0, False)
        t72 = t71
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000038
            return (0.0, False, 0.0, False)
        t73_0, t73_1, t73_2, t73_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t72), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_nw_0 = t73_0
        v_fx_nw_1 = t73_1
        v_fy_nw_0 = t73_2
        v_fy_nw_1 = t73_3
        t74 = v_fx_0 + v_fx_nw_0
        t75 = v_fx_1 and v_fx_nw_1
        v_fx_0 = t74
        v_fx_1 = t75
        t76 = v_fy_0 + v_fy_nw_0
        t77 = v_fy_1 and v_fy_nw_1
        v_fy_0 = t76
        v_fy_1 = t77
    t78 = v_sr0_I7
    if t78 >= 0:
        t79 = v_sr0_I7
        if t79 < 0:
            st[0] = 1
            top[3] = 4000043
            return (0.0, False, 0.0, False)
        t80 = t79
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000043
            return (0.0, False, 0.0, False)
        t81_0, t81_1, t81_2, t81_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t80), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_se_0 = t81_0
        v_fx_se_1 = t81_1
        v_fy_se_0 = t81_2
        v_fy_se_1 = t81_3
        t82 = v_fx_0 + v_fx_se_0
        t83 = v_fx_1 and v_fx_se_1
        v_fx_0 = t82
        v_fx_1 = t83
        t84 = v_fy_0 + v_fy_se_0
        t85 = v_fy_1 and v_fy_se_1
        v_fy_0 = t84
        v_fy_1 = t85
    t86 = v_sr0_I8
    if t86 >= 0:
        t87 = v_sr0_I8
        if t87 < 0:
            st[0] = 1
            top[3] = 4000048
            return (0.0, False, 0.0, False)
        t88 = t87
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 4000048
            return (0.0, False, 0.0, False)
        t89_0, t89_1, t89_2, t89_3 = f24_calculate_force_borrowed(_heap_ctx, np.int64(t88), np.int64(v_particle), np.float64(v_theta))
        if st[0]:
            return (0.0, False, 0.0, False)
        top[1] -= 1
        v_fx_sw_0 = t89_0
        v_fx_sw_1 = t89_1
        v_fy_sw_0 = t89_2
        v_fy_sw_1 = t89_3
        t90 = v_fx_0 + v_fx_sw_0
        t91 = v_fx_1 and v_fx_sw_1
        v_fx_0 = t90
        v_fx_1 = t91
        t92 = v_fy_0 + v_fy_sw_0
        t93 = v_fy_1 and v_fy_sw_1
        v_fy_0 = t92
        v_fy_1 = t93
    t94 = v_fx_0
    t95 = v_fx_1
    t96 = v_fy_0
    t97 = v_fy_1
    return (t94, t95, t96, t97)
    return (0.0, False, 0.0, False)


@njit(error_model="numpy")
def s0_f23_insert_borrowed(_heap_ctx, which, m0_v_self, m0_v_particle, m1_v_self):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if which == 0:
        m0_t1 = I[np.uint64(m0_v_self + 0)]
        if m0_t1 < 0:
            st[0] = 1
            top[3] = 3000002
            return (False,)
        m0_t2 = m0_t1
        if m0_v_particle < 0:
            st[0] = 1
            top[3] = 3000002
            return (False,)
        m0_t3 = I[np.uint64(m0_v_particle + 2)]
        m0_t4_0 = f25_contains_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_t2, m0_t3)
        if st[0]:
            return (False,)
        if not m0_t4_0:
            return (False,)
        m0_t5 = I[np.uint64(m0_v_self + 6)]
        m0_t6 = I[np.uint64(m0_t5)]
        m0_t7 = I[np.uint64(m0_v_self + 1)]
        m0_t8 = m0_t6 < m0_t7
        if m0_t8:
            m0_t9 = I[np.uint64(m0_v_self + 3)] != 0
            m0_t8 = not m0_t9
        if m0_t8:
            m0_t10 = I[np.uint64(m0_v_self + 6)]
            m0_t11 = list_room(I, top, st, m0_t10)
            if st[0]:
                return (False,)
            I[m0_t11] = m0_v_particle
            m0_t12 = m0_v_self
            f26_update_mass_distribution_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_t12, m0_v_particle)
            if st[0]:
                return (False,)
            return (True,)
        m0_t13 = I[np.uint64(m0_v_self + 3)] != 0
        if not m0_t13:
            m0_t14 = m0_v_self
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 3000011
                return (False,)
            s0_f23_insert_borrowed(_heap_ctx, np.int64(1), np.int64(-1), np.int64(-1), np.int64(m0_t14))
            if st[0]:
                return (False,)
            top[1] -= 1
        m0_t15 = I[np.uint64(m0_v_self + 4)]
        if m0_t15 < 0:
            st[0] = 1
            top[3] = 3000013
            return (False,)
        m0_t16 = m0_t15
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000013
            return (False,)
        m0_t17_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m0_t16), np.int64(m0_v_particle), np.int64(-1))[0]
        if st[0]:
            return (False,)
        top[1] -= 1
        if m0_t17_0:
            return (True,)
        m0_t18 = I[np.uint64(m0_v_self + 5)]
        if m0_t18 < 0:
            st[0] = 1
            top[3] = 3000014
            return (False,)
        m0_t19 = m0_t18
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000014
            return (False,)
        m0_t20_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m0_t19), np.int64(m0_v_particle), np.int64(-1))[0]
        if st[0]:
            return (False,)
        top[1] -= 1
        if m0_t20_0:
            return (True,)
        m0_t21 = I[np.uint64(m0_v_self + 7)]
        if m0_t21 < 0:
            st[0] = 1
            top[3] = 3000015
            return (False,)
        m0_t22 = m0_t21
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000015
            return (False,)
        m0_t23_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m0_t22), np.int64(m0_v_particle), np.int64(-1))[0]
        if st[0]:
            return (False,)
        top[1] -= 1
        if m0_t23_0:
            return (True,)
        m0_t24 = I[np.uint64(m0_v_self + 8)]
        if m0_t24 < 0:
            st[0] = 1
            top[3] = 3000016
            return (False,)
        m0_t25 = m0_t24
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 3000016
            return (False,)
        m0_t26_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m0_t25), np.int64(m0_v_particle), np.int64(-1))[0]
        if st[0]:
            return (False,)
        top[1] -= 1
        if m0_t26_0:
            return (True,)
        return (False,)
        return (False,)
    elif which == 1:
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000002
            return (False,)
        m1_t1 = I[np.uint64(m1_v_self + 0)]
        if m1_t1 < 0:
            st[0] = 1
            top[3] = 10000002
            return (False,)
        m1_t2 = F[np.uint64(m1_t1 + 2)]
        m1_v_x = m1_t2
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000003
            return (False,)
        m1_t3 = I[np.uint64(m1_v_self + 0)]
        if m1_t3 < 0:
            st[0] = 1
            top[3] = 10000003
            return (False,)
        m1_t4 = F[np.uint64(m1_t3 + 3)]
        m1_v_y = m1_t4
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000004
            return (False,)
        m1_t5 = I[np.uint64(m1_v_self + 0)]
        if m1_t5 < 0:
            st[0] = 1
            top[3] = 10000004
            return (False,)
        m1_t6 = F[np.uint64(m1_t5 + 1)]
        m1_t7 = 2.0
        if m1_t7 == 0.0:
            st[0] = 1
            top[3] = 10000004
            return (False,)
        m1_v_w = m1_t6 / m1_t7
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000005
            return (False,)
        m1_t8 = I[np.uint64(m1_v_self + 0)]
        if m1_t8 < 0:
            st[0] = 1
            top[3] = 10000005
            return (False,)
        m1_t9 = F[np.uint64(m1_t8 + 0)]
        m1_t10 = 2.0
        if m1_t10 == 0.0:
            st[0] = 1
            top[3] = 10000005
            return (False,)
        m1_v_h = m1_t9 / m1_t10
        m1_t11 = alloc(I, top, st, 4)
        if st[0]:
            return (False,)
        f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t11, m1_v_x + m1_v_w, m1_v_y - m1_v_h, m1_v_w, m1_v_h)
        if st[0]:
            return (False,)
        m1_v_ne = m1_t11
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000008
            return (False,)
        m1_t12 = I[np.uint64(m1_v_self + 1)]
        m1_t13 = alloc(I, top, st, 11)
        if st[0]:
            return (False,)
        f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t13, m1_v_ne, m1_t12)
        if st[0]:
            return (False,)
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000008
            return (False,)
        I[np.uint64(m1_v_self + 4)] = m1_t13
        m1_t14 = alloc(I, top, st, 4)
        if st[0]:
            return (False,)
        f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t14, m1_v_x - m1_v_w, m1_v_y - m1_v_h, m1_v_w, m1_v_h)
        if st[0]:
            return (False,)
        m1_v_nw = m1_t14
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000011
            return (False,)
        m1_t15 = I[np.uint64(m1_v_self + 1)]
        m1_t16 = alloc(I, top, st, 11)
        if st[0]:
            return (False,)
        f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t16, m1_v_nw, m1_t15)
        if st[0]:
            return (False,)
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000011
            return (False,)
        I[np.uint64(m1_v_self + 5)] = m1_t16
        m1_t17 = alloc(I, top, st, 4)
        if st[0]:
            return (False,)
        f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t17, m1_v_x + m1_v_w, m1_v_y + m1_v_h, m1_v_w, m1_v_h)
        if st[0]:
            return (False,)
        m1_v_se = m1_t17
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000014
            return (False,)
        m1_t18 = I[np.uint64(m1_v_self + 1)]
        m1_t19 = alloc(I, top, st, 11)
        if st[0]:
            return (False,)
        f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t19, m1_v_se, m1_t18)
        if st[0]:
            return (False,)
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000014
            return (False,)
        I[np.uint64(m1_v_self + 7)] = m1_t19
        m1_t20 = alloc(I, top, st, 4)
        if st[0]:
            return (False,)
        f2___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t20, m1_v_x - m1_v_w, m1_v_y + m1_v_h, m1_v_w, m1_v_h)
        if st[0]:
            return (False,)
        m1_v_sw = m1_t20
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000017
            return (False,)
        m1_t21 = I[np.uint64(m1_v_self + 1)]
        m1_t22 = alloc(I, top, st, 11)
        if st[0]:
            return (False,)
        f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t22, m1_v_sw, m1_t21)
        if st[0]:
            return (False,)
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000017
            return (False,)
        I[np.uint64(m1_v_self + 8)] = m1_t22
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000019
            return (False,)
        I[np.uint64(m1_v_self + 3)] = True
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000022
            return (False,)
        m1_t23 = I[np.uint64(m1_v_self + 6)]
        m1_t24 = m1_t23
        m1_t25 = 0
        while True:
            if m1_t25 >= I[np.uint64(m1_t24)]:
                break
            m1_t26 = I[np.uint64(I[np.uint64(m1_t24 + 2)] + m1_t25)]
            m1_t25 += 1
            m1_v_particle = m1_t26
            if m1_v_self < 0:
                st[0] = 1
                top[3] = 10000023
                return (False,)
            m1_t27 = I[np.uint64(m1_v_self + 4)]
            if m1_t27 < 0:
                st[0] = 1
                top[3] = 10000023
                return (False,)
            m1_t28 = m1_t27
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 10000023
                return (False,)
            m1_t29_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m1_t28), np.int64(m1_v_particle), np.int64(-1))[0]
            if st[0]:
                return (False,)
            top[1] -= 1
            if m1_v_self < 0:
                st[0] = 1
                top[3] = 10000024
                return (False,)
            m1_t30 = I[np.uint64(m1_v_self + 5)]
            if m1_t30 < 0:
                st[0] = 1
                top[3] = 10000024
                return (False,)
            m1_t31 = m1_t30
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 10000024
                return (False,)
            m1_t32_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m1_t31), np.int64(m1_v_particle), np.int64(-1))[0]
            if st[0]:
                return (False,)
            top[1] -= 1
            if m1_v_self < 0:
                st[0] = 1
                top[3] = 10000025
                return (False,)
            m1_t33 = I[np.uint64(m1_v_self + 7)]
            if m1_t33 < 0:
                st[0] = 1
                top[3] = 10000025
                return (False,)
            m1_t34 = m1_t33
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 10000025
                return (False,)
            m1_t35_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m1_t34), np.int64(m1_v_particle), np.int64(-1))[0]
            if st[0]:
                return (False,)
            top[1] -= 1
            if m1_v_self < 0:
                st[0] = 1
                top[3] = 10000026
                return (False,)
            m1_t36 = I[np.uint64(m1_v_self + 8)]
            if m1_t36 < 0:
                st[0] = 1
                top[3] = 10000026
                return (False,)
            m1_t37 = m1_t36
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 10000026
                return (False,)
            m1_t38_0 = s0_f23_insert_borrowed(_heap_ctx, np.int64(0), np.int64(m1_t37), np.int64(m1_v_particle), np.int64(-1))[0]
            if st[0]:
                return (False,)
            top[1] -= 1
        m1_t39 = list_new(I, top, st, 0, 0)
        if st[0]:
            return (False,)
        if m1_v_self < 0:
            st[0] = 1
            top[3] = 10000029
            return (False,)
        I[np.uint64(m1_v_self + 6)] = m1_t39
        return (False,)
    return (False,)


@njit(error_model="numpy")
def f0_advance_system(F, I, top, st, v_particles, v_theta, v_time_step, v_width, v_height):
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
    return f0_advance_system_borrowed(_heap_ctx, v_particles, v_theta, v_time_step, v_width, v_height)

