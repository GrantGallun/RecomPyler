def _rcv2_spread(_rc_st, points, k):
    total = 0.0
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, points):
        p = points[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        d = _rc_sub(_rc_st, p, _rc_index(_rc_st, points, 0))
        total = _rc_nadd(_rc_st, total, _rc_add(_rc_st, _rc_add(_rc_st, _rc_method0(_rc_st, d, (d,)), _rc_getattr1(_rc_st, _rc_mul(_rc_st, 2.0, p))), _rc_getattr2(_rc_st, _rc_mul(_rc_st, p, k))))
    return total

def _rcv3_dot(_rc_st, self, other):
    return _rc_add(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other)), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other))), _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other)))

def _rcv4_new_Vec(_rc_st, x, y, z):
    _rcf_x = x
    _rcf_y = y
    _rcf_z = z
    return _rc_make4(_rc_st, (_rcf_x, _rcf_y, _rcf_z))

def _rcv5___sub__(_rc_st, self, other):
    return _rcv4_new_Vec(_rc_st, _rc_sub(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other)))

def _rcv6___mul__(_rc_st, self, k):
    return _rcv4_new_Vec(_rc_st, _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), k))

def _rcv7___rmul__(_rc_st, self, k):
    return _rcv4_new_Vec(_rc_st, _rc_mul(_rc_st, k, _rc_getattr1(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr2(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr3(_rc_st, self)))
