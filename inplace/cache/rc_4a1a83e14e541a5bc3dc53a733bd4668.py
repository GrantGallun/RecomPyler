def _rcv1_changing_range(_rc_st, start, stop, step):
    values = _rc_arange(_rc_st, 0, 1, 1)
    for r in range(3):
        if _rc_st[0]:
            break
        values = _rc_arange_reuse(_rc_st, values, start, stop, step)
    return _rc_len(_rc_st, values)
