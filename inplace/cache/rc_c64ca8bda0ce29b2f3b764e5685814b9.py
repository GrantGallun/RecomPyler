def _rcv1_escaped_copy(_rc_st, n):
    source = list(range(n))
    target = _rc_slice0(_rc_st, source)
    saved = target
    target = _rc_slice0(_rc_st, source)
    _rc_setitem(_rc_st, target, 0, 99)
    return _rc_index(_rc_st, saved, 0)
