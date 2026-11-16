"""DESIGN 20 adversarial additions; prepared statically, never run by the author.

Positive cases use real native artifacts and the actual saved runner. Descriptor
forgeries preserve the schema and recompute every JSON-side content reference.
"""
from copy import deepcopy
import gc
import json
import sys
from types import BuiltinFunctionType, FunctionType
import weakref

import pytest

from test_prepared_cache import (SOURCE, artifact, load_source, row_for, standalone)


def _guard_kind(guard):
    return guard[0] if type(guard) is list else guard['kind']


def _replace_scalar(kind, before, after):
    if type(kind) is str:
        return (after, 1) if kind == before else (kind, 0)
    if type(kind) is list:
        result, count = [], 0
        for item in kind:
            value, changed = _replace_scalar(item, before, after)
            result.append(value)
            count += changed
        return result, count
    if type(kind) is dict:
        result, count = {}, 0
        for name, item in kind.items():
            value, changed = _replace_scalar(item, before, after)
            result[name] = value
            count += changed
        return result, count
    return kind, 0


def _forged_section(pc, original, mutation):
    section = deepcopy(original)
    prepared = section['prepared']
    cores = prepared['cores']
    old_ids = [pc.core_id(core) for core in cores]
    core = next(core for core in cores if core['variant'] == 'legacy'
                and core['entry_id']['qualname'].split('.')[-1] == 'work')
    execution = core['execution']
    if mutation == 'written':
        assert execution['written'], 'fixture must really write an input field'
        execution['written'] = []
    elif mutation == 'return-conversion':
        entry = execution['functions'][execution['entry_function']]
        # Both tags have the same int64 machine representation; only Python
        # result conversion changes. No ill-typed sentinel or width mismatch.
        entry['ret'], changed = _replace_scalar(entry['ret'], 'i', 'I')
        assert changed, 'fixture must expose an integer return component'
    elif mutation == 'guard-deletion':
        guards = execution['guards']
        index = next(i for i, guard in enumerate(guards) if _guard_kind(guard) == 'const')
        del guards[index]
    elif mutation == 'cell-mutation':
        cell = next(cell for cell in execution['cells'] if cell['mutated'] is True)
        cell['mutated'] = False
    else:
        raise AssertionError(mutation)
    # This assertion distinguishes a native seal test from a parser/type test.
    for candidate in cores:
        assert pc.validate_core(candidate) is None
    new_ids = [pc.core_id(candidate) for candidate in cores]
    references = dict(zip(old_ids, new_ids))
    assert old_ids != new_ids
    for row in section['functions']:
        row['prepared'] = [references[old_id] for old_id in row['prepared']]
    outer = deepcopy(prepared['artifact'])
    manifest = deepcopy(prepared['manifest'])
    manifest['functions'] = deepcopy(section['functions'])
    section['prepared'] = {**prepared, **pc.bundle(cores, manifest, prepared['build_key']), 'artifact': outer}
    assert section['prepared']['bundle_seal'] != original['prepared']['bundle_seal']
    assert section['prepared']['artifact'] == original['prepared']['artifact']
    assert section['module'] == original['module']
    assert all(record_id in new_ids for row in section['functions'] for record_id in row['prepared'])
    return section


@pytest.mark.parametrize('mutation', ['written', 'return-conversion', 'guard-deletion', 'cell-mutation'])
def test_well_typed_forgery_with_all_json_hashes_updated_still_fails_native_seal(artifact, mutation):
    pc, heap, module, source, original = artifact
    # Establish this artifact really binds before forging anything.
    index = pc.open_index(original, row_for(original), plan_snapshot=standalone(original))
    assert index is not None and index.bind(module.work)
    section = _forged_section(pc, original, mutation)
    # Read the real compiled metadata function, not a Python stand-in. Its full
    # constant seal remains the original even after every JSON hash was updated.
    native = sys.modules[original['module']]
    metadata = vars(native)[original['prepared']['seal_export']]
    assert type(metadata) is BuiltinFunctionType
    actual = metadata()
    words = lambda seal: tuple(int(seal[i:i + 8], 16) for i in range(0, 64, 8))
    assert type(actual) is tuple and len(actual) == 8
    assert all(type(word) is int and 0 <= word <= 0xffffffff for word in actual)
    assert actual == words(original['prepared']['bundle_seal'])
    assert actual != words(section['prepared']['bundle_seal'])
    index = pc.open_index(section, row_for(section), plan_snapshot=standalone(section))
    assert index is None or index.bind(module.work) == []
    assert pc.last_miss()['reason'] == 'seal', pc.last_miss()


