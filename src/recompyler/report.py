from pathlib import Path


def compact_profile(report):
    """Convert the detailed profile to the versioned agent report."""
    hotspots = []
    for row in report["functions"]:
        candidate = row["candidate"]
        item = {"function": row["function"], "line": row["line"], "calls": row["calls"],
                "self_ms": round(row["self_s"] * 1000, 3), "status": candidate["status"]}
        if candidate["status"] == "verified":
            item.update(recommended=candidate["recommended"], recommendation=candidate["recommendation"][:160],
                        net_ms_first_run=round(candidate["net_s_first_run"] * 1000, 3),
                        net_ms_cached=round(candidate["net_s_cached"] * 1000, 3),
                        warm_start_ms=round(candidate["warm_start_s"] * 1000, 3))
            item.update(samples=candidate["samples"], fallback=candidate["fallback_samples"],
                        call_x=round(candidate["speedup"], 3), batch_x=candidate["batch_speedup"] and round(candidate["batch_speedup"], 3),
                        batch_size=candidate["batch_size"], first_pass_ms=round(candidate["first_pass_s"] * 1000, 3),
                        backends_x={name: round(ratio, 3) for name, ratio in candidate["batch_backends"].items()},
                        best_backend=candidate["best_backend"])
            if candidate["backend_note"]:
                item["backend_note"] = candidate["backend_note"][:160]
        else:
            item["reason"] = candidate["reason"][:160]
        hotspots.append(item)
    compact = {"schema": "recompyler.profile.v1", "script": Path(report["script"]).name, "hotspots": hotspots}
    if "plan" in report:
        compact["plan"] = report["plan"]
    return compact
