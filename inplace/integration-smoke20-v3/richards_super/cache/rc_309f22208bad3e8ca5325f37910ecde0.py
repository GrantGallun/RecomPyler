def _rcv1_fn(_rc_st, self, pkt, r):
    _rc_setattr0(_rc_st, self, pkt)

def _rcv2_waitTask(_rc_st, self):
    _rc_setattr5(_rc_st, self, True)
    return self

def _rcv3_release(_rc_st, self, i):
    t = _rc_method7(_rc_st, self, (i,))
    _rc_setattr8(_rc_st, t, False)
    if _rc_getattr9(_rc_st, t) > _rc_getattr9(_rc_st, self):
        return t
    else:
        return self

def _rcv4_packetPending(_rc_st, self):
    _rc_setattr13(_rc_st, self, True)
    _rc_setattr5(_rc_st, self, False)
    _rc_setattr8(_rc_st, self, False)
    return self

def _rcv5_waiting(_rc_st, self):
    _rc_setattr13(_rc_st, self, False)
    _rc_setattr5(_rc_st, self, True)
    _rc_setattr8(_rc_st, self, False)
    return self

def _rcv6_running(_rc_st, self):
    _rc_setattr13(_rc_st, self, False)
    _rc_setattr5(_rc_st, self, False)
    _rc_setattr8(_rc_st, self, False)
    return self

def _rcv7_waitingWithPacket(_rc_st, self):
    _rc_setattr13(_rc_st, self, True)
    _rc_setattr5(_rc_st, self, True)
    _rc_setattr8(_rc_st, self, False)
    return self

def _rcv8_isPacketPending(_rc_st, self):
    return _rc_getattr14(_rc_st, self)

def _rcv9_isTaskWaiting(_rc_st, self):
    return _rc_getattr15(_rc_st, self)

def _rcv10_isTaskHolding(_rc_st, self):
    return _rc_getattr16(_rc_st, self)

def _rcv11_isTaskHoldingOrWaiting(_rc_st, self):
    return _rc_getattr16(_rc_st, self) or (not _rc_getattr14(_rc_st, self) and _rc_getattr15(_rc_st, self))

def _rcv12_isWaitingWithPacket(_rc_st, self):
    return _rc_getattr14(_rc_st, self) and _rc_getattr15(_rc_st, self) and (not _rc_getattr16(_rc_st, self))
