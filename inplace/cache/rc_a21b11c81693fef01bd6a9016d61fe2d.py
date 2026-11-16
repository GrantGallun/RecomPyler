def _rcv3_rebinds_sequence(_rc_st, values):
    total = 0.0
    _rcp_total = True
    _rcv2_seq = values
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, _rcv2_seq):
        value = _rcv2_seq[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        total = _rc_nadd(_rc_st, total, _rc_floatonly(_rc_st, value))
        _rcp_total = False
        values = [1, 2, 3]
    return _rc_settled(_rc_st, total, _rcp_total)
