"""Literal S89 RED: bulk cold seeding retires hot prepared entries.

Run: python bench/libs/repro_bulk_entry.py jinja2_render --expect-hot-entry
Correctness-only, one below-normal worker; uses installed packages only.
"""
import collections,ctypes,json,sys
from pathlib import Path
from bench.libs.workloads import workloads,output_digest
from bench.libs.diagnose import collect_calls,select_targets,entry_state,public_row
from bench.libs.census import compile_library
import tools.ir_self_host as canonical
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
name=sys.argv[1]; case=workloads()[name];run=case.prepare();expected=output_digest(run())
for _ in range(8): assert output_digest(run())==expected
_,observed=collect_calls(run,case.package);selected,excluded=select_targets(observed)
for _ in range(8): assert output_digest(run())==expected
hot={r['name']:r['calls'] for r in selected}
watched=[(r,r['function']()) for r in selected if r['function']() is not None]
changes=[];last={};ordinal=0
original=canonical.install_candidate

def install(function):
 global ordinal
 ordinal+=1
 try: return original(function)
 finally:
  for row,target in watched:
   state=entry_state(target)
   signature=(state['prepared'],state['installed'],state['active'])
   if last.get(id(target)) != signature:
    changes.append(dict(function=row['name'],after_install=function.__qualname__,ordinal=ordinal,state=state))
    last[id(target)]=signature
canonical.install_candidate=install
report,compiled,counters=compile_library(case.package,install=True,budget=60,count_entries=True,hotness=hot)
before=[dict(public_row(row),state=entry_state(target)) for row,target in watched]
for counter in counters.values(): counter.calls.value=0
for _ in range(32): assert output_digest(run())==expected
counts={n:c.calls.value for n,c in counters.items() if c.calls.value}
after=[dict(public_row(row),state=entry_state(target)) for row,target in watched]
result=dict(name=name,compiled=report['compiled'],attempted=report['attempted'],not_attempted=report['not_attempted'],installed=report['installed_after'],native_entries=sum(counts.values()),counts=counts,before=before,after=after,changes=changes)
Path('bench/libs/results/bulk-state-'+name+'.json').write_text(json.dumps(result,indent=2))
print(json.dumps({k:v for k,v in result.items() if k not in ('counts','before','after','changes')}))
print('changes',json.dumps(changes[-20:],indent=2))

if "--expect-hot-entry" in sys.argv:
 assert result["native_entries"] > 0, "hot native entries retired while seeding cold functions"
