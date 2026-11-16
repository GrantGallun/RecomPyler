def _rcv3_stretch_tail(_rc_st, bodies, k):
    _rcv2_seq = _rc_slice0(_rc_st, bodies)
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, _rcv2_seq):
        body = _rcv2_seq[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        _rc_setattr2(_rc_st, body, _rc_nmul(_rc_st, _rc_getattr1(_rc_st, body), k))
    return _rc_getattr1(_rc_st, _rc_index(_rc_st, _rc_slice0(_rc_st, bodies), 0))

def _rcv4_energy(_rc_st, self):
    return _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 0.5, _rc_getattr3(_rc_st, self)), _rc_getattr4(_rc_st, self)), _rc_getattr4(_rc_st, self))
