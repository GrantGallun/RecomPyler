"""Original nested code builds share the bytecode SSA builder without fake cells."""
import types
from recompyler.ir.verifier import verify
from recompyler.ir.lower_llvm import lower

def test_original_compiler_nested_code_builds_without_a_placeholder_function():
    from recompyler.ir.builder import build_code
    code=next(c for c in verify.__code__.co_consts if type(c) is types.CodeType and c.co_name=='require')
    graph=build_code(code)
    assert graph.code is code and graph.function is None
    assert lower(graph,frame_entry=True).body_address>0

def test_code_only_closure_body_does_not_need_fabricated_cells():
    from recompyler.ir.builder import build_code
    def outer(value):
        def child():return value
        return child
    code=next(c for c in outer.__code__.co_consts if type(c) is types.CodeType)
    graph=build_code(code)
    assert graph.code is code and graph.function is None
    assert lower(graph,frame_entry=True).body_address>0


def test_code_only_graph_does_not_retain_dynamic_closure_values():
    import weakref,gc
    from recompyler.ir.builder import build_code
    class Marker:pass
    def factory():
        value=Marker()
        def child():return value
        return child,weakref.ref(value)
    child,reference=factory();function_reference=weakref.ref(child)
    graph=build_code(child.__code__)
    del child;gc.collect()
    assert graph.function is None and function_reference() is None and reference() is None

def test_original_live_cells_are_used_when_code_only_body_executes():
    from recompyler.ir.builder import build_code
    from test_ir_existing_frame import frame_entry
    def factory(value):
        def child():return value
        return child
    marker=object();replacement=object();child=factory(marker)
    native,_,_=frame_entry(child,graph=build_code(child.__code__))
    assert native() is marker
    child.__closure__[0].cell_contents=replacement
    assert native() is replacement

def test_non_code_inputs_decline_without_accessing_user_properties():
    import pytest
    from recompyler.ir.builder import build_code
    class Foreign:
        @property
        def __code__(self):raise AssertionError('user property')
    with pytest.raises(TypeError):build_code(Foreign())
