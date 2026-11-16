from pathlib import Path
import subprocess,json,hashlib,shutil
R=Path(__file__).resolve().parents[1]; W=R.parent; S=W/'wave14-capture/stages/item1-s23-final2'; D=R/'inplace'
f=json.loads((S/'freeze.json').read_text()); receipt={'depth_commit':subprocess.check_output(['git','rev-parse','HEAD'],cwd=R,text=True).strip(),'coverage_freeze_sha256':hashlib.sha256((S/'freeze.json').read_bytes()).hexdigest(),'base':'087c0dd','files':[]}
for group,sub in [('source','src'),('tests','tests')]:
 for rel,digest in f[group].items():
  src=S/sub/rel; assert hashlib.sha256(src.read_bytes()).hexdigest()==digest,src
  path=Path(sub)/rel; target=R/path; target.parent.mkdir(parents=True,exist_ok=True)
  base=subprocess.run(['git','show','087c0dd:'+path.as_posix()],cwd=R,capture_output=True)
  theirs=src.read_bytes(); ours=target.read_bytes() if target.exists() else None
  if src.suffix in ('.py','.c'):
   theirs=theirs.replace(b'\r\n',b'\n'); ours=ours.replace(b'\r\n',b'\n') if ours is not None else None; base.stdout=base.stdout.replace(b'\r\n',b'\n')
  mode='unchanged'
  if ours==theirs: pass
  elif base.returncode or ours==base.stdout: target.write_bytes(theirs); mode='coverage'
  elif theirs==base.stdout: mode='depth'
  elif ours is None: target.write_bytes(theirs);mode='coverage-new'
  else:
   b=D/'merge-base'; b.write_bytes(base.stdout)
   t=D/'merge-theirs'; t.write_bytes(theirs)
   p=subprocess.run(['git','merge-file','-p',str(target),str(b),str(t)],capture_output=True)
   target.write_bytes(p.stdout);mode='conflict' if p.returncode else 'merged'
  receipt['files'].append({'path':path.as_posix(),'mode':mode,'frozen_sha256':digest})
(D/'integration-inputs.json').write_text(json.dumps(receipt,indent=2)+'\n')
for name in ['merge-base','merge-theirs']:
 p=D/name
 if p.exists():p.unlink()
print(json.dumps([x for x in receipt['files'] if x['mode']!='unchanged'],indent=2))
