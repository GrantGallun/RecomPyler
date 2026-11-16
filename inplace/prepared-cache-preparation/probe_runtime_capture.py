import sys,json,copyreg,importlib.util
from pathlib import Path
D=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(D/'integration-smoke20-v4/shim'))
from recompyler import heap,_prepared as pc
from recompyler._region_seed import restore
class SourceOnly(dict):
    def __bool__(self):return True
    def get(self,key,default=None):return True
results=[]
for name in ('chaos','richards_super'):
    common=D/'integration-smoke20-v4'/name
    report=json.loads((common/'plan.json').read_text())
    script=Path(report['script'])
    spec=importlib.util.spec_from_file_location('_prepared_probe_'+name,script)
    module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module;spec.loader.exec_module(module)
    for row in report['plan']['aot_regions']['functions']:
        fn=module
        for part in row['qualname'].split('.'):fn=getattr(fn,part)
        for digest,seed in row['seeds'].items():
            p=restore(fn,seed);p.compile(SourceOnly())
            for cls in p.class_fields:copyreg._slotnames(cls)
            refs=pc.References(fn,p)
            for g in p.guards.values():
                if g[0] in ('item','own','attr','builtin') and not (g[0]=='attr' and g[2] in ('__mro__','__defaults__','__kwdefaults__')):
                    try: pc._binding_key(g[-1],refs)
                    except pc.PreparedMiss as exc:
                        t=type(g[-1]); print('BINDING MISS',g[0],[v for v in g[1:] if type(v) is str], t.__module__ if type(t) is type else 'custom',t.__name__ if type(t) is type else 'custom',str(exc),flush=True)
            core=pc.capture(p,seed=seed,export='rprobe',plan_key={},build_key={})
            result=dict(program=name,function=row['qualname'],variant='seed',functions=len(core['execution']['functions']),classes=len(core['execution']['classes']),core=pc.core_id(core))
            results.append(result);print(json.dumps(result),flush=True)
output=D/sys.argv[1]
with output.open('x') as f:json.dump(dict(complete=True,diagnostic_only=True,source='current clone; complete v4 baseline input and seed only',results=results),f,indent=2)
