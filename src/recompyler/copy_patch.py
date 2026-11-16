"""Linear linking of immutable machine-code stencils; no compiler import.

Templates are built once. Linking copies code/data, then resolves every hole in
one pass. Symbols remain names until linking so cached plans contain no process
addresses. Native allocation, entry installation and source semantics are separate.
"""
from dataclasses import dataclass
from types import MappingProxyType
import struct


@dataclass(frozen=True, slots=True)
class Target:
    label: int | str

    def __post_init__(self):
        if type(self.label) not in (int, str):
            raise TypeError('label must be an exact int or str')


@dataclass(frozen=True, slots=True)
class Symbol:
    name: str

    def __post_init__(self):
        if type(self.name) is not str or not self.name:
            raise TypeError('symbol name required')


@dataclass(frozen=True, slots=True)
class Hole:
    section: str
    offset: int
    kind: str
    source: str
    addend: int = 0

    def __post_init__(self):
        if type(self.section) is not str or type(self.kind) is not str:
            raise TypeError('relocation section/kind must be exact strings')
        if self.section not in ('code', 'data') or self.kind not in ('abs64', 'rel32'):
            raise ValueError('unknown relocation section or kind')
        if type(self.offset) is not int or self.offset < 0 or type(self.addend) is not int:
            raise ValueError('integer relocation offset/addend required')
        if type(self.source) is not str or not self.source:
            raise ValueError('relocation source required')
        if self.source.startswith('$') and self.source not in ('$code', '$data', '$next'):
            raise ValueError('unknown local relocation source')

    @property
    def width(self):
        return 8 if self.kind == 'abs64' else 4


@dataclass(frozen=True, slots=True)
class Stencil:
    code: bytes
    data: bytes = b''
    holes: tuple[Hole, ...] = ()

    def __post_init__(self):
        if type(self.code) is not bytes or not self.code or type(self.data) is not bytes:
            raise TypeError('immutable code/data bytes required')
        if type(self.holes) is not tuple or len(self.holes) > 64:
            raise ValueError('bounded immutable relocation tuple required')
        used = {'code': 0, 'data': 0}
        for hole in self.holes:
            if type(hole) is not Hole:
                raise TypeError('relocation required')
            if hole.offset + hole.width > len(getattr(self, hole.section)):
                raise ValueError('relocation outside stencil')
            mask = ((1 << hole.width) - 1) << hole.offset
            if used[hole.section] & mask:
                raise ValueError('overlapping relocations')
            used[hole.section] |= mask


@dataclass(frozen=True, slots=True)
class Operation:
    stencil: Stencil
    bindings: dict
    label: int | str | None = None

    def __post_init__(self):
        if type(self.stencil) is not Stencil or type(self.bindings) is not dict:
            raise TypeError('stencil and exact binding dict required')
        if self.label is not None and type(self.label) not in (int, str):
            raise TypeError('label must be an exact int or str')
        snapshot = {}
        for key, value in self.bindings.items():
            if type(key) is not str or key.startswith('$'):
                raise TypeError('named binding required')
            if type(value) not in (int, Target, Symbol):
                raise TypeError('integer, label or symbolic binding required')
            snapshot[key] = value
        object.__setattr__(self, 'bindings', MappingProxyType(snapshot))


@dataclass(frozen=True, slots=True)
class Image:
    body: bytes
    code_size: int
    data_offsets: tuple[int, ...]
    labels: dict
    operations: int
    patches: int
    copied_bytes: int


@dataclass(frozen=True, slots=True)
class Layout:
    operations: tuple[Operation, ...]
    offsets: tuple[int, ...]
    data_offsets: tuple[int, ...]
    relative_labels: dict
    code_size: int
    size: int

    def link(self, *, base, symbols=None):
        return _link(self, base=base, symbols=symbols)


def prepare(operations, *, max_bytes=16 * 1024 * 1024):
    """Plan allocation without copying bytes or patching any holes."""
    if type(max_bytes) is not int or max_bytes < 1:
        raise ValueError('positive image limit required')
    operations = tuple(operations)
    if not operations or any(type(op) is not Operation for op in operations):
        raise TypeError('nonempty operation sequence required')
    offsets = []; labels = {}; code_size = 0
    for op in operations:
        offsets.append(code_size)
        if op.label is not None:
            if op.label in labels:
                raise ValueError('duplicate label')
            labels[op.label] = code_size
        code_size += len(op.stencil.code)
    end = code_size; data_offsets = []
    for op in operations:
        end = (end + 7) & -8
        data_offsets.append(end)
        end += len(op.stencil.data)
    if end > max_bytes:
        raise ValueError('image exceeds allocation limit')
    return Layout(operations, tuple(offsets), tuple(data_offsets),
                  MappingProxyType(labels), code_size, end)


def link(operations, *, base, symbols=None, max_bytes=16 * 1024 * 1024):
    """Copy each stencil once, then patch once per hole; O(ops + bytes + holes)."""
    return prepare(operations, max_bytes=max_bytes).link(base=base, symbols=symbols)


def _link(layout, *, base, symbols):
    if type(base) is not int or not 0 <= base < 1 << 64:
        raise ValueError('unsigned image base required')
    if base + layout.size > 1 << 64:
        raise ValueError('image exceeds address limit')
    symbols = {} if symbols is None else symbols
    if type(symbols) is not dict or any(type(k) is not str or type(v) is not int for k, v in symbols.items()):
        raise TypeError('exact symbol address dictionary required')
    operations, offsets, data_offsets = layout.operations, layout.offsets, layout.data_offsets
    code_size = layout.code_size
    labels = {name: base + offset for name, offset in layout.relative_labels.items()}
    body = bytearray(layout.size); copied = patches = 0
    for index, op in enumerate(operations):
        for section, start in (('code', offsets[index]), ('data', data_offsets[index])):
            chunk = getattr(op.stencil, section)
            body[start:start + len(chunk)] = chunk
            copied += len(chunk)
    for index, op in enumerate(operations):
        for hole in op.stencil.holes:
            if hole.source == '$code': value = base + offsets[index]
            elif hole.source == '$data': value = base + data_offsets[index]
            elif hole.source == '$next':
                if index + 1 == len(operations):
                    raise ValueError('next relocation has no successor')
                value = base + offsets[index + 1]
            else:
                if hole.source not in op.bindings:
                    raise ValueError('missing relocation binding: ' + hole.source)
                value = op.bindings[hole.source]
                if type(value) is Target:
                    if value.label not in labels:
                        raise ValueError('missing target label')
                    value = labels[value.label]
                elif type(value) is Symbol:
                    if value.name not in symbols:
                        raise ValueError('missing symbol: ' + value.name)
                    value = symbols[value.name]
            value += hole.addend
            if not 0 <= value < 1 << 64:
                raise ValueError(hole.kind + ' relocation outside unsigned word range')
            start = (offsets if hole.section == 'code' else data_offsets)[index] + hole.offset
            if hole.kind == 'rel32':
                value -= base + start + 4
                if not -(1 << 31) <= value < 1 << 31:
                    raise ValueError('rel32 target outside signed displacement range')
                struct.pack_into('<i', body, start, value)
            else:
                if not 0 <= value < 1 << 64:
                    raise ValueError('abs64 relocation outside unsigned word range')
                struct.pack_into('<Q', body, start, value)
            patches += 1
    return Image(bytes(body), code_size, tuple(data_offsets), MappingProxyType(labels),
                 len(operations), patches, copied)
