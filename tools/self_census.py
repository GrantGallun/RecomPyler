"""Bounded admission census. Target bodies are never invoked.

Module imports establish real namespaces; nested/decorated source code is built
with FunctionType without evaluating defaults, decorators or enclosing bodies.
Empty closure cells are reported, not populated with invented application data.
Admission is NOT execution parity, deployability, or proof that a first-refusal
fix will complete a function. Run again after accepted integrations.
"""
import argparse
import ast
from collections import Counter
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
import gc
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time
from types import CellType, CodeType, FunctionType


def _definitions(path):
    source = Path(path).read_text(encoding='utf-8-sig')
    tree = ast.parse(source, filename=str(path))
    nodes = {}
    for node in ast.walk(tree):
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.Lambda)):
            first = min([node.lineno] + [n.lineno for n in getattr(node, 'decorator_list', ())])
            name = '<lambda>' if isinstance(node, ast.Lambda) else node.name
            nodes.setdefault((name, first), []).append(node)
    module = compile(source, str(path), 'exec', dont_inherit=True)
    found = []
    def walk(code):
        key = (code.co_name, code.co_firstlineno)
        if key in nodes:
            node = nodes[key].pop(0)
            if not nodes[key]:
                del nodes[key]
            found.append((code, node))
        for item in code.co_consts:
            if type(item) is CodeType:
                walk(item)
    walk(module)
    return found


def inventory(path):
    rows = []
    for index, (code, node) in enumerate(_definitions(path)):
        nested = '.<locals>.' in code.co_qualname
        kind = ('lambda' if isinstance(node, ast.Lambda) else
                'async-function' if isinstance(node, ast.AsyncFunctionDef) else
                'method' if '.' in code.co_qualname and not nested else 'function')
        rows.append(dict(index=index, qualname=code.co_qualname, line=code.co_firstlineno,
                         kind=kind, nested=nested, freevars=list(code.co_freevars)))
    return rows


def source_functions(path, namespace):
    namespace.setdefault('__builtins__', vars(__import__('builtins')))
    namespace.setdefault('__name__', '_self_census_source')
    namespace.setdefault('__file__', str(path))
    result = []
    for code, node in _definitions(path):
        closure = tuple(CellType() for _ in code.co_freevars) or None
        fn = FunctionType(code, namespace, code.co_name, closure=closure)
        result.append(fn)
    # Bind plain source functions for direct recursion without evaluating the
    # module. Preserve real live namespace values whenever they are available.
    for fn in result:
        if '.' not in fn.__qualname__ and fn.__name__ != '<lambda>':
            namespace.setdefault(fn.__name__, fn)
    return result


def family(reason, fn=None):
    text = reason.lower()
    if 'kwargs' in text or 'variadic keyword' in text:
        return 'variadic-keywords'
    if 'closure' in text or 'suspended frame' in text:
        if fn is not None and fn.__code__.co_flags & (0x20 | 0x200):
            return 'generators'
        if fn is not None and fn.__code__.co_flags & 0x80:
            return 'async'
        return 'closures-functions-cells'
    rules = [
        ('protected except/else', 'try-except'), ('statement trystar', 'exception-groups'),
        ('statement try', 'try-except'), ('statement with', 'with'),
        ('statement async', 'async'), ('protected loop exits', 'protected-loop-exits'),
        ('expanded', 'starred-arguments'), ('star', 'starred-arguments'), ('f-string', 'formatted-strings'),
        ('joinedstr', 'formatted-strings'), ('comprehension', 'comprehensions'),
        ('listcomp', 'comprehensions'), ('dictcomp', 'comprehensions'),
        ('setcomp', 'comprehensions'), ('generatorexp', 'generators'), ('classdef', 'class-creation'),
        ('functiondef', 'closures-functions-cells'), ('lambda', 'closures-functions-cells'), ('statement global', 'global-writes'),
        ('statement nonlocal', 'closures-functions-cells'), ('statement delete', 'delete'),
        ('statement assert', 'assert'), ('statement augassign', 'augmented-assignment'),
        ('statement raise', 'raise'), ('statement for', 'for-else'),
        ('statement while', 'while-else'), ('statement match', 'pattern-matching'),
        ('for-else', 'for-else'), ('while-else', 'while-else'),
        ('instruction positions', 'source-binding'), ('binary operator', 'binary-operators'),
        ('future compilation', 'future-context'), ('source', 'source-binding'),
        ('original', 'source-binding'), ('literal', 'literal-ownership'),
        ('compare', 'comparisons'), ('comparison', 'comparisons'),
        ('binop', 'binary-operators'), ('unary', 'unary-operators'),
        ('namedexpr', 'assignment-expressions'), ('dict', 'dictionaries'),
        ('set', 'sets'), ('slice', 'slices'), ('assignment', 'assignment-targets'),
        ('call', 'calls'), ('builtin', 'builtins')]
    for needle, label in rules:
        if needle in text:
            return label
    return 'other: ' + reason.split(':', 1)[0][:90]


