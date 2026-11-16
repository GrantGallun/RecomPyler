"""Explicit development injection of sibling providers; never acceptance evidence."""
from pathlib import Path
import sys
import runpy
runpy.run_path(str(Path(__file__).with_name('s61_development_provider.py')))
import pytest
raise SystemExit(pytest.main(sys.argv[1:]))
