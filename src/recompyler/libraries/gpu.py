"""Conservative CUDA experiment consuming the shared SSA graph, never source AST.

No entry is installed. Only independent float64 pointwise loops are candidates;
reductions, callbacks, other arithmetic and overlapping arrays remain Python.
"""
import builtins
import ctypes
import os
from dataclasses import dataclass
import math
import sys
from types import FunctionType
import weakref


_LEN=len
_RANGE=range
_EXPECTED_BUILTINS={"len":_LEN,"range":_RANGE}


try:
    if os.name!='nt':raise OSError('floating-control provider unavailable')
    _crt=ctypes.CDLL('ucrtbase')
    _control=_crt._controlfp_s
    _control.argtypes=[ctypes.POINTER(ctypes.c_uint),ctypes.c_uint,ctypes.c_uint]
    _control.restype=ctypes.c_int
except (OSError,AttributeError):
    _control=None


def default_floating_mode():
    # Read the calling thread's CRT/MXCSR controls without changing them.
    # Windows float.h: RC_NEAR=0, DN_SAVE=0, all exceptions masked=0x8001f.
    if _control is None:return False
    current=ctypes.c_uint()
    return (_control(ctypes.byref(current),0,0)==0 and
            current.value & (0x300|0x03000000|0x8001f)==0x8001f)


# Resolve canonical objects through NumPy's implementation modules. Public
# aliases may already be rebound before this module is imported.
from numpy._core import multiarray as _multiarray,umath as _umath
from numpy._core import fromnumeric as _fromnumeric,_ufunc_config as _ufunc_config
_NUMPY_BINDINGS={
    'ndarray':_multiarray.ndarray,'dtype':_multiarray.dtype,
    'isfinite':_umath.isfinite,'abs':_umath.absolute,
    'max':_fromnumeric.max,'geterr':_ufunc_config.geterr,
    'empty_like':_multiarray.empty_like,'empty':_multiarray.empty,
    'array':_multiarray.array,'asarray':_multiarray.asarray,
    'asanyarray':_multiarray.asanyarray,'ascontiguousarray':_multiarray.ascontiguousarray,
}


class LoopDeclined(ValueError):pass


def _decline(message):raise LoopDeclined(message)


def _builtin(function,name):
    namespace=function.__globals__
    if name in namespace:return namespace[name]
    return function.__builtins__.get(name)


@dataclass(frozen=True)
class LoopPlan:
    code_reference:object
    input_slot:int
    output_slot:int
    expression:tuple

    def guard(self,function,args):
        import numpy as np
        if any(np.__dict__.get(name) is not value for name,value in _NUMPY_BINDINGS.items()):
            return 'NumPy helper binding changed'
        if type(function) is not FunctionType or function.__code__ is not self.code_reference():return 'code changed'
        if _LEN(args)!=2:return 'argument shape'
        if not default_floating_mode():return 'nondefault floating environment'
        if _builtin(function,'range') is not _RANGE or _builtin(function,'len') is not _LEN:return 'builtin binding changed'
        if sys.gettrace() is not None or sys.getprofile() is not None:return 'Python observer active'
        monitoring=getattr(sys,'monitoring',None)
        if monitoring and any(monitoring.get_events(tool) for tool in _RANGE(6)):return 'Python observer active'
        source,output=args[self.input_slot],args[self.output_slot]
        for array in (source,output):
            if type(array) is not np.ndarray:return 'exact ndarray required'
            if array.ndim!=1 or array.dtype!=np.dtype('float64') or not array.dtype.isnative:return 'float64 vector required'
            if not array.flags.c_contiguous or not array.flags.aligned:return 'contiguous aligned vector required'
        if not output.flags.writeable:return 'readonly output'
        if source.size!=output.size:return 'length mismatch'
        a,b=source.ctypes.data,output.ctypes.data
        if source.nbytes and a<b+output.nbytes and b<a+source.nbytes:return 'overlapping arrays'
        if np.geterr()['under']!='ignore':return 'underflow observation enabled'
        if not bool(np.isfinite(source).all()):return 'nonfinite input'
        bound=float(np.max(np.abs(source))) if source.size else 0.0
        def upper(expression):
            if expression[0]=='load':return bound
            if expression[0]=='constant':return abs(expression[1])
            left,right=upper(expression[1]),upper(expression[2])
            value=left*right if expression[0]=='multiply' else left+right
            # Round the magnitude bound outward at every operation.
            value=math.nextafter(value,math.inf)
            if not math.isfinite(value):raise OverflowError
            return value
        try:upper(self.expression)
        except OverflowError:return 'finite arithmetic not proven'
        return None


