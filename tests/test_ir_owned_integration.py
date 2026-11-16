"""Joint native Entry -> canonical provider -> original CALL owner transfer."""
import ctypes
from recompyler import _source_frames_native as frames
from test_ir_owned_call import owned_entry,events_for


def current_callable():
    return ctypes.PYFUNCTYPE(ctypes.c_void_p)(frames.addresses()['current_callable'])()


def test_actual_native_entry_uses_shared_owner_claim_without_target_packet():
    entry,claimed=owned_entry(actual_hook=True)
    result,events=events_for(entry)
    assert result==37 and claimed.value==1
    assert events==['drop','weakref','observe','after']
    assert current_callable() is None
    assert frames.active_depth()==0


def test_actual_callable_scope_restores_after_nested_native_entries():
    first,first_claim=owned_entry(actual_hook=True)
    second,second_claim=owned_entry(actual_hook=True)
    seen=[]
    def inner():
        seen.append(current_callable()==id(second))
        return 37
    def outer():
        seen.append(current_callable()==id(first))
        result=second(None,inner)
        seen.append(current_callable()==id(first))
        return result
    result=first(None,outer)
    assert result==37 and seen==[True,True,True]
    assert first_claim.value==second_claim.value==1
    assert current_callable() is None
    assert frames.active_depth()==0
