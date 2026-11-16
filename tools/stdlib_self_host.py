"""Isolated stock/native execution of CPython's own stdlib test suites.

Uses the census enumerator's module functions, descriptors and class methods,
including fresh module copies that CPython's tests deliberately construct.
Candidate installation is explicit; this does not enable default deployment.
"""
import argparse
from collections import Counter
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import traceback
from types import FunctionType, ModuleType
import unittest

GROUPS = {
    'json': (('json', 'json.encoder', 'json.decoder', 'json.scanner'), ('test.test_json',)),
    're': (('re', 're._parser', 're._compiler', 're._casefix'), ('test.test_re',)),
    'collections': (('collections', 'collections.abc', '_collections_abc'), ('test.test_collections', 'test.test_ordered_dict')),
    **{name: ((name,), ('test.test_'+name,)) for name in ('enum','dataclasses','fractions','statistics','textwrap','difflib','heapq','bisect','argparse','pprint','ipaddress','typing','inspect')},
    'tomllib': (('tomllib','tomllib._parser','tomllib._re'), ('test.test_tomllib',)),
    'decimal': (('_pydecimal',), ('test.test_decimal',)),
    'datetime': (('_pydatetime',), ('test.test_datetime',)),
    'email': (('email','email.parser','email.feedparser','email.message','email.policy','email._policybase'), ('test.test_email',)),
    'asyncio': (('asyncio','asyncio.tasks','asyncio.futures','asyncio.events','asyncio.locks','asyncio.queues'), ('test.test_asyncio.test_queues','test.test_asyncio.test_locks')),
}


def library_names(import_names, modules):
    # _pydecimal and _pydatetime deliberately publish decimal/datetime names
    # for pickling. Their actual module dictionaries remain the test targets.
    return set(import_names) | {vars(module)['__name__'] for module in modules
                              if type(vars(module).get('__name__')) is str}


def referenced_modules(names, modules, classes=()):
    """Find actual fresh modules held by test namespaces and inherited fixtures."""
    found = []; seen = set(); functions = set(); namespaces = set()
    def add(value):
        if type(value) is ModuleType and vars(value).get('__name__') in names and id(value) not in seen:
            seen.add(id(value)); found.append(value)
    def namespace(module):
        if type(module) is not ModuleType or id(module) in namespaces: return
        namespaces.add(id(module)); add(module)
        for value in tuple(vars(module).values()): add(value)
    def fixture(value):
        if type(value) in (classmethod,staticmethod): value=value.__func__
        if type(value) is not FunctionType or id(value) in functions: return
        functions.add(id(value))
        # test_datetime's wrappers retain their actual fresh test modules in
        # defaults; inherited methods also retain those exact global namespaces.
        for item in tuple(value.__globals__.values()): add(item)
        for item in (*(value.__defaults__ or ()), *(value.__kwdefaults__ or {}).values()):
            namespace(item)
        for cell in value.__closure__ or ():
            try: item=cell.cell_contents
            except ValueError: continue
            namespace(item)
            if type(item) is FunctionType: fixture(item)
    for module in modules: namespace(module)
    for cls in classes:
        for base in cls.__mro__:
            for value in tuple(vars(base).values()):
                add(value); fixture(value)
    return found


def cases(suite):
    if isinstance(suite, unittest.TestSuite):
        for child in suite: yield from cases(child)
    else: yield suite


class Results(unittest.TestResult):
    def __init__(self, refresh=lambda: None):
        super().__init__(); self.refresh = refresh; self.passed = 0; self.details = []; self.subtests_passed = 0
    def startTest(self, test):
        self.refresh(); super().startTest(test)
    def addSuccess(self, test):
        self.passed += 1; super().addSuccess(test)
    def detail(self, test, error):
        self.details.append(dict(test=test.id(), exception=error[0].__name__, message=str(error[1]),
                            frames=[dict(path=f.filename, function=f.name, line=f.lineno) for f in traceback.extract_tb(error[2])]))
    def addFailure(self, test, error):
        self.detail(test, error); super().addFailure(test, error)
    def addError(self, test, error):
        self.detail(test, error); super().addError(test, error)
    def addSubTest(self, test, subtest, error):
        if error: self.detail(subtest, error)
        else: self.subtests_passed += 1
        super().addSubTest(test, subtest, error)


def compare(stock, candidate):
    stock_errors = {(r['test'],r['exception'],r['message']) for r in stock.get('failures', [])}
    candidate_errors = {(r['test'],r['exception'],r['message']) for r in candidate.get('failures', [])}
    return dict(tests_match=stock['counts']==candidate['counts'] and stock_errors==candidate_errors,
                native_execution_verified=candidate.get('native_entries',0)>0,
                new_failures=[dict(test=t,exception=e,message=m) for t,e,m in sorted(candidate_errors-stock_errors)])


def write(path, report):
    path.write_text(json.dumps(report, indent=2), encoding='utf-8')


def finish_worker(document, code):
    """Require a clean process exit as well as a completed unittest report."""
    status = document.get('status')
    expected_failure = code == 1 and status == 'failed'
    if (code and not expected_failure) or status not in ('passed','failed'):
        document.update(status='timeout' if code == 124 else 'worker-error',process_exit=code)
    else:
        document['process_exit'] = code
    return document


