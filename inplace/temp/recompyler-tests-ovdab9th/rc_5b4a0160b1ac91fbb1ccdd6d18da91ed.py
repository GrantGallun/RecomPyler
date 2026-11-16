def _rcv1_new_PythonInitializer(_rc_st, value):
    _rcf_value = value
    return _rc_make0(_rc_st, (_rcf_value,))

def _rcv2_python_initializer_factory(_rc_st, value):
    made = _rcv1_new_PythonInitializer(_rc_st, value)
    return _rc_getattr1(_rc_st, made)
