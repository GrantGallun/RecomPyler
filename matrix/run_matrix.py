"""Execute one real construct through capture, verification and native accounting.

The compiler is a black box: a rejected result is a wrong row, internal compiler
exceptions remain crashes even when a public wrapper would silently use Python.
"""
import argparse, ast, asyncio, contextlib, copy, hashlib, importlib.util, inspect
import functools, io, json, math, os, re, struct, sys, traceback, types, warnings
from pathlib import Path
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,os.environ.get('MATRIX_PRODUCT_SOURCE',str(R/'src')));sys.path.insert(0,str(R/'matrix'))
from catalogue import cases, source, inventory
from recompyler import profiler
from recompyler.monitor import CallMonitor, Yielded
from recompyler.lift import Lifted, Unsupported, lift
from recompyler.heap import lift_region

T=R/'matrix'/'temp';T.mkdir(exist_ok=True)

def freeze(value, seen=None):
    if seen is None:seen={}
    kind=type(value)
    if kind in (type(None),bool,int,str):return [kind.__name__,value]
    if kind is float:return ['float',struct.pack('>d',value).hex()]
    if kind is complex:return ['complex',freeze(value.real),freeze(value.imag)]
    if kind in (bytes,bytearray):return [kind.__name__,bytes(value).hex()]
    if kind is memoryview:return ['memoryview',value.format,value.itemsize,value.ndim,freeze(value.shape),freeze(value.strides),value.readonly,value.tobytes().hex()]
    if kind is type:return ['type',value.__module__,value.__qualname__]
    if id(value) in seen:return ['ref',seen[id(value)]]
    seen[id(value)]=len(seen)
    if kind in (tuple,list):return [kind.__name__,[freeze(x,seen) for x in value]]
    if kind is dict:return ['dict',[[freeze(k,seen),freeze(v,seen)] for k,v in value.items()]]
    if kind in (set,frozenset):return [kind.__name__,sorted([freeze(x,{}) for x in value],key=lambda x:json.dumps(x,sort_keys=True))]
    if kind is slice:return ['slice',freeze(value.start),freeze(value.stop),freeze(value.step)]
    if kind is Yielded:return ['yielded',freeze(value.values,seen),value.finished,value.truncated,freeze(value.value,seen)]
    if kind is types.CodeType:return ['code',value.co_code.hex(),freeze(value.co_consts)]
    # Tested fixture objects have inert fields; opaque builtin values are compared
    # by their specific stable representation below, never by address-bearing repr.
    if kind.__module__=='string.templatelib':return ['template',freeze(value.strings),[[freeze(i.value),i.expression,i.conversion,i.format_spec] for i in value.interpolations]]
    if isinstance(value,BaseException):return exception(value)
    if hasattr(value,'__dict__') and kind.__module__.startswith('matrix_fixture'):
        return ['object',kind.__name__,freeze(vars(value),seen)]
    if kind in (property,classmethod,staticmethod):return ['descriptor',kind.__name__,getattr(value,'__name__',None)]
    if isinstance(value,range):return ['range',value.start,value.stop,value.step]
    if isinstance(value,types.ModuleType):return ['module',value.__name__]
    raise TypeError('matrix oracle lacks stable projection for '+kind.__module__+'.'+kind.__qualname__)

def exception(exc):
    data=[type(exc).__module__,type(exc).__qualname__,str(exc)]
    if isinstance(exc,BaseExceptionGroup):data.append([exception(e) for e in exc.exceptions])
    if exc.__cause__ is not None:data.append(['cause',exception(exc.__cause__)])
    elif exc.__context__ is not None:data.append(['context',exception(exc.__context__)])
    data.append(['suppress_context',exc.__suppress_context__])
    return data

async def collect_async(value):
    if inspect.isasyncgen(value):return [v async for v in value]
    return await value

def drive(value):
    if inspect.isgenerator(value):
        result=[]
        while True:
            try:result.append(next(value))
            except StopIteration as done:return Yielded(result,True,False,done.value)
    if inspect.isawaitable(value) or inspect.isasyncgen(value):return asyncio.run(collect_async(value))
    if type(value).__name__=='AsyncRange':return asyncio.run(collect_range(value))
    return value
