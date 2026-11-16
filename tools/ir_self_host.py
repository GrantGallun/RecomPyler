"""Isolated IR self-host execution check; candidate installation is opt-in.

All bodies are prepared before any is installed. Functions keep their original
identity and descriptors. Compiler entry/bridge modules are explicitly excluded
from this first bootstrap check. A successful compile or install does not prove
that the suite exercised every body, and unavailable seeds remain visible.
"""
import argparse
import gc
from collections import Counter
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
from types import FunctionType, ModuleType

BOOTSTRAP = {'recompyler.ir.compiler', 'recompyler.ir.entry', 'recompyler.ir.symbols'}


def bootstrap_reason(module):
    return 'compiler entry/bridge bootstrap excluded explicitly' if module in BOOTSTRAP else None


def identity(function):
    return function.__module__ + ':' + function.__qualname__ + ':' + str(function.__code__.co_firstlineno)


def live_functions(modules, module_names=None):
    """Read actual module/class dictionaries and live closures, never descriptors."""
    found = []; seen = set()
    def admitted(name):
        if type(name) is not str: return False
        if module_names is not None: return name in module_names
        return name == 'recompyler' or name.startswith('recompyler.')
    def visit(value):
        if id(value) in seen: return
        seen.add(id(value))
        if type(value) is FunctionType:
            if not admitted(value.__module__): return
            found.append(value)
            visit(vars(value).get('__wrapped__'))
            for cell in value.__closure__ or ():
                try: enclosed = cell.cell_contents
                except ValueError: continue
                if type(enclosed) is FunctionType: visit(enclosed)
        elif type(value) in (staticmethod, classmethod): visit(value.__func__)
        elif type(value) is property:
            for accessor in (value.fget, value.fset, value.fdel): visit(accessor)
        elif isinstance(value, type) and admitted(vars(value).get('__module__')):
            for member in tuple(vars(value).values()): visit(member)
    for module in modules:
        for value in tuple(vars(module).values()): visit(value)
    return sorted(found, key=identity)



def install_candidate(function):
    """Use the canonical entry API, retaining its precise refusal exception."""
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import install_frame_entry
    details = _entry_native.compilation_info(function)
    if details and details['installed']: return True
    state = _entry_native._compilation_owner(function)
    prepared = _entry_native._compilation_handle(function)
    if state is None or prepared is None: raise ValueError('prepared body invalidated')
    code, owner = state
    handle = install_frame_entry(function, owner.body_address, owner,
        seed_arguments=(None,)*code.co_argcount,
        seed_keywords={name:None for name in code.co_varnames[code.co_argcount:code.co_argcount+code.co_kwonlyargcount]} if code.co_kwonlyargcount else None,
        entry_offset=owner.entry_offset,
        expected_code=code, expected_prepared=prepared)
    return handle is prepared and handle.active


def prepare_and_install(functions, compile_function, install, info, publish=lambda report: None, *, defer_install=False, report=None):
    if report is None: report = {}
    report.update(status='preparing', ir_prepared=0, ir_installed=0,
                  execution_verified=False, prepared=[], installed=[], unavailable=[], excluded=[])
    prepared = []
    for function in functions:
        name = identity(function)
        reason = bootstrap_reason(function.__module__)
        if reason:
            report['excluded'].append(dict(function=name, reason=reason)); continue
        report['current'] = name; publish(report)
        try:
            compile_function(function)
            details = info(function)
            if not details or not details['compiled']: raise ValueError('no actual native body')
            prepared.append(function)
            report['prepared'].append(dict(function=name, native_prefix=bool(details.get('native_prefix'))))
            report['ir_prepared'] += 1
        except Exception as error:
            report['unavailable'].append(dict(function=name, phase='prepare', reason=type(error).__name__+': '+str(error)))
    if defer_install:
        report['status'] = 'prepared'; publish(report)
        return report
    return install_functions(prepared, report, install, info, publish)


