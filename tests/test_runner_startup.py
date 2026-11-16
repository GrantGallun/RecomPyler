"""Unselected runs use original source without loading unused rewrite machinery."""
import json
import os
from pathlib import Path
import subprocess
import sys
import traceback

import pytest

from recompyler import runner


def child_env():
    return dict(os.environ, PYTHONPATH=str(Path(__file__).resolve().parents[1] / "src"),
                PYTHONIOENCODING="utf-8")


@pytest.mark.parametrize("cli", [False, True], ids=["runner", "cli"])
def test_plain_run_does_not_import_rewrite_or_native_modules(tmp_path, cli):
    script = tmp_path / "work.py"
    script.write_text("import sys\nprint('plain', sys.argv[1])\n", encoding="utf-8")
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps({"functions": []}), encoding="utf-8")
    code = '''import json, sys
from pathlib import Path
blocked = {'ast', 'tokenize', 'recompyler.batch', 'recompyler.heap', 'numba', 'recompyler._origin', 'hashlib'}
class UnusedImport:
    def find_spec(self, fullname, path=None, target=None):
        if fullname in blocked:
            raise AssertionError('unused runner import: ' + fullname)
sys.meta_path.insert(0, UnusedImport())
if sys.argv[3] == 'True':
    from recompyler.__main__ import main
    assert main(['run', '--plan', sys.argv[2], sys.argv[1], 'forwarded']) == 0
else:
    from recompyler import runner
    report = runner.run_script(Path(sys.argv[1]), ['forwarded'], Path(sys.argv[2]))
    assert report['functions'] == report['not_found'] == []
    assert report['batches'] == report['batch_failures'] == {}
    assert report['exit_code'] is None
assert not blocked.intersection(sys.modules)
'''
    result = subprocess.run([sys.executable, "-c", code, str(script), str(plan), str(cli)],
                            env=child_env(), capture_output=True, text=True, timeout=30)
    assert result.returncode == 0, result.stderr
    assert result.stdout == "plain forwarded\n"


@pytest.mark.parametrize("selected", [False, True], ids=["plain", "selected"])
def test_runner_reads_one_plan_snapshot(tmp_path, monkeypatch, capsys, selected):
    script = tmp_path / "work.py"
    script.write_text("def step(value):\n    return value + 1\n"
                      "print(hasattr(step, '__recompyler_original__'))\n", encoding="utf-8")
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps({
        "plan": {"worth_running": selected},
        "functions": [{"function": "step", "line": 1,
                       "candidate": {"status": "verified", "recommended": True}}],
    }), encoding="utf-8")
    original = Path.read_text
    reads = []

    def read(path, *args, **kwargs):
        if path == plan:
            reads.append(path)
        return original(path, *args, **kwargs)

    monkeypatch.setattr(Path, "read_text", read)
    report = runner.run_script(script, [], plan)
    assert capsys.readouterr().out == f"{selected}\n"
    assert len(report["functions"]) == int(selected)
    assert len(reads) == 1


def test_plan_snapshot_stays_consistent_and_next_run_sees_replacement(tmp_path, monkeypatch, capsys):
    script = tmp_path / "work.py"
    script.write_text("def step(value):\n    return value + 1\n"
                      "print(hasattr(step, '__recompyler_original__'))\n", encoding="utf-8")
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps({
        "plan": {"worth_running": True},
        "functions": [{"function": "step", "line": 1,
                       "candidate": {"status": "verified", "recommended": True, "engine": "region"}}],
    }), encoding="utf-8")
    original = Path.read_text

    def replace_after_read(path, *args, **kwargs):
        text = original(path, *args, **kwargs)
        if path == plan:
            path.write_text('{"functions": []}', encoding="utf-8")
        return text

    monkeypatch.setattr(Path, "read_text", replace_after_read)
    first = runner.run_script(script, [], plan)
    assert first["functions"][0]["region"] is True
    second = runner.run_script(script, [], plan)
    assert second["functions"] == []
    assert capsys.readouterr().out == "True\nFalse\n"


@pytest.mark.parametrize("data,force,picks,regions", [
    ({}, False, set(), set()),
    ({"functions": [{"function": "first", "line": 1,
                     "candidate": {"status": "verified", "recommended": True, "engine": "region"}}]},
     False, set(), {("first", 1)}),
    ({"functions": [{"function": "first", "line": 1,
                     "candidate": {"status": "verified", "recommended": True, "engine": "region"}}]},
     True, {("first", 1)}, {("first", 1)}),
    ({"plan": {"worth_running": True}, "functions": [
        {"function": "first", "line": 1,
         "candidate": {"status": "verified", "recommended": True, "engine": "region"}},
        {"function": "second", "line": 8,
         "candidate": {"status": "verified", "recommended": False}},
        {"function": "third", "line": 12,
         "candidate": {"status": "rejected", "recommended": True}}]},
     False, {("first", 1)}, {("first", 1)}),
    ({"plan": {"worth_running": True}, "functions": [], "hotspots": [
        {"function": "legacy", "line": 3, "status": "verified", "recommended": True,
         "engine": "region"}]}, False, {("legacy", 3)}, set()),
])
def test_public_plan_selection_apis_keep_path_and_force_behavior(tmp_path, data, force, picks, regions):
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps(data), encoding="utf-8")
    assert runner.recommended(plan, force=force) == picks
    assert runner.regional(plan) == regions