def attempt(fn):
    from recompyler.heap import lift_structures, lift_calls
    from recompyler.managed import lift_managed
    from recompyler.lift import Unsupported
    from recompyler._call_bridge import UnsupportedCall
    attempts = []
    for name, entry in [('lift_structures', lift_structures), ('lift_calls', lift_calls),
                        ('lift_managed', lift_managed)]:
        try:
            region = entry(fn)
            if hasattr(region, 'run') and region.run is None:
                reason = region.problem or 'no compiled entry'
            elif hasattr(region, 'entry') and not region.entry.supported:
                reason = 'variadic keywords require interpreter entry'
            else:
                attempts.append(dict(backend=name, status='compiled', reason=None))
                return dict(status='compiled', backend=name, family=None,
                            execution_verified=False, attempts=attempts)
            attempts.append(dict(backend=name, status='declined', reason=reason))
        except (Unsupported, UnsupportedCall, ValueError, OSError, SyntaxError) as exc:
            attempts.append(dict(backend=name, status='declined', reason=str(exc)[:1500]))
        except Exception as exc:
            attempts.append(dict(backend=name, status='error', reason=type(exc).__name__ + ': ' + str(exc)[:1500]))
        finally:
            # Regions contain compiler-generated cycles. Do not let an entire
            # module's native artifacts accumulate until its worker exits.
            region = None
        gc.collect()
    first = attempts[0]
    return dict(status='error' if any(a['status'] == 'error' for a in attempts) else 'declined',
                backend=None, family=family(first['reason'], fn),
                execution_verified=False, attempts=attempts)



def attempt_ir(fn):
    """Only a successfully lowered native entry counts, never a builder graph."""
    base=dict(native_compiled=False,execution_verified=False,native_prefix=False)
    try:
        from recompyler import ir
        compiler=getattr(ir,'compile_function',None)
        if compiler is None:
            return dict(base,status='unavailable',reason='shared native IR compiler entry not published')
        try:
            from recompyler.ir.semantics import UnsupportedBytecode
            refusals=(NotImplementedError,UnsupportedBytecode)
        except ImportError:
            refusals=(NotImplementedError,)
        try:
            result=compiler(fn)
        except refusals as error:
            return dict(base,status='declined',reason=str(error)[:1500])
        from recompyler.ir._entry_native import NativeEntry
        if type(result) is NativeEntry:
            return dict(base,status='compiled',native_compiled=True,installed=False,reason=None)
        if result is fn:
            from recompyler.ir._entry_native import compilation_info
            info=compilation_info(fn)
            if info is None:
                return dict(base,status='declined',reason='public compiler left unsupported function in Python')
            if info['compiled'] and info['body_address']>0:
                return dict(base,status='compiled',native_compiled=True,installed=info['installed'],native_prefix=bool(info.get('native_prefix',False)),compilation_kind=info.get('compilation_kind','native-body'),reason=None)
        return dict(base,status='error',reason='IR compiler did not return a native entry; graphs are not native compilation')
    except Exception as error:
        return dict(base,status='error',reason=type(error).__name__+': '+str(error)[:1500])

