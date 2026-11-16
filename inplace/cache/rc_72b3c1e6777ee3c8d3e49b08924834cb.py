def _rcv1_helper(_rc_st, x):
    if _rc_int_domain(_rc_st, x, -16777216, 16777216):
        return x + 1
    else:
        return _rc_add(_rc_st, x, 1)

def _rcv2_root(_rc_st, x):
    return _rcv1_helper(_rc_st, x)
