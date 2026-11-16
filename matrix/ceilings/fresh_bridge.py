from pathlib import Path
import base64,importlib,json,sys
sys.path[:0]=sys.argv[1:3]
assert 'numba' not in sys.modules
module=importlib.import_module('wave17_bytes_bridge')
base64.a85encode(b'');base64.b85encode(b'')
raw=b'hello world'
assert module.a85_boxed(base64.a85encode(raw))==raw
assert module.a85_borrowed(base64.a85encode(raw))==raw
assert module.b32_boxed(base64._b32alphabet,base64.b32encode(raw))==raw
assert module.b32_borrowed(base64._b32alphabet,base64.b32encode(raw))==raw
args=(raw,base64._a85chars,base64._a85chars2,False,True,False)
assert module.encode_boxed(*args)==base64._85encode(*args)
assert module.encode_borrowed(*args)==base64._85encode(*args)
try:module.a85_boxed(b'uuuuu')
except ValueError as exc:assert str(exc)=='Ascii85 overflow' and exc.__suppress_context__
else:raise AssertionError('missing error')
assert 'numba' not in sys.modules
print(json.dumps({'six_aot_bodies_passed_without_numba':True,'error_chain_preserved':True}))
