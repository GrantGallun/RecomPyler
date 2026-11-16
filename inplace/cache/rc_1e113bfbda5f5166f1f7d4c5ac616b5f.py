def _rcv1_clamp(_rc_st, x, lo, hi):
    return lo if x < lo else hi if x > hi else x
