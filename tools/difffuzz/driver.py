"""One supervised worker per subject; all subprocesses belong to this driver."""
import argparse
import ast
import collections
import importlib
import io
import json
import linecache
import os
from pathlib import Path
import random
import subprocess
import sys
import time
import types
from concurrent.futures import ThreadPoolExecutor
from .core import UnsupportedOracle,arguments,compare,shrink
from .catalog import discover,mutate,resource_risk
from .recipe import recipe


def low_priority():
    if sys.platform=='win32':
        import psutil
        psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
    elif hasattr(os,'nice'):os.nice(5)


def write_line(path,row):
    with path.open('a',encoding='utf-8') as out:out.write(json.dumps(row,ensure_ascii=True,default=repr)+'\n');out.flush()


def fixture(descriptor,directory):
    filename=directory/'subject.py';filename.write_text(descriptor['source'],encoding='utf-8')
    module=types.ModuleType('difffuzz_subject');module.__file__=str(filename)
    module.EVENTS=[];module.COUNTER=0;module.TEMP_FILE=str(directory/'fixture.txt')
    Path(module.TEMP_FILE).write_text('difffuzz\n',encoding='utf-8')
    import builtins
    builtins_ns=dict(vars(builtins))
    def breakpoint_(*a,**k):module.EVENTS.append(('breakpoint',a,k))
    def input_(prompt=''):print(prompt,end='');return 'difffuzz'
    builtins_ns.update(breakpoint=breakpoint_,input=input_)
    module.__dict__['__builtins__']=builtins_ns
    sys.modules[module.__name__]=module
    linecache.cache[str(filename)]=(len(descriptor['source']),None,descriptor['source'].splitlines(True),str(filename))
    exec(compile(descriptor['source'],str(filename),'exec',dont_inherit=True),vars(module))
    fn=vars(module)[descriptor['name']]
    base=eval(descriptor['args'],vars(module)) if descriptor['args'] is not None else ()
    kwargs=eval(descriptor['kwargs'],vars(module)) if descriptor['kwargs'] is not None else {}
    if descriptor.get('replay_recipe'):
        replay={};exec(descriptor['replay_recipe'],replay);base,kwargs=replay['ARGS'],replay['KWARGS']
    return fn,module,base,kwargs


