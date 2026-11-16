"""Serial below-normal correctness execution with frozen sources; no timing claims."""
import hashlib,json,os,subprocess,sys
from pathlib import Path
from correctness_inputs import freeze_corpus,corpus_matches
R=Path(__file__).resolve().parents[1]
def sources():
    files=list((R/'src/recompyler').rglob('*.py'))+list((R/'tests').glob('test_*.py'))+[Path(__file__)]
    files+=list((R/'matrix').glob('*.py'))
    files+=list((R/'tests/provenance_cases').glob('*'))
    return {os.path.relpath(p,R):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
def main():
    folder=(R/sys.argv[1]).resolve()
    if not folder.is_relative_to(R):raise ValueError('clone-local evidence required')
    folder.mkdir(parents=True,exist_ok=False)
    corpus,corpus_hashes=freeze_corpus(folder)
    before=sources();(folder/'input-seal.json').write_text(json.dumps(before,indent=2))
    for name in before:
        target=folder/'source'/name.replace('../','root/').replace('..\\','root/')
        target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes((R/name).read_bytes())
    env=os.environ.copy();env['PYTHONDONTWRITEBYTECODE']='1';env['PYTHONPATH']=str(R/'src');env['PROVENANCE_CORPUS']=str(corpus)
    if os.environ.get('PROVENANCE_BASELINE'):env['PYTHONPATH']=os.environ['PROVENANCE_BASELINE']
    cmd=[sys.executable,*sys.argv[2:]]
    with (folder/'stdout').open('wb') as out,(folder/'stderr').open('wb') as err:
        run=subprocess.run(cmd,cwd=R,stdout=out,stderr=err,env=env)
    result={'complete':True,'exit_code':run.returncode,'unchanged':before==sources() and corpus_matches(corpus,corpus_hashes),'corpus_sha256':corpus_hashes,'command':cmd,'pythonpath':env['PYTHONPATH'],'source_sha256':before,'artifacts':{str(p.relative_to(folder)):hashlib.sha256(p.read_bytes()).hexdigest() for p in folder.rglob('*') if p.is_file() and p.suffix in ('.json','.jsonl','.pyd','.ll','.py') and 'source' not in p.relative_to(folder).parts}}
    (folder/'complete.json').write_text(json.dumps(result,indent=2))
    print(json.dumps({k:v for k,v in result.items() if k not in ('source_sha256','artifacts','corpus_sha256')}),flush=True)
    return run.returncode if result['unchanged'] else 99
if __name__=='__main__':
    if sys.platform=='win32':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    sys.exit(main())

