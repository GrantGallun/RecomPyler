"""Independent verification of saved combined test logs and exact input bytes."""
import hashlib
import json
from pathlib import Path
import re
root = Path(__file__).resolve().parent
folder = root / 'wave10-validation/full-suite'
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
read = lambda n: json.loads((folder / n).read_text())
receipt, freeze = read('receipt.json'), read('candidate-freeze.json')
before, after = read('before-inputs.json'), read('after-inputs.json')
assert receipt['exit_code'] == 0 and receipt['inputs_unchanged'] and not receipt['changed_inputs']
assert before == after == freeze['inputs']
assert freeze['commit'] == receipt['commit'] == 'a5d11d7745da8d324e46e544f929849c0598cddd'
assert sha(folder / 'stdout.log') == receipt['stdout_sha256']
assert sha(folder / 'stderr.log') == receipt['stderr_sha256']
for name, expected in after.items():
    assert sha(root / 'wave10-combined' / name) == expected, name
output = (folder / 'stdout.log').read_text()
summary = output.strip().splitlines()[-1]
assert re.search(r'\d+ passed', summary) and 'failed' not in summary and 'error' not in summary.lower(), summary
result = {'all_assertions_passed': True, 'candidate': freeze['commit'],
          'frozen_inputs': len(after), 'summary': summary,
          'stdout_sha256': receipt['stdout_sha256'], 'source_unchanged': True,
          'note': 'pytest also collects four archived protocol tests; product src/tests and native inputs frozen, no tests rerun.'}
(root / 'wave10-root-full-suite-verification.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result))
