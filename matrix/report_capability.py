"""Post-commit held-out report against the preceding complete observed cohort."""
import argparse,collections,json,os,subprocess,sys
from pathlib import Path
import psutil
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(R/'matrix'))
from first_failures import first_failure

def main():
    parser=argparse.ArgumentParser();parser.add_argument('output');parser.add_argument('--source',default=str(R/'src'));parser.add_argument('--commit',required=True);parser.add_argument('--baseline',default='matrix/unicode-heldout-v1/summary.json');args=parser.parse_args()
    psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
    out=R/args.output;out.mkdir(parents=True,exist_ok=False)
    baseline=json.loads((R/args.baseline).read_text());rows={};blockers=collections.defaultdict(list)
    for name,versions in baseline['programs'].items():
        source=str(Path(args.source).resolve());env=dict(os.environ,PYTHONPATH=source,MATRIX_PRODUCT_SOURCE=source)
        temporary=out/(name+'-tmp');temporary.mkdir()
        for key in ('TEMP','TMP','TMPDIR'):env[key]=str(temporary)
        env['RECOMPYLER_CACHE']=str(temporary/'cache')
        with (out/(name+'.stdout')).open('wb') as stdout,(out/(name+'.stderr')).open('wb') as stderr:
            result=subprocess.run([sys.executable,str(R/'matrix/heldout_native.py'),name,str(out/name)],env=env,cwd=R,stdout=stdout,stderr=stderr,timeout=1800)
        if result.returncode:raise RuntimeError((name,result.returncode))
        record=json.loads((out/name/'results.json').read_text());rows[name]={'before':versions['after'],'after':record}
        for row in record['rows']:
            if row['captured'] and not row['whole_function_native']:
                candidate=row['candidate'];reason=candidate.get('region_reason') or candidate.get('reason') or candidate['status']
                blockers[first_failure(reason)].append({'program':name,'function':row['function'],'line':row['line'],'reason':reason})
        print(name,{k:record[k]for k in ('captured','verified','whole_function_native','deployed')},flush=True)
    totals={variant:{k:sum(record[variant][k]for record in rows.values())for k in ('own_defined','captured','verified','whole_function_native','deployed')}for variant in ('before','after')}
    ranked=sorted([{'first_failure':key,'functions':len(value),'rows':value}for key,value in blockers.items()],key=lambda row:(-row['functions'],row['first_failure']))
    report={'commit':args.commit,'programs':rows,'totals':totals,'all_defined':375,'all_first_failures':ranked,'note':'Previous complete cohort compared with fresh complete-call replay; unobserved definitions never inferred native; no deployment or speed claim.'}
    (out/'summary.json').write_text(json.dumps(report,indent=2),encoding='utf-8');print(json.dumps(totals),flush=True)
if __name__=='__main__':main()
