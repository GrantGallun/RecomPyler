def _rcv1_changing_fill(_rc_st, n):
    if _rc_int_domain(_rc_st, n, -16777216, 16777216):
        values = _rc_full(_rc_st, 1, 0)
        total = 0
        for r in range(4):
            if _rc_st[0]:
                break
            values = _rc_full_reuse(_rc_st, values, n + r, 0)
            total = _rc_nadd(_rc_st, total, _rc_len(_rc_st, values))
        return total
    else:
        values = _rc_full(_rc_st, 1, 0)
        total = 0
        for r in range(4):
            if _rc_st[0]:
                break
            values = _rc_full_reuse(_rc_st, values, _rc_add(_rc_st, n, r), 0)
            total = _rc_nadd(_rc_st, total, _rc_len(_rc_st, values))
        return total
