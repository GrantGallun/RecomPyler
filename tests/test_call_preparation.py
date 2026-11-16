"""Real preparation-helper execution through shared managed boundaries."""
from types import SimpleNamespace
import pytest
from recompyler import heap


def formatted_library_value(value, specification):
    return f'item:{value!r:{specification}}'


def test_formatted_library_value_uses_original_protocol():
    events = []
    class Value:
        def __repr__(self):
            events.append('repr')
            return 'value'
    lifted = heap.lift_calls(formatted_library_value)
    assert lifted(Value(), '>8') == 'item:   value'
    assert events == ['repr']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_real_generated_region_preparation_is_compiled():
    lift_structures = heap.lift_structures
    def original(value):
        return value + 1
    program = SimpleNamespace(entry_fn=original, entry=SimpleNamespace(name='generated'),
        source='def generated(value):\n    return value + 1\ngenerated.py_func = generated\n')
    lifted = lift_structures(heap._inlined_entry)
    generated = lifted(program)
    assert generated(41) == 42
    assert generated.__globals__['generated'] is generated
    assert lifted.compiled_calls == 1 and lifted.managed_calls >= 5
    assert lifted.fallback_calls == 0

def dynamic_format(value, specifier):
    return f'{value!r:{specifier()}}'


def implicit_format(value):
    return f'{value}'


def explicit_format_conversions(value):
    return (f'{value!s}', f'{value!r}', f'{value!a}')


def format_literal():
    return f'original-format-literal'


def test_conversion_precedes_dynamic_specification():
    events = []
    class Value:
        def __repr__(self):
            events.append('repr')
            return 'result'
    def specifier():
        events.append('spec')
        return '>8'
    lifted = heap.lift_calls(dynamic_format)
    assert lifted(Value(), specifier) == '  result'
    assert events == ['repr', 'spec']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_format_exception_and_mutation_happen_once():
    events = []
    error = ValueError('format failed')
    class Value:
        def __format__(self, spec):
            events.append(spec)
            raise error
    lifted = heap.lift_calls(implicit_format)
    with pytest.raises(ValueError) as actual:
        lifted(Value())
    assert actual.value is error
    assert events == ['']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_single_formatted_string_keeps_exact_original_owner():
    original = ''.join(['managed', 'original', 'string'])
    lifted = heap.lift_calls(implicit_format)
    assert lifted(original) is original
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_formatted_literal_keeps_original_code_owner():
    lifted = heap.lift_calls(format_literal)
    assert lifted() is format_literal()
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_all_explicit_conversions_use_cpython_protocol():
    value = ['?', '\ud800', '??']
    lifted = heap.lift_calls(explicit_format_conversions)
    assert lifted(value) == explicit_format_conversions(value)
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0

def nested_formatted_spec(value, spec):
    return f'{value:{spec}}'


def test_single_formatted_subclass_keeps_type_and_original_owner():
    class Text(str):
        pass
    original = Text('formatted subclass')
    class Value:
        def __format__(self, spec):
            return original
    lifted = heap.lift_calls(implicit_format)
    assert implicit_format(Value()) is original
    assert lifted(Value()) is original
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_nested_specification_keeps_formatted_subclass():
    class Text(str):
        pass
    class Spec:
        def __format__(self, spec):
            return Text('spec')
    class Value:
        def __format__(self, spec):
            return type(spec).__name__
    lifted = heap.lift_calls(nested_formatted_spec)
    assert nested_formatted_spec(Value(), Spec()) == 'Text'
    assert lifted(Value(), Spec()) == 'Text'
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0

preparation_events = []


def test_real_generated_preparation_error_keeps_effects_once():
    import sys
    from importlib import import_module
    def original(value):
        return value
    source = (f'from importlib import import_module\n'
              f'import_module({__name__!r}).preparation_events.append("once")\n'
              'raise ValueError("generated failure")\n')
    program = SimpleNamespace(entry_fn=original, entry=SimpleNamespace(name='generated'), source=source)
    before = set(sys.modules)
    preparation_events.clear()
    lifted = heap.lift_structures(heap._inlined_entry)
    try:
        with pytest.raises(ValueError, match='generated failure'):
            lifted(program)
        added = [name for name in set(sys.modules)-before if name.startswith('rc_inlined_heap')]
        assert len(added) == 1
        assert preparation_events == ['once']
        assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0
    finally:
        for name in set(sys.modules)-before:
            if name.startswith('rc_inlined_heap'):
                del sys.modules[name]
        preparation_events.clear()


def add_small_literal(value):
    return value + 1


def small_literal_format_width(value):
    return f'{value:>{3}}'


def test_small_integer_operation_origin_is_identity_exempt():
    lifted = heap.lift_calls(add_small_literal)
    assert lifted(41) == 42
    assert type(lifted(41)) is int
    assert lifted.compiled_calls == 2 and lifted.fallback_calls == 0


def test_small_integer_format_width_uses_shared_operation_fact():
    lifted = heap.lift_calls(small_literal_format_width)
    assert lifted('a') == '  a'
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0
