def _rcv1_replay(_rc_st, values, n):
    source = _rc_arange(_rc_st, 0, n, 1)
    target = _rc_arange(_rc_st, 0, n, 1)
    total = 0
    for k in range(3):
        if _rc_st[0]:
            break
        _rc_setitem(_rc_st, values, 0, _rc_nadd(_rc_st, _rc_index(_rc_st, values, 0), 1))
        _rc_setitem(_rc_st, source, 0, k)
        if _rc_copy_fits(_rc_st, target, source):
            _rc_copy_into(_rc_st, target, source)
        else:
            target = _rc_copy(_rc_st, source)
        total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
    return _rc_add(_rc_st, total, _rc_mul(_rc_st, _rc_pow(_rc_st, 2, 62), _rc_index(_rc_st, values, 0)))
