"""Adversarial fail-first checks for the direct-proof ownership boundary."""
import gc
import importlib.util
import weakref

import pytest

from recompyler import direct, heap


def test_replacing_parent_reference_invalidates_child_family_locations():
    parent_link = direct.Place('field', 1, 'child')
    child_number = direct.Place('field', 2, 'value')
    analysis = direct.Effects((direct.FunctionIR('root', (
        direct.Operation('load_numeric', place=child_number),
        direct.Operation('store_reference', place=parent_link))),))
    assert not analysis.borrowable('root'), 'no path-dependency proof permits a stale child map'


def test_identity_cycle_without_original_or_producer_cannot_materialize():
    identity = direct.Identity({'a': direct.Producer('forward', ('b',)),
                                'b': direct.Producer('forward', ('a',))}, ('a',))
    assert identity.problems
    assert all('no origin' in problem for problem in identity.problems)


def test_unanchored_phi_arm_is_not_hidden_by_an_anchored_other_arm():
    identity = direct.Identity({'source': direct.Producer('existing'),
                                'loop': direct.Producer('forward', ('loop',)),
                                'phi': direct.Producer('select', ('source', 'loop'))}, ('phi',))
    assert any(problem.startswith('loop:') for problem in identity.problems)


def test_proof_metadata_cannot_retain_arbitrary_class_identity_keys():
    class Ephemeral:
        pass
    with pytest.raises(ValueError, match='primitive'):
        direct.Identity({Ephemeral: direct.Producer('existing')}, (Ephemeral,))


@pytest.mark.parametrize('class_cell', [False, True])
def test_constructor_escape_cache_does_not_keep_classes_alive(class_cell):
    def discover():
        if class_cell:
            class Ephemeral:
                def __init__(self, value):
                    self.value = value if __class__ is not None else 0
        else:
            class Ephemeral:
                def __init__(self, value):
                    self.value = value
        heap._init_assigned(Ephemeral, Ephemeral.__init__)
        return weakref.ref(Ephemeral)
    reference = discover()
    gc.collect()
    assert reference() is None, 'constructor facts must not change ordinary class weakref lifetime'


def test_unproved_llvm_intrinsic_is_not_automatically_callback_free():
    from llvmlite import ir
    from numba import njit, types
    from numba.extending import intrinsic
    from recompyler import _direct_adapter as adapter

    @intrinsic
    def marker(typingctx):
        def codegen(context, builder, sig, args):
            function = ir.Function(builder.module, ir.FunctionType(ir.VoidType(), ()), 'llvm.sideeffect')
            builder.call(function, ())
            return context.get_dummy_value()
        return types.void(), codegen

    def native(F, I, top, st):
        marker()
        return I[0]

    signature = (types.float64[::1], types.int64[::1], types.int64[::1], types.uint8[::1])
    with pytest.raises(adapter.AdapterDecline, match='intrinsic'):
        adapter.build(njit(_nrt=False)(native), signature)


@pytest.mark.parametrize('make', [
    lambda obj: direct.FunctionIR(obj, ()),
    lambda obj: direct.Helper(obj),
    lambda obj: direct.Operation('call', callee=obj),
    lambda obj: direct.Producer('forward', (obj,)),
])
def test_all_persistent_names_and_operands_are_primitive(make):
    class Ephemeral:
        pass
    with pytest.raises(ValueError, match='primitive'):
        make(Ephemeral)


@pytest.mark.parametrize('make', [
    lambda owner: direct.Place(owner('field'), 1),
    lambda owner: direct.Summary(helpers=frozenset((owner('helper'),))),
    lambda owner: direct.Identity({'value': owner}, ('value',)),
])
def test_subclasses_and_untyped_values_cannot_smuggle_owned_references(make):
    class OwnedString(str):
        pass
    with pytest.raises(ValueError, match='primitive'):
        make(OwnedString)
