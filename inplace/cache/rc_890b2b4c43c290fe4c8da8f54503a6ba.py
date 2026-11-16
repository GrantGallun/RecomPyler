def _rcv1_reset_range(_rc_st, n, rounds):
    if _rc_int_domain(_rc_st, n, 0, 16777216):
        values = _rc_arange(_rc_st, 0, n, 1)
        total = 0
        for r in range(rounds):
            if _rc_st[0]:
                break
            values = _rc_arange_reuse(_rc_st, values, 0, n, 1)
            total = _rc_nadd(_rc_st, total, _rc_add(_rc_st, _rc_index(_rc_st, values, 0), _rc_getitem(_rc_st, values, n - 1)))
        return total
    else:
        values = _rc_arange(_rc_st, 0, n, 1)
        total = 0
        for r in range(rounds):
            if _rc_st[0]:
                break
            values = _rc_arange_reuse(_rc_st, values, 0, n, 1)
            total = _rc_nadd(_rc_st, total, _rc_add(_rc_st, _rc_index(_rc_st, values, 0), _rc_getitem(_rc_st, values, _rc_sub(_rc_st, n, 1))))
        return total
