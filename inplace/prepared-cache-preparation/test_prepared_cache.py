"""PREPARATION ONLY: not imported or run; relocate only after DESIGN 20 activation.

API tests target the proposal in design.md. Positive cases require real pycc
artifacts. No fake Python callable is accepted as native seal evidence.
"""
from copy import deepcopy
import gc
import importlib.util
import json
from pathlib import Path
import struct
import sys
import weakref

import pytest

SOURCE = '''import random
GLOBAL = 3

def helper(value=4):
    return abs(value) + 1

class Base:
    def offset(self):
        return 1

class Box(Base):
    def __init__(self, value):
        self.value = value

def work(box, items, scale=2, *, bias=1):
    box.value += scale + bias + helper(GLOBAL) + box.offset()
    items.append(box.value)
    return box, items, box.value

def alias(box, left, right):
    left.append(box)
    return left, right, left[-1]

def random_step(n):
    return random.randrange(n)

def read(box):
    return box.value
'''


def standalone(section):
    return {'mode': 'standalone', 'functions': [], 'plan': {'aot_regions': section}}


def load_source(path):
    name = '_prepared_cache_fixture_' + path.parent.name.replace('-', '_')
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


@pytest.fixture(scope='module')
def artifact(tmp_path_factory):
    from recompyler import heap, _prepared as pc
    folder = tmp_path_factory.mktemp('prepared-real-aot')
    source = folder / 'workload.py'
    source.write_text(SOURCE, encoding='utf-8')
    module = load_source(source)
    calls = [(module.work, (module.Box(10), [])),
             (module.alias, (module.Box(10), [], [])),
             (module.random_step, (100,)), (module.read, (module.Box(10),))]
    entries = []
    for fn, args in calls:
        region = heap.lift_region(fn)
        region(*args)
        assert region.compiled_calls == 1, region.problem
        entries.append(((fn.__name__, fn.__code__.co_firstlineno), fn, region))
    section = heap.build_regions(entries, folder)
    assert section and section.get('prepared'), 'real prepared records were not emitted'
    (folder / 'section.json').write_text(json.dumps(section), encoding='utf-8')
    return pc, heap, module, source, section


def row_for(section, name='work'):
    return next(row for row in section['functions'] if row['function'] == name)


def bound(artifact, *, section=None, name='work', snapshot=None):
    pc, heap, module, source, original = artifact
    section = original if section is None else section
    index = pc.open_index(section, row_for(section, name),
                          plan_snapshot=standalone(section) if snapshot is None else snapshot)
    return [] if index is None else index.bind(getattr(module, name))


def assert_no_binding(artifact, **kwargs):
    assert bound(artifact, **kwargs) == [], 'incompatible metadata acquired a native binding'


def test_real_legacy_and_seed_records_are_emitted(artifact):
    pc, heap, module, source, section = artifact
    cores = section['prepared']['cores']
    assert any(core['variant'] == 'legacy' for core in cores)
    assert any(core['variant'] in ('strict-seed', 'wide-seed') for core in cores)
    assert all(row['prepared'] for row in section['functions'])
    assert all(core['generated']['digest'] in row_for(section, core['entry_id']['qualname'].split('.')[-1])['exports']
               for core in cores)


def test_prepared_bind_skips_all_program_construction_and_analysis(artifact, monkeypatch):
    pc, heap, module, source, section = artifact
    def forbidden(*args, **kwargs):
        raise AssertionError('analysis ran on valid prepared bind')
    for owner, name in [(heap._Program, '__init__'), (heap._Function, '__init__'),
                        (heap._Program, 'compile'), (heap._Program, 'settle'),
                        (heap._Program, 'register'), (heap._Gen, 'run'),
                        (heap, '_seed'), (heap, '_init_assigned'), (heap, '_source_digest')]:
        monkeypatch.setattr(owner, name, forbidden)
    programs = bound(artifact)
    assert programs and all(program.ahead_of_time for program in programs)
    assert programs[0].entry.params == ['box', 'items', 'scale', 'bias']


