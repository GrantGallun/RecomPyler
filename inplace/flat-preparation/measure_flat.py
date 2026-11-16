"""Three alternating warmed current-Lifted/flat pairs; unchanged benchmark bodies."""
import gc,json,statistics,struct,time
from array import array
from recompyler import lift
from recompyler._flat import FlatLifted,_shape,native
from target_support import spectral,fft
clock=time.perf_counter_ns

def prepare(ns,names,args):
    out={}
    for mode,factory in [('python',lambda f:f),('current',lift.Lifted),('flat',FlatLifted)]:
        out[mode]={}
        for name in names:
            fn=ns[name];wrapped=factory(fn)
            for values in args:
                call=tuple(array(v.typecode,v) if type(v) is array else v for v in values)
                wrapped(*call)
            if mode!='python':assert wrapped.compiled_calls and not wrapped.fallback_calls,(name,mode,wrapped.problem)
            out[mode][name]=wrapped
    return out

_NAMESPACES={}

def install(ns,names,selected):
    # runpy functions use their original globals, which are not necessarily
    # identical to runpy's returned dict.
    namespace=_NAMESPACES.get(id(ns))
    if namespace is None:
        namespace=ns[names[0]].__globals__
        _NAMESPACES[id(ns)]=namespace
    for name in names:namespace[name]=selected[name]

def counters(variants):
    return {m:{n:dict(native=w.compiled_calls,fallback=w.fallback_calls,flat=getattr(w,'flat_calls',None)) for n,w in rows.items()} for m,rows in variants.items() if m!='python'}

def complete(fn,args,repetitions):
    elapsed=0
    for _ in range(repetitions):
        call=tuple(array(v.typecode,v) if type(v) is array else v for v in args)
        begin=clock();fn(*call);elapsed+=clock()-begin
    return elapsed/repetitions/1000

def breakdown(w,args,repetitions):
    phases={k:0 for k in ('argument_shape','variant_lookup','holder','dispatch_guard_native_cleanup_box','audit_result_accounting')}
    for _ in range(repetitions):
        call=tuple(array(v.typecode,v) if type(v) is array else v for v in args)
        t=clock();full=w.base._complete(call);schema=_shape(full);u=clock();phases['argument_shape']+=u-t
        t=u;dispatcher,checks,code,graph=w._variants[schema];u=clock();phases['variant_lookup']+=u-t
        t=u;holder=native.make_call(w.original,code,checks,__import__('math').__dict__,full,schema);u=clock();phases['holder']+=u-t
        t=u;result=w._invoke(dispatcher,holder);u=clock();phases['dispatch_guard_native_cleanup_box']+=u-t
        t=u;audit=native.audit(holder);assert audit['commits']==1 and audit['active']==0;w.compiled_calls+=1;w.flat_calls+=1;u=clock();phases['audit_result_accounting']+=u-t
    return {k:v/repetitions/1000 for k,v in phases.items()}

spec=spectral();snames=['part_A_times_u','part_At_times_u']
sargs=[((64,[1]*130),),((64,[float(i)/130 for i in range(130)]),)]
sv=prepare(spec,snames,sargs)
kern=fft();knames=['FFT_transform','FFT_inverse'];kargs=[(2048,kern['Random'](7).RandomVector(2048))]
kv=prepare(kern,knames,kargs)
print('WARMED_JIT_DEVELOPMENT no AOT/default deployment claim; timers absent from complete/whole measurements; bulk undo retained',flush=True)
# Whole-program correctness: record every boundary result/input AFTER its call,
# off the measured runs. Python and both wrappers must agree for full20loops.
for label,ns,names,variants,bench_args in [('spectral_norm',spec,snames,sv,(20,)),('fft',kern,knames,kv,(20,1024,50))]:
    traces={}
    for mode in ('python','current','flat'):
        trace=[]
        def recorder(name,fn):
            def call(*args):
                result=fn(*args)
                payload=tuple(v.tobytes() for v in args if type(v) is array)
                trace.append((name,type(result).__name__,struct.pack('!d',result).hex() if type(result) is float else result,payload))
                return result
            return call
        install(ns,names,{name:recorder(name,variants[mode][name]) for name in names})
        ns['bench_spectral_norm' if label=='spectral_norm' else 'bench_FFT'](*bench_args)
        traces[mode]=trace
    assert traces['python']==traces['current']==traces['flat'],label
    print(json.dumps(dict(correctness=label,loops=20,boundary_calls=len(traces['flat']),exact_type_bits_postargs=True)),flush=True)
    del traces
# Baseline Python shown separately; current/candidate are alternating three pairs.
rows=[]
for label,ns,names,variants,bench_args in [('spectral_norm',spec,snames,sv,(20,)),('fft',kern,knames,kv,(20,1024,50))]:
    bench=ns['bench_spectral_norm' if label=='spectral_norm' else 'bench_FFT']
    install(ns,names,variants['python']);python_s=bench(*bench_args)
    for pair in range(3):
        for mode in (('current','flat') if pair%2==0 else ('flat','current')):
            install(ns,names,variants[mode]);seconds=bench(*bench_args)
            row=dict(target=label,pair=pair,mode=mode,loops=20,seconds=seconds,python_seconds=python_s)
            rows.append(row);print(json.dumps(row),flush=True)
    for name in names:
        args=sargs[1] if label=='spectral_norm' else kargs[0]
        repetitions=5000 if label=='spectral_norm' else 200
        for pair in range(3):
            for mode in (('current','flat') if pair%2==0 else ('flat','current')):
                us=complete(variants[mode][name],args,repetitions)
                print(json.dumps(dict(complete_call=name,pair=pair,mode=mode,us=us)),flush=True)
        print(json.dumps(dict(complete_call=name,mode='python',us=complete(variants['python'][name],args,repetitions))),flush=True)
        print(json.dumps(dict(components=name,us=breakdown(variants['flat'][name],args,1000),instrumented=True,envelope='includes C guard scan, buffer export/undo, native body, cleanup and result boxing; not isolated body')),flush=True)
def flat_first(values):
    return values[0]
control={mode:factory(flat_first) for mode,factory in [('python',lambda f:f),('current',lift.Lifted),('flat',FlatLifted)]}
for fn in control.values():assert fn([1.25])==1.25
for pair in range(3):
    for mode in (('current','flat') if pair%2==0 else ('flat','current')):
        print(json.dumps(dict(trivial_list_read=True,pair=pair,mode=mode,us=complete(control[mode],([1.25],),5000))),flush=True)
print(json.dumps(dict(trivial_list_read=True,mode='python',us=complete(control['python'],([1.25],),5000))),flush=True)
print(json.dumps(dict(final_counters=dict(spectral=counters(sv),fft=counters(kv)))),flush=True)
assert all(w.fallback_calls==0 for variants in (sv,kv) for mode in ('current','flat') for w in variants[mode].values())
print('PASS exact20loop traces; all timed public wrapper calls native; no fallback',flush=True)
