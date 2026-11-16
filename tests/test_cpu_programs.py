import sys
import pytest


def test_cpu_and_library_groups_preserve_separate_heldout():
    from bench.libs.programs import manifest
    cpu=manifest('cpu');libraries=manifest('libraries')
    assert set(cpu)=={'nbody','spectral_norm','richards','raytrace','chaos','deltablue','go','float','fannkuch','nqueens','poker','scimark'}
    assert len(libraries)==15 and 'selfcompile' not in libraries
    assert set(manifest('heldout'))=={'held_csv','held_decimal','held_graph'}
    assert cpu['nbody'].prepare is not manifest('train')['nbody'].prepare
    assert cpu['poker'].repeats==1


def test_fixture_loader_reads_source_without_external_bytecode_writes(tmp_path):
    from bench.libs.cpu_programs import load_fixture
    folder=tmp_path/'bm_nbody';folder.mkdir()
    source=folder/'run_benchmark.py';source.write_text('import pyperf\ndef marker(): return 42\n')
    previous=sys.dont_write_bytecode
    module=load_fixture('nbody',corpus=tmp_path)
    try:
        assert module.marker()==42 and module._fixture_sha256
        assert not (folder/'__pycache__').exists()
        assert sys.dont_write_bytecode is previous
    finally:sys.modules.pop(module.__name__,None)


def test_missing_fixture_is_unavailable_without_installation(tmp_path):
    from bench.libs.cpu_programs import load_fixture
    with pytest.raises(ModuleNotFoundError,match='local CPU fixture'):load_fixture('nbody',corpus=tmp_path)

def test_long_cpu_preset_is_fixed_and_preserves_legacy():
    from bench.libs.programs import manifest
    legacy=manifest('cpu');long=manifest('cpu_long')
    assert set(legacy)==set(long)
    assert all(long[name].repeats>legacy[name].repeats for name in long)
    assert manifest('train')['nbody'].repeats==64
    assert legacy['nbody'].repeats==64 and long['nbody'].repeats==4096
