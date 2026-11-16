def _rcv1_fields_Either(_rc_st, value):
    _rcf_value = value
    return (_rcf_value,)

def _rcv2_make_mixed(_rc_st, n):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        items = _rc_blank0(_rc_st, n)
        for i in range(n):
            if _rc_st[0]:
                break
            _rc_fill1(_rc_st, items, i, _rcv1_fields_Either(_rc_st, i))
            _rc_fill1(_rc_st, items, i, _rcv1_fields_Either(_rc_st, i * 0.5))
        return _rc_getattr2(_rc_st, _rc_getitem(_rc_st, items, n - 1))
    else:
        items = _rc_blank0(_rc_st, n)
        for i in range(n):
            if _rc_st[0]:
                break
            _rc_fill1(_rc_st, items, i, _rcv1_fields_Either(_rc_st, i))
            _rc_fill1(_rc_st, items, i, _rcv1_fields_Either(_rc_st, _rc_mul(_rc_st, i, 0.5)))
        return _rc_getattr2(_rc_st, _rc_getitem(_rc_st, items, _rc_sub(_rc_st, n, 1)))
