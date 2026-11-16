def _rcv1_walk(_rc_st, position, step, n):
    total = position
    for _ in range(n):
        if _rc_st[0]:
            break
        position = _rc_mod(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, position, 3), step), 1000003)
        total = _rc_nadd(_rc_st, total, position)
    return total
