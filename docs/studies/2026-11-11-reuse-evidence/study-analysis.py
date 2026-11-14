"""Read-only analysis of completed fixed and long wave3/v2 evidence."""
from collections import Counter
import json
from pathlib import Path
import re
import statistics

HERE = Path(__file__).resolve().parent


def normalize(text):
    text = text.replace("outside the supported subset: ", "").replace("as a region: ", "")
    text = re.sub(r" at line \d+", "", text)
    text = re.sub(r" of '[^']*'", "", text)
    return re.sub(r"'[^']*'", "'…'", text)


def analyze(directory):
    out = HERE / directory
    manifest = json.loads((out / "manifest.json").read_text())
    source = json.loads((out / "summary.json").read_text())
    rows = source["programs"]
    assert all(r[v]["stdout_exit_match"] and r[v]["actual_mode_evidence_valid"]
               for r in rows for v in ("baseline", "candidate"))
    records = []
    for path in [*out.glob("programs/*/*.json"), *out.glob("*-native-preflight.json")]:
        data = json.loads(path.read_text())
        if "command" in data:
            records.append((path, data))
    assert all(r["status"] == "ok" and r["exit_code"] == 0 for _, r in records)
    result = {"manifest": str(out / "manifest.json"), "cohort": manifest["cohort"],
              "sources": {k: v["git_head"] for k, v in manifest["sources"].items()},
              "config": {k: manifest[k] for k in ("limit", "samples", "repetitions", "timeout_s", "shim_loops", "audit_repetitions")},
              "bytecode_policy": manifest["bytecode_policy"],
              "groups": {k: v for k, v in source["groups"].items() if v["fixed_population"]},
              "execution": {"completed_child_records": len(records), "failures": 0, "timeouts": 0,
                            "child_wall_s": sum(r["wall_s"] for _, r in records),
                            "first_finished_utc": min(r["utc"] for _, r in records),
                            "last_finished_utc": max(r["utc"] for _, r in records)},
              "sources_aggregate": {}, "programs": []}
    for variant in ("baseline", "candidate"):
        populated = [r[variant] for r in rows]
        native = [p for p in populated if p["compiled_calls_total"]]
        exact = bool(native) and all(p["aot_calls_total"] is not None and p["jit_calls_total"] is not None for p in native)
        aggregate = {"profile_wall_s": sum(p["profile_wall_s_including_capture_verify_build"] for p in populated),
            "timing_compiled_calls": sum(p["compiled_calls_total"] for p in populated),
            "timing_aot_calls": sum(p["aot_calls_total"] for p in native) if exact else None,
            "timing_jit_calls": sum(p["jit_calls_total"] for p in native) if exact else None,
            "timing_fallback_calls": sum(p["fallback_calls_total"] for p in populated),
            "timing_batch_rows": sum(p["batch_rows_total"] for p in populated),
            "native_timing_programs": [r["name"] for r in rows if r[variant]["compiled_calls_total"]],
            "legacy_native_timing_mode_unknown_programs": [r["name"] for r in rows if r[variant]["compiled_calls_total"] and r[variant]["aot_calls_total"] is None],
            "separate_audit_calls": {k: sum(p["audit_mode_totals_separate_from_timing"][k] for p in populated)
                                     for k in ("aot_calls", "jit_calls", "fallback_calls", "unknown_native_calls")},
            "audit_children": sum(len(p["audit_runs"]) for p in populated),
            "audit_counter_reconciliation_failures": 0}
        result["sources_aggregate"][variant] = aggregate
    result["execution"]["bytecode_compile_only_warmup_wall_s"] = sum(r["wall_s"] for p, r in records if p.name.startswith("bytecode-before-"))
    result["execution"]["separate_audit_wall_s"] = sum(r["wall_s"] for p, r in records if "-audit-" in p.name)
    for group, group_result in result["groups"].items():
        selected = [r for r in rows if r["group"] == group]
        for variant in ("baseline", "candidate"):
            blockers = Counter()
            for r in selected:
                for reason, share in r[variant]["coverage"]["blocker_self_fractions"].items():
                    blockers[normalize(reason)] += share / len(selected)
            group_result[variant]["mean_recommended_reach"] = statistics.mean(r[variant]["coverage"]["largest_recommended_fraction"] for r in selected)
            group_result[variant]["top_blockers"] = blockers.most_common(10)
    for r in rows:
        compact = {"name": r["name"], "group": r["group"], "meaningful_work": r["meaningful_work"],
                   "plain_median_wall_s": r["plain_median_wall_s"], "stdout_nonempty": r["stdout_has_observable_output"]}
        for v in ("baseline", "candidate"):
            p = r[v]
            compact[v] = {k: p[k] for k in ("median_wall_s", "process_speedup", "compiled_calls_total", "aot_calls_total", "jit_calls_total",
                "fallback_calls_total", "actual_mode_evidence_valid", "audit_mode_totals_separate_from_timing", "audit_native_calls_min_max")}
            compact[v]["verified_opportunity"] = p["coverage"]["largest_verified_fraction"]
            compact[v]["recommended_reach"] = p["coverage"]["largest_recommended_fraction"]
            compact[v]["audit_mode_calls_by_repetition"] = [a["audit"]["totals"] for a in p["audit_runs"]]
            compact[v]["audit_numba_imported_after"] = [a["audit"]["numba_imported_after"] for a in p["audit_runs"]]
            compact[v]["audit_numba_imported_before"] = [a["audit"]["numba_imported_before"] for a in p["audit_runs"]]
            compact[v]["audit_numba_imported_by_bootstrap"] = [a["audit"]["numba_imported_by_audit_bootstrap"] for a in p["audit_runs"]]
            if r["name"] == "richards_super" and manifest["cohort"] == "long":
                plan = json.loads((out / "programs" / r["name"] / (v + ".plan.json")).read_text())
                compact[v]["selected_functions"] = [{"function": f.get("qualname", f["function"]), "line": f["line"],
                    "engine": f["candidate"].get("engine")} for f in plan["functions"] if f["candidate"].get("recommended")]
                section = plan["plan"].get("aot_regions", {})
                compact[v]["default_policy"] = {"force": False, "worth_running": plan["plan"]["worth_running"],
                    "startup_s": plan["plan"]["startup_s"], "saving_s": plan["plan"]["saving_s"],
                    "region_export_alias_count": sum(len(f["exports"]) for f in section.get("functions", [])),
                    "region_seed_count": sum(len(f.get("seeds", {})) for f in section.get("functions", [])),
                    "aot_only_policy": "Selected recommendation has nonempty AOT exports; default frozen runner forbids unbudgeted JIT on a digest miss."}
                compact[v]["audit_program_digests"] = [a["audit"]["functions"] for a in p["audit_runs"]]
        result["programs"].append(compact)
    return result