def install_functions(prepared, report, install, info, publish):
    report['status'] = 'installing'; publish(report)
    for function in prepared:
        name = identity(function); report['current'] = name; publish(report)
        try:
            if not install(function): raise ValueError('canonical frame entry seed declined')
            report['installed'].append(name)
        except Exception as error:
            report['unavailable'].append(dict(function=name, phase='install', reason=type(error).__name__+': '+str(error)))
    # Seeding or invalidation may have retired an earlier entry. Count live entries.
    active = [identity(fn) for fn in prepared if info(fn) and info(fn)['installed']]
    report['ir_installed'] = len(active); report['active_before_tests'] = active
    report['status'] = 'prepared'; report.pop('current', None); publish(report)
    return report



class CountedBodyPool:
    """Share LLVM execution infrastructure, never source/counter ownership."""
    def __init__(self):
        import itertools
        from threading import Lock
        from llvmlite import binding
        self.names=itertools.count()
        self.lock=Lock()
        self.engine=binding.create_mcjit_compiler(binding.parse_assembly(''),
                    binding.Target.from_default_triple().create_target_machine())

    def compile(self,module,name):
        from llvmlite import binding
        parsed=binding.parse_assembly(str(module));parsed.verify()
        with self.lock:
            self.engine.add_module(parsed)
            self.engine.finalize_object()
            return self.engine.get_function_address(name)


_shared_counter_pool=None


def _counter_pool():
    import weakref
    global _shared_counter_pool
    pool=_shared_counter_pool() if _shared_counter_pool is not None else None
    if pool is None:
        pool=CountedBodyPool();_shared_counter_pool=weakref.ref(pool)
    return pool


class CountedBody:
    """Harness-only native entry counter; retains the exact compiled body."""
    def __init__(self, original, *, pool=None, discard_ir=False):
        import ctypes
        from llvmlite import ir, binding
        from dataclasses import replace
        # The LLVM engine owns executable memory. The Python code-generation
        # tree is only diagnostic data and is very large across the full census.
        if type(discard_ir) is not bool: raise TypeError('discard_ir must be bool')
        if discard_ir:
            # The caller has removed this private body from the canonical
            # registry. Finalized machine code belongs to the engine; only the
            # now-unused compilation IR is detached and disposed here.
            native = original.native_module
            if native is not None:
                original.engine.remove_module(native)
                native.close()
            self.original = replace(original, module=None, native_module=None)
        else:
            self.original = replace(original, module=None)
        self.calls = ctypes.c_uint64()
        self.entry_offset = original.entry_offset
        pointer = ir.IntType(8).as_pointer(); word = ir.IntType(64)
        signature = ir.FunctionType(pointer, [pointer, word.as_pointer(), pointer])
        module = ir.Module()
        self.pool=pool if pool is not None else _counter_pool()
        name='self_host_counted_body_'+str(next(self.pool.names))
        function = ir.Function(module, signature, name)
        builder = ir.IRBuilder(function.append_basic_block('entry'))
        counter = ir.Constant(word, ctypes.addressof(self.calls)).inttoptr(word.as_pointer())
        builder.store(builder.add(builder.load(counter), ir.Constant(word, 1)), counter)
        target = builder.inttoptr(ir.Constant(word, original.body_address), signature.as_pointer())
        builder.ret(builder.call(target, list(function.args)))
        self.engine=self.pool.engine
        self.body_address=self.pool.compile(module,name)


def write_report(path, report):
    path.write_text(json.dumps(report, indent=2), encoding='utf-8')



def working_set_bytes():
    if os.name != 'nt': return None
    import ctypes
    cached=getattr(working_set_bytes,'_query',None)
    if cached is None:
        class Memory(ctypes.Structure):
            _fields_ = [('cb',ctypes.c_uint32),('faults',ctypes.c_uint32)] + [(name,ctypes.c_size_t) for name in
                ('peak_working_set','working_set','peak_paged','paged','peak_nonpaged','nonpaged','pagefile','peak_pagefile','private')]
        # Private DLL wrappers leave ctypes.windll's shared function prototypes intact.
        current=ctypes.WinDLL('kernel32',use_last_error=True).GetCurrentProcess
        current.restype=ctypes.c_void_p
        query=ctypes.WinDLL('psapi',use_last_error=True).GetProcessMemoryInfo
        query.argtypes=(ctypes.c_void_p,ctypes.POINTER(Memory),ctypes.c_uint32)
        query.restype=ctypes.c_int
        cached=working_set_bytes._query=(Memory,current,query)
    Memory,current,query=cached
    details=Memory(); details.cb=ctypes.sizeof(details)
    if not query(current(),ctypes.byref(details),details.cb): return None
    return details.working_set


