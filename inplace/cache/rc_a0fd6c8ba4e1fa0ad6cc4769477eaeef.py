def _rcv2_offset(_rc_st, x, index):
    return _rc_add(_rc_st, x, _rc_getitem(_rc_st, _rcv1_OFFSETS, index))
