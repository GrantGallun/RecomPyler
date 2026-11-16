"""Closed typed proof IR for direct access; no runtime pointers in facts."""
import pytest

from recompyler import direct


def op(code, **kw):
    return direct.Operation(code, **kw)


def fn(name, *ops):
    return direct.FunctionIR(name, ops)


VALUE = direct.Place('field', 1, 'value')
OTHER = direct.Place('field', 1, 'other')
ITEM = direct.Place('list', 2)


def test_whole_pure_reader_reports_read_only_locations():
    a = direct.Effects([fn('read', op('load_numeric', place=VALUE), op('load_numeric', place=ITEM))])
    s = a.summary('read')
    assert s.reads == frozenset((VALUE, ITEM))
    assert a.borrowable('read') == s.reads
    assert s.read_only


def test_transitive_alias_write_blocks_same_canonical_family_only():
    alias = direct.Place('field', 9, 'value')
    a = direct.Effects([
        fn('read', op('load_numeric', place=VALUE), op('load_numeric', place=OTHER), op('call', callee='write')),
        fn('write', op('store_numeric', place=alias)),
    ], canonical={('field', 9): 1})
    assert a.borrowable('read') == frozenset((OTHER,))
    assert a.summary('read').writes == frozenset((VALUE,))
    assert not a.summary('read').read_only


def test_recursive_scc_propagates_deep_write_and_marks_every_member():
    a = direct.Effects([
        fn('a', op('load_numeric', place=ITEM), op('call', callee='b')),
        fn('b', op('call', callee='c')),
        fn('c', op('store_numeric', place=ITEM), op('call', callee='a')),
    ])
    assert all(a.summary(name).recursive for name in ('a', 'b', 'c'))
    assert all(a.summary(name).writes == frozenset((ITEM,)) for name in ('a', 'b', 'c'))
    assert not a.borrowable('a')


def test_list_topology_change_blocks_all_items_through_aliases():
    alias = direct.Place('list', 7)
    a = direct.Effects([fn('root', op('load_numeric', place=ITEM), op('call', callee='append')),
                        fn('append', op('resize', place=alias))], canonical={('list', 7): 2})
    assert a.summary('root').topology == frozenset((ITEM,))
    assert not a.borrowable('root')


@pytest.mark.parametrize('operation', [op('future'), op('call', callee='missing'), op('helper', helper='unregistered')])
def test_unknown_operation_call_or_helper_never_becomes_pure(operation):
    a = direct.Effects([fn('root', op('load_numeric', place=VALUE), operation)])
    assert a.summary('root').unknown
    assert not a.summary('root').read_only
    assert not a.borrowable('root')


def test_helper_contract_is_explicit_and_transitive():
    helper = direct.Helper('list_get', reads=frozenset((ITEM,)), failures=frozenset(('bounds',)))
    a = direct.Effects([fn('root', op('call', callee='inner')), fn('inner', op('helper', helper='list_get'))], helpers=[helper])
    assert a.summary('root').reads == frozenset((ITEM,))
    assert a.summary('root').failures == frozenset(('bounds',))
    assert a.borrowable('root') == frozenset((ITEM,))


@pytest.mark.parametrize('code', ['observer', 'rng', 'array_write'])
def test_observer_rng_or_array_write_blocks_live_reads(code):
    a = direct.Effects([fn('root', op('load_numeric', place=VALUE), op(code))])
    assert not a.borrowable('root')
    assert not a.summary('root').read_only


def test_topology_of_a_field_owner_blocks_its_other_field_reads():
    a = direct.Effects([fn('root', op('load_numeric', place=OTHER), op('resize', place=VALUE))])
    assert not a.borrowable('root')


@pytest.mark.parametrize('code', ['load_numeric', 'store_numeric', 'resize'])
def test_missing_location_is_unknown_instead_of_empty_effect(code):
    a = direct.Effects([fn('root', op(code))])
    assert a.summary('root').unknown
    assert not a.summary('root').read_only


def test_canonical_alias_cycles_are_rejected():
    with pytest.raises(ValueError, match='canonical.*cycle'):
        direct.Effects([fn('root')], canonical={('field', 1): 2, ('field', 2): 1})


def test_identity_demand_propagates_through_forward_select_and_loops():
    values = {
        'left': direct.Producer('existing'), 'right': direct.Producer('existing'),
        'phi': direct.Producer('select', ('left', 'right', 'loop')),
        'loop': direct.Producer('forward', ('phi',)),
        'return': direct.Producer('forward', ('loop',)),
    }
    a = direct.Identity(values, ('return',))
    assert a.demanded == frozenset(values)
    assert a.existing == frozenset(('left', 'right'))
    assert not a.problems


def test_independent_arithmetic_producer_stops_operand_token_demand():
    a = direct.Identity({'argument': direct.Producer('existing'),
                         'result': direct.Producer('independent', ('argument',))}, ('result',))
    assert a.demanded == frozenset(('result',))
    assert a.fresh == frozenset(('result',))
    assert not a.existing


def test_shared_producer_has_one_token_but_distinct_sites_remain_distinct():
    a = direct.Identity({'a': direct.Producer('independent'), 'b': direct.Producer('independent'),
                         'x': direct.Producer('forward', ('a',)), 'y': direct.Producer('forward', ('a',))}, ('x', 'y', 'b'))
    assert a.fresh == frozenset(('a', 'b'))
    assert a.transfers['x'] == a.transfers['y'] == ('a',)
    assert 'x' not in a.fresh and 'y' not in a.fresh


def test_exact_recipe_demands_operand_identity_and_unknown_demand_fails_closed():
    a = direct.Identity({'source': direct.Producer('existing'),
                         'result': direct.Producer('exact', ('source',)),
                         'bad': direct.Producer('unsupported')}, ('result', 'bad', 'lost'))
    assert a.existing == frozenset(('source',))
    assert a.recipes == frozenset(('result',))
    assert set(a.problems) == {'bad: unsupported producer', 'lost: missing producer'}


def test_unused_unsupported_producer_does_not_require_a_box():
    a = direct.Identity({'used': direct.Producer('existing'), 'dead': direct.Producer('unsupported')}, ('used',))
    assert not a.problems
    assert a.demanded == frozenset(('used',))


def test_empty_or_malformed_forward_is_a_computed_decline():
    a = direct.Identity({'bad': direct.Producer('forward')}, ('bad',))
    assert a.problems == ('bad: forward requires operands',)


def test_effect_facts_hold_only_primitives_and_are_deterministic():
    a = direct.Effects([fn('root', op('load_numeric', place=VALUE), op('call', callee='child')), fn('child', op('checked_exit'))])
    b = direct.Effects([fn('child', op('checked_exit')), fn('root', op('load_numeric', place=VALUE), op('call', callee='child'))])
    assert a.report() == b.report()
    assert a.summary('root').failures == frozenset(('checked',))
    assert isinstance(a.report()['root']['reads'][0]['owner'], int)