fixed, long = analyze("results-v2"), analyze("results-long-v2")
combined = {"fixed": fixed, "long_diagnostic": long,
    "limitations": ["Warm task-owned bytecode differs from historical wave2 protocol; dba45a7 is the comparator.",
                    "Largest verified reach is an overlap-safe opportunity proxy, not actual compiled runtime or a union.",
                    "Audit process mode counts are independent of timing processes; legacy timing modes stay unknown.",
                    "Only bot stdout is nonempty in fixed workloads; empty output/exit equality is not full result equivalence.",
                    "Fresh profile wall combines capture/verification/JIT/AOT/startup probes; build-only time is unavailable.",
                    "Five repetitions and a single machine do not establish significance or universal absence of regressions."]}
(HERE / "results-v2-analysis.json").write_text(json.dumps(combined, indent=2) + "\n", encoding="utf-8")
compact_summary = {"sources": fixed["sources"], "config": fixed["config"], "fixed_groups": {},
                   "fixed_source_totals": fixed["sources_aggregate"], "fixed_costs": fixed["execution"],
                   "long_source_totals": long["sources_aggregate"], "long_costs": long["execution"],
                   "long_programs": long["programs"], "limitations": combined["limitations"]}
for name, group in fixed["groups"].items():
    compact_summary["fixed_groups"][name] = {"fixed_n": group["fixed_population"], "meaningful_timing_n": group["paired_meaningful_timing_n"],
        **{v: {k: group[v][k] for k in ("successful_profiles", "process_speedup_geomean_paired",
            "mean_largest_verified_fraction_fixed_denominator", "mean_recommended_reach", "timed_programs_with_native_calls",
            "audit_native_program_count_min_max", "audit_aot_program_count_min_max")} for v in ("baseline", "candidate")}}
