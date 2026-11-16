"""Run the final union once and seal the exact tested source and test tree."""
from pathlib import Path
import argparse,hashlib,json,os,shutil,subprocess,sys
from freeze_build_step0 import inventory,write,D,R,W

def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);group=p.add_mutually_exclusive_group(required=True);group.add_argument('--lock-label');group.add_argument('--correctness-label');o=p.parse_args()
 if o.correctness_label:
  assert os.environ.get('WAVE16_CORRECTNESS_LABEL')==o.correctness_label
 else:
  owner=(W/'TIMING.lock/owner.txt').read_text();assert 'wave16-inplace' in owner and 'purpose: '+o.lock_label+'\n' in owner
 output=o.output.resolve();assert output.is_relative_to(D) and not output.exists();output.mkdir()
 corpus_root=W/'provenance-cases'
 if not corpus_root.exists():corpus_root=R/'tests/provenance_cases'
 corpus=output/'frozen-provenance';corpus.mkdir()
 corpus_seal={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(corpus_root.iterdir()) if p.suffix in ('.py','.json')}
 for name in corpus_seal:shutil.copyfile(corpus_root/name,corpus/name)
 assert inventory(corpus)==corpus_seal,'corpus changed while taking snapshot'
 env=os.environ.copy();env['RECOMPYLER_PROVENANCE_CORPUS']=str(corpus)
 frozen=dict(source=inventory(R/'src'),tests=inventory(R/'tests'),harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),provenance_corpus=corpus_seal,provenance_origin=str(corpus_root))
 write(output/'freeze.json',frozen)
 command=[sys.executable,'-m','pytest','tests','-q','--basetemp',str(output/'pytest-temp')]
 try:
  child=subprocess.run(command,cwd=R,env=env)
  assert child.returncode==0,('Union failed',child.returncode)
  assert frozen==dict(source=inventory(R/'src'),tests=inventory(R/'tests'),harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),provenance_corpus=inventory(corpus),provenance_origin=str(corpus_root))
  write(output/'complete.json',dict(complete=True,lock_label=o.lock_label,correctness_label=o.correctness_label,execution_class='correctness' if o.correctness_label else 'legacy-locked',command=command,freeze_sha256=hashlib.sha256((output/'freeze.json').read_bytes()).hexdigest(),source=frozen['source'],tests=frozen['tests'],provenance_corpus=frozen['provenance_corpus'],provenance_origin=frozen['provenance_origin']))
 except BaseException as exc:
  write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False));raise
if __name__=='__main__':main()
