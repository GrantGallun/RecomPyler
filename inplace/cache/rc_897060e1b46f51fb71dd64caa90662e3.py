def _rcv1_waves(_rc_st, x):
    if _rc_int_domain(_rc_st, x, -16777216, 16777216):
        return _rc_add(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_proven_sin(_rc_st, x), _rc_mul(_rc_st, _rc_cos(_rc_st, x), _rc_exp(_rc_st, -x))), _rc_log1p(_rc_st, _rc_abs(_rc_st, x))), 3.141592653589793)
    else:
        return _rc_add(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_sin(_rc_st, x), _rc_mul(_rc_st, _rc_cos(_rc_st, x), _rc_exp(_rc_st, _rc_neg(_rc_st, x)))), _rc_log1p(_rc_st, _rc_abs(_rc_st, x))), 3.141592653589793)
