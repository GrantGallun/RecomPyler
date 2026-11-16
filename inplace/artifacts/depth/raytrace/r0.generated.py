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
def f0_render_borrowed(_heap_ctx, v_self, v_canvas):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 0)]
    t2 = 2.0
    if t2 == 0.0:
        st[0] = 1
        top[3] = 2
        return
    t3 = 180.0
    if t3 == 0.0:
        st[0] = 1
        top[3] = 2
        return
    v_fovRadians = 3.141592653589793 * (float(t1) / t2) / t3
    t4 = v_fovRadians
    t5 = math.tan(t4)
    if math.isnan(t5) and (not math.isnan(t4)) or (math.isinf(t5) and (not math.isinf(t4))):
        st[0] = 1
        top[3] = 3
        return
    v_halfWidth = t5
    v_halfHeight = 0.75 * v_halfWidth
    v_width = v_halfWidth * 2.0
    v_height = v_halfHeight * 2.0
    t6 = I[np.uint64(v_canvas + 2)]
    t7 = sub_i(st, t6, 1)
    if st[0]:
        return
    t8 = float(t7)
    if t8 == 0.0:
        st[0] = 1
        top[3] = 7
        return
    v_pixelWidth = v_width / t8
    t9 = I[np.uint64(v_canvas + 1)]
    t10 = sub_i(st, t9, 1)
    if st[0]:
        return
    t11 = float(t10)
    if t11 == 0.0:
        st[0] = 1
        top[3] = 8
        return
    v_pixelHeight = v_height / t11
    t12 = I[np.uint64(v_self + 4)]
    t13 = I[np.uint64(v_self + 2)]
    t14 = I[np.uint64(v_self + 4)]
    t15 = t13
    _sr_call_t16_0_F0, _sr_call_t16_0_F2, _sr_call_t16_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t15, t14)
    if st[0]:
        return
    _sr_t17_I0 = np.int64(0)
    _sr_t17_I1 = np.int64(0)
    if st[0]:
        return
    _sr_t17_I0, _sr_t17_I1 = sr30_f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t17_I0, _sr_t17_I1, t12, _sr_call_t16_0_F0, _sr_call_t16_0_F2, _sr_call_t16_0_F4)
    if st[0]:
        return
    pass
    t18 = _sr_t17_I1
    t19 = t18
    _sr_call_t20_0_F0, _sr_call_t20_0_F2, _sr_call_t20_0_F4 = sr36_f24_cross_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t19, I[0])
    if st[0]:
        return
    pass
    _sr_call_t22_0_F0, _sr_call_t22_0_F2, _sr_call_t22_0_F4 = sr29_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t20_0_F0, _sr_call_t20_0_F2, _sr_call_t20_0_F4)
    if st[0]:
        return
    pass
    pass
    t24 = _sr_t17_I1
    _sr_call_t25_0_F0, _sr_call_t25_0_F2, _sr_call_t25_0_F4 = sr38_f24_cross_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t22_0_F0, _sr_call_t22_0_F2, _sr_call_t22_0_F4, t24)
    if st[0]:
        return
    pass
    _sr_call_t27_0_F0, _sr_call_t27_0_F2, _sr_call_t27_0_F4 = sr29_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t25_0_F0, _sr_call_t25_0_F2, _sr_call_t25_0_F4)
    if st[0]:
        return
    pass
    t28 = I[np.uint64(v_canvas + 1)]
    t29 = t28
    for t30 in range(t29):
        v_y = t30
        t31 = I[np.uint64(v_canvas + 2)]
        t32 = t31
        for t33 in range(t32):
            v_x = t33
            pass
            _sr_call_t35_0_F0, _sr_call_t35_0_F2, _sr_call_t35_0_F4 = sr28_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t22_0_F0, _sr_call_t22_0_F2, _sr_call_t22_0_F4, float(v_x) * v_pixelWidth - v_halfWidth)
            if st[0]:
                return
            pass
            pass
            _sr_call_t37_0_F0, _sr_call_t37_0_F2, _sr_call_t37_0_F4 = sr28_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t27_0_F0, _sr_call_t27_0_F2, _sr_call_t27_0_F4, float(v_y) * v_pixelHeight - v_halfHeight)
            if st[0]:
                return
            pass
            t38 = _sr_t17_I0
            t39 = _sr_t17_I1
            t40 = t39
            _sr_call_t41_0_F0, _sr_call_t41_0_F2, _sr_call_t41_0_F4 = sr41_f27___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t40, _sr_call_t35_0_F0, _sr_call_t35_0_F2, _sr_call_t35_0_F4)
            if st[0]:
                return
            pass
            _sr_call_t43_0_F0, _sr_call_t43_0_F2, _sr_call_t43_0_F4 = sr43_f27___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t41_0_F0, _sr_call_t41_0_F2, _sr_call_t41_0_F4, _sr_call_t37_0_F0, _sr_call_t37_0_F2, _sr_call_t37_0_F4)
            if st[0]:
                return
            _sr_t44_I0 = np.int64(0)
            _sr_t44_I1 = np.int64(0)
            if st[0]:
                return
            _sr_t44_I0, _sr_t44_I1 = sr30_f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t44_I0, _sr_t44_I1, t38, _sr_call_t43_0_F0, _sr_call_t43_0_F2, _sr_call_t43_0_F4)
            if st[0]:
                return
            pass
            t45 = v_self
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 19
                return
            t46_0, t46_1, t46_2, t46_3, t46_4, t46_5 = sr4_f30_rayColour_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t45), _sr_t44_I0, _sr_t44_I1)
            if st[0]:
                return
            top[1] -= 1
            v_colour_0 = t46_0
            v_colour_1 = t46_1
            v_colour_2 = t46_2
            v_colour_3 = t46_3
            v_colour_4 = t46_4
            v_colour_5 = t46_5
            t47 = v_canvas
            f71_plot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t47, v_x, v_y, v_colour_0, v_colour_1, v_colour_2, v_colour_3, v_colour_4, v_colour_5)
            if st[0]:
                return
    return


@njit(error_model="numpy", inline="always")
def f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    f7_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return -1
    t2 = F[np.uint64(v_self + 0)]
    t3 = True
    t4 = F[np.uint64(v_other + 0)]
    t5 = True
    t6 = t2 - t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 1000003
        return -1
    t7 = F[np.uint64(v_self + 2)]
    t8 = True
    t9 = F[np.uint64(v_other + 2)]
    t10 = True
    t11 = t7 - t9
    if math.fabs(t11) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 1000003
        return -1
    t12 = F[np.uint64(v_self + 4)]
    t13 = True
    t14 = F[np.uint64(v_other + 4)]
    t15 = True
    t16 = t12 - t14
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 1000003
        return -1
    t17 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t17, t6, True, t11, True, t16, True)
    if st[0]:
        return -1
    return t17
    return -1


@njit(error_model="numpy", inline="always")
def f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_point, v_vector):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    I[np.uint64(v_self + 0)] = v_point
    t1 = v_vector
    t2_0 = f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return
    I[np.uint64(v_self + 1)] = t2_0
    return


@njit(error_model="numpy", inline="always")
def f24_cross_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return -1
    t3 = F[np.uint64(v_self + 2)]
    t4 = True
    t5 = F[np.uint64(v_other + 4)]
    t6 = True
    t7 = t3 * t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t8 = F[np.uint64(v_self + 4)]
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t13 = t7 - t12
    if math.fabs(t13) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t14 = F[np.uint64(v_self + 4)]
    t15 = True
    t16 = F[np.uint64(v_other + 0)]
    t17 = True
    t18 = t14 * t16
    if math.fabs(t18) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t19 = F[np.uint64(v_self + 0)]
    t20 = True
    t21 = F[np.uint64(v_other + 4)]
    t22 = True
    t23 = t19 * t21
    if math.fabs(t23) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t24 = t18 - t23
    if math.fabs(t24) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t25 = F[np.uint64(v_self + 0)]
    t26 = True
    t27 = F[np.uint64(v_other + 2)]
    t28 = True
    t29 = t25 * t27
    if math.fabs(t29) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t30 = F[np.uint64(v_self + 2)]
    t31 = True
    t32 = F[np.uint64(v_other + 0)]
    t33 = True
    t34 = t30 * t32
    if math.fabs(t34) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t35 = t29 - t34
    if math.fabs(t35) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return -1
    t36 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t36, t13, True, t24, True, t35, True)
    if st[0]:
        return -1
    return t36
    return -1


@njit(error_model="numpy", inline="always")
def f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_self
    t2 = v_self
    t3_0 = f14_magnitude_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2)
    if st[0]:
        return -1
    t4 = t3_0
    if t4 == 0.0:
        st[0] = 1
        top[3] = 4000002
        return -1
    t5_0 = f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, 1.0 / t4)
    if st[0]:
        return -1
    return t5_0
    return -1


@njit(error_model="numpy", inline="always")
def f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_factor):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 0)]
    t2 = True
    t3 = F[np.uint64(v_self + 2)]
    t4 = True
    t5 = F[np.uint64(v_self + 4)]
    t6 = True
    t7 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, v_factor * t1, v_factor * t3, v_factor * t5)
    if st[0]:
        return -1
    return t7
    return -1


@njit(error_model="numpy", inline="always")
def f27___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    f29_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return -1
    t2 = F[np.uint64(v_self + 0)]
    t3 = True
    t4 = F[np.uint64(v_other + 0)]
    t5 = True
    t6 = t2 + t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return -1
    t7 = F[np.uint64(v_self + 2)]
    t8 = True
    t9 = F[np.uint64(v_other + 2)]
    t10 = True
    t11 = t7 + t9
    if math.fabs(t11) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return -1
    t12 = F[np.uint64(v_self + 4)]
    t13 = True
    t14 = F[np.uint64(v_other + 4)]
    t15 = True
    t16 = t12 + t14
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return -1
    t17 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t17, t6, True, t11, True, t16, True)
    if st[0]:
        return -1
    return t17
    return -1


