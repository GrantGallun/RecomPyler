"""Four below-normal pytest shards, no timing lock or provider injection."""
from concurrent.futures import ThreadPoolExecutor
import os
from pathlib import Path
import subprocess
import sys

root = Path(__file__).resolve().parents[1]
label = sys.argv[1]
files = sorted((root / 'tests').glob('test_*.py'))
workers = int(os.environ.get('WAVE16_CORRECTNESS_WORKERS', '4'))
assert 1 <= workers <= 4
shards = [[] for _ in range(workers)]
loads = [0] * workers
for path in sorted(files, key=lambda p:p.stat().st_size, reverse=True):
    index = loads.index(min(loads))
    shards[index].append(str(path.relative_to(root)))
    loads[index] += path.stat().st_size

def run(pair):
    index, paths = pair
    log = root / 'inplace' / (label + '-shard' + str(index) + '.txt')
    temp = root / 'inplace' / 'flat-temp' / (label + '-' + str(index))
    env = dict(os.environ, PYTHONPATH=str(root / 'src'), RECOMPYLER_CACHE=str(temp / 'cache'), NUMBA_CACHE_DIR=str(temp / 'numba'))
    command = [sys.executable, '-m', 'pytest', '-q', '--basetemp=' + str(temp), *sorted(paths)]
    with log.open('w') as stream:
        stream.write('Command: ' + repr(command) + '\n'); stream.flush()
        result = subprocess.run(command, cwd=root, env=env, stdout=stream, stderr=subprocess.STDOUT, creationflags=subprocess.BELOW_NORMAL_PRIORITY_CLASS | subprocess.CREATE_NO_WINDOW)
    print('shard', index, 'exit', result.returncode, 'files', len(paths), 'log', log.name, flush=True)
    return result.returncode

with ThreadPoolExecutor(max_workers=workers) as pool:
    codes = list(pool.map(run, enumerate(shards)))
sys.exit(max(codes))
