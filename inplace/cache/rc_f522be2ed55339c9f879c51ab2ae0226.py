def _rcv1_tally(_rc_st, n):
    counts = _rc_full(_rc_st, 4, 0)
    for i in range(n):
        if _rc_st[0]:
            break
        _rc_setitem(_rc_st, counts, i & 3, _rc_nadd(_rc_st, _rc_getitem(_rc_st, counts, i & 3), i))
    return _rc_sub(_rc_st, _rc_index(_rc_st, counts, 1), _rc_index(_rc_st, counts, 2))
