def _rcv1_weighted(_rc_st, pair, scale):
    return _rc_mul(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_index(_rc_st, pair, 0), 3), _rc_index(_rc_st, pair, 1)), scale)
