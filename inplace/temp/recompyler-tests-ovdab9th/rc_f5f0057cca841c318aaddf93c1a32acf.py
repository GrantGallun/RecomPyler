def _rcv3_rotate_reverse(_rc_st, n, i, j, k):
    if True:
        values = _rc_arange(_rc_st, 0, n, 1)
        _rc_rotate(_rc_st, values, i, j)
        _rc_moveslice(_rc_st, values, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
        total = 0
        _rcv2_k = _rc_int64(0)
        while not _rc_st[0] and _rcv2_k < _rc_len(_rc_st, values):
            value = values[_rcv2_k]
            _rcv2_k = _rcv2_k + 1
            total = _rc_add(_rc_st, _rc_mul(_rc_st, total, 11), value)
        return total
    else:
        values = _rc_arange(_rc_st, 0, n, 1)
        _rc_rotate(_rc_st, values, i, j)
        _rc_moveslice(_rc_st, values, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
        total = 0
        _rcv1_k = _rc_int64(0)
        while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, values):
            value = values[_rcv1_k]
            _rcv1_k = _rcv1_k + 1
            total = _rc_add(_rc_st, _rc_mul(_rc_st, total, 11), value)
        return total
