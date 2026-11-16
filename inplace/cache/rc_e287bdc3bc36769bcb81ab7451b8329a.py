def _rcv1_relax(_rc_st, grid, sweeps, omega):
    if _rc_int_domain(_rc_st, omega, -16777216, 16777216):
        for _ in range(sweeps):
            if _rc_st[0]:
                break
            for y in range(1, _rc_sub(_rc_st, _rc_getattr0(_rc_st, grid), 1)):
                if _rc_st[0]:
                    break
                for x in range(1, _rc_sub(_rc_st, _rc_getattr1(_rc_st, grid), 1)):
                    if _rc_st[0]:
                        break
                    _rc_setitem(_rc_st, grid, (x, y), _rc_add(_rc_st, _rc_mul(_rc_st, omega * 0.25, _rc_add(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_getitem(_rc_st, grid, (x, _rc_sub(_rc_st, y, 1))), _rc_getitem(_rc_st, grid, (x, _rc_add(_rc_st, y, 1)))), _rc_getitem(_rc_st, grid, (_rc_sub(_rc_st, x, 1), y))), _rc_getitem(_rc_st, grid, (_rc_add(_rc_st, x, 1), y)))), _rc_mul(_rc_st, 1.0 - omega, _rc_getitem(_rc_st, grid, (x, y)))))
    else:
        for _ in range(sweeps):
            if _rc_st[0]:
                break
            for y in range(1, _rc_sub(_rc_st, _rc_getattr0(_rc_st, grid), 1)):
                if _rc_st[0]:
                    break
                for x in range(1, _rc_sub(_rc_st, _rc_getattr1(_rc_st, grid), 1)):
                    if _rc_st[0]:
                        break
                    _rc_setitem(_rc_st, grid, (x, y), _rc_add(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, omega, 0.25), _rc_add(_rc_st, _rc_add(_rc_st, _rc_add(_rc_st, _rc_getitem(_rc_st, grid, (x, _rc_sub(_rc_st, y, 1))), _rc_getitem(_rc_st, grid, (x, _rc_add(_rc_st, y, 1)))), _rc_getitem(_rc_st, grid, (_rc_sub(_rc_st, x, 1), y))), _rc_getitem(_rc_st, grid, (_rc_add(_rc_st, x, 1), y)))), _rc_mul(_rc_st, _rc_sub(_rc_st, 1.0, omega), _rc_getitem(_rc_st, grid, (x, y)))))
