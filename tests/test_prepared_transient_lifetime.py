"""Recipe discovery must release incidental roots before validation observers."""
import gc
from types import ModuleType
import weakref
import pytest
from test_prepared_cache import SOURCE,load_source,standalone

@pytest.fixture(scope='module')
def native_artifact(tmp_path_factory):
 from recompyler import heap,_prepared as pc
 folder=tmp_path_factory.mktemp('transient-native');source=folder/'lifetime.py'
 source.write_text(SOURCE+'\nBox.native_alias=abs\n')
 module=load_source(source);region=heap.Region(module.read)
 assert region(module.Box(10))==10 and region.compiled_calls==1
 section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],folder)
 return pc,heap,module,section

@pytest.mark.parametrize('finalizer',[False,True])
@pytest.mark.parametrize('location',['global','dictionary','module','class-member'])
def test_incidental_search_roots_die_inside_native_validation(native_artifact,monkeypatch,finalizer,location):
 pc,heap,module,section=native_artifact
 index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section));assert index is not None
 events=[]
 class Payload:pass
 if finalizer:Payload.__del__=lambda self:events.append('finalizer')
 def install(namespace):
  if location=='global':namespace.UNUSED=Payload();payload=namespace.UNUSED
  elif location=='dictionary':namespace.UNUSED={'payload':Payload()};payload=namespace.UNUSED['payload']
  elif location=='module':
   namespace.UNUSED=ModuleType('unused_recipe_namespace');namespace.UNUSED.payload=Payload()
   payload=namespace.UNUSED.payload
  else:
   namespace.UNUSED=type('UnusedRecipeClass',(),{'payload':Payload()});payload=namespace.UNUSED.payload
  return weakref.ref(payload,lambda ref:events.append('weak'))
 control=ModuleType('python_control');control_reference=install(control)
 del control.UNUSED;gc.collect();assert control_reference() is None
 expected=list(events);events.clear()
 reference=install(module)
 original=pc.file_key;observed=[]
 def observer(path):
  if not observed:
   observed.append(True);del module.UNUSED;gc.collect()
   assert reference() is None,'incidental recipe search kept an unrelated payload alive across native validation'
   assert events==expected
  return original(path)
 monkeypatch.setattr(pc,'file_key',observer)
 try:
  programs=index.bind(module.read)
  assert programs,pc.last_miss()
  assert observed and reference() is None
  assert all('UNUSED' not in repr(core['definitions']) for core in index.cores)
 finally:
  vars(module).pop('UNUSED',None)


def test_incidental_nonweak_container_recipe_is_revalidated_by_identity(native_artifact):
 pc,heap,module,section=native_artifact
 module.OLD=[];module.CURRENT=[]
 refs=pc.References(module.read)
 old=refs.ref(module.OLD)
 # A stale ID-to-recipe hint must not turn current identity into old identity.
 refs.discovered[id(module.CURRENT)]=old
 try:
  recipe=refs.ref(module.CURRENT)
  assert refs.resolve(recipe) is module.CURRENT
  assert recipe!=old
 finally:
  del module.OLD,module.CURRENT
