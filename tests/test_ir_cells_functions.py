"""M1 uses original function code and shared real CPython closure cells."""
import dis,gc,sys,types,weakref
import pytest
from recompyler import _source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry


def make_reader(value):
 def read():return value
 return read


def make_default(value):
 def read(argument=value):return argument
 return read


def make_pair(value):
 def read():return value
 def write(next_value):
  nonlocal value
  value=next_value
  return value
 return read,write


def make_empty():
 def read():return value
 return read
 value=None


def make_delete(value):
 def remove():
  nonlocal value
  del value
 def read():return value
 return remove,read


def test_cell_prelude_is_a_separate_cfg_before_original_resume():
 graph=build(make_reader)
 resume=next(op.offset for op in dis.get_instructions(make_reader) if op.opname=='RESUME')
 assert resume in graph.blocks and resume!=graph.entry
 assert graph.blocks[resume].parameters==()


def test_native_factory_returns_actual_original_code_function_and_real_cell():
 entry,lowered,status=frame_entry(make_reader);marker=object()
 child=entry(marker)
 code=next(value for value in make_reader.__code__.co_consts if type(value) is types.CodeType)
 assert type(child) is types.FunctionType and child.__code__ is code
 assert child.__globals__ is make_reader.__globals__
 assert child.__qualname__==code.co_qualname and child.__name__==code.co_name
 assert child.__module__==make_reader.__module__
 assert type(child.__closure__[0]) is types.CellType
 assert child.__closure__[0].cell_contents is marker and child() is marker
 assert lowered.entry_offset==next(op.offset for op in dis.get_instructions(make_reader) if op.opname=='RESUME')
 assert frames.active_depth()==0


def test_tuple_default_installation_uses_original_object_and_python_binding():
 entry,lowered,status=frame_entry(make_default);marker=object()
 child=entry(marker)
 assert child.__defaults__==(marker,) and child.__defaults__[0] is marker
 assert child() is marker
 replacement=object();assert child(argument=replacement) is replacement
 with pytest.raises(TypeError):child(1,2)
 assert child.__closure__ is None


def test_native_siblings_share_the_same_cell_and_native_reads_observe_external_writes():
 entry,lowered,status=frame_entry(make_pair);marker=object()
 read,write=entry(marker)
 assert read.__closure__[0] is write.__closure__[0]
 native_read,_,_=frame_entry(read);native_write,_,_=frame_entry(write)
 replacement=object()
 assert native_write(replacement) is replacement
 assert native_read() is replacement and read() is replacement
 read.__closure__[0].cell_contents=marker
 assert native_read() is marker
 assert frames.active_depth()==0


def test_empty_original_free_cell_matches_name_error_and_source_pc():
 entry,lowered,status=frame_entry(make_empty)
 child=entry();native,lowered,_=frame_entry(child)
 with pytest.raises(NameError) as expected:child()
 with pytest.raises(NameError) as actual:native()
 assert str(actual.value)==str(expected.value) and actual.value.name==expected.value.name
 trace=actual.value.__traceback__
 while trace and trace.tb_frame.f_code is not child.__code__:trace=trace.tb_next
 assert trace is not None and trace.tb_lasti==next(op.offset for op in dis.get_instructions(child) if op.opname=='LOAD_DEREF')
 assert frames.active_depth()==0


def test_cell_store_publishes_new_value_before_old_destructor_and_does_not_keep_extra_owner():
 events=[]
 class Previous:
  def __del__(self):
   current=sys._getframe(1)
   events.append((current.f_code is write.__code__,current.f_locals.get('value') is replacement))
 read,write=make_pair(Previous())
 native,lowered,status=frame_entry(write);replacement=object()
 assert native(replacement) is replacement and read() is replacement
 assert events==[(True,True)]
 assert frames.active_depth()==0


def test_delete_deref_retires_actual_cell_then_reports_original_empty_error():
 removed=[]
 class Owner:
  def __del__(self):removed.append('drop')
 remove,read=make_delete(Owner());native,lowered,status=frame_entry(remove)
 assert native() is None and removed==['drop']
 with pytest.raises(NameError):read()
 with pytest.raises(NameError) as expected:remove()
 with pytest.raises(NameError) as actual:native()
 assert str(actual.value)==str(expected.value) and actual.value.name==expected.value.name
 assert frames.active_depth()==0


def test_returned_original_closure_owns_value_until_its_last_reference():
 class Owner:pass
 marker=Owner();reference=weakref.ref(marker)
 entry,lowered,status=frame_entry(make_reader)
 child=entry(marker);del marker;gc.collect()
 assert reference() is child()
 del child;gc.collect();assert reference() is None


def test_execution_owner_keeps_no_original_function_code_or_closure_cell():
 marker=object();child=make_reader(marker);reference=weakref.ref(child)
 lowered=lower(build(child),frame_entry=True);owner=lowered.execution_owner
 del lowered,child;gc.collect()
 assert reference() is None and owner.engine.get_function_address('body')==owner.body_address


def make_item_setter(value):
 def write(items):
  nonlocal value
  value=items[0]
 return write


def test_cell_store_transfers_stack_ownership_before_reentrant_cell_clear():
 events=[]
 class Next:
  def __del__(self):events.append('next-drop')
 class Previous:
  def __del__(self):
   items.clear()
   cell.cell_contents=None
   events.append(('old-observe',reference() is None))
 write=make_item_setter(Previous());cell=write.__closure__[0]
 value=Next();reference=weakref.ref(value);items=[value];del value
 entry,lowered,status=frame_entry(write)
 assert entry(items) is None
 assert events==['next-drop',('old-observe',True)]
 assert cell.cell_contents is None and frames.active_depth()==0


def test_explicit_cell_entry_cannot_repeat_cpython_owned_make_cell():
 from recompyler.ir.builder import UnsupportedBytecode
 with pytest.raises(UnsupportedBytecode,match='prelude|RESUME'):
  lower(build(make_reader),frame_entry=True,entry_offset=0)


def test_cell_factory_function_attributes_must_be_fresh_not_mutate_arbitrary_function():
 from dataclasses import replace
 from recompyler.ir.builder import UnsupportedBytecode
 graph=build(make_default)
 for block in graph.blocks.values():
  for index,op in enumerate(block.operations):
   if op.name=='set_function_attribute':
    block.operations[index]=replace(op,attributes={**op.attributes,'oparg':64})
 with pytest.raises(UnsupportedBytecode,match='fresh original-code function'):
  lower(graph,frame_entry=True)


def make_replacing(value,replacement):
 def read():return value
 value=replacement
 return read


def test_captured_argument_claim_releases_temporary_before_factory_returns():
 entry,lowered,status=frame_entry(make_replacing);replacement=object()
 def observe(call):
  events=[]
  class Previous:
   def __del__(self):
    frame=sys._getframe(1)
    events.append(('drop',frame.f_code is make_replacing.__code__,frame.f_locals.get('value') is replacement))
  child=call(Previous(),replacement);events.append('returned')
  assert child() is replacement
  return events
 assert observe(entry)==observe(make_replacing)==[('drop',True,True),'returned']
 assert status.value==1 and frames.active_depth()==0
