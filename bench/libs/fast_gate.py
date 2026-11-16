"""Full fast gate in fresh pytest groups, to bound cumulative LLVM memory."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import ctypes
import json
import os
from pathlib import Path
import subprocess
import sys
import time
from tools.affected_tests import cache_environment


def plan_batches(root,count):
    if count<1:raise ValueError('batch count must be positive')
    root=Path(root)
    files=sorted((root/'tests').glob('test_*.py'))
    batches=[[] for _ in range(min(count,len(files)))];loads=[0]*len(batches)
    for path in sorted(files,key=lambda path:(-path.stat().st_size,path.name)):
        index=loads.index(min(loads))
        batches[index].append(path.relative_to(root).as_posix())
        loads[index]+=path.stat().st_size
    return [sorted(batch) for batch in batches]


def run_gate(root,label,*,workers=1,batches=8,run=subprocess.run):
    if workers not in (1,2):raise ValueError('workers must be 1 or 2')
    if not label or Path(label).name!=label:raise ValueError('label must be a filename component')
    root=Path(root).resolve();groups=plan_batches(root,batches)
    if not groups:raise ValueError('no fast-suite test files')
    evidence=root/'.cache'/'wave21-evidence';evidence.mkdir(parents=True,exist_ok=True)
    env=cache_environment(root,force=True)
    env["PYTEST_ADDOPTS"]=""
    start=time.monotonic()
    def execute(pair):
        index,paths=pair
        log=evidence/f'{label}-batch{index}.log'
        command=[sys.executable,'-m','pytest','-q','-m','not slow',
                 '--basetemp='+str(root/'.cache'/f'{label}-batch{index}'),*paths]
        with log.open('w',encoding='utf-8') as stream:
            stream.write('Command: '+repr(command)+'\n');stream.flush()
            result=run(command,cwd=root,env=env,stdout=stream,stderr=subprocess.STDOUT,
                       creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
        print(f'batch={index} exit={result.returncode} files={len(paths)} log={log.name}',flush=True)
        return {'index':index,'paths':paths,'returncode':result.returncode,'log':log.name}
    with ThreadPoolExecutor(max_workers=workers) as pool:
        rows=list(pool.map(execute,enumerate(groups)))
    # Exit 5 is pytest's normal result for a group containing only slow tests.
    report={'ok':all(row['returncode'] in (0,5) for row in rows),'tier':'fast','workers':workers,
            'test_files':sum(map(len,groups)),'wall_seconds':time.monotonic()-start,'batches':rows}
    (evidence/f'{label}.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(f'fast_gate_ok={report["ok"]} files={report["test_files"]} workers={workers}',flush=True)
    return report


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('label');parser.add_argument('--workers',type=int,choices=(1,2),default=1)
    parser.add_argument('--batches',type=int,default=8)
    args=parser.parse_args(argv)
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    return 0 if run_gate(Path(__file__).resolve().parents[2],args.label,workers=args.workers,batches=args.batches)['ok'] else 1


if __name__=='__main__':raise SystemExit(main())
