"""Bitset lattice operations never underapproximate Python object values."""
import struct
import pytest


def test_python_objects_and_native_primitives_are_disjoint():
    from recompyler.ir.type_lattice import OBJECT,PRIMITIVE,TOP,BOTTOM,Atom,TypeSet
    assert OBJECT&PRIMITIVE==BOTTOM and OBJECT|PRIMITIVE==TOP
    assert not TypeSet(Atom.SIGNED64).matches(3)
    assert not TypeSet(Atom.NULL).matches(None)


def test_exact_bool_is_distinct_from_exact_int_and_subclasses_widen():
    from recompyler.ir.type_lattice import exact_builtin,from_value,OBJECT
    class Int(int):pass
    assert not exact_builtin(int).matches(True)
    assert exact_builtin(bool).matches(True)
    assert from_value(Int(3))<=OBJECT
    assert not from_value(Int(3))<=exact_builtin(int)


def test_constant_join_meet_subtraction_and_subtype():
    from recompyler.ir.type_lattice import constant,exact_builtin,BOTTOM
    a,b=constant(3),constant(4)
    assert a|b==exact_builtin(int)
    assert a&b==BOTTOM and a&exact_builtin(int)==a
    assert a<=exact_builtin(int) and not exact_builtin(int)<=a
    assert a-a==BOTTOM and a-b==a
    assert exact_builtin(int)-a==exact_builtin(int)


def test_signed_zero_and_nan_payload_are_kept_bit_exact():
    from recompyler.ir.type_lattice import constant,exact_builtin,BOTTOM
    positive,negative=constant(0.0),constant(-0.0)
    assert positive!=negative and positive&negative==BOTTOM
    assert positive|negative==exact_builtin(float)
    nan=struct.unpack('>d',bytes.fromhex('7ff8000000000042'))[0]
    c=constant(nan)
    assert struct.pack('>d',c.materialize())==struct.pack('>d',nan)
    assert c==constant(nan) and c.matches(nan)


@pytest.mark.parametrize('value',[None,True,False,2**140,-5,-0.0,complex(-0.0,2.0)])
def test_literal_roundtrip_preserves_exact_type(value):
    from recompyler.ir.type_lattice import constant
    c=constant(value);other=c.materialize()
    assert type(other) is type(value) and c.matches(other)
    if type(value) is complex:assert struct.pack('>dd',other.real,other.imag)==struct.pack('>dd',value.real,value.imag)
    elif type(value) is float:assert struct.pack('>d',other)==struct.pack('>d',value)
    else:assert other==value


def test_classification_does_not_call_metaclass_hash_or_user_protocols():
    from recompyler.ir.type_lattice import from_value,constant,OBJECT
    class Meta(type):
        def __hash__(self):raise AssertionError('hash')
        def __eq__(self,other):raise AssertionError('eq')
    class Value(metaclass=Meta):
        def __bool__(self):raise AssertionError('bool')
        def __eq__(self,other):raise AssertionError('eq')
    value=Value()
    assert from_value(value)<=OBJECT and from_value(value).matches(value)
    with pytest.raises(ValueError):constant(value)


def test_finite_lattice_set_laws_and_sound_coverage():
    from recompyler.ir.type_lattice import constant,exact_builtin,from_value,OBJECT,TOP,BOTTOM
    samples=(None,False,True,-1,0,3,4,-0.0,0.0,1.0,complex(1,2),'x',[],{},object())
    types=(BOTTOM,TOP,OBJECT,exact_builtin(int),constant(3),constant(-0.0),exact_builtin(float)|exact_builtin(str))
    for a in types:
        assert a|BOTTOM==a and a&TOP==a and a-a==BOTTOM
        for b in types:
            assert a|b==b|a and a&b==b&a
            assert a<=a|b and a&b<=a
            for value in samples:
                if a.matches(value) or b.matches(value):assert (a|b).matches(value)
                if a.matches(value) and b.matches(value):assert (a&b).matches(value)
                if a.matches(value) and not b.matches(value):assert (a-b).matches(value)


def test_native_literal_range_validation_and_boxed_separation():
    from recompyler.ir.type_lattice import Atom,primitive_constant,constant
    assert primitive_constant(Atom.SIGNED64,-2**63).materialize()==-2**63
    assert primitive_constant(Atom.UNSIGNED64,2**64-1).materialize()==2**64-1
    assert primitive_constant(Atom.CBOOL,True)!=constant(True)
    for atom,value in ((Atom.SIGNED64,2**63),(Atom.UNSIGNED64,-1),(Atom.CBOOL,1)):
        with pytest.raises(ValueError):primitive_constant(atom,value)
