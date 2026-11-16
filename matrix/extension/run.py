from pathlib import Path
import copy,gc,hashlib,importlib,json,statistics,sys,time,traceback,weakref
R=Path(__file__).resolve().parents[2];D=Path(__file__).resolve().parent
sys.path[:0]=[str(D),str(R/'matrix/direct_calls'),str(R/'src')]
import run_c as fixtures
from numba import njit
from recompyler._pycc import CC
import managed as m

def gates(fn):
    original=fixtures.cases[0][1];G=fixtures.chaos['GVector']
    tests=[(G(1.25,-0.,3.5),),(G(float('inf'),float('nan'),-0.),),(object(),),(G('bad',1,2),)]
    observations=[]
    for i,args in enumerate(tests):
        print('GATE',i,flush=True)
        reference=fixtures.observe(original,copy.deepcopy(args));actual=fixtures.observe(fn,copy.deepcopy(args))
        same=fixtures.snapshot(reference)==fixtures.snapshot(actual);observations.append({'identical':same,'reference':repr(reference),'compiled':repr(actual)});assert same
    held=(G(1.,2.,3.),)
    reference_output=original(*held);compiled_output=fn(*held)
    reference_count=sys.getrefcount(reference_output);compiled_count=sys.getrefcount(compiled_output)
    print('OUTPUT REFS',reference_count,compiled_count,flush=True)
    assert reference_output==compiled_output and reference_count==compiled_count,('output refs',reference_count,compiled_count)
    del reference_output,compiled_output
    for args in (held,tests[-1],tests[2]):
        before=[sys.getrefcount(a) for a in args]
        for _ in range(10000):
            try:fn(*args)
            except Exception:pass
        after=[sys.getrefcount(a) for a in args];assert before==after,(before,after)
    events=[]
    class Witness:
        def __del__(self):events.append('released')
    owner=G(1.,2.,3.);owner.witness=Witness();ref=weakref.ref(owner);fn(owner);del owner;gc.collect();assert ref() is None and events==['released']
    events.clear()
    class BadFloat:
        def __float__(self):
            child=Witness();raise ValueError('owned conversion failure')
    owner=G(BadFloat(),2.,3.)
    expected=fixtures.observe(original,(owner,));expected_events=list(events);events.clear();actual=fixtures.observe(fn,(owner,));assert expected[1]==actual[1] and events==expected_events==['released']
    class Operand:
        def __init__(self,name):self.name=name
        def __del__(self):events.append('del-'+self.name)
    class LateError:
        @property
        def x(self):return Operand('x')
        @property
        def y(self):return Operand('y')
        @property
        def z(self):raise ValueError('z failed')
    events.clear();reference=fixtures.observe(original,(LateError(),));reference_events=list(events);events.clear();actual=fixtures.observe(fn,(LateError(),));actual_events=list(events)
    assert reference[1]==actual[1] and reference_events==actual_events,('operand unwind',reference_events,actual_events)
    return {'operand_unwind_events':actual_events,'behavior':observations,'input_success_error_refcounts_stable':True,'owned_child_and_exception_finalizers_identical':True}

def main():
    report={}
    sys.path.insert(0,str(D/'vendor'))
    try:import numba_passthru;report['unchanged_upstream_import']='succeeded'
    except Exception as exc:report['unchanged_upstream_import']={'type':type(exc).__name__,'message':str(exc)}
    try:
        compiled=njit(m.managed(m.managed))(m.string_build)
        entry=next(iter(compiled.overloads.values())).entry_point
        report['nopython_signatures']=[str(s) for s in compiled.nopython_signatures]
        (D/'managed-string.ll').write_text(compiled.inspect_llvm(compiled.signatures[0]))
        report['jit']=gates(entry)
        cc=CC('wave17_managed');cc.output_dir=str(R/'matrix/temp/managed');Path(cc.output_dir).mkdir(exist_ok=True)
        cc.export('string_build',m.managed(m.managed))(m.string_build);cc.compile()
        sys.path.insert(0,cc.output_dir);aot=importlib.import_module('wave17_managed')
        report['aot']=gates(aot.string_build)
        artifact=Path(aot.__file__);report['artifact']={'path':str(artifact.relative_to(R)),'sha256':hashlib.sha256(artifact.read_bytes()).hexdigest()}
        import subprocess
        fresh=subprocess.run([sys.executable,'-B',str(D/'fresh_aot.py'),str(artifact)],capture_output=True,text=True)
        report['fresh_aot_process']={'exit_code':fresh.returncode,'stdout':fresh.stdout,'stderr':fresh.stderr};assert fresh.returncode==0,report['fresh_aot_process']
        samples={'cpython':[],'extension_jit_entry':[],'extension_aot':[]}
        n=20000
        for rep in range(3):
            order=[('cpython',fixtures.cases[0][1]),('extension_jit_entry',entry),('extension_aot',aot.string_build)]
            if rep%2:order.reverse()
            for key,fn in order:
                args=fixtures.cases[0][3]();start=time.perf_counter_ns()
                for _ in range(n):fn(*args)
                samples[key].append((time.perf_counter_ns()-start)/n)
        report['complete_call_ns']=samples;report['median_ns']={k:statistics.median(v) for k,v in samples.items()}
    except Exception as exc:report['error']={'type':type(exc).__name__,'message':str(exc),'traceback':traceback.format_exc()}
    report['source_hashes']={str(p.relative_to(R)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [D/'managed.py',Path(__file__),D/'vendor/numba_passthru/numba_passthru.py']}
    print(json.dumps(report),flush=True);(D/'results.json').write_text(json.dumps(report,indent=2))
    return 1 if 'error' in report else 0
if __name__=='__main__':sys.exit(main())
