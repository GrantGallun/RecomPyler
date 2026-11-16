def _rcv1_Mag(_rc_st, self):
    return _rc_sqrt(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_sq(_rc_st, _rc_getattr0(_rc_st, self)), _rc_sq(_rc_st, _rc_getattr1(_rc_st, self))), _rc_sq(_rc_st, _rc_getattr2(_rc_st, self))))
