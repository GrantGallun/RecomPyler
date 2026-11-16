"""Tabulate actual captured first failures from one complete held-out replay."""
import collections
import hashlib
import json
from pathlib import Path
import re
import sys
R=Path(__file__).resolve().parents[1]
folder=R/sys.argv[1]
assert json.loads((folder/'complete.json').read_text())['complete']
summary=json.loads((folder/'summary.json').read_text())
assert hashlib.sha256((folder/'summary.json').read_bytes()).hexdigest()==json.loads((folder/'complete.json').read_text())['summary_sha256']
failures=collections.defaultdict(list)
for program,pair in summary['programs'].items():
    for row in pair['after']['rows']:
        if not row['captured'] or row['whole_function_native']:
            continue
        c=row['candidate']
        reason=c.get('region_reason') or c.get('reason') or c.get('status')
        # Keep the actual diagnostic as well as a stable grouping. Do not infer
        # whole-function gains from the syntax or from a missing first blocker.
        group=re.sub(r"at line \d+",'at line N',reason)
        group=re.sub(r"'[^']+'", "'<name>'",group)
        failures[group].append({'program':program,'function':row['function'],'line':row['line'],'reason':reason})
rank=sorted(failures,key=lambda s:(-len(failures[s]),s))
result={'whole_function_native':summary['totals']['after']['whole_function_native'],'denominator':375,'before':summary['totals']['before'],'after':summary['totals']['after'],'first_failures':[{'reason_group':s,'functions':len(failures[s]),'programs':len({r['program'] for r in failures[s]}),'rows':failures[s]} for s in rank],'source_summary_sha256':hashlib.sha256((folder/'summary.json').read_bytes()).hexdigest()}
(folder/'first-failures.json').write_text(json.dumps(result,indent=2))
print(str(result['whole_function_native'])+' of 375')
print('| First failure | Functions | Programs |')
print('|---|---:|---:|')
for s in rank[:10]:
    rows=failures[s]
    print('| '+s.replace('|','\\|')+' | '+str(len(rows))+' | '+str(len({r['program'] for r in rows}))+' |')
