"""Concrete independent-review counterexamples, executed against selectable source."""
import json,sys,os
from pathlib import Path
R=Path(__file__).resolve().parents[1]
# Select the baseline product before importing the shared harness.
sys.path.insert(0,str(R/'matrix'))
import run_matrix as m
if len(sys.argv)>2:
    # run_matrix respects this environment only in a fresh process.
    raise RuntimeError('select product with MATRIX_PRODUCT_SOURCE')
from catalogue import Case
probes=[]
for n,(a,b) in enumerate([('2**53+1','float(2**53)'),('2**63-1','float(2**63)')]):
 for op,label in [('==','eq'),('>','gt'),('<=','le')]:probes.append(Case('review.mixed'+str(n)+'.'+label,'review','return a '+op+' b','a,b','('+a+','+b+')'))
probes += [Case('review.tuple_nan_shared','review','return a==b','a,b','((NAN,),(NAN,))','NAN=float("nan")'),
           Case('review.literal_index_high','review','return [1,2][3]'),Case('review.literal_index_low','review','return [1,2][-3]')]
rows=[]
for c in probes:
 row=m.run_case(c);rows.append(row);print(c.id,row['verdict'],row.get('reason','').splitlines()[0][:150] if row.get('reason') else '',flush=True)
(R/sys.argv[1]).write_text('\n'.join(json.dumps(r) for r in rows)+'\n')
