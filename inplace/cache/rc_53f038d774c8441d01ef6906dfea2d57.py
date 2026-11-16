def _rcv3_step(_rc_st, x, v):
    if True:
        for _ in range(32):
            if _rc_st[0]:
                break
            v = _rc_nadd(_rc_st, v, _rc_mul(_rc_st, _rc_sub(_rc_st, -9.81, _rc_mul(_rc_st, 0.04, v)), 0.01))
            x = _rc_nadd(_rc_st, x, _rc_mul(_rc_st, v, 0.01))
            if x < 0.0:
                _rcv2_unpack = (_rc_neg(_rc_st, x), _rc_mul(_rc_st, v, -0.7))
                _rc_unpack(_rc_st, _rcv2_unpack, 2)
                x = _rc_index(_rc_st, _rcv2_unpack, 0)
                v = _rc_index(_rc_st, _rcv2_unpack, 1)
        return x
    else:
        for _ in range(32):
            if _rc_st[0]:
                break
            v = _rc_nadd(_rc_st, v, _rc_mul(_rc_st, _rc_sub(_rc_st, -9.81, _rc_mul(_rc_st, 0.04, v)), 0.01))
            x = _rc_nadd(_rc_st, x, _rc_mul(_rc_st, v, 0.01))
            if x < 0.0:
                _rcv1_unpack = (_rc_neg(_rc_st, x), _rc_mul(_rc_st, v, -0.7))
                _rc_unpack(_rc_st, _rcv1_unpack, 2)
                x = _rc_index(_rc_st, _rcv1_unpack, 0)
                v = _rc_index(_rc_st, _rcv1_unpack, 1)
        return x
