import sys,json
from pathlib import Path
sys.path.insert(0,str(Path('tests').resolve()))
from test_prepared_cache import load_source,standalone,row_for
from recompyler import _prepared as pc
folder=Path('inplace/temp/s31-prepared-review-green-v2/prepared-real-aot0').resolve()
module=load_source(folder/'workload.py');section=json.loads((folder/'section.json').read_text())
old=pc._class_unchanged
def unchanged(snapshot):
    result=old(snapshot)
    if not result:
        cls,mro,items=snapshot;current=vars(cls)
        print('CLASS CHANGE',cls,'mro',cls.__mro__ is mro,'added',set(current)-dict(items).keys(),flush=True)
        for n,saved in items:
            v=current.get(n)
            if saved[0]=='weak': good=v is saved[1]()
            elif saved[0]=='method': good=type(v) is saved[1] and id(v)==saved[2] and v.__func__ is saved[3]()
            else: good=v is saved[1]
            if not good: print('CHANGED',n,saved[0],flush=True)
    return result
pc._class_unchanged=unchanged
idx=pc.open_index(section,row_for(section,'random_step'),plan_snapshot=standalone(section))
print('BIND',len(idx.bind(module.random_step)),pc.last_miss(),flush=True)
import pytest
sys.exit(pytest.main(['-q','inplace/prepared-cache-preparation/test_prepared_review_regressions.py','-k','mutable_metadata','--basetemp','inplace/temp/s31-prepared-late-metadata-red-v1']))
