def _rcv1_GetIndex(_rc_st, self, u):
    dom = _rc_method0(_rc_st, self, ())
    for ii in range(_rc_sub(_rc_st, _rc_getattr1(_rc_st, self), 1), _rc_sub(_rc_st, _rc_len(_rc_st, _rc_getattr2(_rc_st, self)), _rc_getattr1(_rc_st, self))):
        if _rc_st[0]:
            break
        if u >= _rc_getitem(_rc_st, _rc_getattr2(_rc_st, self), ii) and u < _rc_getitem(_rc_st, _rc_getattr2(_rc_st, self), _rc_add(_rc_st, ii, 1)):
            I = ii
            break
    else:
        I = _rc_sub(_rc_st, _rc_index(_rc_st, dom, 1), 1)
    return I
