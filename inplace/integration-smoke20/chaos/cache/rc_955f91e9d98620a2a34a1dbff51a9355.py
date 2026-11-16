def _rcv1___sub__(_rc_st, self, other):
    if _rc_int_domain(_rc_st, other, -16777216, 16777216) and _rc_int_domain(_rc_st, self, -16777216, 16777216):
        return self + other * -1
    else:
        return _rc_add(_rc_st, self, _rc_mul(_rc_st, other, -1))
