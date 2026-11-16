def _rcv1_scale_in_place(_rc_st, values, k):
    if _rc_array_extent(_rc_st, values, _rc_len(_rc_st, values)) and _rc_array_extent(_rc_st, values, _rc_len(_rc_st, values)):
        for i in range(_rc_len(_rc_st, values)):
            if _rc_st[0]:
                break
            _rc_proven_setitem(_rc_st, values, i, _rc_nmul(_rc_st, _rc_proven_getitem(_rc_st, values, i), k))
    else:
        for i in range(_rc_len(_rc_st, values)):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, values, i, _rc_nmul(_rc_st, _rc_getitem(_rc_st, values, i), k))
