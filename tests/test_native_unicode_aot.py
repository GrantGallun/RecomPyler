"""Ordinary capture/verification and fresh AOT for strict native Unicode."""
from pathlib import Path
import importlib,json,os,subprocess,sys
from unittest.mock import patch
import pytest
from recompyler import aot,profiler
from recompyler.monitor import CallMonitor
from test_native_unicode import (selected,nested_alias,literal_owner,char_count,search,
    all_predicates,scalar_alias,character_alias,character_separate,search_all)

FUNCTIONS=(selected,nested_alias,literal_owner,char_count,search,all_predicates,
           scalar_alias,character_alias,character_separate,search_all)


def arguments(fn,text):
    if fn is literal_owner:return (3,)
    if fn is search:return (text,'d',0,len(text))
    if fn in (character_alias,character_separate):return (text,0)
    if fn is search_all:return (text,'',-(2**63),None)
    return (text,)


def exact_owners(fn,got,args):
    expected=fn(*args)
    assert type(got) is type(expected) and got==expected
    if fn is selected:assert got is args[0]
    elif fn is nested_alias:assert got[0] is got[1] and got[0][0] is args[0]
    elif fn is literal_owner:assert got[1] is expected[1]
    elif fn is search_all:assert got[-2] is args[0] and got[-1] is args[1]
    else:
        assert got[-1] is args[0]
        if fn in (scalar_alias,character_alias):assert got[0] is got[1]
        if fn is character_separate:assert (got[0] is got[1])==(expected[0] is expected[1])


def test_unicode_capture_verification_and_aot(tmp_path):
    text=''.join(['ABCdef','\u03bb']);entries=[]
    for fn in FUNCTIONS:
        args=arguments(fn,text);path=Path(fn.__code__.co_filename)
        with CallMonitor([path],2,profiler.snapshot,backend='python',bias=0,yield_bias=0) as monitor:
            fn(*args)
        sampler=monitor.samplers[(str(path),fn.__qualname__,fn.__code__.co_firstlineno)]
        candidate=profiler.test_candidate(fn,sampler.samples,1,extra=())
        assert candidate['status']=='verified',candidate
        compiled=candidate['_lifted'];assert compiled.compiled_calls
        entries.append(((fn.__qualname__,fn.__code__.co_firstlineno),fn,compiled,[args]))
    section=aot.build(entries,tmp_path);assert section and len(section['functions'])==len(FUNCTIONS)
    module=aot.load(section)
    for entry,(_,fn,_,cases) in zip(section['functions'],entries):
        wrapper=aot.AotLifted(fn,entry,module)
        for text in ('A1','\u03bbA','\U0001f600A'):
            args=arguments(fn,text)
            if fn is search:args=(text,'A',0,len(text))
            before=wrapper.compiled_calls;got=wrapper(*args);exact_owners(fn,got,args)
            assert wrapper.compiled_calls==before+1
    lifting=importlib.import_module('recompyler.lift')
    with patch.object(lifting,'_text_semantics',return_value='changed helper source'):
        with pytest.raises(lifting.Unsupported,match='changed'):
            aot.AotLifted(FUNCTIONS[0],section['functions'][0],module)
    code="""import json,sys
sys.path.insert(0,'tests')
from test_native_unicode_aot import FUNCTIONS,arguments,exact_owners
from recompyler import aot
section=json.loads(sys.argv[1]);module=aot.load(section)
assert 'numba' not in sys.modules
functions={f.__name__:f for f in FUNCTIONS}
for entry in section['functions']:
    fn=functions[entry['qualname']];wrapper=aot.AotLifted(fn,entry,module)
    for text in ('A1','\u03bbA','\U0001f600A'):
        args=arguments(fn,text)
        if fn.__name__=='search':args=(text,'A',0,len(text))
        before=wrapper.compiled_calls;got=wrapper(*args);exact_owners(fn,got,args)
        assert wrapper.compiled_calls==before+1
assert 'numba' not in sys.modules
print('fresh native Unicode AOT without Numba')
"""
    child=subprocess.run([sys.executable,'-c',code,json.dumps(section)],text=True,capture_output=True,env=os.environ.copy(),timeout=60)
    assert child.returncode==0,(child.stdout,child.stderr)
    assert 'fresh native Unicode AOT without Numba' in child.stdout
