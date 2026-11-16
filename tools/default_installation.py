"""Explicit training for replayable benchmarks using the canonical frameless API.

The supplied measure callback owns TIMING.lock and measures one checked workload.
This module never captures arguments, emits native code, or reuses timings for a
new body. Ordinary application calls must not be replayed through this tool.
"""
import math
import random
from statistics import median
from types import FunctionType
import weakref
from time import perf_counter


class Selection:
    def __init__(self):
        self.candidates=[]
        self._report={'rows':[], 'installed_default':0}

    @property
    def report(self):
        self._report['installed_default']=sum(bool(c.active) for c in self.candidates)
        return dict(self._report)

    def close(self):
        for candidate in reversed(self.candidates): candidate.close()
        self.candidates.clear()

    def __enter__(self): return self
    def __exit__(self,*unused): self.close()


def _positive(value):
    return type(value) in (int,float) and math.isfinite(value) and value>0


def _upper_ratio(python,native):
    ratios=[n/p for p,n in zip(python,native)]
    rng=random.Random(94)
    estimates=sorted(median(rng.choices(ratios,k=len(ratios))) for _ in range(2000))
    return estimates[1950]


def payback_bound(*, self_seconds, profile_runs, expected_runs, compile_seconds):
    """Reject hopeless compilation using the optimistic removal of all self time.

    Passing this bound is only permission to measure a candidate offline. Actual
    speed, output and artifact checks still decide whether it can be installed.
    """
    if (type(self_seconds) not in (int,float) or not math.isfinite(self_seconds) or self_seconds < 0
        or type(profile_runs) is not int or profile_runs < 1
        or type(expected_runs) is not int or expected_runs < 0 or not _positive(compile_seconds)):
        raise ValueError('finite self time, positive profile runs/cost and nonnegative future runs required')
    try: saved = self_seconds * expected_runs / profile_runs
    except OverflowError: raise ValueError('finite projected saving required') from None
    if not math.isfinite(saved): raise ValueError('finite projected saving required')
    return dict(eligible=saved > compile_seconds, projected_saved_seconds=saved,
                compile_seconds=float(compile_seconds), expected_runs=expected_runs,
                profile_runs=profile_runs, profile_self_seconds=float(self_seconds))


