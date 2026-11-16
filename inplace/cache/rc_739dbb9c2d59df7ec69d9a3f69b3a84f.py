def _rcv1_changing_source(_rc_st, n, rounds):
    s = _rc_arange(_rc_st, 0, n, 1)
    t = _rc_arange(_rc_st, 0, n, 1)
    total = 0
    for k in range(rounds):
        if _rc_st[0]:
            break
        _rc_setitem(_rc_st, s, 0, k)
        if _rc_copy_fits(_rc_st, t, s):
            _rc_copy_into(_rc_st, t, s)
        else:
            t = _rc_copy(_rc_st, s)
        total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, t, 0))
    return total
