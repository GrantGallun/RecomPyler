"""Classify slow integration work without importing test modules twice."""
import importlib.util
import os
from pathlib import Path
import pytest

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('_test_cycle',ROOT/'tools'/'affected_tests.py')
cycle=importlib.util.module_from_spec(spec)
spec.loader.exec_module(cycle)
for name in ("RECOMPYLER_CACHE","NUMBA_CACHE_DIR"):
    os.environ.setdefault(name,cycle.cache_environment(ROOT)[name])


def is_slow_test(path,name):
    path=Path(path)
    return (path.stem in {'test_aot','test_cli','test_pycc_platform','test_region_reuse'}
            or bool(cycle.SLOW_NAME.search(name))
            or name in cycle.slow_test_names(path.read_text(encoding='utf-8-sig')))


def pytest_collection_modifyitems(items):
    classified={}
    for item in items:
        path=Path(str(item.path))
        if path not in classified:
            classified[path]=cycle.slow_test_names(path.read_text(encoding='utf-8-sig'))
        name=getattr(item,'originalname',None) or item.name.split('[')[0]
        if path.stem in {'test_aot','test_cli','test_pycc_platform','test_region_reuse'} or name in classified[path]:
            item.add_marker(pytest.mark.slow)
