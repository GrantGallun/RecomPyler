def _rcv1_kind_change(_rc_st, n):
    if _rc_int_domain(_rc_st, n, 0, 16777216):
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        total = 0.0
        for k in range(3):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, source, 0, k + 0.5)
            if _rc_copy_fits(_rc_st, target, source):
                _rc_copy_into(_rc_st, target, source)
            else:
                target = _rc_copy(_rc_st, source)
            total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
        return total
    else:
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        total = 0.0
        for k in range(3):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, source, 0, _rc_add(_rc_st, k, 0.5))
            if _rc_copy_fits(_rc_st, target, source):
                _rc_copy_into(_rc_st, target, source)
            else:
                target = _rc_copy(_rc_st, source)
            total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
        return total
