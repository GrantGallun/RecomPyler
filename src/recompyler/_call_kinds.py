"""Shared optional counter layout; slots zero/one retain their existing ABI."""
import operator
from types import FunctionType

CALL_KINDS = ('function', 'method', 'append', 'get', 'add', 'isinstance', 'len',
              'context', 'construct', 'getattr', 'setattr', 'getitem', 'setitem',
              'contains', 'compare', 'arithmetic', 'iteration', 'cell', 'name', 'helper')


def named_kind(name, method=False):
    if method:
        return name if name in ('append', 'get', 'add') else 'method'
    if name in ('len', 'isinstance'):
        return name
    if name in ('locals', 'globals', 'vars', 'dir', 'eval', 'exec'):
        return 'context'
    if name in ('list', 'tuple', 'dict', 'set', 'int', 'float', 'str', 'bytes'):
        return 'construct'
    return 'function'


def helper_kind(value):
    for candidate, kind in ((getattr, 'getattr'), (setattr, 'setattr'),
            (operator.getitem, 'getitem'), (operator.setitem, 'setitem'),
            (operator.contains, 'contains'), (iter, 'iteration'), (next, 'iteration')):
        if value is candidate:
            return kind
    if any(value is candidate for candidate in (operator.is_, operator.is_not,
            operator.eq, operator.ne, operator.lt, operator.le, operator.gt, operator.ge)):
        return 'compare'
    if any(value is candidate for candidate in (operator.add, operator.sub, operator.mul,
            operator.truediv, operator.floordiv, operator.mod, operator.iadd,
            operator.and_, operator.or_, operator.xor)):
        return 'arithmetic'
    if type(value) is FunctionType:
        name, module = value.__name__, value.__module__
        if type(name) is str and type(module) is str and module.startswith('recompyler.'):
            if name == '_read_name' or name == '_store_name': return 'name'
            if name == '_read_free' or 'cell' in name: return 'cell'
    return 'helper'


class CounterLayout:
    kinds = CALL_KINDS

    def __init__(self, start=2):
        self.start = max(2, start)
        self.width = self.start + 2 * len(self.kinds)

    def slots(self, kind):
        if kind not in self.kinds:
            kind = 'helper'
        index = self.kinds.index(kind)
        return self.start + index, self.start + len(self.kinds) + index
