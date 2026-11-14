"""Frozen current-source A/B versus unchanged C ports; no historical timings reused."""
import argparse
import json
import os
from pathlib import Path
import re
import shutil
import statistics
import struct
import sys

import common

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
NAMES = ["barnes_hut", "nbody", "float", "scimark", "fannkuch", "spectral_norm", "coroutines", "richards", "raytrace"]
HELPERS = ["bench.py", "common.py", "audit.py", "warm_bytecode.py", "phase_breakdown.py", "map_aot.py"]


def parse(output):
    checks, seconds = {}, {}
    for line in output.splitlines():
        fields = line.split()
        if len(fields) == 3 and fields[0] == "check":
            checks[fields[1]] = fields[2]
        elif len(fields) == 2 and fields[0].startswith("seconds"):
            seconds[fields[0]] = float(fields[1])
    return checks, seconds


def checks_equal(left, right):
    if left.keys() != right.keys():
        return False
    for key, value in left.items():
        other = right[key]
        if "0x" in value.lower() or "0x" in other.lower():
            if struct.pack("!d", float.fromhex(value)) != struct.pack("!d", float.fromhex(other)):
                return False
        elif value != other:
            return False
    return True


def kernel_view(name):
    return "warm" if name in {"richards", "spectral_norm", "scimark"} else "forced"


def sha(path):
    return common.digest(Path(path).read_bytes())


def prepare(args):
    out = Path(args.output).resolve()
    if (out / "manifest.json").exists():
        raise SystemExit("Manifest exists; preserve it and choose a new output directory.")
    if not args.candidate:
        raise SystemExit("A reviewed candidate source path is required for preparation.")
    reference = Path(args.reference_native).resolve()
    old = common.read(reference / "manifest.json")
    sources = {"baseline": common.revision(Path(args.baseline).resolve()), "candidate": common.revision(Path(args.candidate).resolve())}
    if sources["baseline"]["git_head"] != "3f0370d5fe5c358b4a0b3fd8e1ea10a2f22f87bf" or any(s["git_status"] for s in sources.values()):
        raise SystemExit("Require clean current baseline3f0370d and reviewed frozen candidate.")
    programs = {}
    for name in NAMES:
        row = old["programs"][name]
        copied = {"name": name, "kernel_view": kernel_view(name)}
        for key, folder in (("binary", "bin"), ("script", "drivers"), ("source", "c-sources")):
            source = Path(row[key])
            if sha(source) != row[key + "_sha256"]:
                raise SystemExit("Changed C reference input: " + str(source))
            target = out / folder / source.name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, target)
            copied[key] = str(target.relative_to(out))
            copied[key + "_sha256"] = sha(target)
        programs[name] = copied
    shutil.copytree(ROOT / "wave3-study" / "results-v2" / "shim", out / "shim", ignore=shutil.ignore_patterns("__pycache__"))
    manifest = {"schema": 1, "sources": sources, "runtime_identity": common.runtime_identity(),
        "execution_environment": common.execution_environment(ROOT.parent / "heads-up-bot"),
        "helpers": {n: sha(HERE / n) for n in HELPERS}, "programs": programs,
        "input_inventory": {n: common.file_hashes(out / n) for n in ("bin", "drivers", "c-sources", "shim")},
        "python": sys.executable, "limit": 40, "samples": 8, "repetitions": 5, "python_inner_reps": 5,
        "c_inner_reps": 20, "profile_inner_reps": 1, "timeout_s": 300,
        "c_provenance": {"manifest": str(reference / "manifest.json"), "sha256": sha(reference / "manifest.json"),
                         "compiler": old["compiler"], "flags": old["flags"], "rebuilt": False},
        "method": "Five rotating fresh processes per variant; identical state-reset kernel bodies across sources; median of process walls and median of each process's best inner kernel time. Common unchanged C reference uses20inner states; Python/RP5. Default and explicitly forced/warm views remain separate.",
        "phase_diagnostic": "Separate instrumented Barnes6repetitions/100advances; first excluded. Never a headline timing sample."}
    common.save(out / "manifest.json", manifest)
    print("Prepared9unchangedCports/drivers,18freshprofiles,300timingchildren,42separateaudits; no benchmark executed.")


