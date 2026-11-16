def _rcv2_clamp(_rc_st, x, lo, hi):
    return lo if x < lo else hi if x > hi else x

def _rcv3_score(_rc_st, cards):
    counts = _rc_full(_rc_st, 4, 0)
    total = 0.0
    for index, card in enumerate(cards):
        if _rc_st[0]:
            break
        _rc_setitem(_rc_st, counts, card & 3, _rc_nadd(_rc_st, _rc_getitem(_rc_st, counts, card & 3), 1))
        total = _rc_nadd(_rc_st, total, _rc_mul(_rc_st, _rc_getitem(_rc_st, _rcv1_WEIGHTS, index), _rc_rshift(_rc_st, card, 2)))
    return _rcv2_clamp(_rc_st, _rc_add(_rc_st, total, _rc_max(_rc_st, _rc_index(_rc_st, counts, 0), _rc_index(_rc_st, counts, 1))), 0.0, 9.5)
