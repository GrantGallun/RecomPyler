from pathlib import Path
import base64,json,sys,types
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'temp/ceilings'))
import wave17_ceiling_bytes as ext
events=[];old=sys.modules['struct'];replacement=types.ModuleType('struct')
def factory(fmt):events.append('replacement Struct');raise RuntimeError('replacement import')
replacement.Struct=factory
sys.modules['struct']=replacement
rows=[]
try:
 for name,fn in [('cpython',base64.a85decode),('boxed-C',ext.a85_boxed)]:
  events.clear()
  try:result=repr(fn(b'!!!!!'))
  except Exception as exc:result=[type(exc).__name__,str(exc)]
  rows.append(dict(variant=name,result=result,events=list(events)))
finally:sys.modules['struct']=old
Path(sys.argv[1]).write_text(json.dumps(rows,indent=2));print(json.dumps(rows));assert rows[0]['result']==rows[1]['result'] and rows[0]['events']==rows[1]['events']
