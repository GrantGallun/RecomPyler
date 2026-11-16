def _rcv1_scale(_rc_st, values, k, offset):
    if _rc_array_extent(_rc_st, values, _rc_len(_rc_st, values)) and _rc_array_extent(_rc_st, values, _rc_len(_rc_st, values)):
        for i in range(_rc_len(_rc_st, values)):
            if _rc_st[0]:
                break
            _rc_proven_setitem(_rc_st, values, i, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_proven_getitem(_rc_st, values, i), k), offset))
    else:
        for i in range(_rc_len(_rc_st, values)):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, values, i, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getitem(_rc_st, values, i), k), offset))