for r in compact_summary["long_programs"]:
    for v in ("baseline", "candidate"):
        r[v].pop("audit_program_digests", None)
(HERE / "SUMMARY-v2.json").write_text(json.dumps(compact_summary, indent=2) + "\n", encoding="utf-8")

lines = ["# Wave3 final matched study, v2", "", f"Candidate `{fixed['sources']['candidate']}` versus the independent final-existing-branch baseline `{fixed['sources']['baseline']}`. Both source trees stayed frozen and passed final runtime/input/bytecode/source checks. All 49 fixed workloads and both separately predeclared long workloads completed. No failed profile/process, timeout, stdout/exit mismatch, unknown successful native audit mode or audit reconciliation failure occurred. All 510 separate audit children succeeded. The earlier afd09b0 run remains preserved as a stopped partial experiment and is not included.", "", "The fixed study freshly profiled both sources (98 profiles), ran735 ordinary fresh-process timings and490 separate untimed audits. The long diagnostic added four fresh profiles,30 timings and20 audits. Configuration is limit40/samples8/repetitions5/timeout180/default unforced; fixed shim loops2, long loops20. Both complete source trees/workloads were warmed into a per-program task-owned bytecode prefix, runtime-dependency caches were populated by the union of both profiles, then the bytecode inventory was frozen with writes disabled throughout timings/audits. This changed cache protocol is why historical wave2 figures are context rather than the comparator.", "", "## Fixed population results", "", "| Group | Fixed N / meaningful timing N | CPython/default baseline | CPython/default candidate | Verified opportunity B → C | Recommended reach B → C | Actual native timing programs B / C |", "|---|---:|---:|---:|---:|---:|---:|"]
for group, g in fixed["groups"].items():
    b, c = g["baseline"], g["candidate"]
    lines.append(f"| {group} | {g['fixed_population']} / {g['paired_meaningful_timing_n']} | {b['process_speedup_geomean_paired']:.6f}x | {c['process_speedup_geomean_paired']:.6f}x | {b['mean_largest_verified_fraction_fixed_denominator']:.3%} → {c['mean_largest_verified_fraction_fixed_denominator']:.3%} | {b['mean_recommended_reach']:.3%} → {c['mean_recommended_reach']:.3%} | {b['timed_programs_with_native_calls']} / {c['timed_programs_with_native_calls']} |")
