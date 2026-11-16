def _rcv1_extends_in_place(_rc_st, x):
    values = [x]
    alias = values
    values = _rc_nadd(_rc_st, values, [x])
    return _rc_len(_rc_st, alias)
