from pathlib import Path
from setuptools import Extension,setup
root=Path(__file__).resolve().parent
setup(name='wave16-owned-guard-probe',ext_modules=[Extension('_guard_probe',[str(root/'native_guards_probe.c')])])
