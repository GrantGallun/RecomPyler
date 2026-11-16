"""Native Unicode scalar methods must retain exact CPython owners and types."""
import importlib.util
import sys
from pathlib import Path
import pytest
from recompyler.lift import lift

METHODS=('isidentifier','islower','isnumeric','isprintable','isspace','istitle','isupper','isascii','isalnum','isalpha','isdecimal','isdigit')
TEXTS=('', 'ABC', 'abc', 'Abc', 'A B', '1', '\x00', '\u00a0', '\u03a9', '\u03a9x', 'a\x00b', '\ud800', '\U0001f600', '\u1c89', '\u1c8a', '\U0001e4f0')

def load_source(folder,name,source):
    path=folder/(name+'.py');path.write_text(source,encoding='utf-8')
    spec=importlib.util.spec_from_file_location(name,path);module=importlib.util.module_from_spec(spec)
    sys.modules[name]=module;spec.loader.exec_module(module);return module.construct

@pytest.fixture(scope='module')
def predicates(tmp_path_factory):
    folder=tmp_path_factory.mktemp('unicode-predicates')
    result={}
    for method in METHODS:
        fn=load_source(folder,'unicode_'+method,'def construct(s):\n    return s.'+method+'(),s\n')
        result[method]=(fn,lift(fn))
    return result

@pytest.mark.parametrize('method',METHODS)
@pytest.mark.parametrize('text',TEXTS)
def test_current_unicode_predicates_exact_bool_and_input_owner(predicates,method,text):
    fn,compiled=predicates[method];before=compiled.compiled_calls
    result=compiled(text);expected=fn(text)
    assert type(result) is tuple and type(result[0]) is bool
    assert result[0] is expected[0] and result[1] is text
    assert compiled.compiled_calls==before+1,compiled.problem


def literal_owner(x):
    y='Abc abc 12'
    return y.isupper(),y


def tuple_literal_owner(x):
    return ('wide \u03bb owner','wide \u03bb owner')


def nested_alias(s):
    y=(s,)
    return y,y


def scalar_alias(s):
    n=len(s)+1000
    return n,n,s


def char_count(s):
    n=0
    for char in s:
        if char.isupper():
            n+=1
    return n,s


def search(s,needle,start,end):
    return s.index(needle,start,end),s.rfind(needle,start,end),s.rindex(needle,start,end),s


def selected(s):
    return s


def character(s,i):
    return s[i],s


def changed_alias(s):
    y=s
    y='another wide \u03bb owner'
    return y,s


def branch_owner(s,flag):
    if flag:
        n=s.isupper()
    else:
        n=s.islower()
    return n,s


def test_code_constant_and_folded_tuple_owners():
    for fn in [literal_owner,tuple_literal_owner]:
        compiled=lift(fn);expected=fn(3);actual=compiled(3)
        assert actual==expected
        if fn is literal_owner:assert actual[1] is expected[1]
        else:assert actual is expected and actual[0] is actual[1]
        assert compiled.compiled_calls==1,compiled.problem


@pytest.mark.parametrize('fn',[selected,nested_alias,scalar_alias,char_count,changed_alias])
@pytest.mark.parametrize('text',['',''.join(['wide','\u03bb','\U0001f600']),'a'*1024])
def test_selected_and_nested_alias_graph(fn,text):
    compiled=lift(fn);actual=compiled(text);expected=fn(text)
    assert type(actual) is type(expected) and actual==expected
    if fn is selected:assert actual is text
    elif fn is nested_alias:assert actual[0] is actual[1] and actual[0][0] is text
    elif fn is scalar_alias:assert actual[0] is actual[1] and actual[2] is text
    elif fn is changed_alias:assert actual[0] is expected[0] and actual[1] is text
    else:assert actual[1] is text
    assert compiled.compiled_calls==1,compiled.problem


@pytest.mark.parametrize('flag',[False,True])
def test_branch_join_preserves_common_owner(flag):
    text=''.join(['wide','\u03bb']);compiled=lift(branch_owner)
    result=compiled(text,flag);assert result==branch_owner(text,flag) and result[1] is text
    assert compiled.compiled_calls==1,compiled.problem


@pytest.mark.parametrize('text',['a','\u00e9','\u0100','\u03bb','\U0001f600','\ud800'])
def test_character_owner_matches_original_and_cache(text):
    text=''.join([text,'']);compiled=lift(character);result=compiled(text,0);expected=character(text,0)
    assert result==expected and (result[0] is text)==(expected[0] is text) and result[1] is text
    if ord(text)<256:assert result[0] is chr(ord(text))
    assert compiled.compiled_calls==1,compiled.problem


