"""Resident exact pointwise array workload; no default entry is installed."""
import argparse
import ctypes
import hashlib
import os
import sys
import numpy as np
from bench.libs.timing_worker import serve,jit_enabled


def affine(array,output):
    for index in range(len(array)):
        output[index]=array[index]*2.0+1.0
    return output


def array_digest(array):return hashlib.sha256(array.tobytes()).hexdigest()


def prepare_native(array,output,expected):
    from recompyler.libraries.numpy_models import NumpyCalls
    from recompyler.ir import build,compilation_info
    from recompyler.ir.lower_llvm import lower
    from recompyler.ir.structure_lowerings import specialize_structure_calls,select_structure_calls
    from recompyler.ir.symbols import CPythonSymbols
    from recompyler import _structure_ops_native
    from recompyler.ir._entry_native import prepare_frame_entry,forget_compilation,_compilation_owner
    from tools.ir_self_host import CountedBody,install_candidate
    graph=specialize_structure_calls(build(affine),immediate_offsets=True)
    graph=select_structure_calls(graph,{'getitem','setitem','load_attr','store_attr','contains'})
    calls=NumpyCalls(CPythonSymbols(),_structure_ops_native)
    lowered=lower(graph,frame_entry=True,structure_calls=calls,owned_readonly_loops=True)
    owner=lowered.execution_owner;counter=CountedBody(owner)
    prepare_frame_entry(affine,counter.body_address,counter,graph.code)
    if not install_candidate(affine):raise RuntimeError('counted native array entry declined')
    counter.calls.value=0
    for _ in range(2):assert array_digest(affine(array,output))==expected
    entries=counter.calls.value
    if entries<2:raise RuntimeError('native array body not exercised')
    forget_compilation(affine)
    prepare_frame_entry(affine,owner.body_address,owner,graph.code)
    if not install_candidate(affine):raise RuntimeError('ordinary native array entry declined')
    def live():
        state=_compilation_owner(affine)
        return int(bool(state and state[1] is owner and (compilation_info(affine) or {}).get('installed')))
    return dict(native_entries=entries,counted_wrappers_installed=0,ordinary_entries_live=live(),
                primitive_counters_installed=False),live


def main(argv=None):
    parser=argparse.ArgumentParser()
    parser.add_argument('name')
    parser.add_argument('--mode',choices=('stock','jit','native','gpu'),required=True)
    args=parser.parse_args(argv)
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    if not args.name.startswith('affine-'):raise ValueError('unknown numeric workload')
    size=int(args.name.removeprefix('affine-'))
    if size<1 or size>2**22:raise ValueError('array size outside benchmark bounds')
    array=np.arange(size,dtype='float64')/1024.0;output=np.empty_like(array)
    expected=array_digest(affine(array,output));live=None;extra={}
    if args.mode=='native':
        extra,live=prepare_native(array,output,expected)
        run=lambda:affine(array,output)
    elif args.mode=='gpu':
        from recompyler.ir import build
        from recompyler.libraries.gpu import plan_loop,GpuLoop
        candidate=GpuLoop(plan_loop(build(affine)))
        run=lambda:candidate.execute(affine,array,output)
        assert array_digest(run())==expected
        if candidate.last_backend!='cuda':raise RuntimeError(candidate.note)
        live=lambda:int(candidate.last_backend=='cuda')
        extra=dict(backend='cuda',transfers_included=True,verified_shapes=len(candidate.verified_shapes),
                   fastmath=candidate.fastmath,lto=candidate.lto)
    else:run=lambda:affine(array,output)
    warmup=8
    for _ in range(warmup):assert array_digest(run())==expected
    serve(run,expected,dict(mode=args.mode,jit=jit_enabled(),warmup=warmup,python=sys.version.split()[0],
                           array_size=size,**extra),live=live,digest=array_digest)


if __name__=='__main__':main()
