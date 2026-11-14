"""Analyze immutable wave5 records; no imports of product code or benchmarks."""
from collections import defaultdict
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
OUT = HERE / "results"
read = lambda p: json.loads(Path(p).read_text())
sha = lambda p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
manifest, raw = read(OUT / "manifest.json"), read(OUT / "summary.json")


def function_counts(variant):
    functions = {}
    for report in variant["counts"]:
        for row in report["functions"]:
            item = functions.setdefault(row["function"], {"function": row["function"], "region": row["region"],
                "compiled_calls": 0, "aot_calls": 0, "jit_calls": 0, "fallback_calls": 0})
            for field in ("compiled_calls", "aot_calls", "jit_calls", "fallback_calls"):
                item[field] += row[field]
    return list(functions.values())


def kernel_functions(name, key, functions):
    if name != "scimark":
        return functions
    wanted = {"FFT_transform", "FFT_inverse"} if key == "seconds_fft" else set()
    return [f for f in functions if f["function"] in wanted]


def engine(name, functions):
    labels = []
    for f in functions:
        if not f["compiled_calls"]:
            continue
        prefix = "heapRegion" if f["region"] else "ordinaryLifted"
        mode = "AOT+JIT" if f["aot_calls"] and f["jit_calls"] else "AOT" if f["aot_calls"] else "JIT/cache"
        labels.append(prefix + "/" + mode)
    label = "; ".join(dict.fromkeys(labels)) or "Python"
    if name == "spectral_norm" and labels:
        label += " helpers; outer Python"
    return label


records = []
for path in [*OUT.glob("programs/*/*.json"), *OUT.glob("diagnostics/*.json")]:
    value = read(path)
    if isinstance(value, dict) and "command" in value:
        records.append((path, value))
assert len(records) == 382, len(records)
assert all(r["status"] == "ok" and r["exit_code"] == 0 for _, r in records)
result = {"manifest": str(OUT / "manifest.json"), "manifest_sha256": sha(OUT / "manifest.json"),
    "sources": {k: {"git_head": v["git_head"], "path": v["path"], "heap_sha256": v["src_sha256"]["recompyler/heap.py"]}
                for k, v in manifest["sources"].items()},
    "method": manifest["method"], "c_provenance": manifest["c_provenance"],
    "execution": {"completed_child_processes": len(records), "failed_processes": 0, "timeouts": 0,
        "profile_processes": 18, "ordinary_timing_processes": 300, "separate_mode_audits": 42,
        "compile_only_warmups": 18, "phase_processes": 2, "map_only_processes": 2,
        "first_child_finished_utc": min(r["utc"] for _, r in records), "last_child_finished_utc": max(r["utc"] for _, r in records),
        "child_wall_s": sum(r["wall_s"] for _, r in records),
        "profile_wall_s": {v: sum(r["wall_s"] for p, r in records if p.name == v + "-profile.json") for v in ("baseline", "candidate")},
        "warmup_wall_s": sum(r["wall_s"] for p, r in records if p.name.startswith("bytecode-before-")),
        "audit_wall_s": sum(r["wall_s"] for p, r in records if p.name.endswith("-audit.json"))},
    "all_numeric_checks_match": True, "all_42_audits_valid": True, "workloads": {}, "kernel_rows": [],
    "phase_diagnostic": {}, "actual_aot_maps": {},
    "limits": ["Shared Windows host with unknown background CPU load; no OS-wide quiet-machine or statistical-significance guarantee.",
               "Kernel metric is median of five fresh-process best-of-five Python/RP inner observations; common C is best-of20 per process.",
               "Unforced default whole-process medians, selected forced/warm walls and instrumented phase medians are different measures.",
               "Explicit warm selection can produce different native paths; FFT candidate changes AOT/JIT composition.",
               "Inherited nullable-tuple field-return identity limitation remains outside this index optimization; finite numeric checks do not prove universal Python compatibility.",
               "Static instruction counts are not cycles or dynamic frequencies."]}

