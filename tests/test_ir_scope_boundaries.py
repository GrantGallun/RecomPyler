"""Canonical local scopes, intrinsics, special methods and raise continuations."""
import ctypes,dis,types,gc,os,subprocess,sys,weakref
from pathlib import Path
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)

def delete_local(value,answer):
 del value
 return answer

def delete_missing(answer):
 del missing
 return answer
 missing=None

def take_local(value):return value

def raw_take_function(*,unbound=False):
 operations=[('RESUME',0),('LOAD_FAST_AND_CLEAR',0),('STORE_FAST',0),('LOAD_FAST_CHECK' if unbound else 'LOAD_FAST',0),('RETURN_VALUE',0)]
 code=take_local.__code__.replace(co_code=bytes(part for name,arg in operations for part in (dis.opmap[name],arg)),co_stacksize=1,co_argcount=0 if unbound else 1,co_exceptiontable=b'')
 return types.FunctionType(code,globals())

def raise_value(value):raise value

def raise_cause(value,cause):raise value from cause

def raise_current():raise

def negate(value):return -value

def invert(value):return ~value

def positive(value):return +value

def with_scope(manager):
 with manager:return manager

@pytest.mark.parametrize('function',[delete_local,delete_missing,raw_take_function(),raw_take_function(unbound=True),raise_value,raise_cause,raise_current,negate,invert,positive,with_scope])
def test_next_scope_generic_lowerings_prepare(function):
 assert lower(build(function),frame_entry=True).body_address>0


@pytest.mark.parametrize('value',[None,True,False,0,1.25,1j,object()])
def test_take_restores_the_same_original_local(value):
 function=raw_take_function();call,_,_=frame_entry(function)
 assert call(value) is value


def test_take_null_local_survives_store_until_original_checked_load():
 call,_,_=frame_entry(raw_take_function(unbound=True))
 with pytest.raises(UnboundLocalError,match="cannot access local variable 'value'"):call()


def test_delete_local_retires_value_once_and_keeps_answer():
 call,_,_=frame_entry(delete_local);events=[];answer=object()
 class Item:
  def __del__(self):events.append('drop')
 result=call(Item(),answer)
 assert result is answer and events==['drop']


def test_delete_missing_matches_original_error():
 call,_,_=frame_entry(delete_missing)
 for function in (delete_missing,call):
  with pytest.raises(UnboundLocalError,match="cannot access local variable 'missing'"):function(None)


@pytest.mark.parametrize('function',[negate,invert,positive])
def test_unary_uses_original_protocol_and_same_result(function):
 marker=object();events=[]
 class Number:
  def __neg__(self):events.append('neg');return marker
  def __invert__(self):events.append('invert');return marker
  def __pos__(self):events.append('pos');return marker
 call,_,_=frame_entry(function)
 assert call(Number()) is marker
 assert len(events)==1


def generic_factory():
 def identity[T](value:T)->T:return value
 return identity


def alias_factory():
 type Alias=int
 return Alias


def test_intrinsic_binary_preserves_real_typeparams_and_original_function_code():
 call,_,_=frame_entry(generic_factory)
 result=call();parameter,=result.__type_params__
 assert parameter.__name__=='T'
 assert result.__annotations__=={'value':parameter,'return':parameter}
 assert result.__code__ is next(value for value in next(value for value in generic_factory.__code__.co_consts if isinstance(value,types.CodeType)).co_consts if isinstance(value,types.CodeType) and value.co_name=='identity')
 marker=object();assert result(marker) is marker


def test_typealias_intrinsic_uses_original_lazy_value():
 call,_,_=frame_entry(alias_factory)
 result=call();assert result.__name__=='Alias' and result.__value__ is int


def class_factory():
 class Result:pass
 return Result


def test_class_load_returns_original_builtin_without_replacement_class_builder():
 call,_,_=frame_entry(class_factory);result=call()
 assert type(result) is type and result.__name__=='Result'
 assert result.__module__==__name__


def test_class_load_preserves_original_missing_builtin_error():
 function=types.FunctionType(class_factory.__code__,{'__builtins__':{},'__name__':__name__})
 call,_,_=frame_entry(function)
 with pytest.raises(NameError,match='__build_class__ not found'):call()


from test_ir_protected_paths import real_frame_entry,_RESOURCES,_unchanged

def native_raise(value,cause):
 _unchanged(None)
 raise value from cause


def native_reraise():
 _unchanged(None)
 raise


