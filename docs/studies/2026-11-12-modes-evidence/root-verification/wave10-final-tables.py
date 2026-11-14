"""Summarize final complete-call medians; do not execute any benchmark."""
import json
from pathlib import Path
root = Path(__file__).resolve().parent
study = root / 'wave10-measurements/results-binding-final'
summary = json.loads((study / 'summary.json').read_text())
cells = {(r['function'], r['variant']): r for r in summary['cells'] if r['task'] in ('time','time-aot')}
variants = ['cpython','current-strict','candidate-strict','checked','unchecked-int64','c-exact','c-wrap']
functions = ['recurrence_1','recurrence_16','recurrence_64','fibonacci','loop_recurrence16']
rows = []
lines = ['| Kernel | CPython | Saved strict | Final strict | Checked | Unchecked | C exact | C wrap |',
         '| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |']
for function in functions:
    times = {v: cells[function, v]['median_ns_per_call'] / 1000 for v in variants}
    assert all(cells[function,v]['children'] == 7 for v in variants)
    lines.append('| ' + function + ' | ' + ' | '.join(f'{times[v]:.3f}' for v in variants) + ' |')
    rows.append({'function': function, 'microseconds': times,
                 'checked_speed_vs_cpython': times['cpython']/times['checked'],
                 'unchecked_speed_vs_cpython': times['cpython']/times['unchecked-int64'],
                 'checked_speed_vs_saved': times['current-strict']/times['checked'],
                 'unchecked_speed_vs_saved': times['current-strict']/times['unchecked-int64']})
(root/'wave10-final-tables.md').write_text('\n'.join(lines)+'\n')
(root/'wave10-final-tables.json').write_text(json.dumps(rows,indent=2)+'\n')
print(json.dumps(rows))
