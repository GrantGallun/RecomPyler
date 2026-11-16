"""Bounded compilation preserves complete source PCs and stack-edge contracts."""
import dis
import importlib
import pytest
from recompyler.ir import build
from recompyler.ir.verifier import verify


def partition(function,budget):
    try:module=importlib.import_module('recompyler.ir.regions')
    except ModuleNotFoundError:pytest.fail('bounded region planner is missing')
    return module.partition(function,max_bytecodes=budget)


def wide_call(function,value):
    return function(value,value+1,value+2,value+3,value+4,value+5)


def test_partition_bounds_straight_line_code_and_preserves_nonempty_stack_edges():
    plan=partition(wide_call,4)
    assert plan.graph.code is wide_call.__code__
    assert plan.graph.function is wide_call
    assert len(plan.regions)>2
    assert sorted(pc for region in plan.regions for pc in region.bytecodes)==[i.offset for i in dis.get_instructions(wide_call)]
    assert all(0<len(region.bytecodes)<=4 for region in plan.regions)
    assert set(plan.graph.blocks)=={offset for region in plan.regions for offset in region.offsets}
    assert any(region.entry_stack for region in plan.regions)
    verify(plan.graph)
    for transfer in plan.transfers:
        block=plan.graph.blocks[transfer.source]
        edge=next(edge for edge in block.edges if edge.target==transfer.target and edge.kind==transfer.kind)
        assert transfer.arguments==edge.arguments
        assert transfer.parameters==plan.graph.blocks[edge.target].parameters
        assert len(transfer.arguments)==len(transfer.parameters)


def test_partition_preserves_loop_source_operations_and_backedges_without_execution():
    events=[]
    def source(function,value,count):
        events.append('entered')
        while count:
            value=function(value)
            count-=1
        return value
    original=build(source);plan=partition(source,3)
    operations=lambda graph:sorted((op.offset,op.name) for block in graph.blocks.values() for op in block.operations)
    assert operations(original)==operations(plan.graph)
    assert any(transfer.target<=transfer.source for transfer in plan.transfers)
    assert events==[]
    assert all(len(region.bytecodes)<=3 for region in plan.regions)
    verify(plan.graph)


@pytest.mark.parametrize('budget',[True,0,-1,None,1.25])
def test_partition_rejects_invalid_size_budgets(budget):
    with pytest.raises((TypeError,ValueError)):partition(wide_call,budget)


def test_partition_refuses_suspension_and_exception_scopes_until_region_entry_is_proved():
    from recompyler.ir.builder import UnsupportedBytecode
    def suspended(value):yield value
    def protected(value):
        try:return value.answer
        except AttributeError:return None
    for function in (suspended,protected):
        with pytest.raises(UnsupportedBytecode):partition(function,4)


@pytest.mark.parametrize('backend',['ssa','regions'])
@pytest.mark.parametrize('size',[2,5])
def test_partitioned_graph_preserves_live_temporaries_and_source_errors(size,backend,monkeypatch):
    import gc,sys,weakref
    from test_ir_existing_frame import frame_entry
    def source(make,callback):
        return callback(make('left'),make('right'))
    def observe(call):
        events=[];refs=[]
        class Probe:
            def __init__(self,name):self.name=name
            def __del__(self):events.append(('drop',self.name))
        def make(name):
            value=Probe(name);refs.append(weakref.ref(value));return value
        def callback(left,right):
            frame=sys._getframe(1)
            events.append(('call',left.name,right.name,frame.f_lasti,tuple(sorted(frame.f_locals))))
            raise LookupError('region boundary')
        try:call(make,callback)
        except LookupError as error:
            saved=error.__traceback__
            assert all(ref() is not None for ref in refs)
        else:raise AssertionError('source error swallowed')
        del saved
        gc.collect()
        assert not any(ref() is not None for ref in refs)
        return events
    expected=observe(source);plan=partition(source,size)
    if backend=='ssa':native,owner,status=frame_entry(source,graph=plan.graph)
    else:native,owner,status=native_regions(monkeypatch,source,size)
    assert observe(native)==expected and status.value==1



def native_regions(monkeypatch,function,budget):
    from recompyler.ir import regions
    compiler=getattr(regions,'lower_partition',None)
    if compiler is None:pytest.fail('bounded native dispatcher is missing')
    owner=compiler(function,max_bytecodes=budget)
    import test_ir_existing_frame as existing
    with monkeypatch.context() as patch:
        patch.setattr(existing,'lower',lambda graph,**options:owner)
        entry,body,status=existing.frame_entry(function)
    return entry,owner,status


@pytest.mark.parametrize('budget',[3,7])
def test_bounded_native_dispatcher_preserves_loop_results_and_callbacks(monkeypatch,budget):
    def source(callback,value,count):
        while count:
            value=callback(value,count)
            count-=1
        return value
    expected=[];actual=[]
    reference=source(lambda value,n:(expected.append(n) or value+n),10,4)
    native,owner,status=native_regions(monkeypatch,source,budget)
    assert native(lambda value,n:(actual.append(n) or value+n),10,4)==reference
    assert actual==expected==[4,3,2,1]
    assert status.value==1 and owner.abi=='frame'


def test_region_observer_exit_returns_to_interpreter_once_at_current_state(monkeypatch):
    import sys
    def source(callback,count):
        while count:
            callback(count)
            count-=1
        return count
    def observe(call):
        events=[]
        def callback(count):
            frame=sys._getframe(1)
            events.append((count,frame.f_lasti,tuple(sorted(frame.f_locals))))
            frame.f_locals['count']=1
        return call(callback,3),events
    expected=observe(source)
    native,owner,status=native_regions(monkeypatch,source,3)
    assert observe(native)==expected
    assert status.value==1