for name, workload in raw["programs"].items():
    assert workload["plain_checks_stable"]
    assert all(v["complete"] and v["checks_match_python"] for v in workload["variants"].values())
    assert all(v.get("audit_valid", True) for v in workload["variants"].values())
    view = workload["kernel_view"]
    work = {"selected_kernel_view": view, "plain_process_wall_s": workload["variants"]["plain"]["median_process_wall_s"],
            "c_process_wall_s": workload["variants"]["c"]["median_process_wall_s"], "versions": {}}
    for v in ("baseline", "candidate"):
        chosen = workload["variants"][v + "-" + view]
        default = workload["variants"][v + "-default"]
        funcs = function_counts(chosen)
        work["versions"][v] = {"selected_process_wall_s": chosen["median_process_wall_s"],
            "default_process_wall_s": default["median_process_wall_s"],
            "default_process_speed_vs_python": work["plain_process_wall_s"] / default["median_process_wall_s"],
            "selected_process_samples_s": chosen["process_wall_samples_s"],
            "default_process_samples_s": default["process_wall_samples_s"],
            "selected_timing_functions": funcs, "selected_timing_count_reports": chosen["counts"],
            "selected_separate_audit_totals": chosen["separate_audit"]["totals"],
            "audit_valid": chosen["audit_valid"], "all_modes": {}}
        for mode in (["default", "forced", "warm"] if view == "warm" else ["default", "forced"]):
            mode_result = workload["variants"][v + "-" + mode]
            assert not any(c.get("batches") for c in mode_result["counts"])
            work["versions"][v]["all_modes"][mode] = {k: mode_result[k] for k in
                ("median_process_wall_s", "median_best_kernel_s", "compiled_calls", "aot_calls", "jit_calls", "fallback_calls", "audit_valid")}
            work["versions"][v]["all_modes"][mode]["process_samples_s"] = mode_result["process_wall_samples_s"]
    result["workloads"][name] = work
    for key, c_time in workload["variants"]["c"]["median_best_kernel_s"].items():
        py_time = workload["variants"]["plain"]["median_best_kernel_s"][key]
        row = {"name": name, "kernel": key, "selected_mode": view,
            "targeted_object_field_region": name in {"barnes_hut", "float", "raytrace", "richards"},
            "c_s": c_time, "python_s": py_time, "versions": {}}
        for v in ("baseline", "candidate"):
            data = workload["variants"][v + "-" + view]
            t = data["median_best_kernel_s"][key]
            funcs = kernel_functions(name, key, work["versions"][v]["selected_timing_functions"])
            totals = {k: sum(f[k] for f in funcs) for k in ("compiled_calls", "aot_calls", "jit_calls", "fallback_calls")}
            row["versions"][v] = {"kernel_s": t, "time_relative_to_c": t / c_time,
                "speed_relative_to_python": py_time / t, "engine": engine(name, funcs), "timing_calls_for_kernel_functions": totals,
                "kernel_native_functions": funcs, "selected_process_wall_s": work["versions"][v]["selected_process_wall_s"],
                "default_process_wall_s": work["versions"][v]["default_process_wall_s"],
                "wall_scope": "complete driver, including all five kernels" if name == "scimark" else "complete driver",
                "kernel_samples_s": [s[key] for s in data["kernel_samples_s"]], "all_checks_match": True, "separate_audit_valid": True}
        row["candidate_speed_vs_baseline"] = row["versions"]["baseline"]["kernel_s"] / row["versions"]["candidate"]["kernel_s"]
        row["candidate_time_change_fraction"] = row["versions"]["candidate"]["kernel_s"] / row["versions"]["baseline"]["kernel_s"] - 1
        result["kernel_rows"].append(row)

assert len(result["kernel_rows"]) == 13
phase_summary = read(OUT / "diagnostics" / "phases-summary.json")
for v in ("baseline", "candidate"):
    assert phase_summary[v]["numeric_checks_match_python"]
    phase = read(OUT / "diagnostics" / (v + "-phases.payload.json"))
    assert phase["report"]["functions"][0]["aot_calls"] == 600
    assert all(r["native_entries"] == 100 for r in phase["repetitions"])
    result["phase_diagnostic"][v] = phase
    result["actual_aot_maps"][v] = read(OUT / "diagnostics" / (v + "-aot-map.payload.json"))
result["assembly_evidence"] = {"report": str(HERE.parent / "wave5-instructions/REPORT.md"),
    "provenance": str(HERE.parent / "wave5-instructions/provenance.json"),
    "nbody_control_provenance": str(HERE.parent / "wave5-instructions/nbody-sections.json"),
    "identified_mass_load_instructions": [5, 1], "force_static_cmovl": [18, 1], "force_static_sar63": [5, 2],
    "nbody_text_bytes_identical": True, "nbody_pdata_identical": True,
    "nbody_text_sha256": "6e9aac9daf84bcfc6c7e4449028884c56978151367c0d2e784adea4792455114"}
