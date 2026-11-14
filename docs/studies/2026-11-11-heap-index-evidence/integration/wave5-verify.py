"""Independent read-only verification of the completed paired measurement matrix."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
OUT = ROOT / "wave5-study/results"


def read(path):
    return json.loads(path.read_text(encoding="utf8"))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


manifest = read(OUT / "manifest.json")
summary = read(OUT / "summary.json")
assert len(summary["programs"]) == 9
timings = audits = 0
rows = []
for name, program in summary["programs"].items():
    assert program["plain_checks_stable"], name
    for label, variant in program["variants"].items():
        assert variant["complete"] and variant["checks_match_python"], (name, label)
        assert len(variant["process_wall_samples_s"]) == 5
        assert len(variant["kernel_samples_s"]) == 5
        timings += 5
        if label not in {"plain", "c"}:
            assert variant["audit_valid"], (name, label)
            assert variant["separate_audit"]["compiled_total_reconciles"]
            assert variant["separate_audit"]["totals"]["unknown_native_calls"] == 0
            assert variant["count_reports"] == 5
            audits += 1
    rows.append({"name": name, "kernel_view": program["kernel_view"], "validated_variants": len(program["variants"])})
assert timings == 300 and audits == 42, (timings, audits)
profiles = []
for name, inputs in manifest["programs"].items():
    for key in ("source", "binary", "script"):
        assert sha(OUT / inputs[key]) == inputs[key + "_sha256"], (name, key)
    for variant in ("baseline", "candidate"):
        profile = read(OUT / "programs" / name / (variant + "-profile.json"))
        assert profile["status"] == "ok" and profile["exit_code"] == 0
        profiles.append(profile["wall_s"])
phase_checks = read(OUT / "diagnostics/phases-summary.json")
phase_totals = {}
for variant in ("baseline", "candidate"):
    checks = phase_checks[variant]
    assert checks["process"]["status"] == "ok" and checks["process"]["exit_code"] == 0
    assert checks["numeric_checks_match_python"]
    payload = read(OUT / "diagnostics" / (variant + "-phases.payload.json"))
    functions = payload["report"]["functions"]
    assert sum(f["aot_calls"] for f in functions) == 600
    assert sum(f["jit_calls"] for f in functions) == 0
    assert sum(f["fallback_calls"] for f in functions) == 0
    assert payload["native_imported_numba"] is False
    phase_totals[variant] = payload["warm_component_medians_ms"]
result = dict(manifest_sha256=sha(OUT / "manifest.json"), timings=timings,
              independent_audits=audits, fresh_profiles=len(profiles),
              all_checks_pass=True, rows=rows, phase_medians_ms=phase_totals)
(ROOT / "wave5-verification.json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf8")
print(f"Verified {timings} timings, {audits} audits, {len(profiles)} profiles and both 600-AOT phase diagnostics.")
