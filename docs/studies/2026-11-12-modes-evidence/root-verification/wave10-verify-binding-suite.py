"""Check final raw suite evidence and current tested bytes; no tests rerun."""
import hashlib
import json
from pathlib import Path
import subprocess

root = Path(__file__).resolve().parent
stem = root / 'wave10-binding-analysis/fullsuite-v1'
read = lambda ext: json.loads(stem.with_suffix(ext).read_text())
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
receipt = read('.receipt.json')
before, after = read('.before.json'), read('.after.json')
assert receipt['exit_code'] == 0 and receipt['inputs_unchanged'] and receipt['support_unchanged']
assert before == after and len(after) == 67
assert receipt['commit'] == '954848ee312b0ef8cdac7f8292b10334e9ccacbf'
for name, expected in after.items():
    assert sha(root / 'wave10-binding' / name) == expected, name
assert sha(stem.with_suffix('.stdout')) == receipt['stdout_sha256']
assert sha(stem.with_suffix('.stderr')) == receipt['stderr_sha256']
summary = stem.with_suffix('.stdout').read_text().strip().splitlines()[-1]
assert summary == '715 passed, 22 warnings, 100 subtests passed in 349.64s (0:05:49)', summary
assert not subprocess.check_output(['git','-C',str(root/'wave10-binding'),'status','--porcelain'], stderr=subprocess.DEVNULL)
result = {'all_assertions_passed': True, 'commit': receipt['commit'], 'input_files': len(after),
          'summary': summary, 'stdout_sha256': receipt['stdout_sha256'],
          'source_unchanged': True, 'native_support_unchanged': True,
          'note': '65 tracked source/test/document/license files plus two native binaries; explicit product tests only.'}
(root / 'wave10-root-binding-suite-verification.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result))
