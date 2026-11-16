"""Diagnostic cProfile attribution, never a whole-call acceptance sample."""
from pathlib import Path
import argparse,cProfile,json,os,pstats,subprocess,sys
import step0_guard_ablation as ab
D=ab.D;R=ab.R;W=ab.W

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);p.add_argument('--lock-label',required=True);p.add_argument('--child',action='store_true');p.add_argument('--kernel',choices=ab.NAMES);p.add_argument('--mode',choices=('full','without-lifetime'));p.add_argument('--report',type=Path);o=p.parse_args()
    assert 'purpose: '+o.lock_label+'\n' in (W/'TIMING.lock/owner.txt').read_text()
    if o.child:
        o.audit=False;profile=cProfile.Profile();profile.enable()
        try:ab.child(o)
        finally:
            profile.disable();stats=pstats.Stats(profile)
            rows=[dict(file=f,line=line,name=name,primitive_calls=cc,calls=nc,self_s=tt,cumulative_s=ct) for (f,line,name),(cc,nc,tt,ct,callers) in stats.stats.items()]
            ab.write(o.report.with_suffix('.profile.json'),dict(diagnostic_only=True,profiler_overhead_retained=True,rows=rows))
        return
    output=o.output.resolve();assert output.is_relative_to(D) and not output.exists();output.mkdir()
    frozen=dict(common=ab.frozen_inputs(),profile_helper=ab.sha(__file__));ab.write(output/'freeze.json',frozen);summary={}
    try:
        for name in ab.NAMES:
            folder=output/name;folder.mkdir();summary[name]={}
            reference=(ab.application((W/'wave11-ledger/gap-ledger/work'/name/'plain-0.stdout').read_bytes()),(W/'wave11-ledger/gap-ledger/work'/name/'plain-0.stderr').read_bytes())
            for mode in ('full','without-lifetime'):
                stem=folder/mode;report=stem.with_suffix('.counts.json');cmd=[sys.executable,str(Path(__file__).resolve()),'--output',str(output),'--lock-label',o.lock_label,'--child','--kernel',name,'--mode',mode,'--report',str(report)]
                env=os.environ.copy();env['PYTHONWARNINGS']='ignore';env['PYTHONPYCACHEPREFIX']=str(output/'bytecode')
                with stem.with_suffix('.stdout').open('xb') as stdout,stem.with_suffix('.stderr').open('xb') as stderr:
                    child=subprocess.run(cmd,cwd=R,env=env,stdout=stdout,stderr=stderr)
                ab.write(stem.with_suffix('.receipt.json'),dict(command=cmd,exit_code=child.returncode,timing_eligible=False));assert child.returncode==0
                assert (ab.application(stem.with_suffix('.stdout').read_bytes()),stem.with_suffix('.stderr').read_bytes())==reference
                data=json.loads(report.read_text());plan=json.loads((D/'artifacts'/ab.V/name/'plan.json').read_text());expected=json.loads((W/'wave11-ledger/gap-ledger/work'/name/'audit.counts.json').read_text())
                assert {ab.key(r):r['aot_calls'] for r in ab.product_functions(data,plan)}=={ab.key(r):5*r['aot_calls'] for r in ab.product_functions(expected,plan)}
                assert all(r['compiled_calls']==r['aot_calls'] and r['jit_calls']==r['fallback_calls']==0 for r in data['functions'])
                stats=json.loads(report.with_suffix('.profile.json').read_text())
                summary[name][mode]=[r for r in stats['rows'] if r['name'] in ('guards_hold','_has_finalizer','_plain_allocation','attempt','_pack_call','_run','<lambda>') and ('recompyler' in r['file'] or 'step0_guard_ablation' in r['file'])]
        assert frozen==dict(common=ab.frozen_inputs(),profile_helper=ab.sha(__file__))
        ab.write(output/'complete.json',dict(complete=True,diagnostic_only=True,profiler_overhead_retained=True,summary=summary));print(json.dumps(summary),flush=True)
    except BaseException as exc:
        ab.write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False));raise
if __name__=='__main__':main()
