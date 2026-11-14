"""Verify retained state evidence and native address bindings without execution."""
import hashlib
import importlib.util
import json
from pathlib import Path

root = Path(__file__).resolve().parent
out = root / 'wave10-measurements/coverage-formal-v1'
read = lambda p: json.loads(p.read_text())
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
spec = importlib.util.spec_from_file_location('wave10_static_pe', root / 'wave10-measurements/results-formal-v1/helpers/pe_method.py')
pe = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pe)
records = []
for path in sorted((out / 'state-processes').glob('*.json')):
    process = read(path)
    assert process['exit_code'] == 0
    for stream in ('stdout', 'stderr'):
        assert sha(path.with_suffix('.' + stream)) == process[stream + '_sha256']
    records.append(path.name)
assert len(records) == 6
rows = []
for kind in ('original', 'pixels'):
    declined = read(out / 'state' / ('current-' + kind) / 'build.json')
    assert declined['status'] == 'native-declined' and declined['state_matches']
    folder = out / 'state' / ('candidate-' + kind)
    result = read(folder / 'aot.json')
    assert result['status'] == 'aot-state-verified'
    assert result['aot_calls'] == result['compiled_calls'] == 1
    assert all(result[k] == 0 for k in ('jit_calls', 'fallback_calls', 'rejected_attempts'))
    assert result['numba_imported'] is False
    assert result['exact_state_match'] and result['input_identities_preserved']
    assert read(folder / 'aot-expected-state.json') == read(folder / 'aot-actual-state.json')
    assert sha(Path(result['script'])) == result['script_sha256']
    for name, expected in result['compiler_inputs'].items():
        assert sha(Path(name)) == expected, name
    assert len(result['raw_export_entries']) == 1
    digest = result['selected_digest']
    entry = result['raw_export_entries'][digest]
    assert entry['entered'] == entry['returned'] == entry['growth_status'] + entry['successful_status']
    assert entry['successful_status'] == 1 and entry['other_status'] == 0
    address = result['raw_export_addresses'][digest]
    assert address['function_address'] - address['module_base'] == address['wrapper_rva']
    binary = Path(address['module_path'])
    assert sha(binary) == address['module_sha256']
    static = pe.inspect_method(binary, address['export'])
    assert static['method_rva'] == address['wrapper_rva']
    rows.append({'kind': kind, 'completed_aot_calls': 1, 'growth_retries': entry['growth_status'],
                 'exact_state_match': True, 'numba_imported': False,
                 'wrapper_rva': address['wrapper_rva'], 'binary_sha256': sha(binary)})
receipt = {'all_assertions_passed': True, 'raw_process_records': len(records), 'rows': rows,
           'note': 'Read-only verification; original None API and separately derived pixel canary are distinct.'}
(root / 'wave10-root-state-verification.json').write_text(json.dumps(receipt, indent=2) + '\n')
print(json.dumps(receipt))
