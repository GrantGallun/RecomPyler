"""Self-host swaps are opt-in, descriptor-correct and reversible."""
import importlib.util
from pathlib import Path
import sys
from types import ModuleType


def host_identity(value):
    return value


class Host:
    def method(self, value): return value
    @staticmethod
    def static(value): return value
    @classmethod
    def classed(cls, value): return value
    @property
    def value(self): return self.marker


def load_tool():
    spec = importlib.util.spec_from_file_location('self_host_tool', Path(__file__).parents[1]/'tools/self_host.py')
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def test_live_function_swap_executes_compiled_body_and_restores_exact_owner():
    from recompyler import heap
    tool = load_tool()
    module = ModuleType('host-fixture')
    module.host_identity = host_identity
    binding = tool.locate(module, 'host_identity', host_identity.__code__.co_firstlineno)
    region = heap.lift_calls(host_identity)
    undo = binding.install(region)
    marker = object()
    try:
        assert module.host_identity(marker) is marker
        assert region.compiled_calls == 1 and region.fallback_calls == 0
        assert module.host_identity.__wrapped__ is host_identity
    finally:
        undo()
    assert module.host_identity is host_identity


def test_method_static_class_and_property_swaps_keep_descriptor_behavior():
    from recompyler import heap
    tool = load_tool()
    module = ModuleType('host-fixture')
    module.Host = Host
    originals = dict(vars(Host))
    undos = []
    regions = []
    try:
        for name, function in [('method', originals['method']),
            ('static', originals['static'].__func__), ('classed', originals['classed'].__func__),
            ('value', originals['value'].fget)]:
            binding = tool.locate(module, 'Host.' + name, function.__code__.co_firstlineno)
            region = heap.lift_calls(function)
            regions.append(region)
            undos.append(binding.install(region))
        marker = object()
        instance = Host()
        instance.marker = marker
        assert instance.method(marker) is marker
        assert Host.static(marker) is marker
        assert Host.classed(marker) is marker
        assert instance.value is marker
        assert [r.compiled_calls for r in regions] == [1, 1, 1, 1]
    finally:
        for undo in reversed(undos): undo()
    assert all(vars(Host)[name] is originals[name] for name in ('method','static','classed','value'))


def test_nested_or_decorated_binding_is_reported_unavailable():
    tool = load_tool()
    module = ModuleType('host-fixture')
    module.host_identity = host_identity
    assert tool.locate(module, 'outer.<locals>.inner', 1) is None
    assert tool.locate(module, 'host_identity', 999999) is None
