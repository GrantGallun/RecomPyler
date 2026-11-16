from pathlib import Path
import ast,copy,gc,hashlib,inspect,json,random,statistics,struct,sys,time,traceback,weakref
R=Path(__file__).resolve().parents[2];sys.path[:0]=[str(R/'src'),str(Path(__file__).resolve().parent)]
import prototype as p
from numba import jit,njit,types
from recompyler._pycc import CC
from recompyler.lift import lift,Unsupported
D=R/'matrix/direct_calls';T=R/'matrix/temp/direct_calls';T.mkdir(exist_ok=True)
INPUTS=R.parent/'wave14-capture/capture/inputs'
def selected(program,names,prelude):
    path=INPUTS/program/'run_benchmark.py';tree=ast.parse(path.read_text());tree.body=[n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id in names for t in n.targets)]
    ns={'__name__':'direct_fixture_'+program,'__file__':str(path)};exec(prelude,ns);exec(compile(tree,str(path),'exec'),ns);return ns
chaos=selected('chaos',{'GVector'},'import math')
jsonloads=selected('json_loads',{'DICT','mutate_dict'},'import sys')
mdp=selected('mdp',{'stats_t','NOMODS','fixeddata_t','halfstate_t','applyHPChange'},'import collections')
fixed=mdp['fixeddata_t'](63,mdp['stats_t'](39,34,46,38),26,(1,0,0,0),65)
hstate=mdp['halfstate_t'](fixed,63,0,mdp['NOMODS'],mdp['stats_t'](39,34,46,38))
cases=[('chaos.GVector.__str__',chaos['GVector'].__str__,p.string_build,lambda:(chaos['GVector'](1.25,-0.,3.5),),20000),('json_loads.mutate_dict',jsonloads['mutate_dict'],p.dict_loop,lambda:(dict(jsonloads['DICT']),random.Random(5)),500),('mdp.applyHPChange',mdp['applyHPChange'],p.mixed_calls,lambda:(hstate,-17),20000)]

class FailingRandom:
    def __init__(self):self.calls=0;self.events=[]
    def random(self):
        self.calls+=1;self.events.append(self.calls)
        if self.calls==2:raise ValueError('mid-loop random failure')
        return .5

def snapshot(value):
    kind=type(value)
    if kind is float:return ['float',struct.pack('!d',value).hex()]
    if kind in (int,str,bytes,bool,type(None)):return [kind.__name__,repr(value)]
    if isinstance(value,tuple):return [kind.__module__,kind.__qualname__,[snapshot(v) for v in value]]
    if kind is list:return ['list',[snapshot(v) for v in value]]
    if kind is dict:return ['dict',[[snapshot(k),snapshot(v)] for k,v in value.items()]]
    if hasattr(value,'__dict__'):return [kind.__module__,kind.__qualname__,snapshot(vars(value))]
    return [kind.__module__,kind.__qualname__]

def observe(fn,args):
    try:result=fn(*args);error=None
    except Exception as exc:result=None;error=[type(exc).__module__,type(exc).__qualname__,str(exc)]
    state=[]
    for a in args:
        if isinstance(a,random.Random):state.append(a.getstate())
        elif type(a) is dict:state.append(list(a.items()))
        elif hasattr(a,'__dict__'):state.append(vars(a).copy())
        else:state.append(a)
    return result,error,state

