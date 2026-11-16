"""Diagnostic only: remove coverage lifetime checks to size their whole-call cost.
The ablated rule is unsound generally and cannot be accepted or deployed.
"""
from pathlib import Path
import argparse, ast, hashlib, json, os, statistics, subprocess, sys
D=Path(__file__).resolve().parent; R=D.parent; W=R.parent
V='integration-depth-prepared-v1'; NAMES=('barnes_hut','scimark')
from heldout_identity import product_functions, native_reconciles, key
from step0_final_cohort import seal
def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,v):
    with Path(p).open('x',encoding='utf-8') as f: json.dump(v,f,indent=2)
def inventory(p):
    return {x.relative_to(p).as_posix():sha(x) for x in sorted(p.rglob('*')) if x.is_file() and '__pycache__' not in x.parts and x.suffix not in ('.pyc','.pyo','.nbi','.nbc')}
def application(raw):
    return b''.join(line for line in raw.splitlines(keepends=True) if not (len(line.split())==2 and line.split()[0].startswith(b'seconds')))
def frozen_inputs():
    files=[Path(__file__),D/'capture_audit.py',D/'heldout_identity.py',D/'step0_final_cohort.py']
    files += [W/'wave5-study/results/drivers'/(n+'.py') for n in NAMES]
    files += [W/'wave11-ledger/gap-ledger/work'/n/f for n in NAMES for f in ('audit.counts.json','plain-0.stdout','plain-0.stderr')]
    return dict(builds={v:seal(v,require_build=True) for v in (V,'depth-tip-v1')}, files={str(p):sha(p) for p in files},shim=inventory(W/'wave5-study/results/shim'))

