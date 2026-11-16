"""Bounded differential checks for optional M2 plans, never a speed test."""
import argparse
import ctypes
import os
import random
import struct
import time
from recompyler.ir.inlining import map_call_args,DefaultArgument,InlineRefused
from recompyler.ir.type_lattice import BOTTOM,TOP,OBJECT,PRIMITIVE,constant,exact_builtin


def target(a,b=20,/,c=30,*args,d,**kwargs):return a,b,c,args,d,kwargs


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--seconds',type=float,default=60)
    args=parser.parse_args()
    if not 0<args.seconds<=120:parser.error('bounded duration must be in (0,120]')
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    rng=random.Random(790080);end=time.monotonic()+args.seconds
    samples=[None,False,True,-1,0,1,3,4,-0.0,0.0,1.0,complex(-0.0,2),'x',[],{},object()]
    samples.extend(struct.unpack('>d',struct.pack('>Q',bits))[0] for bits in (0x7ff8000000000042,0xfff0000000000000,0x7ff0000000000000))
    types=[BOTTOM,TOP,OBJECT,PRIMITIVE,exact_builtin(int),exact_builtin(float),exact_builtin(str)]
    types.extend(constant(v) for v in samples if type(v) in (type(None),bool,int,float,complex))
    iterations=mapped=declined=checks=0
    while time.monotonic()<end:
        a,b,c=rng.choices(types,k=3)
        left=rng.choice((a|b,a&b,a-b))
        right=rng.choice((b|c,b&c,b-c))
        for x,y in ((a,b),(left,right)):
            union,meet,difference=x|y,x&y,x-y
            assert x<=union and meet<=x and x|y==y|x and x&y==y&x
            for value in rng.sample(samples,3):
                mx,my=x.matches(value),y.matches(value)
                assert not (mx or my) or union.matches(value)
                assert not (mx and my) or meet.matches(value)
                assert not (mx and not my) or difference.matches(value)
                assert not (x<=y and mx) or my
                checks+=4
        npos=rng.randrange(7);names=tuple(rng.choices(('c','d','x','a','extra'),k=rng.randrange(4)))
        try:m=map_call_args(target.__code__,npos,names,positional_defaults=2)
        except InlineRefused:declined+=1
        else:
            values=tuple(rng.randrange(-1000,1000) for _ in range(npos+len(names)))
            expected=target(*values[:npos],**dict(zip(names,values[npos:])))
            params=tuple(target.__defaults__[s.index] if isinstance(s,DefaultArgument) else values[s] for s in m.parameters)
            actual=(*params[:3],tuple(values[i] for i in m.varargs),params[3],dict((k,values[i]) for k,i in m.varkw))
            assert actual==expected
            mapped+=1
        iterations+=1
    print(f'iterations={iterations} lattice_checks={checks} canonical_calls={mapped} declined_calls={declined} wrong=0',flush=True)


if __name__=='__main__':main()
