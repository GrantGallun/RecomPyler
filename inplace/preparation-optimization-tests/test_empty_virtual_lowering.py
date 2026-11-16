"""Prepared fail-first tests; not collected until coordinator activates them.

The optimization contract is to avoid full Lower when no Virtual can exist,
while preserving normalized source, seals, F5 validation, and native behavior.
"""
import ast
import copy
from types import SimpleNamespace

import pytest

from recompyler import heap, scalar
from recompyler.escape import EscapeAnalysis, FunctionIR


FULL_LOWER = scalar.Lower


class Cell:
    def __init__(self, value):
        self.value = value


def helper(value, step=2):
    return value + step


def loops_and_calls(count):
    total = 0
    for index in range(count):
        total += helper(index)
    return total


def captured_allocation(value, output):
    made = Cell(value)
    output.append(made)
    output.append(made)
    return made.value


def read_field(cell):
    return cell.value


def local_field_clone(value):
    made = Cell(value)
    return read_field(made)


def make_cell(value):
    return Cell(value)


def fresh_return_clone(value):
    made = make_cell(value)
    return made.value + 1


class SourceOnly(dict):
    def __bool__(self): return True
    def get(self, key, default=None): return True


def source_program(fn, args):
    region = heap.Region(fn, ahead_of_time=SourceOnly())
    program = region.program_for(args)
    assert program is not None, region.problem
    return program


def normalize(tree):
    return ast.unparse(ast.fix_missing_locations(tree))


def engine_for(source, *, object_params=(), allocations=None, extra=()):
    function = FunctionIR('f', source, tuple(object_params), allocations or {})
    analysis = EscapeAnalysis([function, *extra])
    engine = object.__new__(scalar.ScalarReplacer)
    engine.p = SimpleNamespace(facts=heap._facts.Facts())
    engine.h = heap
    engine.analysis = analysis
    engine.epoch = 0
    engine.by_clone = {}
    return engine, ast.parse(source).body[0]


def full_result(engine, tree, locals_, params, clone, fresh):
    return FULL_LOWER(engine, 'f', copy.deepcopy(tree), locals_, params, clone, fresh).lower()


EMPTY_CASES = [
    ('calls_and_loops', '''@njit(error_model="numpy", inline="always")
def f(F, I, top, st, count):
    total = 0
    for index in range(count):
        if index & 1:
            total = total + callee(F, I, top, st, index)
        else:
            total = total + index
    return total
''', {}),
    ('captured_allocation', '''@njit(error_model="numpy")
def f(F, I, top, st, value, output):
    p = alloc(I, top, st, 1)
    I[p + 0] = value
    I[output + 0] = p
    unknown_consumer(p)
    return I[p + 0]
''', {'p': Cell}),
    ('default_return_and_decorator', '''@njit(error_model="numpy", inline="always")
def f(F, I, top, st, value=7):
    if st[0]:
        return -1
    return value
''', {}),
    ('try_finally_and_fallthrough', '''@njit(error_model="numpy")
def f(F, I, top, st, value):
    try:
        if value:
            return value
    finally:
        I[0] = I[0] + 1
''', {}),
]


@pytest.mark.parametrize('name,source,allocations', EMPTY_CASES, ids=[row[0] for row in EMPTY_CASES])
def test_empty_virtual_path_skips_full_lower_and_preserves_ast_and_digest(monkeypatch, name, source, allocations):
    engine, tree = engine_for(source, allocations=allocations)
    original_ast = ast.dump(tree, include_attributes=True)
    expected = normalize(full_result(engine, tree, {}, {}, None, {}))
    checks = []
    ordinary_check = engine.check_clones
    def validate(body):
        checks.append(normalize(copy.deepcopy(body)))
        return ordinary_check(body)
    engine.check_clones = validate
    def forbidden_full_lower(*args, **kwargs):
        raise AssertionError('empty-Virtual lowering still constructs full Lower')
    monkeypatch.setattr(scalar, 'Lower', forbidden_full_lower)
    result = engine.checked_lower('f', tree, {}, {}, None, {})
    actual = normalize(result)
    assert actual == expected
    assert heap._source_digest(actual) == heap._source_digest(expected)
    assert ast.dump(tree, include_attributes=True) == original_ast
    assert result.decorator_list == []
    assert checks, 'the shortcut must retain clone reachability validation'
    facts = [fact for (family, _), fact in engine.p.facts.answers.items() if family == 'F5']
    assert len(facts) == 1 and facts[0].state == 'proven'
    assert facts[0].value == expected
    if name == 'default_return_and_decorator':
        assert normalize(result.args.defaults[0]) == '7'
        assert any(isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.USub)
                   for node in ast.walk(result))


def test_empty_virtual_path_rejects_failed_clone_in_uncached_and_cached_proofs(monkeypatch):
    source = 'def f(F, I, top, st, value):\n    return sr_existing(F, I, top, st, value)\n'
    engine, tree = engine_for(source)
    engine.by_clone['sr_existing'] = dict(failed=False, building=False,
        info=SimpleNamespace(source='def sr_existing(F,I,top,st,value):\n    return value\n'))
    def forbidden_full_lower(*args, **kwargs):
        raise AssertionError('empty-Virtual lowering still constructs full Lower')
    monkeypatch.setattr(scalar, 'Lower', forbidden_full_lower)
    engine.checked_lower('f', tree, {}, {}, None, {})
    engine.by_clone['sr_existing']['failed'] = True
    with pytest.raises(scalar.CannotScalar, match='failed clone'):
        engine.checked_lower('f', tree, {}, {}, None, {})
    engine.p.facts.answers.clear()
    with pytest.raises(scalar.CannotScalar, match='failed clone'):
        engine.checked_lower('f', tree, {}, {}, None, {})
    fact = next(fact for (family, _), fact in engine.p.facts.answers.items() if family == 'F5')
    assert fact.state == 'unknown'