def worker(jobfile):
    low_priority();job=json.loads(Path(jobfile).read_text(encoding='utf-8'))
    directory=Path(jobfile).parent;output=directory/'events.jsonl';descriptor=job['descriptor']
    sys.path.insert(0,job['product_source'])
    os.environ['RECOMPYLER_CACHE']=str(directory/'cache')
    for key in ('TEMP','TMP','TMPDIR'):os.environ[key]=str(directory)
    try:fn,module,base,kwargs=fixture(descriptor,directory)
    except Exception as exc:
        write_line(output,dict(status='fixture-unavailable',reason=type(exc).__name__+': '+str(exc)));return
    factories=[]
    if job['engine'] in ('lift','both'):
        m=importlib.import_module('recompyler.lift');factories.append(('lift',m.lift,m.Unsupported))
    if job['engine'] in ('heap','both'):
        m=importlib.import_module('recompyler.heap');factories.append(('heap',m.lift_region,importlib.import_module('recompyler.lift').Unsupported))
    if job['engine']=='managed':
        m=importlib.import_module('recompyler.managed');factories.append(('managed',m.lift_managed,importlib.import_module('recompyler.lift').Unsupported))
    if job['engine']=='structures':
        m=importlib.import_module('recompyler.heap')
        unsupported=importlib.import_module('recompyler.lift').Unsupported
        def structures(fn):
            region=m.lift_structures(fn)
            if region.run is None:raise unsupported(region.problem)
            return region
        factories.append(('structures',structures,unsupported))
    for engine,factory,decline in factories:
        try:compiled=factory(fn)
        except decline as exc:write_line(output,dict(status='construction-declined',engine=engine,reason=str(exc)));continue
        except Exception as exc:write_line(output,dict(status='compiler-error',engine=engine,reason=type(exc).__name__+': '+str(exc)));continue
        try:variants=arguments(fn,base,kwargs,seed=job['seed'],trials=job['trials'])
        except (ValueError,TypeError,UnsupportedOracle) as exc:write_line(output,dict(status='fixture-unavailable',engine=engine,reason=str(exc)));continue
        try:
            for index,(args,kw) in enumerate(variants):
                write_line(output,dict(status='started',engine=engine,trial=index))
                if resource_risk(descriptor['source'],args,kw):
                    write_line(output,dict(status='resource-filtered',engine=engine,trial=index));continue
                result=compare(fn,compiled,args,kw,module,warm=job['warm'])
                result.update(engine=engine,trial=index)
                if descriptor['origin']!='matrix' and result['status'] in ('native','declined'):
                    # Missing helpers/imports in a static extraction are no evidence.
                    if result.get('reference_exception') in (('builtins','NameError'),('builtins','UnboundLocalError')):result['status']='fixture-unavailable'
                if result['status']=='wrong':
                    deadline=time.monotonic()+job['shrink_seconds']
                    def fails(a,k):
                        if time.monotonic()>deadline or resource_risk(descriptor['source'],a,k):return False
                        try:new=factory(fn)
                        except Exception:return False
                        return compare(fn,new,a,k,module,warm=job['warm'])['status']=='wrong'
                    small,smallkw=shrink(args,kw,fails,budget=job['shrink_attempts'])
                    try:
                        text=recipe(small,smallkw);namespace={};exec(text,namespace)
                        if not fails(namespace['ARGS'],namespace['KWARGS']):raise UnsupportedOracle('recipe did not reproduce')
                    except (UnsupportedOracle,ValueError,TypeError,NameError,SyntaxError,AttributeError) as exc:
                        text=None;result['recipe_unavailable']=str(exc)
                    # Reduce statements only after the argument witness reproduces.
                    # Each candidate is a real edited version of the same program.
                    minimal_descriptor=descriptor
                    if text and time.monotonic()<deadline:
                        tree=ast.parse(descriptor['source'])
                        subject=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name==descriptor['name'])
                        changed=True;attempt=0
                        while changed and len(subject.body)>1 and time.monotonic()<deadline:
                            changed=False
                            for at in range(len(subject.body)):
                                body=subject.body;subject.body=body[:at]+body[at+1:]
                                candidate=dict(descriptor,source=ast.unparse(tree)+'\n',replay_recipe=text)
                                attempt+=1;temporary=directory/('shrink-'+engine+'-'+str(attempt));temporary.mkdir()
                                try:
                                    testfn,testmodule,aa,kk=fixture(candidate,temporary)
                                    testwrapper=factory(testfn)
                                    reproduces=compare(testfn,testwrapper,aa,kk,testmodule,warm=job['warm'])['status']=='wrong'
                                except Exception:reproduces=False
                                if reproduces:minimal_descriptor=candidate;changed=True;break
                                subject.body=body
                                if time.monotonic()>=deadline:break
                    result['input_recipe']=text
                    result['minimal_args']=repr(small);result['minimal_kwargs']=repr(smallkw)
                    # Keep only transitive fixture dependencies in the published program.
                    tree=ast.parse(minimal_descriptor['source']);needed={minimal_descriptor['name']};kept=[]
                    pending=True
                    def binds(node):
                        if isinstance(node,(ast.FunctionDef,ast.ClassDef)):return {node.name}
                        if isinstance(node,ast.Import):return {a.asname or a.name.split('.')[0] for a in node.names}
                        if isinstance(node,ast.ImportFrom):return {a.asname or a.name for a in node.names}
                        return {n.id for n in ast.walk(node) if isinstance(n,ast.Name) and isinstance(n.ctx,ast.Store)}
                    while pending:
                        pending=False
                        for node in tree.body:
                            if node not in kept and binds(node)&needed:
                                kept.append(node);needed.update(n.id for n in ast.walk(node) if isinstance(n,ast.Name));pending=True
                    sliced=dict(minimal_descriptor,source=ast.unparse(ast.Module(body=[n for n in tree.body if n in kept],type_ignores=[]))+'\n')
                    if text and time.monotonic()<deadline:
                        temporary=directory/('slice-'+engine);temporary.mkdir()
                        try:
                            testfn,testmodule,aa,kk=fixture(dict(sliced,replay_recipe=text),temporary)
                            if compare(testfn,factory(testfn),aa,kk,testmodule,warm=job['warm'])['status']=='wrong':minimal_descriptor=sliced
                        except Exception:pass
                    result['seed']=job['seed'];result['descriptor']=minimal_descriptor;result['original_descriptor']=descriptor
                    write_line(output,result)
                    # One reduced finding per subject/engine keeps the hour reporting rule practical.
                    break
                write_line(output,result)
        except (UnsupportedOracle,ValueError,TypeError) as exc:
            write_line(output,dict(status='fixture-unavailable',engine=engine,reason=str(exc)))
    write_line(output,dict(status='finished'))


