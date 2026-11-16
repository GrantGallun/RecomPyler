import math
import os
import pytest


def test_manifest_separates_training_and_heldout():
    from bench.libs.programs import manifest
    train, held = manifest('train'), manifest('heldout')
    assert len(train) == 19
    assert len(held) >= 3
    assert not set(train) & set(held)
    assert 'selfcompile' in train
    with pytest.raises(ValueError): manifest('all')


def test_bootstrap_and_geomean_reject_incomplete_or_wrong_results():
    from bench.libs.shared_harness import interval, headline
    assert interval([2, 2, 2]) == {'median': 2, 'low': 2, 'high': 2, 'n': 3}
    def row(name, speed):
        return dict(name=name, status='ok', samples=[dict(cpython_off={'seconds': speed, 'digest': 'x'},
            cpython_on={'seconds': speed/2, 'digest': 'x'}, recompyler={'seconds': 1, 'digest': 'x', 'installed': 0})]*3)
    report = headline([row('a', 4), row('b', 1)], ['a', 'b'])
    assert report['cpython_off']['median'] == 2
    assert report['cpython_on']['median'] == 1
    assert report['installed_default'] == 0
    assert headline([row('a',4)], ['a','b'])['status'] == 'incomplete'
    bad = row('a', 4)
    bad['samples'][0]['recompyler']['digest'] = 'wrong'
    with pytest.raises(ValueError, match='digest'): headline([bad], ['a'])
    with pytest.raises(ValueError): interval([float('nan')])


def test_fresh_worker_checks_jit_and_runs_fixed_repetitions():
    from bench.libs.shared_harness import observe
    off = observe('json_encode', 'cpython_off', repeats=2)
    on = observe('json_encode', 'cpython_on', repeats=2)
    assert off['pid'] != on['pid'] != os.getpid()
    assert off['digest'] == on['digest']
    assert off['jit'] is False and on['jit'] is True
    assert off['seconds'] >= off['work_seconds'] > 0
    assert off['repeats'] == on['repeats'] == 2


def test_native_attribution_prefers_leaf_and_preserves_unknown():
    from bench.libs.attribution import classify, opportunities
    bodies = [{'start': 4096, 'size': 32, 'function': 'pkg:f'}]
    assert classify([{'name':'0x1001','address':4097}], bodies) == ('compiled_body','pkg:f')
    assert classify([{'name':'PyObject_Malloc'},{'name':'body','address':4097}], bodies)[0] == 'compiled_body'
    assert classify([{'name':'body','address':4097},{'name':'PyObject_Malloc'}], bodies)[0] == 'allocation_gc'
    assert classify([{'name':'mystery'}], bodies)[0] == 'unknown'
    rows=opportunities({'interpreter': 50, 'allocation_gc': 50}, {'interpreter': {'speedup':2,'source':'CPython JIT actual'}})
    assert rows[0]['recoverable_share'] == .25
    assert rows[0]['priority'] == 1
    assert rows[1]['speedup'] is None


def test_speedscope_weights_and_instrumented_guard_counts():
    from bench.libs.attribution import summarize
    profile={'shared':{'frames':[{'name':'_PyEval_EvalFrameDefault'},{'name':'PyObject_Malloc'}]},
             'profiles':[{'type':'sampled','samples':[[0],[0,1]],'weights':[1,3]}]}
    result=summarize(profile, [])
    assert result['counts'] == {'interpreter':1,'allocation_gc':3}
    from bench.libs.redundancy import Counters
    from llvmlite import ir, binding
    import ctypes
    binding.initialize_native_target(); binding.initialize_native_asmprinter()
    def witness(x): return x
    counters=Counters(witness.__code__)
    module=ir.Module(); module.triple=binding.get_default_triple()
    fn=ir.Function(module,ir.FunctionType(ir.IntType(64),[ir.IntType(64)]),'witness')
    builder=ir.IRBuilder(fn.append_basic_block('entry'))
    condition=builder.icmp_signed('>',fn.args[0],ir.Constant(ir.IntType(64),0))
    counters.emit(builder, 'guard', 1, condition)
    counters.emit(builder, 'refcount', 1)
    builder.ret(fn.args[0])
    native=binding.parse_assembly(str(module));native.verify()
    engine=binding.create_mcjit_compiler(native,binding.Target.from_default_triple().create_target_machine())
    engine.finalize_object()
    call=ctypes.CFUNCTYPE(ctypes.c_int64,ctypes.c_int64)(engine.get_function_address('witness'))
    assert [call(i) for i in [-2,0,4]] == [-2,0,4]
    rows=counters.rows()
    guard=next(r for r in rows if r['kind']=='guard')
    assert guard['executed']==3 and guard['taken']==1 and not guard['never_failed']
    assert next(r for r in rows if r['kind']=='refcount')['executed']==3



