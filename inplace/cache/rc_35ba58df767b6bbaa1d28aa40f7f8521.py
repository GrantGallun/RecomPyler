def _rcv1_count_fields(_rc_st, p):
    return _rc_len(_rc_st, p)

def _rcv2_dot(_rc_st, self, other):
    return _rc_add(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr0(_rc_st, self), _rc_getattr0(_rc_st, other)), _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other))), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other)))

def _rcv3_new_Vec(_rc_st, x, y, z):
    _rcf_x = x
    _rcf_y = y
    _rcf_z = z
    return _rc_make3(_rc_st, (_rcf_x, _rcf_y, _rcf_z))

def _rcv4___sub__(_rc_st, self, other):
    return _rcv3_new_Vec(_rc_st, _rc_sub(_rc_st, _rc_getattr0(_rc_st, self), _rc_getattr0(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other)), _rc_sub(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other)))

def _rcv5___mul__(_rc_st, self, k):
    return _rcv3_new_Vec(_rc_st, _rc_mul(_rc_st, _rc_getattr0(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), k), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), k))

def _rcv6___rmul__(_rc_st, self, k):
    return _rcv3_new_Vec(_rc_st, _rc_mul(_rc_st, k, _rc_getattr0(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr1(_rc_st, self)), _rc_mul(_rc_st, k, _rc_getattr2(_rc_st, self)))
