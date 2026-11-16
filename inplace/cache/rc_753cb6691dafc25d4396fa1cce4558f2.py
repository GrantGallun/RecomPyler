def _rcv1_overlapping_copy(_rc_st, n):
    if True:
        a = list(range(n))
        _rc_moveslice(_rc_st, a, None, -1, None, 1, None, None)
        return a
    else:
        a = list(range(n))
        _rc_moveslice(_rc_st, a, None, -1, None, 1, None, None)
        return a
