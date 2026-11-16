def _rcv1_grow(_rc_st, n):
    x = 1
    for _ in range(n):
        if _rc_st[0]:
            break
        x = _rc_nmul(_rc_st, x, 3)
    return x
