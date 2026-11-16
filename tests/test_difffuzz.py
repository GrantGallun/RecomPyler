"""Executable counterexamples for the differential oracle and seeded driver."""
import importlib.util
import struct
import sys
import types
from pathlib import Path
import pytest
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
from difffuzz.core import compare, arguments, shrink, UnsupportedOracle

class Native:
    def __init__(self,fn):self.fn=fn;self.compiled_calls=0
    def __call__(self,*a,**k):self.compiled_calls+=1;return self.fn(*a,**k)

def module():return types.ModuleType('difffuzz_test')

def check(a,b,args=(),kwargs=None):
    return compare(a,Native(b),args,kwargs or {},module())

def test_value_and_exact_type():
    assert check(lambda:1,lambda:True)['status']=='wrong'
    assert check(lambda:1,lambda:1)['status']=='native'

def test_numeric_identity_is_exempt_but_bits_are_exact():
    assert check(lambda x:x,lambda x:int(str(x)),(10**30,))['status']=='native'
    assert check(lambda:-0.,lambda:0.)['status']=='wrong'
    a=struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0]
    b=struct.unpack('!d',bytes.fromhex('7ff8000000005678'))[0]
    assert check(lambda:a,lambda:b)['status']=='wrong'

def test_string_identity_against_input_and_nested_container():
    text=''.join(['noninterned',' text'])
    assert check(lambda x:x,lambda x:(' '+x)[1:],(text,))['status']=='wrong'
    assert check(lambda x:x[0],lambda x:(' '+x[0])[1:],([text],))['status']=='wrong'

def test_result_sharing_and_cycles():
    def a():x=[];return [x,x]
    assert check(a,lambda:[[],[]])['status']=='wrong'
    x=[];x.append(x)
    assert check(lambda x:x,lambda x:x,(x,))['status']=='native'

def test_mutation_every_argument_and_alias():
    def a(x,y):x.append(3);return 1
    assert check(a,lambda x,y:1,([],[]))['status']=='wrong'
    x=[]
    assert check(lambda a,b:a is b,lambda a,b:False,(x,x))['status']=='wrong'

def test_exception_type_message_and_context():
    def a():raise ValueError('one')
    def b():raise ValueError('two')
    def c():
        try:raise TypeError('inner')
        except TypeError:raise ValueError('one') from None
    assert check(a,b)['status']=='wrong'
    assert check(a,c)['status']=='wrong'

def test_globals_stdout_and_event_order_are_observed():
    m=module();m.EVENTS=[];m.COUNT=0
    def a(x):m.EVENTS.append(x);m.COUNT+=1;print('event');return x
    got=compare(a,Native(lambda x:x),(1,),{},m)
    assert got['status']=='wrong' and m.EVENTS==[] and m.COUNT==0

def test_unknown_result_is_explicitly_unchecked():
    assert check(lambda:iter([1]),lambda:iter([1]))['status']=='unchecked'

def test_warm_call_and_declined_fallback():
    class Warm:
        compiled_calls=0
        def __call__(self,x):self.compiled_calls+=1;return x if self.compiled_calls==1 else x+1
    wrapper=Warm()
    assert compare(lambda x:x,wrapper,(1,),{},module(),warm=2)['status']=='wrong'
    assert compare(lambda x:x,lambda x:x,(1,),{},module())['status']=='declined'

def test_subclass_kind_and_nested_alias_survive_input_copy():
    class I(int):pass
    assert check(lambda x:type(x),lambda x:int,(I(2),))['status']=='wrong'

def test_generators_preserve_return_value():
    def a():yield 1;return 'a'
    def b():yield 1;return 'b'
    assert check(a,b)['status']=='wrong'

