"""One before/after capture cohort, complete receipts only; no timing claims."""
import argparse,json,os,subprocess,sys,time,hashlib
from pathlib import Path
R=Path(__file__).resolve().parents[1]

def main():
    p=argparse.ArgumentParser();p.add_argument('output');p.add_argument('--programs',nargs='+');p.add_argument('--all-safe',action='store_true');a=p.parse_args()
    out=(R/a.output).resolve();out.mkdir(parents=True,exist_ok=False)
    baseline=R/'matrix/temp/reuse-baseline-v1';receipt=json.loads((baseline/'complete.json').read_text());assert receipt['complete']
    assert all(hashlib.sha256((baseline/k).read_bytes()).hexdigest()==v for k,v in receipt['source_sha256'].items())
    result={'programs':{},'fixed_all_program_defined':375,'note':'Observed native count/share; unobserved definitions are never inferred native. Network workloads excluded.'}
    programs = [w['name'] for w in json.loads((R.parent/'wave14-capture/capture/input-manifest.json').read_text())['workloads'] if w['name'] not in {'asyncio_tcp','asyncio_websockets','fastapi'}] if a.all_safe else a.programs
    assert programs and len(set(programs))==len(programs)
    for program in programs:
        result['programs'][program]={}
        for variant,source in [('before',baseline/'src'),('after',R/'src')]:
            target=out/(program+'-'+variant);cmd=[sys.executable,str(R/'matrix/heldout_native.py'),program,str(target)]
            env=os.environ.copy();env['MATRIX_PRODUCT_SOURCE']=str(source);env['PYTHONPATH']=str(source)
            started=time.monotonic()
            with (out/(program+'-'+variant+'.stdout')).open('wb') as stdout,(out/(program+'-'+variant+'.stderr')).open('wb') as stderr:
                done=subprocess.run(cmd,cwd=R,env=env,stdout=stdout,stderr=stderr,timeout=1800)
            (out/(program+'-'+variant+'.receipt.json')).write_text(json.dumps({'command':cmd,'exit_code':done.returncode,'wall_s':time.monotonic()-started,'source':str(source)},indent=2))
            assert done.returncode==0,(program,variant)
            complete=json.loads((target/'complete.json').read_text());assert complete['complete'] and hashlib.sha256((target/'results.json').read_bytes()).hexdigest()==complete['results_sha256']
            record=json.loads((target/'results.json').read_text());result['programs'][program][variant]=record
            if variant=='after':assert record['source_sha256']==result['programs'][program]['before']['source_sha256']
            print(program,variant,{k:record[k] for k in ['own_defined','captured','verified','whole_function_native','deployed']},flush=True)
    result['totals']={v:{k:sum(d[v][k] for d in result['programs'].values()) for k in ['own_defined','captured','verified','whole_function_native','deployed']} for v in ('before','after')}
    for v in ('before','after'):result['totals'][v]['whole_function_share_of375']=result['totals'][v]['whole_function_native']/375
    (out/'summary.json').write_text(json.dumps(result,indent=2));(out/'complete.json').write_text(json.dumps({'complete':True,'summary_sha256':hashlib.sha256((out/'summary.json').read_bytes()).hexdigest()}))
    print(json.dumps(result['totals']),flush=True)
if __name__=='__main__':main()
