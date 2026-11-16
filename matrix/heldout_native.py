"""Count whole own functions from actual complete-call replay, never AST support guesses.

All files and execution cwd are private clone-local copies. S58 uses plain result output. The source
manifest supplies the fixed375-definition denominator; unobserved functions count
as unobserved, never native. No timings from this collector are reported.
"""
import argparse,ast,contextlib,io,json,os,runpy,shutil,sys,subprocess
from pathlib import Path
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(os.environ.get('MATRIX_PRODUCT_SOURCE',R/'src')))
from recompyler import profiler
from recompyler.monitor import CallMonitor,Yielded


def collect(program, output):
    output.mkdir(parents=True,exist_ok=False)
    inputs=R.parent/'wave14-capture/capture/inputs'
    manifest=json.loads((inputs.parent/'input-manifest.json').read_text())
    recipe=next(w for w in manifest['workloads'] if w['name']==program)
    assert program not in {'asyncio_tcp','asyncio_websockets','fastapi'}, 'network workloads are excluded'
    folder=output/'input';shutil.copytree(inputs/program,folder,ignore=shutil.ignore_patterns('__pycache__'))
    shim=output/'shim';shutil.copytree(inputs/'shim',shim,ignore=shutil.ignore_patterns('__pycache__'))
    script=folder/Path(recipe['script']).name
    trees={str(p.resolve()):ast.parse(p.read_text(encoding='utf-8')) for p in folder.glob('*.py')}
    definitions={(f,min([n.lineno,*[d.lineno for d in n.decorator_list]])):n.name for f,t in trees.items() for n in ast.walk(t) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef))}
    off=output/'off-input';shutil.copytree(inputs/program,off,ignore=shutil.ignore_patterns('__pycache__'))
    arguments=lambda where:[a.replace(str(inputs/program),str(where)) for a in recipe['args']]
    plain=subprocess.run([sys.executable,str(Path(__file__).resolve()),'--plain',str(off/script.name),str(shim),json.dumps(arguments(off))],cwd=off,text=True,capture_output=True,timeout=300,env=os.environ.copy())
    (output/'plain.stdout').write_text(plain.stdout);(output/'plain.stderr').write_text(plain.stderr)
    assert plain.returncode==0,(plain.returncode,plain.stderr[-1000:])
    oldcwd=Path.cwd(); oldargv=sys.argv[:];oldpath=sys.path[:]
    monitor=CallMonitor([folder],8,profiler.snapshot,backend='python',bias=0,yield_bias=0)
    out=io.StringIO();err=io.StringIO()
    try:
        os.chdir(folder);sys.argv=[str(script),*arguments(folder)];sys.path[:0]=[str(folder),str(shim)]
        with contextlib.redirect_stdout(out),contextlib.redirect_stderr(err),monitor:
            runpy.run_path(str(script),run_name='__main__')
    finally:
        os.chdir(oldcwd);sys.argv=oldargv;sys.path[:]=oldpath
    normalized=lambda text,where:text.replace(str(where),'$INPUT').replace(str(where).replace('\\','/'),'$INPUT')
    assert normalized(out.getvalue(),folder)==normalized(plain.stdout,off), 'capture changed application stdout'
    assert normalized(err.getvalue(),folder)==normalized(plain.stderr,off), 'capture changed application stderr'
    records=[]
    for row in monitor.rows():
        key=row['_key'];sampler=monitor.samplers.get(key)
        # Only definitions in the fixed own-source population; imported stdlib is separate.
        if (str(Path(key[0]).resolve()),key[2]) not in definitions:continue
        retained=[*sampler.samples,*sampler.extra()] if sampler and sampler.samples else []
        candidate=profiler.test_candidate(sampler.function,retained,row['calls'],sampler.list_reuse,extra=(),cumulative_s=row.get('cumulative_s')) if retained else {'status':'uncaptured','reason':monitor.skipped.get(key)}
        verified=candidate.get('status')=='verified'
        complete_calls=all(not isinstance(expected,Yielded) or expected.finished and not expected.truncated for _,expected,_ in retained)
        native=verified and complete_calls and candidate.get('fallback_samples',0)==0 and candidate.get('compiled_samples',0)>0
        records.append({'function':row['function'],'line':key[2],'captured':bool(sampler and sampler.samples),'verified':verified,'retained_complete_calls':complete_calls,'whole_function_native':native,'recommended':bool(candidate.get('recommended')),'deployed':False,'candidate':{k:candidate[k] for k in ('status','reason','compiled_samples','fallback_samples') if k in candidate}})
    result={'program':program,'capture_monitor_on_off_behavior_identical':True,'coverage_scope':'Complete function native on every retained uniform and rare sample; no inference for unobserved calls or definitions. Recommendation diagnostic only; retained sample mix is combined.','own_defined':len(definitions),'fixed_all_program_defined':375,'rows':records,'captured':sum(r['captured'] for r in records),'verified':sum(r['verified'] for r in records),'whole_function_native':sum(r['whole_function_native'] for r in records),'deployed':0,'deployment_note':'replay/capture count only; no runner deployment performed','stdout':out.getvalue(),'stderr':err.getvalue()}
    result['whole_function_native_share_of_all_defined']=result['whole_function_native']/375
    (output/'results.json').write_text(json.dumps(result,indent=2,default=str))
    print(json.dumps({k:v for k,v in result.items() if k not in {'rows','stdout','stderr','source_sha256'}}))

if __name__=='__main__':
    if len(sys.argv)>1 and sys.argv[1]=='--plain':
        script,shim,args=sys.argv[2:];sys.path[:0]=[str(Path(script).parent),shim];sys.argv=[script,*json.loads(args)];runpy.run_path(script,run_name='__main__');sys.exit(0)
    p=argparse.ArgumentParser();p.add_argument('program');p.add_argument('output');a=p.parse_args();collect(a.program,(R/a.output).resolve())
