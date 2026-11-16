"""One source-slot owner is shared by function, visitor and bridge frontends."""
import gc
import types
import weakref


def captures(value):
    def read():return value
    return read


def identity(value):return value


def test_shared_frame_preserves_escaping_original_closure_cells():
    from recompyler._managed_frames import Frame
    class Owner:pass
    owner=Owner();reference=weakref.ref(owner)
    frame=Frame(captures,{'value':owner})
    code=next(value for value in captures.__code__.co_consts if type(value) is types.CodeType)
    read=types.FunctionType(code,globals(),closure=(frame.cells['value'],))
    del owner,frame;gc.collect()
    assert read() is reference() and reference() is not None
    del read;gc.collect();assert reference() is None


def test_shared_frame_supplies_exact_dictionary_execution_view():
    from recompyler._managed_frames import Frame
    frame=Frame(identity,{'value':object()})
    assert type(frame.native_data) is dict and frame.native_data is frame.data


def test_native_activation_query_is_fail_closed_without_application_probes():
    from recompyler._managed_frames import native_activation_available
    events=[]
    class Unknown:
        def __getattribute__(self,name):events.append(name);raise RuntimeError('probe')
    assert native_activation_available(Unknown()) is False
    assert native_activation_available(identity) is False
    assert events==[]
