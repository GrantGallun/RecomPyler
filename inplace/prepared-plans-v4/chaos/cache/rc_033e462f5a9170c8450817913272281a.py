def _rcv1_truncate(_rc_st, self, point):
    if _rc_getattr0(_rc_st, point) >= _rc_getattr1(_rc_st, self):
        _rc_setattr2(_rc_st, point, _rc_getattr1(_rc_st, self))
    if _rc_getattr3(_rc_st, point) >= _rc_getattr4(_rc_st, self):
        _rc_setattr5(_rc_st, point, _rc_getattr4(_rc_st, self))
    if _rc_getattr0(_rc_st, point) < _rc_getattr6(_rc_st, self):
        _rc_setattr2(_rc_st, point, _rc_getattr6(_rc_st, self))
    if _rc_getattr3(_rc_st, point) < _rc_getattr7(_rc_st, self):
        _rc_setattr5(_rc_st, point, _rc_getattr7(_rc_st, self))
