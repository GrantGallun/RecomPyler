"""IR self-host harness discovery, ordering and failure classification."""
import importlib.util
from pathlib import Path
import sys
from types import ModuleType


def tool():
    path = Path(__file__).parents[1] / 'tools/ir_self_host.py'
    spec = importlib.util.spec_from_file_location('ir_self_host_tool', path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def test_discovery_keeps_original_functions_and_all_descriptor_accessors():
    runner = tool()
    module = ModuleType('recompyler.fixture')
    exec('''
def identity(value): return value
class Host:
    @staticmethod
    def static(value): return value
    @classmethod
    def classed(cls, value): return value
    @property
    def value(self): return self.marker
    @value.setter
    def value(self, marker): self.marker = marker
''', module.__dict__)
    found = runner.live_functions([module])
    assert {fn.__qualname__ for fn in found} == {'identity', 'Host.static', 'Host.classed', 'Host.value'}
    assert len(found) == 5
    assert module.identity in found
    assert vars(module.Host)['value'].fset in found


def test_discovery_follows_live_wrappers_and_closure_functions_once():
    runner = tool()
    module = ModuleType('recompyler.fixture')
    exec('''
def factory():
    def original(value): return value
    def wrapper(value): return original(value)
    wrapper.__wrapped__ = original
    return wrapper
wrapped = factory()
alias = wrapped
''', module.__dict__)
    found = runner.live_functions([module])
    assert len(found) == 3
    assert module.wrapped.__wrapped__ in found


def test_prepares_all_before_installing_and_excludes_bootstrap():
    runner = tool()
    module = ModuleType('recompyler.fixture')
    exec('def first(x): return x\ndef second(x): return x', module.__dict__)
    events = []
    def prepare(fn): events.append(('prepare', fn.__name__))
    def install(fn): events.append(('install', fn.__name__)); return True
    report = runner.prepare_and_install([module.first, module.second], prepare, install,
                                       lambda fn: {'compiled': True, 'installed': True})
    assert events == [('prepare','first'), ('prepare','second'), ('install','first'), ('install','second')]
    assert report['ir_installed'] == 2
    assert runner.bootstrap_reason('recompyler.ir.compiler')
    assert runner.bootstrap_reason('recompyler.ir.entry')
    assert runner.bootstrap_reason('recompyler.ir.symbols')
    assert runner.bootstrap_reason('recompyler.heap') is None


def test_failed_install_is_reported_without_claiming_execution():
    runner = tool()
    module = ModuleType('recompyler.fixture')
    exec('def identity(x): return x', module.__dict__)
    report = runner.prepare_and_install([module.identity], lambda fn: None, lambda fn: False,
                                       lambda fn: {'compiled': True, 'installed': False})
    assert report['ir_prepared'] == 1 and report['ir_installed'] == 0
    assert report['unavailable'][0]['phase'] == 'install'
    assert not report['execution_verified']


def test_discovery_does_not_invoke_nonstring_class_module_descriptor():
    runner = tool()
    module = ModuleType('recompyler.fixture')
    module.Odd = type('Odd', (), {'__module__': property(lambda self: 1 / 0)})
    assert runner.live_functions([module]) == []


def test_fresh_actual_native_self_host_counter_and_exact_restoration():
    import os
    import subprocess
    root = Path(__file__).parents[1]
    environment = dict(os.environ, PYTHON_JIT='1', PYTHONPATH=str(root/'src'))
    result = subprocess.run([sys.executable, str(root/'tests/ir_self_host_cases.py')],
        cwd=root, env=environment, capture_output=True, text=True, timeout=120,
        creationflags=0x08004000 if os.name == 'nt' else 0)
    assert result.returncode == 0, (result.stdout, result.stderr)
    assert 'actual native entries=2' in result.stdout


def test_fresh_executed_native_entries_survive_cold_executor_sweeps():
    import os
    import subprocess
    root = Path(__file__).parents[1]
    environment = dict(os.environ, PYTHON_JIT='1', PYTHONPATH=str(root/'src'))
    result = subprocess.run([sys.executable, str(root/'tests/ir_self_host_cases.py'), 'cold'],
        cwd=root, env=environment, capture_output=True, text=True, timeout=120,
        creationflags=0x08004000 if os.name == 'nt' else 0)
    assert result.returncode == 0, (result.stdout, result.stderr)
    assert 'PASS native entries remain warm' in result.stdout


def test_fresh_prepared_body_can_reinstall_after_cold_eviction():
    import os
    import subprocess
    root = Path(__file__).parents[1]
    environment = dict(os.environ, PYTHON_JIT='1', PYTHONPATH=str(root/'src'))
    result = subprocess.run([sys.executable, str(root/'tests/ir_self_host_cases.py'), 'rearm'],
        cwd=root, env=environment, capture_output=True, text=True, timeout=120,
        creationflags=0x08004000 if os.name == 'nt' else 0)
    assert result.returncode == 0, (result.stdout, result.stderr)
    assert 'PASS cold native entry reinstalled' in result.stdout


def test_deferred_installation_waits_until_pytest_collection_finishes():
    runner = tool()
    module = ModuleType('recompyler.fixture')
    exec('def identity(x): return x', module.__dict__)
    events = []
    report = runner.prepare_and_install([module.identity], lambda fn: events.append('prepare'),
        lambda fn: events.append('install'), lambda fn: {'compiled': True, 'installed': False}, defer_install=True)
    assert events == ['prepare'] and report['ir_installed'] == 0
    plugin = runner.Results(Path('.'), activate=lambda: events.append('collection-finished'))
    plugin.pytest_collection_finish()
    assert events == ['prepare', 'collection-finished']


def test_candidate_refresh_runs_immediately_before_test_call():
    runner = tool()
    events = []
    plugin = runner.Results(Path('.'), refresh=lambda: events.append('refresh'))
    plugin.pytest_runtest_call(None)
    assert events == ['refresh']


def test_discovery_includes_root_package_functions():
    runner = tool()
    module = ModuleType('recompyler')
    exec('def identity(x): return x', module.__dict__)
    assert runner.live_functions([module]) == [module.identity]


def test_candidate_installer_preserves_canonical_seed_errors(monkeypatch):
    from types import SimpleNamespace
    from recompyler.ir import _entry_native, entry
    runner = tool()
    function = lambda value: value
    handle = object()
    owner = SimpleNamespace(body_address=123, entry_offset=0)
    monkeypatch.setattr(_entry_native, '_compilation_owner', lambda fn: (function.__code__, owner))
    monkeypatch.setattr(_entry_native, '_compilation_handle', lambda fn: handle)
    def seed(*args, **kwargs):
        assert args[:3] == (function, 123, owner)
        assert kwargs['expected_code'] is function.__code__
        assert kwargs['expected_prepared'] is handle
        raise TypeError("missing required keyword-only argument: 'required'")
    monkeypatch.setattr(entry, 'install_frame_entry', seed)
    import pytest
    with pytest.raises(TypeError, match='required keyword-only'):
        runner.install_candidate(function)


def test_counted_body_releases_codegen_tree_but_keeps_executable_code():
    import gc
    import weakref
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    runner = tool()
    lowered = lower(build(host_counter_identity), frame_entry=True)
    source_tree = weakref.ref(lowered.module)
    address = lowered.body_address
    counted = runner.CountedBody(lowered.execution_owner)
    del lowered
    gc.collect()
    assert source_tree() is None
    assert counted.original.engine.get_function_address('body') == address
    assert counted.body_address > 0


def host_counter_identity(value):
    return value


def test_memory_probe_does_not_change_shared_ctypes_signatures():
    import ctypes
    import os
    if os.name != 'nt': return
    runner = tool()
    current = ctypes.windll.kernel32.GetCurrentProcess
    original = current.restype
    assert runner.working_set_bytes() > 0
    assert current.restype is original


def test_refresh_retries_previously_installed_body_after_observer_seed_refusal():
    from types import SimpleNamespace
    runner = tool()
    function = lambda value: value
    handle = SimpleNamespace(function=function, active=False)
    outcomes = [RuntimeError('source activation requires unobserved interpreter'),
                ValueError('CPython declined frame entry seed'), True]
    calls = []
    def install(fn):
        calls.append(fn)
        outcome = outcomes.pop(0)
        if isinstance(outcome, Exception): raise outcome
        handle.active = True
        return outcome
    refresh = runner.CandidateRefresh({function:handle}, install, installed=[function])
    for _ in range(4): refresh()
    assert len(calls) == 3 and refresh.reinstallations == 1


def test_refresh_retains_permanent_first_seed_decline_without_resurrecting_invalid_body():
    from types import SimpleNamespace
    runner = tool()
    declined = lambda: None
    invalid = lambda: None
    attempts = []
    def install(fn):
        attempts.append(fn)
        raise ValueError('CPython declined frame entry seed')
    refresh = runner.CandidateRefresh({declined:SimpleNamespace(function=declined,active=False),
                                      invalid:SimpleNamespace(function=None,active=False)}, install)
    refresh(); refresh()
    assert attempts == [declined]


def test_refresh_does_not_cache_temporary_observation_for_uninstalled_candidate():
    from types import SimpleNamespace
    runner = tool()
    function = lambda: None
    attempts = []
    def install(fn):
        attempts.append(fn)
        if len(attempts) == 1: raise RuntimeError('source activation requires unobserved interpreter')
        return True
    refresh = runner.CandidateRefresh({function:SimpleNamespace(function=function,active=False)}, install)
    refresh(); refresh()
    assert attempts == [function,function] and refresh.reinstallations == 1


def test_matrix_failure_details_preserve_complete_literal_row():
    from types import SimpleNamespace
    runner = tool()
    row = {'id':'operator.bool.augmented11','verdict':'crash',
           'internal_errors':[{'exception':'RuntimeError','message':'literal seed cause'}]}
    frame = SimpleNamespace(f_locals={'row':row})
    trace = SimpleNamespace(path='tests/test_language_matrix.py',frame=frame,lineno=15)
    plugin = runner.Results(Path('.'))
    plugin.pytest_runtest_makereport(SimpleNamespace(nodeid='matrix'),
        SimpleNamespace(excinfo=SimpleNamespace(traceback=[trace],type=AssertionError),when='call'))
    assert plugin.details[('matrix','call')]['matrix_row'] == row


def test_fresh_observer_transitions_restore_native_coverage():
    import os
    import subprocess
    root = Path(__file__).parents[1]
    result = subprocess.run([sys.executable, str(root/'tests/ir_self_host_cases.py'), 'observer'],
        cwd=root, env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=120,
        creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode == 0, (result.stdout,result.stderr)
    assert 'PASS native entry recovered after trace and monitoring' in result.stdout


def test_fresh_native_monitor_activation_exits_cleanly():
    import os
    import subprocess
    root = Path(__file__).parents[1]
    result = subprocess.run([sys.executable,str(root/'tests/ir_monitor_shutdown_cases.py')],
        cwd=root,env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=45,
        creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(result.stdout,result.stderr)
    assert 'PASS actual monitoring activation native=4' in result.stdout


def test_fresh_selfhost_monitor_population_preserves_shutdown(tmp_path):
    import os
    import subprocess
    import json
    root=Path(__file__).parents[1]
    report=tmp_path/'monitor-shutdown.json'
    result=subprocess.run([sys.executable,str(root/'tools/ir_self_host.py'),
        '--label','monitor-shutdown-regression','--report',str(report),
        '--match','recompyler.monitor:','--timeout','60',
        'tests/test_language_matrix.py::test_construct_verdict[operator.bool.augmented11]'],
        cwd=root,env=dict(os.environ,PYTHONPATH=str(root/'src')),capture_output=True,
        text=True,timeout=120,creationflags=0x08004000 if os.name=='nt' else 0)
    details=json.loads(report.read_text()) if report.exists() else {}
    assert result.returncode==0,(result.stdout,result.stderr,details.get('status'))
    assert details['status']=='passed' and details['native_entries']>=4


def test_counter_batch_uses_one_engine_and_preserves_each_body_and_count(monkeypatch):
    import ctypes,gc
    from dataclasses import dataclass
    from llvmlite import binding
    runner=tool()
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    created=[];factory=binding.create_mcjit_compiler
    def create(*args,**kwargs):
        engine=factory(*args,**kwargs);created.append(engine)
        return engine
    monkeypatch.setattr(binding,'create_mcjit_compiler',create)
    pool=runner.CountedBodyPool()
    @dataclass
    class Owner:
        body_address:int
        module:object
        keepalive:tuple
        entry_offset:int=0
    signature=ctypes.CFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p,ctypes.c_void_p,ctypes.c_void_p)
    bodies=[]
    for offset in (1,2,3):
        callback=signature(lambda frame,stack,thread,offset=offset:thread+offset)
        owner=Owner(ctypes.cast(callback,ctypes.c_void_p).value,object(),(callback,))
        bodies.append(runner.CountedBody(owner,pool=pool))
    del pool
    gc.collect()
    for index,repeats in enumerate((2,1,3)):
        call=signature(bodies[index].body_address)
        for _ in range(repeats): assert call(None,None,0x100)==0x101+index
    assert [body.calls.value for body in bodies]==[2,1,3]
    assert all(body.original.module is None for body in bodies)
    assert len(created)==1
