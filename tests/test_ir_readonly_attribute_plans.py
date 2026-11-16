"""The one shared borrowed traversal emitter consumes guarded attribute feedback."""
import pytest
from recompyler import heap,_structure_ops_native as provider,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.structure_lowerings import StructureCalls,specialize_structure_calls
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import create_callable

@pytest.mark.parametrize('mapping',[False,True])
def test_immutable_attribute_plan_is_used_by_the_shared_borrowed_loop(mapping):
 if mapping:
  function=heap._Program.canon
  classes=[type('R'+str(i),(),{}) for i in range(4)]
  owner=object.__new__(heap._Program);owner.alias=dict(zip(classes,classes[1:]));arguments=(owner,classes[0]);expected=classes[-1]
 else:
  function=heap._find
  nodes=[heap._Cell() for _ in range(4)]
  for first,second in zip(nodes,nodes[1:]):first.parent=second
  arguments=(nodes[0],);expected=nodes[-1]
 for _ in range(2000):assert function(*arguments) is expected
 graph=specialize_structure_calls(build(function),immediate_offsets=True)
 ops=StructureCalls(CPythonSymbols(),provider)
 result=lower(graph,structure_calls=ops,readonly_loops=True)
 assert len(ops.attribute_plans)==1
 entry=create_callable(function,result.body_address,result.keepalive,
                       runner_address=frames.addresses()['run_vectorcall'])
 assert entry(*arguments) is expected
 # Materializing the attribute dictionary must use the same loop's fallback.
 vars(arguments[0])
 assert entry(*arguments) is expected


def test_late_foreign_key_error_keeps_current_source_locals_and_original_site():
 import sys
 events=[];failure=ValueError('late key hash')
 class Root:pass
 class Middle:pass
 class Meta(type):
  def __hash__(cls):
   frame=sys._getframe(1)
   events.append((frame.f_code is heap._Program.canon.__code__,
                  frame.f_locals['self'] is owner,frame.f_locals['root'] is cls,frame.f_lasti))
   raise failure
 class Foreign(metaclass=Meta):pass
 owner=object.__new__(heap._Program);owner.alias={Root:Middle,Middle:Foreign}
 with pytest.raises(ValueError) as caught:heap._Program.canon(owner,Root)
 assert caught.value is failure
 expected=list(events);events.clear()
 ops=StructureCalls(CPythonSymbols(),provider)
 lowered=lower(build(heap._Program.canon),structure_calls=ops,readonly_loops=True)
 entry=create_callable(heap._Program.canon,lowered.body_address,lowered.keepalive,
                       runner_address=frames.addresses()['run_vectorcall'])
 with pytest.raises(ValueError) as caught:entry(owner,Root)
 assert caught.value is failure and events==expected
