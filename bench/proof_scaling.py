"""Locked S99 scaling of proof analyses; never a whole-compiler T1 claim."""
import argparse
import dis
import gc
import hashlib
import json
import math
import os
from pathlib import Path
import statistics
import subprocess
import sys
from time import perf_counter

ROOT=Path(__file__).resolve().parents[1]


def growth_exponent(points):
    if len(points)<2 or any(not math.isfinite(x) or not math.isfinite(y) or x<=0 or y<=0 for x,y in points):
        raise ValueError('at least two positive finite points required')
    xs=[math.log(x) for x,y in points];ys=[math.log(y) for x,y in points]
    center=statistics.mean(xs);variance=sum((x-center)**2 for x in xs)
    if not variance:raise ValueError('distinct sizes required')
    return sum((x-center)*(y-statistics.mean(ys)) for x,y in zip(xs,ys))/variance


def make_case(size,family):
    """Real boxed CFGs and explicit backend-private raw work models."""
    from recompyler.ir.builder import build
    from recompyler.ir.ops import Block,FunctionIR,Operation,Value
    from recompyler.ir.types import INT64
    from recompyler.ir.memory_proofs import MemoryEffect,Location
    from recompyler.ir.virtual_proofs import RAW_RECORD,VirtualEffect
    if type(size) is not int or size<1:raise ValueError('positive input size required')
    statement='    if x: x=x+0\n' if family=='branchy' else '    x=x+0\n'
    namespace={};exec(compile('def scale_input(x):\n'+statement*size+'    return x\n','<proof-scaling-'+family+'>','exec'),namespace)
    fn=namespace['scale_input']
    if family in ('straight','branchy'):return fn,build(fn),{}
    if family not in ('raw_words','raw_heap','raw_virtual'):raise ValueError('unknown family')
    instructions=list(dis.get_instructions(fn));operations=[];effects={};next_id=0
    def value(kind=INT64):
        nonlocal next_id
        result=Value(next_id,kind);next_id+=1;return result
    def op(name,args=(),results=(),attributes=None,effect=None):
        instruction=instructions[len(operations)]
        result=Operation(name,args,results,instruction.offset,0,instruction,attributes or {})
        operations.append(result)
        if effect is not None:effects[result.offset]=effect
        return result
    seed=value();op('seed',results=(seed,))
    if family=='raw_words':
        zero=value();op('constant',results=(zero,),attributes={'argval':0})
        current=seed
        for _ in range(size):
            result=value();op('binary',(current,zero),(result,),{'oparg':0},MemoryEffect('pure',operator='add',inert=True,may_raise=False))
            op('sink',(result,));current=result
    elif family=='raw_heap':
        constants=[]
        for number in range(size):
            constant=value();op('constant',results=(constant,),attributes={'argval':number+1});constants.append(constant)
            current=value();op('binary',(seed,constant),(current,),{'oparg':0},MemoryEffect('pure',operator='add',inert=True,may_raise=False))
        for constant in constants:
            op('write',(seed,constant),effect=MemoryEffect('write',Location('private',seed.id,'value'),stored=constant.id,inert=True,may_raise=False))
    else:
        handles=[]
        for _ in range(size):
            handle=value(RAW_RECORD);handles.append(handle)
            op('alloc',(seed,),(handle,),effect=VirtualEffect('alloc',fields=('x',),invisible=True,inert=True))
        for handle in handles:
            current=value();op('read',(handle,),(current,),effect=VirtualEffect('read',field='x',inert=True))
        for handle in handles:op('release',(handle,),effect=VirtualEffect('release',inert=True))
    op('return',(current,))
    neutral=VirtualEffect('neutral',inert=True) if family=='raw_virtual' else MemoryEffect('neutral',inert=True,may_raise=False)
    for operation in operations:effects.setdefault(operation.offset,neutral)
    return fn,FunctionIR(fn,fn.__code__,0,{0:Block(0,(),operations,[])}),effects


def fingerprint(root):
    digest=hashlib.sha256()
    for path in sorted((root/'src').rglob('*')):
        if path.suffix in ('.py','.c','.h','.pyd'):
            digest.update(path.relative_to(root).as_posix().encode());digest.update(path.read_bytes())
    return digest.hexdigest()


