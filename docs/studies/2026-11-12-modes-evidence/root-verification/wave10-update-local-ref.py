"""Fast-forward only the original local integration ref, preserving the checkout."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
ORIGINAL = ROOT.parent / "RecomPyler"
INTEGRATION = ROOT / "wave10-integration"
TARGET = "refs/heads/codex/integrated-coverage"


def git(repo, *args):
    return subprocess.check_output(["git", "-c", "safe.directory=*", "-C", str(repo), *args], stderr=subprocess.PIPE)


def snapshot():
    return {"branch": git(ORIGINAL, "symbolic-ref", "HEAD"),
            "head": git(ORIGINAL, "rev-parse", "HEAD"),
            "status": git(ORIGINAL, "status", "--porcelain"),
            "working_diff": git(ORIGINAL, "diff", "--binary"),
            "staged_diff": git(ORIGINAL, "diff", "--cached", "--binary")}


before = snapshot()
assert before["branch"].decode().strip() != TARGET, "Ref belongs to current user checkout; refusing."
old_ref = git(ORIGINAL, "rev-parse", TARGET).decode().strip()
expected = git(INTEGRATION, "rev-parse", "HEAD").decode().strip()
git(ORIGINAL, "fetch", "--no-tags", str(INTEGRATION), "codex/integrated-coverage:" + TARGET)
after = snapshot()
assert before == after, "User checkout changed during update; inspect without modifying it."
actual = git(ORIGINAL, "rev-parse", TARGET).decode().strip()
assert actual == expected
record = dict(previous_integration_ref=old_ref, integration_ref=actual,
              user_checkout_preserved=True,
              before_after_sha256={k: hashlib.sha256(v).hexdigest() for k, v in before.items()})
(ROOT / (sys.argv[1] if len(sys.argv)>1 else "wave10-final-integration.json")).write_text(json.dumps(record, indent=2) + "\n", encoding="utf8")
print(f"Updated local integration ref to {actual[:12]}; original HEAD, branch, working changes and index unchanged.")
