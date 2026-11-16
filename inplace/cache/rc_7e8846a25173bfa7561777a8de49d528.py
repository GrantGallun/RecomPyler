def _rcv1_store_into_ints(_rc_st, x):
    values = _rc_full(_rc_st, 3, 0)
    _rc_setitem(_rc_st, values, 0, x)
    return _rc_index(_rc_st, values, 0)
