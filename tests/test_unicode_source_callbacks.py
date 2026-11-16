"""Actual public-call source callbacks must happen zero times, as in CPython."""
import linecache,tokenize,types
import pytest
from recompyler import provenance as p
from recompyler.lift import lift


def cached_predicate(name):
    source='def predicate(text):\n    return text.isupper()\n';filename='wave17-'+name+'.py'
    linecache.cache[filename]=(len(source),None,source.splitlines(True),filename)
    ns=types.ModuleType(name);exec(compile(source,filename,'exec',dont_inherit=True),ns.__dict__)
    return ns.predicate,source,filename


def test_public_unicode_lazy_source_loader_has_no_application_event():
    fn,source,filename=cached_predicate('lazy-original-source')
    compiled=lift(fn);events=[]
    def loader():events.append('loader');return source
    linecache.cache[filename]=(loader,)
    assert fn('ABC') is True and not events
    assert compiled('ABC') is True
    assert events==[]


def test_public_first_call_does_not_reopen_cleared_original_source(tmp_path,monkeypatch):
    source='def predicate(text):\n    return text.isupper()\n';path=tmp_path/'original.py';path.write_text(source)
    ns=types.ModuleType('wave17_raw_original');exec(compile(source,str(path),'exec',dont_inherit=True),ns.__dict__)
    compiled=lift(ns.predicate);linecache.cache.pop(str(path),None)
    events=[];original=tokenize._builtin_open
    def watched(filename,*args,**kwargs):
        if str(filename)==str(path):events.append('source read')
        return original(filename,*args,**kwargs)
    monkeypatch.setattr(tokenize,'_builtin_open',watched)
    assert ns.predicate('ABC') is True and not events
    assert compiled('ABC') is True
    assert events==[]


def test_shared_source_cache_rejects_colliding_custom_keys_before_lookup():
    fn,source,filename=cached_predicate('colliding-cache-key');events=[]
    class Key:
        def __hash__(self):return hash(filename)
        def __eq__(self,other):events.append('cache equality');return False
    key=Key();linecache.cache.pop(filename,None);linecache.cache[key]=(len(source),None,source.splitlines(True),filename)
    try:
        events.clear();summary=p.analyze(fn)
        assert not summary.valid and events==[],(summary,events)
    finally:linecache.cache.pop(key,None)

def test_source_cache_metadata_type_comparison_does_not_call_metaclass():
    fn,source,filename=cached_predicate('cache-metadata-type');events=[]
    class Meta(type):
        def __eq__(self,other):events.append('metadata type equality');return False
    class Metadata(metaclass=Meta):pass
    linecache.cache[filename]=(len(source),Metadata(),source.splitlines(True),filename)
    summary=p.analyze(fn)
    assert not summary.valid and events==[]

def test_direct_shared_lazy_source_refuses_without_loader_event():
    fn,source,filename=cached_predicate('direct-lazy-cache');events=[]
    def loader():events.append('loader');return source
    linecache.cache[filename]=(loader,)
    assert not p.analyze(fn).valid and events==[]

def test_public_cold_and_warm_calls_do_not_repeat_certificate_analysis(monkeypatch):
    from recompyler import _text_owners
    fn,source,filename=cached_predicate('cached-certificate')
    compiled=lift(fn);events=[]
    original=_text_owners.analyze
    def observed(*args,**kwargs):events.append('certificate analysis');return original(*args,**kwargs)
    monkeypatch.setattr(_text_owners,'analyze',observed)
    assert compiled('ABC') is True and compiled('abc') is False
    assert events==[] and compiled.compiled_calls==2

def test_public_heap_lazy_source_predicate_declines_without_loader_event():
    from recompyler.heap import lift_region
    fn,source,filename=cached_predicate('heap-lazy-cache');events=[]
    compiled=lift_region(fn)
    def loader():events.append('loader');return source
    linecache.cache[filename]=(loader,)
    assert compiled('ABC') is True and events==[]
    assert compiled.compiled_calls==0 and compiled.fallback_calls==1

def test_public_heap_lazy_source_text_list_declines_without_loader_event():
    from recompyler.heap import lift_region
    source='def f(items):\n    return len(items)\n';filename='wave17-heap-list-loader.py'
    linecache.cache[filename]=(len(source),None,source.splitlines(True),filename)
    ns=types.ModuleType('wave17_heap_list_loader');exec(compile(source,filename,'exec',dont_inherit=True),ns.__dict__)
    compiled=lift_region(ns.f);events=[]
    def loader():events.append('loader');return source
    linecache.cache[filename]=(loader,)
    assert ns.f(['text'])==1 and events==[]
    assert compiled(['text'])==1 and events==[]
    assert compiled.compiled_calls==0
