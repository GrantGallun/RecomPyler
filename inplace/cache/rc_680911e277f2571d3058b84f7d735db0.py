def _rcv2_total_energy(_rc_st, bodies):
    total = 0.0
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, bodies):
        body = bodies[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        total = _rc_nadd(_rc_st, total, _rc_method0(_rc_st, body, ()))
    return total

def _rcv3_energy(_rc_st, self):
    return _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 0.5, _rc_getattr1(_rc_st, self)), _rc_getattr2(_rc_st, self)), _rc_getattr2(_rc_st, self))
