from pathlib import Path
import json,sys
from setuptools import Extension,setup
root=Path(__file__).resolve().parents[2]
setup(name="wave16-flat-prototype",ext_modules=[Extension("recompyler._flat_native",[str(root/"src/recompyler/_flat_native.c")],define_macros=[("RECOMPYLER_GUARD_BUILD_SIGNATURE",json.dumps(sys.version))],optional=False)])