@njit(error_model="numpy")
def f30_rayColour_borrowed(_heap_ctx, v_self, v_ray):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 5)]
    if t1 > 3:
        t2 = 0
        t3 = 0
        t4 = 0
        t5 = t2
        if t5 > 9007199254740992 or t5 < -9007199254740992:
            st[0] = 1
            top[3] = 7000003
            return (0.0, False, 0.0, False, 0.0, False)
        t6 = t3
        if t6 > 9007199254740992 or t6 < -9007199254740992:
            st[0] = 1
            top[3] = 7000003
            return (0.0, False, 0.0, False, 0.0, False)
        t7 = t4
        if t7 > 9007199254740992 or t7 < -9007199254740992:
            st[0] = 1
            top[3] = 7000003
            return (0.0, False, 0.0, False, 0.0, False)
        return (float(t5), True, float(t6), True, float(t7), True)
    t8 = I[np.uint64(v_self + 5)]
    t9 = add_i(st, t8, 1)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    I[np.uint64(v_self + 5)] = t9
    t10 = list_new(I, top, st, 0, 0)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    v__c0_list = t10
    t11 = I[np.uint64(v_self + 3)]
    t12 = t11
    t13 = 0
    while True:
        if t13 >= I[np.uint64(t12)]:
            break
        t14 = I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 0]
        t15 = I[I[np.uint64(I[np.uint64(t12 + 2)] + t13)] + 1]
        t13 += 1
        v__c0_o = t14
        v__c0_s = t15
        t16 = v__c0_o
        t18 = I[t16]
        if t18 == 0:
            t19_0, t19_1 = f32_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t16, v_ray)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            t17_0 = t19_0
            t17_1 = t19_1
        elif t18 == 1:
            t20_0, t20_1 = f34_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t16, v_ray)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            t17_0 = t20_0
            t17_1 = t20_1
        else:
            st[0] = 1
            top[3] = 7000006
            return (0.0, False, 0.0, False, 0.0, False)
        t21 = v__c0_o
        t22 = t17_0
        t23 = t17_1
        t24 = v__c0_s
        t25 = list_room(I, top, st, v__c0_list)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        t26 = alloc(I, top, st, 4)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        I[t26 + 0] = t21
        F[t26 + 1] = t22
        I[t26 + 1 + 1] = t23
        I[t26 + 3] = t24
        I[t25] = t26
    v_intersections = v__c0_list
    t27_0, t27_1, t27_2, t27_3, t27_4 = f36_firstIntersection_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_intersections)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    v_i_0 = t27_0
    v_i_1 = t27_1
    v_i_2 = t27_2
    v_i_3 = t27_3
    v_i_4 = t27_4
    if not v_i_4:
        t28 = 0
        t29 = 0
        t30 = 0
        t31 = t28
        if t31 > 9007199254740992 or t31 < -9007199254740992:
            st[0] = 1
            top[3] = 7000010
            return (0.0, False, 0.0, False, 0.0, False)
        t32 = t29
        if t32 > 9007199254740992 or t32 < -9007199254740992:
            st[0] = 1
            top[3] = 7000010
            return (0.0, False, 0.0, False, 0.0, False)
        t33 = t30
        if t33 > 9007199254740992 or t33 < -9007199254740992:
            st[0] = 1
            top[3] = 7000010
            return (0.0, False, 0.0, False, 0.0, False)
        t34 = float(t31)
        t35 = True
        t36 = float(t32)
        t37 = True
        t38 = float(t33)
        t39 = True
        t40 = I[np.uint64(v_self + 5)]
        t41 = sub_i(st, t40, 1)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        I[np.uint64(v_self + 5)] = t41
        return (t34, t35, t36, t37, t38, t39)
    else:
        if not v_i_4:
            st[0] = 1
            top[3] = 7000012
            return (0.0, False, 0.0, False, 0.0, False)
        v_o = v_i_0
        v_t_0 = v_i_1
        v_t_1 = v_i_2
        v_s = v_i_3
        t42 = v_ray
        t43_0 = f38_pointAtTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t42, v_t_0, v_t_1)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        v_p = t43_0
        t44 = v_s
        t45 = v_o
        t47 = I[t45]
        if t47 == 0:
            t48_0 = f51_normalAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t45, v_p)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            t46_0 = t48_0
        elif t47 == 1:
            t49_0 = f52_normalAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t45, v_p)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            t46_0 = t49_0
        else:
            st[0] = 1
            top[3] = 7000014
            return (0.0, False, 0.0, False, 0.0, False)
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 7000014
            return (0.0, False, 0.0, False, 0.0, False)
        t50_0, t50_1, t50_2, t50_3, t50_4, t50_5 = f54_colourAt_borrowed(_heap_ctx, np.int64(t44), np.int64(v_self), np.int64(v_ray), np.int64(v_p), np.int64(t46_0))
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        top[1] -= 1
        t51 = t50_0
        t52 = t50_1
        t53 = t50_2
        t54 = t50_3
        t55 = t50_4
        t56 = t50_5
        t57 = I[np.uint64(v_self + 5)]
        t58 = sub_i(st, t57, 1)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        I[np.uint64(v_self + 5)] = t58
        return (t51, t52, t53, t54, t55, t56)
    return (0.0, False, 0.0, False, 0.0, False)


@njit(error_model="numpy", inline="always")
def f71_plot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_x, v_y, v_r_0, v_r_1, v_g_0, v_g_1, v_b_0, v_b_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 1)]
    t2 = sub_i(st, t1, v_y)
    if st[0]:
        return
    t3 = sub_i(st, t2, 1)
    if st[0]:
        return
    t4 = I[np.uint64(v_self + 2)]
    t5 = mul_i(st, t3, t4)
    if st[0]:
        return
    t6 = add_i(st, t5, v_x)
    if st[0]:
        return
    t7 = mul_i(st, t6, 3)
    if st[0]:
        return
    v_i = t7
    t8 = v_r_0 * 255.0
    if math.fabs(t8) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 8000003
        return
    t9 = t8
    if not -9.223372036854776e+18 < t9 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 8000003
        return
    t10 = np.int64(t9)
    t11 = 255
    t12 = t10
    t13 = t12 if t12 < t11 else t11
    t14 = 0
    t15 = t13
    t16 = t15 if t15 > t14 else t14
    t17 = I[np.uint64(v_self + 0)]
    t18 = I[np.uint64(t17)]
    t19 = v_i
    if t19 < 0:
        t19 += t18
    if t19 < 0 or t19 >= t18:
        st[0] = 1
        top[3] = 8000003
        return
    t20 = I[np.uint64(t17 + 2)] + t19
    t21 = t16
    if t21 < 0 or t21 > 255:
        st[0] = 1
        top[3] = 8000003
        return
    I[np.uint64(t20)] = t21
    t22 = v_g_0 * 255.0
    if math.fabs(t22) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 8000004
        return
    t23 = t22
    if not -9.223372036854776e+18 < t23 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 8000004
        return
    t24 = np.int64(t23)
    t25 = 255
    t26 = t24
    t27 = t26 if t26 < t25 else t25
    t28 = 0
    t29 = t27
    t30 = t29 if t29 > t28 else t28
    t31 = I[np.uint64(v_self + 0)]
    t32 = add_i(st, v_i, 1)
    if st[0]:
        return
    t33 = I[np.uint64(t31)]
    t34 = t32
    if t34 < 0:
        t34 += t33
    if t34 < 0 or t34 >= t33:
        st[0] = 1
        top[3] = 8000004
        return
    t35 = I[np.uint64(t31 + 2)] + t34
    t36 = t30
    if t36 < 0 or t36 > 255:
        st[0] = 1
        top[3] = 8000004
        return
    I[np.uint64(t35)] = t36
    t37 = v_b_0 * 255.0
    if math.fabs(t37) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 8000005
        return
    t38 = t37
    if not -9.223372036854776e+18 < t38 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 8000005
        return
    t39 = np.int64(t38)
    t40 = 255
    t41 = t39
    t42 = t41 if t41 < t40 else t40
    t43 = 0
    t44 = t42
    t45 = t44 if t44 > t43 else t43
    t46 = I[np.uint64(v_self + 0)]
    t47 = add_i(st, v_i, 2)
    if st[0]:
        return
    t48 = I[np.uint64(t46)]
    t49 = t47
    if t49 < 0:
        t49 += t48
    if t49 < 0 or t49 >= t48:
        st[0] = 1
        top[3] = 8000005
        return
    t50 = I[np.uint64(t46 + 2)] + t49
    t51 = t45
    if t51 < 0 or t51 > 255:
        st[0] = 1
        top[3] = 8000005
        return
    I[np.uint64(t50)] = t51
    return


@njit(error_model="numpy", inline="always")
def f7_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return True
    return False


@njit(error_model="numpy", inline="always")
def f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_initx_0, v_initx_1, v_inity_0, v_inity_1, v_initz_0, v_initz_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    F[np.uint64(v_self + 0)] = v_initx_0
    F[np.uint64(v_self + 2)] = v_inity_0
    F[np.uint64(v_self + 4)] = v_initz_0
    return


@njit(error_model="numpy", inline="always")
def f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return v_self
    return -1


@njit(error_model="numpy", inline="always")
def f14_magnitude_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_self
    t2_0, t2_1 = f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, v_self)
    if st[0]:
        return 0.0
    t3 = t2_0
    if t3 < 0.0:
        st[0] = 1
        top[3] = 12000002
        return 0.0
    t4 = math.sqrt(t3)
    return t4
    return 0.0


@njit(error_model="numpy", inline="always")
def f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_initx, v_inity, v_initz):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    F[np.uint64(v_self + 0)] = v_initx
    F[np.uint64(v_self + 2)] = v_inity
    F[np.uint64(v_self + 4)] = v_initz
    return


@njit(error_model="numpy", inline="always")
def f29_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return False
    return False


