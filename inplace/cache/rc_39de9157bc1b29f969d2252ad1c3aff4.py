def _rcv1_int_log2(_rc_st, n):
    if _rc_int_domain(_rc_st, n, 1, 16777216) and _rc_power_extent(_rc_st, n, 1):
        k = 1
        log = 0
        while not _rc_st[0] and k < n:
            k = k * 2
            log = _rc_nadd(_rc_st, log, 1)
        if n != _rc_lshift(_rc_st, 1, log):
            raise _rc_Fallback
        return log
    else:
        k = 1
        log = 0
        while not _rc_st[0] and k < n:
            k = _rc_nmul(_rc_st, k, 2)
            log = _rc_nadd(_rc_st, log, 1)
        if n != _rc_lshift(_rc_st, 1, log):
            raise _rc_Fallback
        return log

def _rcv2_FFT_bitreverse(_rc_st, N, data):
    if _rc_even_extent(_rc_st, N) and _rc_array_extent(_rc_st, data, N) and _rc_int_domain(_rc_st, N, -16777216, 16777216):
        n = N // 2
        nm1 = n - 1
        j = 0
        for i in range(nm1):
            if _rc_st[0]:
                break
            ii = i << 1
            jj = _rc_lshift(_rc_st, j, 1)
            k = n >> 1
            if i < j:
                tmp_real = _rc_proven_getitem(_rc_st, data, ii)
                tmp_imag = _rc_proven_getitem(_rc_st, data, ii + 1)
                _rc_proven_setitem(_rc_st, data, ii, _rc_getitem(_rc_st, data, jj))
                _rc_proven_setitem(_rc_st, data, ii + 1, _rc_getitem(_rc_st, data, _rc_add(_rc_st, jj, 1)))
                _rc_setitem(_rc_st, data, jj, tmp_real)
                _rc_setitem(_rc_st, data, _rc_add(_rc_st, jj, 1), tmp_imag)
            while not _rc_st[0] and k <= j:
                j = _rc_sub(_rc_st, j, k)
                k = _rc_rshift(_rc_st, k, 1)
            j = _rc_nadd(_rc_st, j, k)
    else:
        n = _rc_floordiv(_rc_st, N, 2)
        nm1 = _rc_sub(_rc_st, n, 1)
        j = 0
        for i in range(nm1):
            if _rc_st[0]:
                break
            ii = _rc_lshift(_rc_st, i, 1)
            jj = _rc_lshift(_rc_st, j, 1)
            k = _rc_rshift(_rc_st, n, 1)
            if i < j:
                tmp_real = _rc_getitem(_rc_st, data, ii)
                tmp_imag = _rc_getitem(_rc_st, data, _rc_add(_rc_st, ii, 1))
                _rc_setitem(_rc_st, data, ii, _rc_getitem(_rc_st, data, jj))
                _rc_setitem(_rc_st, data, _rc_add(_rc_st, ii, 1), _rc_getitem(_rc_st, data, _rc_add(_rc_st, jj, 1)))
                _rc_setitem(_rc_st, data, jj, tmp_real)
                _rc_setitem(_rc_st, data, _rc_add(_rc_st, jj, 1), tmp_imag)
            while not _rc_st[0] and k <= j:
                j = _rc_sub(_rc_st, j, k)
                k = _rc_rshift(_rc_st, k, 1)
            j = _rc_nadd(_rc_st, j, k)

