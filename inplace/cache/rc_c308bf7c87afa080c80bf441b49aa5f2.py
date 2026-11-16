def _rcv1_drift(_rc_st, bodies, dt):
    if _rc_array_extent(_rc_st, bodies, _rc_len(_rc_st, bodies)) and _rc_array_extent(_rc_st, bodies, _rc_len(_rc_st, bodies)):
        for i in range(_rc_len(_rc_st, bodies)):
            if _rc_st[0]:
                break
            _rc_setattr2(_rc_st, _rc_proven_getitem(_rc_st, bodies, i), _rc_nadd(_rc_st, _rc_getattr0(_rc_st, _rc_proven_getitem(_rc_st, bodies, i)), _rc_mul(_rc_st, _rc_getattr1(_rc_st, _rc_proven_getitem(_rc_st, bodies, i)), dt)))
    else:
        for i in range(_rc_len(_rc_st, bodies)):
            if _rc_st[0]:
                break
            _rc_setattr2(_rc_st, _rc_getitem(_rc_st, bodies, i), _rc_nadd(_rc_st, _rc_getattr0(_rc_st, _rc_getitem(_rc_st, bodies, i)), _rc_mul(_rc_st, _rc_getattr1(_rc_st, _rc_getitem(_rc_st, bodies, i)), dt)))

def _rcv2_energy(_rc_st, self):
    return _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 0.5, _rc_getattr3(_rc_st, self)), _rc_getattr1(_rc_st, self)), _rc_getattr1(_rc_st, self))
