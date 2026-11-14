"""Read-only verification of both completed native-cost studies."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def read(path):
    return json.loads(path.read_text(encoding="utf8"))


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


records = {}
for name, folder, expected_timings in (
    ("manual", ROOT / "wave6-study/results-v2", 40),
    ("proof", ROOT / "wave6-proof-study/results", 20),
):
    analysis = read(folder / "ANALYSIS.json")
    manifest = read(folder / "manifest.json")
    assert analysis["all_valid"] and analysis["failures"] == []
    assert analysis["manifest_sha256"] == digest(folder / "manifest.json")
    post = read(folder / "checkpoint-postverification.json")
    assert post["all_valid"]
    for comparison in post["comparisons"].values():
        assert comparison["valid"]
        for metric, result in comparison["metrics"].items():
            if metric != "types_sha256" or not comparison["declared_type_relaxation"]:
                assert result["matched_steps"] == result["compared_steps"]
                assert not result["different_steps"]
    timing_count = aot_calls = phase_calls = 0
    for label, row in analysis["rows"].items():
        assert row["checks_valid"]
        assert len(row["kernel_samples_s"]) == len(row["process_wall_samples_s"]) == 5
        timing_count += 5
        if label in ("plain", "c"):
            continue
        assert row["jit_calls_total"] == row["fallback_calls_total"] == 0
        assert row.get("actual_modes_valid", True)
        aot_calls += row["aot_calls_total"]
        phase = row["phase"]
        assert phase["valid"] and phase["numba_imported"] is False
        if name == "manual":
            assert phase["actual_jit_calls"] == phase["fallback_calls"] == 0
            phase_calls += phase["actual_aot_calls"]
        else:
            assert phase["actual_calls"]["jit_calls"] == phase["actual_calls"]["fallback_calls"] == 0
            phase_calls += phase["actual_calls"]["aot_calls"]
        assert phase["growth_native_exits"] == 0
    assert timing_count == expected_timings
    assert aot_calls == (11250 if name == "manual" else 5000)
    assert phase_calls == (2700 if name == "manual" else 1200)
    records[name] = dict(manifest_sha256=digest(folder / "manifest.json"),
                         timing_processes=timing_count, timing_AOT_calls=aot_calls,
                         phase_AOT_calls=phase_calls, every_checkpoint_valid=True)
(ROOT / "wave6-verification.json").write_text(json.dumps(records, indent=2) + "\n", encoding="utf8")
print("Verified60 timing processes,16250 timing AOT calls,3900 diagnostic AOT calls and every checkpoint comparison.")
