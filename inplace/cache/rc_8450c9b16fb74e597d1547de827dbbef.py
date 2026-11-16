def _rcv4_step_bodies(_rc_st, dt, bodies):
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, bodies):
        _rcv2_unpack = bodies[_rcv1_k]
        _rc_unpack(_rc_st, _rcv2_unpack, 3)
        r = _rc_index(_rc_st, _rcv2_unpack, 0)
        _rcv3_unpack = _rc_index(_rc_st, _rcv2_unpack, 1)
        _rc_unpack(_rc_st, _rcv3_unpack, 2)
        vx = _rc_index(_rc_st, _rcv3_unpack, 0)
        vy = _rc_index(_rc_st, _rcv3_unpack, 1)
        m = _rc_index(_rc_st, _rcv2_unpack, 2)
        _rcv1_k = _rcv1_k + 1
        _rc_setitem(_rc_st, r, 0, _rc_nadd(_rc_st, _rc_index(_rc_st, r, 0), _rc_mul(_rc_st, dt, vx)))
        _rc_setitem(_rc_st, r, 1, _rc_nadd(_rc_st, _rc_index(_rc_st, r, 1), _rc_mul(_rc_st, dt, vy)))