def test_seeded_domains_include_boundaries_aliases_and_subclasses():
    fn=lambda a,b:None
    variants=list(arguments(fn,([1],[2]),{},seed=17,trials=80))
    assert repr(variants)==repr(list(arguments(fn,([1],[2]),{},seed=17,trials=80)))
    assert any(a[0] is a[1] for a,k in variants)
    values=[x for a,k in arguments(lambda x:None,(0,),{},seed=1,trials=80) for x in a]
    assert any(type(x) is int and x==2**63 for x in values)
    assert any(type(x) is bool for x in values)
    assert any(type(x) is not int and isinstance(x,int) and type(x) is not bool for x in values)

def test_shrinker_preserves_failure_and_reduces_input():
    args,kw=shrink(([1,2,3,4],),{},lambda a,k:bool(a[0]))
    assert len(args[0])==1
from difffuzz.catalog import discover,filtered_source,mutate
from difffuzz.recipe import recipe
from difffuzz.core import compare

def test_portable_recipe_keeps_alias_cycles_and_float_bits():
    x=[];x.append(x);args=(x,x,-0.0)
    ns={};exec(recipe(args,{}),ns)
    assert ns['ARGS'][0] is ns['ARGS'][1] is ns['ARGS'][0][0]
    assert struct.pack('!d',ns['ARGS'][2])==struct.pack('!d',-0.0)

def test_existing_program_inventory_and_mutation():
    root=Path(__file__).resolve().parents[1]
    rows=discover(root,('matrix',))
    assert len(rows)>=1016
    target=next(r for r in rows if r['id']=='matrix:statement.if_else')
    changed=mutate(target,0)
    assert changed['source']!=target['source'] and changed['mutation']==0

def test_static_discovery_never_executes_test_module_setup():
    source='import os\nraise RuntimeError("top level")\nSTATE=[]\ndef subject(x):\n    return x+1\n'
    filtered=filtered_source(source)
    ns={};exec(filtered,ns)
    assert 'os' not in ns and ns['subject'](2)==3

def test_closure_selected_string_identity():
    text=''.join(['closure',' selected owner'])
    def a():return text
    assert check(a,lambda:(' '+text)[1:])['status']=='wrong'

def test_mutable_defaults_get_independent_calls():
    def a(x=[]):x.append(1);return len(x)
    assert check(a,a)['status']=='native'
    assert a.__defaults__==([],)

def test_each_parameter_gets_text_and_numeric_boundaries():
    variants=list(arguments(lambda a,b:None,('abc','def'),{},seed=9,trials=48))
    for at in (0,1):
        assert any(type(a[at]) is str and a[at]=='\u03a9' for a,k in variants)
        assert any(type(a[at]) is bytes and not a[at] for a,k in variants)

def test_extension_template_is_unchecked_instead_of_worker_crash():
    if sys.version_info<(3,14):pytest.skip('template literals require Python 3.14')
    value=eval('t"hello"')
    assert check(lambda:value,lambda:value)['status']=='unchecked'

def test_created_global_cannot_contaminate_compiled_replay():
    m=module();exec('def subject():\n    globals()["CREATED"]=1\n    return 0\n',m.__dict__)
    assert compare(m.subject,Native(lambda:0),(),{},m)['status']=='wrong'
    assert 'CREATED' not in vars(m)

def test_created_callable_binding_is_observed():
    m=module();exec('def subject():\n    globals()["CREATED"]=int\n    return 0\n',m.__dict__)
    assert compare(m.subject,Native(lambda:0),(),{},m)['status']=='wrong'
    assert 'CREATED' not in vars(m)

def test_oracle_retains_seen_nodes_for_the_whole_projection():
    from difffuzz.core import Graph
    graph=Graph({})
    first=graph.freeze([1])
    # A temporary projection must not be confused with a later object whose
    # address was recycled after the first temporary was destroyed.
    second=graph.freeze([])
    assert second[0]=='node' and second[1]!=first[1]

def test_same_named_distinct_instance_types_are_not_equal():
    m=module();exec('class C: pass\ndef subject(): return C()\n',m.__dict__)
    other=type('C',(),{'__module__':m.__name__})
    assert compare(m.subject,Native(other),(),{},m)['status']=='wrong'

