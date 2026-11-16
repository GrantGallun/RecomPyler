"""Existing CPython frames use the common emitter without rebinding or popping."""
import ctypes,dis,sys,weakref
import pytest
from llvmlite import ir,binding
from recompyler import heap,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import create_callable
from recompyler.ir.symbols import CPythonSymbols


def frame_entry(function,*,compile_as=None,entry_offset=None,pending_callback=None,interrupt=False,lowering_options=None,graph=None,structure_calls=None,allow_protected=False):
    if function.__code__.co_exceptiontable and not allow_protected:
        from recompyler.ir.builder import UnsupportedBytecode
        raise UnsupportedBytecode('protected frame tests require real executor entry')
    options=dict(lowering_options or {})
    if entry_offset is not None:options["entry_offset"]=entry_offset
    if structure_calls is not None:options['structure_calls']=structure_calls
    lowered=lower(build(compile_as or function) if graph is None else graph,frame_entry=True,**options)
    layout=frames.layout();symbols=CPythonSymbols()
    for name,address in frames.addresses().items():symbols.register_external('existing_test_'+name,address,frames)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
    module=ir.Module();module.triple=binding.get_process_triple()
    body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),'wrapper')
    original,args,nargs,names=body.args;b=ir.IRBuilder(body.append_basic_block('entry'))
    status=ctypes.c_int(-99);null=ir.Constant(p,None)
    def number(value):return ir.Constant(n,value)
    def address(value):return number(id(value)).inttoptr(p)
    def call(name,result,values):return b.call(symbols.declare(module,name,result,[v.type for v in values]),values)
    code_base=b.gep(address(function.__code__),[number(layout['code_data_offset'])])
    resume=next(op.offset for op in dis.get_instructions(function) if op.opname=='RESUME')
    count=b.and_(nargs,number((1<<63)-1))
    frame=call('existing_test_enter',p,[original,address(function.__code__),args,count,number(resume)])
    with b.if_then(b.icmp_unsigned('==',frame,null)):b.ret(null)
    actual=call('existing_test_current_callable',p,[])
    claimed=call('existing_test_claim_call_args',i,[frame,actual,args,count])
    b.store(claimed,number(ctypes.addressof(status)).inttoptr(i.as_pointer()))
    localbase=b.bitcast(b.gep(frame,[number(layout['locals_offset'])]),n.as_pointer())
    base=b.gep(localbase,[number(frames.localsplus_count(function.__code__))])
    sp=b.bitcast(b.gep(frame,[number(layout['stackpointer_offset'])]),n.as_pointer().as_pointer())
    ip=b.bitcast(b.gep(frame,[number(layout['instrptr_offset'])]),p.as_pointer())
    thread=call('PyThreadState_Get',p,[])
    target=b.inttoptr(number(lowered.body_address),ir.FunctionType(p,[p,n.as_pointer(),p]).as_pointer())
    if pending_callback is not None:
        callback=number(ctypes.cast(pending_callback,ctypes.c_void_p).value).inttoptr(p)
        call('Py_AddPendingCall',i,[callback,null])
    if interrupt:call('PyErr_SetInterrupt',ir.VoidType(),[])
    next_pc=b.call(target,[frame,base,thread])
    with b.if_then(b.icmp_unsigned('==',next_pc,null)):
        offset=b.sub(b.ptrtoint(b.load(ip),n),b.ptrtoint(code_base,n))
        call('existing_test_leave_raw',i,[frame,ir.Constant(i,0),offset]);b.ret(null)
    returns=[ins.offset for ins in dis.get_instructions(function) if ins.opname=='RETURN_VALUE']
    is_return=ir.Constant(ir.IntType(1),0)
    for pc in returns:is_return=b.or_(is_return,b.icmp_unsigned('==',next_pc,b.gep(code_base,[number(pc)])))
    observed=call('existing_test_observers_active',i,[frame])
    handoff=b.or_(b.not_(is_return),b.icmp_signed('!=',observed,ir.Constant(i,0)))
    with b.if_then(handoff):
        b.store(next_pc,ip)
        b.ret(call('existing_test_resume_python',p,[frame]))
    value=b.load(base);b.store(base,sp)
    offset=b.sub(b.ptrtoint(next_pc,n),b.ptrtoint(code_base,n))
    b.ret(call('existing_test_word_return',p,[frame,value,offset]))
    machine=binding.Target.from_default_triple().create_target_machine()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine);engine.add_module(parsed);engine.finalize_object()
    entry=create_callable(function,engine.get_function_address('wrapper'),(lowered,engine,symbols,status,pending_callback),owned_runner_address=frames.addresses()['run_owned_vectorcall'])
    return entry,lowered,status