async def collect_range(value):return [x async for x in value]

def native_callable(wrapper):
    original=getattr(wrapper,"original",None)
    if original is not None and original.__code__.co_flags & (0x20|0x200) and hasattr(wrapper,"values"):
        def collected(*args):
            values=wrapper.values(args)
            if values is None:return wrapper.original(*args)
            # Native generator ABI collects yielded values, with None return.
            if original.__code__.co_flags & 0x200:return values
            return Yielded(values,True,False,None)
        return collected
    return wrapper

def outcome(fn, args, module, kwargs=None):
    kwargs={} if kwargs is None else kwargs
    module.EVENTS.clear();module.COUNTER=0
    if hasattr(module,'box'):module.box=module.Box(3)
    out,err=io.StringIO(),io.StringIO();oldin=sys.stdin;oldhook=sys.breakpointhook
    sys.stdin=io.StringIO('matrix\nq\n');sys.breakpointhook=lambda *a,**k:module.EVENTS.append('breakpoint')
    # No caches/files escape the clone-local TEMP/TMP configured by run_locked.
    shared={}
    try:
        with contextlib.redirect_stdout(out),contextlib.redirect_stderr(err):
            try:raw=drive(fn(*args,**kwargs))
            except BaseException as exc:result={'exception':exception(exc)}
            else:
                result={'result':freeze(raw,shared)}
                if getattr(module,'CHECK_SCALAR_IDENTITY',False):
                    result['result_argument_identity']=[raw is item for item in args]
    finally:sys.stdin=oldin;sys.breakpointhook=oldhook
    result.update(arguments=freeze(args,shared),keywords=freeze(kwargs,shared),events=freeze(module.EVENTS,shared),counter=module.COUNTER,stdout=out.getvalue(),stderr=err.getvalue())
    if hasattr(module,'box'):result['box']=freeze(vars(module.box),shared)
    return result

def fixture(case):
    digest=hashlib.sha256(case.id.encode()).hexdigest()[:14]
    path=T/(digest+'.py');path.write_text(source(case),encoding='utf-8')
    name='matrix_fixture_'+digest
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec)
    m.CHECK_SCALAR_IDENTITY=case.group=='identity';m.EVENTS=[];m.COUNTER=0;m.TEMP_FILE=str(T/'open-fixture.txt')
    Path(m.TEMP_FILE).write_text('matrix file\n',encoding='utf-8')
    sys.modules[name]=m;spec.loader.exec_module(m)
    return m,path

def summarize(candidate):
    return {k:v for k,v in candidate.items() if not k.startswith('_')}