@pytest.mark.parametrize("source", [
    b"# coding: latin-1\nprint('caf\xe9')\n",
    b"\xef\xbb\xbfprint('snowman \xe2\x98\x83')\n",
    b"value = 4\r\nprint(value + 3)\r\n",
    b"value = 4\rprint(value + 3)\r",
])
def test_plain_source_encoding_and_newlines_match_direct_python(tmp_path, source):
    script = tmp_path / "work.py"
    script.write_bytes(source)
    plan = tmp_path / "plan.json"
    plan.write_text('{"functions": []}', encoding="utf-8")
    direct = subprocess.run([sys.executable, str(script)], env=child_env(), capture_output=True,
                            text=True, timeout=30)
    via_runner = subprocess.run([sys.executable, "-m", "recompyler", "run", "--plan", str(plan),
                                 str(script)], env=child_env(), capture_output=True, text=True, timeout=30)
    assert via_runner.returncode == direct.returncode == 0, (direct.stderr, via_runner.stderr)
    assert via_runner.stdout == direct.stdout


@pytest.mark.parametrize("source", [
    b"# coding: latin-1\nif True print('caf\xe9')\n",
    b"# coding: utf-8\nprint('\xff')\n",
    b"# coding: unknown_encoding\nprint(1)\n",
])
def test_plain_syntax_errors_follow_direct_byte_compilation(tmp_path, source):
    script = tmp_path / "work.py"
    script.write_bytes(source)
    plan = tmp_path / "plan.json"
    plan.write_text('{"functions": []}', encoding="utf-8")
    with pytest.raises(SyntaxError) as direct:
        compile(source, str(script), "exec")
    with pytest.raises(SyntaxError) as actual:
        runner.run_script(script, [], plan)
    assert (actual.value.filename, actual.value.lineno, actual.value.offset) == (
        str(script), direct.value.lineno, direct.value.offset)
    assert actual.value.text == direct.value.text


def test_plain_runtime_traceback_keeps_source_filename_and_line(tmp_path):
    script = tmp_path / "work.py"
    script.write_bytes(b"# coding: latin-1\r\nlabel = 'caf\xe9'\r\n1 / 0\r\n")
    plan = tmp_path / "plan.json"
    plan.write_text('{"functions": []}', encoding="utf-8")
    with pytest.raises(ZeroDivisionError) as actual:
        runner.run_script(script, [], plan)
    frames = traceback.extract_tb(actual.value.__traceback__)
    assert (frames[-1].filename, frames[-1].lineno) == (str(script), 3)


@pytest.mark.parametrize("ending,exit_code,error", [
    ("", None, None),
    ("raise SystemExit(None)", None, None),
    ("raise SystemExit(0)", 0, None),
    ("raise SystemExit(7)", 7, None),
    ("raise SystemExit('stop')", "stop", None),
    ("raise ValueError('stop')", None, ValueError),
])
def test_plain_execution_restores_interpreter_state(tmp_path, capsys, ending, exit_code, error):
    script = tmp_path / "work.py"
    script.write_text("import json, sys\n"
                      "print(json.dumps([__name__, __file__, sys.argv, sys.path[0], "
                      "sys.modules['__main__'].__file__]))\n"
                      "sys.argv.append('changed')\nsys.path.append('changed')\n" + ending + "\n",
                      encoding="utf-8")
    plan = tmp_path / "plan.json"
    plan.write_text('{"functions": []}', encoding="utf-8")
    original_main, original_argv, original_path = sys.modules["__main__"], sys.argv, sys.path[:]
    if error:
        with pytest.raises(error, match="stop"):
            runner.run_script(script, ["forwarded"], plan)
    else:
        report = runner.run_script(script, ["forwarded"], plan)
        assert report["exit_code"] == exit_code
        assert report["functions"] == report["not_found"] == []
    assert json.loads(capsys.readouterr().out) == [
        "__main__", str(script), [str(script), "forwarded"], str(tmp_path), str(script)]
    assert sys.modules["__main__"] is original_main
    assert sys.argv is original_argv
    assert sys.path == original_path
