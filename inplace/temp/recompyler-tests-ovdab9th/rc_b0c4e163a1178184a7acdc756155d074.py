def _rcv1_continue_init(_rc_st, n):
    source = _rc_arange(_rc_st, 0, n, 1)
    total = 0
    for k in range(4):
        if _rc_st[0]:
            break
        if k == 0:
            continue
        target = _rc_copy(_rc_st, source)
        total = _rc_nadd(_rc_st, total, _rc_index(_rc_st, target, 0))
    return total
