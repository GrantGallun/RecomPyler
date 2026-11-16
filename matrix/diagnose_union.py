from pathlib import Path
import sys,json
R=Path(__file__).resolve().parents[1];sys.path[:0]=[str(R/'src'),str(R/'tests')]
import test_lift as t
import test_backends as b
from recompyler.lift import lift
for f,args in [(t.score_hand,((0,1,2,3),)),(b.particle,(1.,1.,.01)),(t.make_and_reduce,(40,2.))]:
    x=lift(f);value=x(*args)
    print(f.__name__, 'native',x.compiled_calls,'fallback',x.fallback_calls,'problem',x.problem,flush=True)
    print('names',repr(x._unit.names),'recordtext',x._record_text,flush=True)
    print('verdicts',repr(x._verdicts),flush=True)
    print('source',x.source,flush=True)

    if f is t.score_hand:
        import traceback
        packed,shape,boundary=x._pack_call(args)
        try:x._compiled(x._flag,*packed)
        except Exception:traceback.print_exc()
    if f is b.particle:
        import numba
        for result in x._compiled.overloads.values():
            a=getattr(result,'type_annotation',None)
            if hasattr(a,'typemap'):
                print('array types',[(n,str(v)) for n,v in a.typemap.items() if isinstance(v,numba.types.Array)],flush=True)
