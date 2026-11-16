"""Frame-state snapshots and checked live-value maps for exact deoptimization."""
import dis
import pytest


def source(a):
    b = a + 1
    return b


def classes():
    from recompyler.ir.deopt import (FrameState, Snapshot, Guard, LiveValue,
                                    RefKind, ValueKind, DeoptMetadata, verify_guards)
    return FrameState, Snapshot, Guard, LiveValue, RefKind, ValueKind, DeoptMetadata, verify_guards


def test_frame_maps_share_live_values_and_keep_bytecode_indices():
    F,S,G,L,R,V,D,verify = classes()
    ops = list(dis.get_instructions(source))
    offset = next(i.offset for i in ops if i.opname == 'RETURN_VALUE')
    values = (L(0,R.BORROWED,V.OBJECT), L(1,R.UNCOUNTED,V.SIGNED))
    state = F(source.__code__, offset, offset, (0,1), (1,))
    metadata = D(values, (state,))
    assert metadata.inline_depth == 0
    assert metadata.frames[0].next_instr_idx == offset // 2
    assert metadata.frames[0].localsplus[1] == metadata.frames[0].stack[0]
    verify((S(state), G(1,state)), metadata)


def test_inlined_frames_share_one_live_table():
    F,S,G,L,R,V,D,verify = classes()
    offset = next(i.offset for i in dis.get_instructions(source) if i.opname == 'RETURN_VALUE')
    state = F(source.__code__,offset,offset,(-1,0),(0,))
    metadata = D((L(0,R.OWNED,V.OBJECT),),(state,state))
    assert metadata.inline_depth == 1
    assert metadata.frames[0].stack == metadata.frames[1].stack


@pytest.mark.parametrize('change', ['index','locals','stack','offset','cache','negative'])
def test_invalid_metadata_is_rejected_before_touching_frame(change):
    F,S,G,L,R,V,D,verify = classes()
    offset = next(i.offset for i in dis.get_instructions(source) if i.opname == 'RETURN_VALUE')
    localsplus,stack = (0,0),(0,)
    if change == 'index': stack=(2,)
    if change == 'locals': localsplus=(0,)
    if change == 'stack': stack=(0,)*(source.__code__.co_stacksize+1)
    if change == 'offset': offset=3
    if change == 'cache': offset=next(i.offset+2 for i in dis.get_instructions(source) if i.opname=='BINARY_OP')
    if change == 'negative': localsplus=(-2,0)
    with pytest.raises(ValueError):
        D((L(0,R.OWNED,V.OBJECT),),(F(source.__code__,offset,offset,localsplus,stack),))


def test_guard_needs_same_dominating_snapshot_and_no_effect_between():
    F,S,G,L,R,V,D,verify = classes()
    offset = next(i.offset for i in dis.get_instructions(source) if i.opname == 'RETURN_VALUE')
    state = F(source.__code__,offset,offset,(0,0),(0,))
    metadata = D((L(0,R.OWNED,V.OBJECT),),(state,))
    with pytest.raises(ValueError,match='snapshot'): verify((G(0,state),),metadata)
    with pytest.raises(ValueError,match='effect'): verify((S(state),'effect',G(0,state)),metadata)
    with pytest.raises(ValueError,match='snapshot'): verify((S(state),G(0,F(source.__code__,2,2,(0,0),()))),metadata)


def test_unboxed_values_cannot_claim_borrowed_object_ownership():
    F,S,G,L,R,V,D,verify = classes()
    with pytest.raises(ValueError): L(0,R.BORROWED,V.DOUBLE)
    with pytest.raises(ValueError): L(-1,R.OWNED,V.OBJECT)

def test_snapshot_stack_height_must_match_original_instruction():
    F,S,G,L,R,V,D,verify=classes()
    offset=next(i.offset for i in dis.get_instructions(source) if i.opname=='RETURN_VALUE')
    with pytest.raises(ValueError,match='stack'):
        D((L(0,R.OWNED,V.OBJECT),),(F(source.__code__,offset,offset,(0,0),()),))

def test_guard_condition_must_name_a_live_value():
    F,S,G,L,R,V,D,verify=classes()
    offset=next(i.offset for i in dis.get_instructions(source) if i.opname=='RETURN_VALUE')
    state=F(source.__code__,offset,offset,(0,0),(0,))
    metadata=D((L(0,R.OWNED,V.OBJECT),),(state,))
    with pytest.raises(ValueError,match='condition'): verify((S(state),G(10,state)),metadata)

def test_null_stack_sentinel_cannot_be_used_as_return_value():
    F,S,G,L,R,V,D,verify=classes()
    offset=next(i.offset for i in dis.get_instructions(source) if i.opname=='RETURN_VALUE')
    with pytest.raises(ValueError,match='NULL'):
        D((L(0,R.OWNED,V.OBJECT),),(F(source.__code__,offset,offset,(0,0),(-1,)),))