def test_existing_frame_codegen_does_not_create_or_pop_a_frame():
    entry,lowered,status=frame_entry(heap._find)
    root=heap._Cell();leaf=heap._Cell();leaf.parent=root
    assert entry(leaf) is root
    assert lowered.abi=='frame'
    text=str(lowered.native_module)
    assert all(name not in text for name in ('rc_ir_frame_enter','rc_ir_frame_leave_raw','rc_ir_frame_word_return'))
    assert frames.active_depth()==0


def test_existing_frame_generic_find_retires_fresh_argument_at_original_store():
    entry,lowered,status=frame_entry(heap._find)
    def events_for(call):
        events=[];refs=[]
        class Root:
            @property
            def parent(self):events.append('root-read');return None
        root=Root()
        class Leaf:
            def __init__(self):refs.append(weakref.ref(self,lambda _:events.append('drop')))
            @property
            def parent(self):events.append('leaf-read');return root
        result=call(Leaf())
        events.append('returned')
        assert result is root and refs[0]() is None
        return events
    assert events_for(entry)==events_for(heap._find)==['leaf-read','leaf-read','drop','root-read','returned']
    assert status.value==1 and frames.active_depth()==0


def test_existing_frame_observer_writes_are_read_live():
    entry,lowered,status=frame_entry(heap._find)
    replacement=object();events=[]
    class Node:
        @property
        def parent(self):
            frame=sys._getframe(1)
            events.append(frame.f_code is heap._find.__code__)
            frame.f_locals['cell']=replacement
            return None
    result=entry(Node())
    assert result is replacement and events==[True]
    assert frames.active_depth()==0


def test_existing_frame_error_keeps_original_source_site():
    entry,lowered,status=frame_entry(heap._find)
    class Node:
        @property
        def parent(self):raise LookupError('parent unavailable')
    with pytest.raises(LookupError,match='parent unavailable') as caught:entry(Node())
    tb=caught.value.__traceback__
    while tb and tb.tb_frame.f_code is not heap._find.__code__:tb=tb.tb_next
    assert tb is not None
    assert tb.tb_lasti==next(op.offset for block in lowered.graph.blocks.values() for op in block.operations if op.name=='load_attr')
    assert frames.active_depth()==0


def test_borrowed_traversal_cannot_be_combined_with_mutable_owned_frame():
    from recompyler.ir.builder import UnsupportedBytecode
    with pytest.raises(UnsupportedBytecode,match='borrowed|ownership|frame'):
        lower(build(heap._find),frame_entry=True,readonly_loops=True)


def release_owner(owner):
    owner=None
    return owner


def test_existing_frame_store_releases_owner_after_publishing_local():
    entry,lowered,status=frame_entry(release_owner);events=[]
    class Owner:
        def __del__(self):
            frame=sys._getframe(1)
            events.append((frame.f_code is release_owner.__code__,frame.f_locals['owner'] is None))
    result=entry(Owner())
    events.append('returned')
    assert result is None and events==[(True,True),'returned']
    assert status.value==1 and frames.active_depth()==0


def test_existing_frame_dictionary_path_preserves_both_lookup_effects():
    entry,lowered,status=frame_entry(heap._Program.canon);events=[]
    class Root:pass
    class Last:pass
    class Noise:
        def __hash__(self):return hash(Root)
        def __eq__(self,other):events.append('eq');return False
    class Program:pass
    owner=Program();owner.alias={Noise():Last,Root:Last}
    events.clear();expected=heap._Program.canon(owner,Root);expected_events=list(events)
    events.clear();actual=entry(owner,Root)
    assert actual is expected and events==expected_events
    assert frames.active_depth()==0


def test_existing_frame_code_guard_rejects_different_original_code():
    entry,lowered,status=frame_entry(heap._find,compile_as=release_owner)
    with pytest.raises(SystemError,match='invalid existing source frame'):
        entry(heap._Cell())
    assert frames.active_depth()==0


def test_retained_existing_source_frame_keeps_final_local_state():
    entry,lowered,status=frame_entry(heap._find);escaped=[]
    class Root:
        @property
        def parent(self):escaped.append(sys._getframe(1));return None
    owner=Root()
    assert entry(owner) is owner
    assert len(escaped)==1 and escaped[0].f_code is heap._find.__code__
    assert escaped[0].f_locals['cell'] is owner
    assert frames.active_depth()==0


def resumed_traversal(cell,marker):
    marker+=1
    while cell.parent is not None:
        cell=cell.parent
    return cell


def loop_header(function):
    return next(op.argval for op in dis.get_instructions(function) if op.opname.startswith('JUMP_BACKWARD'))


def test_existing_frame_can_enter_an_empty_stack_loop_block_without_replaying_prefix():
    events=[]
    class Marker:
        def __iadd__(self,value):events.append('prefix');return self
    class Root:
        @property
        def parent(self):
            current=sys._getframe(1)
            events.append(('root',current.f_code is resumed_traversal.__code__))
            return None
    root=Root();marker=Marker()
    marker+=1  # The real interpreter has already executed this prefix.
    entry,lowered,status=frame_entry(resumed_traversal,entry_offset=loop_header(resumed_traversal))
    assert entry(root,marker) is root
    assert events==['prefix',('root',True)]
    assert lowered.entry_offset==loop_header(resumed_traversal)
    assert frames.active_depth()==0


