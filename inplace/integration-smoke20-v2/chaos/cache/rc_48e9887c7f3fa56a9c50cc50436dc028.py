def _rcv3___call__(_rc_st, self, u):
    if True:
        dom = _rc_method0(_rc_st, self, ())
        if u < _rc_index(_rc_st, dom, 0) or u > _rc_index(_rc_st, dom, 1):
            _rc_fail(_rc_st)
            return _rc_index(_rc_st, _rc_getattr1(_rc_st, self), 0)
        if u == _rc_index(_rc_st, dom, 0):
            return _rc_index(_rc_st, _rc_getattr1(_rc_st, self), 0)
        if u == _rc_index(_rc_st, dom, 1):
            return _rc_getitem(_rc_st, _rc_getattr1(_rc_st, self), -1)
        I = _rc_method2(_rc_st, self, (u,))
        d = [_rc_getitem(_rc_st, _rc_getattr1(_rc_st, self), _rc_add(_rc_st, _rc_add(_rc_st, _rc_sub(_rc_st, I, _rc_getattr3(_rc_st, self)), 1), _rcv2_ii)) for _rcv2_ii in range(_rc_add(_rc_st, _rc_getattr3(_rc_st, self), 1))]
        U = _rc_getattr4(_rc_st, self)
        for ik in range(1, _rc_add(_rc_st, _rc_getattr3(_rc_st, self), 1)):
            if _rc_st[0]:
                break
            for ii in range(_rc_add(_rc_st, _rc_add(_rc_st, _rc_sub(_rc_st, I, _rc_getattr3(_rc_st, self)), ik), 1), _rc_add(_rc_st, I, 2)):
                if _rc_st[0]:
                    break
                ua = _rc_getitem(_rc_st, U, _rc_sub(_rc_st, _rc_add(_rc_st, ii, _rc_getattr3(_rc_st, self)), ik))
                ub = _rc_getitem(_rc_st, U, _rc_sub(_rc_st, ii, 1))
                co1 = _rc_div(_rc_st, _rc_sub(_rc_st, ua, u), _rc_sub(_rc_st, ua, ub))
                co2 = _rc_div(_rc_st, _rc_sub(_rc_st, u, ub), _rc_sub(_rc_st, ua, ub))
                index = _rc_sub(_rc_st, _rc_sub(_rc_st, _rc_add(_rc_st, _rc_sub(_rc_st, ii, I), _rc_getattr3(_rc_st, self)), ik), 1)
                _rc_setitem(_rc_st, d, index, _rc_method5(_rc_st, _rc_getitem(_rc_st, d, index), (_rc_getitem(_rc_st, d, _rc_add(_rc_st, index, 1)), co1, co2)))
        return _rc_index(_rc_st, d, 0)
    else:
        dom = _rc_method0(_rc_st, self, ())
        if u < _rc_index(_rc_st, dom, 0) or u > _rc_index(_rc_st, dom, 1):
            _rc_fail(_rc_st)
            return _rc_index(_rc_st, _rc_getattr1(_rc_st, self), 0)
        if u == _rc_index(_rc_st, dom, 0):
            return _rc_index(_rc_st, _rc_getattr1(_rc_st, self), 0)
        if u == _rc_index(_rc_st, dom, 1):
            return _rc_index(_rc_st, _rc_getattr1(_rc_st, self), -1)
        I = _rc_method2(_rc_st, self, (u,))
        d = [_rc_getitem(_rc_st, _rc_getattr1(_rc_st, self), _rc_add(_rc_st, _rc_add(_rc_st, _rc_sub(_rc_st, I, _rc_getattr3(_rc_st, self)), 1), _rcv1_ii)) for _rcv1_ii in range(_rc_add(_rc_st, _rc_getattr3(_rc_st, self), 1))]
        U = _rc_getattr4(_rc_st, self)
        for ik in range(1, _rc_add(_rc_st, _rc_getattr3(_rc_st, self), 1)):
            if _rc_st[0]:
                break
            for ii in range(_rc_add(_rc_st, _rc_add(_rc_st, _rc_sub(_rc_st, I, _rc_getattr3(_rc_st, self)), ik), 1), _rc_add(_rc_st, I, 2)):
                if _rc_st[0]:
                    break
                ua = _rc_getitem(_rc_st, U, _rc_sub(_rc_st, _rc_add(_rc_st, ii, _rc_getattr3(_rc_st, self)), ik))
                ub = _rc_getitem(_rc_st, U, _rc_sub(_rc_st, ii, 1))
                co1 = _rc_div(_rc_st, _rc_sub(_rc_st, ua, u), _rc_sub(_rc_st, ua, ub))
                co2 = _rc_div(_rc_st, _rc_sub(_rc_st, u, ub), _rc_sub(_rc_st, ua, ub))
                index = _rc_sub(_rc_st, _rc_sub(_rc_st, _rc_add(_rc_st, _rc_sub(_rc_st, ii, I), _rc_getattr3(_rc_st, self)), ik), 1)
                _rc_setitem(_rc_st, d, index, _rc_method5(_rc_st, _rc_getitem(_rc_st, d, index), (_rc_getitem(_rc_st, d, _rc_add(_rc_st, index, 1)), co1, co2)))
        return _rc_index(_rc_st, d, 0)
