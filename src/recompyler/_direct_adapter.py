"""Shared raw LLVM entry emission for observation-free direct-access variants.

Only the compiler imports Numba. The nine-pointer v1 ABI contains four borrowed
array data pointers, their arena extent, scalar argument arrays, and scalar
result arrays. It performs no Python boxing and normalizes successful None
status to zero. A C execution envelope must validate/own every buffer and live
object, inspect raw status, release pins/restore stores, and only then box.

This emitter alone does not activate a Region direct path or establish a live
layout/identity certificate. Process addresses are ephemeral, never cache keys.
"""
from dataclasses import dataclass
import hashlib

ABI_VERSION = 1
POINTERS = 9


class AdapterDecline(Exception):
    pass


@dataclass(frozen=True)
class Entry:
    address: int
    library: object
    environments: tuple
    arguments: tuple
    returns: tuple
    ir_sha256: str
    ir: str
    abi_version: int = ABI_VERSION


def _leaves(kind):
    from numba import types
    if kind in (types.none, types.void):
        return ()
    if kind == types.float64:
        return (((), 'f'),)
    if kind == types.int64:
        return (((), 'i'),)
    if kind == types.boolean:
        return (((), 'b'),)
    if isinstance(kind, types.BaseTuple):
        return tuple(((index,) + path, letter)
                     for index, part in enumerate(kind.types)
                     for path, letter in _leaves(part))
    raise AdapterDecline(f'unsupported raw result kind: {kind}')


def _verify_native(cres):
    """Reject reachable allocation, Python calls and indirect native calls.

    Static native exception records require no retirement; dynamic exception
    allocation is excluded by no-NRT compilation plus this call-graph check.
    No claim is made that a Python wrapper has the same properties.
    """
    from llvmlite import binding
    module = binding.parse_assembly(cres.library.get_llvm_str())
    functions = {fn.name: fn for fn in module.functions}
    pending, seen = [cres.fndesc.llvm_func_name], set()
    while pending:
        name = pending.pop()
        if name in seen:
            continue
        seen.add(name)
        function = functions.get(name)
        if function is None or function.is_declaration:
            # Exact audited names only. In particular sideeffect, patchpoint,
            # statepoint, stack and exception intrinsics are not certificates.
            if name in {'llvm.fabs.f64', 'llvm.sqrt.f64', 'llvm.floor.f64',
                        'llvm.ceil.f64', 'llvm.trunc.f64', 'llvm.rint.f64',
                        'llvm.copysign.f64', 'llvm.sadd.with.overflow.i64',
                        'llvm.ssub.with.overflow.i64', 'llvm.smul.with.overflow.i64',
                        'llvm.uadd.with.overflow.i64', 'llvm.umul.with.overflow.i64'}:
                continue
            if name.startswith('llvm.'):
                raise AdapterDecline(f'unproved native intrinsic: {name}')
            raise AdapterDecline(f'unproved external native helper: {name}')
        for block in function.blocks:
            for instruction in block.instructions:
                if instruction.opcode not in ('call', 'invoke', 'callbr'):
                    continue
                if instruction.opcode != 'call':
                    raise AdapterDecline('unproved invoke/callbr native control flow')
                called = tuple(instruction.operands)[-1].name
                if not called:
                    raise AdapterDecline('unproved indirect native call')
                if called.startswith(('NRT_', 'Py', '_Py', 'numba_gil_')):
                    raise AdapterDecline(f'allocation/Python/NRT helper: {called}')
                pending.append(called)


