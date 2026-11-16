def _rcv1_particle(_rc_st, position, velocity, dt):
    if True:
        for _ in range(128):
            if _rc_st[0]:
                break
            velocity = _rc_nadd(_rc_st, velocity, _rc_mul(_rc_st, _rc_sub(_rc_st, -9.81, _rc_mul(_rc_st, 0.04, velocity)), dt))
            position = _rc_nadd(_rc_st, position, _rc_mul(_rc_st, velocity, dt))
            if position < 0.0:
                position = _rc_neg(_rc_st, position)
                velocity = _rc_nmul(_rc_st, velocity, -0.7)
        return position
    else:
        for _ in range(128):
            if _rc_st[0]:
                break
            velocity = _rc_nadd(_rc_st, velocity, _rc_mul(_rc_st, _rc_sub(_rc_st, -9.81, _rc_mul(_rc_st, 0.04, velocity)), dt))
            position = _rc_nadd(_rc_st, position, _rc_mul(_rc_st, velocity, dt))
            if position < 0.0:
                position = _rc_neg(_rc_st, position)
                velocity = _rc_nmul(_rc_st, velocity, -0.7)
        return position
