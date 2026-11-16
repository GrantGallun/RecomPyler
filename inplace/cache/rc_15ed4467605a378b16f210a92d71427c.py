def _rcv1_returns_local(_rc_st, n):
    values = _rc_mul(_rc_st, [0.5], n)
    _rc_setitem(_rc_st, values, 0, 2.0)
    return values
