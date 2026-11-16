from pathlib import Path
import ast,hashlib,itertools,json,random,statistics,subprocess,sys,textwrap,time
R=Path(__file__).resolve().parents[2];D=Path(__file__).resolve().parent
sys.path[:0]=[str(R/'src'),str(R/'matrix'),str(R/'matrix/temp/ceilings')]
from run_matrix import exception
import wave17_ceiling_unicode as ext

def observe(fn,value):
    try:
        result=fn(value)
        return {'type':type(result).__name__,'result':result,'input_alias':result is value}
    except Exception as exc:return {'error':exception(exc)}

def fixtures():
    folder=Path('C:/Users/grant/AppData/Roaming/Python/Python314/site-packages/sqlalchemy')
    out=[]
    for filename,line,name in [('orm/session.py',1999,'Session.commit'),('orm/session.py',4323,'Session.flush'),('orm/query.py',2689,'Query.all')]:
        p=folder/filename;source=p.read_text(encoding='utf8');tree=ast.parse(source);node=next(n for n in ast.walk(tree) if isinstance(n,ast.FunctionDef) and n.lineno==line)
        owner,method=name.split('.');assert node.name==method and any(isinstance(c,ast.ClassDef) and c.name==owner and node in c.body for c in ast.walk(tree))
        doc=ast.get_docstring(node,clean=False);first,remaining=doc.split('\n',1);value=remaining if not first.startswith(' ') else doc
        out.append({'name':name,'source':str(p),'line':line,'source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'value':value,'characters':len(value),'input_sha256':hashlib.sha256(value.encode('utf8')).hexdigest()})
    return out

def main():
    label=sys.argv[1];target=D/('unicode-'+label+'.json');report={'gates':[],'samples':[],'fixtures':fixtures()}
    candidates=[('boxed-C',ext.dedent_boxed),('borrowed-C',ext.dedent_borrowed)]
    if '--bridge' in sys.argv:
        from unicode_bridge import compile_bridges
        entries,dispatchers,aot=compile_bridges()
        candidates.extend([('boxed-njit',entries['dedent_boxed']),('borrowed-njit',entries['dedent_borrowed']),('boxed-AOT',aot.dedent_boxed),('borrowed-AOT',aot.dedent_borrowed)])
        report['bridge_artifact']={'path':str(Path(aot.__file__).relative_to(R)),'sha256':hashlib.sha256(Path(aot.__file__).read_bytes()).hexdigest()}
        child=subprocess.run([sys.executable,'-B',str(D/'unicode_fresh.py'),str(Path(aot.__file__).parent),str(R/'matrix/temp/ceilings')],capture_output=True,text=True)
        report['fresh_aot']={'exit_code':child.returncode,'stdout':child.stdout,'stderr':child.stderr};assert child.returncode==0,report['fresh_aot']
    cases=['','a','   ','\t','\n',' \n  ','  a','  a\n','  a\n  b','\ta\n b','\t a\n\t b','\r\n a\r\n','\u00a0\n  \u03a9\n  \U0001f600','  a\n\x1c\x1f\u2003\n  b',None,3,b'abc']
    class Sub(str):
        def split(self,*args):return ['  a','  b']
    cases.append(Sub('custom'));cases.extend(['  a\x00b\n  c', 'x\x00', '  a\n  ab', '\n\n', ' \r \n\t'])
    whitespace=[chr(cp) for cp in range(sys.maxunicode+1) if chr(cp).isspace()]
    report['unicode_whitespace_codepoints']=[ord(c) for c in whitespace]
    cases.extend('  a\n'+c+'\n  b' for c in whitespace)
    cases.extend(c+'a\n'+c+'b' for c in whitespace)
    cases.extend(['  \xe9\n  x','  \ud800\n  x'])
    # A deterministic broad local grammar covers whitespace/prefix identities.
    rng=random.Random(17);alphabet=['a','b',' ','\t','\r','\v','\x1c','\u00a0','\u2003','\u03a9','\U0001f600','\n']
    cases.extend(''.join(rng.choices(alphabet,k=rng.randrange(50))) for _ in range(300))
    cases.extend(f['value'] for f in report['fixtures'])
    for index,value in enumerate(cases):
        ref=observe(textwrap.dedent,value)
        for variant,fn in candidates:
            got=observe(fn,value);row={'case':index,'variant':variant,'identical':ref==got,'reference':ref,'compiled':got};report['gates'].append(row)
            if ref!=got:print('MISMATCH',json.dumps(row),flush=True)
    from unicode_mutations import gates as mutation_gates
    report['gates'].extend(mutation_gates(textwrap.dedent,candidates,observe))
    for row in report['gates']:
        if not row['identical']:print('MISMATCH',json.dumps(row),flush=True)
    target.write_text(json.dumps(report,indent=2));assert all(r['identical'] for r in report['gates'])
    report['ownership']=[]
    for variant,fn in candidates:
        for value in ['abc',' a\n b',None]:
            observe(fn,value);before=sys.getrefcount(value)
            for _ in range(1000):observe(fn,value)
            after=sys.getrefcount(value);assert before==after,(variant,value,before,after)
        ref=textwrap.dedent(report['fixtures'][0]['value']);got=fn(report['fixtures'][0]['value']);assert sys.getrefcount(ref)==sys.getrefcount(got),(variant,'output refs')
        report['ownership'].append({'variant':variant,'success_error_input_refs_stable':True,'output_refs':sys.getrefcount(got)})
    for fixture in report['fixtures']:
        value=fixture['value'];all_variants=[('cpython',textwrap.dedent),*candidates];samples={k:[] for k,f in all_variants};routes=[]
        for pair in range(3):
            order=all_variants if pair%2==0 else list(reversed(all_variants))
            for variant,fn in order:
                before=ext.stats();start=time.perf_counter_ns()
                for _ in range(500):fn(value)
                samples[variant].append((time.perf_counter_ns()-start)/500);after=ext.stats();delta=[b-a for a,b in zip(before,after)]
                if variant.startswith('borrowed-'):assert delta==[0,500,0],(variant,delta)
                elif variant.startswith('boxed-'):assert delta==[500,0,0],(variant,delta)
                else:assert delta==[0,0,0]
                routes.append({'pair':pair,'variant':variant,'calls':500,'delta':delta})
        report['samples'].append({'fixture':fixture['name'],'complete_call_ns':samples,'median_ns':{k:statistics.median(v) for k,v in samples.items()},'routes':routes})
    report['source_hashes']={str(p.relative_to(R)) if p.is_relative_to(R) else str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in [Path(__file__),D/'unicode.c',D/'unicode_bridge.py',D/'unicode_fresh.py',D/'unicode_mutations.py',Path(textwrap.__file__),R/'matrix/extension/managed.py',R/'matrix/build_ceiling.py']}
    report['helper_artifact']={'path':str(Path(ext.__file__).relative_to(R)),'sha256':hashlib.sha256(Path(ext.__file__).read_bytes()).hexdigest()}
    report['complete']=True;target.write_text(json.dumps(report,indent=2));print(json.dumps({'complete':True,'gates':len(report['gates']),'samples':report['samples']}));return 0
if __name__=='__main__':sys.exit(main())
