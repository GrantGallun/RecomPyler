"""Globals and closure calls use the original CPython binding machinery."""
import builtins,dis,gc,sys,types,weakref
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler import _source_frames_native as frames
from test_ir_existing_frame import frame_entry

GLOBAL_MARKER=object()
def read_global():return GLOBAL_MARKER
def read_missing_global():return NEVER_DEFINED_IR_GLOBAL
def call_one(fn,value):return fn(value)
def call_keywords(fn,value):return fn(named=value)
def call_local(value):
 def read(argument=value):return argument
 return read()
def call_temporary(fn,source,observe):return fn(source+0,observe)
def make_keyword_default(value):
 def read(*,named=value):return named
 return read

def test_original_keyword_only_default_dictionary_and_binding():
 call,_,_=frame_entry(make_keyword_default);marker=object();child=call(marker)
 assert child.__kwdefaults__['named'] is marker and child() is marker
 replacement=object();assert child(named=replacement) is replacement
 with pytest.raises(TypeError):child(marker)


def test_global_lookup_reads_live_original_globals_after_mutation():
 global GLOBAL_MARKER
 call,_,_=frame_entry(read_global);before=GLOBAL_MARKER;replacement=object()
 try:
  assert call() is before
  GLOBAL_MARKER=replacement;assert call() is replacement
 finally:GLOBAL_MARKER=before


def test_global_lookup_uses_function_captured_builtins_and_original_missing_error():
 name='IR_TEMP_BUILTIN_VALUE';marker=object();namespace={'__builtins__':{name:marker}}
 exec('def read():return IR_TEMP_BUILTIN_VALUE',namespace);fn=namespace['read']
 call,_,_=frame_entry(fn);assert call() is marker
 namespace['__builtins__']={name:object()};assert call() is marker
 missing,_,_=frame_entry(read_missing_global)
 with pytest.raises(NameError) as expected:read_missing_global()
 with pytest.raises(NameError) as actual:missing()
 assert actual.value.name==expected.value.name and str(actual.value)==str(expected.value)
 trace=actual.value.__traceback__
 while trace and trace.tb_frame.f_code is not read_missing_global.__code__:trace=trace.tb_next
 assert trace and trace.tb_lasti==next(i.offset for i in dis.get_instructions(read_missing_global) if i.opname=='LOAD_GLOBAL')


def test_original_local_function_creation_and_zero_argument_call():
 call,_,_=frame_entry(call_local);marker=object();assert call(marker) is marker
 assert frames.active_depth()==0


def test_positional_closure_call_uses_real_defaults_cells_and_object_identity():
 call,_,_=frame_entry(call_one);marker=object();captured=object()
 def child(value,default=captured):return value,default
 result=call(child,marker);assert result[0] is marker and result[1] is captured
 with pytest.raises(TypeError) as expected:call_one(lambda:None,marker)
 with pytest.raises(TypeError) as actual:call(lambda:None,marker)
 assert str(actual.value)==str(expected.value)


def test_keyword_call_uses_cpython_kwonly_variadic_and_bound_method_binding():
 call,_,_=frame_entry(call_keywords);marker=object()
 def child(*args,named=None,**kwargs):return args,named,kwargs
 result=call(child,marker);assert result[0]==() and result[1] is marker and result[2]=={}
 class Receiver:
  def method(self,*,named):return self,named
 owner=Receiver();result=call(owner.method,marker)
 assert result[0] is owner and result[1] is marker


def test_native_call_transfers_temporary_argument_before_python_child_overwrite():
 call,_,_=frame_entry(call_temporary)
 def observe(target):
  events=[];refs=[]
  class Item:
   def __del__(self):events.append('drop')
  class Source:
   def __add__(self,unused):
    item=Item();refs.append(weakref.ref(item));return item
  def child(value,probe):value=None;return probe()
  def probe():events.append(('observed',refs[0]() is None));return None
  assert target(child,Source(),probe) is None
  events.append('returned');return events
 assert observe(call)==observe(call_temporary)==['drop',('observed',True),'returned']
 assert frames.active_depth()==0


def test_native_call_keeps_original_parent_in_python_child_frame_chain():
 call,_,_=frame_entry(call_one);marker=object();seen=[]
 def child(value):
  parent=sys._getframe(1);seen.append((parent.f_code,parent.f_locals['value'],parent.f_lasti));return value
 assert call(child,marker) is marker
 assert seen[0][0] is call_one.__code__ and seen[0][1] is marker
 assert seen[0][2]==next(i.offset for i in dis.get_instructions(call_one) if i.opname=='CALL')


def test_native_call_exception_retains_original_child_parent_traceback():
 call,_,_=frame_entry(call_one)
 def child(value):raise LookupError('child failure')
 with pytest.raises(LookupError) as actual:call(child,object())
 trace=actual.value.__traceback__;codes=[]
 while trace:
  if trace.tb_frame.f_code in (call_one.__code__,child.__code__):codes.append(trace.tb_frame.f_code)
  trace=trace.tb_next
 assert codes==[call_one.__code__,child.__code__] and frames.active_depth()==0


