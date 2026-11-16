"""Fresh AOT kernel checks, exact native bodies and counters; no speed claim."""
import ast,ctypes,json,os,struct,subprocess,sys
import psutil
from pathlib import Path
R=Path(__file__).resolve().parents[1];W=R.parent
if sys.platform=='win32':psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
variant=sys.argv[1];out=R/sys.argv[2];out.mkdir(exist_ok=False)
def checks(text):
    result={}
    for line in text.splitlines():
        fields=line.split()
        if len(fields)==3 and fields[0]=='check':
            result[fields[1]]=struct.pack('!d',float.fromhex(fields[2])).hex() if '0x' in fields[2].lower() else fields[2]
    return result
def bodies(folder):
    return {p.name:ast.dump(ast.Module(body=[n for n in ast.parse(p.read_text()).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),include_attributes=False) for p in folder.glob('*.generated.py')}
rows=[]
for name in ('barnes_hut','fannkuch','scimark','raytrace'):
    folder=R/'matrix/temp/artifacts'/variant/name
    if not folder.exists() and len(sys.argv)>3:folder=R/'matrix/temp/artifacts'/sys.argv[3]/name
    assert bodies(folder)==bodies(R/'matrix/temp/artifacts/sets-postmerge-v1'/name),(name,'native function body changed')
    env=dict(os.environ,PYTHONPATH=os.pathsep.join([str(W/'wave5-study/results/shim'),str(R/'src')]))
    temp=out/(name+'-tmp');temp.mkdir()
    for key in ('TEMP','TMP','TMPDIR'):env[key]=str(temp)
    env['RECOMPYLER_CACHE']=str(temp/'cache')
    count=out/(name+'.counts.json')
    command=[sys.executable,'-m','recompyler','run','--force','--plan',str(folder/'plan.json'),'--json',str(count),str(W/'wave5-study/results/drivers'/(name+'.py')),'5']
    run=subprocess.run(command,cwd=R,env=env,capture_output=True)
    (out/(name+'.stderr')).write_bytes(run.stderr)
    actual=checks(run.stdout.decode(errors='replace'));expected=checks((W/'wave11-ledger/gap-ledger/work'/name/'plain-0.stdout').read_text())
    assert run.returncode==0 and actual==expected,(name,run.returncode,run.stderr.decode(errors='replace'))
    data=json.loads(count.read_text());audit=json.loads((W/'wave11-ledger/gap-ledger/work'/name/'audit.counts.json').read_text())
    key=lambda row:(row['function'],row.get('line'))
    assert {key(row):row.get('aot_calls',0) for row in data['functions']}=={key(row):5*row.get('aot_calls',0) for row in audit['functions']},name
    assert not any(row.get('jit_calls',0) or row.get('fallback_calls',0) for row in data['functions']),name
    assert not data.get('not_found') and not data.get('batches'),name
    rows.append({'kernel':name,'checks':actual,'native_bodies_unchanged':True,'aot_multiplicity':5,'jit':0,'fallback':0})
    print(name+': exact outputs, unchanged native bodies, five-loop AOT counts; zero JIT/fallback',flush=True)
(out/'results.json').write_text(json.dumps(rows,indent=2),encoding='utf-8')
