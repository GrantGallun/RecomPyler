def _rcv1_aliased_copy(_rc_st, n):
    a = list(range(n))
    b = a
    a = _rc_slice0(_rc_st, b)
    _rc_setitem(_rc_st, a, 0, 99)
    return _rc_index(_rc_st, b, 0)
