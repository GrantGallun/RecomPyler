"""Semantic value types; NULL is a VM sentinel, never Python None."""
from dataclasses import dataclass
from enum import Enum

@dataclass(frozen=True,eq=False)
class ValueType:
    kind: str = 'object'
    exact: type | None = None
    maybe_unbound: bool = False

    def __eq__(self,other):
        return (type(other) is ValueType and self.kind==other.kind
                and self.exact is other.exact and self.maybe_unbound==other.maybe_unbound)

    def __hash__(self):
        return hash((self.kind,id(self.exact),self.maybe_unbound))

PYOBJECT = ValueType()
NULL = ValueType('null')
OBJECT_OR_NULL = ValueType('object-or-null')
INT64 = ValueType('int64')

def exact_type(value_type):
    return ValueType(exact=value_type)

def join_types(left, right):
    if left == right:
        return left
    unbound = left.maybe_unbound or right.maybe_unbound
    if left.kind in ('null', 'object-or-null') or right.kind in ('null', 'object-or-null'):
        return ValueType('object-or-null', maybe_unbound=unbound)
    return ValueType(maybe_unbound=unbound)

class Ownership(Enum):
    OWNED = 'owned'
    BORROWED = 'borrowed'
    NULL = 'null'
    STACKREF = 'stackref'