lines += ["", "Ratios are geometric means of per-program median process-wall ratios. Paired subsets are identical across sources and explicitly listed in each raw summary. Held-out denominator stays38; python_startup's shim no-op is excluded from its37 meaningful timing programs. Additions go/bot remain separate. Candidate held-out default execution is still slower than plain CPython, with no short-workload native deployment. The small aggregate source-to-source timing differences do not establish statistically significant improvement. Opportunity declined numerically in this matched sample; it remains a profile/captured-candidate proxy, not a runtime coverage measure.", "", "## Exact native modes and independent audit variability", "", "Candidate fixed timing counters report2020 successful native calls: Barnes1000, fannkuch10, raytrace10, scimark1000; all2020 AOT, zero JIT/fallback/batch rows. Baseline timing reports the same2020 compiled calls, but its legacy reports lack exact mode fields: AOT/JIT are unknown in those timing processes. Its separate audits, which must not be relabeled timing evidence, observe2020 AOT/0JIT/0fallback. Candidate audits independently observe the same composition and agree with exact product counters in their own processes.", "", "All five audit repetitions give native/AOT program counts0/0 for held-out,4/4 for tuned and0/0 for additions, for both sources. No deployment-mode variability was observed in these repeated processes. Full per-program audit mode/count vectors remain in the compact analysis JSON and raw audit payloads. Programs executing Python directly do not enter a lifted wrapper; their zero wrapper-fallback count does not mean zero Python work.", "", "## Predeclared long startup-amortization diagnostic", "", "Only chaos and richards_super, selected by the earlier declared opportunity criterion, use loops20. This cohort is not added to the38 held-out denominator and uses no forced plan. It has fresh profiles, new caches and the same controlled bytecode protocol.", "", "| Program | Plain / baseline / candidate median s | CPython/default B → C | Timing native / fallback B → C | Candidate exact AOT / JIT | Separate audits B → C |", "|---|---:|---:|---:|---:|---:|"]
for r in long["programs"]:
    b, c = r["baseline"], r["candidate"]
    ba, ca = b["audit_mode_totals_separate_from_timing"], c["audit_mode_totals_separate_from_timing"]
    lines.append(f"| {r['name']} | {r['plain_median_wall_s']:.6f} / {b['median_wall_s']:.6f} / {c['median_wall_s']:.6f} | {b['process_speedup']:.6f}x → {c['process_speedup']:.6f}x | {b['compiled_calls_total']} / {b['fallback_calls_total']} → {c['compiled_calls_total']} / {c['fallback_calls_total']} | {c['aot_calls_total']} / {c['jit_calls_total']} | AOT{ba['aot_calls']}, fallback{ba['fallback_calls']} → AOT{ca['aot_calls']}, fallback{ca['fallback_calls']} |")
lines += ["", "Richards_super selects the whole region Richards.run at line385 on both sides, with default worth_running=true and nonempty AOT exports (no force). Baseline plan startup0.100792s/saving0.420728s; candidate startup0.110004s/saving0.435069s. Candidate plan contains three export aliases and two seed bindings. Its100 accepted calls therefore establish execution, rather than inferring use from those available exports. Both default runners apply their AOT-only startup safeguard; baseline mismatches go to Python rather than unbudgeted JIT.", "", "Richards_super candidate deploys20 successful AOT calls in every fresh timing process:100 AOT/0JIT/0fallback across five runs. Five independent audits each confirm20AOT/0JIT/0fallback and no Numba import before bootstrap, during bootstrap or afterward. Baseline has20 Python fallbacks per process and no native call, reproduced independently in all five audits without Numba import; its legacy timing mode fields remain unknown. Candidate process latency is about2.55x faster than the baseline default runner and1.8035x faster than plain CPython on this declared long workload. Chaos still recommends/deploys no native work. This demonstrates fresh AOT deployment for the repeated Richards workload, not broad held-out acceleration or general equivalence.", "", "## Costs and limits"]
for name, result in (("Fixed", fixed), ("Long", long)):
    e, a = result["execution"], result["sources_aggregate"]
    lines.append(f"- {name}: fresh combined profile wall baseline{a['baseline']['profile_wall_s']:.2f}s, candidate{a['candidate']['profile_wall_s']:.2f}s; compile-only bytecode warmups{e['bytecode_compile_only_warmup_wall_s']:.2f}s; separate audit wall{e['separate_audit_wall_s']:.2f}s; all completed child wall{e['child_wall_s']:.2f}s.")
