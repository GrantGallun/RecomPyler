"""One postcommit correctness matrix/capture refresh, no reported timings."""
from concurrent.futures import ThreadPoolExecutor
import io,json,os,subprocess,sys,tarfile
from pathlib import Path
import psutil
R=Path(__file__).resolve().parents[1]
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
commit=subprocess.check_output(['git','-c','safe.directory=*','rev-parse','HEAD'],cwd=R,text=True).strip()
export=R/'matrix/temp/native-family-report-source';export.mkdir(exist_ok=False)
archive=subprocess.check_output(['git','-c','safe.directory=*','archive',commit,'src'],cwd=R)
with tarfile.open(fileobj=io.BytesIO(archive)) as tree:tree.extractall(export,filter='data')
import shutil
for binary in (R/'src/recompyler').glob('*.pyd'):shutil.copy2(binary,export/'src/recompyler'/binary.name)
source=export/'src';temporary=R/'matrix/temp/native-family-report';temporary.mkdir(exist_ok=True)
env=dict(os.environ,PYTHONPATH=str(source),MATRIX_PRODUCT_SOURCE=str(source),TEMP=str(temporary),TMP=str(temporary),RECOMPYLER_CACHE=str(temporary/'cache'),NUMBA_CACHE_DIR=str(temporary/'numba'))
flags=subprocess.BELOW_NORMAL_PRIORITY_CLASS|subprocess.CREATE_NO_WINDOW
print(json.dumps(dict(pid=os.getpid(),commit=commit,source=str(source),kind='correctness only')),flush=True)
def run(command,log):
    with (R/'matrix'/log).open('wb') as stream:
        child=subprocess.Popen(command,cwd=R,env=env,stdout=stream,stderr=subprocess.STDOUT,creationflags=flags)
        print(json.dumps(dict(child=child.pid,command=command,log=log)),flush=True)
        status=child.wait()
    print(json.dumps(dict(log=log,exit=status)),flush=True)
    if status:raise RuntimeError((log,status))
def matrix():
    run([sys.executable,str(R/'matrix/run_matrix.py'),'--output','matrix/native-family-postcommit.jsonl'],'native-family-postcommit-matrix.log')
    records=[json.loads(line) for line in (R/'matrix/native-family-postcommit.jsonl').read_text().splitlines()]
    from collections import Counter
    print(json.dumps(dict(matrix=Counter(row.get('verdict',row.get('status','unknown')) for row in records))),flush=True)
def heldout():
    output=R/'matrix/native-family-postcommit-heldout';output.mkdir(exist_ok=False)
    manifest=json.loads((R.parent/'wave14-capture/capture/input-manifest.json').read_text())
    programs=[row['name'] for row in manifest['workloads'] if row['name'] not in {'asyncio_tcp','asyncio_websockets','fastapi'}]
    result=dict(commit=commit,programs={},fixed_all_program_defined=375,note='Fresh complete-call results; no deployment or speed claim.')
    for name in programs:
        target=output/name
        run([sys.executable,str(R/'matrix/heldout_native.py'),name,str(target)],'native-family-heldout-'+name+'.log')
        record=json.loads((target/'results.json').read_text());result['programs'][name]=record
        print(json.dumps(dict(program=name,**{key:record[key] for key in ('own_defined','captured','verified','whole_function_native','deployed')})),flush=True)
    result['totals']={key:sum(row[key] for row in result['programs'].values()) for key in ('own_defined','captured','verified','whole_function_native','deployed')}
    result['totals']['whole_function_share_of375']=result['totals']['whole_function_native']/375
    groups={}
    for program,record in result['programs'].items():
        for row in record['rows']:
            if row['whole_function_native']:continue
            reason=row.get('candidate',{}).get('reason','uncaptured')
            group=groups.setdefault(reason,dict(first_failure=reason,functions=0,programs=set(),rows=[]))
            group['functions']+=1;group['programs'].add(program);group['rows'].append(dict(program=program,function=row['function'],line=row['line']))
    result['first_failures']=[dict(group,programs=sorted(group['programs']),program_count=len(group['programs'])) for group in sorted(groups.values(),key=lambda row:(-row['functions'],row['first_failure']))]
    (output/'summary.json').write_text(json.dumps(result,indent=2))
    print(json.dumps(dict(heldout=result['totals'])),flush=True)
with ThreadPoolExecutor(max_workers=2) as pool:
    jobs=[pool.submit(matrix),pool.submit(heldout)]
    for job in jobs:job.result()
print('COMPLETE postcommit matrix and heldout',flush=True)
