def _rcv1_conditional_init(_rc_st, flag):
    if True:
        source = _rc_arange(_rc_st, 0, 4, 1)
        if flag:
            target = _rc_copy(_rc_st, source)
        else:
            target = _rc_copy(_rc_st, source)
        _rc_proven_setitem(_rc_st, target, 0, 7)
        return _rc_proven_getitem(_rc_st, target, 0)
    else:
        source = _rc_arange(_rc_st, 0, 4, 1)
        if flag:
            target = _rc_copy(_rc_st, source)
        else:
            target = _rc_copy(_rc_st, source)
        _rc_setitem(_rc_st, target, 0, 7)
        return _rc_index(_rc_st, target, 0)