@njit(error_model="numpy", inline="always")
def f32_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_ray):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 1)]
    t2 = I[np.uint64(v_ray + 0)]
    t3 = t1
    _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t3, t2)
    if st[0]:
        return (0.0, False)
    pass
    pass
    t6 = I[np.uint64(v_ray + 1)]
    t7_0, t7_1 = sr8_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4, t6)
    if st[0]:
        return (0.0, False)
    v_v_0 = t7_0
    v_v_1 = t7_1
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = F[np.uint64(v_self + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    pass
    t14_0, t14_1 = sr9_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4)
    if st[0]:
        return (0.0, False)
    t15 = v_v_0 * v_v_0
    if math.fabs(t15) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    t16 = t14_0 - t15
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    t17 = t12 - t16
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    v_discriminant_0 = t17
    v_discriminant_1 = True
    if v_discriminant_0 < 0.0:
        return (0.0, False)
    else:
        t18 = v_discriminant_0
        if t18 < 0.0:
            st[0] = 1
            top[3] = 15000008
            return (0.0, False)
        t19 = math.sqrt(t18)
        return (v_v_0 - t19, True)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def f34_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_ray):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_ray + 1)]
    t2 = t1
    t3 = I[np.uint64(v_self + 4)]
    t4_0, t4_1 = f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, t3)
    if st[0]:
        return (0.0, False)
    v_v_0 = t4_0
    v_v_1 = t4_1
    if v_v_0 != 0.0:
        t5 = -v_v_0
        t6 = t5
        if t6 == 0.0:
            st[0] = 1
            top[3] = 16000004
            return (0.0, False)
        return (1.0 / t6, True)
    else:
        return (0.0, False)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def f36_firstIntersection_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_intersections):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    v_result_0 = -1
    v_result_1 = 0.0
    v_result_2 = False
    v_result_3 = -1
    v_result_4 = False
    t1 = v_intersections
    t2 = 0
    while True:
        if t2 >= I[np.uint64(t1)]:
            break
        t3 = I[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 0]
        t4 = F[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 1]
        t5 = I[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 1 + 1] != 0
        t6 = I[I[np.uint64(I[np.uint64(t1 + 2)] + t2)] + 3]
        t2 += 1
        v_i_0 = t3
        v_i_1 = t4
        v_i_2 = t5
        v_i_3 = t6
        v_candidateT_0 = v_i_1
        v_candidateT_1 = v_i_2
        t7 = not not v_candidateT_1
        if t7:
            if not v_candidateT_1:
                st[0] = 1
                top[3] = 17000005
                return (-1, 0.0, False, -1, False)
            t7 = v_candidateT_0 > -1e-05
        if t7:
            t8 = not v_result_4
            if not t8:
                if not v_result_4:
                    st[0] = 1
                    top[3] = 17000006
                    return (-1, 0.0, False, -1, False)
                if not v_candidateT_1:
                    st[0] = 1
                    top[3] = 17000006
                    return (-1, 0.0, False, -1, False)
                if not v_result_2:
                    st[0] = 1
                    top[3] = 17000006
                    return (-1, 0.0, False, -1, False)
                t8 = v_candidateT_0 < v_result_1
            if t8:
                v_result_0 = v_i_0
                v_result_1 = v_i_1
                v_result_2 = v_i_2
                v_result_3 = v_i_3
                v_result_4 = True
    return (v_result_0, v_result_1, v_result_2, v_result_3, v_result_4)
    return (-1, 0.0, False, -1, False)


@njit(error_model="numpy", inline="always")
def f38_pointAtTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_t_0, v_t_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 0)]
    t2 = I[np.uint64(v_self + 1)]
    t3 = t2
    _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4 = sr13_f16_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t3, v_t_0, v_t_1)
    if st[0]:
        return -1
    t5 = t1
    t6_0 = sr14_f48___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t5, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4)
    if st[0]:
        return -1
    return t6_0
    return -1


@njit(error_model="numpy", inline="always")
def f51_normalAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_p):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 1)]
    t2 = v_p
    _sr_call_t3_0_F0, _sr_call_t3_0_F2, _sr_call_t3_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, t1)
    if st[0]:
        return -1
    pass
    t5_0 = sr25_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t3_0_F0, _sr_call_t3_0_F2, _sr_call_t3_0_F4)
    if st[0]:
        return -1
    return t5_0
    return -1


@njit(error_model="numpy", inline="always")
def f52_normalAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_p):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 4)]
    return t1
    return -1


@njit(error_model="numpy")
def f54_colourAt_borrowed(_heap_ctx, v_self, v_scene, v_ray, v_p, v_normal):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_self
    t3 = I[t1]
    if t3 == 0:
        t4_0, t4_1, t4_2, t4_3, t4_4, t4_5 = f56_baseColourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, v_p)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        t2_0 = t4_0
        t2_1 = t4_1
        t2_2 = t4_2
        t2_3 = t4_3
        t2_4 = t4_4
        t2_5 = t4_5
    elif t3 == 1:
        t5_0, t5_1, t5_2, t5_3, t5_4, t5_5 = f58_baseColourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, v_p)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        t2_0 = t5_0
        t2_1 = t5_1
        t2_2 = t5_2
        t2_3 = t5_3
        t2_4 = t5_4
        t2_5 = t5_5
    else:
        st[0] = 1
        top[3] = 21000002
        return (0.0, False, 0.0, False, 0.0, False)
    v_b_0 = t2_0
    v_b_1 = t2_1
    v_b_2 = t2_2
    v_b_3 = t2_3
    v_b_4 = t2_4
    v_b_5 = t2_5
    t6 = 0
    t7 = 0
    t8 = 0
    t9 = t6
    if t9 > 9007199254740992 or t9 < -9007199254740992:
        st[0] = 1
        top[3] = 21000004
        return (0.0, False, 0.0, False, 0.0, False)
    t10 = t7
    if t10 > 9007199254740992 or t10 < -9007199254740992:
        st[0] = 1
        top[3] = 21000004
        return (0.0, False, 0.0, False, 0.0, False)
    t11 = t8
    if t11 > 9007199254740992 or t11 < -9007199254740992:
        st[0] = 1
        top[3] = 21000004
        return (0.0, False, 0.0, False, 0.0, False)
    v_c_0 = float(t9)
    v_c_1 = True
    v_c_2 = float(t10)
    v_c_3 = True
    v_c_4 = float(t11)
    v_c_5 = True
    t12 = F[np.uint64(v_self + 4)]
    if t12 > 0.0:
        t13 = I[np.uint64(v_ray + 1)]
        t14 = t13
        _sr_call_t15_0_F0, _sr_call_t15_0_F2, _sr_call_t15_0_F4 = sr18_f60_reflectThrough_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t14, v_normal)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        _sr_t16_I0 = np.int64(0)
        _sr_t16_I1 = np.int64(0)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        _sr_t16_I0, _sr_t16_I1 = sr30_f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t16_I0, _sr_t16_I1, v_p, _sr_call_t15_0_F0, _sr_call_t15_0_F2, _sr_call_t15_0_F4)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        pass
        t17 = v_scene
        top[1] += 1
        if top[1] > top[2]:
            st[0] = 1
            top[3] = 21000007
            return (0.0, False, 0.0, False, 0.0, False)
        t18_0, t18_1, t18_2, t18_3, t18_4, t18_5 = sr4_f30_rayColour_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, np.int64(t17), _sr_t16_I0, _sr_t16_I1)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        top[1] -= 1
        v_reflectedColour_0 = t18_0
        v_reflectedColour_1 = t18_1
        v_reflectedColour_2 = t18_2
        v_reflectedColour_3 = t18_3
        v_reflectedColour_4 = t18_4
        v_reflectedColour_5 = t18_5
        t19 = F[np.uint64(v_self + 4)]
        t20_0, t20_1, t20_2 = f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_c_0, v_c_1, v_c_2, v_c_3, v_c_4, v_c_5, t19, v_reflectedColour_0, v_reflectedColour_1, v_reflectedColour_2, v_reflectedColour_3, v_reflectedColour_4, v_reflectedColour_5)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        v_c_0 = t20_0
        v_c_1 = False
        v_c_2 = t20_1
        v_c_3 = False
        v_c_4 = t20_2
        v_c_5 = False
    t21 = F[np.uint64(v_self + 3)]
    if t21 > 0.0:
        v_lambertAmount_0 = 0.0
        v_lambertAmount_1 = True
        t22 = v_scene
        t23_0 = f63_visibleLights_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t22, v_p)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        t24 = t23_0
        t25 = 0
        while True:
            if t25 >= I[np.uint64(t24)]:
                break
            t26 = I[np.uint64(I[np.uint64(t24 + 2)] + t25)]
            t25 += 1
            v_lightPoint = t26
            t27 = v_lightPoint
            _sr_call_t28_0_F0, _sr_call_t28_0_F2, _sr_call_t28_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t27, v_p)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            pass
            _sr_call_t30_0_F0, _sr_call_t30_0_F2, _sr_call_t30_0_F4 = sr29_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t28_0_F0, _sr_call_t28_0_F2, _sr_call_t28_0_F4)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            pass
            t32_0, t32_1 = sr8_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t30_0_F0, _sr_call_t30_0_F2, _sr_call_t30_0_F4, v_normal)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False)
            v_contribution_0 = t32_0
            v_contribution_1 = t32_1
            if v_contribution_0 > 0.0:
                t33 = v_lambertAmount_0 + v_contribution_0
                if math.fabs(t33) >= 9007199254740992.0:
                    st[0] = 1
                    top[3] = 21000015
                    return (0.0, False, 0.0, False, 0.0, False)
                v_lambertAmount_0 = t33
                v_lambertAmount_1 = True
        t34 = 1.0
        t35 = True
        t36 = v_lambertAmount_0
        t37 = v_lambertAmount_1
        t38 = t36 < t34
        t39 = t36 if t38 else t34
        t40 = t37 if t38 else t35
        v_lambertAmount_0 = t39
        v_lambertAmount_1 = t40
        t41 = F[np.uint64(v_self + 3)]
        t42_0, t42_1, t42_2 = f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_c_0, v_c_1, v_c_2, v_c_3, v_c_4, v_c_5, t41 * v_lambertAmount_0, v_b_0, v_b_1, v_b_2, v_b_3, v_b_4, v_b_5)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        v_c_0 = t42_0
        v_c_1 = False
        v_c_2 = t42_1
        v_c_3 = False
        v_c_4 = t42_2
        v_c_5 = False
    t43 = F[np.uint64(v_self + 1)]
    if t43 > 0.0:
        t44 = F[np.uint64(v_self + 1)]
        t45_0, t45_1, t45_2 = f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_c_0, v_c_1, v_c_2, v_c_3, v_c_4, v_c_5, t44, v_b_0, v_b_1, v_b_2, v_b_3, v_b_4, v_b_5)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False)
        v_c_0 = t45_0
        v_c_1 = False
        v_c_2 = t45_1
        v_c_3 = False
        v_c_4 = t45_2
        v_c_5 = False
    return (v_c_0, v_c_1, v_c_2, v_c_3, v_c_4, v_c_5)
    return (0.0, False, 0.0, False, 0.0, False)


