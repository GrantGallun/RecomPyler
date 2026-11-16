def _rcv1_arithmetic(_rc_st, x):
    for i in range(200):
        if _rc_st[0]:
            break
        x = _rc_nadd(_rc_st, x, i)
    return x
