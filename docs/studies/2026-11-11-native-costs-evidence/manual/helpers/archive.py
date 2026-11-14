"""Archive already-completed evidence only; never import compiler or run workloads."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

def sha(path): return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def load(path): return json.loads(Path(path).read_text())
def save(path,value):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(value,indent=2)+'\n')

def prepare(root):
    root=root.resolve();parent=root.parent
    (root/'.gitattributes').write_text('* -text\n')
    (root/'.gitignore').write_text('/baseline/\n**/__pycache__/\n**/bytecode/\n**/cache/\n**/temp/\n*.pyc\n*.pyo\n')
    performed=root/('results-v2' if root.name=='wave6-study' else 'results')
    manifest=load(performed/'manifest.json');copies=[];maps=[]
    def copy(source,target,expected=None,role=None):
        source=Path(source);target=root/target
        if expected and sha(source)!=expected:raise ValueError('Source hash changed: '+str(source))
        target.parent.mkdir(parents=True,exist_ok=True)
        shutil.copyfile(source,target)
        if sha(target)!=sha(source):raise ValueError('Copy differs.')
        copies.append({'source':str(source),'archive':target.relative_to(root).as_posix(),'sha256':sha(target),'role':role})
    for path in sorted(performed.rglob('*aot-map.json')):
        label=path.parent.name if 'cases' in path.parts else path.name.removesuffix('-aot-map.json')
        maps.extend(load(path))
        for row in load(path):
            artifact=Path(row['artifact'])
            copy(artifact,Path('selected-aot')/label/artifact.name,row['artifact_sha256'],'actual selected AOT PE, successful audit maps digest/export')
            for source in sorted(artifact.parent.iterdir()):
                if source.is_file() and source.suffix in ['.py','.json']:
                    copy(source,Path('selected-aot')/label/'build-evidence'/source.name,role='retained generated source/build probe evidence, not additional execution')
    script=manifest['cases']['current-direct']['script'] if 'cases' in manifest else manifest['script']
    copy(script,Path('inputs/original-driver/barnes_hut.py'),manifest['cases']['current-direct']['script_sha256'] if 'cases' in manifest else manifest['script_sha256'],'exact original current-control execution path archive')
    baseline=Path(manifest['source']['path'] if 'source' in manifest else manifest['sources']['baseline']['path'])
    for source in sorted((baseline/'src/recompyler').glob('*.pyd')):
        copy(source,Path('inputs/runtime-extensions')/source.name,role='exact existing frozen baseline runtime native extension')
    copy(baseline/'tools/_phase_worker.py',Path('inputs/frozen-tools/_phase_worker.py'),role='exact frozen phase adapter dependency')
    copy(parent/'wave5-study/map_aot.py',Path('inputs/frozen-tools/map_aot.py'),role='exact address-mapping tool used; extension import only, no kernel execution')
    reused=manifest['reused_profile']
    report=Path(reused['report'])
    copy(report,Path('inputs/reused-profile/original.plan.json'),reused['report_sha256'],'historical original raw profile/plan, not a fresh wave6 cost')
    for suffix in ['.json','.stdout','.stderr']:
        source=report.parent/('candidate-profile'+suffix)
        copy(source,Path('inputs/reused-profile')/source.name,role='historical profile raw process evidence, not a fresh measurement')
    if root.name=='wave6-study':
        early=load(root/'results/manifest.json')
        copy(parent/'wave5-study/warm_bytecode.py',Path('preparation-only-helpers/warm_bytecode.py'),early['helpers']['warm_bytecode.py'],'superseded metadata-only first prepare helper, never used in performed study')
    save(root/'ARCHIVE-INDEX.json',{'schema':1,'performed_manifest':str((performed/'manifest.json').relative_to(root)),
        'performed_manifest_sha256':sha(performed/'manifest.json'),'copies':copies,'selected_aot_map_count':len(maps),
        'note':'Original absolute paths/manifests/raw evidence unchanged. Copies preserve exact bytes. Baseline clones, heavy caches, bytecode and temp excluded; source commits and raw byte fingerprints retained.'})

def verify(root):
    root=root.resolve()
    def git(*args):return subprocess.check_output(['git','-C',str(root),*args])
    paths=[s.decode() for s in git('ls-tree','-rz','--name-only','HEAD').split(b'\0') if s]
    total=0;blob_hashes={}
    request=''.join('HEAD:'+name+'\n' for name in paths).encode()
    packed=subprocess.run(['git','-C',str(root),'cat-file','--batch'],input=request,stdout=subprocess.PIPE,check=True).stdout
    cursor=0
    for name in paths:
        end=packed.index(b'\n',cursor);header=packed[cursor:end].split();size=int(header[-1]);cursor=end+1
        if header[-2]!=b'blob':raise ValueError('Expected Git blob.')
        raw=packed[cursor:cursor+size];cursor+=size+1;disk=(root/name).read_bytes()
        if raw!=disk:raise ValueError('Git blob differs: '+name)
        blob_hashes[name]=hashlib.sha256(raw).hexdigest();total+=len(raw)
    index=load(root/'ARCHIVE-INDEX.json')
    for row in index['copies']:
        if blob_hashes.get(row['archive'])!=row['sha256']:raise ValueError('Archived artifact/source hash mismatch.')
    manifests=[];raw_records=0
    for name in paths:
        if name.endswith('.json'):
            data=load(root/name)
            if isinstance(data,dict) and 'stdout_sha256' in data:
                stdout=Path(name).with_suffix('.stdout').as_posix()
                if blob_hashes.get(stdout)!=data['stdout_sha256']:raise ValueError('Raw stdout hash mismatch: '+name)
                raw_records+=1
    for name in paths:
        if name.endswith('/manifest.json') and name.count('/')==1:
            data=load(root/name);manifests.append(name)
            for helper,h in data.get('helpers',{}).items():
                file=Path(helper)
                target=root/file.name if file.is_absolute() else root/helper
                if name.startswith('results/') and root.name=='wave6-study' and file.name=='warm_bytecode.py':target=root/'preparation-only-helpers/warm_bytecode.py'
                rel=target.relative_to(root).as_posix() if target.is_relative_to(root) else None
                # Proof dependencies live in the separately committed manual repo.
                if blob_hashes.get(rel)!=h:
                    if root.name=='wave6-proof-study' and Path(helper).is_absolute():
                        dependency=Path(helper);repo=dependency.parent
                        raw=subprocess.check_output(['git','-C',str(repo),'show','HEAD:'+dependency.name])
                        if hashlib.sha256(raw).hexdigest()!=h:raise ValueError('External committed helper mismatch: '+helper)
                    else:raise ValueError('Manifest helper mismatch: '+helper)
            for folder,inventory in data.get('input_inventory',{}).items():
                base=Path(name).parent/folder
                committed={str(Path(n).relative_to(base)).replace('\\','/'):h for n,h in blob_hashes.items() if Path(n).is_relative_to(base)}
                if committed!=inventory:raise ValueError('Committed input inventory differs: '+str(base))
    result={'commit':git('rev-parse','HEAD').decode().strip(),'file_count':len(paths),'blob_bytes':total,
        'all_git_blobs_equal_disk':True,'manifest_helper_input_hashes_verified':manifests,
        'raw_process_stdout_records_verified':raw_records,
        'archived_copy_count':len(index['copies']),'archived_AOT_pyd_count':sum(r['archive'].endswith('.pyd') and r['archive'].startswith('selected-aot/') for r in index['copies'])}
    print(json.dumps(result,indent=2))
    save(root/'.git/archive-verification.json',result)

if __name__=='__main__':
    action=sys.argv[1];root=Path(sys.argv[2]);{'prepare':prepare,'verify':verify}[action](root)
