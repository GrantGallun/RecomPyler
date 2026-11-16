"""Runner wrapper trust: real generated adapters, without a native build."""
import json
from pathlib import Path
from types import SimpleNamespace
import pytest

@pytest.fixture
def wrapper(tmp_path, monkeypatch):
    from recompyler import runner, heap
    script = tmp_path / 'runner_fixture.py'
    script.write_text('def helper(x):\n    return x + 1\n\ndef work(x):\n    return helper(x)\n\nassert work(10) == 11\n')
    plan = tmp_path / 'plan.json'
    plan.write_text(json.dumps({'script': str(script), 'functions': [
        {'function': name, 'line': line, 'candidate': {'status': 'verified', 'recommended': True, 'engine': 'region'}}
        for name, line in [('helper', 1), ('work', 4)]], 'plan': {'worth_running': True}}))
    seen = []
    def lift(fn, *args, **kwargs):
        seen.append(fn)
        return None
    monkeypatch.setattr(heap, 'lift_region', lift)
    runner.run_script(script, [], plan, force=True)
    work = next(fn for fn in seen if fn.__name__ == 'work')
    return work.__globals__['work'], work


def test_actual_runner_wrapper_is_registered(wrapper):
    from recompyler import _runner_wrapper as rw
    fast, fn = wrapper
    assert rw.original(fn) is fn
    assert rw.original(fast) is fn
    assert rw.guard(fast)


@pytest.mark.parametrize('mutation', ['marker', 'wrapped', 'code', 'fn-cell', 'prepare-code', 'state-cell', 'lifted'])
def test_wrapper_mutation_breaks_equivalence_before_reuse(wrapper, mutation):
    from recompyler import _runner_wrapper as rw
    fast, fn = wrapper
    cells = dict(zip(fast.__code__.co_freevars, fast.__closure__))
    if mutation == 'marker': fast.__recompyler_original__ = lambda: None
    elif mutation == 'wrapped': fast.__wrapped__ = lambda: None
    elif mutation == 'code': fast.__code__ = fast.__code__.replace(co_consts=fast.__code__.co_consts + ('changed',))
    elif mutation == 'fn-cell': cells['fn'].cell_contents = lambda *args: 999
    elif mutation == 'prepare-code':
        prep = cells['prepare'].cell_contents
        prep.__code__ = prep.__code__.replace(co_consts=prep.__code__.co_consts + ('changed',))
    elif mutation == 'state-cell': cells['state'].cell_contents = dict(cells['state'].cell_contents)
    elif mutation == 'lifted': cells['state'].cell_contents['lifted'] = lambda *args: 999
    assert not rw.guard(fast)
    assert rw.original(fast) is None


def test_forged_marker_does_not_make_a_trusted_wrapper():
    from recompyler import _runner_wrapper as rw
    def fn(x): return x
    def forged(x): return x + 99
    forged.__recompyler_original__ = fn
    forged.__wrapped__ = fn
    assert rw.original(forged) is None
    assert not rw.guard(forged)


def test_attached_lifted_original_mutation_invalidates_wrapper(wrapper):
    from recompyler import _runner_wrapper as rw, heap
    fast, fn = wrapper
    state = dict(zip(fast.__code__.co_freevars, fast.__closure__))['state'].cell_contents
    state['lifted'] = heap.Region(fn)
    assert rw.record_lifted(fast)
    assert rw.guard(fast)
    state['lifted'].original = lambda *args: 999
    assert not rw.guard(fast)