@pytest.fixture(scope='module')
def runner_artifact(tmp_path_factory):
    """Freeze the actual complete runner input, including non-plan selection rows."""
    from recompyler import _prepared as pc, heap, profiler
    folder = tmp_path_factory.mktemp('prepared-runner-adversarial')
    source = folder / 'workload.py'
    source.write_text(SOURCE + '''
if __name__ == '__main__':
    print(work(Box(10), [])[2])
    print(helper(3))
''', encoding='utf-8')
    module = load_source(source)
    entries, rows = [], []
    for fn, args in ((module.work, (module.Box(10), [])), (module.helper, (3,))):
        region = heap.lift_region(fn)
        region(*args)
        assert region.compiled_calls == 1, region.problem
        entries.append(((fn.__name__, fn.__code__.co_firstlineno), fn, region))
        rows.append(dict(file=str(source), function=fn.__name__, line=fn.__code__.co_firstlineno,
                         calls=1, candidate=dict(status='verified', recommended=True, engine='region',
                         net_s_cached=1.0, python_us_per_call=10.0, batch_backends={})))
    report = dict(script=str(source), functions=rows, mode='saved', force=False)
    calls, startup_modes, before = [], [], []
    def plan_factory(preview):
        calls.append(True)
        report['plan'] = profiler.run_plan([row['candidate'] for row in rows], None, preview)
        before.append(deepcopy(report))
        return report
    with pytest.MonkeyPatch.context() as patch:
        def startup(ahead_of_time=False):
            startup_modes.append(ahead_of_time)
            return 0.01
        patch.setattr(profiler, 'process_startup', startup)
        section = heap.build_regions(entries, folder, plan_factory=plan_factory)
    assert section and section.get('prepared')
    assert len(calls) == 1 and startup_modes == [True]
    assert report['plan']['startup_s'] == 0.01
    assert report['plan']['saving_s'] == 2.0 and report['plan']['worth_running'] is True
    # Artifact attachment changes only the versioned derived projection.
    assert pc.plan_key(before[0]) == pc.plan_key(report)
    assert report['plan']['aot_regions'] == section
    plan_file = folder / 'plan.json'
    plan_file.write_text(json.dumps(report, allow_nan=False), encoding='utf-8')
    return pc, heap, module, source, section, report, plan_file


def test_complete_runner_snapshot_really_binds_before_plan_mutation(runner_artifact):
    pc, heap, module, source, section, report, plan_file = runner_artifact
    index = pc.open_index(section, row_for(section), plan_snapshot=report)
    assert index is not None and index.bind(module.work)


@pytest.mark.parametrize('field,value', [
    ('recommended', False), ('status', 'declined'), ('engine', 'lift'),
    ('batch_backends', {'cpu': 1.25}), ('batch_size', 16),
    ('future_selection_option', {'enabled': True}),
])
def test_top_level_candidate_edits_invalidate_unchanged_plan(runner_artifact, field, value):
    pc, heap, module, source, section, report, plan_file = runner_artifact
    changed = deepcopy(report)
    changed['functions'][0]['candidate'][field] = value
    assert changed['plan'] == report['plan'], 'only the top-level candidate changed'
    assert pc.plan_key(changed) != pc.plan_key(report)
    index = pc.open_index(section, row_for(section), plan_snapshot=changed)
    assert index is None or index.bind(module.work) == []
    assert pc.last_miss()['reason'] == 'plan'


@pytest.mark.parametrize('field,value', [('calls', 99), ('line', 999), ('file', 'different.py')])
def test_top_level_function_controls_invalidate_unchanged_plan(runner_artifact, field, value):
    pc, heap, module, source, section, report, plan_file = runner_artifact
    changed = deepcopy(report)
    changed['functions'][0][field] = value
    assert changed['plan'] == report['plan']
    assert pc.plan_key(changed) != pc.plan_key(report)
    index = pc.open_index(section, row_for(section), plan_snapshot=changed)
    assert index is None or index.bind(module.work) == []
    assert pc.last_miss()['reason'] == 'plan'


