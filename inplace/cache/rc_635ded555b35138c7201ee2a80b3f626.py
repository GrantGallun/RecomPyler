def _rcv2_new_Vec(_rc_st, x, y, z):
    _rcf_x = x
    _rcf_y = y
    _rcf_z = z
    return _rc_make0(_rc_st, (_rcf_x, _rcf_y, _rcf_z))

def _rcv3_build_vec(_rc_st, a, b):
    return _rc_sub(_rc_st, _rcv2_new_Vec(_rc_st, a, b, _rcv1___init___default0), _rcv2_new_Vec(_rc_st, b, a, _rcv1___init___default0))

def _rcv4_dot(_rc_st, self, other):
    return _rc_add(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other)), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other))), _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other)))

def _rcv5___sub__(_rc_st, self, other):
    return _rcv2_new_Vec(_rc_st, _rc_sub(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other)))

def _rcv6___mul__(_rc_st, self, k):
    return _rcv2_new_Vec(_rc_st, _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), k))

def _rcv7___rmul__(_rc_st, self, k):
    return _rcv2_new_Vec(_rc_st, _rc_mul(_rc_st, k, _rc_getattr1(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr2(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr3(_rc_st, self)))
