"""Minimal fail-first contract; preparation only, not executed by its author."""
import importlib.util


def test_prepared_cache_api_exists_before_implementation():
    assert importlib.util.find_spec('recompyler._prepared') is not None, (
        'S31 requires a persistent prepared-program mechanism; inference seeds '
        'and regenerated source digests do not implement it')
    from recompyler import _prepared
    assert _prepared.SCHEMA == 1
    for name in ('compiler_key', 'runtime_key', 'plan_key', 'capture', 'bundle',
                 'open_index', 'literal_key', 'validate_core', 'PreparedIndex', 'PreparedMiss'):
        assert hasattr(_prepared, name), name
