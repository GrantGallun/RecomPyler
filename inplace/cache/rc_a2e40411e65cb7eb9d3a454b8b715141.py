def _rcv1_peek(_rc_st, grid, x, y):
    return _rc_getitem(_rc_st, grid, (x, y))

def _rcv2__idx(_rc_st, self, x, y):
    if 0 <= x < _rc_getattr0(_rc_st, self) and 0 <= y < _rc_getattr1(_rc_st, self):
        return _rc_add(_rc_st, _rc_mul(_rc_st, y, _rc_getattr0(_rc_st, self)), x)
    _rc_fail(_rc_st)
    return _rc_add(_rc_st, _rc_mul(_rc_st, y, _rc_getattr0(_rc_st, self)), x)

def _rcv4___getitem__(_rc_st, self, x_y):
    _rcv3_unpack = x_y
    _rc_unpack(_rc_st, _rcv3_unpack, 2)
    x = _rc_index(_rc_st, _rcv3_unpack, 0)
    y = _rc_index(_rc_st, _rcv3_unpack, 1)
    return _rc_getitem(_rc_st, _rc_getattr2(_rc_st, self), _rc_method3(_rc_st, self, (x, y)))

def _rcv6___setitem__(_rc_st, self, x_y, value):
    _rcv5_unpack = x_y
    _rc_unpack(_rc_st, _rcv5_unpack, 2)
    x = _rc_index(_rc_st, _rcv5_unpack, 0)
    y = _rc_index(_rc_st, _rcv5_unpack, 1)
    _rc_setitem(_rc_st, _rc_getattr2(_rc_st, self), _rc_method3(_rc_st, self, (x, y)), value)
