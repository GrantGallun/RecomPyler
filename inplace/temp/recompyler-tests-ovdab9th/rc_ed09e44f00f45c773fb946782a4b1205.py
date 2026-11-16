def _rcv1_helper(_rc_st, n, data):
    if _rc_array_extent(_rc_st, data, n) and _rc_int_domain(_rc_st, n, -16777216, 16777216):
        total = 0
        for i in range(n):
            if _rc_st[0]:
                break
            total = _rc_nadd(_rc_st, total, _rc_proven_getitem(_rc_st, data, i))
        return total
    else:
        total = 0
        for i in range(n):
            if _rc_st[0]:
                break
            total = _rc_nadd(_rc_st, total, _rc_getitem(_rc_st, data, i))
        return total

def _rcv2_two_calls(_rc_st, n, data):
    return _rc_add(_rc_st, _rcv1_helper(_rc_st, n, data), _rcv1_helper(_rc_st, n, data))