def test_prepared_runtime_preserves_writeback_alias_and_original_identity(artifact):
    pc, heap, module, source, section = artifact
    index = pc.open_index(section, row_for(section), plan_snapshot=standalone(section))
    assert index is not None, pc.last_miss()
    programs = index.bind(module.work)
    assert programs, pc.last_miss()
    program = programs[0]
    region = heap.lift_region(module.work, {program.digest: program.run}, prepared=index)
    box, values = module.Box(10), []
    result = region(box, values)
    assert result == (box, values, 18)
    assert result[0] is box and result[1] is values and values == [18]
    assert region.prepared_hits == 1
    assert (region.compiled_calls, region.aot_calls, region.jit_calls, region.fallback_calls) == (1, 1, 0, 0)
    alias_index = pc.open_index(section, row_for(section, 'alias'), plan_snapshot=standalone(section))
    alias_program = alias_index.bind(module.alias)[0]
    alias = heap.lift_region(module.alias, {alias_program.digest: alias_program.run}, prepared=alias_index)
    shared = []
    result = alias(box, shared, shared)
    assert result[0] is result[1] is shared and result[2] is box
    assert alias.aot_calls == 1


@pytest.mark.parametrize('mutation', ['source-bytes', 'entry-code', 'entry-constants',
    'dependency-code', 'dependency-constants', 'entry-defaults', 'kwdefaults-replace',
    'kwdefaults-inplace', 'dependency-defaults', 'global-constant', 'method-body',
    'method-shadow', 'constructor-body', 'mro', 'finalizer', 'custom-new',
    'getattribute', 'slot-descriptor', 'class-binding', 'builtin-shadow', 'module-binding'])
def test_each_live_key_component_change_declines_before_native(artifact, monkeypatch, mutation):
    pc, heap, module, source, section = artifact
    module = load_source(source)
    artifact = (pc, heap, module, source, section)
    assert bound(artifact), pc.last_miss()
    if mutation == 'source-bytes':
        before = source.read_bytes()
        try:
            source.write_bytes(before + b'\n# exact file bytes changed\n')
            assert_no_binding(artifact)
        finally:
            source.write_bytes(before)
        return
    if mutation == 'entry-code':
        monkeypatch.setattr(module.work, '__code__', module.read.__code__)
    elif mutation == 'entry-constants':
        code = module.work.__code__
        monkeypatch.setattr(module.work, '__code__', code.replace(co_consts=code.co_consts + (123456789,)))
    elif mutation in ('dependency-code', 'dependency-constants'):
        code = module.helper.__code__
        changed = module.read.__code__ if mutation == 'dependency-code' else code.replace(co_consts=(None, 2))
        monkeypatch.setattr(module.helper, '__code__', changed)
    elif mutation == 'entry-defaults':
        monkeypatch.setattr(module.work, '__defaults__', (7,))
    elif mutation == 'kwdefaults-replace':
        monkeypatch.setattr(module.work, '__kwdefaults__', {'bias': 8})
    elif mutation == 'kwdefaults-inplace':
        monkeypatch.setitem(module.work.__kwdefaults__, 'bias', 8)
    elif mutation == 'dependency-defaults':
        monkeypatch.setattr(module.helper, '__defaults__', (9,))
    elif mutation == 'global-constant':
        monkeypatch.setattr(module, 'GLOBAL', 9)
    elif mutation == 'method-body':
        monkeypatch.setattr(module.Base.offset, '__code__', module.helper.__code__)
    elif mutation == 'method-shadow':
        monkeypatch.setattr(module.Box, 'offset', module.helper, raising=False)
    elif mutation == 'constructor-body':
        monkeypatch.setattr(module.Box.__init__, '__code__', module.read.__code__)
    elif mutation == 'mro':
        class Other: pass
        before = module.Box.__bases__
        try:
            module.Box.__bases__ = (Other,)
            assert_no_binding(artifact)
        finally:
            module.Box.__bases__ = before
        return
    elif mutation == 'finalizer':
        monkeypatch.setattr(module.Base, '__del__', lambda self: None, raising=False)
    elif mutation == 'custom-new':
        monkeypatch.setattr(module.Box, '__new__', staticmethod(lambda cls, *a: object.__new__(cls)), raising=False)
    elif mutation == 'getattribute':
        monkeypatch.setattr(module.Box, '__getattribute__', lambda self, key: object.__getattribute__(self, key), raising=False)
    elif mutation == 'slot-descriptor':
        monkeypatch.setattr(module.Box, 'value', property(lambda self: 999), raising=False)
    elif mutation == 'class-binding':
        monkeypatch.setattr(module, 'Box', type('Box', (), {}))
    elif mutation == 'builtin-shadow':
        # Work's list append does not use a builtin global. This exercises the
        # recorded absence recipe through the dependent helper's globals.
        monkeypatch.setitem(module.__dict__, '__builtins__', {'len': lambda x: 999})
    elif mutation == 'module-binding':
        monkeypatch.setattr(module, 'random', object())
        assert_no_binding(artifact, name='random_step')
        return
    assert_no_binding(artifact)