def _run_case(case):
    row={'id':case.id,'group':case.group,'source':source(case),'argument_expression':case.args}
    try:
        module,path=fixture(case);fn=module.construct
        args=eval(case.args,module.__dict__);kwargs=eval(case.kwargs,module.__dict__)
        plain=outcome(fn,copy.deepcopy(args),module,copy.deepcopy(kwargs))
        if "exception" in plain and plain["exception"][1] in {"NameError","SyntaxError"}:
            raise RuntimeError("invalid construct fixture: "+str(plain["exception"]))
        with CallMonitor([path],2,profiler.snapshot,backend='python',bias=0,yield_bias=0) as monitor:
            captured=outcome(fn,copy.deepcopy(args),module,copy.deepcopy(kwargs))
        if plain!=captured:raise AssertionError('capture changed program behavior')
        key=(str(path),'construct',fn.__code__.co_firstlineno)
        sampler=monitor.samplers.get(key)
        samples=sampler.samples if sampler else []
        row['capture']={'samples':len(samples),'reason':monitor.skipped.get(key),'declines':sampler.declines if sampler else {}}
        row['reference']=plain
        if samples:
            module.EVENTS.clear();module.COUNTER=0
            # Ordinary product entrypoint: no bypass of analysis, guards, timing gate,
            # replay verification, or lifter/region selection.
            candidate=profiler.test_candidate(fn,samples,1,extra=())
            row['candidate']=summarize(candidate)
            if candidate['status']=='rejected':
                row['rejection_replays']=[]
                for factory in (lift,lift_region):
                    try:
                        replay=factory(fn);before=replay.compiled_calls
                        got=outcome(native_callable(replay),copy.deepcopy(args),module,copy.deepcopy(kwargs))
                        native=replay.compiled_calls-before
                        row['rejection_replays'].append(dict(engine=factory.__name__,native_calls=native,outcome=got))
                        if got!=plain:
                            row.update(verdict='wrong' if native else 'crash',reason='observed rejected-candidate replay differs',compiled=got,native_calls=native)
                            return row
                        if any(p is not None and p.broken for p in getattr(replay,'programs',{}).values()):
                            row.update(verdict='crash',reason=replay.problem)
                            return row
                    except Unsupported as exc:row['rejection_replays'].append(dict(engine=factory.__name__,decline=str(exc)))
                row.update(verdict='crash',reason='candidate rejection not reproduced by direct replay: '+candidate.get('reason',''),harness_error=True)
                return row
            wrapper=candidate.get('_region') or candidate.get('_lifted')
            if candidate['status']=='verified' and wrapper is not None:
                before=wrapper.compiled_calls
                got=outcome(native_callable(wrapper),copy.deepcopy(args),module,copy.deepcopy(kwargs))
                row['compiled']=got;row['native_calls']=wrapper.compiled_calls-before
                row.update(verdict=('wrong' if row['native_calls'] else 'crash') if got!=plain else ('native' if row['native_calls'] else 'declined'),reason='' if got==plain and row['native_calls'] else 'compiled replay differs' if got!=plain else 'runtime guard declined')
                return row
            # Region.problem preserves an internal Numba/backend exception hidden
            # by normal Python fallback. Probe its ordinary attempt to expose it.
            region=lift_region(fn);given=copy.deepcopy(args)
            got=outcome(native_callable(region),given,module,copy.deepcopy(kwargs))
            broken=any(p is not None and p.broken for p in region.programs.values())
            if broken:row.update(verdict='crash',reason=region.problem)
            elif got!=plain:row.update(verdict='wrong',reason='fallback result differs',compiled=got)
            else:row.update(verdict='declined',reason=candidate.get('region_reason') or candidate.get('reason') or region.problem or 'runtime guard declined')
            return row
        # Exception calls and signatures capture deliberately declines still execute
        # both public compiler wrappers. Their semantics are compared after fallback.
        reasons=[];native=0;broken=False
        for factory in (lift,lift_region):
            try:
                wrapper=factory(fn);before=wrapper.compiled_calls
                got=outcome(native_callable(wrapper),copy.deepcopy(args),module,copy.deepcopy(kwargs));native+=wrapper.compiled_calls-before
                if got!=plain:row.update(verdict='wrong',reason='compiled exception/result/side effects differ',compiled=got);return row
                if hasattr(wrapper,'programs'):
                    broken=any(p is not None and p.broken for p in wrapper.programs.values())
                    if broken:row.update(verdict='crash',reason=wrapper.problem);return row
                    if wrapper.problem:reasons.append(wrapper.problem)
                    elif wrapper.gave_up:reasons.append('runtime guard at '+str(wrapper.gave_up))
            except Unsupported as exc:reasons.append(str(exc))
        row.update(verdict='native' if native else 'declined',native_calls=native,reason='' if native else '; '.join(reasons) or row['capture']['reason'] or 'capture snapshot or runtime type guard declined')
    except BaseException as exc:
        row.update(verdict='crash',reason=f'{type(exc).__name__}: {exc}',traceback=traceback.format_exc())
    return row

