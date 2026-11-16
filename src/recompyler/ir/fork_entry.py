"""Explicit in-tree installation of canonical real-frame LLVM bodies.

This fork-only correctness/measurement API never installs implicitly. Source
functions, binding and observable frames remain CPython's original objects.
"""
import ctypes
from dataclasses import dataclass
import dis
import inspect
from types import FunctionType
import weakref

from .builder import build, UnsupportedBytecode
from .lower_llvm import lower


def _require_fork():
    import sys
    if not getattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative', None):
        raise RuntimeError('fork native-frame API unavailable')
    if sys._jit.is_enabled():
        raise RuntimeError('fork native frames require CPython JIT disabled')


@dataclass(frozen=True)
class ForkCompilation:
    function_ref: object
    code_ref: object
    entries: tuple
    count: bool
    borrow_guards: bool = False

    @property
    def entry_count(self):
        return len(self.entries)

    def install(self):
        _require_fork()
        function, code = self.function_ref(), self.code_ref()
        if function is None or code is None:
            raise ReferenceError('compiled source function or code no longer exists')
        from . import _fork_entry_native
        from .. import _source_frames_native as frames
        return _fork_entry_native.install(function, code, self.entries,
            frames.addresses()['observers_active'], frames, self.count, self.borrow_guards)


def prepare_function(function, *, count=False, include_osr=False, start=True, specialize=False, borrow_guards=False, numeric_ops=None):
    """Compile original RESUME slices, optionally ordinary empty-stack OSR."""
    _require_fork()
    if type(function) is not FunctionType:
        raise TypeError('a Python function is required')
    if any(type(value) is not bool for value in (count, include_osr, start)):
        raise TypeError('count, include_osr and start must be bool')
    if type(specialize) is not bool:
        raise TypeError('specialize must be bool')
    if type(borrow_guards) is not bool:
        raise TypeError('borrow_guards must be bool')
    graph = build(function)
    calls = None
    if specialize:
        from .. import _structure_ops_native
        from .symbols import CPythonSymbols
        from .structure_lowerings import StructureCalls, select_structure_calls, specialize_structure_calls
        graph = specialize_structure_calls(graph, immediate_offsets=True)
        graph = select_structure_calls(graph, {'load_attr', 'store_attr', 'getitem', 'setitem', 'contains'})
        calls = StructureCalls(CPythonSymbols(), _structure_ops_native)
    code = graph.code
    instructions = tuple(dis.get_instructions(code))
    suspended = bool(code.co_flags & (inspect.CO_GENERATOR | inspect.CO_COROUTINE | inspect.CO_ASYNC_GENERATOR))
    entries = []
    for instruction in instructions:
        if instruction.opname == 'RESUME':
            if instruction.arg == 0 and not start:
                continue
            owner = lower(graph, frame_entry=True,
                          structure_calls=calls, owned_readonly_loops=specialize, numeric_ops=numeric_ops,
                          entry_offset=instruction.offset,
                          allow_async_resume=bool(code.co_flags & (inspect.CO_COROUTINE | inspect.CO_ASYNC_GENERATOR))).execution_owner
            event = 1 if instruction.arg == 0 else 2
            entries.append((instruction.offset, owner.body_address, owner, event))
        elif include_osr and not suspended and instruction.opname == 'JUMP_BACKWARD':
            target = instruction.argval
            if target not in graph.blocks or graph.blocks[target].parameters:
                continue
            owner = lower(graph, frame_entry=True, entry_offset=target,
                          structure_calls=calls, owned_readonly_loops=specialize, numeric_ops=numeric_ops).execution_owner
            entries.append((instruction.offset, owner.body_address, owner, 4))
    if not entries:
        raise UnsupportedBytecode('no supported original native entry point')
    if function.__code__ is not code:
        raise RuntimeError('source code changed during fork compilation')
    return ForkCompilation(weakref.ref(function), weakref.ref(code), tuple(entries), count, borrow_guards)


def install_function(function, **options):
    """Force explicit installation for isolated correctness or measurements."""
    return prepare_function(function, **options).install()


def stats(handle):
    from . import _fork_entry_native
    return _fork_entry_native.stats(handle.owner)
