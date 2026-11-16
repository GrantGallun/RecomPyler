def _rcv2_fields_Counted(_rc_st, i, weight):
    _rcf_n = _rc_mul(_rc_st, i, weight)
    _rcf_even = _rc_mod(_rc_st, i, 2) == 0
    _rcf_share = _rc_div(_rc_st, i, 4)
    return (_rcf_even, _rcf_n, _rcf_share)

def _rcv5_make_counted(_rc_st, n):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        items = _rc_blank0(_rc_st, n)
        for i in range(n):
            if _rc_st[0]:
                break
            _rc_fill1(_rc_st, items, i, _rcv2_fields_Counted(_rc_st, i, _rcv1___init___default0))
        total = 0
        _rcv4_k = _rc_int64(0)
        while not _rc_st[0] and _rcv4_k < _rc_len(_rc_st, items):
            item = items[_rcv4_k]
            _rcv4_k = _rcv4_k + 1
            if _rc_getattr2(_rc_st, item):
                total = _rc_nadd(_rc_st, total, _rc_getattr3(_rc_st, item))
        return (total, _rc_getattr4(_rc_st, _rc_getitem(_rc_st, items, n - 1)))
    else:
        items = _rc_blank0(_rc_st, n)
        for i in range(n):
            if _rc_st[0]:
                break
            _rc_fill1(_rc_st, items, i, _rcv2_fields_Counted(_rc_st, i, _rcv1___init___default0))
        total = 0
        _rcv3_k = _rc_int64(0)
        while not _rc_st[0] and _rcv3_k < _rc_len(_rc_st, items):
            item = items[_rcv3_k]
            _rcv3_k = _rcv3_k + 1
            if _rc_getattr2(_rc_st, item):
                total = _rc_nadd(_rc_st, total, _rc_getattr3(_rc_st, item))
        return (total, _rc_getattr4(_rc_st, _rc_getitem(_rc_st, items, _rc_sub(_rc_st, n, 1))))
