def _rcv1_enumerated(_rc_st, n):
    a = list(range(n))
    result = 0
    for i, v in enumerate(a):
        if _rc_st[0]:
            break
        a = _rc_mul(_rc_st, [9], n)
        result = _rc_nadd(_rc_st, result, v)
    return result
