def _rcv1_self_copy(_rc_st, n):
    a = _rc_arange(_rc_st, 0, n, 1)
    for k in range(4):
        if _rc_st[0]:
            break
        _rc_setitem(_rc_st, a, 0, k)
        if _rc_copy_fits(_rc_st, a, a):
            _rc_copy_into(_rc_st, a, a)
        else:
            a = _rc_copy(_rc_st, a)
    return _rc_index(_rc_st, a, 0)
