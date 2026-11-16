"""Single-file correctness probe, permitted alongside acceptance timing."""
from pathlib import Path
import json,os,runpy

def test_handler_compile_precondition_and_cached_selection():
 r=Path(__file__).resolve().parents[2]
 runpy.run_path(str(r/'inplace/s46_compile_probe.py'),run_name='__main__')
 data=json.loads((r/'inplace/correctness'/os.environ['WAVE16_CORRECTNESS_LABEL']/'data.json').read_text())
 assert data['complete']
 assert all(row['result_equal'] and row['arguments_equal'] for row in data['normal_calls'])
