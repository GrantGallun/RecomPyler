def _rcv1_copy_after_error(_rc_st, n, rounds, divisor):
    if _rc_int_domain(_rc_st, n, 0, 16777216):
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        total = 0
        for k in range(rounds):
            if _rc_st[0]:
                break
            total = _rc_floordiv(_rc_st, 1, divisor)
            _rc_copy_into(_rc_st, target, source)
            total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
        return total
    else:
        source = _rc_arange(_rc_st, 0, n, 1)
        target = _rc_arange(_rc_st, 0, n, 1)
        total = 0
        for k in range(rounds):
            if _rc_st[0]:
                break
            total = _rc_floordiv(_rc_st, 1, divisor)
            if _rc_copy_fits(_rc_st, target, source):
                _rc_copy_into(_rc_st, target, source)
            else:
                target = _rc_copy(_rc_st, source)
            total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
        return total
