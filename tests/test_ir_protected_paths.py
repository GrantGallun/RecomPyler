"""Protected native normal paths hand errors to CPython's original handlers."""
import ctypes,dis,gc,os,subprocess,sys,weakref
from pathlib import Path
import pytest
from recompyler import _source_frames_native as frames
from recompyler.ir import build,compile_function,compilation_info,UnsupportedBytecode
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive

_RESOURCES=[]
def real_frame_entry(function):
 lowered=lower(build(function),frame_entry=True);owner=Keepalive(lowered)
 handle=install_frame_entry(function,owner.address,owner,seed_arguments=(None,)*function.__code__.co_argcount,entry_offset=lowered.entry_offset)
 _RESOURCES.append((owner,handle))
 return function,lowered,owner.calls



def _unchanged(value):return value

def protected_get(mapping,key):
 try:
  value=mapping[key]
  return _unchanged(value)
 except KeyError:return None


def protected_caught(action):
 try:return action()
 except ValueError as error:return error


def protected_finally(action,cleanup):
 try:return action()
 finally:cleanup()


def protected_return(items,cleanup):
 try:return items[0]
 finally:cleanup()


def case_protected_native_normal_return_and_original_keyerror_handler():
 call,lowered,_=real_frame_entry(protected_get);marker=object()
 assert call({'key':marker},'key') is marker
 assert call({},'missing') is None and frames.active_depth()==0
 assert lowered.graph.exceptions


def case_protected_error_does_not_replay_getitem_effect_and_keeps_original_frame():
 call,_,_=real_frame_entry(protected_get);events=[]
 class Mapping:
  def __getitem__(self,key):
   events.append(sys._getframe(1).f_code is protected_get.__code__);raise KeyError(key)
 assert call(Mapping(),'key') is None and events==[True]


def case_original_handler_receives_same_exception_and_original_parent_traceback_once():
 call,_,_=real_frame_entry(protected_caught);original=ValueError('same error')
 def action():raise original
 result=call(action)
 assert result is original
 trace=result.__traceback__;parents=[]
 while trace:
  if trace.tb_frame.f_code is protected_caught.__code__:parents.append(trace.tb_lasti)
  trace=trace.tb_next
 assert parents==[next(i.offset for i in dis.get_instructions(protected_caught) if i.opname=='CALL')]
 assert frames.active_depth()==0


def case_finally_runs_once_for_native_success_and_original_error_continuation():
 call,_,_=real_frame_entry(protected_finally);marker=object();events=[]
 def success():events.append('body');return marker
 def cleanup():events.append('finally')
 assert call(success,cleanup) is marker and events==['body','finally']
 events.clear();error=LookupError('body error')
 def failure():events.append('body');raise error
 with pytest.raises(LookupError) as actual:call(failure,cleanup)
 assert actual.value is error and events==['body','finally'] and frames.active_depth()==0


def case_finally_cleanup_observes_original_handled_exception_and_context():
 call,_,_=real_frame_entry(protected_finally);primary=ValueError('primary');secondary=LookupError('secondary');seen=[]
 def failure():raise primary
 def cleanup():seen.append(sys.exception() is primary);raise secondary
 with pytest.raises(LookupError) as actual:call(failure,cleanup)
 assert actual.value is secondary and secondary.__context__ is primary and seen==[True]
 assert frames.active_depth()==0


def case_normal_return_operand_survives_finally_container_clear_until_caller_releases_it():
 call,_,_=real_frame_entry(protected_return);events=[]
 class Item:
  def __del__(self):events.append('drop')
 value=Item();reference=weakref.ref(value);items=[value];del value
 def cleanup():items.clear();assert reference() is not None
 result=call(items,cleanup)
 assert result is reference() and events==[]
 del result;gc.collect();assert reference() is None and events==['drop']


def case_uncaught_protected_error_keeps_original_source_pc_and_no_double_parent():
 call,_,_=real_frame_entry(protected_get)
 with pytest.raises(TypeError) as actual:call(None,'key')
 trace=actual.value.__traceback__;parents=[]
 while trace:
  if trace.tb_frame.f_code is protected_get.__code__:parents.append(trace.tb_lasti)
  trace=trace.tb_next
 assert parents==[next(i.offset for i in dis.get_instructions(protected_get) if i.opname=='BINARY_OP')]
 assert frames.active_depth()==0


def test_protected_native_preparation_keeps_complete_original_graph_and_runs_no_body():
 code=protected_get.__code__;graph=build(protected_get)
 lowered=lower(graph,frame_entry=True)
 assert lowered.body_address>0 and lowered.graph is graph and graph.exceptions
 assert compile_function(protected_get) is protected_get
 assert compilation_info(protected_get)['compiled'] and not compilation_info(protected_get)['installed']
 assert protected_get.__code__ is code


def test_protected_scope_stays_closed_on_unadmitted_vectorcall_debug_lane():
 with pytest.raises(UnsupportedBytecode,match='unprotected'):
  lower(build(protected_get))


def protected_unbound():
 _unchanged(None)
 try:return missing
 except UnboundLocalError as error:return error
 missing=None


def case_first_protected_instruction_error_uses_its_exact_handler_and_traceback_pc():
 call,_,_=real_frame_entry(protected_unbound)
 error=call();assert type(error) is UnboundLocalError
 trace=error.__traceback__
 assert trace and trace.tb_frame.f_code is protected_unbound.__code__
 assert trace.tb_lasti==next(i.offset for i in dis.get_instructions(protected_unbound) if i.opname=='LOAD_FAST_CHECK')
 assert frames.active_depth()==0


def protected_native_iteration(items):
 _unchanged(None)
 try:
  for item in items:_unchanged(item)
 except ValueError:return None
 return items


def case_protected_native_iteration_uses_exhausted_and_original_error_edges():
 call,_,counter=real_frame_entry(protected_native_iteration)
 items=[object(),object()]
 assert call(items) is items
 events=[]
 class Iterator:
  def __iter__(self):return self
  def __next__(self):events.append(sys._getframe(1).f_code is protected_native_iteration.__code__);raise ValueError('stop')
 assert call(Iterator()) is None and events==[True]
 assert counter.value==2


CASES=[name for name in tuple(globals()) if name.startswith('case_')]
@pytest.mark.slow
@pytest.mark.parametrize('case',CASES)
def test_real_protected_native_error_continuation(case):
 root=Path(__file__).resolve().parents[1]
 env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
 result=subprocess.run([sys.executable,str(Path(__file__)),case],cwd=root,env=env,
  capture_output=True,text=True,timeout=90,creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
 assert result.returncode==0,(case,result.stdout,result.stderr)
 assert 'PASS '+case in result.stdout


if __name__=='__main__':
 ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
 case=sys.argv[1]
 try:
  globals()[case]()
  assert _RESOURCES and all(owner.calls.value>0 for owner,handle in _RESOURCES),'native body was never entered'
 finally:
  for owner,handle in _RESOURCES:handle.close()
 print('PASS '+case)

def protected_iteration(items):
 try:
  for item in items:pass
 except ValueError:return None
 return None


def test_protected_for_iter_uses_semantic_terminator_before_exception_metadata():
 graph=build(protected_iteration)
 blocks=[block for block in graph.blocks.values() if any(op.name=='for_iter' for op in block.operations)]
 assert blocks and any(block.operations[-1].name=='exception_state' for block in blocks)
 assert lower(graph,frame_entry=True).body_address>0
