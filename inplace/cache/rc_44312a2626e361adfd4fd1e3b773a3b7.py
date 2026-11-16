def _rcv1_shuffle(_rc_st, n, k):
    if True:
        perm = list(range(n))
        _rc_moveslice(_rc_st, perm, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
        copy = _rc_slice0(_rc_st, perm)
        copy[1:3] = _rc_samelist(_rc_st, copy, [7])
        pass
        _rc_append(_rc_st, copy, _rc_method1(_rc_st, perm, (0,)))
        _rc_method2(_rc_st, copy, (1, _rc_method1(_rc_st, perm, ())))
        return (perm, copy)
    else:
        perm = list(range(n))
        _rc_moveslice(_rc_st, perm, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
        copy = _rc_slice0(_rc_st, perm)
        copy[1:3] = _rc_samelist(_rc_st, copy, [7])
        pass
        _rc_append(_rc_st, copy, _rc_method1(_rc_st, perm, (0,)))
        _rc_method2(_rc_st, copy, (1, _rc_method1(_rc_st, perm, ())))
        return (perm, copy)
