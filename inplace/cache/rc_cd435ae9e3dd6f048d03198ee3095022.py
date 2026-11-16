def _rcv1_copy_late_error(_rc_st, n, rounds):
    if _rc_int_domain(_rc_st, n, 0, 16777216):
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        for k in range(rounds):
            if _rc_st[0]:
                break
            _rc_copy_into(_rc_st, target, source)
        return _rc_getitem(_rc_st, target, n)
    else:
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        for k in range(rounds):
            if _rc_st[0]:
                break
            if _rc_copy_fits(_rc_st, target, source):
                _rc_copy_into(_rc_st, target, source)
            else:
                target = _rc_copy(_rc_st, source)
        return _rc_getitem(_rc_st, target, n)