def worker(args):
    import faulthandler
    faulthandler.enable()
    from ir_self_host import live_functions, identity, CountedBody, prepare_and_install, install_functions, install_candidate, CandidateRefresh
    from recompyler.ir import compile_function, _entry_native
    names, tests = GROUPS[args.module]
    imported = [importlib.import_module(name) for name in names]
    names = library_names(names, imported)
    suite = unittest.defaultTestLoader.loadTestsFromNames(tests)
    test_cases = list(cases(suite))
    classes = {type(case) for case in test_cases}
    test_modules = {importlib.import_module(cls.__module__) for cls in classes}
    modules = referenced_modules(set(names), [*imported,*test_modules], classes)
    functions = live_functions(modules, module_names=set(names))
    report = dict(module=args.module, mode=args.mode, live_functions=len(functions), ir_installed=0,
                  native_entries=0, ir_executed=0, suite_seconds=None, all_functions_installed=False)
    counters = {}
    def publish(update):
        report.update(update); write(args.report, report)
    def prepare(function):
        compile_function(function, strict=True)
        code, owner = _entry_native._compilation_owner(function)
        _entry_native.forget_compilation(function)
        counted = CountedBody(owner, discard_ir=True)
        _entry_native.prepare_frame_entry(function, counted.body_address, counted, code)
        counters[function] = counted
    if args.mode == 'native':
        prepared = prepare_and_install(functions, prepare, install_candidate, _entry_native.compilation_info,
                                       publish, defer_install=True)
        install_functions(list(counters), prepared, install_candidate, _entry_native.compilation_info, publish)
    handles = {fn:_entry_native._compilation_handle(fn) for fn in counters}
    installed = set(report.get('installed', ()))
    refresher = CandidateRefresh(handles, install_candidate,
        installed=[fn for fn in counters if identity(fn) in installed])
    report['reinstallations'] = 0
    def refresh():
        refresher()
        report['reinstallations'] = refresher.reinstallations
        report['refresh_refusals'] = dict(refresher.refusals)
    report['status'] = 'running-tests'; publish({})
    result = Results(refresh=refresh)
    try:
        suite.run(result)
        report.update(status='passed' if result.wasSuccessful() else 'failed',
            counts=dict(passed=result.passed, failed=len(result.failures), errors=len(result.errors),
                        skipped=len(result.skipped), xfailed=len(result.expectedFailures), tests_run=result.testsRun,
                        subtests_passed=result.subtests_passed), failures=result.details,
            native_entries=sum(owner.calls.value for owner in counters.values()),
            ir_executed=sum(owner.calls.value>0 for owner in counters.values()),
            calls=[dict(function=identity(fn),native_entries=owner.calls.value) for fn,owner in counters.items()],
            active_after_tests=[identity(fn) for fn in counters if (_entry_native.compilation_info(fn) or {}).get('installed')])
        ranked=Counter((d['exception'], d['frames'][-1]['path']+':'+d['frames'][-1]['function'] if d['frames'] else d['test']) for d in result.details)
        report['ranked_causes']=[dict(exception=e,function=f,failures=n) for (e,f),n in ranked.most_common()]
        publish({})
    finally:
        for function in reversed(functions): _entry_native.forget_compilation(function)
    return int(not result.wasSuccessful())


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--module',choices=GROUPS,required=True)
    parser.add_argument('--mode',choices=('stock','native','both'),default='both')
    parser.add_argument('--label',default='s84-stdlib')
    parser.add_argument('--report',type=Path)
    parser.add_argument('--timeout',type=float,default=1800)
    parser.add_argument('--worker',action='store_true')
    args=parser.parse_args(argv)
    repo=Path(__file__).resolve().parents[1]
    args.report=(args.report or repo/'.cache/evidence'/(args.label+'-'+args.module+'.json')).resolve()
    args.report.parent.mkdir(parents=True,exist_ok=True)
    if os.name=='nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    if args.worker:return worker(args)
    from affected_tests import cache_environment
    env=cache_environment(repo,force=True);env.update(PYTHONPATH=str(repo/'src'),PYTHON_JIT='1')
    reports={}
    for mode in ('stock','native') if args.mode=='both' else (args.mode,):
        target=args.report.with_name(args.report.stem+'-'+mode+'.json')
        command=[sys.executable,str(Path(__file__).resolve()),'--worker','--module',args.module,'--mode',mode,'--report',str(target)]
        with target.with_suffix('.log').open('w',encoding='utf-8') as stream:
            child=subprocess.Popen(command,cwd=repo,env=env,stdout=stream,stderr=subprocess.STDOUT,
                        creationflags=0x08004000 if os.name=='nt' else 0)
            try:code=child.wait(timeout=args.timeout)
            except subprocess.TimeoutExpired:child.kill();child.wait();code=124
        document=json.loads(target.read_text()) if target.exists() else {}
        finish_worker(document,code)
        write(target,document)
        reports[mode]=document
    report=dict(module=args.module,runs=reports)
    if args.mode=='both' and all('counts' in d for d in reports.values()):report.update(compare(reports['stock'],reports['native']))
    write(args.report,report)
    print(json.dumps(dict(module=args.module,tests_match=report.get('tests_match'),native_entries=reports.get('native',{}).get('native_entries'),report=str(args.report))),flush=True)
    return int(any(d.get('status') not in ('passed','failed') for d in reports.values()) or bool(report.get('new_failures')))


if __name__=='__main__':raise SystemExit(main())
