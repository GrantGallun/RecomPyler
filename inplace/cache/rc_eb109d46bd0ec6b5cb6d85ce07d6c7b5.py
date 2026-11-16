def _rcv1_changing_lengths(_rc_st, n):
    source = _rc_arange(_rc_st, 0, n, 1)
    target = _rc_arange(_rc_st, 0, 1, 1)
    for r in range(3):
        if _rc_st[0]:
            break
        if _rc_copy_fits(_rc_st, target, source):
            _rc_copy_into(_rc_st, target, source)
        else:
            target = _rc_copy(_rc_st, source)
    return _rc_len(_rc_st, target)
