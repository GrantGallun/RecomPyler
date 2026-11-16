def _rcv1_bump_some(_rc_st, values, step):
    if True:
        for j in range(3):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, values, j * 5, _rc_nadd(_rc_st, _rc_getitem(_rc_st, values, j * 5), step))
    else:
        for j in range(3):
            if _rc_st[0]:
                break
            _rc_setitem(_rc_st, values, _rc_mul(_rc_st, j, 5), _rc_nadd(_rc_st, _rc_getitem(_rc_st, values, _rc_mul(_rc_st, j, 5)), step))
