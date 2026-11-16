def _rcv1_reset_buffer(_rc_st, n, rounds):
    values = _rc_full(_rc_st, n, 0)
    total = 0
    for r in range(rounds):
        if _rc_st[0]:
            break
        values = _rc_full_reuse(_rc_st, values, n, 0)
        _rc_setitem(_rc_st, values, 0, r)
        total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, values, 0))
    return total
