def _rcv1_same_list(_rc_st, xs):
    if _rc_array_extent(_rc_st, xs, _rc_len(_rc_st, xs)) and _rc_array_extent(_rc_st, xs, _rc_len(_rc_st, xs)):
        total = 0.0
        for i in range(_rc_len(_rc_st, xs)):
            if _rc_st[0]:
                break
            total = _rc_nadd(_rc_st, total, _rc_mul(_rc_st, _rc_proven_getitem(_rc_st, xs, i), _rc_proven_getitem(_rc_st, xs, i)))
        return total
    else:
        total = 0.0
        for i in range(_rc_len(_rc_st, xs)):
            if _rc_st[0]:
                break
            total = _rc_nadd(_rc_st, total, _rc_mul(_rc_st, _rc_getitem(_rc_st, xs, i), _rc_getitem(_rc_st, xs, i)))
        return total