@pytest.mark.parametrize('boundary', ['locals', 'params', 'fresh', 'clone'])
def test_nonempty_virtual_boundaries_still_use_full_lower(monkeypatch, boundary):
    virtual = scalar.Virtual('f:p', Cell, {('I', 0): ('v_scalar', heap.INT)})
    locals_, params, fresh, clone = {}, {}, {}, None
    if boundary == 'locals':
        source = 'def f(F,I,top,st,value):\n    p=alloc(I,top,st,1)\n    I[p+0]=value\n    return I[p+0]\n'
        engine, tree = engine_for(source, allocations={'p': Cell})
        locals_ = {'f:p': virtual}
    elif boundary == 'params':
        source = 'def f(F,I,top,st,p):\n    return I[p+0]\n'
        engine, tree = engine_for(source, object_params=('p',))
        params = {4: virtual}
    elif boundary == 'fresh':
        source = 'def f(F,I,top,st,value):\n    p=make(F,I,top,st,value)\n    return I[p+0]\n'
        maker = FunctionIR('make', 'def make(F,I,top,st,value):\n    q=alloc(I,top,st,1)\n    I[q+0]=value\n    return q\n', allocations={'q': Cell}, object_return=True)
        engine, tree = engine_for(source, extra=(maker,))
        fresh = {'p': virtual}
        engine.clone = lambda *args, **kwargs: dict(info=SimpleNamespace(name='sr_make'), params={}, updates=[], return_width=1)
    else:
        source = 'def f(F,I,top,st,value):\n    return value\n'
        engine, tree = engine_for(source)
        clone = dict(info=SimpleNamespace(name='sr_f'), params={}, fresh_result=None, return_width=1, updates=[])
    expected = normalize(full_result(engine, tree, locals_, params, clone, fresh))
    calls = []
    def counted_full_lower(*args, **kwargs):
        calls.append(True)
        return FULL_LOWER(*args, **kwargs)
    monkeypatch.setattr(scalar, 'Lower', counted_full_lower)
    actual = engine.checked_lower('f', tree, locals_, params, clone, fresh)
    assert calls, f'{boundary} must not take the empty-Virtual shortcut'
    assert normalize(actual) == expected
    if boundary in ('locals', 'params', 'fresh'):
        assert 'v_scalar' in normalize(actual)


def full_checked_reference(self, name, tree, locals_, params, clone, fresh):
    """Independent full-transform oracle, never the proposed empty fast path."""
    body = FULL_LOWER(self, name, copy.deepcopy(tree), locals_, params, clone, fresh).lower()
    self.check_clones(body)
    normalized = normalize(body)
    answer = ast.parse(normalized).body[0]
    self.check_clones(answer)
    return answer


@pytest.mark.parametrize('fn,args', [
    (loops_and_calls, (6,)),
    (captured_allocation, (7, [])),
    (local_field_clone, (7,)),
    (fresh_return_clone, (7,)),
])
def test_whole_program_generated_source_and_digest_equal_full_transform(monkeypatch, fn, args):
    optimized = source_program(fn, args)
    with monkeypatch.context() as context:
        context.setattr(scalar.ScalarReplacer, 'checked_lower', full_checked_reference)
        reference = source_program(fn, args)
    assert optimized.source == reference.source
    assert optimized.digest == reference.digest
    for key in ('removed_sites', 'field_clones', 'fresh_return_clones', 'blocked'):
        assert optimized.scalar_report.get(key) == reference.scalar_report.get(key)
    if fn is local_field_clone:
        assert optimized.scalar_report['removed_sites']
        assert optimized.scalar_report['field_clones']
    if fn is fresh_return_clone:
        assert optimized.scalar_report['fresh_return_clones']


@pytest.mark.parametrize('fn,args,expected', [
    (loops_and_calls, (6,), 27),
    (local_field_clone, (7,), 7),
    (fresh_return_clone, (7,), 8),
])
def test_successful_native_execution_and_r8_reach(fn, args, expected):
    region = heap.Region(fn)
    assert region(*args) == expected
    assert region.compiled_calls == 1 and region.fallback_calls == 0, region.problem
    assert region.aot_calls + region.jit_calls == 1
    if fn is not loops_and_calls:
        assert region.latest.scalar_report['removed_sites'] or region.latest.scalar_report.get('fresh_return_clones')


def test_captured_allocation_stays_captured_on_successful_native_call():
    output = []
    region = heap.Region(captured_allocation)
    assert region(7, output) == 7
    assert region.compiled_calls == 1 and region.fallback_calls == 0, region.problem
    assert len(output) == 2 and output[0] is output[1]
    assert type(output[0]) is Cell and output[0].value == 7
    allocations = region.latest.escape_analysis.allocations
    retained = [row for row in allocations.values() if row['record'].endswith('Cell') and row['captured']]
    assert retained, allocations
