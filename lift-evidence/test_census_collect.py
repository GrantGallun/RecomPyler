"""Source identity joins for S51 diagnostic capture."""
from pathlib import Path
import hashlib,types
from types import SimpleNamespace
import sys
sys.path.insert(0,str(Path(__file__).parent))
from census_collect import select_sampler


def test_sampler_requires_relative_file_hash_and_qualname(tmp_path):
    private=tmp_path/'private';private.mkdir();source=private/'work.py';source.write_text('\ndef f():pass\n')
    original=tmp_path/'original'
    code=(lambda:None).__code__.replace(co_name='f',co_qualname='Q.f',co_filename=str(source),co_firstlineno=2)
    fn=types.FunctionType(code,{})
    root={'source':str(original/'work.py'),'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'function':'f','line':2,'qualname':'Q.f'}
    candidates=[((str(source),'f',2),SimpleNamespace(function=fn))]
    assert select_sampler(root,candidates,private,original)[1]=='matched'
    assert select_sampler({**root,'qualname':'Other.f'},candidates,private,original)[0] is None
    assert select_sampler({**root,'source_sha256':'bad'},candidates,private,original)[0] is None
    assert select_sampler(root,candidates+candidates,private,original)[0] is None
    wrong=private/'other.py';wrong.write_text(source.read_text())
    other=types.FunctionType(code.replace(co_filename=str(wrong)),{})
    assert select_sampler(root,[((str(wrong),'f',2),SimpleNamespace(function=other))],private,original)[0] is None
