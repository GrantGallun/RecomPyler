def _rcv2_grow_while_iterating(_rc_st, values):
    seen = 0
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, values):
        value = values[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        seen = _rc_nadd(_rc_st, seen, 1)
        if value > 0 and _rc_len(_rc_st, values) < 8:
            _rc_method0(_rc_st, values, (_rc_sub(_rc_st, value, 1),))
    return seen
