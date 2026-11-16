def _rcv1_release(_rc_st, self, i):
    t = _rc_method0(_rc_st, self, (i,))
    _rc_setattr1(_rc_st, t, False)
    if _rc_getattr2(_rc_st, t) > _rc_getattr2(_rc_st, self):
        return t
    else:
        return self
