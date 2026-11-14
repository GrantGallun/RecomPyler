"""Import-path/native-extension preflight. Requires the coordinator's test slot."""
import hashlib
import importlib
import json
from pathlib import Path
import sys


def main():
    source = Path(sys.argv[1]).resolve()
    report = {"source": str(source), "python": sys.executable, "extensions": {}}
    for name in ("_heap", "_monitor"):
        module = importlib.import_module("recompyler." + name)
        path = Path(module.__file__).resolve()
        if source / "src" not in path.parents:
            raise RuntimeError(f"Wrong native extension imported: {path}")
        report["extensions"][name] = {"path": str(path), "sha256": hashlib.sha256(path.read_bytes()).hexdigest()}
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