class CandidateRefresh:
    """Retry cold entries and transient observer seeding without executing targets."""
    def __init__(self, handles, install, *, installed=()):
        self.handles = handles
        self.install = install
        self.ever_installed = set(installed)
        self.failed_seeds = set()
        self.reinstallations = 0
        self.refusals = Counter()

    def __call__(self):
        for function, handle in self.handles.items():
            if function in self.failed_seeds: continue
            if handle is None or handle.function is not function: continue
            if handle.active:
                self.ever_installed.add(function)
                continue
            try:
                if self.install(function):
                    self.ever_installed.add(function)
                    self.reinstallations += 1
                else:
                    self.failed_seeds.add(function)
            except Exception as error:
                reason = type(error).__name__+': '+str(error)
                self.refusals[reason] += 1
                # Tracing can retire an entry and leave instrumented bytecode
                # until the application's next ordinary CPython call. Seeding
                # must never call its body just to warm that bytecode.
                temporary = (isinstance(error, RuntimeError) and 'unobserved interpreter' in str(error))
                temporary |= (function in self.ever_installed and isinstance(error, ValueError)
                              and str(error) == 'CPython declined frame entry seed')
                if not temporary: self.failed_seeds.add(function)


class Results:
    def __init__(self, repo, activate=lambda: None, refresh=lambda: None, progress=lambda counts: None):
        self.repo = repo
        self.activate = activate
        self.refresh = refresh
        self.progress = progress
        self.counts = dict(passed=0, failed=0, skipped=0, errors=0, xfailed=0)
        self.failures = []; self.details = {}

    def pytest_collection_finish(self):
        self.activate()

    def pytest_runtest_call(self, item):
        self.refresh()

    def pytest_runtest_makereport(self, item, call):
        if call.excinfo is None: return
        frames = []
        for entry in call.excinfo.traceback:
            filename = str(entry.path)
            if 'src' + os.sep + 'recompyler' + os.sep in filename:
                frames.append(dict(function=entry.frame.code.name, path=filename, line=entry.lineno+1))
        detail = dict(exception=call.excinfo.type.__name__, functions=frames)
        for entry in call.excinfo.traceback:
            if Path(str(entry.path)).name not in ('test_language_matrix.py','test_s82_bool_xor.py'): continue
            row = entry.frame.f_locals.get('row')
            if type(row) is dict and type(row.get('id')) is str and 'verdict' in row:
                # The matrix already records a JSON-safe result. Preserve its
                # full reason; pytest truncates large assertion dictionaries.
                try: detail['matrix_row'] = json.loads(json.dumps(row))
                except (TypeError, ValueError): pass
        self.details[(item.nodeid, call.when)] = detail

    def pytest_runtest_logreport(self, report):
        if report.failed:
            self.counts['failed' if report.when == 'call' else 'errors'] += 1
            self.failures.append(dict(test=report.nodeid, phase=report.when,
                error=str(report.longrepr), **self.details.get((report.nodeid, report.when), {})))
        elif report.when == 'call':
            self.counts['xfailed' if hasattr(report, 'wasxfail') else 'passed' if report.passed else 'skipped'] += 1
        if report.when == 'call' and (report.failed or sum(self.counts.values()) % 25 == 0):
            self.progress(self.counts)

    def pytest_collectreport(self, report):
        if report.failed:
            self.counts['errors'] += 1
            self.failures.append(dict(test=report.nodeid, phase='collection', error=str(report.longrepr)))

    def ranked(self):
        causes = Counter()
        for failure in self.failures:
            frames = failure.get('functions', [])
            function = frames[-1]['path']+':'+frames[-1]['function'] if frames else failure['test'].split('::')[0]
            causes[(failure.get('exception', 'collection'), function)] += 1
        return [dict(exception=exc, function=fn, failures=count) for (exc, fn), count in causes.most_common()]


