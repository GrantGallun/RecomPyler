"""Delivery policy: stale, cold and slower library functions stay in Python."""
import importlib
import pytest


def cache_api():
    try: return importlib.import_module('recompyler.libraries.cache')
    except ModuleNotFoundError: pytest.fail('library delivery cache is missing')


def target(x): return x + 1


def test_policy_requires_hot_verified_finite_speed_evidence(tmp_path):
    api = cache_api()
    cache = api.DecisionCache(tmp_path, compiler_tag='test-compiler', minimum_calls=100)
    assert cache.eligible(target) is False
    for calls, stock, native, verified in [(99,10,5,True),(100,10,11,True),(100,10,5,False)]:
        cache.record(target, calls=calls, cpython_ns=stock, native_ns=native, verified=verified)
        assert cache.eligible(target) is False
    cache.record(target, calls=100, cpython_ns=10, native_ns=10, verified=True)
    assert cache.eligible(target) is True
    for invalid in [0, -1, float('nan'), float('inf')]:
        with pytest.raises(ValueError):
            cache.record(target, calls=100, cpython_ns=invalid, native_ns=5, verified=True)


def test_policy_invalidates_on_code_source_and_compiler_changes(tmp_path):
    api = cache_api()
    source = tmp_path/'library.py'
    source.write_text('def f(x): return x + 1\n')
    scope = {}; exec(compile(source.read_text(),str(source),'exec'),scope)
    f = scope['f']
    cache = api.DecisionCache(tmp_path/'cache', compiler_tag='one')
    cache.record(f,calls=100,cpython_ns=10,native_ns=5,verified=True)
    assert cache.eligible(f)
    assert not api.DecisionCache(tmp_path/'cache',compiler_tag='two').eligible(f)
    source.write_text('# source changed\ndef f(x): return x + 1\n')
    assert not cache.eligible(f)
    source.write_text('def f(x): return x + 1\n')
    f.__code__ = f.__code__.replace(co_consts=(None,2))
    assert not cache.eligible(f)


def test_corrupt_decision_cache_falls_back_to_python(tmp_path):
    api = cache_api()
    cache = api.DecisionCache(tmp_path, compiler_tag='one')
    cache.record(target,calls=100,cpython_ns=10,native_ns=5,verified=True)
    next(tmp_path.glob('*.json')).write_text('{broken')
    assert cache.eligible(target) is False


def test_artifact_manifest_is_bound_to_the_verified_receipt(tmp_path):
    from recompyler.libraries.cache import DecisionCache
    cache=DecisionCache(tmp_path,compiler_tag='manifest-fixture')
    cache.record(target,calls=100,cpython_ns=10,native_ns=5,verified=True,
                 artifact_digest='a'*64,artifact_manifest_digest='b'*64)
    assert cache.receipt(target)['artifact_manifest_digest']=='b'*64
    with pytest.raises(ValueError):
        cache.record(target,calls=100,cpython_ns=10,native_ns=5,verified=True,
                     artifact_digest='a'*64,artifact_manifest_digest='invalid')
