from pathlib import Path
import sys,json
D=Path(__file__).resolve().parent;sys.path[:0]=[str(D/'bases/integration/src'),str(D.parent.parent/'wave5-study/results/shim')]
from recompyler import aot
old=aot.AotLifted.__init__;rows=[]
def init(self,fn,entry,module):
 try:return old(self,fn,entry,module)
 except Exception as exc:
  row={'function':fn.__qualname__,'error':str(exc),'expected_digest':entry['digest']}
  if hasattr(self,'_unit'):
   row['actual_digest']=aot._digest(self._unit,self.source)
   row['guards']=[{'name':name,'value_name':getattr(value,'__qualname__',str(type(value))),'value_file':getattr(getattr(value,'__code__',None),'co_filename',None),'original_name':getattr(getattr(value,'__recompyler_original__',None),'__qualname__',None)} for namespace,name,value,code in self._unit.guards]
  rows.append(row);raise
aot.AotLifted.__init__=init
from recompyler.runner import run_script
r=run_script(D.parent.parent/'wave5-study/results/drivers/scimark.py',['1'],D/'artifacts/integration/scimark/plan.json',True)
(D/'integration-aot-diagnostic.json').write_text(json.dumps({'rejections':rows,'report':r},indent=2));print(json.dumps(rows,indent=2))
