"""Read CPython's scalar performance clock through Numba's extension API.

The raw API does not run Python or access region objects. Its error code is
returned to the generated status guard, so a clock failure uses Python replay.
Seconds use CPython's own conversion, including its rounding behavior.
"""
import ctypes
from llvmlite import binding, ir
from numba import types
from numba.core import cgutils
from numba.extending import intrinsic

for _name in ('PyTime_PerfCounterRaw', 'PyTime_AsSecondsDouble'):
    binding.add_symbol(_name, ctypes.cast(getattr(ctypes.pythonapi, _name), ctypes.c_void_p).value)


@intrinsic
def perf_counter(typingctx):
    result_type = types.Tuple((types.int32, types.float64))

    def codegen(context, builder, signature, args):
        i64 = ir.IntType(64)
        slot = cgutils.alloca_once_value(builder, ir.Constant(i64, 0))
        clock = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(ir.IntType(32), [i64.as_pointer()]), 'PyTime_PerfCounterRaw')
        convert = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(ir.DoubleType(), [i64]), 'PyTime_AsSecondsDouble')
        status = builder.call(clock, [slot])
        value = builder.call(convert, [builder.load(slot)])
        return context.make_tuple(builder, result_type, [status, value])

    return result_type(), codegen


IMPORT = 'from recompyler._clock import perf_counter as scalar_perf_counter\n'
