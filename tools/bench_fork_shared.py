"""Compare the fork's unchanged default policy with stock on the S94 programs.

Uses the committed wave21 workers, digest checks, intervals and whole-set metric.
The candidate is the fork with its default library hook and JIT enabled. Fork-only
native-frame/numeric providers remain off, as required by their failed speed gate.
"""
import argparse
from contextlib import contextmanager
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import uuid

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / 'src'))


def utc():
    return datetime.now(timezone.utc).isoformat()


@contextmanager
def timing_session(root, purpose):
    lock = root / 'TIMING.lock'
    lock.mkdir()
    token = 'wave20-cinder-' + uuid.uuid4().hex
    owner = lock / 'owner.txt'
    ledger = root / 'WAVE20-CINDER-PLAN.md'
    def record(action):
        with ledger.open('a', encoding='utf-8') as stream:
            stream.write(f'\n- TIMING {action} {utc()} {token} {purpose}.\n')
    try:
        owner.write_text(f'{token}\nclass: development\npurpose: {purpose}\nstart: {utc()}\nexpected: 600 seconds\n')
        record('acquire')
        yield
    finally:
        if owner.exists() and owner.read_text().splitlines()[0] == token:
            owner.unlink()
            lock.rmdir()
            record('release')


def run_case(name, *, stock, fork, pypy=None, pairs=3, split='train',
             root=ROOT.parent, harness=None, test_processes=None,
             cache_state='cold', library_cache=None):
    if type(pairs) is not int or pairs < 3:
        raise ValueError('at least three fresh process pairs required')
    if cache_state not in ('cold', 'warm'):
        raise ValueError('explicit cold or warm cache state required')
    if cache_state == 'warm':
        if library_cache is None or not Path(library_cache).is_dir():
            raise ValueError('warm requires an existing explicit library cache')
        library_cache = Path(library_cache).resolve()
    elif library_cache is not None:
        raise ValueError('cold must not supply a library cache')
    if harness is None:
        from bench.libs import shared_harness as harness
    if test_processes is None:
        from bench.libs.timing_runner import test_processes
    engines = list(harness.ENGINES) + (['pypy'] if pypy else [])
    stock, fork = Path(stock).resolve(), Path(fork).resolve()
    pypy = Path(pypy).resolve() if pypy else None
    executables = dict(cpython_off=stock, cpython_on=stock, recompyler=fork, pypy=pypy)
    repeats = 1 if name == 'selfcompile' else 64
    samples = []
    before = test_processes()
    with timing_session(root, 'S97 fork '+cache_state+' whole-program ' + name):
        for pair in range(pairs):
            sample = {}
            for engine in engines[::1 if pair % 2 == 0 else -1]:
                sample[engine] = harness.observe(name, engine, executable=executables[engine],
                    repeats=repeats, split=split, run_name='wave20-cinder',
                    cache_state=cache_state if engine == 'recompyler' else 'existing',
                    library_cache=library_cache if engine == 'recompyler' else None)
            samples.append(sample)
    after = test_processes()
    ok = harness.validate_samples(samples)
    return dict(name=name, status='ok' if ok else 'error', repeats=repeats, samples=samples, cache_state=cache_state,
        summary={e: harness.interval([s[e]['seconds'] for s in samples])
                 for e in engines if all(s[e]['status'] == 'ok' for s in samples)},
        concurrent_tests_before=before, concurrent_tests_after=after)


def file_hash(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def executable_identity(path):
    path = path.resolve(strict=True)
    # The Python DLL contains the interpreter; hashing only python.exe is insufficient.
    images = [path] + sorted(path.parent.glob('*.dll'))
    return dict(path=str(path), images={str(p): file_hash(p) for p in images})


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--stock', type=Path, default=Path('C:/Python314/python.exe'))
    parser.add_argument('--fork', type=Path, default=ROOT.parent/'cpython-rp/PCbuild/amd64/python.exe')
    parser.add_argument('--pypy', type=Path)
    parser.add_argument('--pairs', type=int, default=3)
    parser.add_argument('--only', nargs='+')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--resume', action='store_true')
    parser.add_argument('--cache-state', choices=('cold', 'warm'), required=True)
    parser.add_argument('--library-cache', type=Path)
    args = parser.parse_args(argv)
    if args.pairs < 3: parser.error('at least three pairs required')
    if args.cache_state == 'warm' and (args.library_cache is None or not args.library_cache.is_dir()):
        parser.error('warm requires --library-cache pointing to an existing directory')
    if args.cache_state == 'cold' and args.library_cache is not None:
        parser.error('--library-cache requires warm cache state')
    if os.name == 'nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
    from bench.libs import shared_harness as shared
    from bench.libs.programs import manifest
    names = list(manifest('train'))
    selected = args.only or names
    if not set(selected) <= set(names): parser.error('program outside frozen training set')
    def fingerprint():
        digest = hashlib.sha256((shared.source_fingerprint() + file_hash(Path(__file__))).encode())
        for path in sorted((ROOT/'src/recompyler/stencils').glob('*.json')):
            digest.update(path.name.encode()); digest.update(path.read_bytes())
        return digest.hexdigest()
    source_hash = fingerprint()
    config = dict(pairs=args.pairs, stock=executable_identity(args.stock),
        fork=executable_identity(args.fork), pypy=executable_identity(args.pypy) if args.pypy else None,
        candidate='fork current default library hook, JIT on; fork-native/numeric_ops off',
        cache_state=args.cache_state,
        library_cache=str(args.library_cache.resolve()) if args.library_cache else None,
        cache_sha256=shared.cache_fingerprint(args.library_cache) if args.library_cache else None)
    rows = []
    if args.resume and args.output.exists():
        previous = json.loads(args.output.read_text())
        rows = shared.resume_rows(previous, 'train', source_hash, config)
    for name in selected:
        if any(r['name'] == name and r['status'] == 'ok' for r in rows): continue
        if fingerprint() != source_hash: raise RuntimeError('source changed during measurement')
        print('MEASURE ' + name, flush=True)
        row = run_case(name, stock=args.stock, fork=args.fork, pypy=args.pypy, pairs=args.pairs,
            cache_state=args.cache_state, library_cache=args.library_cache)
        if fingerprint() != source_hash: raise RuntimeError('source changed during measurement')
        # Detect interpreter rebuilds just as strictly as native-provider changes.
        if executable_identity(args.stock) != config['stock'] or executable_identity(args.fork) != config['fork']:
            raise RuntimeError('interpreter changed during measurement')
        if args.pypy and executable_identity(args.pypy) != config['pypy']:
            raise RuntimeError('PyPy changed during measurement')
        rows = [r for r in rows if r['name'] != name] + [row]
        report = dict(schema=1, split='train', config=config, source_sha256=source_hash,
            head=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
            utc=utc(), metric='whole process wall seconds including startup, imports, setup, compilation and exit',
            confidence='95% bootstrap from canonical wave21 shared_harness',
            rows=rows, headline=shared.headline(rows, names))
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(report, indent=2))
        print(json.dumps(dict(name=name, status=row['status'], headline=report['headline'])), flush=True)
    return int(any(r['status'] != 'ok' for r in rows))


if __name__ == '__main__':
    raise SystemExit(main())
