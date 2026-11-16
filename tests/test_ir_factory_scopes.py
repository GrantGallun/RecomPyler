"""Fail-first real factory, mid-body cell and power lowerings."""
import ctypes,types,os,subprocess,sys
from pathlib import Path
from test_ir_protected_paths import _unchanged,real_frame_entry,_RESOURCES
import pytest
from recompyler import _flat,heap,provenance
from recompyler._pycc.compiler import _ModuleCompiler
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)

@pytest.mark.parametrize('function',[_flat.unbox_call,_ModuleCompiler.emit_header,heap._ContainerGen.super_call,provenance.bind_source,heap._Program.compile])
def test_original_compiler_factory_prepares_through_protected_stack_parameters(function):
 assert lower(build(function),frame_entry=True).body_address>0

def factory(items,sentinel):
 _unchanged(None)
 item=sentinel
 result=[lambda:item for item in items]
 return result,item

def case_comprehension_cell_is_new_and_outer_local_is_restored():
 call,_,counter=real_frame_entry(factory);a=object();b=object();sentinel=object()
 functions,outer=call([a,b],sentinel)
 assert outer is sentinel and [function() for function in functions]==[b,b]
 assert functions[0].__closure__[0] is functions[1].__closure__[0]
 other,outer=call([a],sentinel)
 assert outer is sentinel and other[0]() is a
 assert other[0].__closure__[0] is not functions[0].__closure__[0]
 empty,outer=call([],sentinel);assert empty==[] and outer is sentinel
 assert counter.value==3

def power(left,right):return left**right

def inplace_power(left,right):
 left**=right
 return left

@pytest.mark.parametrize('function',[power,inplace_power])
def test_power_uses_original_protocol_and_same_result(function):
 marker=object();seen=[]
 class Value:
  def __pow__(self,right,*modulus):seen.append(('pow',right,modulus));return marker
  def __ipow__(self,right,*modulus):seen.append(('ipow',right,modulus));return marker
 call,_,_=frame_entry(function);right=object()
 assert call(Value(),right) is marker
 assert seen==[('ipow' if function is inplace_power else 'pow',right,())]


def test_comprehension_factory_prepares_with_original_graph():
 graph=build(factory);assert lower(graph,frame_entry=True).graph is graph


@pytest.mark.slow
def test_actual_comprehension_factory_native_entry():
 root=Path(__file__).resolve().parents[1];env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
 result=subprocess.run([sys.executable,str(Path(__file__))],cwd=root,env=env,capture_output=True,text=True,timeout=90,creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
 assert result.returncode==0,(result.stdout,result.stderr)
 assert 'PASS original factory' in result.stdout


def protected_defaults(value):
 _unchanged(None)
 try:
  def inner(argument=value):return value,argument
  return inner
 except Exception:return None


def test_duplicate_function_field_stays_closed_across_protected_parameters():
 from dataclasses import replace
 from recompyler.ir import UnsupportedBytecode
 graph=build(protected_defaults);found=False
 for block in graph.blocks.values():
  for index,operation in enumerate(block.operations):
   if operation.name=='set_function_attribute' and operation.attributes['oparg']==1:
    block.operations[index]=replace(operation,attributes={**operation.attributes,'oparg':8});found=True
 assert found
 with pytest.raises(UnsupportedBytecode,match='fresh original-code function'):
  lower(graph,frame_entry=True)


def case_protected_default_factory_keeps_original_function_and_shared_cell():
 call,_,counter=real_frame_entry(protected_defaults);marker=object();function=call(marker)
 assert function()==(marker,marker)
 assert function.__closure__[0].cell_contents is marker
 assert function.__code__ is next(value for value in protected_defaults.__code__.co_consts if isinstance(value,types.CodeType))
 assert counter.value==1


if __name__=='__main__':
 try:
  case_comprehension_cell_is_new_and_outer_local_is_restored()
  case_protected_default_factory_keeps_original_function_and_shared_cell()
 finally:
  for owner,handle in _RESOURCES:handle.close()
 print('PASS original factory')