def child(o):
    source=D/'bases'/V/'src'; sys.path[:0]=[str(source),str(W/'wave5-study/results/shim'),str(D)]
    from recompyler import heap,lift
    from recompyler.runner import run_script
    if o.mode=='without-lifetime':
        # Retain the call/guard loop: this sizes only the MRO/allocation scans.
        lift._has_finalizer=lambda cls: False
        lift._plain_allocation=lambda cls: True
        # AOT Lift has no records. Restore its actual committed flat guard loop.
        tree=ast.parse((D/'bases/depth-tip-v1/src/recompyler/lift.py').read_text())
        unit=next(n for n in tree.body if isinstance(n,ast.ClassDef) and n.name=='_Unit')
        fn=next(n for n in unit.body if isinstance(n,ast.FunctionDef) and n.name=='guards_hold')
        ns={};exec(compile(ast.fix_missing_locations(ast.Module(body=[fn],type_ignores=[])),'<committed-flat-guards>','exec'),vars(lift),ns)
        original=ns['guards_hold']
        # Avoid a Python wrapper in latency samples; AotLifted construction
        # already rejects every record class before any accepted entry.
        lift._Unit.guards_hold=original
    auditor=None
    if o.audit:
        from capture_audit import Auditor
        from recompyler.aot import AotLifted
        auditor=Auditor();auditor.patch_region(heap.Region);auditor.patch_lifted(lift.Lifted,AotLifted);auditor.start_profile()
    report=None
    try:
        report=run_script(W/'wave5-study/results/drivers'/(o.kernel+'.py'),['5'],D/'artifacts'/V/o.kernel/'plan.json',True)
    finally:
        if auditor:
            observed=auditor.result();auditor.restore();write(o.report.with_suffix('.audit.json'),observed)
        if report is not None: write(o.report,report)
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);p.add_argument('--lock-label',required=True)
    p.add_argument('--child',action='store_true');p.add_argument('--kernel',choices=NAMES);p.add_argument('--mode',choices=('full','without-lifetime'));p.add_argument('--report',type=Path);p.add_argument('--audit',action='store_true');o=p.parse_args()
    assert 'purpose: '+o.lock_label+'\n' in (W/'TIMING.lock/owner.txt').read_text()
    if o.child: child(o);return
    output=o.output.resolve();assert output.is_relative_to(D) and not output.exists();output.mkdir()
    frozen=frozen_inputs()
    write(output/'freeze.json',frozen);summary={}
    try:
        for name in NAMES:
            directory=output/name;directory.mkdir();rows=[];reference=None;expected=json.loads((W/'wave11-ledger/gap-ledger/work'/name/'audit.counts.json').read_text())
            plan=json.loads((D/'artifacts'/V/name/'plan.json').read_text())
            counts={key(row):5*row.get('aot_calls',0) for row in product_functions(expected,plan)}
            reference=(application((W/'wave11-ledger/gap-ledger/work'/name/'plain-0.stdout').read_bytes()),(W/'wave11-ledger/gap-ledger/work'/name/'plain-0.stderr').read_bytes())
            for rep in range(4):
                modes=('full','without-lifetime') if rep%2==0 else ('without-lifetime','full')
                row={}
                for mode in modes:
                    stem=directory/(mode+'-'+str(rep));report=stem.with_suffix('.counts.json')
                    cmd=[sys.executable,str(Path(__file__).resolve()),'--output',str(output),'--lock-label',o.lock_label,'--child','--kernel',name,'--mode',mode,'--report',str(report)]
                    if rep==3: cmd.append('--audit')
                    env=os.environ.copy();env['PYTHONWARNINGS']='ignore';env['PYTHONPYCACHEPREFIX']=str(output/'bytecode')
                    with stem.with_suffix('.stdout').open('xb') as out,stem.with_suffix('.stderr').open('xb') as err:
                        run=subprocess.run(cmd,cwd=R,env=env,stdout=out,stderr=err)
                    write(stem.with_suffix('.receipt.json'),dict(command=cmd,exit_code=run.returncode,timing_eligible=rep<3));assert run.returncode==0,(name,mode,rep)
                    data=json.loads(report.read_text());assert data['exit_code'] in (None,0) and not data['not_found'] and not data['batches'] and not data.get('batch_failures')
                    assert {key(r):r['aot_calls'] for r in product_functions(data,plan)}==counts
                    assert all(r['compiled_calls']==r['aot_calls'] and r['jit_calls']==r['fallback_calls']==0 for r in data['functions'])
                    stdout=stem.with_suffix('.stdout').read_bytes();app=(application(stdout),stem.with_suffix('.stderr').read_bytes())
                    if reference is None:reference=app
                    assert app==reference
                    if rep==3:
                        audit=json.loads(report.with_suffix('.audit.json').read_text());assert audit['audit_accounting_complete']
                        assert audit['totals']['aot_calls']==sum(counts.values()) and all(audit['totals'][k]==0 for k in ('jit_calls','unknown_native_calls','fallback_calls'))
                        assert all(r['unobserved_successes']==0 for r in audit['functions'])
                        assert native_reconciles(product_functions(data,plan),audit['independent_functions'])
                        for record in audit['functions']:
                            for program in record['programs'].values():
                                for event in program['native_events']:
                                    path=Path(event['module_path']).resolve()
                                    relative=path.relative_to((D/'artifacts'/V/name).resolve()).as_posix()
                                    assert frozen['builds'][V]['artifacts'][name][relative]==event['module_sha256']==sha(path)
                                    assert any(event['export'] in row['exports'].values() for section in ('aot','aot_regions') if plan['plan'].get(section) for row in plan['plan'][section]['functions'])
                    else:
                        values={a.decode():float(b)*1000 for line in stdout.splitlines() if len(line.split())==2 for a,b in [line.split()] if a.startswith(b'seconds')}
                        row[mode]=values['seconds_fft' if name=='scimark' else 'seconds']
                if rep<3:rows.append(row)
            summary[name]=dict(pairs=rows,medians_ms={m:statistics.median(row[m] for row in rows) for m in ('full','without-lifetime')},note='Unsound guard deletion diagnostic; same integrated native artifacts; final pair separately audited and excluded from timing.')
        assert frozen==frozen_inputs()
        write(output/'complete.json',dict(complete=True,diagnostic_only=True,summary=summary));print(json.dumps(summary),flush=True)
    except BaseException as exc:
        write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False));raise
if __name__=='__main__':main()