@njit(error_model="numpy", inline="always")
def f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return (0.0, False)
    t3 = F[np.uint64(v_self + 0)]
    t4 = True
    t5 = F[np.uint64(v_other + 0)]
    t6 = True
    t7 = t3 * t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t13 = t7 + t12
    if math.fabs(t13) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t14 = F[np.uint64(v_self + 4)]
    t15 = True
    t16 = F[np.uint64(v_other + 4)]
    t17 = True
    t18 = t14 * t16
    if math.fabs(t18) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t19 = t13 + t18
    if math.fabs(t19) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    return (t19, True)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def f16_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_factor_0, v_factor_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 0)]
    t2 = True
    if not v_factor_1:
        st[0] = 1
        top[3] = 23000002
        return -1
    t3 = F[np.uint64(v_self + 2)]
    t4 = True
    if not v_factor_1:
        st[0] = 1
        top[3] = 23000002
        return -1
    t5 = F[np.uint64(v_self + 4)]
    t6 = True
    if not v_factor_1:
        st[0] = 1
        top[3] = 23000002
        return -1
    t7 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, v_factor_0 * t1, v_factor_0 * t3, v_factor_0 * t5)
    if st[0]:
        return -1
    return t7
    return -1


@njit(error_model="numpy", inline="always")
def f48___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return -1
    t3 = F[np.uint64(v_self + 0)]
    t4 = True
    t5 = F[np.uint64(v_other + 0)]
    t6 = True
    t7 = t3 + t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 24000003
        return -1
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 + t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 24000003
        return -1
    t13 = F[np.uint64(v_self + 4)]
    t14 = True
    t15 = F[np.uint64(v_other + 4)]
    t16 = True
    t17 = t13 + t15
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 24000003
        return -1
    t18 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f50___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t18, t7, True, t12, True, t17, True)
    if st[0]:
        return -1
    return t18
    return -1


@njit(error_model="numpy", inline="always")
def f56_baseColourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_p):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[I[np.uint64(v_self + 2)] + 0]
    t2 = True
    t3 = F[I[np.uint64(v_self + 2)] + 2]
    t4 = True
    t5 = F[I[np.uint64(v_self + 2)] + 4]
    t6 = True
    return (t1, t2, t3, t4, t5, t6)
    return (0.0, False, 0.0, False, 0.0, False)


@njit(error_model="numpy", inline="always")
def f58_baseColourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_p):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_p
    _sr_call_t2_0_F0, _sr_call_t2_0_F2, _sr_call_t2_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, I[1])
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    pass
    pass
    t4 = I[np.uint64(v_self + 5)]
    t5 = float(t4)
    if t5 == 0.0:
        st[0] = 1
        top[3] = 26000003
        return (0.0, False, 0.0, False, 0.0, False)
    _sr_call_t6_0_F0, _sr_call_t6_0_F2, _sr_call_t6_0_F4 = sr28_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t2_0_F0, _sr_call_t2_0_F2, _sr_call_t2_0_F4, 1.0 / t5)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    t7 = _sr_call_t2_0_F0
    t8 = True
    t9 = math.fabs(t7)
    t10 = t9 + 0.5
    if not -9.223372036854776e+18 < t10 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 26000004
        return (0.0, False, 0.0, False, 0.0, False)
    t11 = np.int64(t10)
    t12 = _sr_call_t2_0_F2
    t13 = True
    t14 = math.fabs(t12)
    t15 = t14 + 0.5
    if not -9.223372036854776e+18 < t15 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 26000004
        return (0.0, False, 0.0, False, 0.0, False)
    t16 = np.int64(t15)
    t17 = add_i(st, t11, t16)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    t18 = _sr_call_t2_0_F4
    t19 = True
    t20 = math.fabs(t18)
    t21 = t20 + 0.5
    if not -9.223372036854776e+18 < t21 < 9.223372036854776e+18:
        st[0] = 1
        top[3] = 26000004
        return (0.0, False, 0.0, False, 0.0, False)
    t22 = np.int64(t21)
    t23 = add_i(st, t17, t22)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    t24 = mod_i(st, t23, 2)
    if st[0]:
        return (0.0, False, 0.0, False, 0.0, False)
    if t24 != 0:
        t25 = I[I[np.uint64(v_self + 6)] + 0]
        t26 = I[I[np.uint64(v_self + 6)] + 1]
        t27 = I[I[np.uint64(v_self + 6)] + 2]
        t28 = t25
        if t28 > 9007199254740992 or t28 < -9007199254740992:
            st[0] = 1
            top[3] = 26000007
            return (0.0, False, 0.0, False, 0.0, False)
        t29 = t26
        if t29 > 9007199254740992 or t29 < -9007199254740992:
            st[0] = 1
            top[3] = 26000007
            return (0.0, False, 0.0, False, 0.0, False)
        t30 = t27
        if t30 > 9007199254740992 or t30 < -9007199254740992:
            st[0] = 1
            top[3] = 26000007
            return (0.0, False, 0.0, False, 0.0, False)
        return (float(t28), True, float(t29), True, float(t30), True)
    else:
        t31 = F[I[np.uint64(v_self + 2)] + 0]
        t32 = True
        t33 = F[I[np.uint64(v_self + 2)] + 2]
        t34 = True
        t35 = F[I[np.uint64(v_self + 2)] + 4]
        t36 = True
        return (t31, t32, t33, t34, t35, t36)
    return (0.0, False, 0.0, False, 0.0, False)


@njit(error_model="numpy", inline="always")
def f60_reflectThrough_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_normal):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_normal
    t2 = v_self
    t3_0, t3_1 = f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, v_normal)
    if st[0]:
        return -1
    _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4 = sr20_f64_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, t3_0, t3_1)
    if st[0]:
        return -1
    pass
    pass
    _sr_call_t6_0_F0, _sr_call_t6_0_F2, _sr_call_t6_0_F4 = sr22_f68_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4, 2)
    if st[0]:
        return -1
    t7 = v_self
    t8_0 = sr45_f70___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, _sr_call_t6_0_F0, _sr_call_t6_0_F2, _sr_call_t6_0_F4)
    if st[0]:
        return -1
    return t8_0
    return -1


@njit(error_model="numpy", inline="always")
def f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_a_0, v_a_1, v_a_2, v_a_3, v_a_4, v_a_5, v_scale, v_b_0, v_b_1, v_b_2, v_b_3, v_b_4, v_b_5):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_a_0 + v_scale * v_b_0
    t2 = v_a_2 + v_scale * v_b_2
    t3 = v_a_4 + v_scale * v_b_4
    return (t1, t2, t3)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def f63_visibleLights_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_p):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = list_new(I, top, st, 0, 0)
    if st[0]:
        return -1
    v_result = t1
    t2 = I[np.uint64(v_self + 1)]
    t3 = t2
    t4 = 0
    while True:
        if t4 >= I[np.uint64(t3)]:
            break
        t5 = I[np.uint64(I[np.uint64(t3 + 2)] + t4)]
        t4 += 1
        v_l = t5
        t6 = v_self
        t7_0 = f66__lightIsVisible_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t6, v_l, v_p)
        if st[0]:
            return -1
        if t7_0:
            t8 = list_room(I, top, st, v_result)
            if st[0]:
                return -1
            I[t8] = v_l
    return v_result
    return -1


@njit(error_model="numpy", inline="always")
def f50___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_initx_0, v_initx_1, v_inity_0, v_inity_1, v_initz_0, v_initz_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    F[np.uint64(v_self + 0)] = v_initx_0
    F[np.uint64(v_self + 2)] = v_inity_0
    F[np.uint64(v_self + 4)] = v_initz_0
    return


@njit(error_model="numpy", inline="always")
def f64_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_factor_0, v_factor_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 0)]
    t2 = True
    t3 = v_factor_0 * t1
    if math.fabs(t3) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 31000002
        return -1
    t4 = F[np.uint64(v_self + 2)]
    t5 = True
    t6 = v_factor_0 * t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 31000002
        return -1
    t7 = F[np.uint64(v_self + 4)]
    t8 = True
    t9 = v_factor_0 * t7
    if math.fabs(t9) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 31000002
        return -1
    t10 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t10, t3, True, t6, True, t9, True)
    if st[0]:
        return -1
    return t10
    return -1


@njit(error_model="numpy", inline="always")
def f68_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_factor):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 0)]
    t2 = True
    t3 = v_factor
    if t3 > 9007199254740992 or t3 < -9007199254740992:
        st[0] = 1
        top[3] = 32000002
        return -1
    t4 = float(t3) * t1
    if math.fabs(t4) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 32000002
        return -1
    t5 = F[np.uint64(v_self + 2)]
    t6 = True
    t7 = v_factor
    if t7 > 9007199254740992 or t7 < -9007199254740992:
        st[0] = 1
        top[3] = 32000002
        return -1
    t8 = float(t7) * t5
    if math.fabs(t8) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 32000002
        return -1
    t9 = F[np.uint64(v_self + 4)]
    t10 = True
    t11 = v_factor
    if t11 > 9007199254740992 or t11 < -9007199254740992:
        st[0] = 1
        top[3] = 32000002
        return -1
    t12 = float(t11) * t9
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 32000002
        return -1
    t13 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t13, t4, True, t8, True, t12, True)
    if st[0]:
        return -1
    return t13
    return -1


