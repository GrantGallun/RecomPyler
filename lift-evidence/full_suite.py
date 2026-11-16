"""Compatibility launcher for the versioned warm correctness runner."""
import runpy
from pathlib import Path
import sys
root=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(root/'tools'))
runpy.run_path(str(root/'tools'/'full_suite.py'),run_name='__main__')
