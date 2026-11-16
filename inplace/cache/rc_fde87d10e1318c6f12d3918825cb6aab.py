def _rcv1_copy_into(_rc_st, target, source):
    if _rc_array_extent(_rc_st, source, _rc_len(_rc_st, source)) and _rc_array_extent(_rc_st, source, _rc_len(_rc_st, source)):
        for i in range(_rc_len(_rc_st, source)):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, target, i, _rc_add(_rc_st, _rc_proven_getitem(_rc_st, source, i), 1))
    else:
        for i in range(_rc_len(_rc_st, source)):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, target, i, _rc_add(_rc_st, _rc_getitem(_rc_st, source, i), 1))
