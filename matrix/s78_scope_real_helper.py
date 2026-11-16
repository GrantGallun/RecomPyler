import ast,ctypes,json,sys
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path[:0]=[str(Path.cwd()/'src'),str(Path.cwd()/'tests')]
from recompyler import lift
from test_ir_protected_paths import real_frame_entry,_RESOURCES
node=ast.parse('def example(items):\n value=1\n result=[x for x in items]\n for item in items:\n  value=item\n return value\n').body[0]
original=lift._local_names;code=original.__code__;expected=original(node)
try:
 call,lowered,count=real_frame_entry(original)
 actual=call(node)
 assert actual==expected=={'value','result','item'}
 assert call is original and call.__code__ is code and count.value>0
 print(json.dumps(dict(helper='recompyler.lift._local_names',native_entries=count.value,correct=True,original_function=True,local_recursive_child='canonical Python CALL',whole_body_native=False)))
finally:
 for owner,handle in _RESOURCES:handle.close()
