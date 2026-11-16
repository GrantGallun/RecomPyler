"""Build new prepared plans against the unchanged completed v4 common inputs.

Run only through inplace/run_locked.py. Each invocation requires new source and
result directories; incomplete/failed attempts are never reused.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

D=Path(__file__).resolve().parent
R=D.parent
W=R.parent


def read(path): return json.loads(Path(path).read_text(encoding='utf-8-sig'))
def write(path,value):
    with Path(path).open('x',encoding='utf-8') as f: json.dump(value,f,indent=2,allow_nan=False)
def inventory(root):
    return {p.relative_to(root).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(root.rglob('*')) if p.is_file() and '__pycache__' not in p.parts}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--variant',required=True)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--lock-label',required=True)
    parser.add_argument('--tests-receipt',type=Path,required=True)
    options=parser.parse_args()
    assert not (D/'prepared-cache-preparation/REVIEW-PENDING').exists(), 'Finish independent prepared-cache review before freezing new source'
    owner=(W/'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
    assert 'wave16-inplace' in owner and 'purpose: '+options.lock_label+'\n' in owner
    assert read(options.tests_receipt)['exit_code']==0
    assert options.variant and Path(options.variant).name==options.variant
    variant=D/'bases'/options.variant
    output=options.output.resolve()
    assert output.is_relative_to(D) and not output.exists() and not variant.exists()
    assert read(D/'logs/integration-smoke20-v4.receipt.json')['exit_code']==0
    shutil.copytree(R/'src',variant/'src',ignore=shutil.ignore_patterns('__pycache__','*.pyc'))
    source=variant/'src'
    manifest=inventory(source)
    write(variant/'source-manifest.json',manifest)
    output.mkdir()
    common=D/'integration-smoke20-v4'
    rows=[]
    try:
        for name in ('chaos','richards_super'):
            folder=output/name;folder.mkdir()
            temporary=folder/'temp';temporary.mkdir()
            old=common/name
            assert read(old/'complete.json')['behavior_preserved']
            original=read(old/'saved-0.receipt.json')['command']
            script=Path(read(old/'plan.json')['script']).resolve()
            arguments=original[original.index(str(script))+1:]
            assert script.is_relative_to(old/'input')
            env=os.environ.copy();env.pop('PYTHONDONTWRITEBYTECODE',None)
            env.update(PYTHONPATH=os.pathsep.join([str(common/'shim'),str(source),str(D)]),
                PYTHONPYCACHEPREFIX=str(output/'bytecode'),RECOMPYLER_CACHE=str(folder/'cache'),
                RECOMPYLER_CACHE_DIR=str(folder/'cache'),NUMBA_CACHE_DIR=str(folder/'numba'),
                TEMP=str(temporary),TMP=str(temporary),PYTHONHASHSEED='0',PYTHONWARNINGS='ignore',
                PYTHONIOENCODING='utf-8:strict',PYTHONUTF8='1',OMP_NUM_THREADS='1',
                OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
            command=[sys.executable,str(D/'capture_profile_s23.py'),str(script),str(folder/'plan.json'),*arguments]
            write(folder/'profile.invocation.json',dict(command=command,cwd=str(script.parent),environment={k:env[k] for k in ('PYTHONPATH','RECOMPYLER_CACHE','PYTHONPYCACHEPREFIX','TEMP','TMP')}))
            start=time.perf_counter()
            with (folder/'profile.stdout').open('xb') as out,(folder/'profile.stderr').open('xb') as err:
                child=subprocess.run(command,cwd=script.parent,env=env,stdout=out,stderr=err)
            write(folder/'profile.receipt.json',dict(exit_code=child.returncode,wall_s=time.perf_counter()-start))
            assert child.returncode==0,(name,child.returncode)
            report=read(folder/'plan.json');section=report['plan']['aot_regions']
            assert report['plan']['worth_running'] and section['prepared']['cores']
            details=dict(name=name,complete=True,plan_sha256=hashlib.sha256((folder/'plan.json').read_bytes()).hexdigest(),
                cores=len(section['prepared']['cores']),diagnostics=section['prepared']['diagnostics'],
                captured=sum(r['captured'] for r in read(folder/'plan.inventory.json')['capture_inventory']),
                verified=sum(r.get('candidate',{}).get('status')=='verified' for r in report['functions']))
            write(folder/'complete.json',details);rows.append(details)
            print(json.dumps(details),flush=True)
        assert inventory(source)==manifest
        write(output/'summary.json',dict(complete=True,variant=options.variant,programs=rows,timing_eligible=False))
        write(variant/'complete.json',dict(complete=True,source_manifest_sha256=hashlib.sha256((variant/'source-manifest.json').read_bytes()).hexdigest(),plan_root=str(output)))
    except BaseException as exc:
        write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False))
        raise


if __name__=='__main__':main()
