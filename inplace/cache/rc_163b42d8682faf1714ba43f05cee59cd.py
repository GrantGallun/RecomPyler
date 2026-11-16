def _rcv1_give_back(_rc_st, bodies):
    return bodies

def _rcv2_energy(_rc_st, self):
    return _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 0.5, _rc_getattr0(_rc_st, self)), _rc_getattr1(_rc_st, self)), _rc_getattr1(_rc_st, self))
