def _rcv1_cube_root(_rc_st, x):
    return _rc_add(_rc_st, _rc_add(_rc_st, _rc_pow(_rc_st, x, _rc_div(_rc_st, 1, 3)), _rc_pow(_rc_st, x, 3)), _rc_pow(_rc_st, 2, x))
