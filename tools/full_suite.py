"""Warm fast commit gate; --include-slow runs the integration tier as well."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import ctypes
import os
from pathlib import Path
import subprocess
import sys
import time
from affected_tests import cache_environment


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('label')
    parser.add_argument('--include-slow',action='store_true')
    parser.add_argument('--chunks',type=int,default=0,help='fresh process chunks; bounds retained compiler memory')
    parser.add_argument('--workers',type=int,default=int(os.environ.get('WAVE18_CORRECTNESS_WORKERS','2')))
    args=parser.parse_args(argv)
    if not 1<=args.workers<=2:parser.error('workers must be between 1 and 2')
    if not 0<=args.chunks<=64:parser.error('chunks must be between 0 and 64')
    if Path(args.label).name!=args.label:parser.error('label must be a filename component')
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    root=Path(__file__).resolve().parents[1]
    evidence=root/'.cache/evidence';evidence.mkdir(parents=True,exist_ok=True)
    files=sorted((root/'tests').glob('test_*.py'))
    chunks=min(len(files),args.chunks or args.workers)
    shards=[[] for _ in range(chunks)];loads=[0]*chunks
    for path in sorted(files,key=lambda p:p.stat().st_size,reverse=True):
        index=loads.index(min(loads));shards[index].append(str(path.relative_to(root)))
        loads[index]+=path.stat().st_size
    env=cache_environment(root,force=True)
    env['PYTHONPATH']=str(root/'src')
    start=time.monotonic()
    def run(pair):
        index,paths=pair
        log=evidence/(args.label+'-shard'+str(index)+'.log')
        temp=evidence/'temp'/(args.label+'-'+str(index))
        temp.parent.mkdir(parents=True,exist_ok=True)
        command=[sys.executable,'-m','pytest','-q','--basetemp='+str(temp)]
        if not args.include_slow:command+=['-m','not slow']
        command+=sorted(paths)
        with log.open('w',encoding='utf-8') as stream:
            stream.write('Command: '+repr(command)+'\n');stream.flush()
            result=subprocess.run(command,cwd=root,env=env,stdout=stream,stderr=subprocess.STDOUT,
                                  creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
        print('shard',index,'exit',result.returncode,'log',log.name,flush=True)
        return result.returncode
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        codes=list(pool.map(run,enumerate(shards)))
    print('tier='+('full' if args.include_slow else 'fast'),'wall_seconds='+str(round(time.monotonic()-start,3)),
          'workers='+str(args.workers),flush=True)
    return max(codes,default=0)

if __name__=='__main__':raise SystemExit(main())