@pytest.mark.parametrize('s,needle,start,end',[('Abc abc 12','a',0,10),('abc','',0,3),('abc','',4,9),('abc','a',-100,100),('abc','x',0,3),('abc','a',2**100,2**100)])
def test_search_bounds_and_exceptions(s,needle,start,end):
    compiled=lift(search)
    def observe(fn):
        try:return ('value',fn(s,needle,start,end))
        except Exception as exc:return ('error',type(exc),str(exc),exc.args)
    expected=observe(search);actual=observe(compiled);assert actual==expected
    if expected[0]=='value':assert actual[1][3] is s and compiled.compiled_calls==1,compiled.problem
    else:assert compiled.fallback_calls==1


def test_subclass_callback_delegates_once(predicates):
    events=[]
    class Text(str):
        def isupper(self):events.append('isupper');return True
    _,compiled=predicates['isupper'];before=compiled.fallback_calls
    text=Text('custom');result=compiled(text)
    assert result[0] is True and result[1] is text and events==['isupper']
    assert compiled.fallback_calls==before+1


def allocated_string(s):
    return s.capitalize()


def ambiguous_owner(s,t,flag):
    if flag:
        y=s
    else:
        y=t
    return y


@pytest.mark.xfail(strict=True,reason='next string builder slice needs explicit fresh/cached/selected result ownership')
def test_next_slice_new_string_builder():
    text=''.join(['lower','\u03bb']);compiled=lift(allocated_string)
    assert compiled(text)==allocated_string(text) and compiled.compiled_calls==1


@pytest.mark.xfail(strict=True,reason='next tagged/managed owner slice carries ambiguous selected source through a join')
def test_next_slice_selected_owner_tag():
    s=''.join(['equal','\u03bb']);t=''.join(['equal','\u03bb']);assert s is not t
    compiled=lift(ambiguous_owner)
    assert compiled(s,t,True) is s and compiled(s,t,False) is t and compiled.compiled_calls==2


COUNTER_ZERO=0


def overwritten_counter(s,values):
    n=COUNTER_ZERO
    for n in values:
        if s.isupper():
            n+=1
    return n,s


def for_else_owner(s,t):
    y=s
    for unused in range(1):
        break
    else:
        y=t
    return y,s


def while_else_owner(s,t):
    y=s
    while True:
        break
    else:
        y=t
    return y,s


@pytest.mark.parametrize('fn',[overwritten_counter,for_else_owner,while_else_owner])
def test_loop_target_is_not_a_fresh_counter_certificate(fn):
    import ast,inspect,textwrap
    from recompyler import _text_owners
    node=ast.parse(textwrap.dedent(inspect.getsource(fn))).body[0]
    certificate=_text_owners.analyze(fn,node)
    assert certificate.result.children[0].kind=='unknown'


def test_loop_target_selected_integer_owner_delegates():
    values=(int('1234567'),int('2345678'))
    compiled=lift(overwritten_counter);result=compiled('lower',values)
    assert type(result[0]) is int and result[0]==values[-1] and result[1]=='lower'
    assert compiled.compiled_calls==1


def all_predicates(s):
    return s.isidentifier(),s.islower(),s.isnumeric(),s.isprintable(),s.isspace(),s.istitle(),s.isupper(),s.isascii(),s.isalnum(),s.isalpha(),s.isdecimal(),s.isdigit(),s


def test_predicates_unicode_categories_and_random_strings():
    import random,unicodedata
    rng=random.Random(8031);examples=list(TEXTS)
    categories={}
    for code in range(0x110000):
        char=chr(code);categories.setdefault(unicodedata.category(char),char)
        if len(categories)==30:break
    examples.extend(categories.values())
    examples.extend(''.join(chr(rng.randrange(0x110000)) for _ in range(rng.randrange(12))) for _ in range(256))
    compiled=lift(all_predicates)
    for text in examples:
        before=compiled.compiled_calls;actual=compiled(text);expected=all_predicates(text)
        assert actual==expected and all(type(value) is bool for value in actual[:-1])
        assert actual[-1] is text and compiled.compiled_calls==before+1,compiled.problem


def search_all(s,needle,start,end):
    return s.find(needle,start,end),s.rfind(needle,start,end),s.count(needle,start,end),s.startswith(needle,start,end),s.endswith(needle,start,end),s,needle


