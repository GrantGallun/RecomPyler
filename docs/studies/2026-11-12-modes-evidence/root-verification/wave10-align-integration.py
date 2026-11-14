"""Copy tested raw bytes after a clean merge and verify exact integration."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
root = Path(__file__).resolve().parent
worker, integration = root/'wave10-binding', root/'wave10-integration'
expected = json.loads((root/'wave10-binding-analysis/fullsuite-v1.after.json').read_text())
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
assert len(expected) == 67
for name, digest in expected.items():
    source, destination = (worker/name).resolve(), (integration/name).resolve()
    assert source.is_relative_to(worker.resolve()) and destination.is_relative_to(integration.resolve())
    assert sha(source) == digest, name
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, destination)
    assert sha(destination) == digest, name
diff = subprocess.check_output(['git','-C',str(integration),'diff','--ignore-space-at-eol','--','src','tests','docs/experimental-numeric.md'])
assert not diff, diff.decode(errors='replace')
result = {'all_assertions_passed': True, 'exact_files': len(expected),
          'tested_source': '954848ee312b0ef8cdac7f8292b10334e9ccacbf',
          'integration': str(integration), 'inputs': expected,
          'note': 'Merged code and exact tested working bytes match; no code change and no duplicate suite run.'}
(root/'wave10-integration-source-verification.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k != 'inputs'}))