@pytest.mark.parametrize('value', [float('nan'), -0.0, 0.0, float('inf'), float('-inf'),
                                  2**53 + 1, -(2**63), b'\x00\xff'])
def test_literal_encoding_is_primitive_and_bit_exact(value):
    from recompyler import _prepared as pc
    encoded = pc.literal_key(value)
    assert json.loads(json.dumps(encoded, allow_nan=False)) == encoded
    if type(value) is float:
        bits = struct.pack('>d', value).hex()
        assert bits in json.dumps(encoded)


def test_distinct_nan_payloads_and_signed_zero_have_distinct_keys():
    from recompyler import _prepared as pc
    a = struct.unpack('>d', bytes.fromhex('7ff8000000000001'))[0]
    b = struct.unpack('>d', bytes.fromhex('7ff8000000000002'))[0]
    assert pc.literal_key(a) != pc.literal_key(b)
    assert pc.literal_key(0.0) != pc.literal_key(-0.0)
    assert pc.literal_key(True) != pc.literal_key(1)


def test_literal_encoder_never_invokes_user_hooks():
    from recompyler import _prepared as pc
    calls = []
    class Trap:
        def __repr__(self): calls.append('repr'); raise AssertionError
        def __hash__(self): calls.append('hash'); raise AssertionError
        def __eq__(self, other): calls.append('eq'); raise AssertionError
        def __reduce__(self): calls.append('pickle'); raise AssertionError
    with pytest.raises(pc.PreparedMiss):
        pc.literal_key(Trap())
    assert calls == []


@pytest.mark.parametrize('section_key,field', [
    ('compiler', 'sources'), ('compiler', 'schema'), ('compiler', 'target_cpu'),
    ('compiler', 'use_nrt'), ('compiler', 'cflags'), ('compiler', 'ldflags'),
    ('compiler', 'numba_build'), ('compiler', 'llvmlite_build'),
    ('runtime', 'python'), ('runtime', 'soabi'), ('runtime', 'pointer_bits'),
    ('runtime', 'byteorder'), ('runtime', 'numpy_abi'), ('runtime', 'native_sha256'),
    ('runtime', 'load_contracts_version'), ('runtime', 'header_abi'),
    ('runtime', 'python_binary_sha256'), ('runtime', 'free_threaded')])
def test_each_compiler_runtime_abi_component_invalidates(artifact, monkeypatch, section_key, field):
    pc = artifact[0]
    name = section_key + '_key'
    original = getattr(pc, name)
    def changed():
        result = deepcopy(original())
        result[field] = ['deliberately-changed', result.get(field)]
        return result
    monkeypatch.setattr(pc, name, changed)
    assert_no_binding(artifact)


@pytest.mark.parametrize('path', [
    ('mode',), ('plan', 'worth_running'), ('plan', 'startup_s'), ('plan', 'saving_s'),
    ('plan', 'future_option'), ('functions',),
    ('plan', 'aot_regions', 'functions', 0, 'seed_policy'),
    ('plan', 'aot_regions', 'functions', 0, 'seeds'),
    ('plan', 'aot_regions', 'functions', 0, 'exports')])
def test_every_semantic_plan_seed_selection_component_invalidates(artifact, path):
    section = deepcopy(artifact[4])
    snapshot = standalone(section)
    node = snapshot
    for part in path[:-1]:
        node = node[part]
    node[path[-1]] = ['changed', node.get(path[-1]) if isinstance(node, dict) else node[path[-1]]]
    assert_no_binding(artifact, section=section, snapshot=snapshot)


@pytest.mark.parametrize('field', ['entry_function', 'functions', 'order', 'cells',
    'classes', 'families', 'aliases', 'written', 'globals', 'strings', 'guards', 'flags', 'reports'])
def test_tampered_runtime_field_cannot_pair_with_original_native_seal(artifact, field):
    pc = artifact[0]
    section = deepcopy(artifact[4])
    cores = section['prepared']['cores']
    cores[0]['execution'][field] = ['forged', cores[0]['execution'][field]]
    # Recompute all untrusted JSON checksums: only the compiled seal is authority.
    section['prepared'].update(pc.bundle(cores))
    assert_no_binding(artifact, section=section)


