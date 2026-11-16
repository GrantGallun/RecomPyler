def _rcv1_flips(_rc_st, n, k):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        perm = _rc_arange(_rc_st, 0, n, 1)
        count = _rc_full(_rc_st, n, 0)
        for step in range(n):
            if _rc_st[0]:
                break
            _rc_rotate(_rc_st, perm, _rc_sub(_rc_st, _rc_mod(_rc_st, step, n + 2), 1), k)
            _rc_moveslice(_rc_st, perm, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
            _rc_setitem(_rc_st, count, _rc_index(_rc_st, perm, 0), _rc_nadd(_rc_st, _rc_getitem(_rc_st, count, _rc_index(_rc_st, perm, 0)), 1))
        snapshot = _rc_copy(_rc_st, perm)
        _rc_moveslice(_rc_st, snapshot, None, 0, -1, 1, None, None)
        return _rc_add(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_index(_rc_st, snapshot, 0), 100), _rc_mul(_rc_st, _rc_index(_rc_st, count, 0), 10)), _rc_getitem(_rc_st, perm, -1))
    else:
        perm = _rc_arange(_rc_st, 0, n, 1)
        count = _rc_full(_rc_st, n, 0)
        for step in range(n):
            if _rc_st[0]:
                break
            _rc_rotate(_rc_st, perm, _rc_sub(_rc_st, _rc_mod(_rc_st, step, _rc_add(_rc_st, n, 2)), 1), k)
            _rc_moveslice(_rc_st, perm, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
            _rc_setitem(_rc_st, count, _rc_index(_rc_st, perm, 0), _rc_nadd(_rc_st, _rc_getitem(_rc_st, count, _rc_index(_rc_st, perm, 0)), 1))
        snapshot = _rc_copy(_rc_st, perm)
        _rc_moveslice(_rc_st, snapshot, None, 0, -1, 1, None, None)
        return _rc_add(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_index(_rc_st, snapshot, 0), 100), _rc_mul(_rc_st, _rc_index(_rc_st, count, 0), 10)), _rc_index(_rc_st, perm, -1))
