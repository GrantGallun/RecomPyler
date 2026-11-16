"""The matrix observer must detect defects before it can certify coverage."""
from pathlib import Path
import sys
import types
import pytest
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(R/'matrix'));sys.path.insert(0,str(R/'src'))
import run_matrix as matrix
from catalogue import Case

def test_oracle_preserves_result_argument_aliasing():
    state=types.SimpleNamespace(EVENTS=[],COUNTER=0)
    a=matrix.outcome(lambda x:x,([1,2],),state)
    b=matrix.outcome(lambda x:list(x),([1,2],),state)
    assert a!=b

def test_oracle_checks_state_and_exception_context():
    state=types.SimpleNamespace(EVENTS=[],COUNTER=0)
    def a(x):state.EVENTS.append(1);return x
    assert matrix.outcome(a,(3,),state)!=matrix.outcome(lambda x:x,(3,),state)
    def implicit(x):
        try:raise TypeError('inner')
        except TypeError:raise ValueError('outer')
    def suppressed(x):
        try:raise TypeError('inner')
        except TypeError:raise ValueError('outer') from None
    assert matrix.outcome(implicit,(3,),state)!=matrix.outcome(suppressed,(3,),state)

def test_oracle_refuses_unknown_opaque_result():
    with pytest.raises(TypeError,match='stable projection'):matrix.freeze(object())

@pytest.mark.parametrize('native,verdict',[(True,'wrong'),(False,'crash')])
def test_wrong_wrapper_cannot_become_a_decline(monkeypatch,native,verdict):
    class Wrapper:
        compiled_calls=0
        def __call__(self,*a,**k):
            if native:self.compiled_calls+=1
            return 999
    monkeypatch.setattr(matrix.profiler,'test_candidate',lambda *a,**k:dict(status='verified',_lifted=Wrapper()))
    row=matrix.run_case(Case('harness.wrong','harness','return x+1'))
    assert row['verdict']==verdict,row

def test_swallowed_lifter_compilation_error_is_visible(monkeypatch):
    module=__import__('recompyler.lift',fromlist=['Lifted'])
    from numba.core.errors import TypingError
    def broken(self,*a,**k):raise TypingError('matrix injected backend error')
    monkeypatch.setattr(module.Lifted,'_run',broken)
    row=matrix.run_case(Case('harness.swallowed','harness','return x+1'))
    assert row['verdict']=='crash' and row.get('internal_errors'),row
    assert 'matrix injected' in row['reason']

def test_generator_draining_uses_native_adapter():
    class Region:
        compiled_calls=0
        def original(self,x):yield x
        def values(self,args):self.compiled_calls+=1;return [args[0]]
    region=Region();got=matrix.native_callable(region)(3)
    assert matrix.freeze(got)==matrix.freeze(matrix.Yielded([3],True,False,None))
    assert region.compiled_calls==1


def test_failure_collector_preserves_active_observers():
    original=sys.gettrace()
    with matrix.observe_failures():
        assert sys.gettrace() is original
    assert sys.gettrace() is original


def test_unobserved_scalar_unicode_predicate_is_native():
    case=next(c for c in matrix.cases() if c.id=='method.str.isupper')
    row=matrix.run_case(case)
    assert row['verdict']=='native',row


def test_swallowed_verifier_exception_outcome_is_a_crash(monkeypatch):
    monkeypatch.setattr(matrix.profiler,'test_lifted',lambda *a,**k:dict(status='rejected',reason='a captured call raised TypeError when replayed'))
    row=matrix.run_case(Case('harness.verifier_none','harness','return None'))
    assert row['verdict']=='crash' and row.get('internal_errors'),row
    assert any(x['phase']=='verification:test_lifted' and x['type']=='TypeError' for x in row['internal_errors'])
    assert not row.get('harness_error'),row


def test_failure_collector_restores_exact_callables_after_error():
    module=__import__('recompyler.lift',fromlist=['Lifted'])
    saved=(module.Lifted._run,matrix.profiler.test_lifted,matrix.profiler._test_region)
    with pytest.raises(ValueError,match='context exit'):
        with matrix.observe_failures():raise ValueError('context exit')
    assert saved==(module.Lifted._run,matrix.profiler.test_lifted,matrix.profiler._test_region)


def test_named_unsupported_remains_a_decline(monkeypatch):
    module=__import__('recompyler.lift',fromlist=['Lifted'])
    def unsupported(self,*a,**k):raise matrix.Unsupported('named injected unsupported')
    monkeypatch.setattr(module.Lifted,'_run',unsupported)
    row=matrix.run_case(Case('harness.named_decline','harness','return x+1'))
    assert row['verdict'] in ('native','declined') and not row.get('internal_errors'),row
    with matrix.observe_failures() as failures:
        with pytest.raises(matrix.Unsupported):module.Lifted._run(types.SimpleNamespace(compiled_calls=0),())
    assert not failures


def test_past_native_success_cannot_hide_warm_failure(monkeypatch):
    module=__import__('recompyler.lift',fromlist=['Lifted'])
    from numba.core.errors import TypingError
    def broken(self,*a,**k):raise TypingError('warm compilation failure')
    monkeypatch.setattr(module.Lifted,'_run',broken)
    owner=types.SimpleNamespace(compiled_calls=1)
    with matrix.observe_failures() as failures:
        with pytest.raises(TypingError):module.Lifted._run(owner,())
    assert failures
    assert matrix.unresolved_failures(failures),failures


def test_float_oracle_preserves_nan_payload_and_zero_sign():
    import struct
    first=struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0]
    second=struct.unpack('!d',bytes.fromhex('7ff8000000005678'))[0]
    assert matrix.freeze(first)!=matrix.freeze(second)
    assert matrix.freeze(-0.0)!=matrix.freeze(0.0)
