"""Capture static disassembly for independently audited actual AOT artifacts."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
from static_method import inspect

ROOT = Path(__file__).resolve().parent
TASK = ROOT.parent


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def collect(name, plan_path, audit_path, tool):
    plan = json.loads(plan_path.read_text())
    audit = json.loads(audit_path.read_text())['mode_evidence']
    totals = audit['totals']
    assert totals['aot_calls'] > 0 and all(totals[k] == 0 for k in ('jit_calls', 'fallback_calls', 'unknown_native_calls', 'rejected_attempts'))
    selected = [(fn, digest, counts['aot_calls']) for fn in audit['functions']
                for digest, counts in fn.get('programs', {}).items() if counts['aot_calls']]
    assert len(selected) == 1
    fn, digest, calls = selected[0]
    section = plan['plan']['aot_regions']
    matches = [row for row in section['functions'] if digest in row['exports']]
    assert len(matches) == 1
    row = matches[0]
    export = row['exports'][digest]
    assert row.get('qualname', row['function']) == fn['function']
    binaries = list(Path(section['folder']).glob(section['module']+'*.pyd'))
    assert len(binaries) == 1
    artifact = binaries[0]
    result = inspect(artifact, export)
    command = [str(tool), '--disassemble', '--demangle', '--no-show-raw-insn', str(artifact)]
    run = subprocess.run(command, capture_output=True)
    (ROOT/(name+'.asm')).write_bytes(run.stdout)
    (ROOT/(name+'.stderr')).write_bytes(run.stderr)
    if run.returncode:
        raise RuntimeError(run.stderr.decode('utf-8', 'replace'))
    result.update(case=name, digest=digest, actual_aot_calls=calls, audit_totals=totals,
                  numba_imported=audit['numba_imported'], function=fn['function'],
                  plan=str(plan_path), plan_sha256=sha(plan_path), audit=str(audit_path), audit_sha256=sha(audit_path),
                  command=command, tool_sha256=sha(tool), assembly_sha256=sha(ROOT/(name+'.asm')),
                  artifact_executed=False)
    (ROOT/(name+'-provenance.json')).write_text(json.dumps(result, indent=2)+'\n')
    print(name, artifact.name, digest, result['method']['function_address'])


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--tool', type=Path, required=True)
    p.add_argument('--cases', nargs='+', required=True)
    args = p.parse_args()
    for name in args.cases:
        if name == 'production':
            folder = TASK/'wave6-proof-study/results'
            collect(name, folder/'plans/candidate.json', folder/'candidate-state.json', args.tool)
        else:
            folder = TASK/'wave6-study/results-v2/cases'/name
            collect(name, folder/'plan.json', folder/'native-state.json', args.tool)
