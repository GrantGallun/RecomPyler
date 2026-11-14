"""A fully AOT-budgeted plan must not silently pay JIT startup on deployment misses."""
import json
import os
from pathlib import Path
import subprocess
import sys

import pytest


@pytest.mark.parametrize("mode,expects_numba,compiled", [
    ("miss", False, 0),
    ("missing", False, 0),
    ("ordinary_missing", False, 0),
    ("valid", False, 2),
    ("force", True, 2),
    ("jit_plan", True, 2),
])
def test_aot_budget_in_fresh_process(tmp_path, mode, expects_numba, compiled):
    script = tmp_path / "work.py"
    script.write_text("def step(values):\n    values[0] += 1\n    return values[0]\n"
                      "data = [0]\nfor _ in range(2):\n    step(data)\nprint(data[0])\n")
    probe = tmp_path / "probe.py"
    probe.write_text('''import json, sys
from pathlib import Path
from types import SimpleNamespace
from recompyler import aot, heap, runner

script, mode = Path(sys.argv[1]), sys.argv[2]
def export(F, I, top, st, handle):
    at = I[handle + 2]
    I[at] += 1
    return I[at]

digest = "saved-digest-that-does-not-match"
if mode == "valid":
    # Generate this exact tiny program without importing Numba, then supply a
    # test export implementing its known one-list/one-int ABI.
    namespace = {}
    exec(compile(script.read_text().split("data =")[0], str(script), "exec"), namespace)
    class Capture(dict):
        def __bool__(self):
            return True
        def get(self, key, default=None):
            self.digest = key
            return export
    capture = Capture()
    heap.lift_region(namespace["step"], capture).program_for(([0],))
    digest = capture.digest

aot.load = lambda section: None if mode in ("missing", "ordinary_missing") else SimpleNamespace(kernel=export)
row = {"function": "step", "line": 1,
       "candidate": {"status": "verified", "recommended": True, "engine": "region"}}
section = {"functions": [{"function": "step", "line": 1, "exports": {digest: "kernel"}}]}
plan = {"worth_running": True, "startup_s": 0.01, "saving_s": 1.0, "aot_regions": section}
if mode == "ordinary_missing":
    del row["candidate"]["engine"]
    plan = {"worth_running": True, "aot": section}
rows = [row]
if mode == "jit_plan":
    # An uncovered recommended function means the plan already budgets JIT.
    rows.append({"function": "not_exported", "line": 100,
                 "candidate": {"status": "verified", "recommended": True}})
plan_path = script.with_suffix(".json")
plan_path.write_text(json.dumps({"plan": plan, "functions": rows}))
report = runner.run_script(script, [], plan_path, force=mode == "force")
print(json.dumps({"numba": "numba" in sys.modules, "row": report["functions"][0]}))
''')
    env = dict(os.environ, PYTHONPATH=str(Path(__file__).resolve().parents[1] / "src"),
               RECOMPYLER_CACHE=str(tmp_path / "cache"), NUMBA_CACHE_DIR=str(tmp_path / "numba"))
    run = subprocess.run([sys.executable, str(probe), str(script), mode], cwd=tmp_path,
                         env=env, capture_output=True, text=True, timeout=90)
    assert run.returncode == 0, run.stderr
    output = run.stdout.splitlines()
    assert output[0] == "2", output  # Each mutation is applied exactly once.
    result = json.loads(output[1])
    assert result["numba"] is expects_numba, result
    assert result["row"]["compiled_calls"] == compiled, result
    assert result["row"]["aot_calls"] == (2 if mode == "valid" else 0), result
    assert result["row"]["jit_calls"] == (2 if mode in ("force", "jit_plan") else 0), result
    assert result["row"]["fallback_calls"] == 2 - compiled, result
    assert result["row"]["ahead_of_time"] is (mode == "valid"), result
