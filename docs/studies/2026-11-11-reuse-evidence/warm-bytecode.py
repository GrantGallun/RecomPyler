"""Compile Python source into task-owned pycache; never import workload code."""
import argparse
import compileall
from pathlib import Path
import py_compile
import re
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="+")
    args = parser.parse_args()
    if not sys.pycache_prefix:
        parser.error("A task-owned PYTHONPYCACHEPREFIX is required.")
    ok = True
    for text in args.paths:
        path = Path(text)
        options = dict(force=True, quiet=1, invalidation_mode=py_compile.PycInvalidationMode.CHECKED_HASH,
                       rx=re.compile(r"(?:^|[\\/])(?:\.venv|\.git|results|\.pytest_cache|__pycache__)(?:[\\/]|$)"))
        ok = (compileall.compile_dir(str(path), workers=1, **options) if path.is_dir()
              else compileall.compile_file(str(path), **options)) and ok
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