@pytest.mark.parametrize('field', ['digest', 'source', 'source_sha256', 'entry_symbol', 'signature'])
def test_tampered_generated_export_metadata_is_not_authority(artifact, field):
    pc = artifact[0]
    section = deepcopy(artifact[4])
    cores = section['prepared']['cores']
    cores[0]['generated'][field] = ['forged', cores[0]['generated'][field]]
    section['prepared'].update(pc.bundle(cores))
    assert_no_binding(artifact, section=section)


@pytest.mark.parametrize('mutation', ['missing', 'file-hash', 'length', 'module-name',
    'wrong-folder', 'export-swap', 'seal-export-name', 'schema'])
def test_bad_native_binding_or_abi_never_attaches(artifact, mutation):
    section = deepcopy(artifact[4])
    outer = section['prepared']['artifact']
    if mutation == 'missing': outer['file'] = 'missing.pyd'
    elif mutation == 'file-hash': outer['sha256'] = '0' * 64
    elif mutation == 'length': outer['length'] += 1
    elif mutation == 'module-name': section['module'] += '_other'
    elif mutation == 'wrong-folder': section['folder'] += '/other'
    elif mutation == 'export-swap':
        rows = section['functions']
        first = next(iter(rows[0]['exports']))
        rows[0]['exports'][first] = next(iter(rows[1]['exports'].values()))
    elif mutation == 'seal-export-name': section['prepared']['seal_export'] = 'r0'
    elif mutation == 'schema': section['prepared']['schema'] = 999
    assert_no_binding(artifact, section=section)


def test_python_replacement_seal_or_export_is_never_called(artifact, monkeypatch):
    pc, heap, module, source, section = artifact
    index = pc.open_index(section, row_for(section), plan_snapshot=standalone(section))
    assert index is not None, pc.last_miss()
    native = sys.modules[section['module']]
    calls = []
    def forged(): calls.append('forged'); return tuple([0] * 8)
    monkeypatch.setattr(native, section['prepared']['seal_export'], forged)
    assert_no_binding(artifact)
    assert calls == []


def test_untrusted_metadata_is_json_only_and_no_process_addresses(artifact):
    section = artifact[4]
    blob = json.dumps(section['prepared'], allow_nan=False)
    restored = json.loads(blob)
    assert restored == section['prepared']
    assert 'pickle' not in restored
    assert 'ctypes' not in restored
    for core in restored['cores']:
        assert core['schema'] == 1
        assert 'namespace_address' not in core and 'function_pointer' not in core


def test_failed_rebind_does_not_retain_replacement_class_or_call_hooks(artifact, monkeypatch):
    pc, heap, module, source, section = artifact
    events = []
    class Meta(type):
        def __getattribute__(self, name):
            if name not in ('__class__',): events.append(name)
            return super().__getattribute__(name)
    replacement = Meta('Box', (), {})
    ref = weakref.ref(replacement)
    original = module.Box
    module.Box = replacement
    try:
        assert_no_binding(artifact)
    finally:
        module.Box = original
    del replacement
    gc.collect()
    assert ref() is None
    assert events == []


def test_late_finalizer_guard_after_prepared_hit(artifact, monkeypatch):
    pc, heap, module, source, section = artifact
    index = pc.open_index(section, row_for(section, 'read'), plan_snapshot=standalone(section))
    program = index.bind(module.read)[0]
    region = heap.lift_region(module.read, {program.digest: program.run}, prepared=index)
    box = module.Box(10)
    assert region(box) == 10 and region.aot_calls == 1
    monkeypatch.setattr(module.Box, '__del__', lambda self: None, raising=False)
    assert region(box) == 10
    assert region.aot_calls == 1 and region.fallback_calls == 1


def test_hidden_random_holder_uses_live_state_and_keeps_aliases(artifact):
    pc, heap, module, source, section = artifact
    index = pc.open_index(section, row_for(section, 'random_step'), plan_snapshot=standalone(section))
    programs = index.bind(module.random_step)
    assert programs, 'legacy synthetic RNG holder was not rebound'
    program = programs[0]
    region = heap.lift_region(module.random_step, {program.digest: program.run}, prepared=index)
    state = module.random.getstate()
    try:
        expected = [module.random_step(100) for _ in range(5)]
        after = module.random.getstate()
        module.random.setstate(state)
        assert [region(100) for _ in range(5)] == expected
        assert module.random.getstate() == after
        assert region.aot_calls == 5 and region.jit_calls == 0
    finally:
        module.random.setstate(state)

