"""Create byte-exact local evidence without caches or transient build objects."""
import hashlib
import json
from pathlib import Path
import shutil

root = Path(__file__).resolve().parent
target = root / 'wave10-integration/docs/studies/2026-11-12-modes-evidence'
target.mkdir(parents=True, exist_ok=False)
entries = []
def copy(source, relative):
    source = Path(source)
    destination = target / relative
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, destination)
    digest = hashlib.sha256(source.read_bytes()).hexdigest()
    assert hashlib.sha256(destination.read_bytes()).hexdigest() == digest
    entries.append({'source': str(source), 'archive': Path(relative).as_posix(),
                    'bytes': source.stat().st_size, 'sha256': digest})
def tree(source, relative, predicate=lambda p: True):
    source = Path(source)
    for path in sorted(source.rglob('*')):
        if path.is_file() and '__pycache__' not in path.parts and path.suffix not in {'.pyc','.pyo'} and predicate(path):
            copy(path, Path(relative) / path.relative_to(source))

measure = root / 'wave10-measurements'
for path in sorted(measure.iterdir()):
    if path.is_file() and path.suffix in {'.py','.md','.c'}:
        copy(path, Path('postprocessing') / path.name)
for name, label in [('results-formal-v1','numeric-prototype'), ('results-binding-final','numeric-final')]:
    source = measure / name
    assert (source / 'manifest.json').exists(), source
    for path in sorted(source.iterdir()):
        if path.is_file() and path.suffix in {'.json','.md'}:
            copy(path, Path(label) / path.name)
    for folder in ('helpers','inputs','processes','cells','aot-assembly'):
        if (source / folder).exists():
            tree(source / folder, Path(label) / folder)
    for folder in ('aot','build'):
        tree(source / folder, Path(label) / folder,
             lambda p: p.suffix in {'.json','.pyd','.dll','.ll','.py'})

coverage = measure / 'coverage-formal-v1'
for path in sorted(coverage.iterdir()):
    if path.is_file(): copy(path, Path('coverage') / path.name)
for folder in ('programs','shim','shim-extended32','state-processes'):
    tree(coverage / folder, Path('coverage') / folder)
tree(coverage / 'state', 'coverage/state', lambda p: p.suffix in {'.json','.pyd','.py','.txt'})
tree(measure / 'coverage-formal-v1-helpers', 'coverage/helpers')
tree(coverage / 'cache', 'coverage/aot-cache', lambda p: p.suffix == '.pyd')

for folder in ('wave10-independent-review','wave10-binding-analysis','wave10-validation/full-suite'):
    tree(root / folder, Path('validation') / Path(folder).name,
         lambda p: p.suffix in {'.json','.md','.txt','.log','.py','.stdout','.stderr'}
         and not any('cache' in x.lower() or x.endswith(('-numba','-temp')) or x == '__pycache__'
                     for x in p.relative_to(root / folder).parts[:-1]))
for name in ('DESIGN.md','combined-review-red.txt','combined-review-green.txt','combined-focused-union.txt','combined-review-input-map.json','numeric-freeze-final.txt'):
    copy(root / 'wave10-modes-analysis' / name, Path('validation/numeric') / name)
for name in ('VALIDATION.md','COVERAGE-NEXT.md','frozen-ranking.json','product-native-freeze.json'):
    copy(root / 'wave10-coverage-analysis' / name, Path('validation/coverage') / name)
for path in sorted(root.glob('wave10-*')):
    if path.is_file() and path.suffix in {'.py','.json'}:
        copy(path, Path('root-verification') / path.name)
for path in sorted(measure.glob('cpu-grant-*.json')):
    copy(path, Path('root-verification') / path.name)
for folder in ('smoke-v1','smoke-v2'):
    # Keep small setup/semantic records; these are never timing data.
    source = measure / folder
    for name in ('manifest.json','SMOKE-VERIFICATION.json'):
        if (source / name).exists(): copy(source / name, Path('mechanics') / folder / name)
    tree(source / 'processes', Path('mechanics') / folder / 'processes')

(target / '.gitattributes').write_bytes(b'* -text\n')
(target / 'archive-manifest.json').write_text(json.dumps({'files': entries, 'file_count': len(entries),
    'total_bytes': sum(x['bytes'] for x in entries),
    'scope': 'Actual successful cohorts, selected code and native artifacts, tests/reviews and retained setup failures. No performance samples pooled across source versions. Build objects, JIT caches and bytecode omitted; raw originals remain in their recorded workspace paths.'}, indent=2)+'\n')
print(json.dumps({'files': len(entries), 'bytes': sum(x['bytes'] for x in entries), 'archive': str(target)}))
