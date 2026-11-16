"""Certified callback-free entries whose source retains every argument.

The body borrows an unchanged input graph and returns an owned result on a hit.
A straight-line miss tail-transfers to CPython. Traversal misses and pending
backedges tail-transfer to a C-owned cold thunk using the existing deopt maps.
The hot path allocates no frame and runs no callback or argument retirement.
"""
import ctypes
import dis
import inspect
from types import FunctionType
from dataclasses import dataclass, replace
from weakref import ref
from llvmlite import ir, binding
from .builder import build, UnsupportedBytecode
from .lower_llvm import _finish, _emit_borrowed_loop
from .readonly import plan_readonly_loop
from .symbols import CPythonSymbols
from .structure_lowerings import StructureCalls

_READS = {'frame.borrow', 'frame.load', 'frame.load_check', 'frame.borrow_borrow', 'frame.load_load'}
_STRAIGHT = _READS | {'resume', 'nop', 'jump', 'constant', 'small_int', 'load_attr', 'return'}


def _straight_operations(graph):
    operations = []; seen = set(); offset = graph.entry
    while offset not in seen:
        seen.add(offset); block = graph.blocks[offset]
        if block.parameters: return None
        operations.extend(block.operations)
        if any(op.name not in _STRAIGHT or op.name == 'load_attr' and op.attributes.get('method')
               for op in block.operations): return None
        if any(op.name == 'return' for op in block.operations):
            return operations if not block.edges and len(seen) == len(graph.blocks) else None
        if len(block.edges) != 1: return None
        offset = block.edges[0].target
    return None


class FramelessCandidate:
    """Source-weak executable certificate. Counting is explicit and off by default."""
    def __init__(self, function, code, owner, counter):
        self._function = ref(function)
        self._code = ref(code)
        self.owner = owner
        self._counter = counter
        self._handle = None

    def source_matches(self, function):
        return type(function) is FunctionType and function is self._function() and function.__code__ is self._code()

    @property
    def counted(self): return self._counter is not None

    @property
    def body_address(self): return self.owner.body_address

    @property
    def native_calls(self): return self._counter.value if self._counter is not None else None

    @property
    def active(self): return self._handle is not None and self._handle.active

    def install(self):
        from . import _entry_native
        function = self._function()
        if function is None or function.__code__ is not self._code():
            raise ValueError('frameless source expired or changed')
        if self.active: return self._handle
        self.close()
        self._handle = _entry_native._install_callback_free_entry(function, self.body_address, self.owner, self._code(), self.owner.cold_address)
        return self._handle

    def close(self):
        if self._handle is not None:
            self._handle.close(); self._handle = None


@dataclass(frozen=True)
class ColdPlan:
    capsule: object
    offset: int


def cold_plan(code, offset):
    """A weak-code map for unchanged arguments plus the separate traversal local."""
    from .deopt import DeoptMetadata, FrameState, LiveValue, RefKind, ValueKind, prepare
    values=tuple(LiveValue(i,RefKind.BORROWED,ValueKind.OBJECT) for i in range(code.co_nlocals))
    state=FrameState(code,offset,offset,tuple(range(code.co_nlocals)),(),lazy=True)
    return ColdPlan(prepare(DeoptMetadata(values,(state,)),weak_code=True),offset)


def _emit_loop_cold(module, symbols, code, state, plans):
    from .deopt import emit_vectorcall_deopt
    p=ir.IntType(8).as_pointer();word=ir.IntType(64)
    body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),word,p,p]),'cold_body')
    original,args,_,_,_=body.args
    b=ir.IRBuilder(body.append_basic_block('entry'))
    cell=ir.Constant(word,ctypes.addressof(state)).inttoptr(p)
    words=b.bitcast(cell,word.as_pointer())
    # Snapshot this GIL-held transition before the frame runner can call Python.
    # A nested invocation may then reuse the cell without changing this payload.
    current=b.load(words);which=b.load(b.gep(words,[ir.Constant(word,1)]))
    raw=tuple(b.ptrtoint(b.load(b.gep(args,[ir.Constant(word,i)])),word) for i in range(code.co_argcount))+(current,)
    def resume(plan):
        emit_vectorcall_deopt(b,original=original,args=args,code=code,plan=plan.capsule,
                              raw=raw,symbols=symbols,cause_offset=plan.offset)
    with b.if_then(b.icmp_unsigned('==',which,ir.Constant(word,1))):resume(plans[1])
    resume(plans[0])


