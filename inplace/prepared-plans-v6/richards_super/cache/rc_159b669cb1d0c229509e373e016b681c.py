def _rcv1_isWaitingWithPacket(_rc_st, self):
    return _rc_getattr0(_rc_st, self) and _rc_getattr1(_rc_st, self) and (not _rc_getattr2(_rc_st, self))