def summarize(rows):
    counts = Counter(r['status'] for r in rows)
    families = Counter(r['family'] for r in rows if r['status'] == 'declined')
    nested = [r for r in rows if r['nested']]
    ir_counts=Counter(r.get('ir_path',{}).get('status','not-attempted') for r in rows)
    return dict(total=len(rows), compiled=counts['compiled'], declined=counts['declined'],
        errors=counts['error'], not_attempted=counts['not-attempted'],
        ir_path=dict(total=len(rows),compiled=ir_counts['compiled'],native_prefix=sum(r.get('ir_path',{}).get('native_prefix',False) for r in rows if r.get('ir_path',{}).get('status')=='compiled'),declined=ir_counts['declined'],
            errors=ir_counts['error'],unavailable=ir_counts['unavailable'],not_attempted=ir_counts['not-attempted']),
        nested=dict(total=len(nested), compiled=sum(r['status'] == 'compiled' for r in nested)),
        ranked_families=[dict(family=label, functions=count,
            nested=sum(r['nested'] and r.get('family') == label and r['status'] == 'declined' for r in rows),
            completion_upper_bound=count, completion_proven=0)
            for label, count in sorted(families.items(), key=lambda x: (-x[1], x[0]))])


def _priority():
    if os.name == 'nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)


def worker(repo, relative, skip_indices=()):
    _priority()
    repo = Path(repo).resolve()
    sys.path.insert(0, str(repo / 'src'))
    path = repo / relative
    name = '.'.join(Path(relative).with_suffix('').parts[1:])
    if name.endswith('.__init__'):
        name = name[:-9]
    namespace = {}
    mode = 'source-only'
    import_error = None
    try:
        module = importlib.import_module(name)
        if Path(module.__file__).resolve() != path.resolve():
            raise RuntimeError('module came from a different checkout')
        namespace = vars(module).copy()
        mode = 'imported-module'
    except Exception as exc:
        import_error = type(exc).__name__ + ': ' + str(exc)
    rows = inventory(path)
    functions = source_functions(path, namespace)
    for row, fn in zip(rows, functions):
        if row['index'] in skip_indices:
            continue
        row.update(path=relative, namespace=mode, import_error=import_error,
                   closure_values='unbound' if fn.__closure__ else 'none')
        row.update(attempt(fn))
        row['ir_path']=attempt_ir(fn)
        print(json.dumps(row), flush=True)


def publish(output, rows, repo, complete=False):
    summary = summarize(rows)
    head = subprocess.check_output(['git', '-c', 'safe.directory=*', 'rev-parse', 'HEAD'],
                                   cwd=repo, text=True).strip()
    result = dict(schema=1, run='wave18-lift', updated_at=datetime.now(timezone.utc).isoformat(),
        repo=str(repo), commit=head, complete=complete, admission_only=True,
        note='No target body invocation. Normal module imports supply globals; nested free cells are unbound. First-refusal counts are upper bounds, not proven completions.',
        summary=summary, functions=rows)
    target = output / 'self-census.json'
    temporary = target.with_suffix('.json.tmp')
    temporary.write_text(json.dumps(result, indent=2), encoding='utf-8')
    temporary.replace(target)
    table = ['# Self-compilation admission census', '',
        f"Compiled {summary['compiled']}/{summary['total']}; declined {summary['declined']}; errors {summary['errors']}; unattempted {summary['not_attempted']}.",
        f"Nested: {summary['nested']['compiled']}/{summary['nested']['total']} compiled.", '',
        f"IR native: {summary['ir_path']['compiled']}/{summary['total']} compiled; builder-only graphs never count.", '',
        'Admission only; no execution parity or speed claim. A family fix may expose another refusal.', '',
        '| Legacy first refusal family | Functions | Nested | Completion upper bound | Proven completions | IR native admitted |',
        '|---|---:|---:|---:|---:|---:|']
    for row in summary['ranked_families']:
        ir_admitted=sum(r.get('family')==row['family'] and r.get('ir_path',{}).get('status')=='compiled' for r in rows)
        table.append(f"| {row['family']} | {row['functions']} | {row['nested']} | {row['completion_upper_bound']} | 0 | {ir_admitted} |")
    (output / 'SELF-CENSUS.md').write_text('\n'.join(table) + '\n', encoding='utf-8')
    return result


