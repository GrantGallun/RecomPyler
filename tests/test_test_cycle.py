"""The development cycle must select relevant checks without losing slow tests."""
from pathlib import Path
import runpy

ROOT=Path(__file__).resolve().parents[1]


def test_affected_tests_includes_changed_tests_and_module_importers(tmp_path):
    api=runpy.run_path(str(ROOT/'tools/affected_tests.py'))
    (tmp_path/'tests').mkdir()
    (tmp_path/'tests/test_direct.py').write_text('from recompyler.ir.lower_llvm import lower\n')
    (tmp_path/'tests/test_other.py').write_text('from recompyler import scalar\n')
    (tmp_path/'tests/test_changed.py').write_text('def test_new():pass\n')
    actual=api['affected_tests'](['src/recompyler/ir/lower_llvm.py','tests/test_changed.py'],root=tmp_path)
    assert actual==['tests/test_changed.py','tests/test_direct.py']


def test_native_module_changes_include_corresponding_wrapper_importers(tmp_path):
    api=runpy.run_path(str(ROOT/'tools/affected_tests.py'))
    (tmp_path/'tests').mkdir()
    (tmp_path/'tests/test_boundary.py').write_text('from recompyler import _source_frames\n')
    actual=api['affected_tests'](['src/recompyler/_source_frames_native.c'],root=tmp_path)
    assert actual==['tests/test_boundary.py']


def test_slow_classification_keeps_python_units_and_flags_process_builds(tmp_path):
    api=runpy.run_path(str(ROOT/'tests/conftest.py'))
    path=tmp_path/'test_examples.py'
    path.write_text('import subprocess\ndef child():\n return subprocess.run(["python"])\ndef test_process():\n child()\ndef test_unit():\n return 1\n')
    classify=api['is_slow_test']
    assert classify(path,'test_process')
    assert not classify(path,'test_unit')
    assert classify(path,'test_runs_without_numba')
