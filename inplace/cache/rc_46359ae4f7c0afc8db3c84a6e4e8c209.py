def _rcv1_copy_loop(_rc_st, n, rounds):
    source = _rc_arange(_rc_st, 0, n, 1)
    target = _rc_arange(_rc_st, 0, n, 1)
    total = 0
    for r in range(rounds):
        if _rc_st[0]:
            break
        if _rc_copy_fits(_rc_st, target, source):
            _rc_copy_into(_rc_st, target, source)
        else:
            target = _rc_copy(_rc_st, source)
        _rc_setitem(_rc_st, target, 0, r)
        total = _rc_nadd(_rc_st, total, _rc_add(_rc_st, _rc_index(_rc_st, target, 0), _rc_index(_rc_st, source, 0)))
    return total
