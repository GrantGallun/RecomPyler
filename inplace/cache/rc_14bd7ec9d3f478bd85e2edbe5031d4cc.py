def _rcv1_drift(_rc_st, x, v):
    for _ in range(16):
        if _rc_st[0]:
            break
        x = _rc_nadd(_rc_st, x, _rc_mul(_rc_st, v, 0.5))
        v = _rc_nmul(_rc_st, v, 0.99)
    return x
