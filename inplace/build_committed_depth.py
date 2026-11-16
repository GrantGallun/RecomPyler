"""Build the exact committed depth tip in this clone for the final comparison."""
from pathlib import Path
import argparse,io,json,os,subprocess,sys,tarfile
from freeze_build_step0 import D,R,W,NAMES,sha,read,write,inventory,inputs
COMMIT='56860c375785c23fbfbb97f85e1589584b4ccaa6'

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--variant',required=True);p.add_argument('--lock-label',required=True);o=p.parse_args()
 assert Path(o.variant).name==o.variant and o.variant not in ('.','..')
 owner=(W/'TIMING.lock/owner.txt').read_text();assert 'wave16-inplace' in owner and 'purpose: '+o.lock_label+'\n' in owner
 assert subprocess.check_output(['git','rev-parse',COMMIT],cwd=R).decode().strip()==COMMIT
 base=D/'bases'/o.variant;artifacts=D/'artifacts'/o.variant;assert not base.exists() and not artifacts.exists()
 archive=subprocess.check_output(['git','archive',COMMIT,'src','setup.py','pyproject.toml','README.md'],cwd=R)
 base.mkdir();(base/'committed-input.tar').write_bytes(archive)
 try:
  with tarfile.open(fileobj=io.BytesIO(archive)) as tar:
   assert tar.pax_headers.get('comment')==COMMIT
   for member in tar.getmembers():
    path=(base/member.name).resolve();assert path.is_relative_to(base.resolve()) and (member.isfile() or member.isdir())
   tar.extractall(base,filter='data')
  original=inventory(base/'src')
  proof=base/'committed-source.json';write(proof,dict(commit=COMMIT,archive_sha256=sha(base/'committed-input.tar'),source_before_native_build=original,setup_sha256=sha(base/'setup.py'),project_sha256=sha(base/'pyproject.toml')))
  native_command=[sys.executable,'setup.py','build_ext','--inplace']
  env=os.environ.copy();env['PYTHONPATH']=str(base/'src');env['PYTHONPYCACHEPREFIX']=str(base/'bytecode')
  with (base/'native-build.stdout').open('xb') as stdout,(base/'native-build.stderr').open('xb') as stderr:
   native=subprocess.run(native_command,cwd=base,env=env,stdout=stdout,stderr=stderr)
  write(base/'native-build.receipt.json',dict(command=native_command,exit_code=native.returncode))
  assert native.returncode==0
  for stem in ('_heap','_monitor'):
   assert len(list((base/'src/recompyler').glob(stem+'*.pyd')))==1,'Optional native build failed'
  verify="import pathlib,recompyler;from recompyler import _heap,_monitor;root=pathlib.Path(recompyler.__file__).resolve().parents[1];assert root==pathlib.Path(__import__('sys').argv[1]).resolve();assert pathlib.Path(_heap.__file__).resolve().is_relative_to(root);assert pathlib.Path(_monitor.__file__).resolve().is_relative_to(root);assert _heap.LOAD_CONTRACTS_VERSION==1;assert callable(_heap.load) and callable(_heap.write_back);print('exact committed native imports verified')"
  checked=subprocess.run([sys.executable,'-c',verify,str(base/'src')],cwd=base,env=env,capture_output=True)
  (base/'native-verify.stdout').write_bytes(checked.stdout);(base/'native-verify.stderr').write_bytes(checked.stderr);assert checked.returncode==0,checked.stderr
  for name,value in original.items():assert sha(base/'src'/name)==value
  frozen=inventory(base/'src');write(base/'source-manifest.json',frozen)
  build_inputs=inputs();build_inputs['files'].update({str(p):sha(p) for p in (Path(__file__),base/'setup.py',base/'pyproject.toml',proof,base/'native-build.receipt.json')})
  subprocess.run([sys.executable,str(D/'build_all.py'),o.variant],cwd=R,check=True)
  assert inventory(base/'src')==frozen
  assert all(sha(path)==value for path,value in build_inputs['files'].items()) and inventory(W/'wave5-study/results/shim')==build_inputs['shim']
  for name in NAMES:
   assert (artifacts/name/'plan.json').is_file() and any(p.suffix in ('.pyd','.so') for p in (artifacts/name).iterdir())
  write(base/'complete.json',dict(complete=True,kind='committed-depth',variant=o.variant,lock_label=o.lock_label,commit=COMMIT,union_evidence={str(proof):sha(proof),str(base/'committed-input.tar'):sha(base/'committed-input.tar')},build_inputs=build_inputs,source_manifest_sha256=sha(base/'source-manifest.json'),artifacts={n:inventory(artifacts/n) for n in NAMES}))
 except BaseException as exc:
  write(base/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False));raise
if __name__=='__main__':main()
