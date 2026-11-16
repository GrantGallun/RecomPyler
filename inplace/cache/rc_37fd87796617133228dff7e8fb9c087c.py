def _rcv1_fields_Dot(_rc_st, i):
    _rcf_x = x = _rc_cos(_rc_st, i)
    _rcf_y = _rc_add(_rc_st, _rc_mul(_rc_st, x, 2), i)
    return (_rcf_x, _rcf_y)

def _rcv5_make_and_reduce(_rc_st, n, k):
    dots = _rc_blank0(_rc_st, n)
    for i in range(n):
        if _rc_st[0]:
            break
        _rc_fill1(_rc_st, dots, i, _rcv1_fields_Dot(_rc_st, i))
    _rcv2_k = _rc_int64(0)
    while not _rc_st[0] and _rcv2_k < _rc_len(_rc_st, dots):
        dot = dots[_rcv2_k]
        _rcv2_k = _rcv2_k + 1
        _rc_method2(_rc_st, dot, (k,))
    best = _rc_index(_rc_st, dots, 0)
    _rcv4_seq = _rc_slice3(_rc_st, dots)
    _rcv3_k = _rc_int64(0)
    while not _rc_st[0] and _rcv3_k < _rc_len(_rc_st, _rcv4_seq):
        dot = _rcv4_seq[_rcv3_k]
        _rcv3_k = _rcv3_k + 1
        best = _rc_method4(_rc_st, best, (dot,))
    return best

def _rcv6_stretch(_rc_st, self, k):
    _rc_setattr6(_rc_st, self, _rc_nmul(_rc_st, _rc_getattr5(_rc_st, self), k))
    _rc_setattr8(_rc_st, self, _rc_nmul(_rc_st, _rc_getattr7(_rc_st, self), k))

def _rcv7_larger(_rc_st, self, other):
    _rc_setattr6(_rc_st, self, _rc_getattr5(_rc_st, self) if _rc_getattr5(_rc_st, self) > _rc_getattr5(_rc_st, other) else _rc_getattr5(_rc_st, other))
    return self

def _rcv8_size(_rc_st, self):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr5(_rc_st, self), _rc_getattr5(_rc_st, self)), _rc_mul(_rc_st, _rc_getattr7(_rc_st, self), _rc_getattr7(_rc_st, self))))
