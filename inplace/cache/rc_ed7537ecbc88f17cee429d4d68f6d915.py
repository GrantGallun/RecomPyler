def _rcv1_set_then_divide(_rc_st, values, k):
    _rc_setitem(_rc_st, values, 0, 5.0)
    return _rc_floordiv(_rc_st, 7, k)
