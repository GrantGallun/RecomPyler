def _rcv1_negate(_rc_st, a):
    if _rc_int_domain(_rc_st, a, -16777216, 16777216):
        return -a
    else:
        return _rc_neg(_rc_st, a)
