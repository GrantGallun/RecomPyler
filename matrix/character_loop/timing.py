"""One three-pair complete-wrapper ceiling on sealed, accepted behavior artifacts."""
import hashlib, importlib, importlib._bootstrap as bootstrap, json, os, shlex, statistics, sys, time
from pathlib import Path
D=Path(__file__).resolve().parent;R=D.parents[1];out=(R/'matrix/temp'/sys.argv[1]).resolve()
seal=json.loads((out/'complete.json').read_text());assert seal['complete']
def hashes():return {name:hashlib.sha256((out/name).read_bytes()).hexdigest() for name in seal['sha256']}
assert hashes()==seal['sha256']
source_hash=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
reference=json.loads((out/'behavior.json').read_text())['reference']
assert hashlib.sha256(Path(shlex.__file__).read_bytes()).hexdigest()==reference['sha256']
assert 'importtime' not in sys._xoptions and os.environ.get('PYTHONPROFILEIMPORTTIME') in (None,'','0')
sys.path.insert(0,str(out))
import workload, wave17_charloop as ext, wave17_character_bridge as aot
# PEP669 observers are an explicit diagnostic precondition, not covered by
# the C trace/profile guard. No normal/global or relevant local events are on.
observed_codes=[workload.token.__code__,shlex.shlex.__init__.__code__,shlex.shlex.read_token.__code__,shlex.shlex.punctuation_chars.fget.__code__,bootstrap._handle_fromlist.__code__]
assert all(sys.monitoring.get_events(tool)==0 and all(sys.monitoring.get_local_events(tool,code)==0 for code in observed_codes) for tool in range(6))
assert getattr(sys.flags,'gil',1)==1
ext.configure(workload.token)
variants=[('cpython',workload.token),('boxed-C',ext.boxed),('borrowed-C',ext.borrowed),('boxed-AOT',aot.boxed),('borrowed-AOT',aot.borrowed)]
report={'complete':False,'behavior_seal_sha256':hashlib.sha256((out/'complete.json').read_bytes()).hexdigest(),'source_sha256':source_hash,'fixtures':[],'attribution':'Complete fresh default-POSIX first-token wrapper. Borrowed removes private lexer/StringIO, state writes and repeated token construction as well as Unicode reads; not a pure character-load bound.'}
for size,repeats in [(20,1000),(127,500),(4096,20),(65536,2)]:
    for kind,char in [('1byte','a'),('2byte','\u03bb'),('4byte','\U0001f600')]:
        text=char*size if kind=='1byte' else '"'+char*size+'"'
        expected=workload.token(text);assert len(expected)==size
        for _,fn in variants:assert fn(text)==expected
        samples={name:[] for name,_ in variants};counters=[]
        for pair in range(3):
            for name,fn in (variants if pair%2==0 else list(reversed(variants))):
                before=ext.stats();start=time.perf_counter_ns()
                for _ in range(repeats):fn(text)
                samples[name].append((time.perf_counter_ns()-start)/repeats)
                delta=tuple(b-a for a,b in zip(before,ext.stats()))
                needed=(0,0,0) if name=='cpython' else (repeats,0,0) if name.startswith('boxed') else (0,repeats,0)
                assert delta==needed,(name,delta,needed)
                counters.append({'pair':pair,'route':name,'calls':repeats,'delta':delta})
        row={'kind':kind,'input_characters':len(text),'token_characters':size,'complete_call_ns':samples,'median_ns':{name:statistics.median(values) for name,values in samples.items()},'route_counters':counters}
        report['fixtures'].append(row);print(json.dumps({k:row[k] for k in ['kind','input_characters','token_characters','median_ns']}),flush=True)
assert hashes()==seal['sha256'],'accepted artifact changed during timing'
assert source_hash==hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'timing source changed'
assert hashlib.sha256(Path(shlex.__file__).read_bytes()).hexdigest()==reference['sha256'],'reference source changed'
report['complete']=True
target=D/(sys.argv[2]+'.json');assert not target.exists();target.write_text(json.dumps(report,indent=2))
