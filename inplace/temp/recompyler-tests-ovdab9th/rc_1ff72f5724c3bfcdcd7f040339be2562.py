def _rcv1_total(_rc_st, a, b):
    if _rc_int_domain(_rc_st, a, -16777216, 16777216) and _rc_int_domain(_rc_st, b, -16777216, 16777216):
        return a + b
    else:
        return _rc_add(_rc_st, a, b)
