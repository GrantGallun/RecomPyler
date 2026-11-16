def _rcv2_with_default(_rc_st, x, k):
    return _rc_mul(_rc_st, x, k)

def _rcv3_calls_default(_rc_st, x):
    return _rc_add(_rc_st, _rcv2_with_default(_rc_st, x, _rcv1_with_default_default0), _rcv2_with_default(_rc_st, x, 2))
