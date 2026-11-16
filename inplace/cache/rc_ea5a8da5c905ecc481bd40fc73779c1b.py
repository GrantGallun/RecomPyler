def _rcv2_comprehension(_rc_st, n):
    a = list(range(n))
    b = [_rc_add(_rc_st, _rcv1_x, 1) for _rcv1_x in a]
    a = _rc_mul(_rc_st, [9], n)
    return b
