import gc,types

def gates(original,candidates,observe):
    rows=[];saved=gc.callbacks;del gc.callbacks
    try:
        ref=observe(original,' a\n b')
        for variant,fn in candidates:
            got=observe(fn,' a\n b');rows.append({'case':'missing-gc-callbacks','variant':variant,'reference':ref,'compiled':got,'identical':ref==got})
    finally:gc.callbacks=saved
    events=[]
    class Hook(types.ModuleType):
        def __getattribute__(self,name):
            if name=='callbacks':events.append('gc-hook')
            return super().__getattribute__(name)
    old_class=gc.__class__;gc.__class__=Hook
    try:
        events.clear();ref=observe(original,' a\n b');expected=list(events)
        for variant,fn in candidates:
            events.clear();got=observe(fn,' a\n b');actual=list(events)
            rows.append({'case':'gc-module-subclass','variant':variant,'reference':ref,'compiled':got,'reference_events':expected,'compiled_events':actual,'identical':ref==got and expected==actual})
    finally:gc.__class__=old_class
    return rows
