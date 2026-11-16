import importlib, importlib.abc, json, sys
from pathlib import Path
out=Path(sys.argv[1]);sys.path.insert(0,str(out))
class NoNumba(importlib.abc.MetaPathFinder):
    def find_spec(self,fullname,path,target=None):
        if fullname=='numba' or fullname.startswith('numba.'):
            raise AssertionError('AOT must run without Numba')
sys.meta_path.insert(0,NoNumba())
assert 'numba' not in sys.modules
import wave17_charloop as ext
from workload import token
ext.configure(token)
aot=importlib.import_module('wave17_character_bridge')
for fn in [aot.boxed,aot.borrowed]:
    for text in ['','abc','\"\u03bb\U0001f600\"','a\\ b','\"unterminated','\\']:
        def observe(call):
            try:
                result=call(text);return type(result),result,result is text
            except Exception as exc:return type(exc),str(exc),exc.args
        assert observe(fn)==observe(token),(text,observe(fn),observe(token))
assert ext.stats()==(6,6,0),ext.stats()
assert 'numba' not in sys.modules
print(json.dumps({'fresh_aot_no_numba':True,'routes':ext.stats()}))