def verify(out, manifest):
    if common.runtime_identity() != manifest["runtime_identity"]:
        raise SystemExit("Runtime/dependency identity changed.")
    for n, h in manifest["helpers"].items():
        if sha(HERE / n) != h:
            raise SystemExit("Frozen helper changed: " + n)
    for folder, expected in manifest["input_inventory"].items():
        if common.file_hashes(out / folder) != expected:
            raise SystemExit("Frozen input inventory changed: " + folder)
    for source in manifest["sources"].values():
        if common.revision(Path(source["path"])) != source:
            raise SystemExit("Frozen product source changed: " + source["path"])


def environment(out, name, variant, manifest, writes=False):
    cache = out / "cache" / name / variant
    temp = cache / "temp"
    temp.mkdir(parents=True, exist_ok=True)
    env = dict(manifest["execution_environment"])
    env.update(PYTHONPATH=os.pathsep.join([str(out / "shim"), str(Path(manifest["sources"][variant]["path"]) / "src")]),
        RECOMPYLER_CACHE=str(cache / "recompyler"), NUMBA_CACHE_DIR=str(cache / "numba"), TEMP=str(temp), TMP=str(temp),
        PYTHONHASHSEED="0", PYTHONWARNINGS="ignore", PYTHONPYCACHEPREFIX=str(out / "bytecode" / name),
        PYTHONDONTWRITEBYTECODE="0" if writes else "1")
    return env


def bytecodes(path):
    return {str(p.relative_to(path)): sha(p) for p in sorted(path.rglob("*")) if p.is_file()}


def modes(name):
    return ["default", "forced"] + (["warm"] if kernel_view(name) == "warm" else [])


def chosen_plan(folder, variant, mode):
    return folder / (variant + (".warm.plan.json" if mode == "warm" else ".plan.json"))


def warm_plan(path, target):
    if target.exists():
        return
    data = common.read(path)
    for row in data.get("functions", []):
        c = row["candidate"]
        c["recommended"] = c.get("status") == "verified" and (c.get("speedup") or 0) > 1.05
    data.setdefault("plan", {})["worth_running"] = True
    data["explicit_warm_diagnostic"] = "Predeclared verified>1.05x selection; force permits JIT. Not a default deployment claim."
    common.save(target, data)