def prepare_frameless(function, *, counted=False):
    """Return a lifetime-certified candidate, or None; never invoke the target.

    Source arguments cannot be stored, taken, deleted, or captured. Attribute
    reads are guarded callback-free borrows rooted transitively in those inputs.
    A separate traversal local may change; its original argument stays live.
    A miss transfers to CPython with unchanged input owners and current locals.
    """
    if type(counted) is not bool: raise TypeError('counted must be bool')
    if type(function) is not FunctionType: return None
    code = function.__code__
    if (code.co_flags & (inspect.CO_OPTIMIZED | inspect.CO_NEWLOCALS) != (inspect.CO_OPTIMIZED | inspect.CO_NEWLOCALS)
        or code.co_exceptiontable or code.co_cellvars or code.co_freevars or code.co_kwonlyargcount
        or code.co_flags & (inspect.CO_GENERATOR | inspect.CO_COROUTINE | inspect.CO_ASYNC_GENERATOR
                           | inspect.CO_VARARGS | inspect.CO_VARKEYWORDS)):
        return None
    try: graph = build(function)
    except UnsupportedBytecode: return None
    plan = plan_readonly_loop(graph, preserved_arguments=True)
    if plan is not None and code.co_argcount>64:return None
    operations = None if plan is not None else _straight_operations(graph)
    if plan is None and (operations is None or code.co_nlocals != code.co_argcount): return None
    for block in graph.blocks.values():
        for op in block.operations:
            if op.name in {'frame.take', 'frame.delete', 'frame.store', 'frame.store_load', 'frame.store_store'}:
                slots = op.attributes.get('slots', (op.attributes['oparg'],))
                writes = slots[:1] if op.name == 'frame.store_load' else slots
                if any(slot < code.co_argcount for slot in writes): return None
    from .. import _structure_ops_native
    symbols = CPythonSymbols(); calls = StructureCalls(symbols, _structure_ops_native)
    from . import _entry_native
    entry_api = _entry_native._callback_free_addresses()
    symbols.register_external("rc_ir_callback_free_guard", entry_api["guard"], _entry_native)
    symbols.register_external("rc_ir_saved_vectorcall", entry_api["saved"], _entry_native)
    p = ir.IntType(8).as_pointer(); word = ir.IntType(64)
    module = ir.Module(name='certified_frameless')
    binding.initialize_native_target(); binding.initialize_native_asmprinter()
    module.triple = binding.get_process_triple()
    body = ir.Function(module, ir.FunctionType(p, [p, p.as_pointer(), word, p]), 'body')
    original, args, nargsf, names = body.args
    builder = ir.IRBuilder(body.append_basic_block('entry'))
    null = ir.Constant(p, None)
    def number(value): return ir.Constant(word, value)
    def obj(value): return number(id(value)).inttoptr(p)
    eligible = builder.and_(builder.icmp_unsigned('==', builder.and_(nargsf, number((1 << 63) - 1)), number(code.co_argcount)),
                            builder.icmp_unsigned('==', names, null))
    hot = body.append_basic_block('admitted'); miss = body.append_basic_block('saved_slot_miss')
    guard = symbols.declare(module, 'rc_ir_callback_free_guard', ir.IntType(32), [])
    eligible = builder.and_(eligible, builder.icmp_signed('!=', builder.call(guard, []), ir.Constant(ir.IntType(32), 0)))
    builder.cbranch(eligible, hot, miss); builder.position_at_end(hot)
    counter = ctypes.c_uint64() if counted else None
    cold_state=None;cold_plans=()
    def done(value):
        if counter is not None:
            address = number(ctypes.addressof(counter)).inttoptr(word.as_pointer())
            builder.store(builder.add(builder.load(address), number(1)), address)
        # Emit the installed release/GIL Py_INCREF exactly, including the
        # higher incref saturation threshold; this operation cannot call back.
        slot = builder.gep(value, [number(entry_api['refcount'])])
        old = builder.load(builder.bitcast(slot, ir.IntType(32).as_pointer()))
        with builder.if_then(builder.icmp_unsigned('<', old, ir.Constant(ir.IntType(32), entry_api['immortal']))):
            new = builder.zext(builder.add(old, ir.Constant(ir.IntType(32), 1)), word)
            builder.store(new, builder.bitcast(slot, word.as_pointer()))
        builder.ret(value)
    if plan is not None:
        current = builder.load(builder.gep(args, [number(plan.initial_state_slot)]))
        owner = current if plan.kind == 'attribute' else builder.load(builder.gep(args, [number(plan.owner_slot)]))
        from .. import _source_frames_native
        cold_state=(ctypes.c_uint64*2)()
        backward=next(op.offset for op in dis.get_instructions(code) if op.opname=='JUMP_BACKWARD')
        cold_plans=(cold_plan(code,plan.loop_offset),cold_plan(code,backward))
        _emit_loop_cold(module,symbols,code,cold_state,cold_plans)
        symbols.register_external('rc_ir_callback_free_cold',entry_api['cold'],_entry_native)
        transfer=symbols.declare(module,'rc_ir_callback_free_cold',p,list(body.function_type.args))
        cell=builder.bitcast(number(ctypes.addressof(cold_state)).inttoptr(p),word.as_pointer())
        def leave(value,site):
            builder.store(builder.ptrtoint(value,word),cell)
            builder.store(number(site),builder.gep(cell,[number(1)]))
            builder.ret(builder.call(transfer,[original,args,nargsf,names],tail='musttail'))
        layout=_source_frames_native.layout()
        thread=builder.call(symbols.declare(module,'PyThreadState_Get',p,[]),[])
        breaker=builder.bitcast(builder.gep(thread,[number(layout['thread_eval_breaker_offset'])]),word.as_pointer())
        def backedge(value):
            flags=builder.and_(builder.load_atomic(breaker,'monotonic',8),number(layout['eval_events_mask']))
            with builder.if_then(builder.icmp_unsigned('!=',flags,number(0))):leave(value,1)
        _emit_borrowed_loop(builder,code,plan,calls,symbols,current,owner,
                            lambda value:leave(value,0),done,backedge=backedge)
    else:
        values = {}
        for op in operations:
            if op.name in ('resume', 'nop', 'jump'): continue
            operands = [values[value.id] for value in op.arguments]
            if op.name in _READS:
                results = [builder.load(builder.gep(args, [number(slot)]))
                           for slot in op.attributes.get('slots', (op.attributes['oparg'],))]
            elif op.name in ('constant', 'small_int'):
                results = [obj(op.attributes['argval'])]
            elif op.name == 'load_attr':
                value = calls.try_load_attr(builder, operands[0], obj(op.attributes['argval']))
                hit = body.append_basic_block('attribute_hit')
                builder.cbranch(builder.icmp_unsigned('==', value, null), miss, hit)
                builder.position_at_end(hit); results = [value]
            elif op.name == 'return': done(operands[0]); break
            for result, value in zip(op.results, results): values[result.id] = value
    builder.position_at_end(miss)
    saved = symbols.declare(module,'rc_ir_saved_vectorcall',p,list(body.function_type.args))
    builder.ret(builder.call(saved, [original, args, nargsf, names], tail='musttail'))
    lowered = _finish(graph, module, calls, symbols)
    owner = replace(lowered.execution_owner, abi='callback-free-vectorcall',
                    cold_address=lowered.engine.get_function_address('cold_body') if cold_state is not None else 0,
                    cold_state=cold_state,cold_plans=cold_plans,
                    compile_options=(('entry_scope','source-retained'),('body_kind','traversal' if plan is not None else 'straight'),('strict',True)))
    if cold_state is not None:owner=replace(owner,providers=owner.providers+(cold_state,)+cold_plans)
    if counter is not None:
        owner = replace(owner, providers=owner.providers + (counter,))
    # Never retain graph/code/function in the source-independent execution owner.
    if function.__code__ is not code: return None
    return FramelessCandidate(function, code, owner, counter)