def test_type_argument_with_reachable_mutation_is_unchecked_without_leaking():
    class C:items=[]
    def bad(c):c.items.append('bad');return 0
    assert check(lambda c:0,bad,(C,))['status']=='unchecked'
    assert C.items==[]

def test_instance_dictionary_alias_survives_copy_in_both_orders():
    from difffuzz.core import clone
    class Box:pass
    obj=Box();obj.x=1;data=obj.__dict__
    for args in ((obj,data),(data,obj)):
        copied=clone(args)
        a,b=copied if type(copied[0]) is Box else tuple(reversed(copied))
        assert a.__dict__ is b
    assert check(lambda obj,d:d is obj.__dict__,lambda obj,d:False,(obj,data))['status']=='wrong'

def test_exceptional_generator_preserves_prior_yields():
    def a():yield 1;raise ValueError('boom')
    def b():yield 2;raise ValueError('boom')
    assert check(a,b)['status']=='wrong'

def test_nonfinite_frozenset_recipe_replays_exact_bits():
    nan=struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0]
    ns={};exec(recipe((frozenset((float('inf'),nan)),),{}),ns)
    assert {struct.pack('!d',v) for v in ns['ARGS'][0]}=={struct.pack('!d',v) for v in (float('inf'),nan)}

def test_first_argument_variant_preserves_positional_keyword_alias():
    x=[];a,k=next(arguments(lambda a,*,b:None,(x,),{'b':x}))
    assert a[0] is k['b']

def test_inventory_resolves_catalogue_sibling_imports_and_restores_path(tmp_path):
    from difffuzz.catalog import discover
    folder=tmp_path/'matrix';folder.mkdir()
    (folder/'wave17_catalogue_helper.py').write_text('ROWS=[]\n')
    (folder/'catalogue.py').write_text('from wave17_catalogue_helper import ROWS\ndef cases(): return ROWS\n')
    before=sys.path[:]
    assert discover(tmp_path,sources=('matrix',))==[]
    assert sys.path==before

def test_static_clock_import_is_retained_without_running_fixture_body():
    from difffuzz.catalog import filtered_source
    source=filtered_source('import time\ndef clock_resolution(): return time.get_clock_info("perf_counter").monotonic\n')
    assert 'import time' in source


def test_ast_graph_clone_and_portable_recipe():
    import ast
    from difffuzz.core import clone
    from difffuzz.recipe import recipe
    value=ast.parse('left, [right, last] = source').body[0].targets[0]
    copied=clone(value)
    assert ast.dump(copied,include_attributes=True)==ast.dump(value,include_attributes=True)
    assert copied is not value and copied.elts[0].id is value.elts[0].id
    text=recipe((value,value),{})
    namespace={};exec(text,namespace)
    a,b=namespace['ARGS']
    assert a is b and ast.dump(a,include_attributes=True)==ast.dump(value,include_attributes=True)


def test_explicit_ast_fixture_arguments(tmp_path):
    from difffuzz.catalog import discover
    path=tmp_path/'ast_subject.py'
    path.write_text("import ast\nFUZZ_ARGUMENTS={'subject': \"(ast.Name(id='value'),)\"}\ndef subject(node):\n    return node.id\n",encoding='utf-8')
    root=Path(__file__).resolve().parents[1]
    descriptor=discover(root,(),[path])[0]
    assert descriptor['args']=="(ast.Name(id='value'),)"
    assert 'import ast' in descriptor['source']

def test_anchor_addresses_keep_their_original_objects_alive():
    import gc
    import weakref
    from difffuzz.core import anchors
    class Box: pass
    box = Box()
    reference = weakref.ref(box)
    external = anchors({'args': (box,)}, lambda: None)
    del box
    gc.collect()
    assert reference() is not None
    assert id(reference()) in external