def main():
    sys.path.insert(0,str(R/'matrix/temp/s34'))
    import wave17_s34 as ext
    for case in cases:copy.deepcopy(case[3]())
    ext.configure(tuple(c[1] for c in cases),chaos['GVector'],random.Random,mdp['halfstate_t'],mdp['fixeddata_t'])
    results=[]
    for label,original,proto,recipe,n in cases:
        row={'function':label,'prototype_source':inspect.getsource(proto),'body_has_interpreter_loop':False,'loop_lifting':False,'repetitions_per_sample':n}
        args=recipe()
        try:
            native=lift(original);native(*args);row['current_product']={'compiled':native.compiled_calls,'fallback':native.fallback_calls,'reason':native.problem}
        except Unsupported as exc:row['current_product']={'compiled':0,'reason':str(exc)}
        signature=types.pyobject(*([types.pyobject]*len(args)))
        try:
            strict=njit(signature)(proto)
            row['unchanged_nopython']='compiled'
        except Exception as exc:
            row['unchanged_nopython']={'type':type(exc).__name__,'message':str(exc)}
        try:
            compile_start=time.perf_counter()
            dispatcher=jit(signature,forceobj=True,looplift=False)(proto)
            row['object_mode_compile_s']=time.perf_counter()-compile_start
            assert all(c.objectmode for c in dispatcher.overloads.values())
            object_entry=next(iter(dispatcher.overloads.values())).entry_point
            compiled=getattr(ext,proto.__name__)
            row['direct_entry_type']=type(compiled).__name__
            row['object_mode_jit']='compiled'
            tests=[recipe()]
            if label.startswith('chaos'):
                tests.extend([(chaos['GVector'](float('inf'),float('nan'),-0.),),(object(),),(chaos['GVector']('bad',1,2),)])
            elif label.startswith('json'):
                tests.extend([({1:2,False:3,(1,2):4},random.Random(5)),(None,random.Random(5)),({'a':1,'b':2},FailingRandom()),({'a':1,b'b':2},random.Random(5))])
            else:tests.extend([(hstate,10**100),(hstate,-10**100),(hstate,'bad'),(object(),3)])
            row['behavior_gates']=[]
            for test in tests:
                reference=observe(original,copy.deepcopy(test));candidate=observe(compiled,copy.deepcopy(test))
                # NaNs compare by stable repr within these inert fixture values.
                equal=snapshot(reference)==snapshot(candidate)
                row['behavior_gates'].append({'identical':equal,'reference':repr(reference),'compiled':repr(candidate)})
                assert equal,(label,reference,candidate)
            held=recipe();result=compiled(*held)
            if label.startswith('mdp'):
                assert type(result) is type(held[0]) and result is not held[0]
                assert result.fixed is held[0].fixed and result.statmods is held[0].statmods and result.stats is held[0].stats
                assert held[0].hp==63
                row['result_field_identity_and_input_unchanged']=True
            elif label.startswith('json'):
                assert type(result) is dict and result is not held[0] and list(result)==list(held[0])
                assert list(held[0].items())==list(jsonloads['DICT'].items())
                row['distinct_dict_original_keys_order_and_input_unchanged']=True
            del result
            llvm=dispatcher.inspect_llvm(dispatcher.signatures[0]);(D/(proto.__name__+'-c-cohort-objectmode.ll')).write_text(llvm)
            row['c_api_callsites']=[line.strip() for line in llvm.splitlines() if '@Py' in line and (' call ' in line or ' invoke ' in line)]
            row['c_api_symbols']=sorted({line.split('@')[1].split('(')[0] for line in llvm.splitlines() if '@Py' in line and line.lstrip().startswith('declare')})
            # Check ownership over 10,000 calls without retaining outputs.
            held=recipe();before=[sys.getrefcount(a) for a in held]
            for _ in range(10000):compiled(*held)
            after=[sys.getrefcount(a) for a in held];assert before==after,(label,before,after)
            row['input_refcounts_before_after']=[before,after]
            # The failing inputs exercise compiled cleanup after C-API NULL returns.
            bad=tests[-1]
            before=[sys.getrefcount(a) for a in bad]
            for _ in range(10000):
                try:compiled(*bad)
                except Exception:pass
            after=[sys.getrefcount(a) for a in bad];assert before==after,(label,'error cleanup',before,after)
            row['exception_refcounts_before_after']=[before,after]
            if label.startswith('json'):
                events=[]
                class Child:
                    def __del__(self):events.append('released')
                child=Child();ref=weakref.ref(child);owner_dict={(1,2):child};new=compiled(owner_dict,random.Random(5))
                assert new[(1,2)] is child
                del new,owner_dict,child;gc.collect();assert ref() is None and events==['released']
                row['dict_child_identity_and_release']=True
            if label.startswith('chaos'):
                events=[]
                class Witness:
                    def __del__(self):events.append('released')
                owner=chaos['GVector'](1.,2.,3.);owner.witness=Witness()
                ref=weakref.ref(owner);compiled(owner);del owner;gc.collect()
                assert ref() is None and events==['released'],(ref(),events)
                row['owned_input_and_child_released']=True
                events.clear()
                class FailingFloat:
                    def __float__(self):
                        child=Witness()
                        raise ValueError('owned conversion failure')
                owner=chaos['GVector'](FailingFloat(),2.,3.)
                expected=observe(cases[0][1],(owner,));expected_events=list(events);events.clear()
                actual=observe(compiled,(owner,));assert expected[1]==actual[1] and events==expected_events==['released']
                row['exception_child_finalizer_identical']=True
            row['c_counters_after_behavior']=ext.stats()
            samples={'cpython':[],'boxed_direct_entry':[],'handwritten_c':[]};route_samples=[]
            variants=[('cpython',original),('boxed_direct_entry',object_entry),('handwritten_c',compiled)]
            if '--with-managed' in sys.argv and label.startswith('chaos'):
                import importlib
                sys.path.insert(0,str(R/'matrix/temp/managed'))
                managed_aot=importlib.import_module('wave17_managed')
                variants.append(('extension_aot',managed_aot.string_build));samples['extension_aot']=[]
                row['extension_aot_sha256']=hashlib.sha256(Path(managed_aot.__file__).read_bytes()).hexdigest()
            
            for rep in range(3):
                for key,fn in (variants if rep%2==0 else list(reversed(variants))):
                    held=recipe();route_before=ext.stats();start=time.perf_counter_ns()
                    for _ in range(n):fn(*held)
                    samples[key].append((time.perf_counter_ns()-start)/n)
                    route_after=ext.stats();route_samples.append({'rep':rep,'variant':key,'calls':n,'delta':{k:[b-a for a,b in zip(route_before[k],route_after[k])] for k in route_before}})
            row['timing_route_counters']=route_samples;row['complete_call_ns']=samples;row['median_ns']={k:statistics.median(v) for k,v in samples.items()};row['speedup']=row['median_ns']['cpython']/row['median_ns']['handwritten_c']
        except Exception as exc:
            row['handwritten_c_gate_error']={'type':type(exc).__name__,'message':str(exc),'traceback':traceback.format_exc()}
        # Exercise the unchanged production AOT compiler with the same object signature.
        try:
            cc=CC('wave17_obj_'+proto.__name__);cc.output_dir=str(T/proto.__name__);Path(cc.output_dir).mkdir(exist_ok=True)
            cc.export('entry',signature)(proto);cc.compile();row['existing_aot']='compiled'
        except Exception as exc:row['existing_aot']={'type':type(exc).__name__,'message':str(exc),'traceback':traceback.format_exc()}
        results.append(row);print(json.dumps(row),flush=True)
        (D/'results-c.json').write_text(json.dumps(results,indent=2))
if __name__=='__main__':main()
