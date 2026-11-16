"""Run each test file once, on one of four below-normal workers."""
import os
from pathlib import Path
import subprocess
import sys
import zlib

ROOT = Path(__file__).resolve().parents[1]
LABEL = os.environ.get('RECOMPYLER_SUITE_LABEL','original-context')
if len(sys.argv) == 2:
    import psutil
    import pytest
    worker = int(sys.argv[1])
    psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
    os.chdir(ROOT)
    sys.path.insert(0, str(ROOT / 'src'))
    os.environ['PYTHONPATH'] = str(ROOT / 'src')
    temporary = ROOT / 'matrix' / 'temp' / f'context-suite-{worker}'
    temporary.mkdir(parents=True, exist_ok=True)
    for key in ('TEMP', 'TMP', 'TMPDIR'):
        os.environ[key] = str(temporary)
    class Files:
        def pytest_collection_modifyitems(self, config, items):
            selected, deselected = [], []
            for item in items:
                name = item.path.relative_to(ROOT).as_posix()
                group = zlib.crc32(name.encode()) % 4
                (selected if group == worker else deselected).append(item)
            config.hook.pytest_deselected(items=deselected)
            items[:] = selected
    raise SystemExit(pytest.main(['tests', '-q', '--tb=short', '-o',
        f'cache_dir=matrix/temp/context-cache-{worker}'], plugins=[Files()]))
children = []
for worker in range(4):
    log = (ROOT / 'matrix' / f'{LABEL}-suite-{worker}.log').open('w', encoding='utf-8')
    child = subprocess.Popen([sys.executable, __file__, str(worker)],
        cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    children.append((worker, child, log))
failed = False
for worker, child, log in children:
    status = child.wait()
    log.close()
    print(f'worker {worker}: exit {status}', flush=True)
    failed |= status != 0
raise SystemExit(int(failed))
