"""Scalar C clock calls use the real clock, with ordinary binding guards."""
import json
from pathlib import Path
import subprocess
import sys
import time
from time import perf_counter as clock_alias
from types import ModuleType

import pytest
from recompyler import heap

clock_module = ModuleType('clock_module')
clock_module.perf_counter = time.perf_counter


def direct_clock():
    return time.perf_counter()


def imported_clock():
    return clock_alias()


def reexported_clock():
    return clock_module.perf_counter()


def clock_surrounds_work(values, n):
    before = time.perf_counter()
    for i in range(n):
        values[0] += i
    return time.perf_counter() >= before


def bad_clock_argument(values):
    return time.perf_counter(values.pop())


def bad_clock_keyword(values):
    return time.perf_counter(x=values.pop())


@pytest.mark.parametrize('fn', [direct_clock, imported_clock, reexported_clock])
def test_clock_is_native_float_between_surrounding_python_reads(fn):
    compiled = heap.lift_region(fn)
    for _ in range(2):
        before = time.perf_counter()
        got = compiled()
        after = time.perf_counter()
        assert type(got) is float and before <= got <= after
    assert compiled.compiled_calls == 2, compiled.problem


def test_clock_call_can_surround_converted_mutation():
    compiled = heap.lift_region(clock_surrounds_work)
    values = [1]
    assert compiled(values, 5) is True
    assert values == [11]
    assert compiled.compiled_calls == 1, compiled.problem


@pytest.mark.parametrize('fn', [bad_clock_argument, bad_clock_keyword])
def test_bad_clock_arguments_replay_exact_exception_and_effect_once(fn):
    expected, actual = [7], [7]
    with pytest.raises(TypeError) as reference:
        fn(expected)
    compiled = heap.lift_region(fn)
    with pytest.raises(TypeError) as result:
        compiled(actual)
    assert actual == expected == []
    assert result.value.args == reference.value.args
    assert compiled.fallback_calls == 1


def test_reexport_rebinding_uses_current_callable_once(monkeypatch):
    compiled = heap.lift_region(reexported_clock)
    assert type(compiled()) is float
    assert compiled.compiled_calls == 1, compiled.problem
    events = []
    def replacement():
        events.append('called')
        return -0.0
    monkeypatch.setattr(clock_module, 'perf_counter', replacement)
    assert compiled() == 0.0
    assert events == ['called']
    assert compiled.fallback_calls == 1


def test_clock_builds_and_reloads_as_fresh_prepared_aot(tmp_path):
    fn = direct_clock
    region = heap.lift_region(fn)
    assert type(region()) is float
    assert region.compiled_calls == 1, region.problem
    section = heap.build_regions([((fn.__qualname__, fn.__code__.co_firstlineno), fn, region)], tmp_path)
    assert section and section.get('prepared')
    section_file = tmp_path / 'clocks.json'
    section_file.write_text(json.dumps(section))
    child = '''import importlib.util,json,sys,time
from pathlib import Path
from recompyler import heap, _prepared as pc
source=Path(sys.argv[1]);spec=importlib.util.spec_from_file_location('clock_aot',source)
mod=importlib.util.module_from_spec(spec);sys.modules[spec.name]=mod;spec.loader.exec_module(mod)
section=json.loads(Path(sys.argv[2]).read_text())
entry=section['functions'][0]
snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}}
index=pc.open_index(section,entry,plan_snapshot=snapshot)
assert index is not None,pc.last_miss()
wrapped=heap.lift_region(mod.direct_clock,index.exports,prepared=index)
before=time.perf_counter();got=wrapped();after=time.perf_counter()
assert type(got) is float and before<=got<=after
assert wrapped.aot_calls==wrapped.compiled_calls==1 and wrapped.jit_calls==0,wrapped.problem
assert 'numba' not in sys.modules
print('clock prepared AOT passed')
'''
    done = subprocess.run([sys.executable, '-c', child, str(Path(__file__).resolve()), str(section_file)],
                          capture_output=True, text=True, timeout=180)
    assert done.returncode == 0, (done.stdout, done.stderr)


def test_preimport_replacement_c_builtin_is_not_lowered_as_perf_clock():
    child = '''import ctypes,importlib.util,sys,time
+class Method(ctypes.Structure):
+    _fields_=[('name',ctypes.c_char_p),('method',ctypes.c_void_p),('flags',ctypes.c_int),('doc',ctypes.c_char_p)]
+get=ctypes.pythonapi.PyCFunction_GetFunction;get.argtypes=[ctypes.py_object];get.restype=ctypes.c_void_p
+flags=ctypes.pythonapi.PyCFunction_GetFlags;flags.argtypes=[ctypes.py_object];flags.restype=ctypes.c_int
+definition=Method(b'perf_counter',get(time.time),flags(time.time),b'replacement')
+make=ctypes.pythonapi.PyCFunction_NewEx;make.argtypes=[ctypes.POINTER(Method),ctypes.py_object,ctypes.py_object];make.restype=ctypes.py_object
+time.perf_counter=make(ctypes.byref(definition),time,'time')
+spec=importlib.util.spec_from_file_location('clock_replacement',sys.argv[1])
+mod=importlib.util.module_from_spec(spec);sys.modules[spec.name]=mod;spec.loader.exec_module(mod)
+compiled=mod.heap.lift_region(mod.direct_clock)
+before=time.time();got=compiled();after=time.time()
+assert type(got) is float and before<=got<=after,(before,got,after)
+assert compiled.fallback_calls==1 and compiled.compiled_calls==0,compiled.problem
+'''.replace('\n+', '\n')
    done = subprocess.run([sys.executable, '-c', child, str(Path(__file__).resolve())],
                          capture_output=True, text=True, timeout=60)
    assert done.returncode == 0, (done.stdout, done.stderr)
