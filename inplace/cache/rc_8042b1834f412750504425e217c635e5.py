def _rcv2_tally(_rc_st, counter, values):
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, values):
        value = values[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        _rc_method0(_rc_st, counter, (value,))
    return _rc_div(_rc_st, _rc_getattr1(_rc_st, counter), _rc_getattr2(_rc_st, counter))

def _rcv3_add(_rc_st, self, value):
    _rc_setattr3(_rc_st, self, _rc_nadd(_rc_st, _rc_getattr2(_rc_st, self), 1))
    _rc_setattr4(_rc_st, self, _rc_nadd(_rc_st, _rc_getattr1(_rc_st, self), value))
