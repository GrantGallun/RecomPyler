"""Diagnostic adapter and S100 pass regressions; no alternate LLVM pipeline.

Collect with compile_scaling --compiler bench.libs.llvm_pass_scaling:compile_function.
Then postprocess that JSON with this module's --input/--output command. Diagnostic
IR snapshots add overhead and must never grade a T1 compile-time budget.
"""
import argparse
import json
from pathlib import Path
from statistics import median
from .llvm_pass_report import capture_passes,summarize

_last={}


def compile_function(function,*,strict=False):
    from llvmlite import binding
    from recompyler.ir import compile_function as canonical
    global _last
    _last={}
    with capture_passes(binding) as reports:
        result=canonical(function,strict=strict)
    _last={'pass_reports':reports}
    return result


compile_function.recompyler_tier='T2'
compile_function.diagnostic_only=True
compile_function.measurements=lambda:dict(_last)


def summarize_report(report):
    kinds={}
    for cohort in report['samples']:
        raw=cohort['attempts'][-1]['samples']
        if len(raw)<3 or not all(row.get('diagnostic_only') for row in raw):
            raise ValueError('three fresh diagnostic observations required')
        if len({row['bytecodes'] for row in raw})!=1: raise ValueError('bytecode shape changed')
        totals=[]
        for row in raw:
            snapshots=row.get('diagnostics',{}).get('pass_reports',[])
            if not snapshots: raise ValueError('LLVM pass timings missing')
            per={};lines=0;instructions=0
            for snapshot in snapshots:
                if not snapshot['modules']:raise ValueError('input IR volume missing')
                for name,seconds in snapshot['per'].items():per[name]=per.get(name,0)+seconds
                for module in snapshot['modules']:
                    lines+=module['llvm_lines']
                    if module.get('llvm_instructions') is None:instructions=None
                    elif instructions is not None:instructions+=module['llvm_instructions']
            totals.append(dict(per=per,llvm_lines=lines,llvm_instructions=instructions))
        names=set().union(*(row['per'] for row in totals))
        point=dict(bytecodes=raw[0]['bytecodes'],llvm_lines=median(row['llvm_lines'] for row in totals),
                   llvm_instructions=median(row['llvm_instructions'] for row in totals) if all(row['llvm_instructions'] is not None for row in totals) else None,
                   per={name:median(row['per'].get(name,0) for row in totals) for name in names})
        kinds.setdefault(cohort['kind'],[]).append(point)
    if set(kinds)!={'straight','branchy'}:raise ValueError('both scaling shapes required')
    summaries={kind:summarize(points) for kind,points in kinds.items()}
    verdicts=[summary['shape_budget_ok'] for summary in summaries.values()]
    verdict=False if False in verdicts else None if None in verdicts else True
    return dict(schema=1,source_sha256=report['source_sha256'],compiler=report['compiler'],diagnostic_only=True,
                shape_budget_ok=verdict,criteria='LCSSA exponent <=1.1 and input LLVM instruction lines/bytecode <10',
                kinds=summaries,points=kinds)


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input',type=Path,required=True);parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args(argv)
    report=summarize_report(json.loads(args.input.read_text()))
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(report,indent=2))
    return 0 if report['shape_budget_ok'] is True else 1


if __name__=='__main__':raise SystemExit(main())