def sample(call,repeats):
    call()  # Explicit warm-up: solver setup is reported by the separate cost cohort.
    times=[];limited=False;work=None;iterations=None
    for _ in range(repeats):
        start=perf_counter();result=call();times.append(perf_counter()-start)
        limited|=getattr(result,'limited',False)
        work=getattr(result,'work',None);iterations=getattr(result,'iterations',None)
        del result
        gc.collect()
    return dict(median_ms=statistics.median(times)*1000,p90_ms=sorted(times)[math.ceil(.9*len(times))-1]*1000,
                samples_ms=[x*1000 for x in times],limited=limited,work=work,iterations=iterations)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source-root',type=Path,default=ROOT)
    parser.add_argument('--sizes',nargs='+',type=int,default=[16,32,64,128,256])
    parser.add_argument('--repeats',type=int,default=3)
    parser.add_argument('--run-name',required=True);parser.add_argument('--ledger',type=Path,required=True)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    if len(set(args.sizes))<2 or any(not 1<=n<=4096 for n in args.sizes) or args.repeats<3:parser.error('two distinct bounded sizes and at least3 repetitions required')
    if os.name=='nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    source=args.source_root.resolve();sys.path.insert(0,str(source/'src'));sys.path.insert(1,str(ROOT))
    from recompyler.ir.builder import build
    from recompyler.ir.verifier import verify
    from recompyler.ir.int_analysis import analyze_intbounds
    from recompyler.ir.proof_checks import annotate_integer_proofs
    from recompyler.ir.memory_proofs import plan_memory
    from recompyler.ir.virtual_proofs import plan_virtuals
    from recompyler.ir.raw_passes import optimize_raw_memory,optimize_raw_words,optimize_raw_virtuals
    from bench.libs.runner import timing_lock
    from bench.libs.timing_runner import test_processes
    cases=[(family,n,make_case(n,family)) for family in ('straight','branchy','raw_words','raw_heap','raw_virtual') for n in sorted(set(args.sizes))]
    source_hash=fingerprint(source);harness_hash=hashlib.sha256(Path(__file__).read_bytes()).hexdigest();before=test_processes();rows=[]
    with timing_lock(ROOT.parent/'TIMING.lock',args.ledger,purpose='S99 proof analysis scaling',expected=180,run_name=args.run_name):
        if fingerprint(source)!=source_hash:raise ValueError('analysis source changed before cohort')
        for family,size,(function,graph,effects) in cases:
            if family in ('straight','branchy'):
                phases={'ir_build':lambda:build(function),'verify':lambda:verify(graph),'int_analysis':lambda:analyze_intbounds(graph),
                    'integer_annotation':lambda:annotate_integer_proofs(graph),'heap_plan':lambda:plan_memory(graph),'virtual_plan':lambda:plan_virtuals(graph)}
            elif family=='raw_words':phases={'word_consumer':lambda:optimize_raw_words(graph,effects)}
            elif family=='raw_heap':phases={'heap_consumer':lambda:optimize_raw_memory(graph,effects)}
            else:phases={'virtual_consumer':lambda:optimize_raw_virtuals(graph,effects)}
            bytecodes=len(list(dis.get_instructions(function)))
            for phase,call in phases.items():
                row=dict(family=family,size=size,bytecodes=bytecodes,phase=phase,**sample(call,args.repeats))
                row['ms_per_bytecode']=row['median_ms']/bytecodes;rows.append(row)
            print(family,size,'complete',flush=True)
        if fingerprint(source)!=source_hash or hashlib.sha256(Path(__file__).read_bytes()).hexdigest()!=harness_hash:
            raise ValueError('source or harness changed during cohort')
    groups={}
    for row in rows:groups.setdefault((row['family'],row['phase']),[]).append(row)
    summary=[]
    for (family,phase),group in groups.items():
        limited=any(r['limited'] for r in group)
        summary.append(dict(family=family,phase=phase,exponent=None if limited else growth_exponent([(r['bytecodes'],r['median_ms']) for r in group]),
            limited=limited,largest_ms_per_bytecode=group[-1]['ms_per_bytecode']))
    report=dict(source_root=str(source),head=subprocess.check_output(['git','-C',str(source),'rev-parse','HEAD'],text=True).strip(),
        dirty=bool(subprocess.check_output(['git','-C',str(source),'status','--porcelain','-uno'],text=True).strip()),source_sha256=source_hash,harness_sha256=harness_hash,
        python=sys.version,jit=bool(getattr(sys,'_jit',None) and sys._jit.is_enabled()),rows=rows,summary=summary,
        scope='analysis stages only; not complete T1/T2 compilation or runtime speed; one untimed warmup and cleanup outside each timed call',
        t1='unavailable here; copy-and-patch owner20',concurrent_tests_before=before,concurrent_tests_after=test_processes())
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(report,indent=2));print(json.dumps(summary),flush=True)


if __name__=='__main__':main()
