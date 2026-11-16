def _rcv1_foreign_kind(_rc_st, n, rounds):
    source = _rc_arange(_rc_st, 0, n, 1)
    target = _rc_arange(_rc_st, 0, n, 1)
    _rc_setitem(_rc_st, source, 0, 1.5)
    for k in range(rounds):
        if _rc_st[0]:
            break
        if _rc_copy_fits(_rc_st, target, source):
            _rc_copy_into(_rc_st, target, source)
        else:
            target = _rc_copy(_rc_st, source)
    return _rc_index(_rc_st, target, 0)