def test_pypy_mismatch_is_visible_without_invalidating_exact_cpython_result():
    from bench.libs.shared_harness import validate_samples
    sample={engine:dict(status='ok',digest='exact',seconds=1,installed=0) for engine in
            ('cpython_off','cpython_on','recompyler','pypy')}
    sample['pypy']['digest']='other-version-float-sum'
    assert validate_samples([sample]) is True
    assert sample['pypy']['status']=='different-output'
    sample['recompyler']['digest']='wrong'
    assert validate_samples([sample]) is False


def test_instrumentation_counts_actual_generic_lowerer_execution():
    from bench.libs.redundancy import instrument
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    from recompyler.ir.entry import create_callable
    from recompyler import _source_frames_native as frames
    def add(x,y): return x+y
    with instrument(add.__code__) as counts: body=lower(build(add))
    entry=create_callable(add,body.body_address,(body,counts),runner_address=frames.addresses()['run_vectorcall'])
    assert entry(2,3)==5
    rows=counts.rows()
    assert sum(row['executed'] for row in rows if row['detail']=='PyNumber_Add')==1
    assert any(row['kind']=='guard' and row['executed'] for row in rows)


def test_resume_rejects_changed_source_or_split_and_counts_only_comparable_pypy():
    from bench.libs.shared_harness import resume_rows,headline
    report={'split':'train','source_sha256':'before','rows':[]}
    with pytest.raises(ValueError,match='source'): resume_rows(report,'train','after')
    with pytest.raises(ValueError,match='split'): resume_rows(report,'heldout','before')
    assert resume_rows(report,'train','before')==[]
    sample={e:dict(status='ok',digest='x',seconds=1,installed=0) for e in ('cpython_off','cpython_on','recompyler')}
    sample['pypy']=dict(status='ok',digest='wrong',seconds=.1)
    result=headline([dict(name='a',status='ok',samples=[sample]*3)],['a'])
    assert 'pypy' not in result


def test_refcount_no_effect_is_observed_and_source_code_is_not_retained():
    from bench.libs.redundancy import Counters
    import weakref,gc
    namespace={};exec('def temporary(): return 42',namespace)
    code=namespace.pop('temporary').__code__;ref=weakref.ref(code)
    counters=Counters(code)
    del code;gc.collect()
    assert ref() is None


def test_python_leaf_and_positive_install_counts_are_not_misreported():
    from bench.libs.attribution import classify
    from bench.libs.shared_harness import headline
    assert classify([{'name':'_PyEval_EvalFrameDefault'},{'name':'run','file':'program.py','line':1}],[])==('interpreter',None)
    rows=[]
    for name,ids in [('a',['p:f','p:g']),('b',['p:g','p:h','p:i'])]:
        sample={e:dict(status='ok',digest='x',seconds=1,installed=0) for e in ('cpython_off','cpython_on','recompyler')}
        sample['recompyler'].update(installed=len(ids),installed_ids=ids)
        rows.append(dict(name=name,status='ok',samples=[sample]*3))
    assert headline(rows,['a','b'])['installed_default']==4


def test_diagnostic_accepts_extended_manifest_and_does_not_crash_selfcompile(tmp_path):
    from bench.libs.redundancy_worker import run
    report=run('selfcompile',tmp_path/'report.json')
    assert report['status']=='not-installed'
    assert report['native_entries']==0


def test_profile_worker_exports_same_process_body_map(tmp_path):
    from bench.libs.shared_harness import observe
    from bench.libs.program_worker import installation_snapshot
    assert installation_snapshot(None)==(0,[])
    import json
    path=tmp_path/'map.json'
    row=observe('json_encode','recompyler',body_map=path)
    assert row['status']=='ok' and row['installed']==0
    assert json.loads(path.read_text())==[]


def test_tagged_refcount_helper_reports_observed_no_effect():
    from bench.libs.redundancy import instrument
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    from recompyler.ir.entry import create_callable
    from recompyler import _source_frames_native as frames
    def add(x,y): return x+y
    with instrument(add.__code__) as counts: body=lower(build(add),refcounts=False)
    entry=create_callable(add,body.body_address,(body,counts),runner_address=frames.addresses()['run_vectorcall'])
    assert entry(2,3)==5
    assert any(r['kind']=='refcount' and r['never_mattered'] is True for r in counts.rows())


def test_native_sampler_success_cannot_mask_workload_unavailability():
    from bench.libs.profile_programs import workload_result
    assert workload_result('py-spy sampling\n{"status":"unavailable","reason":"package missing"}\npy-spy wrote file')['status']=='unavailable'
    assert workload_result('py-spy wrote a profile without a child result')['status']=='error'


def test_entry_counters_use_function_line_not_last_validated_instruction():
    from bench.libs.redundancy import instrument
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    def target(x,y):
        return x+y
    with instrument(target.__code__) as counters: lower(build(target))
    call=next(r for r in counters.rows() if r['detail']=='PyThreadState_Get')
    assert call['line']==target.__code__.co_firstlineno


