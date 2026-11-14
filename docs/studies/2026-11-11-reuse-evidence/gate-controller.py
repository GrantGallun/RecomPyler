"""Run the independent Richards native gate; no latency samples are produced."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    source, out = args.source.resolve(), args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    assert not (out / 'build-process.json').exists(), 'Use a new gate directory'
    (out / 'temp').mkdir(exist_ok=True)
    gate = Path(__file__).with_name('wave3_richards_gate.py')
    revision = subprocess.check_output(['git', '-C', str(source), 'rev-parse', 'HEAD'], text=True).strip()
    files = {str(p.relative_to(source / 'src')): hashlib.sha256(p.read_bytes()).hexdigest()
             for p in sorted((source / 'src').rglob('*')) if p.is_file() and '__pycache__' not in p.parts}
    base_env = dict(os.environ, PYTHONPATH=str(source / 'src'), RECOMPYLER_CACHE=str(out / 'cache'),
                    NUMBA_CACHE_DIR=str(out / 'numba'), TEMP=str(out / 'temp'), TMP=str(out / 'temp'),
                    PYTHONPYCACHEPREFIX=str(out / 'bytecode'), PYTHONWARNINGS='ignore')
    rows = []
    for mode, seed, python_loader in [('build', '11', False), ('run', '17', False), ('run', '29', False),
                                      ('run', '37', True), ('run', '53', True)]:
        label = mode if mode == 'build' else 'run-' + seed
        env = dict(base_env, PYTHONHASHSEED=seed)
        command = [sys.executable, str(gate), mode, str(out)]
        if python_loader:
            command.append('--python-loader')
        completed = subprocess.run(command, cwd=out, env=env, capture_output=True, text=True, timeout=300)
        (out / (label + '.stdout')).write_text(completed.stdout)
        (out / (label + '.stderr')).write_text(completed.stderr)
        row = dict(command=command, seed=seed, exit_code=completed.returncode, timing_eligible=False,
                   source_revision=revision, stdout=completed.stdout, stderr=completed.stderr)
        if mode == 'build':
            row['source_sha256'] = files
            (out / 'build-process.json').write_text(json.dumps(row, indent=2) + '\n')
        else:
            rows.append(row)
            (out / 'deployment.json').write_text(json.dumps(rows, indent=2) + '\n')
        if completed.returncode:
            print(label, completed.stdout[-2000:], completed.stderr[-4000:], flush=True)
            return completed.returncode
        print(label, completed.stdout.splitlines()[-1], flush=True)
    print('Four fresh real-workload AOT deployments passed; these are correctness gates, not timing samples.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
