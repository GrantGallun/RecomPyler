"""The proof layer must consume real checked compiler metadata, not a profile."""
from recompyler import direct, heap


class Cell:
    def __init__(self, value, other):
        self.value = value
        self.other = other


def compare(cell):
    return cell.value > 0.0


def total(values):
    result = 0.0
    for value in values:
        result += value
    return result


def write(cell):
    cell.value += 1.0


def transitive(left, right):
    write(right)
    return left.value


def independent(cell):
    cell.other += 1.0
    return cell.value


def append(values):
    values.append(2.0)
    return values[0]


class SourceOnly(dict):
    def __bool__(self): return True
    def get(self, key, default=None): return True


def analyze(fn, *args):
    p = heap._Program(fn)
    for name, value in zip(p.entry.params, args):
        p.widen(p.entry.vars, name, heap._seed(p, value, {}))
    p.compile(SourceOnly())
    return direct.from_program(p)


def test_pure_numeric_field_uses_checked_types_and_reports_no_writes():
    a = analyze(compare, Cell(1.0, 2.0))
    s = a.summary('entry')
    assert s.read_only
    assert any(p.space == 'field' and p.field == 'value' for p in a.borrowable('entry'))


def test_pure_numeric_list_is_a_live_read_candidate():
    a = analyze(total, [1.0, 2.0])
    assert any(p.space == 'list' for p in a.borrowable('entry'))
    assert a.summary('entry').read_only


def test_actual_transitive_alias_write_blocks_field():
    cell = Cell(1.0, 2.0)
    a = analyze(transitive, cell, cell)
    assert any(p.field == 'value' for p in a.summary('entry').writes)
    assert not any(p.field == 'value' for p in a.borrowable('entry'))


def test_actual_independent_field_remains_borrowable():
    a = analyze(independent, Cell(1.0, 2.0))
    assert any(p.field == 'value' for p in a.borrowable('entry'))
    assert not any(p.field == 'other' for p in a.borrowable('entry'))


def test_actual_list_growth_blocks_live_storage():
    a = analyze(append, [1.0])
    assert a.summary('entry').topology
    assert not a.borrowable('entry')


def reinitialize(cell):
    cell.__init__(3.0, 4.0)
    return cell.value


def test_constructor_on_existing_input_does_not_omit_its_writes():
    import pytest
    # The integrated R7 constructor gate already rejects this complete graph.
    with pytest.raises(heap.Unsupported, match='constructor receiver'):
        analyze(reinitialize, Cell(1.0, 2.0))
    # The memory bridge must also decline when used on settled pre-R7 metadata.
    p = heap._Program(reinitialize)
    p.widen(p.entry.vars, p.entry.params[0], heap._seed(p, Cell(1.0, 2.0), {}))
    p.settle()
    a = direct.from_program(p)
    assert not a.summary('entry').read_only
    assert not a.borrowable('entry')
