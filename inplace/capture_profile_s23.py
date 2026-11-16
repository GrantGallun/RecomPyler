"""S23 profile adapter: inclusive-priority replayable coverage policy; full inventory remains an audit-only sidecar."""
import hashlib
import json
from pathlib import Path
import sys
from recompyler import profiler
from recompyler.monitor import CallMonitor
from capture_behavior import ApplicationOutput

class InventoryMonitor(CallMonitor):
    latest = None
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        InventoryMonitor.latest = self
    def __enter__(self):
        self.application=ApplicationOutput(output)
        self.application.__enter__()
        try:return super().__enter__()
        except BaseException:
            self.application.__exit__(*sys.exc_info());raise
    def __exit__(self,*exc):
        try:return super().__exit__(*exc)
        finally:self.application.__exit__(*exc)

profiler.CallMonitor = InventoryMonitor
script, output = Path(sys.argv[1]), Path(sys.argv[2])
sidecar = output.with_name(output.stem+'.inventory.json')
assert not output.exists() and not sidecar.exists() and not Path(str(output)+'.application.json').exists(), 'Preserve prior/incomplete profile output; use a NEW directory'
report = profiler.profile_script(script, sys.argv[3:], 128, 8, True)
assert isinstance(report.get('candidate_ranking'), dict), 'S23 source must supply candidate_ranking'
assert isinstance(report.get('uncaptured_hotspots'), list), 'S23 source must supply uncaptured_hotspots'
ranking = report.pop('candidate_ranking')
uncaptured = report.pop('uncaptured_hotspots')
considered = {(row.get('file', str(script)), row['function'], row['line']) for row in report['functions']}
monitor = InventoryMonitor.latest
inventory = []
for row in monitor.rows():
    key = row.pop('_key')
    sampler = monitor.samplers.get(key)
    row.update(captured=bool(sampler and sampler.samples),
               samples=len(sampler.samples) if sampler else 0,
               snapshot_declines=dict(getattr(sampler,'declines',{})),
               capture_reason=monitor.skipped.get(key) or (next(iter(getattr(sampler,'declines',{})),None) if sampler and not sampler.samples else None) or ('no replayable samples' if not sampler or not sampler.samples else 'captured'))
    row['considered'] = key in considered
    row['selection_exclusion'] = None if row['considered'] else (
        'not considered: outside inclusive-priority replayable coverage budget' if row['captured']
        else 'not replayable: '+str(row['capture_reason']))
    inventory.append(row)
# Ranking and uncaptured diagnostics are also sidecar-only in this held-out adapter.
# Never feed diagnostic inventory back through the timed runner's plan loader.
report.pop('capture_inventory', None)
output.write_text(json.dumps(report, indent=2)+'\n', encoding='utf8')
sidecar = output.with_name(output.stem+'.inventory.json')
sidecar.write_text(json.dumps(dict(
    schema='wave14-s23-inventory-v1',
    candidate_ranking=ranking,
    uncaptured_hotspots=uncaptured,
    runtime_plan_sha256=hashlib.sha256(output.read_bytes()).hexdigest(),
    capture_inventory=inventory), indent=2)+'\n', encoding='utf8')

