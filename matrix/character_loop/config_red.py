"""Isolated fail-first configuration witness, never reuse an attempt directory."""
import hashlib, json, shutil, subprocess, sys
from pathlib import Path
R = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(R/'src'), str(Path(__file__).parent)]
from recompyler._pycc.platform import Toolchain
attempt = R/'matrix/temp'/sys.argv[1]
assert not attempt.exists()
attempt.mkdir()
# Execute the exact frozen bridge root expressions before fixing the reviewed path.
bridge_path=Path(__file__).with_name('bridge.py')
namespace={'__file__':str(attempt/'bridge.py')}
saved_argv=sys.argv;sys.argv=[str(attempt/'bridge.py'),str(attempt)]
try:exec('\n'.join(bridge_path.read_text().splitlines()[:5]),namespace)
finally:sys.argv=saved_argv
assert namespace['R']!=R
(attempt/'path-red.json').write_text(json.dumps({'copied_bridge_root':str(namespace['R']),'required_root':str(R),'expected_failure':True},indent=2))
print('RED: copied bridge computes the wrong repository root',flush=True)
source = attempt/'char_loop.c'
shutil.copyfile(Path(__file__).with_name('char_loop.c'), source)
t = Toolchain()
objects = t.compile_objects([str(source)], str(attempt/'obj'), include_dirs=t.get_python_include_dirs(), extra_cflags=['/O2'])
artifact = attempt/t.get_ext_filename('wave17_charloop')
t.link_shared(str(artifact), objects, libraries=t.get_python_libraries(), library_dirs=t.get_python_library_dirs(), export_symbols=['PyInit_wave17_charloop'])
sys.path.insert(0,str(attempt))
import wave17_charloop as ext
from workload import token
try:
    ext.configure(token)
except RuntimeError as exc:
    assert str(exc)=='missing lexer binding'
    (attempt/'red.json').write_text(json.dumps({'expected_failure':str(exc), 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'artifact_sha256':hashlib.sha256(artifact.read_bytes()).hexdigest()},indent=2))
    print('RED: configuration rejects the nonexistent global deque binding', flush=True)
    subprocess.run([sys.executable, str(Path(__file__).with_name('context_red.py')), str(attempt)], check=True)
    raise
raise AssertionError('Expected configuration failure disappeared')
