def _rcv8_pair_energy(_rc_st, pairs):
    e = 0.0
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, pairs):
        _rcv2_unpack = pairs[_rcv1_k]
        _rc_unpack(_rc_st, _rcv2_unpack, 2)
        _rcv3_unpack = _rc_index(_rc_st, _rcv2_unpack, 0)
        _rc_unpack(_rc_st, _rcv3_unpack, 3)
        _rcv4_unpack = _rc_index(_rc_st, _rcv3_unpack, 0)
        _rc_unpack(_rc_st, _rcv4_unpack, 2)
        x1 = _rc_index(_rc_st, _rcv4_unpack, 0)
        y1 = _rc_index(_rc_st, _rcv4_unpack, 1)
        v1 = _rc_index(_rc_st, _rcv3_unpack, 1)
        m1 = _rc_index(_rc_st, _rcv3_unpack, 2)
        _rcv5_unpack = _rc_index(_rc_st, _rcv2_unpack, 1)
        _rc_unpack(_rc_st, _rcv5_unpack, 3)
        _rcv6_unpack = _rc_index(_rc_st, _rcv5_unpack, 0)
        _rc_unpack(_rc_st, _rcv6_unpack, 2)
        x2 = _rc_index(_rc_st, _rcv6_unpack, 0)
        y2 = _rc_index(_rc_st, _rcv6_unpack, 1)
        v2 = _rc_index(_rc_st, _rcv5_unpack, 1)
        m2 = _rc_index(_rc_st, _rcv5_unpack, 2)
        _rcv1_k = _rcv1_k + 1
        _rcv7_unpack = (_rc_sub(_rc_st, x1, x2), _rc_sub(_rc_st, y1, y2))
        _rc_unpack(_rc_st, _rcv7_unpack, 2)
        dx = _rc_index(_rc_st, _rcv7_unpack, 0)
        dy = _rc_index(_rc_st, _rcv7_unpack, 1)
        e = _rc_sub(_rc_st, e, _rc_div(_rc_st, _rc_mul(_rc_st, m1, m2), _rc_pow(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, dx, dx), _rc_mul(_rc_st, dy, dy)), 0.5)))
        _rc_setitem(_rc_st, v1, 0, _rc_sub(_rc_st, _rc_index(_rc_st, v1, 0), _rc_mul(_rc_st, dx, m2)))
        _rc_setitem(_rc_st, v2, 1, _rc_nadd(_rc_st, _rc_index(_rc_st, v2, 1), _rc_mul(_rc_st, dy, m1)))
    return e