def native_with(manager):
 _unchanged(None)
 with manager as value:return value


def case_same_frame_raise_preserves_exception_cause_and_original_pc():
 call,_,counter=real_frame_entry(native_raise)
 error=ValueError('same error');cause=LookupError('cause')
 try:call(error,cause)
 except ValueError as actual:
  assert actual is error and actual.__cause__ is cause and actual.__suppress_context__
  trace=actual.__traceback__;parents=[]
  while trace:
   if trace.tb_frame.f_code is native_raise.__code__:parents.append(trace.tb_lasti)
   trace=trace.tb_next
  assert parents==[next(op.offset for op in dis.get_instructions(native_raise) if op.opname=='RAISE_VARARGS')]
 else:raise AssertionError('missing raise')
 assert counter.value==1


def test_reraise_active_exception_remains_on_guarded_python_path():
 call,_,status=frame_entry(native_reraise);error=ValueError('active')
 try:raise error
 except ValueError:
  try:call()
  except ValueError as actual:assert actual is error
  else:raise AssertionError('missing reraise')
 assert status.value==-99


def case_no_active_exception_reraise_uses_native_prefix_and_original_pc():
 call,_,counter=real_frame_entry(native_reraise)
 try:call()
 except RuntimeError as error:
  assert str(error)=='No active exception to reraise'
  trace=error.__traceback__;parents=[]
  while trace:
   if trace.tb_frame.f_code is native_reraise.__code__:parents.append(trace.tb_lasti)
   trace=trace.tb_next
  assert parents==[next(op.offset for op in dis.get_instructions(native_reraise) if op.opname=='RAISE_VARARGS')]
 else:raise AssertionError('missing reraise error')
 assert counter.value==1


def case_special_methods_preserve_original_context_manager_protocol():
 call,_,counter=real_frame_entry(native_with);marker=object();events=[]
 class Manager:
  def __enter__(self):
   events.append(('enter',sys._getframe(1).f_code is native_with.__code__));return marker
  def __exit__(self,*args):
   events.append(('exit',sys._getframe(1).f_code is native_with.__code__,args));return False
 manager=Manager();manager.__enter__=lambda:None
 assert call(manager) is marker
 assert events==[('enter',True),('exit',True,(None,None,None))]
 assert counter.value==1


def case_special_method_missing_errors_match_original_interpreter():
 original=types.FunctionType(native_with.__code__.replace(),native_with.__globals__)
 call,_,counter=real_frame_entry(native_with)
 class Missing:pass
 class MissingEnter:
  def __exit__(self,*args):return False
 for manager in (None,Missing(),MissingEnter()):
  messages=[]
  for function in (original,call):
   try:function(manager)
   except TypeError as error:messages.append(str(error))
   else:raise AssertionError('missing protocol error')
  assert messages[0]==messages[1]
 assert counter.value==3


def case_special_lookup_descriptor_result_and_single_retirement():
 call,_,counter=real_frame_entry(native_with);events=[];marker=object()
 class Callable:
  def __init__(self,name):self.name=name
  def __call__(self,*args):events.append((self.name,args));return marker if self.name=='enter' else False
  def __del__(self):events.append(('drop',self.name))
 class Descriptor:
  def __init__(self,name):self.name=name
  def __get__(self,instance,owner):events.append(('get',self.name));return Callable(self.name)
 class Manager:
  __enter__=Descriptor('enter');__exit__=Descriptor('exit')
 assert call(Manager()) is marker
 assert events==[('get','exit'),('get','enter'),('enter',()),('drop','enter'),('exit',(None,None,None)),('drop','exit')],events
 assert counter.value==1


CASES=[name for name in tuple(globals()) if name.startswith('case_')]
@pytest.mark.slow
@pytest.mark.parametrize('case',CASES)
def test_actual_scope_native_entry(case):
 root=Path(__file__).resolve().parents[1];env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
 result=subprocess.run([sys.executable,str(Path(__file__)),case],cwd=root,env=env,capture_output=True,text=True,timeout=90,creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
 assert result.returncode==0,(case,result.stdout,result.stderr)
 assert 'PASS '+case in result.stdout


if __name__=='__main__':
 try:
  globals()[sys.argv[1]]()
  assert _RESOURCES and all(owner.calls.value>0 for owner,handle in _RESOURCES)
 finally:
  for owner,handle in _RESOURCES:handle.close()
 print('PASS '+sys.argv[1])