def test_selfcompile_fixture_covers_the_ir_frontend_lowerer_and_entry():
    from bench.libs.programs import selfcompile_targets
    targets=selfcompile_targets()
    identities={fn.__module__+':'+fn.__qualname__ for fn in targets}
    assert {'recompyler.ir.compiler:compile_function','recompyler.ir.builder:build','recompyler.ir.lower_llvm:lower'}<=identities
    assert all(fn.__module__ in ('recompyler.ir.compiler','recompyler.ir.builder','recompyler.ir.lower_llvm') for fn in targets)


def test_opportunity_priority_uses_requested_share_times_speedup():
    from bench.libs.attribution import opportunities
    rows=opportunities({'small':1,'large':5},{'small':{'speedup':10,'source':'spike'},'large':{'speedup':1.5,'source':'JIT'}})
    assert rows[0]['bucket']=='small'


def test_native_sampler_timeout_returns_a_failed_receipt():
    import sys
    from bench.libs.profile_programs import record
    result=record([sys.executable,'-c','import time;time.sleep(30)'],env=os.environ.copy(),timeout=.1)
    assert result.returncode==124


def test_shared_program_cohort_uses_callers_ledger_and_native_worker(tmp_path, monkeypatch):
    from contextlib import contextmanager
    from bench.libs import shared_harness as harness, timing_runner
    locks=[];observations=[]
    @contextmanager
    def locked(lock, ledger, **options):
        locks.append((lock, ledger, options))
        yield
    def observe(name, engine, **options):
        observations.append((engine, options))
        return dict(status='ok', digest='exact', seconds=1, installed=0)
    monkeypatch.setattr(harness, 'timing_lock', locked)
    monkeypatch.setattr(harness, 'observe', observe)
    monkeypatch.setattr(timing_runner, 'test_processes', lambda: [])
    ledger=tmp_path/'own-ledger.md'
    row=harness.run_case('json_encode', pairs=3, run_name='wave17-matrix',
                         ledger=ledger, worker_module='bench.libs.selected_program_worker')
    assert row['status']=='ok'
    assert locks[0][1]==ledger and locks[0][2]['run_name']=='wave17-matrix'
    assert len(observations)==9
    for engine, options in observations:
        assert options['worker_module']==('bench.libs.selected_program_worker' if engine=='recompyler'
                                         else 'bench.libs.program_worker')


def test_resume_fingerprint_includes_selection_policy(tmp_path, monkeypatch):
    from bench.libs import shared_harness as harness
    (tmp_path/'src').mkdir()
    (tmp_path/'bench/libs').mkdir(parents=True)
    (tmp_path/'tools').mkdir()
    policy=tmp_path/'tools/default_installation.py'
    policy.write_text('selection_policy = 1\n')
    monkeypatch.setattr(harness, 'ROOT', tmp_path)
    before=harness.source_fingerprint()
    policy.write_text('selection_policy = 2\n')
    assert harness.source_fingerprint()!=before, 'changed selection policy reused an old speed receipt'


def test_shared_timing_lock_reports_the_callers_name(tmp_path):
    from bench.libs.runner import timing_lock
    lock=tmp_path/'TIMING.lock';ledger=tmp_path/'ledger.md'
    with timing_lock(lock, ledger, run_name='wave17-matrix', purpose='owner fixture'):
        assert (lock/'owner.txt').read_text().splitlines()[0]=='wave17-matrix'
    assert not lock.exists()
    assert 'acquire' in ledger.read_text() and 'release' in ledger.read_text()


def test_counter_sites_bind_code_pc_and_distinguish_same_line_guards():
    import dis,hashlib,marshal
    from bench.libs.redundancy import instrument
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    def add(x,y): return x+y
    binary_pc=next(i.offset for i in dis.get_instructions(add) if i.opname=='BINARY_OP')
    with instrument(add.__code__) as counters: lower(build(add))
    rows=counters.rows()
    expected=hashlib.sha256(marshal.dumps(add.__code__)).hexdigest()
    assert all(row['code_sha256']==expected for row in rows)
    assert len({row['site_index'] for row in rows})==len(rows)
    guards=[row for row in rows if row['kind']=='guard' and row['original_pc']==binary_pc]
    assert guards and all(row['predicate_llvm'] and row['proof_required'] for row in guards)
    assert all(row['graph_sha256'] is None for row in rows)


def test_native_package_dll_is_identified_without_inventing_internal_symbols():
    from bench.libs.attribution import classify
    dll='C:/Users/user/site-packages/llvmlite/binding/llvmlite.dll'
    assert classify([{'name':'0x1234','file':dll}],[])==('c_extensions',None)
    assert classify([{'name':'0x1234','file':'C:/Windows/System32/VCRUNTIME140.dll'}],[])==('unknown',None)
    assert classify([{'name':'0x1234','file':dll}],[dict(start=0x1234,size=1,function='body')])==('compiled_body','body')
