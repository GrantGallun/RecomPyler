"""Unadmitted measurement adapter over the one common IR LLVM lowerer."""
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import create_callable
from recompyler import _source_frames_native as provider


def compile_probe(function):
    result=lower(build(function))
    return create_callable(function,result.body_address,result.keepalive,
        runner_address=provider.addresses()['run_vectorcall'])
