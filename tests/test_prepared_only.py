"""Load-only prepared regions never infer or compile on a cache miss."""
from types import SimpleNamespace
from unittest.mock import Mock
import pytest


def source(values):
    values.append('source')
    return values


@pytest.mark.parametrize('failure',['missing','empty','broken','guard','signature'])
def test_prepared_only_misses_fall_back_without_compilation(monkeypatch,failure):
    from recompyler import heap
    good=SimpleNamespace(broken=False,guards_hold=lambda:True)
    records=[] if failure=='empty' else [good]
    if failure=='broken':good.broken=True
    if failure=='guard':good.guards_hold=lambda:False
    index=None if failure=='missing' else SimpleNamespace(iter_bind=lambda fn:iter(records),reasons=[])
    region=heap.lift_region(source,prepared=index,prepared_only=True)
    inference=Mock(side_effect=AssertionError('inference on load-only miss'))
    monkeypatch.setattr(region,'_make_program',inference)
    def load(program,args):
        if failure=='signature':raise heap._Mismatch
        raise AssertionError('invalid record reached loading')
    monkeypatch.setattr(region,'load',load)
    values=[]
    assert region(values) is values and values==['source']
    assert region.fallback_calls==1 and region.compiled_calls==0
    inference.assert_not_called()


def test_prepared_only_requires_literal_bool():
    from recompyler import heap
    with pytest.raises(TypeError,match='prepared_only'):
        heap.lift_region(source,prepared_only=1)


def test_explicit_prepared_only_miss_does_not_infer(monkeypatch):
    from recompyler import heap
    index=SimpleNamespace(iter_bind=lambda fn:iter(()),reasons=[])
    region=heap.lift_region(source,prepared=index,prepared_only=True)
    inference=Mock(side_effect=AssertionError('inference on prepared miss'))
    monkeypatch.setattr(region,'_make_program',inference)
    values=[]
    assert region(values) is values and values==['source']
    assert region.fallback_calls==1 and region.compiled_calls==0
    inference.assert_not_called()


def test_jit_misses_require_explicit_opt_in(monkeypatch):
    from recompyler import heap
    index=SimpleNamespace(iter_bind=lambda fn:iter(()),reasons=[])
    region=heap.lift_region(source,prepared=index,prepared_only=False)
    inference=Mock(side_effect=heap.Unsupported('unsupported test signature'))
    monkeypatch.setattr(region,'_make_program',inference)
    values=[]
    assert region(values) is values and values==['source']
    inference.assert_called_once_with()


def test_prepared_only_cannot_be_ignored_by_managed_backend(monkeypatch):
    from recompyler import heap
    delegate=Mock()
    monkeypatch.setattr(heap,'lift_calls',delegate)
    with pytest.raises(ValueError,match='prepared_only'):
        heap.lift_region(source,backend='managed',prepared_only=True)
    delegate.assert_not_called()