def plan_loop(graph):
    """Recognize a single independent loop in canonical FunctionIR operations."""
    function=graph.function
    if type(function) is not FunctionType or graph.exceptions:_decline('real unprotected Python function required')
    code=graph.code
    if code.co_argcount!=2 or code.co_kwonlyargcount or code.co_flags & (4|8|32|128|512) or code.co_freevars:_decline('two positional array arguments required')
    if _LEN(graph.blocks)!=4:_decline('single four-block loop required')
    entry=graph.blocks[graph.entry]
    if _LEN(entry.edges)!=1:_decline('one loop entry required')
    header=graph.blocks[entry.edges[0].target]
    if _LEN(header.operations)!=1 or header.operations[0].name!='for_iter':_decline('range iteration required')
    edges={edge.kind:edge for edge in header.edges}
    if set(edges)!={'next','exhausted'}:_decline('ordinary exhausted and next edges required')
    body=graph.blocks[edges['next'].target];tail=graph.blocks[edges['exhausted'].target]
    if _LEN(body.edges)!=1 or body.edges[0].target!=header.offset:_decline('independent single-block loop required')
    symbols={};source_slot=None
    def put(op,values):
        if _LEN(op.results)!=_LEN(values):_decline('unexpected SSA shape')
        for result,value in zip(op.results,values):symbols[result.id]=value
    def args(op):
        try:return [symbols[value.id] for value in op.arguments]
        except KeyError:_decline('unknown SSA value')
    for op in entry.operations:
        if op.name=='resume':continue
        if op.name=='global.load':
            name=op.attributes['argval']
            if name not in ('range','len') or _builtin(function,name) is not _EXPECTED_BUILTINS[name]:_decline('exact builtin range/len required')
            put(op,[('null',),('builtin',name)])
        elif op.name in ('frame.borrow','frame.load'):
            slot=op.attributes['oparg']
            if slot not in (0,1):_decline('only array parameters may be read')
            put(op,[('argument',slot)])
        elif op.name=='call':
            values=args(op)
            if _LEN(values)!=3 or values[0]!=('null',):_decline('one positional builtin argument required')
            if values[1]==('builtin','len') and values[2][0]=='argument':
                source_slot=values[2][1];put(op,[('length',source_slot)])
            elif values[1]==('builtin','range') and values[2][0]=='length':put(op,[('range',values[2][1])])
            else:_decline('only _RANGE(_LEN(array)) is admitted')
        elif op.name=='get_iter':
            values=args(op)
            if _LEN(values)!=1 or values[0]!=('range',source_slot):_decline('ordinary range iterator required')
            put(op,[('iterator',)])
        else:_decline('extra entry effect: '+op.name)
    if source_slot is None or [symbols.get(v.id) for v in entry.edges[0].arguments]!=[('iterator',)]:_decline('range iterator must enter loop')
    next_edge=edges['next'];result=header.operations[0].results
    if _LEN(result)!=1 or _LEN(next_edge.arguments)!=2 or next_edge.arguments[1]!=result[0]:_decline('ordinary index SSA edge required')
    if _LEN(body.parameters)!=2:_decline('iterator and index parameters required')
    symbols={body.parameters[0].id:('iterator',),body.parameters[1].id:('index',)}
    index_slot=None;expression=None;output_slot=None
    for op in body.operations:
        if expression is not None and op.name!='jump':_decline('effect after output store')
        if op.name=='frame.store':
            if index_slot is not None or args(op)!=[('index',)]:_decline('only the loop index local may be stored')
            index_slot=op.attributes['oparg']
            if index_slot<2:_decline('loop must not replace arguments')
        elif op.name in ('frame.borrow','frame.load','frame.borrow_borrow'):
            slots=op.attributes.get('slots',(op.attributes['oparg'],))
            values=[]
            for slot in slots:
                if slot==index_slot:values.append(('index',))
                elif slot in (0,1):values.append(('argument',slot))
                else:_decline('extra local read')
            put(op,values)
        elif op.name=='constant':
            value=op.attributes['argval']
            if type(value) is not float or not math.isfinite(value):_decline('finite float constants only')
            put(op,[('constant',value)])
        elif op.name in ('binary','subscr'):
            values=args(op);operator=op.instruction.argrepr if op.name=='binary' else '[]'
            if operator=='[]':
                if values!=[('argument',source_slot),('index',)]:_decline('only same-index source loads')
                put(op,[('load',)])
            elif operator in ('+','-','*') and all(value[0] in ('load','constant','add','subtract','multiply') for value in values):
                put(op,[(dict(zip(('+','-','*'),('add','subtract','multiply')))[operator],*values)])
            else:_decline('arithmetic not bit-exactly admitted: '+operator)
        elif op.name=='store_subscr':
            values=args(op)
            if _LEN(values)!=3 or values[1][0]!='argument' or values[2]!=('index',):_decline('same-index output required')
            if values[0][0] not in ('load','constant','add','subtract','multiply'):_decline('numeric output required')
            expression=values[0];output_slot=values[1][1]
            if output_slot==source_slot:_decline('separate source/output arguments required')
        elif op.name!='jump':_decline('extra loop effect: '+op.name)
    if expression is None:_decline('one numeric output store required')
    if _LEN(tail.operations)!=3 or [op.name for op in tail.operations]!=['pop_iter','frame.borrow','return']:_decline('return output directly')
    if tail.operations[1].attributes['oparg']!=output_slot or tail.operations[2].arguments!=tail.operations[1].results:_decline('return exact output argument')
    return LoopPlan(weakref.ref(code),source_slot,output_slot,expression)


