def _rcv1_glide(_rc_st, x, v):
    if True:
        for _ in range(16):
            if _rc_st[0]:
                break
            v = _rc_nadd(_rc_st, v, _rc_mul(_rc_st, _rc_mul(_rc_st, -0.5, v), 0.01))
            x = _rc_nadd(_rc_st, x, _rc_mul(_rc_st, v, 0.01))
        return x
    else:
        for _ in range(16):
            if _rc_st[0]:
                break
            v = _rc_nadd(_rc_st, v, _rc_mul(_rc_st, _rc_mul(_rc_st, -0.5, v), 0.01))
            x = _rc_nadd(_rc_st, x, _rc_mul(_rc_st, v, 0.01))
        return x
