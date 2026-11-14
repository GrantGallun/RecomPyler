"""Portable CLI contracts; fixture engines do not compile or run benchmarks."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import pytest

CLI = Path(__file__).resolve().parents[1] / "tools" / "dev_inspect.py"


def call(*args):
    return subprocess.run([sys.executable, str(CLI), *map(str, args)], capture_output=True)


def test_lossless_diff_keeps_bytes_and_exposes_line_endings(tmp_path):
    left, right, out = (tmp_path / n for n in ("left", "right", "out"))
    left.write_bytes(b"x\r\n\xff")
    right.write_bytes(b"x\n\xff\n")
    done = call("diff", left, right, "--output", out)
    assert done.returncode == 1, done.stderr
    assert (out / "left.raw").read_bytes() == left.read_bytes()
    assert (out / "right.raw").read_bytes() == right.read_bytes()
    report = json.loads((out / "report.json").read_text())
    assert report["raw_equal"] is False
    assert report["normalization"] == []
    assert "\\r\\n" in (out / "diff.txt").read_text()


def test_diff_normalization_is_explicit_and_keeps_originals(tmp_path):
    left, right = tmp_path / "left", tmp_path / "right"
    left.write_bytes(b"x\r\n")
    right.write_bytes(b"x\n")
    out = tmp_path / "out"
    assert call("diff", left, right, "--normalize", "newlines", "--output", out).returncode == 0
    report = json.loads((out / "report.json").read_text())
    assert not report["raw_equal"] and report["compared_equal"]
    assert call("diff", left, right, "--output", out).returncode == 2
    assert (out / "left.raw").read_bytes() == b"x\r\n"


def test_asm_inspects_never_executes_binary_and_records_provenance(tmp_path):
    binary = tmp_path / "not executable.bin"
    binary.write_bytes(b"not executable\x00")
    tool = tmp_path / "fake_objdump.py"
    tool.write_text("import sys\nprint('fixture objdump 1' if '--version' in sys.argv else '0001: ret')\n")
    out = tmp_path / "out"
    done = call("asm", "--binary", binary, "--tool", sys.executable, "--tool-arg", tool,
                "--kind", "actual-aot", "--output", out)
    assert done.returncode == 0, done.stderr
    report = json.loads((out / "report.json").read_text())
    assert report["binary"]["sha256"] == hashlib.sha256(binary.read_bytes()).hexdigest()
    assert report["kind"] == "actual-aot"
    assert "fixture objdump 1" in report["tool_version"]
    assert (out / "assembly.txt").read_text().strip() == "0001: ret"
    assert "--binary" not in report["command"]


def test_asm_missing_tool_and_failed_tool_are_explicit(tmp_path):
    binary = tmp_path / "b"
    binary.write_bytes(b"b")
    assert call("asm", "--binary", binary, "--tool", "missing-objdump-12345", "--output", tmp_path / "missing").returncode == 2
    tool = tmp_path / "bad.py"
    tool.write_text("import sys\nprint('bad input', file=sys.stderr)\nsys.exit(7)\n")
    out = tmp_path / "failed"
    done = call("asm", "--binary", binary, "--tool", sys.executable, "--tool-arg", tool, "--output", out)
    assert done.returncode == 2
    assert json.loads((out / "report.json").read_text())["status"] == "error"


def test_c_provenance_preserves_flag_order_and_source(tmp_path):
    source = tmp_path / "a.c"
    source.write_bytes(b"int main(void){return 0;}\r\n")
    out = tmp_path / "out"
    done = call("c", "--source", source, "--flag=-O3", "--flag=-ffp-contract=off", "--output", out)
    assert done.returncode == 0, done.stderr
    report = json.loads((out / "report.json").read_text())
    assert report["flags"] == ["-O3", "-ffp-contract=off"]
    assert report["flags_origin"] == "user-supplied; not recovered from binary"
    assert (out / "source.raw").read_bytes() == source.read_bytes()


def fixture_repo(tmp_path):
    repo = tmp_path / "repo"
    package = repo / "src" / "recompyler"
    package.mkdir(parents=True)
    (package / "__init__.py").write_text("")
    (package / "heap.py").write_text('''
class _Program:
    ahead_of_time = True
    def compile(self): self.run = lambda: 42
    def guards_hold(self): return True
class _Unloader:
    def result(self): return 42
    def write_back(self): pass
class Region:
    aot_calls = jit_calls = 0
    def __init__(self, fn): self.original = fn
    def load(self, program, args): return None
    def attempt(self, args, kwargs=None):
        program = _Program()
        program.compile()
        self.load(program, args)
        assert program.guards_hold()
        program.run()
        unloader = _Unloader()
        answer = unloader.result()
        unloader.write_back()
        self.aot_calls += 1
        return True, answer
''')
    (package / "runner.py").write_text('''
import json
from . import heap
def recommended(plan, force=False): return {('target', 1)}
def regional(plan): return {('target', 1)} if json.loads(plan.read_text()).get('region') else set()
def run_script(script, script_args, plan, force=False):
    ns = {}; exec(compile(script.read_text(), str(script), 'exec'), ns)
    region = heap.Region(ns['target'])
    ok, value = region.attempt(())
    print('check answer', value)
    return {'functions': [{'function': 'target', 'region': True, 'aot_calls': 1, 'jit_calls': 0, 'fallback_calls': 0}], 'exit_code': None, 'batches': {}}
''')
    script, plan = tmp_path / "target.py", tmp_path / "plan.json"
    script.write_text("def target():\n    return 42\n")
    plan.write_text(json.dumps({"region": True}))
    return repo, script, plan


def test_phases_runs_explicit_repo_keeps_real_stdout_modes_and_hashes(tmp_path):
    repo, script, plan = fixture_repo(tmp_path)
    out = tmp_path / "out"
    done = call("phases", "--repo", repo, "--python", sys.executable, "--script", script,
                "--plan", plan, "--function", "target", "--output", out)
    assert done.returncode == 0, done.stderr
    report = json.loads((out / "report.json").read_text())
    diagnostic = report["diagnostic"]
    assert diagnostic["instrumented"] is True
    assert diagnostic["attempts"][0]["native_entries"] == 1
    assert diagnostic["attempts"][0]["aot_calls"] == 1
    assert diagnostic["attempts"][0]["jit_calls"] == 0
    assert diagnostic["runner"]["functions"][0]["fallback_calls"] == 0
    assert report["checks"] == ["check answer 42"]
    assert b"check answer 42" in (out / "stdout.bin").read_bytes()
    assert report["script"]["sha256"] == hashlib.sha256(script.read_bytes()).hexdigest()


def test_phases_rejects_unsupported_engine_before_script_effects(tmp_path):
    repo, script, plan = fixture_repo(tmp_path)
    plan.write_text('{"region": false}')
    script.write_text("raise RuntimeError('must not execute')\n")
    out = tmp_path / "out"
    done = call("phases", "--repo", repo, "--python", sys.executable, "--script", script,
                "--plan", plan, "--function", "target", "--output", out)
    assert done.returncode == 2
    report = json.loads((out / "report.json").read_text())
    assert "unsupported engine" in report["diagnostic"]["error"]
    assert "must not execute" not in (out / "stderr.bin").read_text()


def test_cases_list_and_dry_run_are_portable(tmp_path):
    listed = call("cases", "--list")
    assert listed.returncode == 0
    assert "cross-process" in listed.stdout.decode()
    repo = CLI.parents[1]
    out = tmp_path / "out"
    done = call("cases", "cross-process", "--repo", repo, "--python", sys.executable,
                "--dry-run", "--output", out)
    assert done.returncode == 0, done.stderr
    report = json.loads((out / "report.json").read_text())
    assert report["executed"] is False
    assert "test_region_reuse.py" in " ".join(report["command"])


@pytest.mark.parametrize("problem", ["uncalled", "ambiguous", "exception"])
def test_phases_reports_missing_coverage_and_execution_errors(tmp_path, problem):
    repo, script, plan = fixture_repo(tmp_path)
    runner = repo / "src/recompyler/runner.py"
    source = runner.read_text()
    if problem == "uncalled":
        source = source.replace("ok, value = region.attempt(())", "ok, value = True, 42")
    elif problem == "ambiguous":
        source = source.replace("return {('target', 1)}\ndef regional", "return {('target', 1), ('target', 8)}\ndef regional")
    else:
        script.write_text("print('check before failure', 1)\nraise RuntimeError('sentinel')\n")
    runner.write_text(source)
    out = tmp_path / "out"
    done = call("phases", "--repo", repo, "--python", sys.executable, "--script", script,
                "--plan", plan, "--function", "target", "--output", out)
    assert done.returncode == 2
    report = json.loads((out / "report.json").read_text())
    assert "error" in report["diagnostic"]
    if problem == "uncalled":
        assert "no target" in report["diagnostic"]["error"]
        assert report["diagnostic"]["runner"] is not None
    if problem == "exception":
        assert report["checks"] == ["check before failure 1"]


def test_native_failed_attempt_does_not_claim_aot_success(tmp_path):
    repo, script, plan = fixture_repo(tmp_path)
    heap = repo / "src/recompyler/heap.py"
    source = heap.read_text().replace("lambda: 42", "lambda: (_ for _ in ()).throw(ValueError('native failure'))")
    source = source.replace("        program.run()", "        try: program.run()\n        except ValueError: return False, None")
    heap.write_text(source)
    runner = repo / "src/recompyler/runner.py"
    source = runner.read_text().replace("print('check answer', value)", "print('check answer', value if ok else ns['target']())")
    source = source.replace("'aot_calls': 1", "'aot_calls': region.aot_calls").replace("'fallback_calls': 0", "'fallback_calls': int(not ok)")
    runner.write_text(source)
    out = tmp_path / "out"
    done = call("phases", "--repo", repo, "--python", sys.executable, "--script", script,
                "--plan", plan, "--function", "target", "--output", out)
    assert done.returncode == 0, done.stderr
    report = json.loads((out / "report.json").read_text())["diagnostic"]
    attempt = report["attempts"][0]
    assert not attempt["ok"] and attempt["native_entries"] == 1
    assert attempt["native_modes"] == ["aot"] and attempt["aot_calls"] == 0
    assert report["runner"]["functions"][0]["fallback_calls"] == 1


@pytest.mark.parametrize("fail", [False, True])
def test_worker_restores_instrumentation_on_success_and_exception(tmp_path, fail):
    repo, script, plan = fixture_repo(tmp_path)
    if fail:
        script.write_text("raise RuntimeError('sentinel')\n")
    config = dict(repo=str(repo), script=str(script), plan=str(plan), function="target", line=None, force=False, script_args=[])
    probe = f'''
import sys
sys.path.insert(0, {str(CLI.parent)!r})
sys.path.insert(0, {str(repo / 'src')!r})
import _phase_worker as worker
from recompyler import heap
methods = [(heap.Region, 'attempt'), (heap.Region, 'load'), (heap._Program, 'compile'), (heap._Program, 'guards_hold'), (heap._Unloader, 'write_back')]
before = [getattr(cls, name) for cls, name in methods]
worker.instrument({config!r})
assert before == [getattr(cls, name) for cls, name in methods]
print('restored')
'''
    done = subprocess.run([sys.executable, "-c", probe], capture_output=True)
    assert done.returncode == 0, done.stderr
    assert b"restored" in done.stdout


@pytest.mark.parametrize("exit_code", [0, 5])
def test_cases_executes_selected_command_and_preserves_failure(tmp_path, exit_code):
    repo = tmp_path / "repo"
    (repo / "tests").mkdir(parents=True)
    (repo / "tests/test_array_fallback.py").write_text("# fixture selected test file\n")
    (repo / "pytest.py").write_text(f"import sys\nprint('fixture selectors', sys.argv[1:])\nsys.exit({exit_code})\n")
    out = tmp_path / "out"
    done = call("cases", "rollback", "--repo", repo, "--python", sys.executable, "--output", out)
    assert done.returncode == (0 if exit_code == 0 else 2), done.stderr
    report = json.loads((out / "report.json").read_text())
    assert report["executed"] and report["returncode"] == exit_code
    assert b"tests/test_array_fallback.py" in (out / "stdout.bin").read_bytes()


def test_phase_jit_counts_and_plan_artifact_hashes_are_explicit(tmp_path):
    repo, script, plan = fixture_repo(tmp_path)
    heap = repo / "src/recompyler/heap.py"
    heap.write_text(heap.read_text().replace("ahead_of_time = True", "ahead_of_time = False").replace("self.aot_calls += 1", "self.jit_calls += 1"))
    runner = repo / "src/recompyler/runner.py"
    runner.write_text(runner.read_text().replace("'aot_calls': 1, 'jit_calls': 0", "'aot_calls': 0, 'jit_calls': 1"))
    artifact = tmp_path / "kernel.pyd"
    artifact.write_bytes(b"unloaded fixture artifact")
    plan.write_text(json.dumps({"region": True, "plan": {"aot_regions": {"folder": str(tmp_path), "module": "kernel"}}}))
    out = tmp_path / "out"
    done = call("phases", "--repo", repo, "--python", sys.executable, "--script", script,
                "--plan", plan, "--function", "target", "--output", out)
    assert done.returncode == 0, done.stderr
    report = json.loads((out / "report.json").read_text())
    attempt = report["diagnostic"]["attempts"][0]
    assert attempt["native_modes"] == ["jit"] and attempt["jit_calls"] == 1 and attempt["aot_calls"] == 0
    assert report["planned_artifacts"][0]["candidates"][0]["sha256"] == hashlib.sha256(artifact.read_bytes()).hexdigest()
    assert report["planned_artifacts"][0]["loaded"] is None


def test_recursive_result_conversion_is_timed_once_per_attempt(tmp_path):
    repo, script, plan = fixture_repo(tmp_path)
    heap = repo / "src/recompyler/heap.py"
    heap.write_text(heap.read_text().replace("    def result(self): return 42", "    def result(self, depth=5):\n        return self.result(depth - 1) if depth else 42"))
    config = dict(repo=str(repo), script=str(script), plan=str(plan), function="target", line=None, force=False, script_args=[])
    probe = f'''
import itertools, json, sys
sys.path.insert(0, {str(CLI.parent)!r})
import _phase_worker as worker
ticks = itertools.count(0, 10)
worker.time.perf_counter_ns = lambda: next(ticks)
report = worker.instrument({config!r})
attempt = report['attempts'][0]
assert attempt['result_ns'] == 10, attempt
assert attempt['other_attempt_ns'] >= 0, attempt
assert attempt['ok'] and attempt['aot_calls'] == 1
print(json.dumps(attempt))
'''
    done = subprocess.run([sys.executable, "-c", probe], capture_output=True)
    assert done.returncode == 0, done.stderr
