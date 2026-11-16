"""Deterministic extraction and native use of exact-version CPython internals."""
from pathlib import Path
import gc
import importlib.util
import weakref
import pytest

ROOT=Path(__file__).resolve().parents[1]


def generator():
    spec=importlib.util.spec_from_file_location('borrow_generator',ROOT/'tools/generate_borrowed.py')
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    return module


def test_extract_definition_skips_prototypes_comments_and_string_braces():
    source='''int target(int x);
/* target(int x) { wrong } */
int other(void) { return 0; }
static int
target(int x)
{
 const char *s = "} target() {"; // }
 if (x) { return 2; }
 return 1;
}
'''
    extracted=generator().extract_function(source,'target')
    assert extracted.startswith('static int\ntarget')
    assert extracted.rstrip().endswith('return 1;\n}')
    with pytest.raises(ValueError):generator().extract_function(source,'missing')


def test_generation_is_exact_reproducible_and_namespaced():
    tool=generator()
    template=ROOT/'tools/borrowed/borrowed_314.c.template'
    source_root=ROOT/'tools/borrowed/cpython-3.14.4'
    generated=tool.generate(template.read_text(),source_root,version='3.14.4')
    assert generated==(ROOT/'src/recompyler/ir/borrowed_314.c').read_text()
    assert 'RcBorrow_BuildSliceConsumeRefs(' in generated
    assert 'Copyright (c) Meta Platforms, Inc. and affiliates.' in generated
    with pytest.raises(ValueError):tool.generate(template.read_text(),source_root,version='3.14.5')


def test_source_path_escape_is_rejected(tmp_path):
    with pytest.raises(ValueError):
        generator().generate('// @Borrow function x from ../elsewhere.c [3.14.4] as X',tmp_path,version='3.14.4')


def test_borrowed_slice_preserves_identity_and_source_lifetime():
    from recompyler.ir import _borrowed_native
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    start=Token();stop=Token();a=weakref.ref(start);b=weakref.ref(stop)
    value=_borrowed_native.make_slice(start,stop)
    assert type(value) is slice and value.start is start and value.stop is stop and value.step is None
    del start,stop
    assert a() is not None and b() is not None and events==[]
    del value
    assert a() is None and b() is None and events==['drop','drop']
    assert _borrowed_native.addresses()['build_slice_consume_refs']>0


def test_borrowed_slice_gc_cycle_matches_python_slice():
    from recompyler.ir import _borrowed_native
    class Token:pass
    value=Token();ref=weakref.ref(value)
    value.slice=_borrowed_native.make_slice(value,None)
    del value
    gc.collect()
    assert ref() is None
