def _rcv1_fields_Dot(_rc_st, i):
    _rcf_x = x = _rc_cos(_rc_st, i)
    _rcf_y = _rc_add(_rc_st, _rc_mul(_rc_st, x, 2), i)
    return (_rcf_x, _rcf_y)

def _rcv2_make_list_and_one(_rc_st, n):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        dots = _rc_blank0(_rc_st, n)
        for i in range(n):
            if _rc_st[0]:
                break
            _rc_fill1(_rc_st, dots, i, _rcv1_fields_Dot(_rc_st, i))
        _rc_method2(_rc_st, _rc_index(_rc_st, dots, 0), (3.0,))
        return (dots, _rc_index(_rc_st, dots, 0), _rc_getitem(_rc_st, dots, n - 1))
    else:
        dots = _rc_blank0(_rc_st, n)
        for i in range(n):
            if _rc_st[0]:
                break
            _rc_fill1(_rc_st, dots, i, _rcv1_fields_Dot(_rc_st, i))
        _rc_method2(_rc_st, _rc_index(_rc_st, dots, 0), (3.0,))
        return (dots, _rc_index(_rc_st, dots, 0), _rc_getitem(_rc_st, dots, _rc_sub(_rc_st, n, 1)))

def _rcv3_stretch(_rc_st, self, k):
    _rc_setattr4(_rc_st, self, _rc_nmul(_rc_st, _rc_getattr3(_rc_st, self), k))
    _rc_setattr6(_rc_st, self, _rc_nmul(_rc_st, _rc_getattr5(_rc_st, self), k))

def _rcv4_larger(_rc_st, self, other):
    _rc_setattr4(_rc_st, self, _rc_getattr3(_rc_st, self) if _rc_getattr3(_rc_st, self) > _rc_getattr3(_rc_st, other) else _rc_getattr3(_rc_st, other))
    return self

def _rcv5_size(_rc_st, self):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_mul(_rc_st, _rc_getattr3(_rc_st, self), _rc_getattr3(_rc_st, self)), _rc_mul(_rc_st, _rc_getattr5(_rc_st, self), _rc_getattr5(_rc_st, self))))
