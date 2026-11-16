from pathlib import Path
import importlib,json,sys
artifact=Path(sys.argv[1]);sys.path.insert(0,str(artifact.parent))
assert 'numba' not in sys.modules
module=importlib.import_module('wave17_managed')
assert 'numba' not in sys.modules
class Vector:
    x=1.25;y=-0.;z=3.5
assert module.string_build(Vector())=='<1.250000, -0.000000, 3.500000>'
try:module.string_build(object())
except AttributeError as exc:assert str(exc)=="'object' object has no attribute 'x'"
else:raise AssertionError('missing exception')
assert 'numba' not in sys.modules
print(json.dumps({'artifact_imported_and_called_without_numba':True,'success_and_error_identical':True}))
