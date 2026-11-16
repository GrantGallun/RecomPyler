"""Load-only delivery requires an artifact even for an already measured owner."""
import types
import pytest


@pytest.mark.parametrize('measured', [False, True])
def test_artifactless_frameless_measurement_requires_offline_artifact(tmp_path, measured):
    from recompyler.ir import compile_function, compilation_info, _entry_native
    from recompyler.ir.compiler import _record_measurement, _frameless_candidates
    from recompyler.libraries.cache import DecisionCache
    from recompyler.libraries.hook import LibrarySession

    module = types.ModuleType('fixture_frameless_delivery')
    exec('def identity(value): return value', module.__dict__)
    function = module.identity
    cache = DecisionCache(tmp_path / 'cache', compiler_tag='test-fixture')
    # Policy fixtures, not performance evidence. Persistent times alone cannot
    # authorize a newly compiled body.
    cache.record(function, calls=100, cpython_ns=10, native_ns=5, verified=True)
    compile_function(function, strict=True)
    candidate = _frameless_candidates[function]
    assert not candidate.active
    if measured:
        _record_measurement(function, 10, 5)
    session = LibrarySession(packages=(module.__name__,), cache=cache, profile=False)
    marker = object()
    try:
        session.process_module(module)
        assert not candidate.active
        assert not compilation_info(function)['installed']
        assert session.report['installed'] == 0
        assert session.handles == []
        assert 'prepare offline' in session.report['declined'][0]['reason']
        assert function(marker) is marker
        assert session.report['declined']
        session.process_module(module)
        assert session.report['installed'] == 0
    finally:
        session.close()
        restored = not candidate.active
        candidate.close()
        _entry_native.forget_compilation(function)
    assert restored, 'session.close left the measured frameless entry installed'
    assert function(marker) is marker
