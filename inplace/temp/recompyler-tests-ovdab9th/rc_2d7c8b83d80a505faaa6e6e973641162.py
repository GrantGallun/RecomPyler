def _rcv7_clamp(_rc_st, x, lo, hi):
    return lo if x < lo else hi if x > hi else x

def _rcv8_score_hand(_rc_st, cards):
    if _rc_len(_rc_st, cards) != 4:
        return 0.5
    rank_counts = _rc_mul(_rc_st, [0], 5)
    suit_masks = _rc_full(_rc_st, 4, 0)
    total = 0
    _rcv1_k = _rc_int64(0)
    while not _rc_st[0] and _rcv1_k < _rc_len(_rc_st, cards):
        c = cards[_rcv1_k]
        _rcv1_k = _rcv1_k + 1
        if not 0 <= _rc_int(_rc_st, c) < 20:
            return 0.5
        _rc_setitem(_rc_st, rank_counts, _rc_rshift(_rc_st, _rc_int(_rc_st, c), 2), _rc_nadd(_rc_st, _rc_getitem(_rc_st, rank_counts, _rc_rshift(_rc_st, _rc_int(_rc_st, c), 2)), 1))
        _rc_setitem(_rc_st, suit_masks, _rc_int(_rc_st, c) & 3, _rc_getitem(_rc_st, suit_masks, _rc_int(_rc_st, c) & 3) | _rc_lshift(_rc_st, 1, _rc_rshift(_rc_st, _rc_int(_rc_st, c), 2)))
        total = _rc_nadd(_rc_st, total, _rc_rshift(_rc_st, _rc_int(_rc_st, c), 2))
    q = _rc_add(_rc_st, 0.25, _rc_mul(_rc_st, _rcv2_SCALE, _rc_div(_rc_st, total, 16.0)))
    mask = 0
    for r, n in enumerate(rank_counts):
        if _rc_st[0]:
            break
        if n:
            mask = mask | _rc_lshift(_rc_st, 1, r)
        if n == 2:
            q = _rc_nadd(_rc_st, q, _rc_add(_rc_st, 0.05, _rc_mul(_rc_st, 0.01, r)))
    best = 0
    _rcv3_k = _rc_int64(0)
    while not _rc_st[0] and _rcv3_k < _rc_len(_rc_st, _rcv4_WINDOWS):
        window = _rcv4_WINDOWS[_rcv3_k]
        _rcv3_k = _rcv3_k + 1
        best = _rc_max(_rc_st, best, _rc_popcount(_rc_st, mask & window))
    distinct = [_rcv5_r for _rcv5_r, _rcv6_n in enumerate(rank_counts) if _rcv6_n]
    gaps = 0
    for i in range(_rc_len(_rc_st, distinct)):
        if _rc_st[0]:
            break
        for j in range(_rc_add(_rc_st, i, 1), _rc_len(_rc_st, distinct)):
            if _rc_st[0]:
                break
            if _rc_sub(_rc_st, _rc_getitem(_rc_st, distinct, j), _rc_getitem(_rc_st, distinct, i)) == 1:
                gaps = _rc_nadd(_rc_st, gaps, 1)
    return _rcv7_clamp(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, q, _rc_mul(_rc_st, 0.03, best)), _rc_mul(_rc_st, _rc_min(_rc_st, gaps, 3), 0.008)), 0.2, 0.94)
