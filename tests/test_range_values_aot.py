"""Actual heap-region verification, prepared artifact and fresh AOT reload."""
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
from recompyler import heap, profiler
from recompyler.monitor import CallMonitor

SOURCE = Path(__file__).resolve()

def range_consume(r):
    d = {0: 0}
    for i in r:
        d[0] += i
    return d

def range_repeated(r):
    d = {0: 0}
    for i in r:
        d[0] += i
    for i in r:
        d[0] += i
    return d

def range_make(n):
    return range(n)

def range_argument(n):
    r = range(n)
    return range_consume(r)

def range_internal(n):
    r = range_make(n)
    return range_consume(r)

def test_range_values_verified_build_and_fresh_prepared_aot(tmp_path):
    recipes = [(range_consume, (range(3),)), (range_repeated, (range(3),)),
               (range_argument, (6,)), (range_internal, (6,))]
    entries = []
    for fn, args in recipes:
        with CallMonitor([SOURCE], 2, profiler.snapshot, backend='python', bias=0, yield_bias=0) as monitor:
            fn(*args)
        key = (str(SOURCE), fn.__qualname__, fn.__code__.co_firstlineno)
        candidate = profiler.test_candidate(fn, monitor.samplers[key].samples, 1, extra=())
        assert candidate['status'] == 'verified', candidate
        assert candidate['engine'] == 'region', candidate
        region = candidate['_region']
        assert region.compiled_calls > 0
        entries.append(((fn.__qualname__, fn.__code__.co_firstlineno), fn, region))
    section = heap.build_regions(entries, tmp_path)
    assert section and len(section['functions']) == 4 and section.get('prepared')
    child = '''import importlib.util,json,sys
from pathlib import Path
from recompyler import heap, _prepared as pc
source=Path(sys.argv[1]);spec=importlib.util.spec_from_file_location('range_aot_functions',source)
functions=importlib.util.module_from_spec(spec);sys.modules[spec.name]=functions;spec.loader.exec_module(functions)
section=json.loads(Path(sys.argv[2]).read_text());snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}}
assert 'numba' not in sys.modules
for entry in section['functions']:
 fn=getattr(functions,entry['qualname'])
 index=pc.open_index(section,entry,plan_snapshot=snapshot)
 assert index is not None,pc.last_miss()
 wrapped=heap.lift_region(fn,index.exports,prepared=index)
 args=(range(9,1,-2),) if entry['qualname'] in {'range_consume','range_repeated'} else (9,)
 got=wrapped(*args);want=fn(*args)
 assert type(got) is type(want) and got==want
 assert wrapped.prepared_hits>=1 and wrapped.aot_calls==wrapped.compiled_calls==1 and wrapped.jit_calls==0, (wrapped.problem,wrapped.prepared_reasons)
 if entry['qualname'] in {'range_consume','range_repeated'}:
  assert wrapped(range(2**100,0))=={0:0}
  assert wrapped.fallback_calls==1
assert 'numba' not in sys.modules
print('heap range fresh prepared AOT verified')
'''
    section_file = tmp_path / 'range-section.json'
    section_file.write_text(json.dumps(section))
    done = subprocess.run([sys.executable, '-c', child, str(SOURCE), str(section_file)],
                          capture_output=True, text=True, env=os.environ.copy(), timeout=180)
    assert done.returncode == 0, (done.stdout, done.stderr)
    assert 'heap range fresh prepared AOT verified' in done.stdout
