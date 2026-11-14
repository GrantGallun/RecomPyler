"""Manual diagnostic target-only capture/verification/AOT adapter."""
import argparse
import json
from pathlib import Path
import sys

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--script', type=Path, required=True)
parser.add_argument('--target', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
from recompyler import profiler
original_rows = profiler.CallMonitor.rows
original_test = profiler.test_candidate
def rows(monitor):
    return [r for r in original_rows(monitor) if r['function'] == args.target]
def candidate(*passed, **named):
    result = original_test(*passed, **named)
    result['diagnostic_original_recommended'] = result.get('recommended')
    result['diagnostic_original_recommendation'] = result.get('recommendation')
    accepted = (result.get('status') == 'verified' and result.get('engine') == 'region'
                and result.get('compiled_samples', 0) > 0 and not result.get('fallback_samples', 0))
    result['recommended'] = accepted
    result['recommendation'] = 'Manual causal target-only diagnostic selection; not default deployment.'
    return result
profiler.CallMonitor.rows, profiler.test_candidate = rows, candidate
try:
    report = profiler.profile_script(args.script.resolve(), ['1'], 40, 8, True)
finally:
    profiler.CallMonitor.rows, profiler.test_candidate = original_rows, original_test
report['manual_diagnostic_contract'] = 'Target-only rows; original recommendation retained; exactly verified heapRegion required; force explicitly permitted, actual AOT required by study.'
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
if len(report['functions']) != 1 or not report['functions'][0]['candidate'].get('recommended'):
    raise SystemExit('Declared target did not verify exactly as a heapRegion; evidence retained.')
if not report.get('plan', {}).get('aot_regions'):
    raise SystemExit('No AOT build for the declared diagnostic target; evidence retained.')