@contextlib.contextmanager
def observe_failures():
    # Scoped ordinary call wrappers preserve the product's observer policy.
    # Serial isolated workers own these bindings for the duration of one row.
    failures=[]
    saved=(Lifted._run,profiler.test_lifted,profiler._test_region)
    controls=(StopIteration,GeneratorExit,Unsupported)
    def record(owner,phase,error):
        if not isinstance(error,controls):
            failures.append((owner,phase,type(error).__name__,str(error),getattr(owner,'compiled_calls',0)))
    @functools.wraps(saved[0])
    def run(owner,*args,**kwargs):
        try:return saved[0](owner,*args,**kwargs)
        except BaseException as error:
            record(owner,'_run',error)
            raise
    def verifier(original,name):
        @functools.wraps(original)
        def checked(*args,**kwargs):
            try:result=original(*args,**kwargs)
            except BaseException as error:
                record(None,'verification:'+name,error)
                raise
            if isinstance(result,dict) and result.get('status')=='rejected':
                reason=result.get('reason','')
                match=re.fullmatch(r'a captured call raised ([A-Za-z_][A-Za-z_0-9]*) when replayed',reason)
                if match and match[1] not in ('StopIteration','GeneratorExit','Unsupported'):
                    failures.append((None,'verification:'+name,match[1],reason,0))
            return result
        return checked
    Lifted._run=run
    profiler.test_lifted=verifier(saved[1],'test_lifted')
    profiler._test_region=verifier(saved[2],'_test_region')
    try:yield failures
    finally:Lifted._run,profiler.test_lifted,profiler._test_region=saved


def unresolved_failures(failures):
    # A subsequent successful specialization can recover; earlier native work
    # does not erase a compilation failure on a new warm-call shape.
    return [{'phase':phase,'type':kind,'message':message}
            for owner,phase,kind,message,count in failures
            if owner is None or owner.compiled_calls<=count]


def run_case(case):
    with observe_failures() as failures:row=_run_case(case)
    unresolved=unresolved_failures(failures)
    if unresolved:
        row['internal_errors']=unresolved
        if row.get('harness_error') and any(x['phase'].startswith('verification:') for x in unresolved):row.pop('harness_error')
        if row['verdict']!='wrong':row.update(verdict='crash',reason=unresolved[-1]['type']+': '+unresolved[-1]['message'])
    return row

def worker(connection):
    rows={c.id:c for c in cases()}
    while True:
        identity=connection.recv()
        if identity is None:return
        connection.send(run_case(rows[identity]))

def execute_isolated(rows,timeout=120):
    import multiprocessing
    ctx=multiprocessing.get_context('spawn');child=None;connection=None;age=0
    try:
        for row in rows:
            if child is None or not child.is_alive() or age>=80:
                if child is not None and child.is_alive():connection.send(None);child.join(10)
                if child is not None and child.is_alive():child.terminate();child.join()
                connection,other=ctx.Pipe();child=ctx.Process(target=worker,args=(other,));child.start();other.close();age=0
            print('START '+row.id,flush=True);connection.send(row.id)
            if connection.poll(timeout):
                try:result=connection.recv()
                except EOFError:
                    child.join(10)
                    if child.is_alive():child.terminate();child.join()
                    result={'id':row.id,'group':row.group,'verdict':'crash','reason':'owned worker exited '+str(child.exitcode)}
                    connection.close();child=None
            else:
                child.terminate();child.join()
                result={'id':row.id,'group':row.group,'verdict':'crash','reason':'owned worker timed out after '+str(timeout)+' seconds'}
            age+=1
            yield result
    finally:
        if child is not None and child.is_alive():
            connection.send(None);child.join(10)
            if child.is_alive():child.terminate();child.join()

def main():
    p=argparse.ArgumentParser();p.add_argument('--output',default='matrix/baseline.jsonl');p.add_argument('--ids',nargs='*');p.add_argument('--groups',nargs='*');a=p.parse_args()
    rows=cases();inv=inventory(rows)
    (R/'matrix/inventory.json').write_text(json.dumps(inv,indent=2),encoding='utf-8')
    if a.ids:rows=[r for r in rows if r.id in a.ids]
    if a.groups:rows=[r for r in rows if r.group in a.groups]
    assert len({r.id for r in rows})==len(rows)
    target=R/a.output
    if target.exists():raise RuntimeError('refuse overwrite '+str(target))
    from collections import Counter
    counts=Counter()
    with target.open('w',encoding='utf-8') as f:
        for n,result in enumerate(execute_isolated(rows),1):
            f.write(json.dumps(result,ensure_ascii=True)+'\n');f.flush()
            counts[result['verdict']]+=1
            print(n,len(rows),result['id'],result['verdict'],result.get('reason','')[:140],flush=True)
    print(json.dumps({'counts':dict(counts),'complete':True,'rows':len(rows)}),flush=True)
if __name__=='__main__':main()
