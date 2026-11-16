def _rcv1___init__(_rc_st, self, x, y, z):
    _rc_setattr0(_rc_st, self, x)
    _rc_setattr1(_rc_st, self, y)
    _rc_setattr2(_rc_st, self, z)

def _rcv2_Mag(_rc_st, self):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_sq(_rc_st, _rc_getattr3(_rc_st, self)), _rc_sq(_rc_st, _rc_getattr4(_rc_st, self))), _rc_sq(_rc_st, _rc_getattr5(_rc_st, self))))

def _rcv3_dist(_rc_st, self, other):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_sq(_rc_st, _rc_sub(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, other))), _rc_sq(_rc_st, _rc_sub(_rc_st, _rc_getattr4(_rc_st, self), _rc_getattr4(_rc_st, other)))), _rc_sq(_rc_st, _rc_sub(_rc_st, _rc_getattr5(_rc_st, self), _rc_getattr5(_rc_st, other)))))

def _rcv4___sub__(_rc_st, self, other):
    return _rc_add(_rc_st, self, _rc_mul(_rc_st, other, -1))

def _rcv5_new_GVector(_rc_st, x, y, z):
    _rcf_x = x
    _rcf_y = y
    _rcf_z = z
    return _rc_make6(_rc_st, (_rcf_x, _rcf_y, _rcf_z))

def _rcv6___mul__(_rc_st, self, other):
    v = _rcv5_new_GVector(_rc_st, _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), other), _rc_mul(_rc_st, _rc_getattr4(_rc_st, self), other), _rc_mul(_rc_st, _rc_getattr5(_rc_st, self), other))
    return v
