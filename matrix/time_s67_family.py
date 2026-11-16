"""One short locked CPython/plain-parent/native-family comparison."""
import ast,datetime,importlib,importlib.util,json,os,sys,timeit
from pathlib import Path
import psutil
CLONE=Path(__file__).resolve().parents[1];ROOT=CLONE.parent
sys.path.insert(0,str(CLONE/'src'))
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
from recompyler._functions import FunctionRegion
from recompyler._visitors import VisitorRegion
from recompyler.managed import lift_managed
spec=importlib.util.spec_from_file_location('s67_family_timing',CLONE/'tests/test_visitor_family.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
L=importlib.import_module('recompyler.lift')
node=ast.parse('def f(a):\n x=[value for value in a]\n for left,right in a:\n  found=left\n return found\n').body[0]
tree=ast.parse('left+right+last')
cases=[('lift._local_names',L._local_names,(node,)),('closure_in_loop',m.closure_in_loop,(list(range(32)),)),('ast_walk_loop',m.ast_walk_loop,(tree,)),('two_helpers',m.two_helpers,(list(range(32)),)),('list_recursion',m.list_recursion,([[1,[2]],3,[]],)),('captured_list_counter',m.captured_list_counter,(tree,))]
ready=[]
for name,fn,args in cases:
    baseline=FunctionRegion(fn);native=lift_managed(fn)
    assert baseline.run is not None,baseline.problem
    expected=fn(*args)
    assert baseline(*args)==expected and native(*args)==expected
    assert baseline.compiled_calls==native.compiled_calls==1 and baseline.fallback_calls==native.fallback_calls==0
    profiled=VisitorRegion(fn,call_kinds=True)
    if profiled.run is None:profiled=FunctionRegion(fn,call_kinds=True)
    assert profiled(*args)==expected and profiled.compiled_calls==1 and profiled.fallback_calls==0
    ready.append((name,fn,args,baseline,native,profiled))
print('READY',flush=True)
if '--prepare-only' in sys.argv:raise SystemExit(0)
lock=ROOT/'TIMING.lock';token='wave17-matrix-s67-family-'+str(os.getpid())
try:lock.mkdir()
except FileExistsError:
    print('BUSY '+(lock/'owner.txt').read_text(encoding='utf-8-sig'),flush=True);raise SystemExit(75)
now=lambda:datetime.datetime.now().astimezone().isoformat()
owner=lock/'owner.txt'
owner.write_text(token+'\nrun: wave17-matrix\npid: '+str(os.getpid())+'\nclass: development\npurpose: short six-family CPython/plain-parent/native ratio\nstart: '+now()+'\nexpected: 20seconds\n',encoding='utf-8')
ledger=ROOT/'WAVE17-MATRIX-PLAN.md'
def record(line):
    with ledger.open('a',encoding='utf-8') as f:f.write(line+'\n')
record('TIMING-ACQUIRE S67: '+token+' at '+now()+'; short six-family comparison, development, correctness may overlap.')
def workloads():
    result=[]
    for process in psutil.process_iter(['pid','name','cmdline']):
        try:
            info=process.info;name=(info['name'] or '').lower();command=' '.join(info['cmdline'] or [])
            if info['pid']!=os.getpid() and ('python' in name or 'pytest' in name) and str(ROOT).lower() in command.lower():result.append(dict(pid=info['pid'],command=command))
        except (psutil.NoSuchProcess,psutil.AccessDenied):pass
    return result
try:
    load_before=workloads();rows=[]
    for name,fn,args,baseline,native,profiled in ready:
        seconds=[]
        for callable_,number in ((fn,1500),(baseline,60),(native,60)):
            seconds.append(min(timeit.repeat(lambda:callable_(*args),number=number,repeat=3))/number)
        plain,parent,child=seconds
        rows.append(dict(helper=name,cpython_us=plain*1e6,parent_us=parent*1e6,native_us=child*1e6,native_over_cpython=child/plain,native_over_parent=child/parent,managed_per_entry=profiled.managed_calls,dispatch_per_entry=profiled.managed_dispatch_calls,managed_kinds=profiled.managed_call_counts,dispatch_kinds=profiled.managed_dispatch_counts,native_children=getattr(profiled,'native_helper_calls',0),whole_fallback=profiled.fallback_calls))
    print(json.dumps(dict(rows=rows,other_work_before=load_before,other_work_after=workloads())),flush=True)
finally:
    if owner.read_text(encoding='utf-8').splitlines()[0]!=token:raise RuntimeError('timing owner changed')
    owner.unlink();lock.rmdir();record('TIMING-RELEASE S67: '+token+' at '+now()+'.')
