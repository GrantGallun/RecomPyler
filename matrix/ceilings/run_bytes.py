from pathlib import Path
import base64,hashlib,itertools,json,random,statistics,sys,time
R=Path(__file__).resolve().parents[2];D=Path(__file__).resolve().parent
sys.path[:0]=[str(R/'src'),str(R/'matrix'),str(R/'matrix/temp/ceilings')]
from run_matrix import exception
import wave17_ceiling_bytes as ext

def observed(fn,args):
    try:value=fn(*args)
    except Exception as exc:return {'error':exception(exc)}
    if type(value) is bytes:return {'type':'bytes','length':len(value),'sha256':hashlib.sha256(value).hexdigest()}
    return {'type':type(value).__name__,'value':repr(value)}

def main():
    label=sys.argv[1];report={'gates':[],'samples':[]};target=D/('bytes-'+label+'.json')
    entries={};aot=None
    if '--bridge' in sys.argv:
        from bridge import compile_bridges
        entries,dispatchers,aot=compile_bridges()
        for name,dispatcher in dispatchers.items():(D/('bridge-'+name+'.ll')).write_text(dispatcher.inspect_llvm(dispatcher.signatures[0]))
        report['bridge_artifact']={'path':str(Path(aot.__file__).relative_to(R)),'sha256':hashlib.sha256(Path(aot.__file__).read_bytes()).hexdigest()}
        import subprocess
        child=subprocess.run([sys.executable,'-B',str(D/'fresh_bridge.py'),str(Path(aot.__file__).parent),str(R/'matrix/temp/ceilings')],capture_output=True,text=True)
        report['fresh_aot_process']={'exit_code':child.returncode,'stdout':child.stdout,'stderr':child.stderr};assert child.returncode==0,report['fresh_aot_process']
        
    def variants(boxed,borrowed):
        out=[('boxed-C',boxed),('borrowed-C',borrowed)]
        if entries:out.extend([('boxed-njit',entries[boxed.__name__]),('borrowed-njit',entries[borrowed.__name__]),('boxed-AOT',getattr(aot,boxed.__name__)),('borrowed-AOT',getattr(aot,borrowed.__name__))])
        return out
    
    def gate(name,original,boxed,borrowed,args):
        ref=observed(original,args)
        for kind,fn in variants(boxed,borrowed):
            got=observed(fn,args);row={'case':name,'variant':kind,'identical':got==ref,'reference':ref,'compiled':got}
            report['gates'].append(row)
            if got!=ref:print('MISMATCH',json.dumps(row),flush=True)
    rng=random.Random(12345);data={n:rng.randbytes(n) for n in [20,127,3072,9000,102400,1048574]}
    base64.a85encode(b'');base64.b85encode(b'');base64.b32decode(b'')
    alph=base64._b32alphabet
    for n in list(range(33))+[127,3072,9000,102400,1048574]:
        raw=data.get(n,bytes((i*37)%256 for i in range(n)))
        a=base64.a85encode(raw);b=base64.b32encode(raw)
        gate('a85-valid-'+str(n),base64.a85decode,ext.a85_boxed,ext.a85_borrowed,(a,))
        gate('b32-valid-'+str(n),base64._b32decode,ext.b32_boxed,ext.b32_borrowed,(alph,b))
        for name,chars,chars2,fold in [('a85',base64._a85chars,base64._a85chars2,True),('b85',base64._b85chars,base64._b85chars2,False)]:
            gate('encode-'+name+'-'+str(n),base64._85encode,ext.encode_boxed,ext.encode_borrowed,(raw,chars,chars2,False,fold,False))
    for value in [b'',b'z',b'zz',b'!z',b'uuuuu',b'~~~~~',b'y',b'! \t\r\n\v',b'!!!!',b'!!!!!',b'!\xff',b'\x00','!!','\u03a9',memoryview(b'!!!!!'),bytearray(b'!!!!!'),123]:
        gate('a85-boundary-'+repr(value),base64.a85decode,ext.a85_boxed,ext.a85_borrowed,(value,))
    for value in [b'',b'AA======',b'AAA=====',b'AAAA====',b'AAAAA===',b'AAAAAA==',b'AAAAAAA=',b'AAAAAAAA',b'!AA=====',b'====!===',b'========',b'AAAA','AA======','\u03a9',memoryview(b'AA======'),bytearray(b'AA======'),123]:
        gate('b32-boundary-'+repr(value),base64._b32decode,ext.b32_boxed,ext.b32_borrowed,(alph,value))
    for raw in [b'',b'\0',b'\0\0',b'\0\0\0',b'\0'*4,b' '*4,b' '*8,b' '*5,b'abcde']:
        for flags in itertools.product((False,True),repeat=3):
            gate('encode-flags-'+repr(raw)+str(flags),base64._85encode,ext.encode_boxed,ext.encode_borrowed,(raw,base64._a85chars,base64._a85chars2,*flags))
    chars=list(base64._a85chars);chars2=list(base64._a85chars2);chars2[0]=b'XY'
    gate('encode-noncanonical-partial-zero',base64._85encode,ext.encode_boxed,ext.encode_borrowed,(b'\0',chars,chars2,False,True,False))
    events=[]
    class Part:
        def __add__(self,other):events.append('add');return Part()
        def __eq__(self,other):events.append('eq');return False
        def __len__(self):events.append('len');return 5
        def __getitem__(self,item):events.append(['slice',item.start,item.stop,item.step]);return b'!!'
    class Table:
        def __init__(self,name):self.name=name
        def __getitem__(self,index):events.append([self.name,index]);return Part()
    args=(b'\\0',Table('chars'),Table('chars2'),False,False,False)
    events.clear();ref=observed(base64._85encode,args);reference_events=list(events)
    for kind,fn in variants(ext.encode_boxed,ext.encode_borrowed):
        events.clear();got=observed(fn,args);got_events=list(events)
        row={'case':'encode-effectful-table-tail','variant':kind,'identical':ref==got and reference_events==got_events,'reference':ref,'compiled':got,'reference_events':reference_events,'compiled_events':got_events};report['gates'].append(row)
        if not row['identical']:print('MISMATCH',json.dumps(row),flush=True)
    from mutations import gates as mutation_gates
    report['gates'].extend(mutation_gates(variants))
    for row in report['gates']:
        if not row['identical']:print('MISMATCH',json.dumps(row),flush=True)
    target.write_text(json.dumps(report,indent=2))
    if any(not r['identical'] for r in report['gates']):return 1
    for fn,args in [(ext.a85_boxed,(base64.a85encode(data[20]),)),(ext.a85_borrowed,(base64.a85encode(data[20]),)),(ext.b32_boxed,(alph,base64.b32encode(data[20]))),(ext.b32_borrowed,(alph,base64.b32encode(data[20]))),(ext.encode_boxed,(data[20],base64._a85chars,base64._a85chars2,False,True,False)),(ext.encode_borrowed,(data[20],base64._a85chars,base64._a85chars2,False,True,False))]:
        before=[sys.getrefcount(a) for a in args]
        for _ in range(1000):fn(*args)
        after=[sys.getrefcount(a) for a in args];assert before==after,(fn.__name__,before,after)
    report['success_refcounts_stable']=True
    report['ownership_gates']=[]
    for original,boxed,borrowed,good,bad in [
        (base64.a85decode,ext.a85_boxed,ext.a85_borrowed,(base64.a85encode(data[20]),),(b'uuuuu',)),
        (base64._b32decode,ext.b32_boxed,ext.b32_borrowed,(alph,base64.b32encode(data[20])),(alph,b'!AA=====')),
        (base64._85encode,ext.encode_boxed,ext.encode_borrowed,(data[20],base64._a85chars,base64._a85chars2,False,True,False),(b'a',[],[],False,False,False))]:
        for key,fn in variants(boxed,borrowed):
            for args in [good,bad]:
                observed(fn,args);before=[sys.getrefcount(a) for a in args]
                for _ in range(1000):
                    try:fn(*args)
                    except Exception:pass
                after=[sys.getrefcount(a) for a in args];assert before==after,(key,before,after)
            ref=original(*good);got=fn(*good);ref_count=sys.getrefcount(ref);got_count=sys.getrefcount(got);assert ref==got and ref_count==got_count,(key,'output refs',ref_count,got_count)
            report['ownership_gates'].append({'variant':key,'function':boxed.__name__,'input_success_error_refs_stable':True,'output_refs':[ref_count,got_count]})
            del ref,got
    
    function_cases=[('a85decode',base64.a85decode,ext.a85_boxed,ext.a85_borrowed),('_b32decode',base64._b32decode,ext.b32_boxed,ext.b32_borrowed),('_85encode-a85',base64._85encode,ext.encode_boxed,ext.encode_borrowed),('_85encode-b85',base64._85encode,ext.encode_boxed,ext.encode_borrowed)]
    for name,original,boxed,borrowed in function_cases:
        for n in [20,127,3072,9000,102400,1048574]:
            raw=data[n]
            args=(base64.a85encode(raw),) if name=='a85decode' else (alph,base64.b32encode(raw)) if name=='_b32decode' else (raw,base64._a85chars,base64._a85chars2,False,True,False) if name.endswith('a85') else (raw,base64._b85chars,base64._b85chars2,False,False,False)
            repetitions={20:1000,127:200,3072:10,9000:5,102400:2,1048574:1}[n];all_variants=[('cpython',original),*variants(boxed,borrowed)];samples={key:[] for key,fn in all_variants};route_samples=[]
            for rep in range(3):
                order=list(all_variants)
                if rep%2:order.reverse()
                for key,fn in order:
                    route_before=ext.stats();start=time.perf_counter_ns()
                    for _ in range(repetitions):fn(*args)
                    samples[key].append((time.perf_counter_ns()-start)/repetitions)
                    route_after=ext.stats()
                    route_key='a85decode' if name=='a85decode' else 'b32decode' if name=='_b32decode' else 'encode85'
                    if key.startswith('borrowed-'):assert route_after[route_key][0]-route_before[route_key][0]==repetitions,(name,key,'not native')
                    assert all(route_after[k][1]==route_before[k][1] for k in route_before),(name,key,'timed fallback')
                    route_samples.append({'rep':rep,'variant':key,'calls':repetitions,'delta':{k:[b-a for a,b in zip(route_before[k],route_after[k])] for k in route_before}})
            row={'function':name,'input_bytes':n,'route_counters':route_samples,'repetitions':repetitions,'complete_call_ns':samples,'median_ns':{key:statistics.median(v) for key,v in samples.items()}}
            report['samples'].append(row);target.write_text(json.dumps(report,indent=2));print(json.dumps(row),flush=True)
    report['source_hashes']={(str(p.relative_to(R)) if p.is_relative_to(R) else str(p)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [Path(__file__),D/'bytes.c',D/'encode85.inc',D/'context.inc',D/'bridge.py',D/'fresh_bridge.py',D/'mutations.py',Path(base64.__file__)]}
    report['helper_artifact']={'path':str(Path(ext.__file__).relative_to(R)),'sha256':hashlib.sha256(Path(ext.__file__).read_bytes()).hexdigest()}
    report['complete']=True;target.write_text(json.dumps(report,indent=2));print('COMPLETE',len(report['gates']),flush=True);return 0
if __name__=='__main__':sys.exit(main())