class GpuLoop:
    """Explicit experimental candidate; measurement admission remains separate."""
    fastmath=False
    lto=False
    transfers_included=True
    def __init__(self,plan):
        self.plan=plan;self.kernel=None;self.last_backend=None;self.note=None
        self.verified_shapes=set();self.rejected_shapes=set()

    def _kernel(self):
        from numba import cuda
        if self.kernel is None:
            def emit(expression):
                if expression[0]=='load':return 'source[index]'
                if expression[0]=='constant':return repr(expression[1])
                symbol={'add':'+','subtract':'-','multiply':'*'}[expression[0]]
                return '('+emit(expression[1])+symbol+emit(expression[2])+')'
            text='def kernel(source,output):\n    index=cuda.grid(1)\n    if index<source.size:\n        output[index]='+emit(self.plan.expression)+'\n'
            namespace={'cuda':cuda}
            exec(compile(text,'<recompyler-ssa-gpu-loop>','exec'),namespace)
            # Function-direct form forwards lto=False to numba-cuda.
            self.kernel=cuda.jit(namespace['kernel'],fastmath=False,lto=False)
        return self.kernel

    def _run_gpu(self,source,output):
        from numba import cuda
        from recompyler.lift import _gpu_compile
        # Allocation, both transfers, launch and synchronization are inside execute.
        with _gpu_compile():
            kernel=self._kernel()
            device_source=cuda.to_device(source)
            device_output=cuda.device_array_like(output)
            # Pad idle threads instead of changing global warning filters.
            kernel[max(128,(source.size+127)//128),128](device_source,device_output)
            device_output.copy_to_host(output)
            cuda.synchronize()

    def execute(self,function,*args):
        reason=self.plan.guard(function,args)
        if reason is not None:
            self.last_backend='python';self.note=reason
            return function(*args)
        source,output=args[self.plan.input_slot],args[self.plan.output_slot]
        key=(source.size,source.dtype.str)
        if not source.size or key in self.rejected_shapes:
            self.last_backend='python';self.note='empty or rejected shape'
            return function(*args)
        try:
            if key not in self.verified_shapes:
                # This admitted graph has no Python effects. Verify copies before
                # any GPU result can mutate the caller's output, as in lift._gpu.
                import numpy as np
                expected=np.empty_like(output);actual=np.empty_like(output)
                reference=list(args);reference[self.plan.output_slot]=expected
                function(*reference)
                self._run_gpu(source,actual)
                if actual.tobytes()!=expected.tobytes():
                    self.rejected_shapes.add(key)
                    self.last_backend='python';self.note='GPU results differed from CPU'
                    output[:]=expected
                    return output
                self.verified_shapes.add(key)
                output[:]=actual
            else:
                self._run_gpu(source,output)
        except Exception as exc:
            self.last_backend='python';self.note='CUDA declined: '+type(exc).__name__+': '+str(exc)
            return function(*args)
        self.last_backend='cuda';self.note=None
        return output
