"""Read-only query census of accepted provenance on the original ten S46 bodies."""
from pathlib import Path
import ast,hashlib,inspect,json,runpy,sys,textwrap
from recompyler import provenance as p
R=Path(__file__).resolve().parents[1];D=R/'inplace';inputs=D/'s46-ten-components-v8';out=D/'s46-provenance-queries-v1';out.mkdir(exist_ok=False)
sha=lambda path:hashlib.sha256(path.read_bytes()).hexdigest()
sys.path.insert(0,str(inputs/'shim'))
targets={'chaos':['Chaosgame.transform_point','Spline.__call__'],'gc_collect':['create_cycle'],'hexiom':['Hex.link_nodes','Done.filter_tiles'],'richards_super':['Task.qpkt','DeviceTask.fn','HandlerTask.fn','Task.runTask','schedule']}
seal={str(inputs/name/'input/run_benchmark.py'):sha(inputs/name/'input/run_benchmark.py') for name in targets};seal[str(Path(p.__file__))]=sha(Path(p.__file__));seal[str(Path(__file__))]=sha(Path(__file__))
rows=[]
def fact(value):
 return {'unknown':value.unknown,'origin_kinds':sorted({o.kind for o in value.origins}),'descendant_kinds':sorted({o.kind for o in p.descendants(value)}),'child_count':len(value.children)}
for program,names in targets.items():
 namespace=runpy.run_path(str(inputs/program/'input/run_benchmark.py'),run_name='wave16_source_query_'+program)
 for name in names:
  value=namespace
  for part in name.split('.'):value=value[part] if type(value) is dict else getattr(value,part)
  source=textwrap.dedent(inspect.getsource(value));node=ast.parse(source).body[0];summary=p.analyze(value)
  accesses=[]
  for expression in ast.walk(node):
   if isinstance(expression,(ast.Attribute,ast.Subscript)):
    at=p.site(expression);origin=summary.expressions.get(at,p.UNKNOWN)
    accesses.append({'site':at,'original_line':value.__code__.co_firstlineno+expression.lineno-1,'expression':ast.unparse(expression),'fact':fact(origin)})
  stores=[{'site':store.at,'location':fact(store.location),'previous':fact(store.previous),'value':fact(store.value),'naturally_rooted':summary.naturally_rooted(store.previous)} for store in summary.stores]
  rows.append({'program':program,'function':name,'source_sha256':hashlib.sha256(source.encode()).hexdigest(),'valid':summary.valid,'reason':summary.reason,'result':fact(summary.result),'unresolved_callback_sites':sum(right is None for left,right in summary.observations),'accesses':accesses,'stores':stores,'scope':'Unassumed shared source facts, not a direct eligibility verdict; exact typed/effect guards may discharge callback sites. Physical roots remain runtime facts.'})
assert all(sha(Path(path))==digest for path,digest in seal.items())
(out/'complete.json').write_text(json.dumps({'complete':True,'source_sha256':seal,'rows':rows,'product_execution':False,'timing_eligible':False},indent=2))
for row in rows:print(row['function'],'valid',row['valid'],'reason',row['reason'],'unknown accesses',sum(v['fact']['unknown'] for v in row['accesses']),'/',len(row['accesses']),'unresolved callback sites',row['unresolved_callback_sites'],'stores',len(row['stores']))