def test_generic_nonpython_vectorcall_and_noncallable_error_remain_original():
 call,_,_=frame_entry(call_one);items=[1,2]
 assert call(len,items)==2
 with pytest.raises(TypeError) as expected:call_one(None,items)
 with pytest.raises(TypeError) as actual:call(None,items)
 assert str(actual.value)==str(expected.value)


def pending_c_callable(callback):
 import ctypes
 from llvmlite import ir,binding
 from recompyler.ir.symbols import CPythonSymbols
 class MethodDef(ctypes.Structure):
  _fields_=[('name',ctypes.c_char_p),('method',ctypes.c_void_p),('flags',ctypes.c_int),('doc',ctypes.c_char_p)]
 symbols=CPythonSymbols();p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
 module=ir.Module();module.triple=binding.get_process_triple()
 body=ir.Function(module,ir.FunctionType(p,[p,p,p]),'enqueue');b=ir.IRBuilder(body.append_basic_block('entry'))
 address=ir.Constant(n,ctypes.cast(callback,ctypes.c_void_p).value).inttoptr(p);null=ir.Constant(p,None)
 add=symbols.declare(module,'Py_AddPendingCall',i,[p,p]);b.call(add,[address,null])
 new=symbols.declare(module,'Py_NewRef',p,[p]);b.ret(b.call(new,[ir.Constant(n,id(None)).inttoptr(p)]))
 machine=binding.Target.from_default_triple().create_target_machine();parsed=binding.parse_assembly(str(module));parsed.verify()
 engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine);engine.add_module(parsed);engine.finalize_object()
 definition=MethodDef(b'enqueue',engine.get_function_address('enqueue'),3,None)
 create=ctypes.pythonapi.PyCFunction_NewEx;create.argtypes=[ctypes.POINTER(MethodDef),ctypes.py_object,ctypes.py_object];create.restype=ctypes.py_object
 keepalive=(engine,definition,callback,symbols)
 function=create(ctypes.byref(definition),keepalive,None)
 return function,keepalive


@pytest.mark.parametrize('function',[(call_one),(call_keywords)])
@pytest.mark.parametrize('warm',[False,True])
def test_call_pending_boundary_matches_original_opcode(function,warm):
 import ctypes
 # CPython itself changes CALL_KW's pending boundary after specialization.
 # Compare independently fresh code objects at the same warm state.
 def observe(native):
  fn=types.FunctionType(function.__code__.replace(),function.__globals__)
  target=frame_entry(fn)[0] if native else fn;seen=[]
  @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
  def callback(unused):
   parent=sys._getframe(1);seen.append(parent.f_code is fn.__code__);return 0
  child,keepalive=pending_c_callable(callback)
  if warm:
   for unused in range(12):target(child,None);ctypes.pythonapi.Py_MakePendingCalls()
   seen.clear()
  assert target(child,None) is None
  ctypes.pythonapi.Py_MakePendingCalls()
  return seen
 assert observe(True)==observe(False)


def test_python_call_return_does_not_add_a_pending_check_skipped_by_inlined_dispatch():
 import ctypes
 call,_,_=frame_entry(call_one)
 def observe(target):
  seen=[]
  @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
  def callback(unused):
   parent=sys._getframe(1);seen.append(parent.f_code in (call_one.__code__,child.__code__));return 0
  enqueue,keepalive=pending_c_callable(callback)
  def child(value):return enqueue(named=value)
  child.__code__=child.__code__.replace()
  assert target(child,None) is None
  ctypes.pythonapi.Py_MakePendingCalls()
  return seen
 assert observe(call)==observe(call_one)==[False]


def keyword_after_effect(effect,fn,value):
 effect+0
 return fn(named=value)


def test_keyword_tier1_continuation_keeps_prior_effects_and_error_source_once():
 call,lowered,_=frame_entry(keyword_after_effect)
 events=[]
 class Effect:
  def __add__(self,unused):events.append('effect');return None
 with pytest.raises(TypeError) as actual:call(Effect(),None,object())
 assert events==['effect'] and frames.active_depth()==0
 trace=actual.value.__traceback__
 while trace and trace.tb_frame.f_code is not keyword_after_effect.__code__:trace=trace.tb_next
 assert trace and trace.tb_lasti==next(i.offset for i in dis.get_instructions(keyword_after_effect) if i.opname=='CALL_KW')


def test_python_child_variadic_default_binding_and_generator_creation_are_original():
 call,_,_=frame_entry(call_one);marker=object()
 def child(*args,default=marker,**kwargs):return args,default,kwargs
 result=call(child,marker)
 assert result[0][0] is marker and result[1] is marker and result[2]=={}
 def generator(value):yield value
 result=call(generator,marker)
 assert type(result) is types.GeneratorType and result.gi_code is generator.__code__
 assert next(result) is marker
 with pytest.raises(StopIteration):next(result)


def make_annotated(value):
 def read(argument:value)->value:return argument
 return read


def test_original_lazy_annotation_helper_uses_same_shared_cell():
 call,_,_=frame_entry(make_annotated);marker=object();child=call(marker)
 assert child.__annotations__=={'argument':marker,'return':marker}
 expected=make_annotated(marker);argument=object()
 assert child(argument) is argument
 assert child.__annotate__.__code__ is expected.__annotate__.__code__
