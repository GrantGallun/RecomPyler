"""Cross-process T2 codegen retains parent pointers and exact source state."""
import os
import pytest


def prepare(monkeypatch,function,workers):
    from recompyler.ir import regions
    import test_ir_existing_frame as existing
    owner=regions.lower_partition(function,max_bytecodes=5,workers=workers)
    with monkeypatch.context() as patch:
        patch.setattr(existing,'lower',lambda *args,**kwargs:owner)
        entry,_,status=existing.frame_entry(function)
    return entry,owner,status


@pytest.mark.parametrize('workers',[1,2])
def test_spawned_objects_execute_with_parent_constants_and_callbacks(monkeypatch,workers):
    from recompyler.ir import region_workers
    from recompyler.ir.compiler import compilation_info
    marker=object()
    def source(callback,value,count):
        while count:
            value=callback(value,count,marker)
            count-=1
        return value
    actual=[]
    entry,owner,status=prepare(monkeypatch,source,workers)
    assert entry(lambda value,n,m:(actual.append((n,m)) or value+n),10,4)==20
    assert actual==[(n,marker) for n in (4,3,2,1)] and status.value==1
    children=[p for p in owner.execution_providers if getattr(p,'abi',None)=='region-frame']
    objects=[p for child in children for p in child.providers if isinstance(p,region_workers.NativeObject)]
    assert len(objects)==len(children)>1
    assert all(obj.pid!=os.getpid() for obj in objects)
    assert 1<=len({obj.pid for obj in objects})<=workers
    assert all(child.native_module is None for child in children)
    assert compilation_info(source) is None


def test_spawned_region_error_keeps_traceback_temporaries_alive(monkeypatch):
    import gc,weakref
    def source(make,callback):
        value=make()
        return callback(value)
    def observe(call):
        events=[];refs=[]
        class Item:
            def __init__(self):refs.append(weakref.ref(self))
            def __del__(self):events.append('drop')
        def callback(value):raise LookupError('region worker')
        try:call(Item,callback)
        except LookupError as error:
            assert str(error)=='region worker' and refs[0]() is not None
            saved=error.__traceback__
        else:pytest.fail('source error swallowed')
        assert refs[0]() is not None
        del saved;gc.collect()
        assert refs[0]() is None
        return events
    expected=observe(source)
    entry,owner,status=prepare(monkeypatch,source,2)
    assert observe(entry)==expected==['drop'] and status.value==1


@pytest.mark.parametrize('workers',[True,-1,3,1.5,None])
def test_worker_count_rejects_nonbounded_correctness_load(workers):
    from recompyler.ir.regions import lower_partition
    with pytest.raises((ValueError,TypeError)):
        lower_partition(lambda value:value,workers=workers)


def test_worker_failure_never_links_or_installs_a_partial_program(monkeypatch):
    from dataclasses import replace
    from recompyler.ir import regions,region_workers,lower_llvm
    from recompyler.ir.compiler import compilation_info
    original=region_workers.compile_objects
    def corrupt(requests,*,workers):
        requests=list(requests);requests[0]=replace(requests[0],digest='wrong')
        return original(requests,workers=workers)
    monkeypatch.setattr(region_workers,'compile_objects',corrupt)
    monkeypatch.setattr(lower_llvm,'_link_emitted',lambda *args:pytest.fail('partial program linked'))
    def source(value):return value+1
    with pytest.raises(ValueError,match='digest'):
        regions.lower_partition(source,max_bytecodes=2,workers=1)
    assert compilation_info(source) is None


def test_parent_only_optimizes_tiny_dispatcher_after_worker_emission(monkeypatch):
    from recompyler.ir import lower_llvm,regions
    parse=lower_llvm.binding.parse_assembly;assemblies=[]
    def record(text,*args,**kwargs):
        if text:assemblies.append(text)
        return parse(text,*args,**kwargs)
    monkeypatch.setattr(lower_llvm.binding,'parse_assembly',record)
    def source(callback,value):return callback(value,value+1,value+2)
    owner=regions.lower_partition(source,max_bytecodes=3,workers=2)
    assert len(assemblies)==1 and 'bounded_frame_dispatch' in assemblies[0]
    assert len(assemblies[0].splitlines())<40 and owner.body_address


def test_worker_linked_bodies_really_execute_multiple_regions(monkeypatch):
    import ctypes
    from llvmlite import binding,ir
    from recompyler.ir import lower_llvm
    original=lower_llvm._link_emitted;counters=[]
    def counted(*args):
        owner=original(*args)
        counter=ctypes.c_uint64();counters.append(counter)
        pointer=ir.IntType(8).as_pointer();word=ir.IntType(64)
        signature=ir.FunctionType(pointer,[pointer,word.as_pointer(),pointer,word.as_pointer()])
        module=ir.Module();module.triple=binding.get_process_triple()
        wrapper=ir.Function(module,signature,'counted_worker_region')
        b=ir.IRBuilder(wrapper.append_basic_block('entry'))
        slot=ir.Constant(word,ctypes.addressof(counter)).inttoptr(word.as_pointer())
        b.store(b.add(b.load(slot),ir.Constant(word,1)),slot)
        target=b.inttoptr(ir.Constant(word,owner.body_address),signature.as_pointer())
        b.ret(b.call(target,list(wrapper.args),tail='musttail'))
        machine=binding.Target.from_default_triple().create_target_machine(opt=0)
        native=binding.parse_assembly(str(module));native.verify()
        engine=binding.create_mcjit_compiler(native,machine);engine.finalize_object()
        owner.body_address=engine.get_function_address('counted_worker_region')
        owner.providers+=(engine,counter);owner.execution_providers+=(engine,counter)
        return owner
    monkeypatch.setattr(lower_llvm,'_link_emitted',counted)
    def source(callback,value):return callback(value,value+1,value+2,value+3)
    entry,owner,status=prepare(monkeypatch,source,2)
    assert entry(lambda *args:args,10)==(10,11,12,13) and status.value==1
    assert sum(counter.value>0 for counter in counters)>=2


def test_object_link_rejects_mismatched_result_before_native_link(monkeypatch):
    from dataclasses import replace
    from recompyler.ir import regions,region_workers,lower_llvm
    original=region_workers.compile_objects
    def corrupt(requests,*,workers):
        results=original(requests,workers=workers)
        return (replace(results[0],digest='wrong'),)+results[1:]
    monkeypatch.setattr(region_workers,'compile_objects',corrupt)
    monkeypatch.setattr(lower_llvm.binding,'ObjectFileRef',None)
    with pytest.raises(ValueError,match='identity'):
        regions.lower_partition(lambda value:value+1,max_bytecodes=3,workers=1)