def test_multiple_region_bodies_really_execute(monkeypatch):
    import ctypes
    from llvmlite import binding,ir
    from recompyler.ir import lower_llvm
    original=lower_llvm._finish;counters=[]
    def counted(*args,**options):
        owner=original(*args,**options)
        if options.get('abi')!='region-frame':return owner
        counter=ctypes.c_uint64();counters.append(counter)
        pointer=ir.IntType(8).as_pointer();word=ir.IntType(64)
        signature=ir.FunctionType(pointer,[pointer,word.as_pointer(),pointer,word.as_pointer()])
        module=ir.Module();module.triple=binding.get_process_triple()
        wrapper=ir.Function(module,signature,'counted_region')
        b=ir.IRBuilder(wrapper.append_basic_block('entry'))
        slot=ir.Constant(word,ctypes.addressof(counter)).inttoptr(word.as_pointer())
        b.store(b.add(b.load(slot),ir.Constant(word,1)),slot)
        target=b.inttoptr(ir.Constant(word,owner.body_address),signature.as_pointer())
        b.ret(b.call(target,list(wrapper.args),tail='musttail'))
        target=binding.Target.from_default_triple().create_target_machine(opt=0)
        native=binding.parse_assembly(str(module));native.verify()
        engine=binding.create_mcjit_compiler(native,target);engine.finalize_object()
        owner.body_address=engine.get_function_address('counted_region')
        owner.providers+=(engine,counter);owner.execution_providers+=(engine,counter)
        return owner
    monkeypatch.setattr(lower_llvm,'_finish',counted)
    native,owner,status=native_regions(monkeypatch,wide_call,3)
    marker=object()
    assert native(lambda *args:args,10)==(10,11,12,13,14,15)
    assert status.value==1
    assert sum(counter.value>0 for counter in counters)>=2
    assert all(counter.value<=1 for counter in counters)



def test_regions_coalesce_small_blocks_within_one_entry_and_size_budget():
    def source(function,value,count):
        while count:
            if count&1:value=function(value)
            else:value+=1
            count-=1
        return value
    plan=partition(source,20)
    owner={offset:region.entry for region in plan.regions for offset in region.offsets}
    assert any(len(region.offsets)>1 for region in plan.regions)
    assert all(len(region.bytecodes)<=20 for region in plan.regions)
    assert all(transfer.target==owner[transfer.target] for transfer in plan.transfers)
    for offset,block in plan.graph.blocks.items():
        for edge in block.edges:
            if owner[offset]!=owner[edge.target]:assert edge.target==owner[edge.target]


def test_native_dispatch_is_bounded_and_normal_transfers_are_tail_calls(monkeypatch):
    native,owner,status=native_regions(monkeypatch,wide_call,3)
    parent=owner.module.get_global('body')
    assert sum(len(block.instructions) for block in parent.blocks)<=32, 'large dispatch recreates a giant LLVM loop'
    children=[resource for resource in owner.execution_providers if getattr(resource,'abi',None)=='region-frame']
    transfers=[instruction for child in children for function in child.module.functions
               if function.name=='body' for block in function.blocks for instruction in block.instructions
               if instruction.opname=='call' and instruction.tail=='musttail']
    assert len(children)>1 and len(transfers)>=2
    assert native(lambda *args:args,10)==(10,11,12,13,14,15)



def test_full_graph_verification_does_not_repeat_for_each_region(monkeypatch):
    from recompyler.ir import regions,verifier,lower_llvm
    calls=[];original=verifier.verify
    def verify(graph):calls.append(id(graph));return original(graph)
    monkeypatch.setattr(verifier,'verify',verify)
    monkeypatch.setattr(lower_llvm,'verify',verify)
    owner=regions.lower_partition(wide_call,max_bytecodes=2)
    children=[resource for resource in owner.execution_providers if getattr(resource,'abi',None)=='region-frame']
    assert len(children)>3
    assert len(calls)<=2, 'full-graph verification multiplied by the region count'



def test_region_entry_keeps_cpython_closure_prelude_and_live_cell_values(monkeypatch):
    captured=object()
    def source(value):return captured,value
    native,owner,status=native_regions(monkeypatch,source,2)
    marker=object()
    assert native(marker)==(captured,marker) and status.value==1
    replacement=object();captured=replacement
    assert native(marker)==(replacement,marker)



@pytest.mark.parametrize('failure',[False,True])
def test_region_for_iter_preserves_exhaustion_and_original_error_pc(monkeypatch,failure):
    def source(make,callback):
        total=0
        for value in make():total=callback(total,value)
        return total
    def observe(call):
        events=[]
        class Items:
            def __init__(self):self.position=0
            def __iter__(self):return self
            def __next__(self):
                self.position+=1
                if failure and self.position==2:raise LookupError('iterator boundary')
                if self.position>3:raise StopIteration
                return self.position
        def callback(total,value):events.append(value);return total+value
        try:result=call(Items,callback)
        except LookupError as error:
            assert failure and str(error)=='iterator boundary'
            traceback=error.__traceback__;pc=None
            while traceback:
                if traceback.tb_frame.f_code is source.__code__:pc=traceback.tb_lasti
                traceback=traceback.tb_next
            assert pc is not None
            return events,pc
        assert not failure
        return events,result
    expected=observe(source)
    native,owner,status=native_regions(monkeypatch,source,5)
    assert observe(native)==expected and status.value==1