(HERE / "SUMMARY.json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")

lines = ["# Nonnegative object-field indexing: matched results", "",
    f"Current baseline `{result['sources']['baseline']['git_head']}` (product0d2c3d3), candidate `{result['sources']['candidate']['git_head']}`. Manifest SHA256 `{result['manifest_sha256']}`. All18fresh profiles,300 ordinary timing children,42 independent mode audits and both separate six-repetition Barnes phase jobs succeeded. Numeric checks matched in every timing/audit/phase process; no timeout or unknown actual audit mode. Final source/runtime/input/AOT-artifact/bytecode checks passed. The CPU slot was explicitly released before further team validation.", "",
    "The narrow change removes signed-negative-index normalization only from proved physical object fields/tags. Python container indices, nullable tuple payload reads, raw ndarray strides, helpers and fallback checks stay unchanged. This is no new frontend coverage claim. The inherited tuple-field return identity limitation remains outside this change; matching these finite checks is not universal Python equivalence.", "",
    "## Targeted heap-region observations", "",
    "Uninstrumented kernel metric: median of five fresh-process best-of-five inner times. Explicit warm/forced policy is declared in the protocol, not chosen from results. The matched C column is newly timed common best-of20-inner observations, also median over five processes. Smaller time is better.", "",
    "| Targeted region | Baseline ms | Candidate ms | Candidate time change | Candidate/C time | Actual path B → C |",
    "|---|---:|---:|---:|---:|---|"]
for r in result["kernel_rows"]:
    if not r["targeted_object_field_region"]:
        continue
    b, c = r["versions"]["baseline"], r["versions"]["candidate"]
    lines.append(f"| {r['name']} | {b['kernel_s']*1000:.4f} | {c['kernel_s']*1000:.4f} | {r['candidate_time_change_fraction']:+.2%} | {c['time_relative_to_c']:.2f}x | {b['engine']} → {c['engine']} |")
lines += ["", "Barnes forced median best kernel fell49.0671→47.4893ms (3.2% less time,1.0332x speed). Float and raytrace also fell in this sample, while basic Richards JIT increased. These are observations on a shared Windows machine with an unknown external CPU consumer; five samples do not establish statistical significance or exclusive attribution. All sample vectors are retained, including regressions and alternative default results.", "",
    "## All13 matched kernel rows", "", "| Kernel | C ms | Python ms | Baseline ms | Candidate ms | Candidate/C time | Python/candidate speed | Candidate engine |",
    "|---|---:|---:|---:|---:|---:|---:|---|"]
for r in result["kernel_rows"]:
    b, c = r["versions"]["baseline"], r["versions"]["candidate"]
    label = r["name"] + ("/" + r["kernel"].replace("seconds_", "") if r["kernel"] != "seconds" else "")
    lines.append(f"| {label} | {r['c_s']*1000:.4f} | {r['python_s']*1000:.4f} | {b['kernel_s']*1000:.4f} | {c['kernel_s']*1000:.4f} | {c['time_relative_to_c']:.2f}x | {c['speed_relative_to_python']:.2f}x | {c['engine']} |")
lines += ["", "The four non-FFT SciMark components execute Python, so their C gaps are not native instruction overhead. SciMark's warm candidate FFT path is mixed ordinary JIT/AOT: FFT_transform uses JIT and FFT_inverse uses AOT, while both are AOT in the baseline. Both sources additionally JIT _total outside the FFT kernel timer. Do not attribute FFT timing differences to this heap-index optimization or assign aggregate workload counters to every SciMark row. Spectral norm uses ordinary JIT helpers with outer Python work.", "",
    "Nbody is an unchanged ordinary-AotLifted control, not the modified heap engine. Its median3.6052→3.7626ms increase is retained; sample ranges overlap strongly (baseline3.5156–3.8052ms, candidate3.5253–3.9312ms). Independent actual PE comparison finds .text and .pdata bytes identical. No additional timing cohort was run and no changed nbody instruction claim is made.", "",
    "## Complete-process walls", "", "Seconds per whole driver containing five inner states (SciMark includes all five kernels). Default is unforced deployment. Selected view is the predeclared forced/warm kernel diagnostic, and its wall includes startup/compiler loading/JIT if used; kernel speed is not whole-process speed.", "",
    "| Workload | Python s | Default B → C s | Selected B → C s | Selected view |", "|---|---:|---:|---:|---|"]
