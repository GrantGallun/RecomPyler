def _rcv1_private_copy(_rc_st, n, rounds, stop):
    if _rc_int_domain(_rc_st, n, 0, 16777216):
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        total = 0
        for k in range(rounds):
            if _rc_st[0]:
                break
            _rc_copy_into(_rc_st, target, source)
            if k == stop:
                return _rc_add(_rc_st, total, _rc_index(_rc_st, target, 0))
            total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
        return total
    else:
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        total = 0
        for k in range(rounds):
            if _rc_st[0]:
                break
            if _rc_copy_fits(_rc_st, target, source):
                _rc_copy_into(_rc_st, target, source)
            else:
                target = _rc_copy(_rc_st, source)
            if k == stop:
                return _rc_add(_rc_st, total, _rc_index(_rc_st, target, 0))
            total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
        return total
