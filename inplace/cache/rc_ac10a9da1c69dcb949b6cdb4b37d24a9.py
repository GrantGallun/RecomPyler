def _rcv1_checked_log(_rc_st, n):
    if _rc_int_domain(_rc_st, n, 1, 16777216) and _rc_power_extent(_rc_st, n, 1):
        k = 1
        log = 0
        while not _rc_st[0] and k < n:
            k = k * 2
            log = _rc_nadd(_rc_st, log, 1)
        if n != _rc_lshift(_rc_st, 1, log):
            raise _rc_Fallback
        return log
    else:
        k = 1
        log = 0
        while not _rc_st[0] and k < n:
            k = _rc_nmul(_rc_st, k, 2)
            log = _rc_nadd(_rc_st, log, 1)
        if n != _rc_lshift(_rc_st, 1, log):
            raise _rc_Fallback
        return log