def emit(context, module, cres, name, *, nrt):
    """Emit into the caller's unfinalized library (also usable by the AOT builder).

    The caller supplies the actual compile flag, not a sample-derived promise.
    All raw layouts of Numba arrays come from its active target data model.
    """
    from llvmlite import ir
    from numba import types
    from numba.np.arrayobj import populate_array
    if nrt is not False:
        raise AdapterDecline('raw direct entry requires NRT disabled')
    wanted = (types.float64, types.int64, types.int64, types.uint8)
    signature = cres.signature
    if len(signature.args) < 4:
        raise AdapterDecline('raw entry needs the four heap buffers')
    for kind, dtype in zip(signature.args[:4], wanted):
        if not isinstance(kind, types.Array) or kind.dtype != dtype or kind.ndim != 1 or kind.layout != 'C':
            raise AdapterDecline('raw entry requires canonical one-dimensional C heap buffers')
    args = []
    for kind in signature.args[4:]:
        leaves = _leaves(kind)
        if len(leaves) != 1 or leaves[0][0]:
            raise AdapterDecline('raw scalar arguments must be int64, float64 or bool')
        args.append(leaves[0][1])
    leaves = _leaves(signature.return_type)
    _verify_native(cres)
    byteptr = ir.IntType(8).as_pointer()
    pointer_table = byteptr.as_pointer()
    fn = ir.Function(module, ir.FunctionType(ir.IntType(32), (pointer_table,)), name)
    builder = ir.IRBuilder(fn.append_basic_block('entry'))
    intp = context.get_value_type(types.intp)
    i64 = ir.IntType(64)
    double = ir.DoubleType()
    def pointer(index, dtype):
        return builder.bitcast(builder.load(builder.gep(fn.args[0], (intp(index),))), dtype.as_pointer())
    extent = builder.load(pointer(4, i64))
    values = []
    for index, (kind, dtype) in enumerate(zip(signature.args[:4], wanted)):
        array = context.make_array(kind)(context, builder)
        item = context.get_value_type(dtype)
        count = extent if index < 2 else intp(4 if index == 2 else 1)
        populate_array(array, pointer(index, item), (count,), (intp(8 if index < 3 else 1),),
                       8 if index < 3 else 1, meminfo=None, parent=None)
        values.append(array._getvalue())
    for index, letter in enumerate(args):
        base = pointer(6 if letter == 'f' else 5, double if letter == 'f' else i64)
        value = builder.load(builder.gep(base, (intp(index),)))
        if letter == 'b':
            value = builder.icmp_unsigned('!=', value, i64(0))
        values.append(value)
    fnty = context.call_conv.get_function_type(signature.return_type, signature.args)
    native = ir.Function(module, fnty, cres.fndesc.llvm_func_name)
    status, result = context.call_conv.call_function(builder, native, signature.return_type, signature.args, values)
    with builder.if_then(status.is_ok):
        for index, (path, letter) in enumerate(leaves):
            value = result
            for part in path:
                value = builder.extract_value(value, part)
            if letter == 'b':
                value = builder.zext(value, i64)
            target = pointer(8 if letter == 'f' else 7, double if letter == 'f' else i64)
            builder.store(value, builder.gep(target, (intp(index),)))
        builder.ret(ir.IntType(32)(0))
    # Return the native status before touching Python, including a static error.
    builder.ret(status.code)
    return fn, tuple(args), tuple(letter for _, letter in leaves)


def _build_locked(dispatcher, signature):
    """Build a transient JIT adapter with the same emitter used for AOT IR.

    A separate library links the already finalized native library, as required
    by the installed code generator. Keeping that library alive owns the code.
    """
    if dispatcher.targetoptions.get('_nrt') is not False:
        raise AdapterDecline('raw direct entry requires NRT disabled')
    try:
        dispatcher.compile(tuple(signature))
        cres = dispatcher.overloads[tuple(signature)]
    except Exception as exc:
        raise AdapterDecline(f'no-NRT native compilation failed: {type(exc).__name__}: {exc}') from exc
    # Environment constants and executable code have independent owners.
    # Retain the complete reachable linked-library environment closure, and
    # reject dynamic globals rather than retaining an unproved pointer owner.
    from numba.core.environment import lookup_environment
    environments = {cres.fndesc.env_name: cres.environment}
    pending, seen = [cres.library], set()
    while pending:
        linked = pending.pop()
        if id(linked) in seen:
            continue
        seen.add(id(linked))
        if linked.has_dynamic_globals:
            raise AdapterDecline('unproved dynamic global ownership')
        for gv in linked._final_module.global_variables:
            if gv.name.startswith('_ZN08NumbaEnv') and gv.name not in environments:
                environment = lookup_environment(gv.name)
                if environment is None:
                    raise AdapterDecline('missing linked native environment owner')
                environments[gv.name] = environment
        pending.extend(linked._linking_libraries)
    context = cres.target_context
    library = context.codegen().create_library('recompyler_direct_adapter')
    module = library.create_ir_module('recompyler_direct_adapter')
    name = 'recompyler_direct_entry_v1'
    _, arguments, returns = emit(context, module, cres, name, nrt=False)
    source = str(module)
    library.add_linking_library(cres.library)
    library.add_ir_module(module)
    library.finalize()
    address = library.get_pointer_to_function(name)
    if not address:
        raise AdapterDecline('native adapter has no machine entry')
    return Entry(address, library, tuple(environments.values()), arguments, returns, hashlib.sha256(source.encode()).hexdigest(), source)


def build(dispatcher, signature):
    # Code generation and linking share Numba's global compiler lock. Keep this
    # import inside compilation so ordinary saved startup does not import Numba.
    from numba.core.compiler_lock import global_compiler_lock
    with global_compiler_lock:
        return _build_locked(dispatcher, signature)
