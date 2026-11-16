def _rcv1_write_then_multiply(_rc_st, values, a, b):
    _rc_setitem(_rc_st, values, 0, _rc_nadd(_rc_st, _rc_index(_rc_st, values, 0), 1))
    return _rc_add(_rc_st, _rc_mul(_rc_st, a, b), _rc_index(_rc_st, values, 0))
