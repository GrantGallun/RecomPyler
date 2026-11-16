from pathlib import Path
import base64,json,sys,types
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'temp/ceilings'))
import wave17_ceiling_bytes as ext
events=[];original=base64.a85decode
class Hook(types.ModuleType):
 def __getattribute__(self,name):
  if name=='_bytes_from_decode_data':
   def converter(value):events.append('module hook');return b'!!!!!'
   return converter
  return super().__getattribute__(name)
base64.__class__=Hook;rows=[]
try:
 for name,fn in [('cpython',original),('boxed-C',ext.a85_boxed),('borrowed-C',ext.a85_borrowed)]:
  events.clear();out=fn(b'');rows.append(dict(variant=name,result=repr(out),events=list(events)))
finally:base64.__class__=types.ModuleType
Path(sys.argv[1]).write_text(json.dumps(rows,indent=2));print(json.dumps(rows));assert all(r['result']==rows[0]['result'] and r['events']==rows[0]['events'] for r in rows)
