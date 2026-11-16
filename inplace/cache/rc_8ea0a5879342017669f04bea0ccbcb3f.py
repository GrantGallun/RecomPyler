def _rcv1_fields_Dot(_rc_st, i):
    _rcf_x = x = _rc_cos(_rc_st, i)
    _rcf_y = _rc_add(_rc_st, _rc_mul(_rc_st, x, 2), i)
    return (_rcf_x, _rcf_y)

def _rcv3_make_total(_rc_st, n):
    dots = _rc_blank0(_rc_st, n)
    for i in range(n):
        if _rc_st[0]:
            break
        _rc_fill1(_rc_st, dots, i, _rcv1_fields_Dot(_rc_st, i))
    total = 0.0
    _rcv2_k = _rc_int64(0)
    while not _rc_st[0] and _rcv2_k < _rc_len(_rc_st, dots):
        dot = dots[_rcv2_k]
        _rcv2_k = _rcv2_k + 1
        total = _rc_nadd(_rc_st, total, _rc_method2(_rc_st, dot, ()))
    return total

def _rcv4_stretch(_rc_st, self, k):
    _rc_setattr4(_rc_st, self, _rc_nmul(_rc_st, _rc_getattr3(_rc_st, self), k))
    _rc_setattr6(_rc_st, self, _rc_nmul(_rc_st, _rc_getattr5(_rc_st, self), k))

def _rcv5_larger(_rc_st, self, other):
    _rc_setattr4(_rc_st, self, _rc_getattr3(_rc_st, self) if _rc_getattr3(_rc_st, self) > _rc_getattr3(_rc_st, other) else _rc_getattr3(_rc_st, other))
    return self

def _rcv6_size(_rc_st, self):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, self)), _rc_mul(_rc_st, _rc_getattr5(_rc_st, self), _rc_getattr5(_rc_st, self))))