def test_search_cartesian_empty_negative_and_extreme_bounds():
    import itertools
    compiled=lift(search_all)
    for s,needle,start,end in itertools.product(('', 'abab', 'a\u03bb\U0001f600a\x00'),('', 'a', 'ab', '\u03bb', 'missing'),(-(2**63),-10,-1,0,1,4,10,2**63-1),(None,-10,-1,0,1,4,10,2**63-1)):
        before=compiled.compiled_calls;result=compiled(s,needle,start,end)
        assert result==search_all(s,needle,start,end),(s,needle,start,end,result)
        assert result[-2] is s and result[-1] is needle
        assert type(result[3]) is type(result[4]) is bool
        assert compiled.compiled_calls==before+1,compiled.problem


def selected_callback(s,callback):
    callback()
    return s


def test_unknown_call_falls_back_without_preparation_effects():
    from recompyler.lift import Unsupported
    events=[];s=''.join(['selected','\u03bb'])
    try:compiled=lift(selected_callback)
    except Unsupported:
        assert events==[]
        return
    assert compiled(s,lambda:events.append('once')) is s
    assert events==['once'] and compiled.fallback_calls==1


def test_source_and_original_bytecode_must_match():
    import ast,inspect,textwrap,types
    from recompyler import _text_owners
    node=ast.parse(textwrap.dedent(inspect.getsource(literal_owner))).body[0]
    old=literal_owner.__code__
    changed=tuple('different owner' if type(v) is str and v=='Abc abc 12' else v for v in old.co_consts)
    fn=types.FunctionType(old.replace(co_consts=changed),literal_owner.__globals__,literal_owner.__name__)
    certificate=_text_owners.analyze(fn,node)
    assert not certificate.valid and 'bytecode' in certificate.reason


@pytest.mark.parametrize('fn',[for_else_owner,while_else_owner])
def test_break_skips_else_selected_owner(fn):
    s=''.join(['same','\u03bb']);t=''.join(['same','\u03bb']);assert s is not t
    compiled=lift(fn);result=compiled(s,t)
    assert result[0] is s and result[1] is s


GLOBAL_TEXT=''.join(['global','\u03bb'])
GLOBAL_NUMBER=int('12345678')


def selected_global(s):
    return GLOBAL_TEXT,GLOBAL_NUMBER,s


def selected_default(s=''.join(['default','\u03bb'])):
    return s


def test_equal_global_rebinding_preserves_new_owners(monkeypatch):
    compiled=lift(selected_global);text='input'
    before=compiled(text);assert before[0] is GLOBAL_TEXT and before[1] is GLOBAL_NUMBER
    replacement=''.join(['global','\u03bb']);number=int('12345678')
    assert replacement is not GLOBAL_TEXT and number is not GLOBAL_NUMBER
    monkeypatch.setitem(selected_global.__globals__,'GLOBAL_TEXT',replacement)
    monkeypatch.setitem(selected_global.__globals__,'GLOBAL_NUMBER',number)
    after=compiled(text)
    assert after[0] is replacement and after[1] is number and after[2] is text


def test_equal_default_rebinding_preserves_new_owner(monkeypatch):
    compiled=lift(selected_default);old=selected_default.__defaults__[0]
    assert compiled() is old
    replacement=''.join(['default','\u03bb']);assert replacement is not old
    monkeypatch.setattr(selected_default,'__defaults__',(replacement,))
    assert compiled() is replacement


def observed_predicate(s):
    return s.isupper(),s


@pytest.mark.parametrize('observer',['profile','trace','monitor','monitor5','monitor_global','import'])
@pytest.mark.parametrize('warm',[False,True])
def test_native_unicode_observers_delegate_before_probe(observer,warm):
    text=''.join(['OBSERVED','\u03bb']);compiled=lift(observed_predicate)
    if warm:assert compiled(text)==observed_predicate(text) and compiled.compiled_calls==1,compiled.problem
    import builtins
    original_import=builtins.__import__
    events=[];tool=None
    def importing(name,globals=None,locals=None,fromlist=(),level=0):
        if fromlist and '_text_owners' in fromlist:events.append('import')
        return original_import(name,globals,locals,fromlist,level)
    def profile(frame,event,arg):
        if event=='c_call' and getattr(arg,'__name__',None)=='isupper' and getattr(arg,'__self__',None) is text:events.append('isupper')
    def trace(frame,event,arg):
        if frame.f_code is observed_predicate.__code__ and event=='call':events.append('call')
        return trace
    def monitor(code,offset,callable,arg0):
        if code is observed_predicate.__code__:events.append('isupper')
    try:
        if observer=='profile':sys.setprofile(profile)
        elif observer=='trace':sys.settrace(trace)
        elif observer=='import':builtins.__import__=importing
        else:
            tool=5 if observer=='monitor5' else next(i for i in range(6) if sys.monitoring.get_tool(i) is None)
            assert sys.monitoring.get_tool(tool) is None
            sys.monitoring.use_tool_id(tool,'Unicode owner regression')
            sys.monitoring.register_callback(tool,sys.monitoring.events.CALL,monitor)
            if observer=='monitor_global':sys.monitoring.set_events(tool,sys.monitoring.events.CALL)
            else:sys.monitoring.set_local_events(tool,observed_predicate.__code__,sys.monitoring.events.CALL)
        expected=observed_predicate(text);assert events==([] if observer=='import' else [('call' if observer=='trace' else 'isupper')])
        events.clear()
        result=compiled(text)
    finally:
        if observer=='profile':sys.setprofile(None)
        elif observer=='trace':sys.settrace(None)
        elif observer=='import':builtins.__import__=original_import
        elif tool is not None:
            sys.monitoring.set_events(tool,0)
            sys.monitoring.set_local_events(tool,observed_predicate.__code__,0)
            sys.monitoring.register_callback(tool,sys.monitoring.events.CALL,None)
            sys.monitoring.free_tool_id(tool)
    assert result[1] is text and events==([] if observer=='import' else [('call' if observer=='trace' else 'isupper')])
    assert compiled.compiled_calls==int(warm)+int(observer=='import')
    assert compiled.fallback_calls==(0 if observer=='import' else 1)


