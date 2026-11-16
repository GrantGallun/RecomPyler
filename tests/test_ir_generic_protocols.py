"""Generic stack/truth/comparison/common-constant interpreter operations."""
import dis,gc,types,weakref
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler import _source_frames_native as frames
from test_ir_existing_frame import frame_entry


def choose(left,right):return left or right
def truth(value):
 if value:return True
 return False
def compare(left,right):return left<right
def compare_truth(left,right):
 if left<right:return True
 return False
def augmented_attr(owner,value):owner.field+=value

def test_copy_short_circuit_preserves_exact_operand_and_truth_once():
 call,_,_=frame_entry(choose);right=object();events=[]
 class Left:
  def __bool__(self):events.append('truth');return False
 left=Left();assert call(left,right) is right and events==['truth']
 events.clear()
 assert call(right,left) is right and events==[]


def test_truth_uses_original_bool_len_and_error_protocol():
 call,_,_=frame_entry(truth)
 class Sized:
  def __len__(self):return 2
 assert call(Sized()) is True and call([]) is False
 class Bad:
  def __bool__(self):return 7
 with pytest.raises(TypeError) as expected:truth(Bad())
 with pytest.raises(TypeError) as actual:call(Bad())
 assert str(actual.value)==str(expected.value)
 trace=actual.value.__traceback__
 while trace and trace.tb_frame.f_code is not truth.__code__:trace=trace.tb_next
 assert trace and trace.tb_lasti==next(i.offset for i in dis.get_instructions(truth) if i.opname=='TO_BOOL')


def test_generic_rich_compare_returns_original_protocol_object_without_truth_coercion():
 call,_,_=frame_entry(compare);marker=object();events=[]
 class Left:
  def __lt__(self,right):events.append('lt');return marker
 assert call(Left(),object()) is marker and events==['lt']


def test_generic_compare_bool_flag_uses_result_bool_and_closes_temporary_result():
 call,_,_=frame_entry(compare_truth);events=[]
 class Verdict:
  def __bool__(self):events.append('bool');return True
  def __del__(self):events.append('drop')
 class Left:
  def __lt__(self,right):return Verdict()
 assert call(Left(),object()) is True and events==['bool','drop']


def test_compare_reflection_nan_and_error_match_original():
 call,_,_=frame_entry(compare);marker=object()
 class Left:
  def __lt__(self,right):return NotImplemented
 class Right:
  def __gt__(self,left):return marker
 assert call(Left(),Right()) is marker
 assert call(float('nan'),0.0) is False
 with pytest.raises(TypeError) as expected:compare(1j,2j)
 with pytest.raises(TypeError) as actual:call(1j,2j)
 assert str(actual.value)==str(expected.value)
 assert frames.active_depth()==0


def test_copy_swap_augmented_attribute_publishes_original_get_add_set_order():
 call,_,_=frame_entry(augmented_attr);events=[];marker=object()
 class Value:
  def __iadd__(self,other):events.append(('add',other is marker));return other
 class Owner:
  @property
  def field(self):events.append('get');return Value()
  @field.setter
  def field(self,value):events.append(('set',value is marker))
 assert call(Owner(),marker) is None and events==['get',('add',True),('set',True)]


def common_function(index):
 def original():return None
 code=bytes([dis.opmap['RESUME'],0,dis.opmap['LOAD_COMMON_CONSTANT'],index,dis.opmap['RETURN_VALUE'],0])
 return types.FunctionType(original.__code__.replace(co_code=code),globals())


@pytest.mark.parametrize('index',range(5))
def test_common_constant_is_actual_interpreter_object(index):
 fn=common_function(index);expected=fn();call,_,_=frame_entry(fn)
 assert call() is expected


def test_common_constant_does_not_take_object_from_mutable_dis_display_table():
 fn=common_function(0);expected=fn();old=dis._common_constants[0]
 try:
  dis._common_constants[0]=object();call,_,_=frame_entry(fn)
  assert call() is expected
 finally:dis._common_constants[0]=old


def compare_temporary_truth(left,right):
 if left+0<right+0:return True
 return False


def test_comparison_retires_right_then_left_before_truth_result_callback():
 call,_,_=frame_entry(compare_temporary_truth)
 def observe(target):
  events=[];refs={}
  class Verdict:
   def __bool__(self):events.append(('bool',refs['left']() is None,refs['right']() is None));return True
   def __del__(self):events.append('verdict-drop')
  class Item:
   def __init__(self,name):self.name=name;refs[name]=weakref.ref(self)
   def __lt__(self,other):return Verdict()
   def __del__(self):events.append(self.name)
  class Source:
   def __init__(self,name):self.name=name
   def __add__(self,unused):return Item(self.name)
  assert target(Source('left'),Source('right')) is True
  return events
 assert observe(call)==observe(compare_temporary_truth)==['right','left',('bool',True,True),'verdict-drop']


@pytest.mark.parametrize('spelling',['<','<=','==','!=','>','>='])
def test_all_rich_comparison_relations_and_bool_flags(spelling):
 namespace={};exec('def relation(left,right):return left '+spelling+' right',namespace)
 fn=namespace['relation'];call,_,_=frame_entry(fn)
 for left,right in [(1,2),(2,1),(1,1),(float('nan'),0.0),('same','same')]:
  assert call(left,right) is fn(left,right)
 namespace={};exec('def relation(left,right):\n if left '+spelling+' right:return True\n return False',namespace)
 fn=namespace['relation'];call,_,_=frame_entry(fn)
 for left,right in [(1,2),(2,1),(1,1),(float('nan'),0.0)]:assert call(left,right) is fn(left,right)


def test_compare_result_bool_error_keeps_result_only_through_original_traceback():
 call,_,_=frame_entry(compare_truth)
 def observe(target):
  events=[];refs=[]
  class Verdict:
   def __bool__(self):raise LookupError('truth failed')
   def __del__(self):events.append('drop')
  class Left:
   def __lt__(self,other):
    value=Verdict();refs.append(weakref.ref(value));return value
  with pytest.raises(LookupError,match='truth failed') as actual:target(Left(),None)
  assert events==[] and refs[0]() is not None and frames.active_depth()==0
  trace=actual.value.__traceback__
  while trace and trace.tb_frame.f_code is not compare_truth.__code__:trace=trace.tb_next
  assert trace and trace.tb_lasti==next(i.offset for i in dis.get_instructions(compare_truth) if i.opname=='COMPARE_OP')
  del trace,actual;gc.collect()
  assert refs[0]() is None
  return events
 assert observe(call)==observe(compare_truth)==['drop']
