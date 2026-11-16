def _rcv1_doubled_length(_rc_st, values):
    if _rc_int_domain(_rc_st, values, -16777216, 16777216):
        both = values + values
        return _rc_add(_rc_st, _rc_len(_rc_st, both), _rc_len(_rc_st, values * 2))
    else:
        both = _rc_add(_rc_st, values, values)
        return _rc_add(_rc_st, _rc_len(_rc_st, both), _rc_len(_rc_st, _rc_mul(_rc_st, values, 2)))
