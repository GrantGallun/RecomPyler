def _rcv2_step(_rc_st, values, k):
    if _rc_array_extent(_rc_st, values, _rc_len(_rc_st, values)) and _rc_array_extent(_rc_st, values, _rc_len(_rc_st, values)) and _rc_int_domain(_rc_st, k, -16777216, 16777216):
        for _ in range(50):
            if _rc_st[0]:
                break
            for i in range(_rc_len(_rc_st, values)):
                if _rc_st[0]:
                    break
                _rc_proven_setitem(_rc_st, values, i, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_proven_getitem(_rc_st, values, i), k), _rcv1_SCALE), 0.001))
        if k > 10.0:
            raise _rc_Fallback
        return _rc_len(_rc_st, values) + float(k)
    else:
        for _ in range(50):
            if _rc_st[0]:
                break
            for i in range(_rc_len(_rc_st, values)):
                if _rc_st[0]:
                    break
                _rc_setitem(_rc_st, values, i, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_getitem(_rc_st, values, i), k), _rcv1_SCALE), 0.001))
        if k > 10.0:
            raise _rc_Fallback
        return _rc_add(_rc_st, _rc_len(_rc_st, values), float(k))
