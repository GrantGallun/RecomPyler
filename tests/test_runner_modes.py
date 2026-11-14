"""Runner mode reporting must describe executed code, not export availability."""
import json
from types import SimpleNamespace

import pytest

from recompyler import aot, heap, runner


@pytest.mark.parametrize("program_modes,calls,fallback,expected", [
    ([False], 1, False, False),  # Exports loaded, but the actual digest used JIT.
    ([True, False], 2, False, False),  # Mixed signatures cannot be reported all-AOT.
    ([True], 1, False, True),
    ([True], 1, True, False),  # Prepared AOT, but no compiled call executed.
    ([], 0, False, False),
    ([True, None], 2, False, False),  # Unknown/unsupported prepared signature.
])
def test_region_aot_report_checks_actual_programs(tmp_path, monkeypatch, program_modes, calls, fallback, expected):
    script = tmp_path / "script.py"
    script.write_text("def candidate(x):\n    return x + 1\n" + "candidate(2)\n" * calls)
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps({
        "plan": {"worth_running": True, "aot_regions": {"functions": [
            {"function": "candidate", "line": 1, "exports": {"saved-digest": "kernel"}}]}},
        "functions": [{"function": "candidate", "line": 1,
                       "candidate": {"status": "verified", "recommended": True, "engine": "region"}}],
    }))
    exports = SimpleNamespace(kernel=object())
    monkeypatch.setattr(aot, "load", lambda section: exports)

    class FakeRegion:
        def __init__(self, original, built):
            assert built == {"saved-digest": exports.kernel}
            self.original = original
            self.compiled_calls = self.fallback_calls = 0
            self.aot_calls = self.jit_calls = 0
            self.programs = {str(index): None if mode is None else SimpleNamespace(
                ahead_of_time=mode, broken=False) for index, mode in enumerate(program_modes)}

        def __call__(self, *args):
            if fallback:
                self.fallback_calls += 1
            else:
                if program_modes[self.compiled_calls % len(program_modes)] is False:
                    self.jit_calls += 1
                else:
                    self.aot_calls += 1
                self.compiled_calls += 1
            return self.original(*args)

    monkeypatch.setattr(heap, "lift_region", FakeRegion)
    row = runner.run_script(script, [], plan)["functions"][0]
    assert row["ahead_of_time"] is expected
    assert row["aot_loaded"] is bool(calls)
    assert row["compiled_calls"] == (0 if fallback else calls)
    assert row["fallback_calls"] == (calls if fallback else 0)
    expected_jit = 0 if fallback else sum(mode is False for mode in program_modes[:calls])
    assert row["jit_calls"] == expected_jit
    assert row["aot_calls"] == (0 if fallback else calls - expected_jit)


@pytest.mark.parametrize("calls,fallback,expected", [(1, False, True), (1, True, False), (0, False, False)])
def test_ordinary_aot_report_requires_executed_compiled_call(tmp_path, monkeypatch, calls, fallback, expected):
    script = tmp_path / "script.py"
    script.write_text("def candidate(x):\n    return x + 1\n" + "candidate(2)\n" * calls)
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps({
        "plan": {"worth_running": True, "aot": {"functions": [{"function": "candidate", "line": 1}]}},
        "functions": [{"function": "candidate", "line": 1,
                       "candidate": {"status": "verified", "recommended": True}}],
    }))
    monkeypatch.setattr(aot, "load", lambda section: object())

    class FakeAotLifted:
        def __init__(self, original, entry, module):
            self.original = original
            self.compiled_calls = self.fallback_calls = 0

        def __call__(self, *args):
            if fallback:
                self.fallback_calls += 1
            else:
                self.compiled_calls += 1
            return self.original(*args)

    monkeypatch.setattr(aot, "AotLifted", FakeAotLifted)
    row = runner.run_script(script, [], plan)["functions"][0]
    assert row["ahead_of_time"] is expected
    assert row["aot_loaded"] is bool(calls)
    assert row["aot_calls"] == (calls if not fallback else 0)
    assert row["jit_calls"] == 0
