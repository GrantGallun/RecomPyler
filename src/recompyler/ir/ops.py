"""One shared graph vocabulary for bytecode semantics and compiler passes."""
from dataclasses import dataclass, field
from typing import Any
from .types import ValueType, PYOBJECT, Ownership

@dataclass(frozen=True)
class Value:
    id: int
    type: ValueType = PYOBJECT
    ownership: Ownership = Ownership.STACKREF

@dataclass(frozen=True)
class ExceptionRegion:
    start: int
    end: int
    target: int
    depth: int
    lasti: bool

@dataclass(frozen=True)
class DeoptState:
    offset: int
    locals: tuple[tuple[int, Value], ...]
    stack: tuple[Value, ...]

@dataclass(frozen=True)
class Operation:
    name: str
    arguments: tuple[Value, ...]
    results: tuple[Value, ...]
    offset: int
    block: int
    instruction: Any
    attributes: dict = field(default_factory=dict)
    handler: ExceptionRegion | None = None

@dataclass(frozen=True)
class Edge:
    target: int
    arguments: tuple[Value, ...]
    kind: str = 'normal'
    source_offset: int | None = None

@dataclass
class Block:
    offset: int
    parameters: tuple[Value, ...]
    operations: list[Operation] = field(default_factory=list)
    edges: list[Edge] = field(default_factory=list)

@dataclass
class FunctionIR:
    function: Any
    code: Any
    entry: int
    blocks: dict[int, Block]
    exceptions: tuple[ExceptionRegion, ...] = ()
    def predecessors(self, target):
        return [(block, edge) for block in self.blocks.values()
                for edge in block.edges if edge.target == target]
