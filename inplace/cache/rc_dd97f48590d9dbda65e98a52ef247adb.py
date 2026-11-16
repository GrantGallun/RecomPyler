def _rcv1_first_index(_rc_st, values, wanted):
    if True:
        for i, value in enumerate(values):
            if _rc_st[0]:
                break
            if value == wanted:
                break
        else:
            return -1
        return i
    else:
        for i, value in enumerate(values):
            if _rc_st[0]:
                break
            if value == wanted:
                break
        else:
            return -1
        return i