def test_existing_frame_loop_resume_preserves_original_error_pc_and_local_state():
    class Marker:
        def __iadd__(self,value):pytest.fail('entry replayed an already-executed prefix')
    class Node:
        @property
        def parent(self):raise LookupError('loop-resume')
    entry,lowered,status=frame_entry(resumed_traversal,entry_offset=loop_header(resumed_traversal))
    owner=Node();marker=Marker()
    with pytest.raises(LookupError,match='loop-resume') as caught:entry(owner,marker)
    trace=caught.value.__traceback__
    while trace and trace.tb_frame.f_code is not resumed_traversal.__code__:trace=trace.tb_next
    assert trace is not None
    assert trace.tb_lasti==next(op.offset for op in dis.get_instructions(resumed_traversal) if op.opname=='LOAD_ATTR')
    assert trace.tb_frame.f_locals['cell'] is owner
    assert trace.tb_frame.f_locals['marker'] is marker
    assert frames.active_depth()==0


def test_nonentry_offset_requires_existing_frame_abi():
    from recompyler.ir.builder import UnsupportedBytecode
    with pytest.raises(UnsupportedBytecode,match='existing.frame|frame.entry|frame ABI'):
        lower(build(resumed_traversal),entry_offset=loop_header(resumed_traversal))


@pytest.mark.parametrize('offset',[-1,1,100000])
def test_existing_frame_resume_rejects_offsets_outside_cfg_blocks(offset):
    from recompyler.ir.builder import UnsupportedBytecode
    with pytest.raises(UnsupportedBytecode,match='block|offset'):
        lower(build(resumed_traversal),frame_entry=True,entry_offset=offset)


def stack_value_join(left,right):
    return left or right


def test_existing_frame_resume_rejects_nonempty_cfg_stack():
    from recompyler.ir.builder import UnsupportedBytecode
    graph=build(stack_value_join)
    offset=next(offset for offset,block in graph.blocks.items() if block.parameters)
    with pytest.raises(UnsupportedBytecode,match='empty.stack|stack.depth'):
        lower(graph,frame_entry=True,entry_offset=offset)


def test_native_resume_services_pending_work_with_original_frame_active():
    observations=[]
    @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
    def callback(unused):
        current=sys._getframe(1)
        observations.append((frames.active_depth(),current.f_code is heap._find.__code__))
        return 0
    entry,lowered,status=frame_entry(heap._find,pending_callback=callback)
    class Node:pass
    root=Node();root.parent=None
    assert entry(root) is root
    assert observations==[(1,True)]
    assert frames.active_depth()==0


def test_native_backedge_pending_work_observes_pc_and_updates_live_local():
    observations=[]
    class Node:pass
    leaf=Node();root=Node();replacement=Node()
    leaf.parent=root;root.parent=replacement.parent=None
    @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
    def callback(unused):
        current=sys._getframe(1)
        observations.append((current.f_code is resumed_traversal.__code__,current.f_lasti,current.f_locals.get('cell') is root))
        if current.f_code is resumed_traversal.__code__:current.f_locals['cell']=replacement
        return 0
    header=loop_header(resumed_traversal)
    entry,lowered,status=frame_entry(resumed_traversal,entry_offset=header,pending_callback=callback)
    assert entry(leaf,0) is replacement
    backward=next(op.offset for op in dis.get_instructions(resumed_traversal) if op.opname=='JUMP_BACKWARD')
    assert observations==[(True,backward,True)]
    assert frames.active_depth()==0


def test_native_periodic_work_uses_relaxed_event_load_and_guarded_runtime_call():
    lowered=lower(build(resumed_traversal),frame_entry=True)
    text=str(lowered.native_module)
    assert '_Py_HandlePending' in text and 'load atomic i64' in text and 'monotonic' in text
    assert lowered.native_module is not None


def test_native_pending_interrupt_uses_original_resume_error_path():
    entry,lowered,status=frame_entry(heap._find,interrupt=True)
    class Node:pass
    root=Node();root.parent=None
    with pytest.raises(KeyboardInterrupt) as caught:entry(root)
    trace=caught.value.__traceback__
    while trace and trace.tb_frame.f_code is not heap._find.__code__:trace=trace.tb_next
    assert trace is not None
    assert trace.tb_lasti==next(op.offset for op in dis.get_instructions(heap._find) if op.opname=='RESUME')
    assert trace.tb_frame.f_locals['cell'] is root
    assert frames.active_depth()==0


def test_vectorcall_and_existing_frame_share_guarded_periodic_lowering():
    lowered=lower(build(heap._find))
    text=str(lowered.native_module)
    assert '_Py_HandlePending' in text and 'PyThreadState_Get' in text
    assert 'load atomic i64' in text
