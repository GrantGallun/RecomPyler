def _rcv1_FFT_bitreverse(_rc_st, N, data):
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
