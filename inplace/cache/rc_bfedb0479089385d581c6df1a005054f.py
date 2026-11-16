def _rcv1_twice(_rc_st, a, b):
    _rc_setattr1(_rc_st, a, _rc_nadd(_rc_st, _rc_getattr0(_rc_st, a), 1.0))
    return _rc_getattr0(_rc_st, b)
