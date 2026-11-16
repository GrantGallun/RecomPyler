def _rcv1_fannkuch(_rc_st, n):
    if _rc_int_domain(_rc_st, n, 1, 16777216):
        count = _rc_arange(_rc_st, 1, n + 1, 1)
        max_flips = 0
        m = n - 1
        r = n
        perm1 = _rc_arange(_rc_st, 0, n, 1)
        perm = _rc_arange(_rc_st, 0, n, 1)
        pass
        pass
        while not _rc_st[0] and 1:
            while not _rc_st[0] and r != 1:
                _rc_proven_setitem(_rc_st, count, r - 1, r)
                r = r - 1
            if _rc_proven_getitem(_rc_st, perm1, 0) != 0 and _rc_proven_getitem(_rc_st, perm1, m) != m:
                if _rc_copy_fits(_rc_st, perm, perm1):
                    _rc_copy_into(_rc_st, perm, perm1)
                else:
                    perm = _rc_copy(_rc_st, perm1)
                flips_count = 0
                k = _rc_proven_getitem(_rc_st, perm, 0)
                while not _rc_st[0] and k:
                    _rc_proven_flip(_rc_st, perm, k)
                    flips_count = _rc_nadd(_rc_st, flips_count, 1)
                    k = _rc_proven_getitem(_rc_st, perm, 0)
                if flips_count > max_flips:
                    max_flips = flips_count
            while not _rc_st[0] and r != n:
                _rc_proven_rotate(_rc_st, perm1, r, 0)
                _rc_proven_setitem(_rc_st, count, r, _rc_sub(_rc_st, _rc_proven_getitem(_rc_st, count, r), 1))
                if _rc_proven_getitem(_rc_st, count, r) > 0:
                    break
                r = r + 1
            else:
                return max_flips
    else:
        count = _rc_arange(_rc_st, 1, _rc_add(_rc_st, n, 1), 1)
        max_flips = 0
        m = _rc_sub(_rc_st, n, 1)
        r = n
        perm1 = _rc_arange(_rc_st, 0, n, 1)
        perm = _rc_arange(_rc_st, 0, n, 1)
        pass
        pass
        while not _rc_st[0] and 1:
            while not _rc_st[0] and r != 1:
                _rc_setitem(_rc_st, count, _rc_sub(_rc_st, r, 1), r)
                r = _rc_sub(_rc_st, r, 1)
            if _rc_index(_rc_st, perm1, 0) != 0 and _rc_getitem(_rc_st, perm1, m) != m:
                if _rc_copy_fits(_rc_st, perm, perm1):
                    _rc_copy_into(_rc_st, perm, perm1)
                else:
                    perm = _rc_copy(_rc_st, perm1)
                flips_count = 0
                k = _rc_index(_rc_st, perm, 0)
                while not _rc_st[0] and k:
                    _rc_moveslice(_rc_st, perm, k, None, -1, None, _rc_add(_rc_st, k, 1), None)
                    flips_count = _rc_nadd(_rc_st, flips_count, 1)
                    k = _rc_index(_rc_st, perm, 0)
                if flips_count > max_flips:
                    max_flips = flips_count
            while not _rc_st[0] and r != n:
                _rc_rotate(_rc_st, perm1, r, 0)
                _rc_setitem(_rc_st, count, r, _rc_sub(_rc_st, _rc_getitem(_rc_st, count, r), 1))
                if _rc_getitem(_rc_st, count, r) > 0:
                    break
                r = _rc_nadd(_rc_st, r, 1)
            else:
                return max_flips