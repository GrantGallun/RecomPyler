def _rcv1_doubled(_rc_st, values):
    if _rc_int_domain(_rc_st, values, -16777216, 16777216):
        return values + values
    else:
        return _rc_add(_rc_st, values, values)
