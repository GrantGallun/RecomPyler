def _rcv2_spread(_rc_st, points, k):
    total = 0.0
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, points):
        p = points[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        d = _rc_sub(_rc_st, p, _rc_index(_rc_st, points, 0))
        total = _rc_nadd(_rc_st, total, _rc_add(_rc_st, _rc_add(_rc_st, _rc_method0(_rc_st, d, (d,)), _rc_getattr1(_rc_st, _rc_mul(_rc_st, 2.0, p))), _rc_getattr2(_rc_st, _rc_mul(_rc_st, p, k))))
    return total
