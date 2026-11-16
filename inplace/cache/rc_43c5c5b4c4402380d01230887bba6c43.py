def _rcv1_overflowing_cancel(_rc_st, n):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        p = _rc_arange(_rc_st, 0, 1, 1)
        j = _rc_sub(_rc_st, _rc_sub(_rc_st, _rc_mul(_rc_st, n, 9223372036854775807), _rc_mul(_rc_st, n - 1, 9223372036854775807)), 9223372036854775807)
        _rc_setitem(_rc_st, p, j, 1)
        return _rc_proven_getitem(_rc_st, p, 0)
    else:
        p = _rc_arange(_rc_st, 0, 1, 1)
        j = _rc_sub(_rc_st, _rc_sub(_rc_st, _rc_mul(_rc_st, n, 9223372036854775807), _rc_mul(_rc_st, _rc_sub(_rc_st, n, 1), 9223372036854775807)), 9223372036854775807)
        _rc_setitem(_rc_st, p, j, 1)
        return _rc_index(_rc_st, p, 0)