@njit(error_model="numpy", inline="always")
def f70___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return -1
    t3 = F[np.uint64(v_self + 0)]
    t4 = True
    t5 = F[np.uint64(v_other + 0)]
    t6 = True
    t7 = t3 - t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return -1
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 - t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return -1
    t13 = F[np.uint64(v_self + 4)]
    t14 = True
    t15 = F[np.uint64(v_other + 4)]
    t16 = True
    t17 = t13 - t15
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return -1
    t18 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t18, t7, True, t12, True, t17, True)
    if st[0]:
        return -1
    return t18
    return -1


@njit(error_model="numpy", inline="always")
def f66__lightIsVisible_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_l, v_p):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 3)]
    t2 = t1
    t3 = 0
    while True:
        if t3 >= I[np.uint64(t2)]:
            break
        t4 = I[I[np.uint64(I[np.uint64(t2 + 2)] + t3)] + 0]
        t5 = I[I[np.uint64(I[np.uint64(t2 + 2)] + t3)] + 1]
        t3 += 1
        v_o = t4
        v_s = t5
        t6 = v_o
        t7 = v_l
        _sr_call_t8_0_F0, _sr_call_t8_0_F2, _sr_call_t8_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, v_p)
        if st[0]:
            return False
        _sr_t9_I0 = np.int64(0)
        _sr_t9_I1 = np.int64(0)
        if st[0]:
            return False
        _sr_t9_I0, _sr_t9_I1 = sr30_f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t9_I0, _sr_t9_I1, v_p, _sr_call_t8_0_F0, _sr_call_t8_0_F2, _sr_call_t8_0_F4)
        if st[0]:
            return False
        t11 = I[t6]
        if t11 == 0:
            t12_0, t12_1 = sr5_f32_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t6, _sr_t9_I0, _sr_t9_I1)
            if st[0]:
                return False
            t10_0 = t12_0
            t10_1 = t12_1
        elif t11 == 1:
            t13_0, t13_1 = sr11_f34_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t6, _sr_t9_I0, _sr_t9_I1)
            if st[0]:
                return False
            t10_0 = t13_0
            t10_1 = t13_1
        else:
            st[0] = 1
            top[3] = 34000003
            return False
        v_t_0 = t10_0
        v_t_1 = t10_1
        t14 = not not v_t_1
        if t14:
            if not v_t_1:
                st[0] = 1
                top[3] = 34000004
                return False
            t14 = v_t_0 > 1e-05
        if t14:
            return False
    return True
    return False


@njit(error_model="numpy", inline="always")
def sr3_f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_initx, v_inity, v_initz):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    v_sr0_F0 = v_initx
    v_sr0_F2 = v_inity
    v_sr0_F4 = v_initz
    return (v_sr0_F0, v_sr0_F2, v_sr0_F4)


@njit(error_model="numpy", inline="always")
def sr4_f30_rayColour_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_I0, v_sr0_I1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return s0_sr4_f30_rayColour_borrowed(_heap_ctx, np.int64(0), np.int64(v_self), np.int64(v_sr0_I0), np.int64(v_sr0_I1), np.int64(0), np.int64(0), np.int64(0), np.int64(0), np.int64(0), np.int64(0))[0:6]


@njit(error_model="numpy", inline="always")
def sr5_f32_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_I0, v_sr0_I1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = I[np.uint64(v_self + 1)]
    t2 = v_sr0_I0
    t3 = t1
    _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t3, t2)
    if st[0]:
        return (0.0, False)
    pass
    pass
    t6 = v_sr0_I1
    t7_0, t7_1 = sr8_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4, t6)
    if st[0]:
        return (0.0, False)
    v_v_0 = t7_0
    v_v_1 = t7_1
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = F[np.uint64(v_self + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    pass
    t14_0, t14_1 = sr9_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4)
    if st[0]:
        return (0.0, False)
    t15 = v_v_0 * v_v_0
    if math.fabs(t15) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    t16 = t14_0 - t15
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    t17 = t12 - t16
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 15000004
        return (0.0, False)
    v_discriminant_0 = t17
    v_discriminant_1 = True
    if v_discriminant_0 < 0.0:
        return (0.0, False)
    else:
        t18 = v_discriminant_0
        if t18 < 0.0:
            st[0] = 1
            top[3] = 15000008
            return (0.0, False)
        t19 = math.sqrt(t18)
        return (v_v_0 - t19, True)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    f7_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t2 = F[np.uint64(v_self + 0)]
    t3 = True
    t4 = F[np.uint64(v_other + 0)]
    t5 = True
    t6 = t2 - t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 1000003
        return (0.0, 0.0, 0.0)
    t7 = F[np.uint64(v_self + 2)]
    t8 = True
    t9 = F[np.uint64(v_other + 2)]
    t10 = True
    t11 = t7 - t9
    if math.fabs(t11) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 1000003
        return (0.0, 0.0, 0.0)
    t12 = F[np.uint64(v_self + 4)]
    t13 = True
    t14 = F[np.uint64(v_other + 4)]
    t15 = True
    t16 = t12 - t14
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 1000003
        return (0.0, 0.0, 0.0)
    _sr_t17_F0 = 0.0
    _sr_t17_F2 = 0.0
    _sr_t17_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t17_F0, _sr_t17_F2, _sr_t17_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t17_F0, _sr_t17_F2, _sr_t17_F4, t6, True, t11, True, t16, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t17_F0, _sr_t17_F2, _sr_t17_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_initx_0, v_initx_1, v_inity_0, v_inity_1, v_initz_0, v_initz_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    v_sr0_F0 = v_initx_0
    v_sr0_F2 = v_inity_0
    v_sr0_F4 = v_initz_0
    return (v_sr0_F0, v_sr0_F2, v_sr0_F4)


@njit(error_model="numpy", inline="always")
def sr8_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return (0.0, False)
    t3 = v_sr0_F0
    t4 = True
    t5 = F[np.uint64(v_other + 0)]
    t6 = True
    t7 = t3 * t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t8 = v_sr0_F2
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t13 = t7 + t12
    if math.fabs(t13) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t14 = v_sr0_F4
    t15 = True
    t16 = F[np.uint64(v_other + 4)]
    t17 = True
    t18 = t14 * t16
    if math.fabs(t18) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t19 = t13 + t18
    if math.fabs(t19) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    return (t19, True)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def sr9_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    sr10_f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return (0.0, False)
    t3 = v_sr0_F0
    t4 = True
    t5 = v_sr0_F0
    t6 = True
    t7 = t3 * t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t8 = v_sr0_F2
    t9 = True
    t10 = v_sr0_F2
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t13 = t7 + t12
    if math.fabs(t13) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t14 = v_sr0_F4
    t15 = True
    t16 = v_sr0_F4
    t17 = True
    t18 = t14 * t16
    if math.fabs(t18) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    t19 = t13 + t18
    if math.fabs(t19) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 22000003
        return (0.0, False)
    return (t19, True)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def sr10_f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return
    return


@njit(error_model="numpy", inline="always")
def sr11_f34_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_I0, v_sr0_I1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_I1
    t2 = t1
    t3 = I[np.uint64(v_self + 4)]
    t4_0, t4_1 = f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, t3)
    if st[0]:
        return (0.0, False)
    v_v_0 = t4_0
    v_v_1 = t4_1
    if v_v_0 != 0.0:
        t5 = -v_v_0
        t6 = t5
        if t6 == 0.0:
            st[0] = 1
            top[3] = 16000004
            return (0.0, False)
        return (1.0 / t6, True)
    else:
        return (0.0, False)
    return (0.0, False)


@njit(error_model="numpy", inline="always")
def sr12_f38_pointAtTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_I0, v_sr0_I1, v_t_0, v_t_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_I0
    t2 = v_sr0_I1
    t3 = t2
    _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4 = sr13_f16_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t3, v_t_0, v_t_1)
    if st[0]:
        return -1
    t5 = t1
    t6_0 = sr14_f48___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t5, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4)
    if st[0]:
        return -1
    return t6_0
    return -1


@njit(error_model="numpy", inline="always")
def sr13_f16_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_factor_0, v_factor_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 0)]
    t2 = True
    if not v_factor_1:
        st[0] = 1
        top[3] = 23000002
        return (0.0, 0.0, 0.0)
    t3 = F[np.uint64(v_self + 2)]
    t4 = True
    if not v_factor_1:
        st[0] = 1
        top[3] = 23000002
        return (0.0, 0.0, 0.0)
    t5 = F[np.uint64(v_self + 4)]
    t6 = True
    if not v_factor_1:
        st[0] = 1
        top[3] = 23000002
        return (0.0, 0.0, 0.0)
    _sr_t7_F0 = 0.0
    _sr_t7_F2 = 0.0
    _sr_t7_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t7_F0, _sr_t7_F2, _sr_t7_F4 = sr3_f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t7_F0, _sr_t7_F2, _sr_t7_F4, v_factor_0 * t1, v_factor_0 * t3, v_factor_0 * t5)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t7_F0, _sr_t7_F2, _sr_t7_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr14_f48___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    sr10_f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return -1
    t3 = F[np.uint64(v_self + 0)]
    t4 = True
    t5 = v_sr0_F0
    t6 = True
    t7 = t3 + t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 24000003
        return -1
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = v_sr0_F2
    t11 = True
    t12 = t8 + t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 24000003
        return -1
    t13 = F[np.uint64(v_self + 4)]
    t14 = True
    t15 = v_sr0_F4
    t16 = True
    t17 = t13 + t15
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 24000003
        return -1
    t18 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f50___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t18, t7, True, t12, True, t17, True)
    if st[0]:
        return -1
    return t18
    return -1


