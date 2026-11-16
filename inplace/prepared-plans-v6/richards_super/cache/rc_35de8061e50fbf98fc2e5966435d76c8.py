def _rcv1_isTaskHoldingOrWaiting(_rc_st, self):
    return _rc_getattr0(_rc_st, self) or (not _rc_getattr1(_rc_st, self) and _rc_getattr2(_rc_st, self))

def _rcv2_waitTask(_rc_st, self):
    _rc_setattr7(_rc_st, self, True)
    return self

def _rcv3_release(_rc_st, self, i):
    t = _rc_method9(_rc_st, self, (i,))
    _rc_setattr10(_rc_st, t, False)
    if _rc_getattr11(_rc_st, t) > _rc_getattr11(_rc_st, self):
        return t
    else:
        return self

def _rcv4_packetPending(_rc_st, self):
    _rc_setattr15(_rc_st, self, True)
    _rc_setattr7(_rc_st, self, False)
    _rc_setattr10(_rc_st, self, False)
    return self

def _rcv5_waiting(_rc_st, self):
    _rc_setattr15(_rc_st, self, False)
    _rc_setattr7(_rc_st, self, True)
    _rc_setattr10(_rc_st, self, False)
    return self

def _rcv6_running(_rc_st, self):
    _rc_setattr15(_rc_st, self, False)
    _rc_setattr7(_rc_st, self, False)
    _rc_setattr10(_rc_st, self, False)
    return self

def _rcv7_waitingWithPacket(_rc_st, self):
    _rc_setattr15(_rc_st, self, True)
    _rc_setattr7(_rc_st, self, True)
    _rc_setattr10(_rc_st, self, False)
    return self

def _rcv8_isPacketPending(_rc_st, self):
    return _rc_getattr1(_rc_st, self)

def _rcv9_isTaskWaiting(_rc_st, self):
    return _rc_getattr2(_rc_st, self)

def _rcv10_isTaskHolding(_rc_st, self):
    return _rc_getattr0(_rc_st, self)

def _rcv11_isWaitingWithPacket(_rc_st, self):
    return _rc_getattr1(_rc_st, self) and _rc_getattr2(_rc_st, self) and (not _rc_getattr0(_rc_st, self))
