def _rcv1_total(_rc_st, n):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        s = 0.0
        for i in range(n):
            if _rc_st[0]:
                break
            s = _rc_nadd(_rc_st, s, i * 0.5)
        return s
    else:
        s = 0.0
        for i in range(n):
            if _rc_st[0]:
                break
            s = _rc_nadd(_rc_st, s, _rc_mul(_rc_st, i, 0.5))
        return s