def character_alias(s,i):
    c=s[i]
    return c,c,c.isidentifier(),s


def character_separate(s,i):
    return s[i],s[i],s


@pytest.mark.parametrize('fn',[character_alias,character_separate])
@pytest.mark.parametrize('s,i',[('\u03bbX',0),('\U0001f600X',0),('\U0001f600A',1),('\u03bbA',1),('A1',0),('A1',1)])
def test_character_cache_freshness_alias_and_identifier(fn,s,i):
    compiled=lift(fn);actual=compiled(s,i);expected=fn(s,i)
    assert actual==expected and actual[-1] is s
    assert (actual[0] is actual[1])==(expected[0] is expected[1])
    assert compiled.compiled_calls==1,compiled.problem


def assigned_before_break(s,t):
    y=s
    for unused in range(1):
        y=t
        break
    else:
        y=s
    return y,s


def skipped_else_return(s,t):
    for unused in range(1):
        break
    else:
        return s,s
    return t,s


def nested_target_counter(s,values):
    n=0
    for group in values:
        for n in group:
            if s.isupper():n+=1
    return n,s


@pytest.mark.parametrize('fn',[assigned_before_break,skipped_else_return])
def test_widened_break_exits_include_assignments_and_else_return(fn):
    s=''.join(['same','\u03bb']);t=''.join(['same','\u03bb']);assert s is not t
    compiled=lift(fn);result=compiled(s,t)
    assert result[0] is t and result[1] is s


def test_nested_for_target_is_not_a_fresh_counter():
    values=((int('1234567'),int('2345678')),)
    compiled=lift(nested_target_counter);result=compiled('lower',values)
    assert type(result[0]) is int and result[0]==values[-1][-1] and compiled.compiled_calls==1


def test_late_nonstring_namespace_key_declines_without_equality_callback():
    events=[];compiled=lift(selected_global);text='input';compiled(text)
    class Key:
        def __hash__(self):return hash('GLOBAL_TEXT')
        def __eq__(self,other):events.append('equality');return False
    key=Key();namespace=selected_global.__globals__;namespace[key]=0;events.clear()
    try:
        result=compiled(text)
        assert result[0] is GLOBAL_TEXT and result[1] is GLOBAL_NUMBER and result[2] is text
        assert events==[] and compiled.fallback_calls==1
    finally:del namespace[key]

def numeric_text_forward(s,value):
    return s,value

def numeric_text_identity(s,left,right):
    return s,left is right

def test_s49_text_leaf_bits_and_identity_observer():
    import struct
    values=(int('1000003'),-0.0,struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0])
    for value in values:
        compiled=lift(numeric_text_forward)
        for _ in range(2):
            text=''.join(['wide ','\u03bb'])
            result=compiled(text,value)
            assert result[0] is text and type(result[1]) is type(value)
            if type(value) is float:assert struct.pack('!d',result[1])==struct.pack('!d',value)
            else:assert result[1]==value
        assert compiled.compiled_calls==2,compiled.problem
    left=int('1000003');right=int('1000003');assert left is not right
    from recompyler.lift import Unsupported
    try:compiled=lift(numeric_text_identity)
    except Unsupported:return
    assert compiled('input',left,right)==('input',False)
    assert compiled.fallback_calls==1 and compiled.compiled_calls==0