def run(args):
    out = Path(args.output).resolve()
    manifest = common.read(out / "manifest.json")
    verify(out, manifest)
    py, timeout = manifest["python"], manifest["timeout_s"]
    for index, (name, item) in enumerate(manifest["programs"].items()):
        if args.names and name not in args.names:
            continue
        folder, script = out / "programs" / name, str(out / item["script"])
        envs = {v: environment(out, name, v, manifest) for v in manifest["sources"]}
        warmenv = environment(out, name, "baseline", manifest, True)
        warmcommand = [py, str(HERE / "warm_bytecode.py"), *[str(Path(s["path"]) / "src") for s in manifest["sources"].values()], str(out / "drivers"), str(out / "shim")]
        freeze = folder / "bytecode-frozen.json"
        prefix = out / "bytecode" / name
        if freeze.exists():
            if bytecodes(prefix) != common.read(freeze):
                raise SystemExit("Bytecode changed on resume: " + name)
        else:
            result = common.execute(folder / "bytecode-before-profiles", warmcommand, out, warmenv, timeout)
            if result["exit_code"] or result["status"] != "ok":
                raise SystemExit("Bytecode warmup failed.")
        order = ["baseline", "candidate"] if index % 2 == 0 else ["candidate", "baseline"]
        valid = {}
        for variant in order:
            plan = chosen_plan(folder, variant, "default")
            command = [py, "-m", "recompyler", "profile", "--json", str(plan), "--limit", "40", "--samples", "8", script, "1"]
            result = common.execute(folder / (variant + "-profile"), command, out, environment(out, name, variant, manifest, True), timeout)
            valid[variant] = result["exit_code"] == 0 and result["status"] == "ok" and plan.exists()
            if valid[variant] and "warm" in modes(name):
                warm_plan(plan, chosen_plan(folder, variant, "warm"))
        artifacts = {}
        for variant in order:
            if not valid[variant]:
                continue
            data = common.read(chosen_plan(folder, variant, "default"))
            for kind in ("aot", "aot_regions"):
                section = data.get("plan", {}).get(kind)
                if section:
                    directory = Path(section["folder"]).resolve()
                    if out not in directory.parents:
                        raise SystemExit("AOT artifact unexpectedly refers outside fresh study cache.")
                    for path in directory.glob(section["module"] + "*.pyd"):
                        artifacts[str(path)] = sha(path)
        artifact_path = folder / "aot-artifacts-frozen.json"
        if artifact_path.exists() and common.read(artifact_path) != artifacts:
            raise SystemExit("AOT artifact identity changed on resume.")
        common.save(artifact_path, artifacts)
        if not freeze.exists():
            result = common.execute(folder / "bytecode-before-timing", warmcommand, out, warmenv, timeout)
            if result["exit_code"] or result["status"] != "ok":
                raise SystemExit("Bytecode warmup failed.")
            common.save(freeze, bytecodes(prefix))
        frozen = common.read(freeze)
        variants = [("plain", None), ("c", None)] + [(v, mode) for mode in modes(name) for v in ("baseline", "candidate")]
        for rep in range(5):
            rotation = rep % len(variants)
            for variant, mode in variants[rotation:] + variants[:rotation]:
                env = envs["baseline"] if variant in {"plain", "c"} else envs[variant]
                label = variant if mode is None else variant + "-" + mode
                if variant == "c":
                    command = [str(out / item["binary"]), "20"]
                elif variant == "plain":
                    command = [py, script, "5"]
                else:
                    if not valid[variant]:
                        continue
                    command = [py, "-m", "recompyler", "run", *(["--force"] if mode != "default" else []),
                        "--plan", str(chosen_plan(folder, variant, mode)), "--json", str(folder / f"{label}-{rep}.counts.json"), script, "5"]
                common.execute(folder / f"{label}-{rep}", command, out, env, timeout)
        for variant in ("baseline", "candidate"):
            if not valid[variant]:
                continue
            for mode in modes(name):
                label = variant + "-" + mode
                command = [py, str(HERE / "audit.py"), "--output", str(folder / (label + ".audit.json")),
                    "--plan", str(chosen_plan(folder, variant, mode)), *(["--force"] if mode != "default" else []), script, "5"]
                common.execute(folder / (label + "-audit"), command, out, envs[variant], timeout)
        if bytecodes(prefix) != frozen:
            raise SystemExit("Frozen bytecode changed during timing/audits: " + name)
        if any(sha(path) != h for path, h in artifacts.items()):
            raise SystemExit("AOT artifact changed during timing/audits: " + name)
        summarize(out)
    verify(out, manifest)


