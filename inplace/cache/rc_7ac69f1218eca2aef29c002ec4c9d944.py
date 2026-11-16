def _rcv3_iterator_keeps_old_list(_rc_st):
    values = _rc_arange(_rc_st, 0, 3, 1)
    total = 0
    _rcv2_seq = values
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, _rcv2_seq):
        value = _rcv2_seq[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        values = _rc_full(_rc_st, 3, 9)
        total = _rc_nadd(_rc_st, total, value)
    return total