def _rcv3_FFT_transform_internal(_rc_st, N, data, direction):
    if _rc_even_extent(_rc_st, N) and _rc_array_extent(_rc_st, data, N) and _rc_int_domain(_rc_st, N, 2, 16777216) and _rc_int_domain(_rc_st, direction, -16777216, 16777216) and _rc_power_extent(_rc_st, N, 2):
        n = N // 2
        bit = 0
        dual = 1
        if n == 1:
            return
        logn = _rcv1_int_log2(_rc_st, n)
        if N == 0:
            return
        _rcv2_FFT_bitreverse(_rc_st, N, data)
        bit = 0
        while not _rc_st[0] and bit < logn:
            w_real = 1.0
            w_imag = 0.0
            theta = 2.0 * direction * 3.141592653589793 / (2.0 * float(dual))
            s = _rc_proven_sin(_rc_st, theta)
            t = _rc_proven_sin(_rc_st, theta / 2.0)
            s2 = 2.0 * t * t
            for b in range(0, n, _rc_step(_rc_st, 2 * dual)):
                if _rc_st[0]:
                    break
                i = 2 * b
                j = 2 * (b + dual)
                wd_real = _rc_proven_getitem(_rc_st, data, j)
                wd_imag = _rc_proven_getitem(_rc_st, data, j + 1)
                _rc_proven_setitem(_rc_st, data, j, _rc_sub(_rc_st, _rc_proven_getitem(_rc_st, data, i), wd_real))
                _rc_proven_setitem(_rc_st, data, j + 1, _rc_sub(_rc_st, _rc_proven_getitem(_rc_st, data, i + 1), wd_imag))
                _rc_proven_setitem(_rc_st, data, i, _rc_nadd(_rc_st, _rc_proven_getitem(_rc_st, data, i), wd_real))
                _rc_proven_setitem(_rc_st, data, i + 1, _rc_nadd(_rc_st, _rc_proven_getitem(_rc_st, data, i + 1), wd_imag))
            for a in range(1, dual):
                if _rc_st[0]:
                    break
                tmp_real = _rc_sub(_rc_st, _rc_sub(_rc_st, w_real, _rc_mul(_rc_st, s, w_imag)), _rc_mul(_rc_st, s2, w_real))
                tmp_imag = _rc_sub(_rc_st, _rc_add(_rc_st, w_imag, _rc_mul(_rc_st, s, w_real)), _rc_mul(_rc_st, s2, w_imag))
                w_real = tmp_real
                w_imag = tmp_imag
                for b in range(0, n, _rc_step(_rc_st, 2 * dual)):
                    if _rc_st[0]:
                        break
                    i = 2 * (b + a)
                    j = 2 * (b + a + dual)
                    z1_real = _rc_proven_getitem(_rc_st, data, j)
                    z1_imag = _rc_proven_getitem(_rc_st, data, j + 1)
                    wd_real = _rc_sub(_rc_st, _rc_mul(_rc_st, w_real, z1_real), _rc_mul(_rc_st, w_imag, z1_imag))
                    wd_imag = _rc_add(_rc_st, _rc_mul(_rc_st, w_real, z1_imag), _rc_mul(_rc_st, w_imag, z1_real))
                    _rc_proven_setitem(_rc_st, data, j, _rc_sub(_rc_st, _rc_proven_getitem(_rc_st, data, i), wd_real))
                    _rc_proven_setitem(_rc_st, data, j + 1, _rc_sub(_rc_st, _rc_proven_getitem(_rc_st, data, i + 1), wd_imag))
                    _rc_proven_setitem(_rc_st, data, i, _rc_nadd(_rc_st, _rc_proven_getitem(_rc_st, data, i), wd_real))
                    _rc_proven_setitem(_rc_st, data, i + 1, _rc_nadd(_rc_st, _rc_proven_getitem(_rc_st, data, i + 1), wd_imag))
            bit = bit + 1
            dual = dual * 2
    else:
        n = _rc_floordiv(_rc_st, N, 2)
        bit = 0
        dual = 1
        if n == 1:
            return
        logn = _rcv1_int_log2(_rc_st, n)
        if N == 0:
            return
        _rcv2_FFT_bitreverse(_rc_st, N, data)
        bit = 0
        while not _rc_st[0] and bit < logn:
            w_real = 1.0
            w_imag = 0.0
            theta = _rc_div(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 2.0, direction), 3.141592653589793), _rc_mul(_rc_st, 2.0, float(dual)))
            s = _rc_sin(_rc_st, theta)
            t = _rc_sin(_rc_st, _rc_div(_rc_st, theta, 2.0))
            s2 = _rc_mul(_rc_st, _rc_mul(_rc_st, 2.0, t), t)
            for b in range(0, n, _rc_step(_rc_st, _rc_mul(_rc_st, 2, dual))):
                if _rc_st[0]:
                    break
                i = _rc_mul(_rc_st, 2, b)
                j = _rc_mul(_rc_st, 2, _rc_add(_rc_st, b, dual))
                wd_real = _rc_getitem(_rc_st, data, j)
                wd_imag = _rc_getitem(_rc_st, data, _rc_add(_rc_st, j, 1))
                _rc_setitem(_rc_st, data, j, _rc_sub(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))
                _rc_setitem(_rc_st, data, _rc_add(_rc_st, j, 1), _rc_sub(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))
                _rc_setitem(_rc_st, data, i, _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))
                _rc_setitem(_rc_st, data, _rc_add(_rc_st, i, 1), _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))
            for a in range(1, dual):
                if _rc_st[0]:
                    break
                tmp_real = _rc_sub(_rc_st, _rc_sub(_rc_st, w_real, _rc_mul(_rc_st, s, w_imag)), _rc_mul(_rc_st, s2, w_real))
                tmp_imag = _rc_sub(_rc_st, _rc_add(_rc_st, w_imag, _rc_mul(_rc_st, s, w_real)), _rc_mul(_rc_st, s2, w_imag))
                w_real = tmp_real
                w_imag = tmp_imag
                for b in range(0, n, _rc_step(_rc_st, _rc_mul(_rc_st, 2, dual))):
                    if _rc_st[0]:
                        break
                    i = _rc_mul(_rc_st, 2, _rc_add(_rc_st, b, a))
                    j = _rc_mul(_rc_st, 2, _rc_add(_rc_st, _rc_add(_rc_st, b, a), dual))
                    z1_real = _rc_getitem(_rc_st, data, j)
                    z1_imag = _rc_getitem(_rc_st, data, _rc_add(_rc_st, j, 1))
                    wd_real = _rc_sub(_rc_st, _rc_mul(_rc_st, w_real, z1_real), _rc_mul(_rc_st, w_imag, z1_imag))
                    wd_imag = _rc_add(_rc_st, _rc_mul(_rc_st, w_real, z1_imag), _rc_mul(_rc_st, w_imag, z1_real))
                    _rc_setitem(_rc_st, data, j, _rc_sub(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))
                    _rc_setitem(_rc_st, data, _rc_add(_rc_st, j, 1), _rc_sub(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))
                    _rc_setitem(_rc_st, data, i, _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))
                    _rc_setitem(_rc_st, data, _rc_add(_rc_st, i, 1), _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))
            bit = _rc_nadd(_rc_st, bit, 1)
            dual = _rc_nmul(_rc_st, dual, 2)

def _rcv4_FFT_inverse(_rc_st, N, data):
    if _rc_array_extent(_rc_st, data, N) and _rc_int_domain(_rc_st, N, -16777216, 16777216):
        n = _rc_div(_rc_st, N, 2)
        norm = 0.0
        _rcv3_FFT_transform_internal(_rc_st, N, data, _rc_pos(_rc_st, 1))
        norm = _rc_div(_rc_st, 1, float(n))
        for i in range(N):
            if _rc_st[0]:
                break
            _rc_proven_setitem(_rc_st, data, i, _rc_nmul(_rc_st, _rc_proven_getitem(_rc_st, data, i), norm))
    else:
        n = _rc_div(_rc_st, N, 2)
        norm = 0.0
        _rcv3_FFT_transform_internal(_rc_st, N, data, _rc_pos(_rc_st, 1))
        norm = _rc_div(_rc_st, 1, float(n))
        for i in range(N):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, data, i, _rc_nmul(_rc_st, _rc_getitem(_rc_st, data, i), norm))
