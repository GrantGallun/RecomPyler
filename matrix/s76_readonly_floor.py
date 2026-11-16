"""M0.5 diagnostic. Timings require the externally acquired exact owner token."""
import os
os.environ['NUMBA_NRT_STATS']='1'
import argparse,inspect,json,statistics,subprocess,sys,textwrap,timeit,types
from pathlib import Path
import psutil
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
from numba.core.runtime import rtsys
from recompyler import heap,_structure_ops_native,_source_frames_native as provider
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import create_callable
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls,select_structure_calls
options=argparse.ArgumentParser();options.add_argument('--prepare-only',action='store_true');options.add_argument('--token');options=options.parse_args()
root=Path(__file__).resolve().parents[2]
entries={};plain={};cases={};allocations={}
for name,function in [('find',heap._find),('canon',heap._Program.canon)]:
 plain[name]=heap.lift_structures(function)
 assert plain[name].run is not None,plain[name].problem
 entries[name]={}
 for lane in ['generic','selected','readonly']:
  graph=build(function);calls=None
  if lane!='generic':
   graph=select_structure_calls(graph,{'load_attr','contains','getitem'})
   calls=StructureCalls(CPythonSymbols(),_structure_ops_native)
  code=lower(graph,structure_calls=calls,readonly_loops=lane=='readonly')
  entries[name][lane]=create_callable(function,code.body_address,code.keepalive,runner_address=provider.addresses()['run_vectorcall'])
for depth in [0,4]:
 leaf=last=heap._Cell()
 for _ in range(depth):
  parent=heap._Cell();last.parent=parent;last=parent
 keys=[type('Key'+str(i),(),{}) for i in range(depth+1)]
 program=object.__new__(heap._Program);program.alias=dict(zip(keys,keys[1:]))
 for name,original,args,target in [('find',heap._find,(leaf,),last),('canon',heap._Program.canon,(program,keys[0]),keys[-1])]:
  functions={'cpython':original,'plain_parent':plain[name],**entries[name]}
  label=name+'_'+str(depth);cases[label]=(functions,args,target)
  for fn in functions.values():assert fn(*args) is target
  for _ in range(2000):original(*args)
  allocations[label]={}
  for lane,fn in functions.items():
   before=rtsys.get_allocation_stats();value=fn(*args);after=rtsys.get_allocation_stats()
   assert value is target;allocations[label][lane]=after.alloc-before.alloc
assert all(fn.fallback_calls==0 for fn in plain.values())
print('PREPARED_ALL_LANES',flush=True)
if options.prepare_only:raise SystemExit(0)
# No measured program cohort can start without the exact externally owned lock.
assert options.token,'timing token required'
owner=(root/'TIMING.lock/owner.txt').read_text()
assert 'run: wave17-matrix\n' in owner and 'token: '+options.token+'\n' in owner,owner
samples={}
for label,(functions,args,target) in cases.items():
 samples[label]={name:[] for name in functions}
 for pair in range(3):
  order=list(functions) if pair%2==0 else list(reversed(functions))
  for lane in order:
   fn=functions[lane];repetitions=3000 if lane=='plain_parent' else 100000
   samples[label][lane].append(timeit.timeit(lambda:fn(*args),number=repetitions)/repetitions*1e9)
pypy_source='import timeit,json,statistics,types\nBOTTOM=object()\n'+inspect.getsource(heap._Cell)+'\n'+inspect.getsource(heap._find)+'\n'+textwrap.dedent(inspect.getsource(heap._Program.canon))+'''
class Program:pass
cases={}
for depth in [0,4]:
 leaf=last=_Cell()
 for _ in range(depth):
  parent=_Cell();last.parent=parent;last=parent
 keys=[type('Key'+str(i),(),{}) for i in range(depth+1)]
 owner=Program();owner.alias=dict(zip(keys,keys[1:]))
 cases['find_'+str(depth)]=(_find,(leaf,),last)
 cases['canon_'+str(depth)]=(canon,(owner,keys[0]),keys[-1])
result={}
for label,(function,args,target) in cases.items():
 assert function(*args) is target
 for _ in range(2000000):function(*args)
 values=[timeit.timeit(lambda:function(*args),number=1000000)/1000000*1e9 for _ in range(3)]
 result[label]={'ns':statistics.median(values),'warmup_calls':2000000,'samples':values}
print(json.dumps(result))
'''
pypy=root/'pypy-compare/pypy-dist/pypy3.11-v8.0.1-win64/pypy3.exe'
child=subprocess.run([str(pypy),'-c',pypy_source],capture_output=True,text=True,check=True,creationflags=getattr(subprocess,'BELOW_NORMAL_PRIORITY_CLASS',0))
py_times=json.loads(child.stdout)
medians={label:{name:statistics.median(values) for name,values in lanes.items()} for label,lanes in samples.items()}
for label,values in medians.items():
 values['readonly_over_cpython']=values['readonly']/values['cpython'];values['readonly_over_pypy']=values['readonly']/py_times[label]['ns']
output={'ns_per_entry':medians,'pypy':py_times,'nrt_allocations_per_entry':allocations,'other_cpython_allocations_per_entry':'unmeasured','samples':samples,'public_admission':False,'known_unresolved':'general native CALL ownership, bound-self and caller-stack publication; readonly lane uses borrowed inputs','census_legacy_last_complete':[699,1827],'ir_census_compiled':0,'concurrent_correctness':True,'lock_token':options.token,'pairs':3}
Path('matrix/s76-readonly-floor-result.json').write_text(json.dumps(output,indent=2)+'\n');print(json.dumps(output,indent=2),flush=True)
