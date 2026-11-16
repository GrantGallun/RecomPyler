"""Seal the two complete S46 diagnostic passes and report conservative ranges."""
from pathlib import Path
import hashlib,json
from freeze_build_step0 import inventory
R=Path(__file__).resolve().parents[1];D=R/'inplace'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def main():
 labels=('s46-ten-components-v7','s46-ten-components-v8');passes=[];seals={}
 for label in labels:
  folder=D/label;receipt=D/'logs'/f'{label}.receipt.json';data=json.loads((folder/'complete.json').read_text());run=json.loads(receipt.read_text())
  assert data['complete'] and len(data['rows'])==10 and run['exit_code']==0 and run['correctness_observation_complete']
  assert inventory(R/'src')==data['source_manifest']
  assert all(sha(p)==h for p,h in data['helper_sha256'].items())
  assert all(sha(p)==h for p,h in data['plain_baseline_sha256'].items())
  for row in data['rows']:
   assert len(row['attempts'])==8 and row['valid']
   for attempt in row['attempts']:
    assert attempt['components_reconcile'] and attempt['component_sum_ns']==attempt['attempt_ns']
    assert attempt['result_and_arguments_equal'] and attempt['counter_delta']==[1,1,0,0]
    assert attempt['native_entries']>=1 and all(e['actual_dispatcher'] and e['status_after']==0 for e in attempt['native_events'])
  for program in {r['program'] for r in data['rows']}:
   child=json.loads((folder/program/'complete.json').read_text());assert child['complete'] and child['behavior_equal']
   assert child['data_sha256']==sha(folder/program/'data.json')
   assert json.loads((folder/program/'child.receipt.json').read_text())['exit_code']==0
  seals[label]={'complete_sha256':sha(folder/'complete.json'),'timing_receipt_sha256':sha(receipt),'timing_audit_sha256':sha(D/'logs'/f'{label}.audit.json'),'other_correctness_seen':run['other_correctness_seen']}
  passes.append({r['function']:r for r in data['rows']})
 assert passes[0].keys()==passes[1].keys()
 rows=[]
 for name,a in passes[0].items():
  records=[]
  for source in passes:
   r=source[name];m=r['mean_exclusive_us'];records.append(dict(total=r['mean_complete_us'],load=m['load_ns'],native_envelope=m['native_ns'],writeback=m['writeback_ns'],other=r['mean_complete_us']-m['load_ns']-m['native_ns']-m['writeback_ns'],named_other={k:v for k,v in m.items() if k not in ('load_ns','native_ns','writeback_ns')}))
  rows.append(dict(function=name,program=a['program'],passes=records,ranges={k:[min(r[k] for r in records),max(r[k] for r in records)] for k in ('total','load','native_envelope','writeback','other')},effect_reports=a['effect_reports']))
 output=dict(complete=True,diagnostic_only=True,performance_acceptance=False,source_manifest=inventory(R/'src'),passes=seals,rows=rows,excluded=['s46-ten-components-v5 failed entire cohort','s46-ten-components-v6 unstarted cancelled'],native_body_isolated=False,observer_retained=True,limitations='Two complete source-identical disturbed development passes, eight uniform samples each, no rare extras. Ranges are replay instrumentation sizes, not shares of earlier selection medians or guaranteed removable savings. Native includes CPUDispatcher and boxing. Other retains observers, guards, outputs and mandatory controls. No elapsed-time aggregates across functions.')
 (D/'S46-TEN-BOUND.json').write_text(json.dumps(output,indent=2))
 text=['# S46 ten-region component diagnostic','', 'Both complete source-identical passes are retained (v7 and the one required disturbed repeat v8). Every row has eight warmed uniform replay samples per pass, actual successful CPUDispatcher calls and exact existing result/argument checks. All four application on/off outputs match the prior completed selection. Peer correctness was alive at Normal priority in both passes; actual priorities and process IDs are recorded. This is descriptive development evidence only. Failed v5 contributes nothing.','', 'Times below are min–max of the two pass means, in microseconds per observed complete replay. Timers and native-entry observation remain installed. Native is the dispatcher/body/boxing envelope; pure machine-body time is not isolated. These totals differ from the earlier selection context and cannot be subtracted from its medians.','', '| Region | Complete | Load | Native envelope | Write-back | Other |','|---|---:|---:|---:|---:|---:|']
 for row in rows:
  def cell(k):return '–'.join(f'{x:.2f}' for x in row['ranges'][k])
  text.append('| '+row['function']+' | '+' | '.join(cell(k) for k in ('total','load','native_envelope','writeback','other'))+' |')
 text+=['','## Decision and limits','','Load is the largest named non-observer component in the large Richards calls. HandlerTask.fn is 423.50–478.30us; DeviceTask.fn 301.14–331.20us; the third-largest load differs by pass (Task.runTask262.11us in v7, Task.qpkt330.43us in v8). There is no summed “unlocked time”: these calls overlap and have different frequencies. The small native envelope does not explain the large completed-call gap. Direct input payload access remains the next implementation direction, before vectorcall.','','Load plus write-back is an upper envelope of work touched by Steps2/3, not an achievable saving. A fresh callback-free layout/kind/alias/root validation walk, strong interval pins and result materialization remain necessary; no component is declared wholly removable. Direct reads avoid numeric payload staging for certified read-only cells; direct stores replace publication with guarded journal work. Output allocation and identity-preserving object materialization remain. RNG and mandatory guards are not silently dropped. No new deployment count or speedup is claimed.','','All ten effect summaries include writes, including writes to private temporaries. Spline.__call__ reads caller inputs but creates a private work list and returns either an original point or a new GVector. Treating a private allocation as an arbitrary caller-object write or treating its output as always fresh are both unsound. Constructor-origin unknowns affect chaos/gc; Hex.link_nodes has object-shape unknowns; the existing conservative effect lattice reports no unknowns for the checked Richards variants or Done.filter_tiles, but that alone proves neither physical roots nor source-owner transfers. The shared layer and consumer runtime certificates must close each obligation before direct execution.','','The complete named-other breakdown for each pass follows; observer bookkeeping is measured overhead, not product saving.']
 for row in rows:
  text+=['','### '+row['function'],'','| Other component | v7 us | v8 us |','|---|---:|---:|']
  for k in row['passes'][0]['named_other']:
   text.append(f"| {k.removesuffix('_ns')} | {row['passes'][0]['named_other'][k]:.3f} | {row['passes'][1]['named_other'][k]:.3f} |")
 text+=['','Evidence: S46-TEN-BOUND.json retains source and receipt hashes. Source/input/shim/application checks are in each pass complete.json and each program complete.json. The earlier 33-program selection remains2022captured/100verified/2deployed,2programs. The86sub-microsecond Python regions have no measured standalone profitable route; their useful direction remains compiled callers/inlining, as CHECKPOINT80 records.']
 (D/'S46-TEN-BOUND.md').write_text('\n'.join(text)+'\n',encoding='utf8')
 print('Verified 2 complete passes, 10 regions, 160 successful observed calls')
if __name__=='__main__':main()
