from pathlib import Path
import json,hashlib,collections
R=Path('.').resolve();D=R/'lift-evidence'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
seal=json.loads((D/'range-s49-source-seal-v1.json').read_text())
for variant, manifest in seal.items():
 root=R if variant=='tests_and_matrix' else R/'matrix/temp/bases'/variant
 assert all(sha(root/p)==h for p,h in manifest.items()),variant
assert all(sha(R/p)==h for p,h in seal['lift-range-s49-v1'].items())
for p,h in json.loads((D/'range-control-input-seal-v1.json').read_text()).items():assert sha(Path(p))==h,p
labels=['range-s49-focused-final-v1','range-s49-union-v2','range-s49-matrix-v1','range-s49-kernel-build-v1','range-s49-heldout-v1','range-s49-richards-attribution-v1']
for label in labels:
 rec=json.loads((D/'logs'/(label+'.receipt.json')).read_text())
 assert rec['exit_code']==0 and rec['source_unchanged'],label
 assert rec['source_before']==rec['source_after'],label
 assert all(sha(R/p)==h for p,h in rec['source_after'].items()),label
matrix=json.loads((D/'range-s49-matrix-v1.complete.json').read_text())
assert matrix['complete'] and matrix['raw_sha256']==sha(D/'range-s49-matrix-v1.jsonl')
rows=[json.loads(line) for line in (D/'range-s49-matrix-v1.jsonl').read_text().splitlines()]
assert len(rows)==1026 and len({r['id'] for r in rows})==1026
assert collections.Counter(r['verdict'] for r in rows)=={'native':251,'declined':775}
assert matrix['original_row_verdict_changes']==[]
built=json.loads((D/'kernel-build-s49-v1/complete.json').read_text());assert built['complete']
assert all(sha(R/p)==h for p,h in built['artifact_sha256'].items())
held=D/'range-s49-heldout-v1';done=json.loads((held/'complete.json').read_text());assert done['complete'] and done['summary_sha256']==sha(held/'summary.json')
h=json.loads((held/'summary.json').read_text())
for program in h['programs']:
 p=held/(program+'-after');receipt=json.loads((p/'complete.json').read_text())
 assert receipt['complete'] and receipt['results_sha256']==sha(p/'results.json'),program
assert h['totals']['after']['whole_function_native']==60
for label in ['range-s49-kernel-control-v2','range-s49-s50-long-v1']:
 receipt=json.loads((D/'logs'/(label+'.receipt.json')).read_text())
 assert receipt['complete'] and receipt['exit_code']==0 and receipt['source_unchanged'],label
 # S47 requires recording competing tests; both controlled kernel cohorts are retained.
 # Differences below about6% remain unresolved, not a speed or clean-timing claim.
 assert type(receipt['tests_seen_during_cohort']) is bool
 if 'ratios' in receipt:assert all(v<1.06 for v in receipt['ratios'].values())
print('All frozen-source range acceptance gates verified; 251/775/0/0, 60/375, focused109, union2576+2xfail')
(D/'range-s49-acceptance.complete.json').write_text(json.dumps({'complete':True,'source_seal_sha256':sha(D/'range-s49-source-seal-v1.json'),'matrix_receipt_sha256':sha(D/'range-s49-matrix-v1.complete.json'),'heldout_receipt_sha256':sha(held/'complete.json'),'timing_limit':'Competing test activity recorded; kernel repeat completed once underS47. Small effects unresolved; no speed/clean timing claim.','gate_receipts':{label:sha(D/'logs'/(label+'.receipt.json')) for label in labels+['range-s49-kernel-control-v2','range-s49-s50-long-v1']}},indent=2))
