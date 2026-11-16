def _rcv1_pick_heaviest(_rc_st, bodies):
    if _rc_array_extent(_rc_st, bodies, _rc_len(_rc_st, bodies)) and _rc_array_extent(_rc_st, bodies, _rc_len(_rc_st, bodies)):
        best = 0
        for i in range(_rc_len(_rc_st, bodies)):
            if _rc_st[0]:
                break
            if _rc_getattr0(_rc_st, _rc_proven_getitem(_rc_st, bodies, i)) > _rc_getattr0(_rc_st, _rc_getitem(_rc_st, bodies, best)):
                best = i
        return _rc_getitem(_rc_st, bodies, best)
    else:
        best = 0
        for i in range(_rc_len(_rc_st, bodies)):
            if _rc_st[0]:
                break
            if _rc_getattr0(_rc_st, _rc_getitem(_rc_st, bodies, i)) > _rc_getattr0(_rc_st, _rc_getitem(_rc_st, bodies, best)):
                best = i
        return _rc_getitem(_rc_st, bodies, best)

def _rcv2_energy(_rc_st, self):
    return _rc_mul(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 0.5, _rc_getattr0(_rc_st, self)), _rc_getattr1(_rc_st, self)), _rc_getattr1(_rc_st, self))