def summarize(out):
    manifest = common.read(out / "manifest.json")
    rows = {}
    for name, item in manifest["programs"].items():
        folder = out / "programs" / name
        references = [parse((folder / f"plain-{r}.stdout").read_text(errors="replace"))[0] for r in range(5) if (folder / f"plain-{r}.stdout").exists()]
        plain_records = [common.read(folder / f"plain-{r}.json") for r in range(5) if (folder / f"plain-{r}.json").exists()]
        stable = (len(references) == len(plain_records) == 5 and bool(references[0])
                  and all(r["status"] == "ok" and r["exit_code"] == 0 for r in plain_records)
                  and all(checks_equal(references[0], r) for r in references))
        row = {"kernel_view": item["kernel_view"], "plain_checks_stable": stable, "variants": {}}
        labels = ["plain", "c"] + [v + "-" + m for v in ("baseline", "candidate") for m in modes(name)]
        for label in labels:
            records, kernels = [], []
            matching = stable
            for rep in range(5):
                path = folder / f"{label}-{rep}.json"
                if not path.exists():
                    continue
                record = common.read(path)
                checks, seconds = parse(path.with_suffix(".stdout").read_text(errors="replace"))
                matching = matching and record["status"] == "ok" and record["exit_code"] == 0 and checks_equal(references[0], checks)
                records.append(record)
                kernels.append(seconds)
            result = {"complete": len(records) == 5, "checks_match_python": matching and len(records) == 5,
                "process_wall_samples_s": [r["wall_s"] for r in records],
                "median_process_wall_s": statistics.median(r["wall_s"] for r in records) if records else None,
                "kernel_samples_s": kernels,
                "median_best_kernel_s": {k: statistics.median(t[k] for t in kernels) for k in kernels[0] if all(k in t for t in kernels)} if kernels else {}}
            if label not in {"plain", "c"}:
                counts = [common.read(folder / f"{label}-{r}.counts.json") for r in range(5) if (folder / f"{label}-{r}.counts.json").exists()]
                functions = [f for c in counts for f in c.get("functions", [])]
                result["counts"] = counts
                result["count_reports"] = len(counts)
                for field in ("compiled_calls", "aot_calls", "jit_calls", "fallback_calls"):
                    result[field] = (sum(f[field] for f in functions) if len(counts) == 5 and
                        (functions or field in {"compiled_calls", "fallback_calls"}) and all(field in f for f in functions) else None)
                audit = folder / (label + ".audit.json")
                if audit.exists():
                    result["separate_audit"] = common.read(audit)
                    result["audit_checks_match_python"] = stable and checks_equal(references[0], parse((folder / (label + "-audit.stdout")).read_text(errors="replace"))[0])
                    audit_process = common.read(folder / (label + "-audit.json"))
                    result["audit_valid"] = bool(result["audit_checks_match_python"] and audit_process["status"] == "ok" and audit_process["exit_code"] == 0
                        and result["separate_audit"].get("compiled_total_reconciles")
                        and result["separate_audit"].get("product_exact_counter_matches_audit") is not False
                        and not result["separate_audit"]["totals"]["unknown_native_calls"])
            row["variants"][label] = result
        rows[name] = row
    common.save(out / "summary.json", {"programs": rows, "method": manifest["method"], "sources": manifest["sources"]})


def diagnostics(args):
    out = Path(args.output).resolve()
    manifest = common.read(out / "manifest.json")
    verify(out, manifest)
    name = "barnes_hut"
    folder = out / "programs" / name
    driver = out / manifest["programs"][name]["script"]
    frozen = common.read(folder / "bytecode-frozen.json")
    evidence = {}
    for variant, source in manifest["sources"].items():
        target = out / "diagnostics" / (variant + ("-phases.payload.json" if args.mode == "phases" else "-aot-map.payload.json"))
        plan = chosen_plan(folder, variant, "forced")
        if args.mode == "phases":
            command = [manifest["python"], str(HERE / "phase_breakdown.py"), "--source", source["path"],
                       "--driver", str(driver), "--plan", str(plan), "--output", str(target)]
        else:
            command = [manifest["python"], str(HERE / "map_aot.py"), "--plan", str(plan),
                       "--audit", str(folder / (variant + "-forced.audit.json")), "--output", str(target)]
        result = common.execute(out / "diagnostics" / (variant + "-" + args.mode), command, out,
                                environment(out, name, variant, manifest), manifest["timeout_s"])
        checks = parse((out / "diagnostics" / (variant + "-" + args.mode + ".stdout")).read_text(errors="replace"))[0]
        reference = parse((folder / "plain-0.stdout").read_text(errors="replace"))[0]
        evidence[variant] = {"process": result, "payload": str(target), "headline_timing_eligible": False,
                             "numeric_checks_match_python": bool(reference) and checks_equal(reference, checks) if args.mode == "phases" else None}
        if bytecodes(out / "bytecode" / name) != frozen:
            raise SystemExit("Frozen bytecode changed during separate diagnostic.")
    common.save(out / "diagnostics" / (args.mode + "-summary.json"), evidence)
    verify(out, manifest)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mode", choices=["prepare", "run", "summary", "phases", "map-aot"])
    parser.add_argument("--output", default=str(HERE / "results"))
    parser.add_argument("--baseline", default=str(HERE / "baseline"))
    parser.add_argument("--candidate")
    parser.add_argument("--reference-native", default=str(ROOT / "wave3-native"))
    parser.add_argument("--names", nargs="*")
    args = parser.parse_args()
    if args.mode == "prepare":
        prepare(args)
    elif args.mode == "run":
        run(args)
    elif args.mode in {"phases", "map-aot"}:
        diagnostics(args)
    else:
        summarize(Path(args.output).resolve())
