"""Freeze and run the reviewed combined suite, retaining raw evidence."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

root = Path(__file__).resolve().parent
source = root / 'wave10-combined'
output = root / 'wave10-validation' / 'full-suite'
output.mkdir(parents=True, exist_ok=False)
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
def inputs():
    return {p.relative_to(source).as_posix(): sha(p)
            for folder in ('src', 'tests') for p in sorted((source / folder).rglob('*'))
            if p.is_file() and p.suffix in {'.py', '.pyd', '.dll', '.c', '.h'}
            and '__pycache__' not in p.parts}
def write(name, value):
    (output / name).write_text(json.dumps(value, indent=2) + '\n')
before = inputs()
head = subprocess.check_output(['git', '-C', str(source), 'rev-parse', 'HEAD'], text=True).strip()
write('before-inputs.json', before)
write('candidate-freeze.json', {'commit': head, 'inputs': before})
env = os.environ.copy()
env.update(PYTHONPATH=str(source / 'src'), PYTHONDONTWRITEBYTECODE='1',
           RECOMPYLER_CACHE=str(output / 'cache'), NUMBA_CACHE_DIR=str(output / 'numba'),
           OMP_NUM_THREADS='1', OPENBLAS_NUM_THREADS='1', NUMBA_NUM_THREADS='1',
           MKL_NUM_THREADS='1', NUMEXPR_NUM_THREADS='1', PYTHONHASHSEED='0')
command = [sys.executable, '-B', '-m', 'pytest', '-q']
start = time.perf_counter()
with (output / 'stdout.log').open('wb') as stdout, (output / 'stderr.log').open('wb') as stderr:
    completed = subprocess.run(command, cwd=source, env=env, stdout=stdout, stderr=stderr)
after = inputs()
write('after-inputs.json', after)
receipt = {'commit': head, 'command': command, 'exit_code': completed.returncode,
           'wall_seconds': time.perf_counter()-start, 'inputs_unchanged': before == after,
           'changed_inputs': [k for k in before.keys() | after.keys() if before.get(k) != after.get(k)],
           'stdout_sha256': sha(output / 'stdout.log'), 'stderr_sha256': sha(output / 'stderr.log')}
write('receipt.json', receipt)
print(json.dumps(receipt))
raise SystemExit(completed.returncode or int(before != after))
