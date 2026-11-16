"""AST nodes use a traditional instance dictionary rather than inline values."""
import ast
import pytest
from test_ir_structure_lowerings import Compiled
from recompyler.ir.structure_lowerings import GUARD_MISS

def test_ast_node_attribute_can_be_borrowed_without_materializing_or_callbacks():
 load=Compiled('try_load_attr',2,borrowed=True)
 marker='ast_identifier';node=ast.Name(id=marker)
 assert load(node,'id') is marker
 node.id=None;assert load(node,'id') is None
 del node.id;assert load(node,'id') is GUARD_MISS

def test_ast_node_mixed_dictionary_declines_without_hash_or_equality_callback():
 load=Compiled('try_load_attr',2,borrowed=True);node=ast.Name(id='identifier');events=[]
 class Collision:
  def __hash__(self):return hash('id')
  def __eq__(self,other):events.append('eq');return False
 node.__dict__[Collision()]=None;events.clear()
 assert load(node,'id') is GUARD_MISS and events==[]


def test_legacy_dictionary_class_descriptor_transition_preserves_generic_effects():
 owned=Compiled('load_attr',2);borrowed=Compiled('try_load_attr',2,borrowed=True)
 class Legacy(ast.AST):
  __slots__=()
 node=Legacy();marker=object();node.value=marker
 assert borrowed(node,'value') is marker and owned(node,'value') is marker
 events=[]
 Legacy.value=property(lambda self:events.append('get') or None)
 assert borrowed(node,'value') is GUARD_MISS and events==[]
 assert owned(node,'value') is None and events==['get']


def test_legacy_owned_result_survives_owner_then_releases_at_last_reference():
 import weakref
 load=Compiled('load_attr',2)
 class Marker:pass
 node=ast.Name(id=Marker());reference=weakref.ref(node.id)
 result=load(node,'id');del node
 assert result is reference()
 del result
 assert reference() is None


def test_legacy_mixed_key_owned_fallback_performs_only_original_equality():
 load=Compiled('load_attr',2);node=ast.Name(id='identifier');events=[]
 class Collision:
  def __hash__(self):return hash('id')
  def __eq__(self,other):events.append(other);return False
 foreign=Collision()
 node.__dict__={foreign:None,'id':'value'};events.clear()
 expected=getattr(node,'id');reference_events=list(events);events.clear()
 assert load(node,'id') is expected and events==reference_events


@pytest.mark.parametrize('legacy',[False,True])
def test_descriptor_class_mutation_invalidates_the_borrowing_assumption(legacy):
 borrowed=Compiled('try_load_attr',2,borrowed=True);owned=Compiled('load_attr',2)
 descriptor_value=object();instance_value=object()
 class Descriptor:
  def __get__(self,instance,owner):return descriptor_value
 base=ast.AST if legacy else object
 class Record(base):
  value=Descriptor()
 node=Record();node.value=instance_value
 assert owned(node,'value') is instance_value
 initial=borrowed(node,'value')
 assert initial is instance_value or initial is GUARD_MISS
 Descriptor.__set__=lambda self,instance,value:None
 assert getattr(node,'value') is descriptor_value
 assert borrowed(node,'value') is GUARD_MISS
 assert owned(node,'value') is descriptor_value
