"""Isolated diagnostic for executed native operations, never speed selection."""
import argparse
import json
from pathlib import Path
from bench.libs.workloads import output_digest


def run(name,output,split="train"):
    from bench.libs.programs import manifest
    cases=manifest(split)
    if name not in cases: raise ValueError("program outside split")
    if name=="selfcompile":
        report=dict(name=name,status="not-installed",native_entries=0,rows=[],bodies=[],mismatches=0,reason="default selfcompile installs no native functions; experimental compiler-self-installation is a separate owner18 acceptance capability")
        output.write_text(json.dumps(report,indent=2));return report
    from recompyler.ir import compiler
    from bench.libs.redundancy import instrument
    from bench.libs.diagnose import diagnose
    old=compiler.lower; owners=[];bodies=[]
    def lower(graph,**kwargs):
        with instrument(graph.code) as counts: lowered=old(graph,**kwargs)
        owners.append(counts)
        # Exactly one defined body in this module; .text bounds come from its
        # emitted object rather than a guessed interval between JIT addresses.
        from llvmlite import binding
        target=binding.Target.from_default_triple().create_target_machine()
        obj=binding.ObjectFileRef.from_data(target.emit_object(lowered.native_module))
        sizes=[section.size() for section in obj.sections() if section.is_text()]
        bodies.append(dict(start=lowered.body_address,size=sum(sizes),function=graph.code.co_qualname,
                           file=graph.code.co_filename,bounds='single-body object text extent'))
        return lowered
    compiler.lower=lower
    def completed(report,work,targets,counters):
        for _ in range(16):
            if output_digest(work())!=report['digest']: raise ValueError('diagnostic digest mismatch')
        result=dict(name=name,status=report['status'],digest=report['digest'],native_entries=report['native_entries'],
            rows=[row for owner in owners for row in owner.rows()],bodies=bodies,
            caveats=['diagnostic code only; counters change machine code and timings',
                     'helper calls counted; mutations/allocations hidden inside helpers unobserved',
                     'never_mattered unknown until semantic effect instrumentation exists',
                     'never_failed is observed only; independent proof required'],execution=report)
        output.write_text(json.dumps(result,indent=2))
    try: return diagnose(name,after_correctness=completed,cases=cases)
    finally: compiler.lower=old


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('name');p.add_argument('--output',type=Path,required=True)
    p.add_argument('--split',choices=['train','heldout'],default='train')
    args=p.parse_args();report=run(args.name,args.output,args.split)
    print(json.dumps({k:report[k] for k in ('name','status','native_entries','mismatches')}))
    return int(report['mismatches']!=0)


if __name__=='__main__':raise SystemExit(main())
