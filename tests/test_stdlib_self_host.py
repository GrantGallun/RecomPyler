"""Stdlib execution uses actual test modules and counts real native entries."""
import importlib.util
from pathlib import Path
import sys
from types import ModuleType
import unittest

ROOT = Path(__file__).parents[1]
sys.path.insert(0, str(ROOT/'tools'))


def tool():
    path = ROOT/'tools/stdlib_self_host.py'
    spec = importlib.util.spec_from_file_location('stdlib_self_host_tool', path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def test_function_discovery_can_target_explicit_library_modules():
    from ir_self_host import live_functions
    module = ModuleType('sample_library')
    exec('def identity(value): return value', module.__dict__)
    assert live_functions([module], module_names={'sample_library'}) == [module.identity]
    assert live_functions([module]) == []


def test_discovery_includes_fresh_library_modules_used_by_test_cases():
    runner = tool()
    library = ModuleType('sample_library')
    module = ModuleType('fixture_test_module')
    exec('class Case: pass', module.__dict__)
    module.Case.library = library
    modules = runner.referenced_modules({'sample_library'}, [module], [module.Case])
    assert modules == [library]


def test_suite_result_distinguishes_passes_failures_and_native_execution():
    runner = tool()
    events = []
    class Case(unittest.TestCase):
        def test_pass(self): events.append('body')
        def test_fail(self): self.assertEqual(1, 2)
    result = runner.Results(refresh=lambda: events.append('refresh'))
    unittest.defaultTestLoader.loadTestsFromTestCase(Case).run(result)
    assert result.passed == 1 and len(result.failures) == 1 and result.testsRun == 2
    assert events == ['refresh', 'refresh', 'body']
    assert result.details[0]['exception'] == 'AssertionError'


def test_stock_comparison_does_not_call_zero_hit_run_native_success():
    runner = tool()
    stock = dict(counts=dict(passed=3, failed=0, errors=0, skipped=1), failures=[])
    candidate = dict(counts=stock['counts'], failures=[], native_entries=0)
    compared = runner.compare(stock, candidate)
    assert compared['tests_match'] and not compared['native_execution_verified']


def test_worker_teardown_timeout_is_not_a_passing_stdlib_check():
    runner = tool()
    report = {'status':'passed','native_entries':5,'counts':{'passed':3}}
    runner.finish_worker(report,124)
    assert report['status']=='timeout' and report['process_exit']==124


def test_worker_crash_after_tests_is_not_a_passing_stdlib_check():
    runner = tool()
    report = {'status':'passed','native_entries':5}
    runner.finish_worker(report,3)
    assert report['status']=='worker-error' and report['process_exit']==3


def test_pure_python_public_module_aliases_are_discovered():
    runner=tool()
    library=ModuleType('decimal')
    exec('def identity(value): return value',library.__dict__)
    names=runner.library_names(('_pydecimal',),[library])
    modules=runner.referenced_modules(names,[library])
    from ir_self_host import live_functions
    assert names=={'_pydecimal','decimal'} and modules==[library]
    assert live_functions(modules,module_names=names)==[library.identity]


def test_fresh_module_in_fixture_method_namespace_is_discovered():
    runner=tool()
    library=ModuleType('sample_library')
    actual=ModuleType('actual_test_copy');actual.library=library
    exec('class Case:\n @classmethod\n def setUpClass(cls): return library',actual.__dict__)
    canonical=ModuleType('canonical_test_copy')
    assert runner.referenced_modules({'sample_library'},[canonical],[actual.Case])==[library]


def test_fresh_module_in_fixture_default_namespace_is_discovered():
    runner=tool()
    library=ModuleType('sample_library')
    actual=ModuleType('actual_test_copy');actual.library=library
    wrapper=ModuleType('wrapper_test_copy');wrapper.actual=actual
    exec('class Case:\n @classmethod\n def setUpClass(cls, module=actual): return module',wrapper.__dict__)
    assert runner.referenced_modules({'sample_library'},[],[wrapper.Case])==[library]
