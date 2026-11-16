def _rcv1_Mag(_rc_st, self):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_sq(_rc_st, _rc_getattr0(_rc_st, self)), _rc_sq(_rc_st, _rc_getattr1(_rc_st, self))), _rc_sq(_rc_st, _rc_getattr2(_rc_st, self))))

def _rcv2_dist(_rc_st, self, other):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_sq(_rc_st, _rc_sub(_rc_st, _rc_getattr0(_rc_st, self), _rc_getattr0(_rc_st, other))), _rc_sq(_rc_st, _rc_sub(_rc_st, _rc_getattr1(_rc_st, self), _rc_getattr1(_rc_st, other)))), _rc_sq(_rc_st, _rc_sub(_rc_st, _rc_getattr2(_rc_st, self), _rc_getattr2(_rc_st, other)))))

def _rcv3___sub__(_rc_st, self, other):
    if _rc_int_domain(_rc_st, other, -16777216, 16777216) and _rc_int_domain(_rc_st, self, -16777216, 16777216):
        return self + other * -1
    else:
        return _rc_add(_rc_st, self, _rc_mul(_rc_st, other, -1))

def _rcv4_new_GVector(_rc_st, x, y, z):
    _rcf_x = x
    _rcf_y = y
    _rcf_z = z
    return _rc_make3(_rc_st, (_rcf_x, _rcf_y, _rcf_z))

def _rcv5___mul__(_rc_st, self, other):
    v = _rcv4_new_GVector(_rc_st, _rc_mul(_rc_st, _rc_getattr0(_rc_st, self), other), _rc_mul(_rc_st, _rc_getattr1(_rc_st, self), other), _rc_mul(_rc_st, _rc_getattr2(_rc_st, self), other))
    return v
