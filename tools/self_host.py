"""Opt-in isolated self-host execution check; admission is not parity.

Prepare all regions before replacing any live binding, then run pytest in the
same child. The parent only collects the result and may kill its own timed-out
child. Decorators and unavailable nested closures are reported, never stripped.
"""
import argparse
from dataclasses import dataclass
from functools import wraps
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time
from types import FunctionType, ModuleType


@dataclass
class Binding:
    owner: object
    name: str
    function: object
    accessor: str = ''

    def install(self, region):
        previous = vars(self.owner)[self.name]
        @wraps(self.function)
        def call(*args, **kwargs):
            return region(*args, **kwargs)
        if self.accessor:
            parts = dict(fget=previous.fget, fset=previous.fset, fdel=previous.fdel)
            parts[self.accessor] = call
            replacement = property(**parts, doc=previous.__doc__)
        elif type(previous) is staticmethod:
            replacement = staticmethod(call)
        elif type(previous) is classmethod:
            replacement = classmethod(call)
        else:
            replacement = call
        def assign(value):
            if type(self.owner) is ModuleType:
                vars(self.owner)[self.name] = value
            else:
                type.__setattr__(self.owner, self.name, value)
        assign(replacement)
        def undo():
            assign(previous)
        return undo


def locate(module, qualname, line):
    if '<locals>' in qualname or '<lambda>' in qualname:
        return None
    parts = qualname.split('.')
    owner = module
    for part in parts[:-1]:
        if not isinstance(owner, (ModuleType, type)):
            return None
        owner = vars(owner).get(part)
    if not isinstance(owner, (ModuleType, type)):
        return None
    raw = vars(owner).get(parts[-1])
    candidates = [(raw, '')]
    if type(raw) in (staticmethod, classmethod):
        candidates = [(raw.__func__, '')]
    elif type(raw) is property:
        candidates = [(raw.fget, 'fget'), (raw.fset, 'fset'), (raw.fdel, 'fdel')]
    for fn, accessor in candidates:
        if (type(fn) is FunctionType and fn.__code__.co_qualname == qualname
                and fn.__code__.co_firstlineno == line):
            return Binding(owner, parts[-1], fn, accessor)
    return None


def _write(path, report):
    path.write_text(json.dumps(report, indent=2), encoding='utf-8')