def select_workload(*,run,functions,measure,digest,prepare=None,minimum_calls=100,pairs=5,publish=None,compile_admission=None,expected_runs=None):
    """Select hot, exercised winners in this process; return a closable session.

    functions contains (function or weakref, profiled call count) pairs, with an
    optional third weak reference to the exact profiled code object. No
    benchmark arguments are retained. Every candidate is timed independently,
    then the combined set is checked against the original complete output.
    A wrong output or measurement failure restores every touched entry and raises.
    """
    if type(minimum_calls) is not int or minimum_calls<1: raise ValueError('positive hotness threshold required')
    if type(pairs) is not int or pairs<3: raise ValueError('at least three alternating pairs required')
    if expected_runs is not None and (type(expected_runs) is not int or expected_runs < 0):
        raise ValueError('nonnegative future workload runs required')
    if prepare is None:
        from recompyler.ir.frameless import prepare_frameless
        prepare=prepare_frameless
    references=[]
    for item in functions:
        reference,calls=item[:2]
        function=reference() if isinstance(reference,weakref.ReferenceType) else reference
        if type(function) is not FunctionType: continue
        if type(calls) is not int or calls<0: raise ValueError('nonnegative integer call count required')
        profiled_code=item[2] if len(item)==3 else weakref.ref(function.__code__)
        if not isinstance(profiled_code,weakref.ReferenceType):raise TypeError('weak profiled code reference required')
        references.append((weakref.ref(function),profiled_code,calls,
                           function.__module__+'.'+function.__qualname__))
    del functions
    function=None;reference=None;item=None
    expected=digest(run())
    def checked_run():
        value=run()
        if digest(value)!=expected: raise AssertionError('native workload output differs from Python')
        return value
    def current(reference,code):
        function=reference()
        return function is not None and function.__code__ is code()
    selection=Selection();touched=[];winners=[]
    try:
        for reference,code,calls,name in references:
            row={'function':name,'calls':calls,'status':'cold'}
            selection._report['rows'].append(row)
            if calls<minimum_calls: continue
            if not current(reference,code): row['status']='changed';continue
            if compile_admission is not None:
                decision=compile_admission(reference(),calls)
                row['compile_cost_bound']=decision
                if not decision['eligible']: row['status']='compile-cost-not-repaid';continue
                if not current(reference,code): row['status']='changed';continue
            counted=prepare(reference(),counted=True)
            if counted is None: row['status']='declined';continue
            touched.append(counted)
            counted.install()
            if not counted.active:
                counted.close();row['status']='inactive';continue
            checked_run()
            hits=counted.native_calls
            counted.close();row['native_hits']=hits
            if not hits: row['status']='not-exercised';continue
            if not current(reference,code): row['status']='changed';continue
            started=perf_counter()
            candidate=prepare(reference(),counted=False)
            row['compile_seconds']=perf_counter()-started
            if candidate is None: row['status']='declined';continue
            touched.append(candidate)
            address=candidate.body_address
            python=[];native=[];valid=True
            for pair in range(pairs):
                for mode in (('python','native') if pair%2==0 else ('native','python')):
                    candidate.close()
                    if not current(reference,code): valid=False;break
                    if mode=='native':
                        candidate.install()
                        if not candidate.active: valid=False;break
                    elapsed=measure(checked_run)
                    if not _positive(elapsed): raise ValueError('positive finite measured time required')
                    if mode=='native' and not candidate.active: valid=False;break
                    (python if mode=='python' else native).append(float(elapsed))
                    if candidate.body_address!=address or not current(reference,code): valid=False;break
                if not valid: break
            candidate.close()
            if not valid: row['status']='changed-or-inactive';continue
            row.update(python_seconds=python,native_seconds=native,
                       ratio=median(native)/median(python),ratio_ci_high=_upper_ratio(python,native))
            if row['ratio']>=1: row['status']='slower';continue
            if row['ratio_ci_high']>=1: row['status']='unresolved';continue
            if expected_runs is not None:
                row['projected_saved_seconds']=(median(python)-median(native))*expected_runs
                if row['projected_saved_seconds']<=row['compile_seconds']:
                    row['status']='compile-cost-not-repaid';continue
            row['status']='selected'
            winners.append((candidate,reference,code,row))
        for candidate,reference,code,row in winners:
            if not current(reference,code): row['status']='changed';continue
            candidate.install()
            if candidate.active: selection.candidates.append(candidate)
            else: row['status']='inactive'
        checked_run()
        # Observation or source changes during the combined check can retire a
        # winner. Count only live ordinary handles, never preparation attempts.
        for candidate,reference,code,row in winners:
            if row['status']=='selected' and not candidate.active: row['status']='inactive'
        if publish is not None:
            for candidate,reference,code,row in winners:
                if row['status']=='selected' and candidate.active:
                    function=reference()
                    if function is None or function.__code__ is not code():
                        candidate.close();row['status']='changed';continue
                    publish(function,candidate,row)
                    function=None
        return selection
    except BaseException:
        for candidate in reversed(touched): candidate.close()
        selection.close()
        raise


def workload_timer(lock,run_name,*,minimum_seconds=0.03):
    """Fixed-work alternating samples; every observation needs the exact lock."""
    from pathlib import Path
    from time import perf_counter
    lock=Path(lock)
    if type(minimum_seconds) not in (int,float) or not math.isfinite(minimum_seconds) or minimum_seconds<0:
        raise ValueError('finite nonnegative batch duration required')
    count=None
    def require_lock():
        try: owner=(lock/'owner.txt').read_text().splitlines()[0]
        except (OSError,IndexError): owner=None
        if owner!=run_name: raise RuntimeError('selector timing requires this run timing lock')
    def measure(run):
        nonlocal count
        require_lock()
        calls=count or 1
        while True:
            start=perf_counter()
            for _ in range(calls): run()
            elapsed=perf_counter()-start
            if count is not None or elapsed>=minimum_seconds:break
            calls*=2
        require_lock()
        count=calls
        return elapsed/calls
    return measure