@njit(error_model="numpy", inline="always")
def sr17_f54_colourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_scene, v_sr0_I0, v_sr0_I1, v_p, v_normal):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return s0_sr4_f30_rayColour_borrowed(_heap_ctx, np.int64(1), np.int64(0), np.int64(0), np.int64(0), np.int64(v_self), np.int64(v_scene), np.int64(v_sr0_I0), np.int64(v_sr0_I1), np.int64(v_p), np.int64(v_normal))[6:12]


@njit(error_model="numpy", inline="always")
def sr18_f60_reflectThrough_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_normal):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_normal
    t2 = v_self
    t3_0, t3_1 = f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t2, v_normal)
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4 = sr20_f64_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1, t3_0, t3_1)
    if st[0]:
        return (0.0, 0.0, 0.0)
    pass
    pass
    _sr_call_t6_0_F0, _sr_call_t6_0_F2, _sr_call_t6_0_F4 = sr22_f68_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_call_t4_0_F0, _sr_call_t4_0_F2, _sr_call_t4_0_F4, 2)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t7 = v_self
    _sr_call_t8_0_F0, _sr_call_t8_0_F2, _sr_call_t8_0_F4 = sr23_f70___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, _sr_call_t6_0_F0, _sr_call_t6_0_F2, _sr_call_t6_0_F4)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_call_t8_0_F0, _sr_call_t8_0_F2, _sr_call_t8_0_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr20_f64_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_factor_0, v_factor_1):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = F[np.uint64(v_self + 0)]
    t2 = True
    t3 = v_factor_0 * t1
    if math.fabs(t3) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 31000002
        return (0.0, 0.0, 0.0)
    t4 = F[np.uint64(v_self + 2)]
    t5 = True
    t6 = v_factor_0 * t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 31000002
        return (0.0, 0.0, 0.0)
    t7 = F[np.uint64(v_self + 4)]
    t8 = True
    t9 = v_factor_0 * t7
    if math.fabs(t9) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 31000002
        return (0.0, 0.0, 0.0)
    _sr_t10_F0 = 0.0
    _sr_t10_F2 = 0.0
    _sr_t10_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t10_F0, _sr_t10_F2, _sr_t10_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t10_F0, _sr_t10_F2, _sr_t10_F4, t3, True, t6, True, t9, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t10_F0, _sr_t10_F2, _sr_t10_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr22_f68_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_factor):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_F0
    t2 = True
    t3 = v_factor
    if t3 > 9007199254740992 or t3 < -9007199254740992:
        st[0] = 1
        top[3] = 32000002
        return (0.0, 0.0, 0.0)
    t4 = float(t3) * t1
    if math.fabs(t4) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 32000002
        return (0.0, 0.0, 0.0)
    t5 = v_sr0_F2
    t6 = True
    t7 = v_factor
    if t7 > 9007199254740992 or t7 < -9007199254740992:
        st[0] = 1
        top[3] = 32000002
        return (0.0, 0.0, 0.0)
    t8 = float(t7) * t5
    if math.fabs(t8) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 32000002
        return (0.0, 0.0, 0.0)
    t9 = v_sr0_F4
    t10 = True
    t11 = v_factor
    if t11 > 9007199254740992 or t11 < -9007199254740992:
        st[0] = 1
        top[3] = 32000002
        return (0.0, 0.0, 0.0)
    t12 = float(t11) * t9
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 32000002
        return (0.0, 0.0, 0.0)
    _sr_t13_F0 = 0.0
    _sr_t13_F2 = 0.0
    _sr_t13_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t13_F0, _sr_t13_F2, _sr_t13_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t13_F0, _sr_t13_F2, _sr_t13_F4, t4, True, t8, True, t12, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t13_F0, _sr_t13_F2, _sr_t13_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr23_f70___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    sr10_f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t3 = F[np.uint64(v_self + 0)]
    t4 = True
    t5 = v_sr0_F0
    t6 = True
    t7 = t3 - t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return (0.0, 0.0, 0.0)
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = v_sr0_F2
    t11 = True
    t12 = t8 - t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return (0.0, 0.0, 0.0)
    t13 = F[np.uint64(v_self + 4)]
    t14 = True
    t15 = v_sr0_F4
    t16 = True
    t17 = t13 - t15
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return (0.0, 0.0, 0.0)
    _sr_t18_F0 = 0.0
    _sr_t18_F2 = 0.0
    _sr_t18_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t18_F0, _sr_t18_F2, _sr_t18_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t18_F0, _sr_t18_F2, _sr_t18_F4, t7, True, t12, True, t17, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t18_F0, _sr_t18_F2, _sr_t18_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr25_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    pass
    t3_0 = sr26_f14_magnitude_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return -1
    t4 = t3_0
    if t4 == 0.0:
        st[0] = 1
        top[3] = 4000002
        return -1
    t5_0 = sr27_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, 1.0 / t4)
    if st[0]:
        return -1
    return t5_0
    return -1


@njit(error_model="numpy", inline="always")
def sr26_f14_magnitude_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    t2_0, t2_1 = sr9_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return 0.0
    t3 = t2_0
    if t3 < 0.0:
        st[0] = 1
        top[3] = 12000002
        return 0.0
    t4 = math.sqrt(t3)
    return t4
    return 0.0


@njit(error_model="numpy", inline="always")
def sr27_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_factor):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_F0
    t2 = True
    t3 = v_sr0_F2
    t4 = True
    t5 = v_sr0_F4
    t6 = True
    t7 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t7, v_factor * t1, v_factor * t3, v_factor * t5)
    if st[0]:
        return -1
    return t7
    return -1


@njit(error_model="numpy", inline="always")
def sr28_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_factor):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_sr0_F0
    t2 = True
    t3 = v_sr0_F2
    t4 = True
    t5 = v_sr0_F4
    t6 = True
    _sr_t7_F0 = 0.0
    _sr_t7_F2 = 0.0
    _sr_t7_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t7_F0, _sr_t7_F2, _sr_t7_F4 = sr3_f22___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t7_F0, _sr_t7_F2, _sr_t7_F4, v_factor * t1, v_factor * t3, v_factor * t5)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t7_F0, _sr_t7_F2, _sr_t7_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr29_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    pass
    t3_0 = sr26_f14_magnitude_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t4 = t3_0
    if t4 == 0.0:
        st[0] = 1
        top[3] = 4000002
        return (0.0, 0.0, 0.0)
    _sr_call_t5_0_F0, _sr_call_t5_0_F2, _sr_call_t5_0_F4 = sr28_f21_scale_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, 1.0 / t4)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_call_t5_0_F0, _sr_call_t5_0_F2, _sr_call_t5_0_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr30_f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_I0, v_sr0_I1, v_point, v_sr1_F0, v_sr1_F2, v_sr1_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    v_sr0_I0 = v_point
    pass
    t2_0 = sr25_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr1_F0, v_sr1_F2, v_sr1_F4)
    if st[0]:
        return (v_sr0_I0, v_sr0_I1)
    v_sr0_I1 = t2_0
    return (v_sr0_I0, v_sr0_I1)


@njit(error_model="numpy", inline="always")
def sr36_f24_cross_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t3 = F[np.uint64(v_self + 2)]
    t4 = True
    t5 = F[np.uint64(v_other + 4)]
    t6 = True
    t7 = t3 * t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t8 = F[np.uint64(v_self + 4)]
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t13 = t7 - t12
    if math.fabs(t13) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t14 = F[np.uint64(v_self + 4)]
    t15 = True
    t16 = F[np.uint64(v_other + 0)]
    t17 = True
    t18 = t14 * t16
    if math.fabs(t18) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t19 = F[np.uint64(v_self + 0)]
    t20 = True
    t21 = F[np.uint64(v_other + 4)]
    t22 = True
    t23 = t19 * t21
    if math.fabs(t23) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t24 = t18 - t23
    if math.fabs(t24) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t25 = F[np.uint64(v_self + 0)]
    t26 = True
    t27 = F[np.uint64(v_other + 2)]
    t28 = True
    t29 = t25 * t27
    if math.fabs(t29) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t30 = F[np.uint64(v_self + 2)]
    t31 = True
    t32 = F[np.uint64(v_other + 0)]
    t33 = True
    t34 = t30 * t32
    if math.fabs(t34) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t35 = t29 - t34
    if math.fabs(t35) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    _sr_t36_F0 = 0.0
    _sr_t36_F2 = 0.0
    _sr_t36_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t36_F0, _sr_t36_F2, _sr_t36_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t36_F0, _sr_t36_F2, _sr_t36_F4, t13, True, t24, True, t35, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t36_F0, _sr_t36_F2, _sr_t36_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr38_f24_cross_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_other):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    t1 = v_other
    t2_0 = f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t1)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t3 = v_sr0_F2
    t4 = True
    t5 = F[np.uint64(v_other + 4)]
    t6 = True
    t7 = t3 * t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t8 = v_sr0_F4
    t9 = True
    t10 = F[np.uint64(v_other + 2)]
    t11 = True
    t12 = t8 * t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t13 = t7 - t12
    if math.fabs(t13) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t14 = v_sr0_F4
    t15 = True
    t16 = F[np.uint64(v_other + 0)]
    t17 = True
    t18 = t14 * t16
    if math.fabs(t18) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t19 = v_sr0_F0
    t20 = True
    t21 = F[np.uint64(v_other + 4)]
    t22 = True
    t23 = t19 * t21
    if math.fabs(t23) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t24 = t18 - t23
    if math.fabs(t24) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t25 = v_sr0_F0
    t26 = True
    t27 = F[np.uint64(v_other + 2)]
    t28 = True
    t29 = t25 * t27
    if math.fabs(t29) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t30 = v_sr0_F2
    t31 = True
    t32 = F[np.uint64(v_other + 0)]
    t33 = True
    t34 = t30 * t32
    if math.fabs(t34) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    t35 = t29 - t34
    if math.fabs(t35) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 3000003
        return (0.0, 0.0, 0.0)
    _sr_t36_F0 = 0.0
    _sr_t36_F2 = 0.0
    _sr_t36_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t36_F0, _sr_t36_F2, _sr_t36_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t36_F0, _sr_t36_F2, _sr_t36_F4, t13, True, t24, True, t35, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t36_F0, _sr_t36_F2, _sr_t36_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr40_f29_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    return False
    return False


