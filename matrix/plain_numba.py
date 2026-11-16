"""S35 diagnostic: execute unchanged declined fixtures through plain njit."""
import argparse,copy,hashlib,json,multiprocessing,sys,traceback,warnings
from collections import Counter,defaultdict
from pathlib import Path
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(R/'matrix'))
import run_matrix as oracle
from catalogue import cases,source
import numba
# Extend only this diagnostic's projection; keep returned runtime types visible.
_original_freeze=oracle.freeze
_original_drive=oracle.drive
def diagnostic_freeze(value,seen=None):
    kind=type(value)
    if kind.__module__=='numba.typed.typeddict' and kind.__name__=='Dict':
        return ['numba.typed.Dict',[[diagnostic_freeze(k),diagnostic_freeze(v)] for k,v in value.items()]]
    if kind.__module__.startswith('numpy.dtypes'):
        return ['numpy.dtype',str(value)]
    return _original_freeze(value,seen)
def diagnostic_drive(value):
    if type(value).__module__=='_dynfunc' and type(value).__name__=='_Generator':
        items=[]
        while True:
            try:items.append(next(value))
            except StopIteration as stop:return oracle.Yielded(items,True,False,stop.value)
    return _original_drive(value)
oracle.freeze=diagnostic_freeze
oracle.drive=diagnostic_drive

def one(case):
    row={'id':case.id,'group':case.group,'source':source(case),'args':case.args,'kwargs':case.kwargs}
    try:
        module,path=oracle.fixture(case);fn=module.construct
        args=eval(case.args,module.__dict__);kw=eval(case.kwargs,module.__dict__)
        row['reference']=oracle.outcome(fn,copy.deepcopy(args),module,copy.deepcopy(kw))
        compiled=numba.njit(fn)
        with warnings.catch_warnings(record=True) as caught:
            warnings.simplefilter('always')
            actual=oracle.outcome(compiled,copy.deepcopy(args),module,copy.deepcopy(kw))
        row['diagnostics']=[{'type':type(w.message).__name__,'message':str(w.message)} for w in caught]
        row['signatures']=[str(sig) for sig in compiled.nopython_signatures]
        row['compiled']=actual
        row['verdict']=('matches' if actual==row['reference'] else 'differs') if row['signatures'] else 'does_not_compile'
    except BaseException as exc:
        row.update(verdict='harness_error',error=type(exc).__name__+': '+str(exc),traceback=traceback.format_exc())
    return row

def worker(conn):
    allcases={c.id:c for c in cases()}
    while True:
        identity=conn.recv()
        if identity is None:return
        conn.send(one(allcases[identity]))

def execute(rows):
    ctx=multiprocessing.get_context('spawn');child=None;conn=None;age=0
    try:
        for case in rows:
            if child is None or not child.is_alive() or age>=40:
                if child is not None and child.is_alive():conn.send(None);child.join(10)
                if child is not None and child.is_alive():child.terminate();child.join()
                conn,other=ctx.Pipe();child=ctx.Process(target=worker,args=(other,));child.start();other.close();age=0
            print('START '+case.id,flush=True);conn.send(case.id)
            if conn.poll(120):
                try:row=conn.recv()
                except EOFError:
                    child.join(10)
                    if child.is_alive():child.terminate();child.join()
                    row={'id':case.id,'group':case.group,'verdict':'harness_error','error':'owned worker exited '+str(child.exitcode)};child=None
            else:
                child.terminate();child.join();child=None
                row={'id':case.id,'group':case.group,'verdict':'harness_error','error':'owned worker timed out after 120s'}
            age+=1;yield row
    finally:
        if child is not None and child.is_alive():
            conn.send(None);child.join(10)
            if child.is_alive():child.terminate();child.join()

def main():
    p=argparse.ArgumentParser();p.add_argument('--output',required=True);p.add_argument('--ids',nargs='*');a=p.parse_args()
    current=[json.loads(line) for line in (R/'matrix/step2-v3.jsonl').read_text().splitlines()]
    declines={r['id'] for r in current if r['verdict']=='declined'}
    selected=[c for c in cases() if c.id in declines and (not a.ids or c.id in a.ids)]
    if not a.ids:assert {c.id for c in selected}==declines and len(selected)==781
    seal={'numba_version':numba.__version__,'ids':[c.id for c in selected],'files':{str(p.relative_to(R)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [Path(__file__),R/'matrix/catalogue.py',R/'matrix/run_matrix.py',R/'matrix/step2-v3.jsonl']}}
    (R/'matrix'/('plain-numba-source-seal-'+Path(a.output).stem+'.json')).write_text(json.dumps(seal,indent=2))
    target=R/a.output
    if target.exists():raise RuntimeError('refuse overwrite '+str(target))
    counts=Counter()
    with target.open('w',encoding='utf-8') as f:
        for row in execute(selected):
            row['numba_version']=numba.__version__;row['product_verdict']='declined'
            f.write(json.dumps(row,ensure_ascii=True)+'\n');f.flush();counts[row['verdict']]+=1
            print(row['id'],row['verdict'],dict(counts),flush=True)
    print(json.dumps({'complete':True,'rows':len(selected),'counts':dict(counts)}),flush=True)
if __name__=='__main__':main()
