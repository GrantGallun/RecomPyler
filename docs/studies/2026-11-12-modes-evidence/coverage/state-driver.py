"""Authorized serialized state diagnostics, separate from default timing cells."""
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent
HELPERS = ROOT.parent / "coverage-formal-v1-helpers"
sys.path.insert(0, str(ROOT.parent / "results-formal-v1" / "helpers"))
from common import environment, execute, read, require_grant, sha, write_new

grant = ROOT.parent / "cpu-grant-formal.json"
require_grant(grant)
manifest = read(ROOT / "manifest.json")
script = next(row["script"] for row in manifest["workloads"] if row["name"] == "chaos")
write_new(ROOT / "state-driver-identity.json", {"driver_sha256": sha(__file__),
          "manifest_sha256": sha(ROOT / "manifest.json"), "grant_sha256": sha(grant)})
for variant in ("current", "candidate"):
    source = Path(manifest["sources"][variant]["path"])
    for kind in ("original", "pixels"):
        label = variant + "-" + kind
        artifact = ROOT / "state" / label / "artifact"
        output = ROOT / "state" / label / "build.json"
        env = environment(ROOT / "state-cache" / label / "cache", source / "src")
        command = [sys.executable, "-B", str(HELPERS / "state_audit.py"), "--mode", "build",
                   "--kind", kind, "--script", script, "--artifact", str(artifact), "--output", str(output)]
        execute(ROOT / "state-processes" / (label + "-build"), command, ROOT, env, timeout=240)
        built = read(output)
        print(label + ": " + built["status"], flush=True)
        if built["status"] == "native-declined":
            if variant == "candidate":
                raise RuntimeError("Candidate state diagnostic declined native execution")
            continue
        assert built["status"] == "aot-built"
        output = output.with_name("aot.json")
        command = [sys.executable, "-B", str(HELPERS / "state_audit.py"), "--mode", "aot",
                   "--kind", kind, "--script", script, "--artifact", str(artifact), "--output", str(output)]
        execute(ROOT / "state-processes" / (label + "-aot"), command, ROOT, env, timeout=240)
        print(label + ": fresh AOT state verified", flush=True)
print("All state diagnostics complete.", flush=True)