def worker(args):
    repo = args.repo.resolve()
    sys.path.insert(0, str(repo/'src'))
    from recompyler.heap import lift_calls, lift_structures
    from recompyler.managed import lift_managed
    entries = dict(lift_calls=lift_calls, lift_structures=lift_structures, lift_managed=lift_managed)
    data = json.loads(args.census.read_text(encoding='utf-8'))
    report = dict(status='preparing', census_commit=data['commit'], census_compiled=data['summary']['compiled'],
                  admission_only=True, prepared=[], unavailable=[], installed=0, tests=None)
    prepared = []
    deadline = time.monotonic() + args.prepare_budget
    for row in data['functions']:
        identity = row['path'] + ':' + row['qualname']
        if row['status'] != 'compiled' or args.match and not any(text in identity for text in args.match):
            continue
        if time.monotonic() >= deadline or args.limit and len(prepared) >= args.limit:
            report['unavailable'].append(dict(function=identity, reason='preparation budget'))
            continue
        if row['nested']:
            report['unavailable'].append(dict(function=identity, reason='nested live binding unavailable without enclosing execution'))
            continue
        name = '.'.join(Path(row['path']).with_suffix('').parts[1:])
        if name.endswith('.__init__'):
            name = name[:-9]
        try:
            module = importlib.import_module(name)
            if Path(module.__file__).resolve() != (repo/row['path']).resolve():
                raise ValueError('provider outside requested checkout')
            binding = locate(module, row['qualname'], row['line'])
            if binding is None:
                raise ValueError('live code/descriptor differs; decorated or source changed')
            if Path(binding.function.__code__.co_filename).resolve() != (repo/row['path']).resolve():
                raise ValueError('function code outside requested source')
            region = entries[row['backend']](binding.function)
            if hasattr(region, 'run') and region.run is None:
                raise ValueError(region.problem)
            if hasattr(region, 'entry') and not region.entry.supported:
                raise ValueError('unsupported entry')
            prepared.append((identity, binding, region))
            report['prepared'].append(dict(function=identity, backend=row['backend']))
        except Exception as exc:
            report['unavailable'].append(dict(function=identity, reason=type(exc).__name__ + ': ' + str(exc)[:800]))
        _write(args.report, report)
    report['status'] = 'installing'
    _write(args.report, report)
    undos = []
    try:
        for identity, binding, region in prepared:
            undos.append(binding.install(region))
            report['installed'] += 1
        report['status'] = 'running-tests'
        _write(args.report, report)
        import pytest
        class Results:
            def __init__(self):
                self.counts = dict(passed=0, failed=0, skipped=0, errors=0)
                self.failures = []
            def pytest_runtest_logreport(self, report):
                if report.failed:
                    key = 'failed' if report.when == 'call' else 'errors'
                    self.counts[key] += 1
                    self.failures.append(dict(test=report.nodeid, phase=report.when, error=str(report.longrepr)[:1800]))
                elif report.when == 'call':
                    self.counts['passed' if report.passed else 'skipped'] += 1
            def pytest_collectreport(self, report):
                if report.failed:
                    self.counts['errors'] += 1
                    self.failures.append(dict(test=report.nodeid, phase='collection', error=str(report.longrepr)[:1800]))
        results = Results()
        arguments = ['-q', '--tb=short', '--basetemp='+str(repo/'lift-evidence/temp'/args.label), *args.tests]
        code = int(pytest.main(arguments, plugins=[results]))
        report['tests'] = dict(command=['python', '-m', 'pytest', *arguments], exit_code=code,
                               counts=results.counts, failures=results.failures)
        report['status'] = 'passed' if code == 0 else 'failed'
        report['admission_only'] = code != 0 or bool(report['unavailable'])
    except BaseException as exc:
        report['status'] = 'worker-error'
        report['error'] = type(exc).__name__ + ': ' + str(exc)[:1800]
        code = 1
    finally:
        for undo in reversed(undos):
            undo()
    report['calls'] = [dict(function=identity, compiled=region.compiled_calls,
                            fallback=region.fallback_calls) for identity, binding, region in prepared]
    report['executed_functions'] = sum(row['compiled'] > 0 for row in report['calls'])
    report['unexercised_functions'] = [row['function'] for row in report['calls'] if row['compiled'] == 0]
    report['admission_only'] = (code != 0 or bool(report['unavailable'])
        or bool(report['unexercised_functions']) or any(row['fallback'] for row in report['calls'])
        or len(prepared) != report['census_compiled'] or bool(args.match) or bool(args.limit))
    _write(args.report, report)
    return code


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--census', type=Path)
    parser.add_argument('--report', type=Path)
    parser.add_argument('--match', action='append')
    parser.add_argument('--limit', type=int, default=0)
    parser.add_argument('--prepare-budget', type=float, default=1800)
    parser.add_argument('--timeout', type=float, default=3600)
    parser.add_argument('--label', default='s71-self-host')
    parser.add_argument('--worker', action='store_true')
    parser.add_argument('tests', nargs='*', default=['tests'])
    args = parser.parse_args(argv)
    args.repo = args.repo.resolve()
    args.census = (args.census or args.repo.parent/'selfcompile-progress/self-census.json').resolve()
    args.report = (args.report or args.repo/'lift-evidence'/ (args.label+'.json')).resolve()
    if os.name == 'nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
    if args.worker:
        os.chdir(args.repo)
        return worker(args)
    command = [sys.executable, str(Path(__file__).resolve()), '--worker', '--repo', str(args.repo),
               '--census', str(args.census), '--report', str(args.report), '--label', args.label,
               '--prepare-budget', str(args.prepare_budget), '--limit', str(args.limit)]
    for match in args.match or ():
        command.extend(['--match', match])
    command.extend(args.tests)
    output = args.report.with_suffix('.log')
    with output.open('w', encoding='utf-8') as stream:
        process = subprocess.Popen(command, cwd=args.repo, stdout=stream, stderr=subprocess.STDOUT,
            creationflags=0x08004000 if os.name == 'nt' else 0)
        try:
            code = process.wait(timeout=args.timeout)
        except subprocess.TimeoutExpired:
            process.kill()
            process.wait()
            report = json.loads(args.report.read_text()) if args.report.exists() else {}
            report.update(status='timeout', admission_only=True)
            _write(args.report, report)
            code = 124
    print('Self-host exit', code, 'report', args.report, 'log', output, flush=True)
    return code


if __name__ == '__main__':
    raise SystemExit(main())
