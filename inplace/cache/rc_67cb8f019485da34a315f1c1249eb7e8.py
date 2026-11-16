def _rcv1_resizes(_rc_st, n):
    values = _rc_arange(_rc_st, 0, n, 1)
    _rc_moveslice(_rc_st, values, 3, None, None, None, 2, None)
    return _rc_len(_rc_st, values)
