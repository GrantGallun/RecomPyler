from pathlib import Path
import hashlib,json,subprocess,sys
R=Path(__file__).resolve().parents[2];D=R/'matrix/direct_calls'
files=[D/'guarded.c',D/'run_c.py',D/'sys_order_probe.py',D/'gc_guard_probe.py',D/'build_c.py',*list((R/'matrix/temp/s34').glob('*.pyd'))]
(D/'c-source-seal-v5.json').write_text(json.dumps({str(p.relative_to(R)):hashlib.sha256(p.read_bytes()).hexdigest() for p in files},indent=2))
def command(label,args):
    p=subprocess.run([sys.executable,'-B',*args],cwd=R,capture_output=True,text=True)
    (D/(label+'.stdout')).write_text(p.stdout);(D/(label+'.stderr')).write_text(p.stderr)
    print(label,'exit',p.returncode,flush=True);assert p.returncode==0,(label,p.stderr[-1000:])
    return p
p=command('guard-green-v5',['matrix/direct_calls/sys_order_probe.py','green5'])
rows=[json.loads(line) for line in p.stdout.splitlines() if line.startswith('{')]
assert len(rows)==6 and all(r['identical'] for r in rows),[(r.get('reference_events'),r.get('c_events')) for r in rows]
command('gc-guard-v5',['matrix/direct_calls/gc_guard_probe.py','--output','matrix/direct_calls/gc-guard-v5.json'])
command('pairs-v5',['matrix/direct_calls/run_c.py'])
results=json.loads((D/'results-c.json').read_text())
assert len(results)==3 and all('handwritten_c_gate_error' not in r for r in results)
for row in results:
    print(row['function'],row['median_ns'],row['timing_route_counters'],flush=True)
print('ALL C DIAGNOSTIC GATES PASSED',flush=True)