@njit(error_model="numpy", inline="always")
def sr41_f27___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    _sr_discard_sr40_f29_isPoint_4_0 = sr40_f29_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t2 = F[np.uint64(v_self + 0)]
    t3 = True
    t4 = v_sr0_F0
    t5 = True
    t6 = t2 + t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return (0.0, 0.0, 0.0)
    t7 = F[np.uint64(v_self + 2)]
    t8 = True
    t9 = v_sr0_F2
    t10 = True
    t11 = t7 + t9
    if math.fabs(t11) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return (0.0, 0.0, 0.0)
    t12 = F[np.uint64(v_self + 4)]
    t13 = True
    t14 = v_sr0_F4
    t15 = True
    t16 = t12 + t14
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return (0.0, 0.0, 0.0)
    _sr_t17_F0 = 0.0
    _sr_t17_F2 = 0.0
    _sr_t17_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t17_F0, _sr_t17_F2, _sr_t17_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t17_F0, _sr_t17_F2, _sr_t17_F4, t6, True, t11, True, t16, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t17_F0, _sr_t17_F2, _sr_t17_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr43_f27___add___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4, v_sr1_F0, v_sr1_F2, v_sr1_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    _sr_discard_sr40_f29_isPoint_4_0 = sr40_f29_isPoint_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr1_F0, v_sr1_F2, v_sr1_F4)
    if st[0]:
        return (0.0, 0.0, 0.0)
    t2 = v_sr0_F0
    t3 = True
    t4 = v_sr1_F0
    t5 = True
    t6 = t2 + t4
    if math.fabs(t6) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return (0.0, 0.0, 0.0)
    t7 = v_sr0_F2
    t8 = True
    t9 = v_sr1_F2
    t10 = True
    t11 = t7 + t9
    if math.fabs(t11) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return (0.0, 0.0, 0.0)
    t12 = v_sr0_F4
    t13 = True
    t14 = v_sr1_F4
    t15 = True
    t16 = t12 + t14
    if math.fabs(t16) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 6000005
        return (0.0, 0.0, 0.0)
    _sr_t17_F0 = 0.0
    _sr_t17_F2 = 0.0
    _sr_t17_F4 = 0.0
    if st[0]:
        return (0.0, 0.0, 0.0)
    _sr_t17_F0, _sr_t17_F2, _sr_t17_F4 = sr7_f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, _sr_t17_F0, _sr_t17_F2, _sr_t17_F4, t6, True, t11, True, t16, True)
    if st[0]:
        return (0.0, 0.0, 0.0)
    return (_sr_t17_F0, _sr_t17_F2, _sr_t17_F4)
    return (0.0, 0.0, 0.0)


@njit(error_model="numpy", inline="always")
def sr45_f70___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_self, v_sr0_F0, v_sr0_F2, v_sr0_F4):
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    pass
    sr10_f20_mustBeVector_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, v_sr0_F0, v_sr0_F2, v_sr0_F4)
    if st[0]:
        return -1
    t3 = F[np.uint64(v_self + 0)]
    t4 = True
    t5 = v_sr0_F0
    t6 = True
    t7 = t3 - t5
    if math.fabs(t7) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return -1
    t8 = F[np.uint64(v_self + 2)]
    t9 = True
    t10 = v_sr0_F2
    t11 = True
    t12 = t8 - t10
    if math.fabs(t12) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return -1
    t13 = F[np.uint64(v_self + 4)]
    t14 = True
    t15 = v_sr0_F4
    t16 = True
    t17 = t13 - t15
    if math.fabs(t17) >= 9007199254740992.0:
        st[0] = 1
        top[3] = 33000003
        return -1
    t18 = alloc(I, top, st, 6)
    if st[0]:
        return -1
    f25___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, t18, t7, True, t12, True, t17, True)
    if st[0]:
        return -1
    return t18
    return -1


