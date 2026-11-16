"""Bounded CPython oracle for CFG integer facts; no native speed claims."""
import ctypes
import json
from pathlib import Path
import random
import sys
import time

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'src'))
from recompyler.ir.builder import build
from recompyler.ir.int_analysis import analyze_intbounds


def main():
    if sys.platform=='win32':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    rng=random.Random(22094)
    limit=float(sys.argv[1]) if len(sys.argv)>1 else 60
    started=time.monotonic()
    calls=proved=graphs=0
    interesting=[-(1<<63),-(1<<63)+1,-257,-1,0,1,256,(1<<63)-2,(1<<63)-1,1<<63]
    while time.monotonic()-started<limit:
        a,b,c=(rng.choice(interesting) if rng.randrange(2) else rng.randrange(-100000,100000) for _ in range(3))
        operator=rng.choice(['+','-','*','&','|','^'])
        source='def case(flag):\n return (('+repr(a)+' if flag is None else '+repr(b)+') '+operator+' '+repr(c)+')\n'
        namespace={}
        exec(compile(source,'<wave22-facts-oracle>','exec'),namespace)
        function=namespace['case']
        graph=build(function);facts=analyze_intbounds(graph)
        returns={op.offset:facts.at[op.offset].arguments[0] for block in graph.blocks.values()
                 for op in block.operations if op.name=='return'}
        for flag in (None,False,True,0,1,object()):
            returned=[]
            def trace(frame,event,arg):
                if event=='return' and frame.f_code is function.__code__:returned.append(frame.f_lasti)
                return trace
            sys.settrace(trace)
            try:value=function(flag)
            finally:sys.settrace(None)
            calls+=1
            bound=returns.get(returned[0])
            if bound is not None:
                proved+=1
                if type(value) is not int or not bound.contains(value):
                    raise AssertionError((source,flag,value,bound))
        graphs+=1
    print(json.dumps(dict(graphs=graphs,calls=calls,proved_return_facts=proved,mismatches=0,
                          scope='CPython return-value oracle for static facts; not native execution')))
    return 0


if __name__=='__main__':raise SystemExit(main())

