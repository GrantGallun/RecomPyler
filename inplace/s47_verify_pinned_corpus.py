"""Prove both corpus tests use an explicitly selected immutable corpus."""
from pathlib import Path
import hashlib,json,os,shutil,subprocess,sys
R=Path(__file__).resolve().parents[1];out=R/'inplace/s47-pinned-corpus-smoke-v1';out.mkdir(exist_ok=False)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
root=R.parent/'provenance-cases';snapshot=out/'corpus';snapshot.mkdir()
seal={p.name:sha(p) for p in root.iterdir() if p.suffix in ('.py','.json')}
for name in seal:shutil.copyfile(root/name,snapshot/name)
assert seal=={p.name:sha(p) for p in snapshot.iterdir()}
source={str(p.relative_to(R)):sha(p) for p in (R/'tests/test_provenance.py',R/'tests/test_provenance_corpus.py',Path(__file__),R/'inplace/step0_union.py')}
runs=[]
for label,corpus,targets,expected in [('snapshot',snapshot,['tests/test_provenance.py','tests/test_provenance_corpus.py'],0),('missing-unit',out/'missing',['tests/test_provenance.py::test_corpus_all_facts_or_decline'],1),('missing-corpus',out/'missing',['tests/test_provenance_corpus.py'],2)]:
 env=os.environ.copy();env['RECOMPYLER_PROVENANCE_CORPUS']=str(corpus)
 command=[sys.executable,'-m','pytest',*targets,'-q','--basetemp',str(out/(label+'-pytest'))]
 with (out/(label+'.stdout')).open('wb') as stdout,(out/(label+'.stderr')).open('wb') as stderr:
  done=subprocess.run(command,cwd=R,env=env,stdout=stdout,stderr=stderr)
 assert done.returncode==expected,(label,done.returncode)
 if expected:assert 'selected provenance corpus is missing' in (out/(label+'.stdout')).read_text()
 runs.append(dict(label=label,command=command,exit_code=done.returncode,expected_exit_code=expected,corpus=str(corpus),stdout_sha256=sha(out/(label+'.stdout')),stderr_sha256=sha(out/(label+'.stderr'))))
assert seal=={p.name:sha(p) for p in snapshot.iterdir()}
assert all(sha(R/p)==value for p,value in source.items())
(out/'complete.json').write_text(json.dumps(dict(complete=True,corpus_sha256=seal,source_sha256=source,runs=runs),indent=2))
print('Both pinned-corpus consumers pass; both missing-directory controls refuse')
