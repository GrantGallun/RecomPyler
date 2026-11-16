"""S57 fail-first design probes; original module context is never executed again."""
import ast,gc,hashlib,inspect,linecache,runpy,sys,textwrap,types,weakref
from pathlib import Path
import pytest
from recompyler import provenance as p
R=Path(__file__).resolve().parents[1]

@pytest.fixture(scope='module')
def originals():
    data=runpy.run_path(str(R/'tests/provenance_cases/wave17-matrix-should-prove.py'))
    absent=object();prior=sys.modules.get('pyperf',absent);shim=types.ModuleType('pyperf')
    exec(compile(data['SUPPORT']['text'],'s57-pyperf','exec',dont_inherit=True),shim.__dict__);sys.modules['pyperf']=shim
    result={}
    try:
        for name,source in data['SOURCES'].items():
            filename='s57-original:'+name;text=source['text']
            linecache.cache[filename]=(len(text),None,text.splitlines(True),filename)
            module=types.ModuleType('s57_original_'+name)
            exec(compile(text,filename,'exec',dont_inherit=True),module.__dict__);result[name]=module
    finally:
        if prior is absent:sys.modules.pop('pyperf',None)
        else:sys.modules['pyperf']=prior
    return result

@pytest.mark.parametrize('module,qualname',[
 ('richards_super','Task.qpkt'),('richards_super','Task.runTask'),
 ('hexiom','Hex.link_nodes'),('hexiom','Done.filter_tiles'),
 ('chaos','Chaosgame.transform_point'),('regex_dna','run_benchmarks'),
])
def test_actual_original_context_binds(module,qualname,originals):
    fn=originals[module]
    for name in qualname.split('.'):fn=getattr(fn,name)
    summary=p.analyze(fn)
    assert summary.valid,(module,qualname,summary.reason)

@pytest.mark.parametrize('module,qualname',[
 ('chaos','Spline.__call__'),('regex_effbot','gen_string_table'),
])
def test_binding_success_does_not_remove_cfg_refusal(module,qualname,originals):
    fn=originals[module]
    for name in qualname.split('.'):fn=getattr(fn,name)
    summary=p.analyze(fn)
    assert not summary.valid and 'explicit provenance transfer' in summary.reason,summary.reason


def make_module(source,name):
    filename='s57-'+name
    linecache.cache[filename]=(len(source),None,source.splitlines(True),filename)
    module=types.ModuleType(name);exec(compile(source,filename,'exec',dont_inherit=True),module.__dict__)
    return module


def test_compiler_never_reexecutes_top_level_decorators_or_defaults():
    source='EVENTS=[]\ndef record(f):\n    EVENTS.append("decorator")\n    return f\ndef default():\n    EVENTS.append("default")\n    return 1\nclass Task:\n    @record\n    def read(self, n=default()):\n        return self.value\n'
    module=make_module(source,'no_reexecute');fn=module.Task.read
    before=list(module.EVENTS);summary=p.analyze(fn)
    assert summary.valid,summary.reason
    assert module.EVENTS==before==['default','decorator']


def test_original_code_metadata_selects_function_despite_mutable_display_names():
    module=make_module('class First:\n    def read(self):\n        return self.first\nclass Second:\n    def read(self):\n        return self.second\n','same_short_name')
    fn=module.Second.read;fn.__name__='display';fn.__qualname__='not.original'
    summary=p.analyze(fn)
    assert summary.valid,summary.reason
    assert any(x.kind=='attribute' and x.key[0]=='second' for x in summary.result.origins)


def test_context_flag_tampering_is_refused_without_standalone_rescue():
    module=make_module('class Task:\n    def read(self):\n        return self.value\n','changed_method_flag')
    code=module.Task.read.__code__
    changed=code.replace(co_flags=code.co_flags & ~getattr(inspect,'CO_METHOD',1<<27))
    fn=types.FunctionType(changed,module.__dict__,'read')
    summary=p.analyze(fn)
    assert not summary.valid,summary


def test_stale_full_context_and_position_tampering_refuse():
    module=make_module('class Task:\n    def read(self):\n        return self.value\n','stale_context');fn=module.Task.read
    filename=fn.__code__.co_filename
    old=linecache.cache[filename];wrong='class Task:\n    def read(self):\n        return self.other\n'
    linecache.cache[filename]=(len(wrong),None,wrong.splitlines(True),filename)
    assert not p.analyze(fn).valid
    linecache.cache[filename]=old
    changed=types.FunctionType(fn.__code__.replace(co_linetable=b''),module.__dict__,'read')
    assert not p.analyze(changed).valid

@pytest.mark.parametrize('field,value',[('co_qualname','wrong.owner.read'),('co_name','display_read'),('co_firstlineno',999)])
def test_original_code_identity_metadata_is_not_normalized(field,value):
    module=make_module('class Task:\n    def read(self):\n        return self.value\n','metadata_'+field)
    code=module.Task.read.__code__.replace(**{field:value})
    fn=types.FunctionType(code,module.__dict__,'read')
    assert not p.analyze(fn).valid

def test_nested_code_positions_are_part_of_the_exact_witness():
    module=make_module('def outer(value):\n    def inner():\n        return 3\n    return value\n','nested_positions')
    code=module.outer.__code__;constants=list(code.co_consts)
    index=next(i for i,c in enumerate(constants)if type(c) is types.CodeType)
    constants[index]=constants[index].replace(co_linetable=b'')
    fn=types.FunctionType(code.replace(co_consts=tuple(constants)),module.__dict__,'outer')
    summary=p.analyze(fn)
    assert not summary.valid and 'cannot bind original source/bytecode' in summary.reason,summary.reason

def test_original_closure_does_not_gain_a_same_named_global_origin():
    module=make_module('captured="global"\ndef factory(captured):\n    def selected():\n        return captured\n    return selected\n','free_cell')
    summary=p.analyze(module.factory(object()))
    assert not summary.valid and summary.result.unknown

def test_full_module_binding_keeps_only_weak_application_witnesses():
    module=make_module('class Value: pass\nvalue=Value()\ndef selected():\n    return value\n','weak_context')
    function,owner=weakref.ref(module.selected),weakref.ref(module.value)
    summary=p.analyze(module.selected);assert summary.valid,summary.reason
    assert summary.dependencies_match(module.selected)
    del module;gc.collect()
    assert function() is None and owner() is None


def test_bound_assertion_tracks_truth_callback_and_failure_message_escape():
    module=make_module('def selected(value,condition,message):\n    assert condition,message\n    return value\n','assert_transfer')
    summary=p.analyze(module.selected)
    assert summary.valid,summary.reason
    assert summary.result==p.argument(0)
    assert summary.may_escape(p.argument(1)) and summary.may_escape(p.argument(2))
    owner,message=object(),object()
    assert module.selected(owner,True,message) is owner
    with pytest.raises(AssertionError) as error:module.selected(owner,False,message)
    assert error.value.args[0] is message


def test_shlex_context_can_bind_without_granting_physical_roots(originals):
    summary=p.analyze(originals['shlex'].shlex.read_token)
    assert summary.valid,summary.reason
    assert summary.naturally_rooted(summary.result) is not True
