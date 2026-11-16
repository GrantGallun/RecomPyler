def _rcv1_twice(_rc_st, a, b):
    _rc_setattr1(_rc_st, a, _rc_nadd(_rc_st, _rc_getattr0(_rc_st, a), 1.0))
    return _rc_getattr0(_rc_st, b)

def _rcv2_dot(_rc_st, self, other):
    return _rc_add(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr0(_rc_st, self), _rc_getattr0(_rc_st, other)), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other))), _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other)))

def _rcv3_new_Vec(_rc_st, x, y, z):
    _rcf_x = x
    _rcf_y = y
    _rcf_z = z
    return _rc_make4(_rc_st, (_rcf_x, _rcf_y, _rcf_z))

def _rcv4___sub__(_rc_st, self, other):
    return _rcv3_new_Vec(_rc_st, _rc_sub(_rc_st, _rc_getattr0(_rc_st, self), _rc_getattr0(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other)))

def _rcv5___mul__(_rc_st, self, k):
    return _rcv3_new_Vec(_rc_st, _rc_mul(_rc_st, _rc_getattr0(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), k))

def _rcv6___rmul__(_rc_st, self, k):
    return _rcv3_new_Vec(_rc_st, _rc_mul(_rc_st, k, _rc_getattr0(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr2(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr3(_rc_st, self)))
