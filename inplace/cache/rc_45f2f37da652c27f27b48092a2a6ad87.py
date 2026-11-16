def _rcv1_branch_owner(_rc_st, n, flag):
    source = _rc_arange(_rc_st, 0, n, 1)
    if flag:
        target = _rc_copy(_rc_st, source)
    else:
        target = _rc_copy(_rc_st, source)
    target = _rc_copy(_rc_st, source)
    return _rc_index(_rc_st, target, 0)
