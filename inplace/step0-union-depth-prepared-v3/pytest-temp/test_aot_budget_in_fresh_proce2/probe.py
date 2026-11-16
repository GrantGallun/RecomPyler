import json, sys
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
