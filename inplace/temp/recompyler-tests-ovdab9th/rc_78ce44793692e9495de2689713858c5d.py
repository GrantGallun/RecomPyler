def _rcv2_fields_Counted(_rc_st, i, weight):
    _rcf_n = _rc_mul(_rc_st, i, weight)
    _rcf_even = _rc_mod(_rc_st, i, 2) == 0
    _rcf_share = _rc_div(_rc_st, i, 4)
    return (_rcf_even, _rcf_n, _rcf_share)

def _rcv3_make_same_twice(_rc_st, n):
    items = _rc_blank0(_rc_st, n)
    for i in range(n):
        if _rc_st[0]:
            break
        _rc_fill1(_rc_st, items, i, _rcv2_fields_Counted(_rc_st, i, _rcv1___init___default0))
    return (_rc_index(_rc_st, items, 0), _rc_index(_rc_st, items, 0))