@njit(error_model="numpy")
def s0_sr4_f30_rayColour_borrowed(_heap_ctx, which, m0_v_self, m0_v_sr0_I0, m0_v_sr0_I1, m1_v_self, m1_v_scene, m1_v_sr0_I0, m1_v_sr0_I1, m1_v_p, m1_v_normal):
    _heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)
    F = carray(_heap_F, _heap_len)
    I = carray(_heap_I, _heap_len)
    top = carray(_heap_top, 4)
    st = carray(_heap_st, 1)
    if which == 0:
        m0_t1 = I[np.uint64(m0_v_self + 5)]
        if m0_t1 > 3:
            m0_t2 = 0
            m0_t3 = 0
            m0_t4 = 0
            m0_t5 = m0_t2
            if m0_t5 > 9007199254740992 or m0_t5 < -9007199254740992:
                st[0] = 1
                top[3] = 7000003
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t6 = m0_t3
            if m0_t6 > 9007199254740992 or m0_t6 < -9007199254740992:
                st[0] = 1
                top[3] = 7000003
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t7 = m0_t4
            if m0_t7 > 9007199254740992 or m0_t7 < -9007199254740992:
                st[0] = 1
                top[3] = 7000003
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            return (float(m0_t5), True, float(m0_t6), True, float(m0_t7), True, 0.0, False, 0.0, False, 0.0, False)
        m0_t8 = I[np.uint64(m0_v_self + 5)]
        m0_t9 = add_i(st, m0_t8, 1)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        I[np.uint64(m0_v_self + 5)] = m0_t9
        m0_t10 = list_new(I, top, st, 0, 0)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        m0_v__c0_list = m0_t10
        m0_t11 = I[np.uint64(m0_v_self + 3)]
        m0_t12 = m0_t11
        m0_t13 = 0
        while True:
            if m0_t13 >= I[np.uint64(m0_t12)]:
                break
            m0_t14 = I[I[np.uint64(I[np.uint64(m0_t12 + 2)] + m0_t13)] + 0]
            m0_t15 = I[I[np.uint64(I[np.uint64(m0_t12 + 2)] + m0_t13)] + 1]
            m0_t13 += 1
            m0_v__c0_o = m0_t14
            m0_v__c0_s = m0_t15
            m0_t16 = m0_v__c0_o
            m0_t18 = I[m0_t16]
            if m0_t18 == 0:
                m0_t19_0, m0_t19_1 = sr5_f32_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_t16, m0_v_sr0_I0, m0_v_sr0_I1)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                m0_t17_0 = m0_t19_0
                m0_t17_1 = m0_t19_1
            elif m0_t18 == 1:
                m0_t20_0, m0_t20_1 = sr11_f34_intersectionTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_t16, m0_v_sr0_I0, m0_v_sr0_I1)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                m0_t17_0 = m0_t20_0
                m0_t17_1 = m0_t20_1
            else:
                st[0] = 1
                top[3] = 7000006
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t21 = m0_v__c0_o
            m0_t22 = m0_t17_0
            m0_t23 = m0_t17_1
            m0_t24 = m0_v__c0_s
            m0_t25 = list_room(I, top, st, m0_v__c0_list)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t26 = alloc(I, top, st, 4)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            I[m0_t26 + 0] = m0_t21
            F[m0_t26 + 1] = m0_t22
            I[m0_t26 + 1 + 1] = m0_t23
            I[m0_t26 + 3] = m0_t24
            I[m0_t25] = m0_t26
        m0_v_intersections = m0_v__c0_list
        m0_t27_0, m0_t27_1, m0_t27_2, m0_t27_3, m0_t27_4 = f36_firstIntersection_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_v_intersections)
        if st[0]:
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        m0_v_i_0 = m0_t27_0
        m0_v_i_1 = m0_t27_1
        m0_v_i_2 = m0_t27_2
        m0_v_i_3 = m0_t27_3
        m0_v_i_4 = m0_t27_4
        if not m0_v_i_4:
            m0_t28 = 0
            m0_t29 = 0
            m0_t30 = 0
            m0_t31 = m0_t28
            if m0_t31 > 9007199254740992 or m0_t31 < -9007199254740992:
                st[0] = 1
                top[3] = 7000010
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t32 = m0_t29
            if m0_t32 > 9007199254740992 or m0_t32 < -9007199254740992:
                st[0] = 1
                top[3] = 7000010
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t33 = m0_t30
            if m0_t33 > 9007199254740992 or m0_t33 < -9007199254740992:
                st[0] = 1
                top[3] = 7000010
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t34 = float(m0_t31)
            m0_t35 = True
            m0_t36 = float(m0_t32)
            m0_t37 = True
            m0_t38 = float(m0_t33)
            m0_t39 = True
            m0_t40 = I[np.uint64(m0_v_self + 5)]
            m0_t41 = sub_i(st, m0_t40, 1)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            I[np.uint64(m0_v_self + 5)] = m0_t41
            return (m0_t34, m0_t35, m0_t36, m0_t37, m0_t38, m0_t39, 0.0, False, 0.0, False, 0.0, False)
        else:
            if not m0_v_i_4:
                st[0] = 1
                top[3] = 7000012
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_v_o = m0_v_i_0
            m0_v_t_0 = m0_v_i_1
            m0_v_t_1 = m0_v_i_2
            m0_v_s = m0_v_i_3
            pass
            m0_t43_0 = sr12_f38_pointAtTime_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_v_sr0_I0, m0_v_sr0_I1, m0_v_t_0, m0_v_t_1)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_v_p = m0_t43_0
            m0_t44 = m0_v_s
            m0_t45 = m0_v_o
            m0_t47 = I[m0_t45]
            if m0_t47 == 0:
                m0_t48_0 = f51_normalAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_t45, m0_v_p)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                m0_t46_0 = m0_t48_0
            elif m0_t47 == 1:
                m0_t49_0 = f52_normalAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m0_t45, m0_v_p)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                m0_t46_0 = m0_t49_0
            else:
                st[0] = 1
                top[3] = 7000014
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 7000014
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m0_t50_0, m0_t50_1, m0_t50_2, m0_t50_3, m0_t50_4, m0_t50_5 = s0_sr4_f30_rayColour_borrowed(_heap_ctx, np.int64(1), np.int64(0), np.int64(0), np.int64(0), np.int64(m0_t44), np.int64(m0_v_self), np.int64(m0_v_sr0_I0), np.int64(m0_v_sr0_I1), np.int64(m0_v_p), np.int64(m0_t46_0))[6:12]
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            top[1] -= 1
            m0_t51 = m0_t50_0
            m0_t52 = m0_t50_1
            m0_t53 = m0_t50_2
            m0_t54 = m0_t50_3
            m0_t55 = m0_t50_4
            m0_t56 = m0_t50_5
            m0_t57 = I[np.uint64(m0_v_self + 5)]
            m0_t58 = sub_i(st, m0_t57, 1)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            I[np.uint64(m0_v_self + 5)] = m0_t58
            return (m0_t51, m0_t52, m0_t53, m0_t54, m0_t55, m0_t56, 0.0, False, 0.0, False, 0.0, False)
        return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
    elif which == 1:
        m1_t1 = m1_v_self
        m1_t3 = I[m1_t1]
        if m1_t3 == 0:
            m1_t4_0, m1_t4_1, m1_t4_2, m1_t4_3, m1_t4_4, m1_t4_5 = f56_baseColourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t1, m1_v_p)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_t2_0 = m1_t4_0
            m1_t2_1 = m1_t4_1
            m1_t2_2 = m1_t4_2
            m1_t2_3 = m1_t4_3
            m1_t2_4 = m1_t4_4
            m1_t2_5 = m1_t4_5
        elif m1_t3 == 1:
            m1_t5_0, m1_t5_1, m1_t5_2, m1_t5_3, m1_t5_4, m1_t5_5 = f58_baseColourAt_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t1, m1_v_p)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_t2_0 = m1_t5_0
            m1_t2_1 = m1_t5_1
            m1_t2_2 = m1_t5_2
            m1_t2_3 = m1_t5_3
            m1_t2_4 = m1_t5_4
            m1_t2_5 = m1_t5_5
        else:
            st[0] = 1
            top[3] = 21000002
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        m1_v_b_0 = m1_t2_0
        m1_v_b_1 = m1_t2_1
        m1_v_b_2 = m1_t2_2
        m1_v_b_3 = m1_t2_3
        m1_v_b_4 = m1_t2_4
        m1_v_b_5 = m1_t2_5
        m1_t6 = 0
        m1_t7 = 0
        m1_t8 = 0
        m1_t9 = m1_t6
        if m1_t9 > 9007199254740992 or m1_t9 < -9007199254740992:
            st[0] = 1
            top[3] = 21000004
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        m1_t10 = m1_t7
        if m1_t10 > 9007199254740992 or m1_t10 < -9007199254740992:
            st[0] = 1
            top[3] = 21000004
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        m1_t11 = m1_t8
        if m1_t11 > 9007199254740992 or m1_t11 < -9007199254740992:
            st[0] = 1
            top[3] = 21000004
            return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
        m1_v_c_0 = float(m1_t9)
        m1_v_c_1 = True
        m1_v_c_2 = float(m1_t10)
        m1_v_c_3 = True
        m1_v_c_4 = float(m1_t11)
        m1_v_c_5 = True
        m1_t12 = F[np.uint64(m1_v_self + 4)]
        if m1_t12 > 0.0:
            m1_t13 = m1_v_sr0_I1
            m1_t14 = m1_t13
            m1__sr_call_t15_0_F0, m1__sr_call_t15_0_F2, m1__sr_call_t15_0_F4 = sr18_f60_reflectThrough_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t14, m1_v_normal)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1__sr_t16_I0 = np.int64(0)
            m1__sr_t16_I1 = np.int64(0)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1__sr_t16_I0, m1__sr_t16_I1 = sr30_f10___init___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1__sr_t16_I0, m1__sr_t16_I1, m1_v_p, m1__sr_call_t15_0_F0, m1__sr_call_t15_0_F2, m1__sr_call_t15_0_F4)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            pass
            m1_t17 = m1_v_scene
            top[1] += 1
            if top[1] > top[2]:
                st[0] = 1
                top[3] = 21000007
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_t18_0, m1_t18_1, m1_t18_2, m1_t18_3, m1_t18_4, m1_t18_5 = s0_sr4_f30_rayColour_borrowed(_heap_ctx, np.int64(0), np.int64(m1_t17), np.int64(m1__sr_t16_I0), np.int64(m1__sr_t16_I1), np.int64(0), np.int64(0), np.int64(0), np.int64(0), np.int64(0), np.int64(0))[0:6]
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            top[1] -= 1
            m1_v_reflectedColour_0 = m1_t18_0
            m1_v_reflectedColour_1 = m1_t18_1
            m1_v_reflectedColour_2 = m1_t18_2
            m1_v_reflectedColour_3 = m1_t18_3
            m1_v_reflectedColour_4 = m1_t18_4
            m1_v_reflectedColour_5 = m1_t18_5
            m1_t19 = F[np.uint64(m1_v_self + 4)]
            m1_t20_0, m1_t20_1, m1_t20_2 = f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_v_c_0, m1_v_c_1, m1_v_c_2, m1_v_c_3, m1_v_c_4, m1_v_c_5, m1_t19, m1_v_reflectedColour_0, m1_v_reflectedColour_1, m1_v_reflectedColour_2, m1_v_reflectedColour_3, m1_v_reflectedColour_4, m1_v_reflectedColour_5)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_v_c_0 = m1_t20_0
            m1_v_c_1 = False
            m1_v_c_2 = m1_t20_1
            m1_v_c_3 = False
            m1_v_c_4 = m1_t20_2
            m1_v_c_5 = False
        m1_t21 = F[np.uint64(m1_v_self + 3)]
        if m1_t21 > 0.0:
            m1_v_lambertAmount_0 = 0.0
            m1_v_lambertAmount_1 = True
            m1_t22 = m1_v_scene
            m1_t23_0 = f63_visibleLights_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t22, m1_v_p)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_t24 = m1_t23_0
            m1_t25 = 0
            while True:
                if m1_t25 >= I[np.uint64(m1_t24)]:
                    break
                m1_t26 = I[np.uint64(I[np.uint64(m1_t24 + 2)] + m1_t25)]
                m1_t25 += 1
                m1_v_lightPoint = m1_t26
                m1_t27 = m1_v_lightPoint
                m1__sr_call_t28_0_F0, m1__sr_call_t28_0_F2, m1__sr_call_t28_0_F4 = sr6_f2___sub___borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_t27, m1_v_p)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                pass
                m1__sr_call_t30_0_F0, m1__sr_call_t30_0_F2, m1__sr_call_t30_0_F4 = sr29_f12_normalized_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1__sr_call_t28_0_F0, m1__sr_call_t28_0_F2, m1__sr_call_t28_0_F4)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                pass
                m1_t32_0, m1_t32_1 = sr8_f18_dot_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1__sr_call_t30_0_F0, m1__sr_call_t30_0_F2, m1__sr_call_t30_0_F4, m1_v_normal)
                if st[0]:
                    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                m1_v_contribution_0 = m1_t32_0
                m1_v_contribution_1 = m1_t32_1
                if m1_v_contribution_0 > 0.0:
                    m1_t33 = m1_v_lambertAmount_0 + m1_v_contribution_0
                    if math.fabs(m1_t33) >= 9007199254740992.0:
                        st[0] = 1
                        top[3] = 21000015
                        return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
                    m1_v_lambertAmount_0 = m1_t33
                    m1_v_lambertAmount_1 = True
            m1_t34 = 1.0
            m1_t35 = True
            m1_t36 = m1_v_lambertAmount_0
            m1_t37 = m1_v_lambertAmount_1
            m1_t38 = m1_t36 < m1_t34
            m1_t39 = m1_t36 if m1_t38 else m1_t34
            m1_t40 = m1_t37 if m1_t38 else m1_t35
            m1_v_lambertAmount_0 = m1_t39
            m1_v_lambertAmount_1 = m1_t40
            m1_t41 = F[np.uint64(m1_v_self + 3)]
            m1_t42_0, m1_t42_1, m1_t42_2 = f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_v_c_0, m1_v_c_1, m1_v_c_2, m1_v_c_3, m1_v_c_4, m1_v_c_5, m1_t41 * m1_v_lambertAmount_0, m1_v_b_0, m1_v_b_1, m1_v_b_2, m1_v_b_3, m1_v_b_4, m1_v_b_5)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_v_c_0 = m1_t42_0
            m1_v_c_1 = False
            m1_v_c_2 = m1_t42_1
            m1_v_c_3 = False
            m1_v_c_4 = m1_t42_2
            m1_v_c_5 = False
        m1_t43 = F[np.uint64(m1_v_self + 1)]
        if m1_t43 > 0.0:
            m1_t44 = F[np.uint64(m1_v_self + 1)]
            m1_t45_0, m1_t45_1, m1_t45_2 = f67_addColours_borrowed(_heap_ctx, _heap_F, _heap_I, _heap_top, _heap_st, _heap_len, m1_v_c_0, m1_v_c_1, m1_v_c_2, m1_v_c_3, m1_v_c_4, m1_v_c_5, m1_t44, m1_v_b_0, m1_v_b_1, m1_v_b_2, m1_v_b_3, m1_v_b_4, m1_v_b_5)
            if st[0]:
                return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
            m1_v_c_0 = m1_t45_0
            m1_v_c_1 = False
            m1_v_c_2 = m1_t45_1
            m1_v_c_3 = False
            m1_v_c_4 = m1_t45_2
            m1_v_c_5 = False
        return (0.0, False, 0.0, False, 0.0, False, m1_v_c_0, m1_v_c_1, m1_v_c_2, m1_v_c_3, m1_v_c_4, m1_v_c_5)
        return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)
    return (0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False, 0.0, False)


@njit(error_model="numpy")
def f0_render(F, I, top, st, v_self, v_canvas):
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
    return f0_render_borrowed(_heap_ctx, v_self, v_canvas)

