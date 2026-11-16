"""Opt-in script delivery and AOT native artifact cache CLI."""
import json
import os
from pathlib import Path
import subprocess
import sys


def cli(*arguments,extra_path=None):
    env=dict(os.environ)
    paths=[str(Path.cwd()/'src'),str(Path.cwd())]
    if extra_path: paths.append(str(extra_path))
    env['PYTHONPATH']=os.pathsep.join(paths)
    return subprocess.run([sys.executable,'-m','recompyler',*map(str,arguments)],env=env,capture_output=True,text=True,timeout=60)


def test_run_without_plan_preserves_script_imports_arguments_and_exit(tmp_path):
    (tmp_path/'fixture_run_helper.py').write_text('value=42\n')
    app=tmp_path/'app.py'
    app.write_text('import sys,fixture_run_helper\nprint(__name__,fixture_run_helper.value,sys.argv[1:])\nraise SystemExit(7)\n')
    report=tmp_path/'run.json'
    result=cli('run','--cache-dir',tmp_path/'cache','--library-package','fixture_run_helper','--json',report,app,'hello')
    assert result.returncode==7,result.stderr
    assert result.stdout=="__main__ 42 ['hello']\n"
    assert json.loads(report.read_text())['installed']==0


def test_compile_package_fills_relocatable_cache_without_calling_functions(tmp_path):
    (tmp_path/'fixture_aot_lib.py').write_text('events=[]\ndef walk(value):\n while value.parent is not None: value=value.parent\n return value\ndef dangerous():\n events.append("called")\n raise AssertionError("AOT invoked target")\n')
    report=tmp_path/'compile.json'
    result=cli('compile','--cache-dir',tmp_path/'cache','--json',report,'fixture_aot_lib',extra_path=tmp_path)
    assert result.returncode==0,result.stderr
    row=json.loads(report.read_text())
    assert row['prepared']>=1 and row['portable']>=1
    assert row['installed']==0
    assert list((tmp_path/'cache').rglob('*.o'))


def test_run_report_cannot_overwrite_application_source(tmp_path):
    app=tmp_path/'app.py';source='print("must not run")\n';app.write_text(source)
    result=cli('run','--json',app,app)
    assert result.returncode==2
    assert app.read_text()==source and result.stdout==''


def test_run_preserves_system_exit_message(tmp_path):
    app=tmp_path/'message.py';app.write_text('raise SystemExit("literal exit message")\n')
    result=cli('run','--cache-dir',tmp_path/'cache',app)
    assert result.returncode==1
    assert result.stderr=='literal exit message\n'


def test_compile_report_cannot_overwrite_package_source(tmp_path):
    source=tmp_path/'fixture_report_lib.py';text='def f(): return 1\n';source.write_text(text)
    result=cli('compile','--cache-dir',tmp_path/'cache','--json',source,'fixture_report_lib',extra_path=tmp_path)
    assert result.returncode==2
    assert source.read_text()==text


def test_run_preserves_noninteger_zero_exit_status(tmp_path):
    app=tmp_path/'zero.py';app.write_text('raise SystemExit(0.0)\n')
    result=cli('run','--cache-dir',tmp_path/'cache',app)
    assert result.returncode==1
    assert result.stderr=='0.0\n'


def test_runner_preserves_a_callers_existing_library_session(tmp_path):
    from recompyler.libraries.hook import enable,disable
    from recompyler.libraries.cache import DecisionCache
    from recompyler.libraries.cli import run_script
    app=tmp_path/'app.py';app.write_text('value=42\n')
    session=enable(packages=('fixture_existing_session',),cache=DecisionCache(tmp_path/'cache',compiler_tag='existing'))
    try:
        assert run_script(app)['exit_code'] is None
        assert not session.closed
        assert session.finder in sys.meta_path
    finally: disable()


def test_cli_shutdown_callbacks_keep_application_main_and_arguments(tmp_path):
    app=tmp_path/'shutdown.py'
    app.write_text('import atexit,sys\nvalue=42\ndef goodbye():\n import __main__\n print(__main__.value,sys.argv[1:])\natexit.register(goodbye)\n')
    result=cli('run','--cache-dir',tmp_path/'cache','--library-package','fixture_atexit_lib',app,'hello')
    assert result.returncode==0,result.stderr
    assert result.stdout=="42 ['hello']\n" and result.stderr==''


def test_aot_report_cannot_overwrite_an_imported_package_submodule(tmp_path):
    package=tmp_path/'fixture_subreport_lib';package.mkdir()
    (package/'__init__.py').write_text('from . import helper\n')
    helper=package/'helper.py';source='def f(): return 1\n';helper.write_text(source)
    result=cli('compile','--cache-dir',tmp_path/'cache','--json',helper,'fixture_subreport_lib',extra_path=tmp_path)
    assert result.returncode==2
    assert helper.read_text()==source


def test_opt_in_cli_starts_with_the_canonical_entry_backend_enabled(tmp_path,monkeypatch):
    app=tmp_path/'entry_enabled.py'
    app.write_text('import sys\nprint(sys._jit.is_enabled())\n')
    monkeypatch.setenv('PYTHON_JIT','0')
    result=cli('run','--cache-dir',tmp_path/'cache','--library-package','fixture_cli_entry',app)
    assert result.returncode==0,result.stderr
    assert result.stdout=='True\n'
