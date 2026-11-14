"""Metadata-only original workload plus separate extended-loop diagnostic."""
from datetime import datetime, timezone
from pathlib import Path
import shutil
import sys


REFERENCE = Path(r"D:/Code/Datathon/recompyler-codex-20261111/wave8-study/results-paired-final")
BASELINE = "1d4084f914fa9594ecb801e3efa565edcd7e1241"


def prepare(args, s):
    if (args.limit, args.samples, args.repetitions, args.timeout) != (40, 8, 5, 180):
        raise SystemExit("Keep fixed 40/8/5/180 profile/timing settings.")
    out = Path(args.output).resolve()
    if out.exists():
        raise SystemExit("Choose a NEW output directory; never reuse or alter old results.")
    reference = s.read(REFERENCE / "manifest.json")
    sources = {"current": s.revision(Path(args.current).resolve()),
               "candidate": s.revision(Path(args.candidate).resolve())}
    if sources["current"]["git_head"] != BASELINE:
        raise SystemExit("Current comparator must be exact strict 1d4084f9.")
    if not args.candidate_commit or sources["candidate"]["git_head"] != args.candidate_commit:
        raise SystemExit("Candidate must be the exact clean reviewed coverage commit.")
    if any(value["git_status"] for value in sources.values()):
        raise SystemExit("Both source checkouts must be clean.")
    original = next(dict(workload) for workload in reference["workloads"] if workload["name"] == "chaos")
    assert original["group"] == "heldout"
    workloads = [original, dict(original, name="chaos_extended32", group="diagnostic")]
    for workload in workloads:
        if s.input_inventory(Path(workload["cwd"]), workload["inventory_kind"]) != workload["input_sha256"]:
            raise SystemExit("Frozen chaos full input inventory changed.")
    out.mkdir(parents=True)
    shutil.copytree(REFERENCE / "shim", out / "shim", ignore=shutil.ignore_patterns("__pycache__"))
    if s.file_hashes(out / "shim") != reference["shim_sha256"]:
        raise SystemExit("Frozen loops=2 shim changed.")
    shutil.copytree(out / "shim", out / "shim-extended32")
    extended = out / "shim-extended32" / "pyperf.py"
    shim = extended.read_bytes()
    assert shim.count(b"LOOPS = 2") == 1
    extended.write_bytes(shim.replace(b"LOOPS = 2", b"LOOPS = 32"))
    helper_names = sorted(s.file_hashes(s.HERE))
    manifest = {"schema": 8, "utc": datetime.now(timezone.utc).isoformat(),
        "python": sys.executable, "python_version": sys.version,
        "runtime_identity": s.runtime_identity(),
        "execution_environment": s.execution_environment(s.HERE),
        "sources": sources, "source_order": list(sources), "stage": "wave10-chaos-subset",
        "harness_sha256": s.digest(Path(s.__file__).read_bytes()),
        "audit_sha256": s.digest((s.HERE / "audit.py").read_bytes()),
        "warmup_sha256": s.digest((s.HERE / "warm_bytecode.py").read_bytes()),
        "preflight_sha256": s.digest((s.HERE / "native_preflight.py").read_bytes()),
        "helpers": {name: s.digest((s.HERE / name).read_bytes()) for name in helper_names},
        "shim_sha256": s.file_hashes(out / "shim"),
        "extra_shim_sha256": {"shim-extended32": s.file_hashes(out / "shim-extended32")},
        "shim_by_workload": {"chaos": "shim", "chaos_extended32": "shim-extended32"},
        "loop_counts_by_workload": {"chaos": 2, "chaos_extended32": 32}, "limit": 40, "samples": 8,
        "repetitions": 5, "timeout_s": 180, "shim_loops": 2, "audit_repetitions": 5,
        "cohort": "one unchanged held-out chaos workload plus separately labeled32-loop diagnostic; not a rerun of all38",
        "workloads": workloads, "historical_exclusions": [],
        "population_provenance": {"manifest": str(REFERENCE / "manifest.json"),
            "sha256": s.digest((REFERENCE / "manifest.json").read_bytes()),
            "latency_or_profile_reuse": False, "historical_heldout_denominator": 38,
            "new_heldout_subset_denominator": 1, "separate_diagnostic_denominator": 1},
        "bytecode_policy": "Copied study compile-only union/freeze protocol, task-local bytecode, no timing writes.",
        "order": "Fresh current/candidate profiles; five rotating plain/current/candidate process triplets; five alternating separate audits.",
        "timing": "Fresh whole-process default-unforced run; no --force. Original case retains loops2; separately labeled extended diagnostic freezes loops32. Includes startup/conversions/guards/workload.",
        "equality": "Exact stdout/exit only (chaos stdout is normally empty); separate original RNG/input graph and derived pixel diagnostics are required.",
        "later_fix_fairness": "All profiles/caches/latencies/audits fresh; never pool historical measurements.",
        "state_audits": "Run state_audit.py separately under CPU grant; explicit-entry artifacts are diagnostic, not selected default deployment."}
    manifest["deployment_preflight_entry"] = "Chaosgame.create_image_chaos"
    s.save(out / "manifest.json", manifest)
    print("Prepared unchanged chaos loops2 plus separate loops32 diagnostic:4profiles,30timingchildren,20separateaudits,4compile-onlywarmups,2nativepreflights. Metadata only.")