def select_profiled_workload(run,package,*,lock,run_name='wave18-lift',repeats=64,pairs=5,
                             minimum_calls=100,include_driver=False,prepare=None,expected_runs=64,
                             compile_estimate_seconds=.1,bytecode_limit=512):
    """Explicit TRAIN fixture replay, never an automatic replay of application calls."""
    from bench.libs.diagnose import collect_calls,public_row
    canonical=prepare is None
    if canonical:prepare=canonical_prepare
    from bench.libs.workloads import output_digest
    if type(repeats) is not int or repeats<1:raise ValueError('positive profile repeats required')
    if type(expected_runs) is not int or expected_runs<0:raise ValueError('nonnegative future runs required')
    if not _positive(compile_estimate_seconds):raise ValueError('positive compile estimate required')
    if type(bytecode_limit) is not int or bytecode_limit<1:raise ValueError('positive T2 bytecode limit required')
    from pathlib import Path
    import dis
    owner=Path(lock)/'owner.txt'
    def require_lock():
        if owner.read_text().splitlines()[0]!=run_name:raise RuntimeError('offline profile requires this run timing lock')
    require_lock()
    expected=output_digest(run());observed={}
    for _ in range(repeats):
        value,rows=collect_calls(run,package,include_driver=include_driver,clock=perf_counter)
        if output_digest(value)!=expected:raise AssertionError('profile workload output changed')
        for row in rows:
            key=(row['function_id'],row['code_id'])
            prior=observed.get(key)
            if prior is not None and prior['function']() is row['function']() and prior['code']() is row['code']():
                prior['calls']+=row['calls']
                prior['self_seconds']+=row['self_seconds']
            else:observed[key]=dict(row)
    require_lock()
    functions=[(row['function'],row['calls'],row['code']) for row in sorted(observed.values(),key=lambda row:-row['calls'])]
    def admit(function,calls):
        profile=observed[(id(function),id(function.__code__))]
        result=payback_bound(self_seconds=profile['self_seconds'],profile_runs=repeats,
            expected_runs=expected_runs,compile_seconds=compile_estimate_seconds)
        result.update(tier='T2',bytecodes=sum(1 for _ in dis.get_instructions(function)),bytecode_limit=bytecode_limit)
        if result['bytecodes']>bytecode_limit:result.update(eligible=False,reason='T2 size budget exceeded')
        return result
    selected=select_workload(run=run,functions=functions,prepare=prepare,
        measure=workload_timer(lock,run_name),digest=output_digest,minimum_calls=minimum_calls,pairs=pairs,
        publish=publish_canonical_measurement if canonical else None,compile_admission=admit,expected_runs=expected_runs)
    selected._report.update(profile_repeats=repeats,expected_future_runs=expected_runs,tier='offline-T2',
        compile_estimate_seconds=compile_estimate_seconds,profile=[public_row(row) for row in observed.values()])
    return selected


def canonical_prepare(function,*,counted=False):
    """Time the same ordinary candidate retained by the public compiler policy."""
    from recompyler.ir.frameless import prepare_frameless
    if counted:return prepare_frameless(function,counted=True)
    from recompyler.ir import compile_function,compilation_info
    from recompyler.ir.compiler import _frameless_candidates
    compile_function(function,strict=True)
    candidate=_frameless_candidates.get(function)
    info=compilation_info(function)
    if (candidate is None or info is None or not candidate.source_matches(function)
        or candidate.counted or info['deployment_body_address']!=candidate.body_address):return None
    return candidate


def publish_canonical_measurement(function,candidate,row):
    """Publish only this measured ordinary body; never transfer a receipt."""
    from recompyler.ir import compilation_info
    from recompyler.ir.compiler import _frameless_candidates,_record_measurement
    if candidate.counted or not candidate.source_matches(function) or _frameless_candidates.get(function) is not candidate:
        raise ValueError('measured candidate source or owner changed')
    info=compilation_info(function)
    if info is None or info['deployment_body_address']!=candidate.body_address:
        raise ValueError('measured body is no longer the canonical deployment candidate')
    _record_measurement(function,median(row['python_seconds'])*1e9,median(row['native_seconds'])*1e9)
    # Exercise public default deployment using this same measured owner.
    candidate.close()
    from recompyler.ir import compile_function
    compile_function(function,strict=True)
    if not candidate.active: raise RuntimeError('verified default candidate did not install')
