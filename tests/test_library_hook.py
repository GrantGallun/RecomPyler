"""Import delivery preserves Python imports and rejects cold/slower decisions."""
import importlib
import sys
import pytest


def delivery():
    try: return importlib.import_module('recompyler.libraries.hook')
    except ModuleNotFoundError: pytest.fail('opt-in library import hook is missing')


def test_cold_import_runs_once_with_original_loader_and_can_be_disabled(tmp_path, monkeypatch):
    source = tmp_path/'fixture_cold_lib.py'
    source.write_text('events=["import"]\ndef f(x): return x+1\n')
    monkeypatch.syspath_prepend(str(tmp_path))
    api = delivery()
    from recompyler.libraries.cache import DecisionCache
    cache = DecisionCache(tmp_path/'cache',compiler_tag='fixture')
    session = api.enable(packages=('fixture_cold_lib',), cache=cache, profile=True)
    try:
        assert api.enable(packages=('fixture_cold_lib',),cache=cache,profile=True) is session
        module = importlib.import_module('fixture_cold_lib')
        assert module.events == ['import']
        for _ in range(120): assert module.f(2) == 3
        assert session.hotness(module.f) == 120
        assert type(module.__loader__).__name__ == 'SourceFileLoader'
        assert module.__spec__.loader is module.__loader__
        assert session.report['installed'] == 0
    finally:
        api.disable()
        sys.modules.pop('fixture_cold_lib',None)
    assert session.finder not in sys.meta_path
    assert session.closed


def test_failed_module_import_preserves_its_original_exception(tmp_path,monkeypatch):
    (tmp_path/'fixture_broken_lib.py').write_text('raise RuntimeError("literal import failure")\n')
    monkeypatch.syspath_prepend(str(tmp_path))
    api = delivery()
    from recompyler.libraries.cache import DecisionCache
    session = api.enable(packages=('fixture_broken_lib',),cache=DecisionCache(tmp_path/'cache',compiler_tag='fixture'))
    try:
        with pytest.raises(RuntimeError,match='literal import failure'):
            importlib.import_module('fixture_broken_lib')
        assert 'fixture_broken_lib' not in sys.modules
        assert session.report['installed'] == 0
    finally: api.disable()


def test_public_enable_is_lazy_and_exposes_disable():
    import recompyler
    assert callable(getattr(recompyler,'enable',None)), 'public enable API is missing'
    assert callable(getattr(recompyler,'disable',None)), 'public disable API is missing'


def test_profiling_does_not_keep_removed_functions_alive(tmp_path,monkeypatch):
    import gc, weakref
    (tmp_path/'fixture_lifetime_lib.py').write_text('def f(): return 1\n')
    monkeypatch.syspath_prepend(str(tmp_path))
    api = delivery()
    from recompyler.libraries.cache import DecisionCache
    session = api.enable(packages=('fixture_lifetime_lib',),cache=DecisionCache(tmp_path/'cache',compiler_tag='fixture'),profile=True)
    try:
        module = importlib.import_module('fixture_lifetime_lib')
        function_ref, code_ref = weakref.ref(module.f), weakref.ref(module.f.__code__)
        del module.f
        gc.collect()
        assert function_ref() is None and code_ref() is None
    finally:
        api.disable();sys.modules.pop('fixture_lifetime_lib',None)


def test_persistent_receipt_does_not_measure_a_new_native_body(tmp_path):
    import os, subprocess, textwrap
    from pathlib import Path
    source = textwrap.dedent('''
        import sys,types
        from pathlib import Path
        from recompyler.libraries.cache import DecisionCache
        from recompyler.libraries.hook import enable,disable
        from recompyler.ir import compile_function,compilation_info,_entry_native
        from recompyler.ir.compiler import _install_prepared
        m=types.ModuleType('fixture_eligible_lib')
        exec('def f(x):\\n while x.parent is not None: x=x.parent\\n return x',m.__dict__)
        marker=type('Value',(),{'parent':None})()
        sys.modules[m.__name__]=m
        for _ in range(32): assert m.f(marker) is marker
        compile_function(m.f,strict=True)
        assert _install_prepared(m.f), 'fixture needs a seedable body'
        _entry_native.forget_compilation(m.f)
        cache=DecisionCache(Path(sys.argv[1]),compiler_tag='fixture')
        cache.record(m.f,calls=100,cpython_ns=10,native_ns=5,verified=True)
        session=enable(packages=(m.__name__,),cache=cache)
        try:
            assert compilation_info(m.f) is None, 'runtime delivery compiled an unmeasured body'
            assert m.f(marker) is marker
        finally: disable()
    ''')
    env=dict(os.environ,PYTHON_JIT='1')
    result=subprocess.run([sys.executable,'-c',source,str(tmp_path/'cache')],env=env,capture_output=True,text=True)
    assert result.returncode==0,result.stdout+result.stderr




