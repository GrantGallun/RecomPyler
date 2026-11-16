"""New generic scope operations retain merged observer successor checks."""
import sys
import pytest
from test_ir_existing_frame import frame_entry

def positive(value):
 result=+value
 return result

def negative(value):
 result=-value
 return result

def inverted(value):
 result=~value
 return result

@pytest.mark.parametrize('source',[positive,negative,inverted])
def test_observer_enabled_by_unary_callback_resumes_original_successor(source):
 events=[];marker=object()
 def trace(frame,event,arg):
  if frame.f_code is source.__code__:events.append((event,frame.f_lineno))
  return trace
 def activate():
  frame=sys._getframe(2);frame.f_trace=trace;sys.settrace(trace)
  return marker
 class Number:
  def __pos__(self):return activate()
  def __neg__(self):return activate()
  def __invert__(self):return activate()
 native,_,_=frame_entry(source);value=Number()
 try:expected_value=source(value)
 finally:sys.settrace(None)
 expected=list(events);events.clear()
 try:actual=native(value)
 finally:sys.settrace(None)
 assert actual is expected_value is marker
 assert events==expected

import ctypes,os,subprocess,types
from pathlib import Path
from test_ir_protected_paths import _unchanged,real_frame_entry,_RESOURCES

def context_target(manager):
 _unchanged(None)
 with manager as value:
  result=value
 return result


def run_context_case(site):
 events=[];marker=object();target=context_target
 def trace(frame,event,arg):
  if frame.f_code is target.__code__:events.append((event,frame.f_lineno))
  return trace
 def activate():
  frame=sys._getframe(2);frame.f_trace=trace;sys.settrace(trace)
 class Descriptor:
  def __init__(self,name):self.name=name
  def __get__(self,instance,owner):
   if site==self.name+'_descriptor':activate()
   name=self.name
   def execute(*args):
    if site==name+'_call':activate()
    return marker if name=='enter' else False
   return execute
 class Manager:
  __exit__=Descriptor('exit');__enter__=Descriptor('enter')
 call,_,counter=real_frame_entry(context_target)
 try:actual=call(Manager())
 finally:sys.settrace(None)
 actual_events=list(events);events.clear()
 target=types.FunctionType(context_target.__code__.replace(),context_target.__globals__)
 try:expected_value=target(Manager())
 finally:sys.settrace(None)
 assert actual is expected_value is marker
 assert actual_events==events,(site,events,actual_events)
 assert counter.value==1


@pytest.mark.slow
@pytest.mark.parametrize('site',['exit_descriptor','enter_descriptor','enter_call'])
def test_original_context_observers_enter_through_counted_native_body(site):
 root=Path(__file__).resolve().parents[1];env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
 result=subprocess.run([sys.executable,str(Path(__file__)),site],cwd=root,env=env,capture_output=True,text=True,timeout=90,creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
 assert result.returncode==0,(site,result.stdout,result.stderr)
 assert 'PASS '+site in result.stdout


if __name__=='__main__':
 ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
 try:run_context_case(sys.argv[1])
 finally:
  for owner,handle in _RESOURCES:handle.close()
 print('PASS '+sys.argv[1])
