"""The new text helper must preserve the package's Python3.10+ import contract."""
import ast,inspect,os,subprocess,sys,textwrap
from pathlib import Path
from types import SimpleNamespace
from recompyler import _text_owners


def owner_fixture():
    return 'constant owner'


def test_helper_import_without_pep669():
    source=str(Path(_text_owners.__file__).resolve())
    code="""import importlib.util,sys
saved=sys.monitoring;del sys.monitoring
try:
    spec=importlib.util.spec_from_file_location('recompyler.old_text_owner_probe',sys.argv[1])
    module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module
    spec.loader.exec_module(module)
    assert module.observers_clear(())
finally:sys.monitoring=saved
"""
    child=subprocess.run([sys.executable,'-c',code,source],capture_output=True,text=True,env=os.environ.copy(),timeout=30)
    assert child.returncode==0,(child.stdout,child.stderr)


def test_missing_instruction_positions_declines_cleanly(monkeypatch):
    node=ast.parse(textwrap.dedent(inspect.getsource(owner_fixture))).body[0]
    instruction=SimpleNamespace(opname='LOAD_CONST',argval='constant owner')
    monkeypatch.setattr(_text_owners.dis,'get_instructions',lambda fn:[instruction])
    certificate=_text_owners.analyze(owner_fixture,node)
    assert not certificate.valid and 'position' in certificate.reason
