def _rcv1_write_index(_rc_st, values, index):
    _rc_setitem(_rc_st, values, index, 19)
    return _rc_index(_rc_st, values, 0)
