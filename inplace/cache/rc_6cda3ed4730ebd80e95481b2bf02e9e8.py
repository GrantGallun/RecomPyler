def _rcv1_spin(_rc_st, n):
    k = 0
    while not _rc_st[0] and True:
        k = _rc_nadd(_rc_st, k, 1)
        if k >= n:
            return k
