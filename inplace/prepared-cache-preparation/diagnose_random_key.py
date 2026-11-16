import sys,json
from pathlib import Path
sys.path.insert(0,str(Path('tests').resolve()))
from test_prepared_cache import load_source,standalone,row_for
from recompyler import _prepared as pc
folder=Path('inplace/temp/s31-prepared-review-green-v3/prepared-real-aot0').resolve()
module=load_source(folder/'workload.py');section=json.loads((folder/'section.json').read_text())
refs=pc.References(module.random_step)
core=next(c for c in section['prepared']['cores'] if c['entry_id']['qualname']=='random_step')
for row in core['definitions']['functions']: refs.resolve(row['binding'])
for row in core['definitions']['classes']:
    cls=refs.resolve(row['binding']);actual=pc._class_key(cls,refs)
    if actual!=row['key']:
        print(cls.__qualname__)
        print('LAYOUT',row['key']['layout'],actual['layout'])
        old=dict(row['key']['dictionary']);new=dict(actual['dictionary'])
        for k in old.keys()|new.keys():
            if old.get(k)!=new.get(k):print(k,old.get(k),new.get(k))
idx=pc.open_index(section,row_for(section,'random_step'),plan_snapshot=standalone(section))
print(len(idx.bind(module.random_step)),pc.last_miss())
