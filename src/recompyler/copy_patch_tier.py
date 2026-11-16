"""Experimental copy-and-patch T1: strict straight-line borrowed return plans.

Classification, IR construction, copying and patching are all runtime work.
Unsupported functions stay in CPython. This module never imports an LLVM API.
It does not participate in default admission until whole-program gates pass.
"""
from dataclasses import dataclass
from functools import lru_cache
import hashlib
import json
from pathlib import Path
import struct
import sys
from types import FunctionType, MappingProxyType
import weakref

from .copy_patch import Hole, Stencil


class Unsupported(ValueError):
    """The small initial T1 proof does not cover this source shape."""


@dataclass(frozen=True, slots=True)
class Step:
    name: str
    operand: int = 0


@dataclass(frozen=True, slots=True)
class Plan:
    source: weakref.ReferenceType
    operations: tuple[Step, ...]
    bytecodes: int


def classify(function):
    """Linear complete classification; never calls the target or user protocols."""
    if type(function) is not FunctionType:
        raise Unsupported('exact Python function required')
    code = function.__code__
    if (code.co_flags & (0x04 | 0x08 | 0x20 | 0x80 | 0x200) or
        code.co_flags & 3 != 3 or code.co_kwonlyargcount or code.co_cellvars or
        code.co_freevars or code.co_exceptiontable or code.co_nlocals != code.co_argcount):
        raise Unsupported('unproved call/local shape')
    # Numeric opcodes belong to the exact 3.14 runtime to which packs are bound.
    if sys.version_info[:2] != (3, 14):
        raise Unsupported('CPython 3.14 required')
    from opcode import opmap
    resume, nop, extended = (opmap[n] for n in ('RESUME', 'NOP', 'EXTENDED_ARG'))
    loads = {opmap[n]: 'arg' for n in ('LOAD_FAST', 'LOAD_FAST_BORROW') if n in opmap}
    loads[opmap['LOAD_CONST']] = 'const'
    ret = opmap['RETURN_VALUE']
    body = code.co_code
    operations = [Step('entry', code.co_argcount)]
    value_loaded = returned = started = False
    argument = extra_words = 0
    for position in range(0, len(body), 2):
        opcode, low = body[position], body[position+1]
        if returned:
            raise Unsupported('instructions after return')
        argument = (argument << 8) | low
        if opcode == extended:
            extra_words += 1
            if extra_words > 3: raise Unsupported('oversized operand')
            continue
        if not started:
            if opcode != resume or argument or position:
                raise Unsupported('initial RESUME 0 required')
            started = True
        elif opcode == nop and not argument:
            pass
        elif opcode in loads and not value_loaded:
            name = loads[opcode]
            bound = code.co_argcount if name == 'arg' else len(code.co_consts)
            if not 0 <= argument < bound: raise Unsupported('operand outside source')
            operations.append(Step(name, argument))
            value_loaded = True
        elif opcode == ret and not argument and value_loaded:
            operations.append(Step('return'))
            returned = True
        else:
            raise Unsupported('unproved opcode or stack state')
        argument = extra_words = 0
    if not returned or extra_words:
        raise Unsupported('complete return required')
    return Plan(weakref.ref(code), tuple(operations), len(body)//2)


@dataclass(frozen=True, slots=True)
class Pack:
    path: Path
    digest: str
    stencils: dict


def load_pack(path=None):
    """Fail closed on build, platform, pointer-width or content mismatch."""
    if path is None:
        name = hashlib.sha256(sys.version.encode()).hexdigest()[:16]+'.json'
        path = Path(__file__).with_name('stencils')/name
    path = Path(path)
    document = json.loads(path.read_text(encoding='utf-8'))
    if (document['runtime'] != sys.version or document['platform'] != sys.platform or
        document['pointer_bits'] != struct.calcsize('P')*8 or document['schema'] != 1):
        raise ValueError('stencil runtime ABI mismatch')
    digest = document.pop('digest')
    body = json.dumps(document, sort_keys=True, separators=(',', ':')).encode()
    if hashlib.sha256(body).hexdigest() != digest:
        raise ValueError('stencil digest mismatch')
    stencils = {}
    if set(document['stencils']) != {'entry', 'arg', 'const', 'return'}:
        raise ValueError('stencil operation set mismatch')
    for name, record in document['stencils'].items():
        stencils[name] = Stencil(bytes.fromhex(record['code']), bytes.fromhex(record['data']),
            tuple(Hole(**hole) for hole in record['holes']))
    return Pack(path, digest, MappingProxyType(stencils))

from .native_image import ExecutableImage as _Executable


@dataclass(frozen=True, slots=True)
class Compilation:
    plan: Plan
    executable: _Executable
    stencil_digest: str
    recompyler_tier = 'T1'
    backend = 'copy-patch'

    @property
    def address(self):
        return self.executable.address

    def install(self, function):
        from .ir import _entry_native
        expected_code = self.plan.source()
        if expected_code is None or type(function) is not FunctionType or function.__code__ is not expected_code:
            raise Unsupported('source changed before installation')
        return _entry_native._install_callback_free_entry(function, self.address, self, expected_code)


def compile_function(function, *, pack=None):
    """Compile a complete supported function, including classification and lift.

    This explicit experimental API never executes the function and never admits
    it to the default runtime policy. The canonical C entry owns all installation,
    invalidation and observer handling. No per-function optimizer is invoked.
    """
    from .copy_patch import Operation, Symbol, prepare
    from .ir import _entry_native
    plan = classify(function)
    if sys.platform != 'win32' or struct.calcsize('P') != 8:
        raise Unsupported('Windows x64 T1 pack required')
    pack = _default_pack() if pack is None else pack
    if type(pack) is not Pack: raise TypeError('validated stencil pack required')
    addresses = _entry_native._callback_free_addresses()
    symbols = {'rc_ir_callback_free_guard': addresses['guard'],
               'rc_ir_saved_vectorcall': addresses['saved']}
    operations = []
    for step in plan.operations:
        stencil = pack.stencils[step.name]
        bindings = {'operand0': step.operand, 'zero': 0}
        for hole in stencil.holes:
            if hole.source.startswith('external:'):
                name = hole.source.removeprefix('external:')
                if name not in symbols: raise Unsupported('unproved stencil helper: '+name)
                bindings[hole.source] = Symbol(name)
        operations.append(Operation(stencil, bindings))
    executable = _Executable(prepare(operations), symbols)
    return Compilation(plan, executable, pack.digest)


_default_pack = lru_cache(maxsize=1)(load_pack)
compile_function.recompyler_tier = 'T1'
