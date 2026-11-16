def _rcv1___sub__(_rc_st, self, other):
    return _rc_add(_rc_st, self, _rc_mul(_rc_st, other, -1))