def test_cold_import_does_not_execute_metaclass_dictionary_descriptor(tmp_path, monkeypatch):
    (tmp_path/'fixture_meta_lib.py').write_text('''
events = []
class Meta(type):
    @property
    def __dict__(cls):
        events.append('descriptor')
        raise RuntimeError('metaclass descriptor executed')
class Box(metaclass=Meta):
    def f(self): return 42
''')
    monkeypatch.syspath_prepend(str(tmp_path))
    api = delivery()
    from recompyler.libraries.cache import DecisionCache
    api.enable(packages=('fixture_meta_lib',), cache=DecisionCache(tmp_path/'cache',compiler_tag='fixture'))
    try:
        module = importlib.import_module('fixture_meta_lib')
        assert module.Box().f() == 42
        assert module.events == []
    finally:
        api.disable();sys.modules.pop('fixture_meta_lib',None)


def test_loader_creation_preserves_original_specification(tmp_path):
    from importlib.machinery import ModuleSpec, SourceFileLoader
    api = delivery()
    class CustomLoader(SourceFileLoader):
        def create_module(self, spec):
            assert spec.loader is self
            return None
    original = CustomLoader('fixture_custom_lib',str(tmp_path/'unused.py'))
    wrapper = api._Loader(original, None)
    spec = ModuleSpec('fixture_custom_lib',wrapper)
    assert wrapper.create_module(spec) is None
    assert spec.loader is wrapper


@pytest.mark.parametrize('artifact_digest', [None, 'f'*64])
def test_receipt_without_artifact_never_calls_the_compiler(tmp_path, monkeypatch, artifact_digest):
    import types
    from recompyler.libraries.cache import DecisionCache
    from recompyler.libraries.hook import LibrarySession
    import recompyler.ir as ir
    module = types.ModuleType('fixture_no_artifact')
    exec('def f(x): return x+1', module.__dict__)
    cache = DecisionCache(tmp_path/'cache', compiler_tag='fixture')
    cache.record(module.f, calls=100, cpython_ns=10, native_ns=5, verified=True, artifact_digest=artifact_digest)
    calls = []
    monkeypatch.setattr(ir, 'compile_function', lambda *a, **kw: calls.append(a))
    session = LibrarySession((module.__name__,), cache, False)
    session.process_module(module)
    assert calls == [], 'application import compiled a body on the critical path'
    assert session.report['prepared'] == session.report['installed'] == 0
    assert session.report['declined']


def test_cold_session_does_not_initialize_the_compiler_identity(tmp_path, monkeypatch):
    from recompyler.libraries import cache as policy
    from recompyler.libraries.hook import enable, disable
    def unexpected():
        raise AssertionError('cold delivery inspected the compiler')
    monkeypatch.setattr(policy, 'compiler_identity', unexpected)
    session = enable(packages=('fixture_cold_identity',), cache_dir=tmp_path/'cache')
    try:
        assert session.report['installed'] == 0
        assert not (tmp_path/'cache').exists()
    finally:
        disable()


def test_library_cache_environment_is_shared_with_aot_and_explicit_path_wins(tmp_path, monkeypatch):
    from recompyler.libraries.hook import enable, disable
    from recompyler.libraries.cli import cache_directory
    configured = tmp_path/'configured'
    explicit = tmp_path/'explicit'
    monkeypatch.setenv('RECOMPYLER_LIBRARY_CACHE', str(configured))
    assert cache_directory() == configured
    assert cache_directory(explicit) == explicit
    for requested, expected in [(None, configured), (explicit, explicit)]:
        session = enable(packages=('fixture_environment',), cache_dir=requested)
        try:
            assert session.cache.directory == expected
        finally:
            disable()


def test_artifact_without_manifest_provenance_is_not_loaded(tmp_path,monkeypatch):
    import types
    from recompyler.libraries.cache import DecisionCache
    from recompyler.libraries.hook import LibrarySession
    module=types.ModuleType('fixture_manifest_missing')
    exec('def f(x):return x+1',module.__dict__)
    cache=DecisionCache(tmp_path,compiler_tag='manifest-fixture')
    cache.record(module.f,calls=100,cpython_ns=10,native_ns=5,verified=True,artifact_digest='a'*64)
    calls=[]
    session=LibrarySession((module.__name__,),cache,False)
    monkeypatch.setattr(session,'_install_artifact',lambda *args:calls.append(args))
    try:
        session.process_module(module)
        assert calls==[], 'object SHA alone authorized artifact loading'
        assert session.report['installed']==0 and session.report['declined']
    finally:session.close()


def test_empty_standard_cache_skips_function_discovery(tmp_path,monkeypatch):
    import types
    from recompyler.libraries.hook import LibrarySession
    from recompyler.libraries.cache import DecisionCache
    api=delivery();module=types.ModuleType('fixture_no_discovery')
    exec('def f(): return 42',module.__dict__)
    def unexpected(module):raise AssertionError('unnecessary cold function discovery')
    monkeypatch.setattr(api,'_function_references',unexpected)
    session=LibrarySession((module.__name__,),DecisionCache(tmp_path/'missing',compiler_tag='test'),False)
    session.process_module(module)
    assert session.report['installed']==0 and module.f()==42
