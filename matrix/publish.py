"""Publish only executed verdicts, with row-level raw evidence provenance."""
import argparse,collections,json,re,sys
from pathlib import Path
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(R/'matrix'))
from weights import evidence

def main():
 p=argparse.ArgumentParser();p.add_argument('inputs',nargs='+');p.add_argument('--output',default='matrix/matrix.json');a=p.parse_args()
 rows={};sources={}
 for name in a.inputs:
  path=R/name;sources[name]=name
  for line in path.read_text(encoding='utf-8-sig').splitlines():
   row=json.loads(line);row['execution_evidence']=name;rows[row['id']]=row
 assert not any(r.get('harness_error') for r in rows.values()),'unresolved harness errors cannot be published'
 e=evidence();flat=[r for g in e['groups'].values() for r in g['frames']]
 for row in rows.values():
  associated=[]
  if row['verdict'] in ('declined','crash'):
   id=row['id'];needle=None
   if id.startswith('method.'):
    _,kind,method=id.split('.',2);needle=kind+" method '"+method+"'"
   elif 'bytes' in id:needle='bytes'
   elif id.startswith('literal.fstring'):needle='f-string'
   elif id=='statement.annotated_assign':needle='AnnAssign'
   elif id=='statement.with_single' or id=='statement.with_multiple':needle='With at line'
   elif id=='call.varargs':needle='*args'
   elif id=='call.varkw':needle='**kwargs'
   if needle:associated=[f for f in flat if needle in f['reason']]
  row['heldout_association']={'old_self_s':sum(f['old_self_s'] for f in associated) if associated else None,'frames':associated,'interpretation':'historical first-decline association, not measured unlocked time; repeated across related rows, do not sum rows'}
 counts=collections.Counter(r['verdict'] for r in rows.values());groups={}
 for name in sorted({r['group'] for r in rows.values()}):groups[name]=dict(collections.Counter(r['verdict'] for r in rows.values() if r['group']==name))
 data={'schema':'wave17-executed-matrix-v1','input_specific':True,'python':sys.version,'rows':list(rows.values()),'counts':dict(counts),'groups':groups,'raw_inputs':list(sources),'heldout_evidence':'matrix/heldout-evidence.json'}
 target=R/a.output;target.write_text(json.dumps(data,indent=2,ensure_ascii=True),encoding='utf-8')
 lines=['# Executed Python language matrix','',f'Installed interpreter: `{sys.version.splitlines()[0]}`. Every verdict below comes from the recorded construct execution; it is specific to the supplied inputs.','', '| Group | Native | Declined | Wrong | Crash |','|---|---:|---:|---:|---:|']
 for group,c in groups.items():lines.append('| '+group+' | '+' | '.join(str(c.get(v,0)) for v in ('native','declined','wrong','crash'))+' |')
 lines+=['| **Total** | '+' | '.join(str(counts.get(v,0)) for v in ('native','declined','wrong','crash'))+' |','', 'Native requires an observed successful native counter increment and matching value/type, exception/chaining, argument poststate, alias relationships, fixture events, stdout and stderr. Declined requires identical Python behavior with an observed decline/guard; hidden compiler failures remain crashes. The full source, input, reference, compiled outcome, reason and raw output path of each row are in [matrix.json](matrix.json).','', '## Every row','', '| Construct | Verdict | Decline / failure | Associated old self s |','|---|---|---|---:|']
 for row in rows.values():
  reason=re.sub(r'\x1b\[[0-9;]*m','',row.get('reason','')).splitlines()[0] if row.get('reason') else ''
  reason=reason.replace('|','\\|');weight=row['heldout_association']['old_self_s']
  lines.append('| '+row['id']+' | '+row['verdict']+' | '+reason[:240]+' | '+('unknown' if weight is None else f'{weight:.9f}')+' |')
 lines+=['','## Weight limits','', 'Associations use retained wave14 own-self weights and actual first declines. Related rows repeat the same frames; row weights must not be summed. Primary hot-entry envelopes overlap and are retained individually in heldout-evidence.json. Base64 dominates bytes; FastAPI dominates With and its busy-wait is instrumentation sensitive. Leave-largest-program-out figures and top contributors are in heldout-evidence.json. No new wave14 profile was run to reconstruct unavailable C-target counts. All public builtin functions/types and public methods of the requested ten types are exercised.','', 'The AST/keyword inventory is generated-source coverage, not a support verdict. Incompatible operator/type combinations intentionally test exception and fallback behavior. Native generator rows apply to complete draining; generator-return rows also compare StopIteration.value.']
 (target.parent/'MATRIX.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
 print(json.dumps({'rows':len(rows),'counts':dict(counts)}))
if __name__=='__main__':main()