def worker(args):
    import faulthandler
    faulthandler.enable()
    faulthandler.dump_traceback_later(300, repeat=True)
    repo = args.repo.resolve(); sys.path.insert(0, str(repo)); sys.path.insert(0, str(repo/'src'))
    import pytest
    from recompyler.ir.compiler import compile_function
    from recompyler.ir._entry_native import compilation_info, forget_compilation, _compilation_owner, prepare_frame_entry
    if not sys._jit.is_enabled(): raise RuntimeError('requires child-only PYTHON_JIT=1')
    modules = []; errors = []
    for path in sorted((repo/'src'/'recompyler').rglob('*.py')):
        name = '.'.join(path.relative_to(repo/'src').with_suffix('').parts).removesuffix('.__init__')
        try:
            module = importlib.import_module(name)
            if Path(module.__file__).resolve() != path.resolve(): raise ValueError('provider outside requested checkout')
            modules.append(module)
        except Exception as error: errors.append(dict(module=name, reason=type(error).__name__+': '+str(error)))
    functions = [fn for fn in live_functions(modules) if Path(fn.__code__.co_filename).is_relative_to(repo/'src')]
    if args.match: functions = [fn for fn in functions if any(part in identity(fn) for part in args.match)]
    if args.limit: functions = functions[:args.limit]
    def publish(report):
        if report.get('status') == 'preparing' and report.get('ir_prepared',0) % 16 == 0:
            gc.collect()
        memory = working_set_bytes()
        report['working_set_mb'] = None if memory is None else round(memory/2**20,1)
        if memory is not None: report['peak_working_set_mb'] = max(report.get('peak_working_set_mb',0), report['working_set_mb'])
        if memory is not None and args.memory_mb and memory > args.memory_mb*2**20:
            report.update(status='resource-limit',resource_limit='self-host working set exceeded '+str(args.memory_mb)+' MiB')
            write_report(args.report, report)
            raise KeyboardInterrupt(report['resource_limit'])
        report.update(import_errors=errors, live_functions=len(functions), mode=args.mode,
                      bootstrap_exclusions=sorted(BOOTSTRAP), suite_seconds=None)
        write_report(args.report, report)
    counters = {}; handles = {}
    def prepare(function):
        compile_function(function, strict=True)
        code, owner = _compilation_owner(function)
        forget_compilation(function)
        counted = CountedBody(owner, discard_ir=True)
        prepare_frame_entry(function, counted.body_address, counted, code)
        counters[function] = counted
    report = dict(status='collecting', ir_prepared=0, ir_installed=0, execution_verified=False)
    publish(report)
    def activate():
        if args.mode != 'baseline':
            prepare_and_install(functions, prepare, install_candidate, compilation_info, publish,
                                defer_install=True, report=report)
            gc.collect()
            from recompyler.ir._entry_native import _compilation_handle
            handles.update((fn,_compilation_handle(fn)) for fn in counters)
            if not args.prepare_only:
                install_functions(list(counters), report, install_candidate, compilation_info, publish)
                installed = set(report['installed'])
                refresher.ever_installed.update(fn for fn in counters if identity(fn) in installed)
        report['status'] = 'running-tests'; publish(report)
        if args.prepare_only: pytest.exit('preparation complete', returncode=0)
    refresher = CandidateRefresh(handles, install_candidate)
    report['reinstallations'] = 0
    def refresh():
        if args.mode == 'baseline': return
        refresher()
        report['reinstallations'] = refresher.reinstallations
        report['refresh_refusals'] = dict(refresher.refusals)
    def progress(counts):
        report['partial_counts'] = dict(counts)
        report['partial_failures'] = list(results.failures)
        report['ranked_causes'] = results.ranked()
        report['native_entries'] = sum(owner.calls.value for owner in counters.values())
        report['ir_executed'] = sum(owner.calls.value > 0 for owner in counters.values())
        report['ir_active_now'] = sum(handle is not None and handle.active for handle in handles.values())
        publish(report)
        print('SELFHOST',report['partial_counts'],'native_entries',report['native_entries'],
              'ir_executed',report['ir_executed'],'active',report['ir_active_now'],
              'memory_mb',report['working_set_mb'],flush=True)
    results = Results(repo, activate=activate, refresh=refresh, progress=progress)
    arguments = ['-q', '--tb=short', '--basetemp='+str(repo/'.cache/evidence/temp'/args.label)]
    if not args.include_slow: arguments += ['-m', 'not slow']
    if args.maxfail: arguments += ['--maxfail='+str(args.maxfail)]
    arguments += args.tests or ['tests']
    try:
        code = int(pytest.main(arguments, plugins=[results]))
        # pytest cancels its faulthandler timer during unconfigure. Keep a
        # fresh watchdog alive through native-owner cleanup and interpreter exit.
        faulthandler.enable()
        faulthandler.dump_traceback_later(30, repeat=True)
        report.update(status='resource-limit' if report.get('resource_limit') else 'passed' if code == 0 else 'failed', tests=dict(exit_code=code, counts=results.counts,
                      failures=results.failures, ranked_causes=results.ranked(), command=arguments))
        report['native_entries'] = sum(owner.calls.value for owner in counters.values())
        report['ir_executed'] = sum(owner.calls.value > 0 for owner in counters.values())
        report['calls'] = [dict(function=identity(fn), native_entries=owner.calls.value) for fn, owner in counters.items()]
        report['active_after_tests'] = [identity(fn) for fn in functions if compilation_info(fn) and compilation_info(fn)['installed']]
        # Passing an incompletely installed population is explicitly partial.
        report['execution_verified'] = False
        report['suite_passed'] = code == 0
        publish(report)
    finally:
        for function in reversed(functions): forget_compilation(function)
    return code


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--report', type=Path)
    parser.add_argument('--label', default='s82-ir-self-host')
    parser.add_argument('--mode', choices=['selfhost', 'baseline'], default='selfhost')
    parser.add_argument('--match', action='append')
    parser.add_argument('--limit', type=int, default=0)
    parser.add_argument('--maxfail', type=int, default=0)
    parser.add_argument('--timeout', type=float, default=3600)
    parser.add_argument('--memory-mb', type=int, default=8192)
    parser.add_argument('--include-slow', action='store_true')
    parser.add_argument('--prepare-only', action='store_true')
    parser.add_argument('--worker', action='store_true')
    parser.add_argument('tests', nargs='*')
    args = parser.parse_args(argv)
    args.repo = args.repo.resolve()
    args.report = (args.report or args.repo/'.cache/evidence'/(args.label+'.json')).resolve()
    args.report.parent.mkdir(parents=True, exist_ok=True)
    (args.repo/'.cache/evidence/temp').mkdir(parents=True, exist_ok=True)
    if os.name == 'nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
    if args.worker: return worker(args)
    from affected_tests import cache_environment
    env = cache_environment(args.repo, force=True)
    env.update(PYTHONPATH=os.pathsep.join((str(args.repo/'src'),str(args.repo))), PYTHON_JIT='1')
    command = [sys.executable, str(Path(__file__).resolve()), '--worker', '--repo', str(args.repo),
               '--report', str(args.report), '--label', args.label, '--mode', args.mode,
               '--limit', str(args.limit), '--maxfail', str(args.maxfail), '--memory-mb', str(args.memory_mb)]
    for value in args.match or (): command += ['--match', value]
    if args.prepare_only: command += ['--prepare-only']
    if args.include_slow: command += ['--include-slow']
    command += args.tests
    with args.report.with_suffix('.log').open('w', encoding='utf-8') as output:
        child = subprocess.Popen(command, cwd=args.repo, env=env, stdout=output, stderr=subprocess.STDOUT,
                                 creationflags=0x08004000 if os.name == 'nt' else 0)
        try: code = child.wait(timeout=args.timeout)
        except subprocess.TimeoutExpired:
            child.kill(); child.wait(); code = 124
    report = json.loads(args.report.read_text(encoding='utf-8')) if args.report.exists() else {}
    if code and report.get('status') not in ('failed', 'worker-error', 'resource-limit'):
        report.update(status='timeout' if code == 124 else 'worker-error', process_exit=code)
        write_report(args.report, report)
    print('IR self-host exit', code, 'status', report.get('status'), 'ir_installed', report.get('ir_installed', 0),
          'report', str(args.report), flush=True)
    return code


if __name__ == '__main__': raise SystemExit(main())