def restore_previous(previous, rows, commit):
    if previous['commit'] != commit:
        raise ValueError('resume commit differs; run a fresh census')
    current = {(r['path'], r['index']): r for r in rows}
    old_keys={(r['path'],r['index']) for r in previous['functions']}
    if set(current)!=old_keys or len(previous['functions'])!=len(current):
        raise ValueError('resume source population differs')
    for old in previous['functions']:
        key = (old['path'], old['index'])
        if key not in current or any(old[field] != current[key][field] for field in ('qualname', 'line')):
            raise ValueError('resume source population differs')
        if old['status'] != 'not-attempted':
            old = dict(old)
            if old['status'] == 'declined' and old.get('attempts'):
                old['family'] = family(old['attempts'][0]['reason']) if old.get('family') != 'generators' else 'generators'
            current[key] = old
    return list(current.values())


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--output', type=Path)
    parser.add_argument('--budget-seconds', type=float, default=1800)
    parser.add_argument('--module-timeout', type=float, default=900)
    parser.add_argument('--workers', type=int, choices=(1, 2, 3), default=3)
    parser.add_argument('--module', action='append', help='relative file such as heap.py (smoke run)')
    parser.add_argument('--resume', action='store_true', help='continue unchanged source after a bounded partial run')
    parser.add_argument('--skip-indices', default='', help=argparse.SUPPRESS)
    parser.add_argument('--worker', help=argparse.SUPPRESS)
    args = parser.parse_args(argv)
    _priority()
    repo = args.repo.resolve()
    if args.worker:
        worker(repo, args.worker, {int(x) for x in args.skip_indices.split(',') if x})
        return 0
    output = (args.output or repo.parent / 'selfcompile-progress').resolve()
    output.mkdir(parents=True, exist_ok=True)
    scratch = repo / 'lift-evidence' / 's70-census'
    scratch.mkdir(parents=True, exist_ok=True)
    sources = sorted((repo / 'src' / 'recompyler').rglob('*.py'))
    if args.module:
        sources = [p for p in sources if str(p.relative_to(repo / 'src' / 'recompyler')).replace('\\', '/') in args.module]
    all_rows = {}
    for path in sources:
        relative = path.relative_to(repo).as_posix()
        for row in inventory(path):
            row.update(path=relative, status='not-attempted', family='budget', execution_verified=False)
            all_rows[(relative, row['index'])] = row
    if args.resume:
        previous = json.loads((output / 'self-census.json').read_text(encoding='utf-8'))
        head = subprocess.check_output(['git', '-c', 'safe.directory=*', 'rev-parse', 'HEAD'], cwd=repo, text=True).strip()
        dirty = subprocess.check_output(['git', '-c', 'safe.directory=*', 'status', '--porcelain', '--untracked-files=all', '--', 'src/recompyler'], cwd=repo, text=True).strip()
        if dirty:
            raise ValueError('resume requires unchanged compiler source')
        restored = restore_previous(previous, list(all_rows.values()), head)
        all_rows = {(r['path'], r['index']): r for r in restored}
        sources = [p for p in sources if any(r['path'] == p.relative_to(repo).as_posix() and r['status'] == 'not-attempted' for r in restored)]
    publish(output, list(all_rows.values()), repo)
    deadline = time.monotonic() + args.budget_seconds
    def run(path):
        relative = path.relative_to(repo).as_posix()
        timeout = min(args.module_timeout, deadline - time.monotonic())
        if timeout <= 0:
            return []
        stem = relative.replace('/', '_')
        out = scratch / (stem + '.jsonl')
        err = scratch / (stem + '.log')
        with out.open('w', encoding='utf-8') as stream, err.open('w', encoding='utf-8') as errors:
            process = subprocess.Popen([sys.executable, str(Path(__file__).resolve()), '--repo', str(repo), '--worker', relative, '--skip-indices', ','.join(str(r['index']) for r in all_rows.values() if r['path'] == relative and r['status'] != 'not-attempted')],
                cwd=repo, stdout=stream, stderr=errors,
                creationflags=0x08004000 if os.name == 'nt' else 0)
            try:
                process.wait(timeout=timeout)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait()
        records = []
        for line in out.read_text(encoding='utf-8').splitlines():
            try:
                record = json.loads(line)
                if isinstance(record, dict) and 'index' in record:
                    records.append(record)
            except json.JSONDecodeError:
                pass
        print(relative, len(records), 'records', 'exit', process.returncode, flush=True)
        return records
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        for job in as_completed([pool.submit(run, path) for path in sources]):
            for row in job.result():
                all_rows[(row['path'], row['index'])] = row
            publish(output, list(all_rows.values()), repo)
    result = publish(output, list(all_rows.values()), repo, complete=True)
    with (output / 'history.jsonl').open('a', encoding='utf-8') as history:
        history.write(json.dumps({key: result[key] for key in ('updated_at', 'commit', 'summary', 'admission_only')}) + '\n')
    print(json.dumps(result['summary'], indent=2), flush=True)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
