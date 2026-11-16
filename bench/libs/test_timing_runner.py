import pytest


class Fake:
    def __init__(self,name,events,digest='same',**extra):
        self.name,self.events=name,events
        self.ready=dict(status='ready',digest=digest,**extra)
    def request(self,command):
        self.events.append(self.name)
        return dict(status='ok',digest=self.ready['digest'],seconds=1.0)


def test_pairs_alternate_engine_order_and_reject_different_stock_output():
    from bench.libs.timing_runner import sample_group
    events=[]
    workers={name:Fake(name,events) for name in ['cpython','native','pypy']}
    rows=sample_group(workers)
    assert events==['cpython','native','pypy','pypy','native','cpython','cpython','native','pypy']
    assert len(rows)==3
    workers['native'].ready['digest']='wrong'
    with pytest.raises(AssertionError,match='stock'):sample_group(workers)


def test_sample_group_never_accepts_fallback_as_native_execution():
    from bench.libs.timing_runner import sample_group
    events=[]
    class Fallback(Fake):
        def request(self,command):return dict(status='not-exercised',digest='same',seconds=1.0)
    workers={'cpython':Fake('cpython',events),'native':Fallback('native',events)}
    with pytest.raises(RuntimeError,match='not-exercised'):sample_group(workers)


def test_worker_cleanup_does_not_mask_an_original_child_failure():
    from bench.libs.timing_runner import Resident
    class Pipe:
        def __init__(self,fail=False):self.closed=False;self.fail=fail
        def close(self):
            self.closed=True
            if self.fail:raise OSError(22,'Invalid argument')
    class Process:
        stdin=Pipe(fail=True)
        stdout=Pipe()
        def poll(self):return 3
    resident=object.__new__(Resident)
    resident.process=Process()
    resident.log=Pipe()
    resident.close()
    assert resident.process.stdout.closed and resident.log.closed
