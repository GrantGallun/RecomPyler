from pathlib import Path
import json,subprocess,sys
R=Path(__file__).resolve().parents[2];out=R/"inplace/s56-default-heldout";out.mkdir(exist_ok=False)
manifest=json.loads((R.parent/"wave14-capture/capture/input-manifest.json").read_text())
programs=[w["name"] for w in manifest["workloads"] if w["name"] not in {"asyncio_tcp","asyncio_websockets","fastapi"}]
records=[];errors=[]
for name in programs:
 with (out/(name+".txt")).open("wb") as f:
  result=subprocess.run([sys.executable,str(R/"matrix/heldout_native.py"),name,str(out/name)],cwd=R,stdout=f,stderr=subprocess.STDOUT)
 if result.returncode:errors.append(name);print(name,"failed",result.returncode,flush=True);continue
 data=json.loads((out/name/"results.json").read_text());records.append(data)
 print(name,{k:data[k] for k in ("captured","verified","whole_function_native")},flush=True)
summary=dict(defined_denominator=375,programs=len(records),errors=errors,**{k:sum(d[k] for d in records) for k in ("captured","verified","whole_function_native")},deployment_selection_run=False,private_flat_not_default=True)
(out/"counts.json").write_text(json.dumps(summary,indent=2));print(json.dumps(summary),flush=True)