def _real_saved_run(runner_artifact, monkeypatch, capsys):
    pc, heap, module, source, section, report, plan_file = runner_artifact
    from recompyler.runner import run_script
    regions = {}
    original = heap.lift_region
    def capture(fn, *args, **kwargs):
        region = original(fn, *args, **kwargs)
        regions[fn.__name__] = region
        return region
    monkeypatch.setattr(heap, 'lift_region', capture)
    def forbidden(*args, **kwargs):
        raise AssertionError(('saved wrapper test unexpectedly regenerated code', pc.last_miss(), {n:r.prepared_reasons for n,r in regions.items()}))
    monkeypatch.setattr(heap.Region, '_make_program', forbidden)
    monkeypatch.setattr(heap, '_seed', forbidden)
    result = run_script(source, [], plan_file, False)
    assert capsys.readouterr().out == '18\n4\n'
    assert result['exit_code'] in (None, 0) and result['not_found'] == []
    assert {row['function'] for row in result['functions']} == {'work', 'helper'}
    assert all(row['aot_calls'] == row['compiled_calls'] == 1
               and row['jit_calls'] == row['fallback_calls'] == 0 for row in result['functions']), (result, {n: r.prepared_reasons for n,r in regions.items()}, pc.last_miss())
    assert set(regions) == {'work', 'helper'}
    assert all(region.prepared_hits == 1 for region in regions.values())
    work = regions['work']
    wrapper = work.original.__globals__['helper']
    assert type(wrapper) is FunctionType
    assert wrapper is not module.helper
    assert wrapper.__dict__['__recompyler_original__'].__name__ == 'helper'
    return work, wrapper


def test_plain_profile_binding_to_actual_runner_wrapper_is_a_prepared_hit(runner_artifact, monkeypatch, capsys):
    work, wrapper = _real_saved_run(runner_artifact, monkeypatch, capsys)
    assert work.aot_calls == 1 and work.jit_calls == work.fallback_calls == 0


def _cell(wrapper, name):
    return dict(zip(wrapper.__code__.co_freevars, wrapper.__closure__))[name]


@pytest.mark.parametrize('mutation', ['forged-marker', 'changed-code', 'changed-marker',
                                    'changed-fn-cell', 'changed-prepare-cell', 'changed-lifted-state'])
def test_wrapper_mutation_after_hit_invalidates_before_native(runner_artifact, monkeypatch, capsys, mutation):
    work, wrapper = _real_saved_run(runner_artifact, monkeypatch, capsys)
    globals_ = work.original.__globals__
    expected = 18
    def replacement(*args, **kwargs):
        return 999
    if mutation == 'forged-marker':
        replacement.__recompyler_original__ = wrapper.__dict__['__recompyler_original__']
        replacement.__wrapped__ = replacement.__recompyler_original__
        monkeypatch.setitem(globals_, 'helper', replacement)
        expected = 1013
    elif mutation == 'changed-code':
        monkeypatch.setattr(wrapper, '__code__', wrapper.__code__.replace(
            co_consts=wrapper.__code__.co_consts + ('different code object',)))
    elif mutation == 'changed-marker':
        monkeypatch.setitem(wrapper.__dict__, '__recompyler_original__', replacement)
    elif mutation == 'changed-fn-cell':
        monkeypatch.setattr(_cell(wrapper, 'fn'), 'cell_contents', replacement)
    elif mutation == 'changed-prepare-cell':
        monkeypatch.setattr(_cell(wrapper, 'prepare'), 'cell_contents', replacement)
    elif mutation == 'changed-lifted-state':
        state = _cell(wrapper, 'state').cell_contents
        assert type(state) is dict
        monkeypatch.setitem(state, 'lifted', replacement)
        expected = 1013
    before = work.aot_calls
    box = globals_['Box'](10)
    result = work(box, [])
    assert result[2] == expected
    assert work.aot_calls == before and work.fallback_calls == 1


def test_trusted_wrapper_registry_does_not_pin_finished_runner_graph(runner_artifact, monkeypatch, capsys):
    work, wrapper = _real_saved_run(runner_artifact, monkeypatch, capsys)
    work_ref, wrapper_ref = weakref.ref(work), weakref.ref(wrapper)
    class_ref = weakref.ref(work.original.__globals__['Box'])
    # Undo the capture function too: its local regions dictionary is deliberately
    # a test observer and must not manufacture the leak being tested.
    monkeypatch.undo()
    del work, wrapper
    gc.collect()
    assert work_ref() is None and wrapper_ref() is None and class_ref() is None