def git(root,*args):
    run=subprocess.run(['git','-c','safe.directory=*',*args],cwd=root,capture_output=True,text=True)
    return run.stdout.strip() if run.returncode==0 else 'unavailable'


def publish_failure(root,folder,row,run_name,number):
    descriptor=row['descriptor'];seed=row['seed'];stem=run_name+'-difffuzz-'+str(seed)+'-'+str(number)
    local=folder/(stem+'.json');local.write_text(json.dumps(row,indent=2,ensure_ascii=True,default=repr),encoding='utf-8')
    corpus=root.parent/'provenance-cases'
    if not corpus.is_dir():return
    path=corpus/(stem+'.py')
    # Preserve the exact program as data; no arbitrary fixture code runs when the
    # shared provenance collector imports this regression.
    text='"""Differential fuzzer finding; replay via tools/difffuzz, seed '+str(seed)+'."""\n'
    text+='DIFFFUZZ_CASE = '+repr({'descriptor':descriptor,'input_recipe':row['input_recipe'],'seed':seed,'trial':row['trial'],'engine':row['engine']})+'\n'
    text+='EXPECTED_STATUS = "CPython-equivalent or declined"\n'
    if path.exists():raise FileExistsError(path)
    path.write_text(text,encoding='utf-8')
    with (corpus/'REQUESTS.md').open('a',encoding='utf-8') as requests:
        requests.write('\n- '+run_name+' | differential seed '+str(seed)+' | '+descriptor['id']+' through '+row['engine']+' differs from exact CPython (trial '+str(row['trial'])+', native calls '+str(row.get('native_calls',0))+'). Owner: '+descriptor['owner']+'. Bounded argument shrink attempted; portable minimized replay '+('available' if row['input_recipe'] else 'unavailable; use exact logged seed')+'. | '+path.name+'; '+str(local.relative_to(root))+'\n')


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--minutes',type=float,default=10);parser.add_argument('--seed',type=int,default=1729)
    parser.add_argument('--workers',type=int,choices=range(1,5),default=1)
    parser.add_argument('--sources',default='matrix,tests,corpus');parser.add_argument('--file',action='append',default=[])
    parser.add_argument('--match',default='');parser.add_argument('--trials',type=int,default=48)
    parser.add_argument('--case-timeout',type=float,default=60);parser.add_argument('--warm',type=int,default=2)
    parser.add_argument('--engine',choices=('lift','heap','both','managed','structures'),default='both')
    parser.add_argument('--mutations',type=int,default=0);parser.add_argument('--output',type=Path)
    parser.add_argument('--product-source',type=Path);parser.add_argument('--product-repo',type=Path);parser.add_argument('--product-commit',default='working-tree')
    parser.add_argument('--run',default='wave17-matrix');parser.add_argument('--publish',action='store_true')
    parser.add_argument('--replay',type=Path);parser.add_argument('--_worker')
    a=parser.parse_args(argv)
    if a._worker:return worker(a._worker)
    if a.minutes<=0 or a.case_timeout<=0 or a.trials<1:parser.error('positive duration, timeout and trials required')
    if not a.run.replace('-','').replace('_','').isalnum():parser.error('run must be a plain filename prefix')
    low_priority();root=Path(__file__).resolve().parents[2]
    output=(a.output or root/'matrix'/('difffuzz-'+str(time.time_ns()))).resolve()
    if not output.is_relative_to(root):parser.error('output must stay inside this clone')
    output.mkdir(parents=True,exist_ok=False)
    descriptors=discover(root,tuple(filter(None,a.sources.split(','))),a.file)
    if a.replay:
        namespace={};exec(a.replay.read_text(encoding='utf-8-sig'),namespace)
        case=namespace['DIFFFUZZ_CASE'];d=dict(case['descriptor']);d['replay_recipe']=case['input_recipe'];descriptors=[d];a.seed=case['seed'];a.engine=case['engine'];a.trials=1 if case.get('input_recipe') else case.get('trial',0)+1
    descriptors=[d for d in descriptors if a.match in d['id']]
    inventory=collections.Counter(d['origin'] for d in descriptors)
    random.Random(a.seed).shuffle(descriptors)
    if a.mutations:descriptors=[item for d in descriptors for item in [d]+[mutate(d,i) for i in range(a.mutations)]]
    deadline=time.monotonic()+a.minutes*60;started=time.monotonic();counts=collections.Counter();findings=[];case_count=0
    product=str((a.product_source or root/'src').resolve())
    if a.product_repo:
        import tarfile
        commit=a.product_commit if a.product_commit!='working-tree' else 'HEAD'
        a.product_commit=git(a.product_repo,'rev-parse',commit)
        archive=subprocess.run(['git','-c','safe.directory=*','archive',a.product_commit,'src'],cwd=a.product_repo,capture_output=True,check=True)
        destination=output/'product';destination.mkdir()
        with tarfile.open(fileobj=io.BytesIO(archive.stdout)) as tar:tar.extractall(destination,filter='data')
        product=str(destination/'src')
    def execute(pair):
        index,d=pair
        if time.monotonic()>=deadline:return []
        directory=output/('case-'+str(index));directory.mkdir()
        job={'descriptor':d,'product_source':product,'engine':a.engine,'seed':a.seed+index,'trials':a.trials,'warm':a.warm,'shrink_seconds':20,'shrink_attempts':40}
        path=directory/'job.json';path.write_text(json.dumps(job),encoding='utf-8')
        flags=0x4000 if sys.platform=='win32' else 0
        with (directory/'stdout').open('wb') as out,(directory/'stderr').open('wb') as err:
            child=subprocess.Popen([sys.executable,'-m','difffuzz','--_worker',str(path)],cwd=root,env=dict(os.environ,PYTHONPATH=str(root/'tools'),PYTHONDONTWRITEBYTECODE='1'),stdout=out,stderr=err,creationflags=flags)
            try:child.wait(timeout=max(.01,min(a.case_timeout,deadline-time.monotonic())))
            except subprocess.TimeoutExpired:
                child.kill();child.wait();write_line(directory/'events.jsonl',{'status':'timeout','subject':d['id']})
        events=directory/'events.jsonl'
        rows=[json.loads(line) for line in events.read_text(encoding='utf-8').splitlines()] if events.exists() else []
        if child.returncode and not any(r['status']=='timeout' for r in rows):rows.append({'status':'worker-error','subject':d['id'],'exit_code':child.returncode})
        for row in rows:row.setdefault('subject',d['id'])
        return rows
    # executor.map is ordered, so result/seed ordering stays reproducible even
    # when completion order varies. Each thread controls exactly one child.
    with ThreadPoolExecutor(max_workers=a.workers) as pool:
        for rows in pool.map(execute,enumerate(descriptors)):
            if rows:case_count+=1
            for row in rows:
                if row['status'] in ('started','finished'):continue
                counts[row['status']]+=1;write_line(output/'results.jsonl',row)
                if row['status']=='wrong':
                    findings.append(row)
                    if a.publish:publish_failure(root,output,row,a.run,len(findings))
            if rows and (case_count%10==0 or any(r['status']=='wrong' for r in rows)):
                print(json.dumps({'subjects':case_count,'counts':dict(counts),'seconds':round(time.monotonic()-started,1)}),flush=True)
    report={'seed':a.seed,'commit':git(root,'rev-parse','HEAD'),'product_commit':a.product_commit,'product_source':product,
            'inventory':dict(inventory),'selected_subjects':len(descriptors),'executed_subjects':case_count,'counts':dict(counts),
            'layer_a_findings':sum('mutation' not in r['descriptor'] for r in findings),'mutated_findings':sum('mutation' in r['descriptor'] for r in findings),
            'findings_by_engine':dict(collections.Counter(r['engine'] for r in findings)),'seconds':round(time.monotonic()-started,2),'command':sys.argv}
    (output/'report.json').write_text(json.dumps(report,indent=2),encoding='utf-8');print(json.dumps(report),flush=True)
    return 1 if findings or counts['worker-error'] or counts['compiler-error'] else 0
