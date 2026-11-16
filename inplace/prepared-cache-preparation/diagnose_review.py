import sys
from pathlib import Path
sys.path.insert(0,str(Path('tests').resolve()))
from test_prepared_cache import load_source,standalone,row_for
from recompyler import _prepared as pc,heap
source=Path('inplace/temp/s31-prepared-review-green-v1/prepared-real-aot0/workload.py').resolve()
module=load_source(source)
original=pc._binding_key
def binding(value):
    try:return original(value)
    except pc.PreparedMiss:
        t=type(value)
        print('REJECTED TYPE',type.__getattribute__(t,'__module__'),type.__getattribute__(t,'__name__'),flush=True)
        raise
pc._binding_key=binding
old=pc._class_unchanged
def unchanged(snapshot):
    result=old(snapshot)
    if not result:
        cls,mro,items=snapshot;current=vars(cls)
        print('CLASS CHANGE',cls,'mro',cls.__mro__ is mro,'added',set(current)-dict(items).keys(),'changed',[n for n,v in items if current.get(n) is not v],flush=True)
    return result
pc._class_unchanged=unchanged
entries=[]
for fn,args in [(module.work,(module.Box(10),[])),(module.random_step,(100,))]:
    region=heap.lift_region(fn);region(*args)
    entries.append(((fn.__name__,fn.__code__.co_firstlineno),fn,region))
folder=Path('inplace/prepared-diagnostic-v1');folder.mkdir(exist_ok=False)
section=heap.build_regions(entries,folder)
print('DIAGNOSTICS',section['prepared']['diagnostics'],flush=True)
for fn,_ in [(module.work,0),(module.random_step,0)]:
    idx=pc.open_index(section,row_for(section,fn.__name__),plan_snapshot=standalone(section))
    print('BIND',fn.__name__,len(idx.bind(fn)),pc.last_miss(),flush=True)