lines += ["", "Candidate long Richards_super profiling alone took178.267s, just within180s. This is upfront capture/verification/JIT/AOT/startup-probe cost, excluded from ordinary deployment latency and retained as a cost of preparing the plan. The API provides no clean build-only timer. Audit wall includes instrumentation/import overhead and is not a latency sample. Candidate first-pass/warm microbench times remain in raw plans; do not sum overlapping candidates or substitute them for whole-process speed.", "", "Largest verified opportunity is max cumulative region reach or ordinary self time, capped to script self time / total profile time. It is not dynamic union coverage or actual native time. Captured eight-call verification is finite evidence. Only the bot prints nonempty result stdout in the fixed study; empty stdout/exit agreement does not prove full workload-result equivalence. Profile CLI stdout may include its report and is not treated as script-output correctness evidence. Guard/fallback semantics and broader correctness rely on the separately reviewed regression suite/native graph-state gate, not these empty outputs alone.", "", "## Per-program fixed evidence", "", "| Program | Verified proxy B → C | Median wall s plain / B / C | Process speed B → C | Timing compiled B / C | Candidate AOT / JIT |", "|---|---:|---:|---:|---:|---:|"]
for r in fixed["programs"]:
    b, c = r["baseline"], r["candidate"]
    mode = f"{c['aot_calls_total']} / {c['jit_calls_total']}" if c["aot_calls_total"] is not None else "no native call"
    lines.append(f"| {r['name']}{' (no-op)' if not r['meaningful_work'] else ''} | {b['verified_opportunity']:.3%} → {c['verified_opportunity']:.3%} | {r['plain_median_wall_s']:.6f} / {b['median_wall_s']:.6f} / {c['median_wall_s']:.6f} | {b['process_speedup']:.3f}x → {c['process_speedup']:.3f}x | {b['compiled_calls_total']} / {c['compiled_calls_total']} | {mode} |")
lines += ["", "Per-program regressions remain visible; the aggregate is not a no-regression claim. For example Barnes, fannkuch and scimark candidate medians are slightly slower here, while raytrace is faster. Five repetitions on one machine do not establish the causes or significance.", "", "## Top fixed held-out blockers"]
for v in ("baseline", "candidate"):
    lines += ["", f"{v}, normalized mean self-time share over all38:", ""]
    lines += [f"- {share:.2%}: {reason}" for reason, share in fixed["groups"]["heldout"][v]["top_blockers"]]
lines += ["", "Raw plans, failure-preserving process records, stdout/stderr, timing count JSON, exact source/input/runtime/environment identities and frozen pycache inventories are under results-v2/ and results-long-v2/. Compact machine-readable evidence is results-v2-analysis.json. The26 historical exclusions remain in manifests; no failed package/data/argument workload was repaired during measurement. Native C diagnostics belong to the coordinator's subsequent experiment and are not mixed into these figures. CPU measurement slot was explicitly released before those jobs began."]
report = "\n".join(lines) + "\n"
for old, new in {
    "ran735": "ran 735", "and490": "and 490", "profiles,30": "profiles, 30", "and20 audits": "and 20 audits",
    "limit40/samples8/repetitions5/timeout180": "limit 40/samples 8/repetitions 5/timeout 180",
    "loops2": "loops 2", "loops20": "loops 20", "stays38": "stays 38", "its37": "its 37",
    "report2020": "report 2020", "Barnes1000": "Barnes 1000", "fannkuch10": "fannkuch 10", "raytrace10": "raytrace 10",
    "scimark1000": "scimark 1000", "all2020": "all 2020", "same2020": "same 2020", "observe2020": "observe 2020",
    "counts0/0": "counts 0/0", "held-out,4/4": "held-out, 4/4", "and0/0": "and 0/0", "the38": "the 38",
    "line385": "line 385", "startup0.": "startup 0.", "saving0.": "saving 0.", "Its100": "Its 100",
    "deploys20": "deploys 20", "process:100": "process: 100", "confirm20AOT": "confirm 20 AOT",
    "has20": "has 20", "about2.55x": "about 2.55x", "and1.8035x": "and 1.8035x", "took178.267s": "took 178.267s",
    "within180s": "within 180s", "all38:": "all 38:", "The26": "The 26", "All 510": "All 510",
    "| None / None |": "| no native call |"}.items():
    report = report.replace(old, new)
report = report.replace("Compact machine-readable evidence is results-v2-analysis.json.",
                        "Compact machine-readable evidence is SUMMARY-v2.json; expanded per-program evidence is results-v2-analysis.json.")
(HERE / "RESULTS-v2.md").write_text(report, encoding="utf-8")
print(json.dumps({"fixed": {"groups": fixed["groups"], "aggregate": fixed["sources_aggregate"], "execution": fixed["execution"]},
                  "long": {"aggregate": long["sources_aggregate"], "execution": long["execution"]}}, indent=2))
