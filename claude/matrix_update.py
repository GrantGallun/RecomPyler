"""Run every language-matrix row; print changes against the pins; with --write update pins
for rows that moved to native. Any wrong/crash row is printed and never pinned."""
import json, sys, collections
from pathlib import Path
R = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(R / 'matrix')); sys.path.insert(0, str(R / 'src'))
from catalogue import cases
from run_matrix import run_case
path = R / 'matrix/matrix.json'
doc = json.loads(path.read_text(encoding='utf-8'))
rows = {r.id: r for r in cases()}
count = collections.Counter(); changed = []
for pin in doc['rows']:
    row = run_case(rows[pin['id']])
    verdict = 'harness_error' if row.get('harness_error') else row['verdict']
    count[verdict] += 1
    if verdict != pin['verdict']:
        changed.append((pin['id'], pin['verdict'], verdict, str(row.get('reason', row.get('detail', '')))[:160]))
        if '--write' in sys.argv and verdict == 'native' and pin['verdict'] == 'declined':
            pin.update(row)
print(dict(count))
for c in changed: print('CHANGED', *c)
if '--write' in sys.argv:
    if 'counts' in doc and isinstance(doc['counts'], dict):
        tally = collections.Counter(p['verdict'] for p in doc['rows'])
        for key in list(doc['counts']):
            if key in ('native', 'declined', 'wrong', 'crash'): doc['counts'][key] = tally.get(key, 0)
    path.write_text(json.dumps(doc, indent=1) + '\n', encoding='utf-8')