for name, work in result["workloads"].items():
    b, c = work["versions"]["baseline"], work["versions"]["candidate"]
    lines.append(f"| {name} | {work['plain_process_wall_s']:.6f} | {b['default_process_wall_s']:.6f} → {c['default_process_wall_s']:.6f} | {b['selected_process_wall_s']:.6f} → {c['selected_process_wall_s']:.6f} | {work['selected_kernel_view']} |")
lines += ["", "## Separate Barnes attribution and actual machine code", "",
    "Each source's instrumented diagnostic made600 successful AOT advance calls (100per repetition), zero JIT/fallback, with matching numeric checks. Excluding the first repetition, native-extension-entry medians were31.4393→27.4435ms; instrumented whole-kernel medians51.8119→48.0503ms. Load9.2806→9.4542ms, write-back3.3203→3.2936ms and guards0.7393→0.7541ms stayed roughly similar. All six per-repetition component records are in SUMMARY.json. Timers add overhead; native entry includes the ABI wrapper, and independently selected component medians are not an exact additive partition. These figures do not replace the uninstrumented headline samples.", "",
    "The newly built, actually audited r0 exports are mapped to PE SHA/digest/wrapper addresses in results/diagnostics. The independent wave5-instructions/REPORT.md follows wrapper call targets into the actual selected artifacts: the identified QuadTree mass-field load shrinks from five instructions to one, force cmovl18→1 and sar63 5→2. Remaining normalization corresponds to deliberately unchanged list paths; MIXED/exact-integer, recursion/status and representation work remain. These are static facts, not cycles, dynamic frequencies or a predicted fivefold speedup. Profiling JIT LLVM is not relabeled as this AOT assembly.", "",
    "## Costs and evidence", "",
    f"Fresh combined capture/verification/source-construction/JIT/AOT/startup-probe wall was baseline{result['execution']['profile_wall_s']['baseline']:.2f}s and candidate{result['execution']['profile_wall_s']['candidate']:.2f}s. Compile-only warmups{result['execution']['warmup_wall_s']:.2f}s; separate audits{result['execution']['audit_wall_s']:.2f}s. Those costs and phase instrumentation are separate from ordinary timings. The API does not provide a clean build-only timer.", "",
    "SUMMARY.json retains all13rows with source hashes, engines, exact per-function AOT/JIT/fallback timing counters, separate audit composition, all kernel/wall sample vectors, selected/default walls, profile costs and six-repetition phase evidence. Complete process records/stdout/stderr/counts/plans, frozen bytecode/artifact identities and actual binaries remain under results/. Both exact current source trees use the same controlled warm-bytecode procedure. C binaries are unchanged hash-verified clang21.1.6 -O3/-march=native/-ffp-contract=off/UCRT ports; they were newly timed, not rebuilt, and are optimized comparisons rather than proof of optimal assembly. The known C/Python lifetime and representation caveats remain."]
report = "\n".join(lines) + "\n"
for old, new in {"product0d2c3d3": "product 0d2c3d3", "All18fresh": "All 18 fresh", "profiles,300": "profiles, 300",
                 "children,42": "children, 42", "fell49": "fell 49", "time,1.": "time, 1.", "All13": "All 13",
                 "median3.": "median 3.", "baseline3.": "baseline 3.", "candidate3.": "candidate 3.",
                 "made600": "made 600", "(100per": "(100 per", "were31.": "were 31.", "medians51.": "medians 51.",
                 "Load9.": "Load 9.", "write-back3.": "write-back 3.", "guards0.": "guards 0.",
                 "cmovl18": "cmovl 18", "baseline287": "baseline 287", "candidate284": "candidate 284",
                 "warmups": "warmups", "all13rows": "all 13 rows", "clang21.": "clang 21."}.items():
    report = report.replace(old, new)
(HERE / "RESULTS.md").write_text(report, encoding="utf-8")
print(json.dumps({"sources": result["sources"], "manifest_sha256": result["manifest_sha256"], "execution": result["execution"],
                  "kernel_comparison": [{"name": r["name"], "kernel": r["kernel"], "speed_vs_baseline": r["candidate_speed_vs_baseline"]} for r in result["kernel_rows"]]}, indent=2))
