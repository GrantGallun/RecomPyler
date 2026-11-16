"""Compile-only native IR census over an unchanged legacy baseline population.

Never calls a target. Actual native machine code, installation and execution
are separate columns. Source additions cannot inflate the 1827-function baseline.
"""
import argparse
from collections import Counter,defaultdict,deque
from concurrent.futures import ThreadPoolExecutor,as_completed
from datetime import datetime,timezone
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time


def match_baseline(baseline,current):
    indices=defaultdict(deque)
    for row in current:indices[row['qualname']].append(row['index'])
    return [(row['index'],indices[row['qualname']].popleft() if indices[row['qualname']] else None)
            for row in baseline]


def worker(repo,relative,baseline):
    from self_census import inventory,source_functions,_priority
    _priority();sys.path.insert(0,str(repo/'src'))
    from recompyler.ir import compile_function
    from recompyler.ir.semantics import UnsupportedBytecode
    from recompyler.ir._entry_native import compilation_info
    path=repo/relative;namespace={};import_error=None
    name='.'.join(Path(relative).with_suffix('').parts[1:]).removesuffix('.__init__')
    try:
        module=importlib.import_module(name)
        if Path(module.__file__).resolve()!=path.resolve():raise RuntimeError('different source checkout')
        namespace=vars(module).copy()
    except Exception as error:import_error=type(error).__name__+': '+str(error)
    current=inventory(path);functions=source_functions(path,namespace)
    for old_index,new_index in match_baseline(baseline,current):
        row=dict(index=old_index,path=relative,execution_verified=False,installed=False,native_compiled=False,native_prefix=False)
        if new_index is None:
            row.update(status='missing',reason='baseline definition no longer present')
        else:
            function=functions[new_index]
            try:
                result=compile_function(function,strict=True)
                info=compilation_info(function)
                if result is function and info and info['compiled'] and info['body_address']>0:
                    row.update(status='compiled',native_compiled=True,installed=info['installed'],native_prefix=bool(info.get('native_prefix',False)),compilation_kind=info.get('compilation_kind','native-body'),reason=None)
                else:row.update(status='error',reason='no actual native body')
            except (UnsupportedBytecode,NotImplementedError) as error:
                row.update(status='declined',reason=str(error))
            except Exception as error:
                row.update(status='error',reason=type(error).__name__+': '+str(error))
        row['import_error']=import_error
        print(json.dumps(row),flush=True)


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo',type=Path,default=Path(__file__).resolve().parents[1])
    parser.add_argument('--baseline',type=Path)
    parser.add_argument('--output',type=Path)
    parser.add_argument('--workers',type=int,choices=(1,2,3),default=3)
    parser.add_argument('--budget-seconds',type=float,default=1800)
    parser.add_argument('--module-timeout',type=float,default=180)
    parser.add_argument('--worker')
    args=parser.parse_args(argv)
    from self_census import _priority
    _priority();repo=args.repo.resolve()
    baseline_path=(args.baseline or repo.parent/'selfcompile-progress'/'self-census.json').resolve()
    baseline=json.loads(baseline_path.read_text(encoding='utf-8'))
    grouped=defaultdict(list)
    for row in baseline['functions']:grouped[row['path']].append(row)
    if args.worker:
        worker(repo,args.worker,grouped[args.worker]);return 0
    output=(args.output or repo.parent/'selfcompile-progress'/'wave18-lift-ir-census.json').resolve()
    scratch=repo/'.cache/evidence'/'ir-census';scratch.mkdir(parents=True,exist_ok=True)
    rows={(r['path'],r['index']):dict(r,legacy_status=r['status'],status='not-attempted',
        native_compiled=False,installed=False,execution_verified=False,native_prefix=False) for r in baseline['functions']}
    deadline=time.monotonic()+args.budget_seconds
    commit=subprocess.check_output(['git','-c','safe.directory=*','rev-parse','HEAD'],cwd=repo,text=True).strip()
    def publish():
        counts=Counter(r['status'] for r in rows.values())
        refusals=Counter(r.get('reason','') for r in rows.values() if r['status']=='declined')
        summary=dict(total=len(rows),ir_compiled=counts['compiled'],native_prefix=sum(r.get('native_prefix',False) for r in rows.values() if r['status']=='compiled'),installed=sum(r['installed'] for r in rows.values()),
            declined=counts['declined'],errors=counts['error'],missing=counts['missing'],unfinished=counts['not-attempted'],
            ranked_refusals=[dict(reason=k,functions=v) for k,v in refusals.most_common()])
        document=dict(schema=1,run='wave18-lift',updated_at=datetime.now(timezone.utc).isoformat(),
            commit=commit,baseline_commit=baseline['commit'],native_compilation_only=True,
            execution_verified=False,summary=summary,functions=list(rows.values()))
        temporary=output.with_suffix('.tmp');temporary.write_text(json.dumps(document,indent=2),encoding='utf-8')
        temporary.replace(output)
        return summary
    publish()
    def run(relative):
        timeout=min(args.module_timeout,deadline-time.monotonic())
        if timeout<=0:return []
        stem=relative.replace('/','_');log=scratch/(stem+'.jsonl');errors=scratch/(stem+'.log')
        with log.open('w',encoding='utf-8') as stream,errors.open('w',encoding='utf-8') as err:
            process=subprocess.Popen([sys.executable,str(Path(__file__).resolve()),'--repo',str(repo),
                '--baseline',str(baseline_path),'--worker',relative],cwd=repo,stdout=stream,stderr=err,
                creationflags=0x08004000 if os.name=='nt' else 0)
            try:process.wait(timeout=timeout)
            except subprocess.TimeoutExpired:process.kill();process.wait()
        records=[]
        for line in log.read_text(encoding='utf-8').splitlines():
            try:
                row=json.loads(line)
                if isinstance(row,dict) and 'index' in row:records.append(row)
            except json.JSONDecodeError:pass
        print(relative,len(records),'records','exit',process.returncode,flush=True)
        return records
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        for job in as_completed([pool.submit(run,path) for path in grouped]):
            for row in job.result():rows[(row['path'],row['index'])].update(row)
            publish()
    summary=publish()
    history=dict(updated_at=datetime.now(timezone.utc).isoformat(),commit=commit,
        ir_compiled=summary['ir_compiled'],ir_total=summary['total'],ir_installed=summary['installed'],ir_native_prefix=summary['native_prefix'],
        native_compilation_only=True,summary={**baseline['summary'],'ir_path':summary})
    with (output.parent/'history.jsonl').open('a',encoding='utf-8') as stream:
        stream.write(json.dumps(history)+'\n')
    print(json.dumps(summary,indent=2),flush=True)
    return int(bool(summary['errors'] or summary['missing'] or summary['unfinished']))


if __name__=='__main__':raise SystemExit(main())
