"""Bounded direct closure-primitive oracle; seed is printed for replay."""
import gc,random,struct,time,types
import psutil
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
from recompyler import _closure_ops_native as ops
from test_closure_primitives_pending import outer
seed=77102
rng=random.Random(seed)
values=[None,True,False,0,-1,2**90,-0.0,float('inf'),struct.unpack('!d',bytes.fromhex('7ff8000000000042'))[0],complex(-0.0,2),[],{},set(),object(),'wide \u03bb \U0001f600',b'bytes']
count=0
for trial in range(10000):
    owner=values[rng.randrange(len(values))]
    template=outer(owner)
    cells=template.__closure__
    defaults=(values[rng.randrange(len(values))],)
    kw={'tail':values[rng.randrange(len(values))]}
    expected=types.FunctionType(template.__code__,template.__globals__,argdefs=defaults,closure=cells)
    expected.__kwdefaults__=kw
    actual=ops.make_function(template.__code__,template.__globals__,cells,defaults,kw)
    assert actual.__code__ is expected.__code__ and actual.__globals__ is expected.__globals__
    assert actual.__closure__ is expected.__closure__ is cells
    assert actual.__defaults__ is expected.__defaults__ is defaults
    assert actual.__kwdefaults__ is expected.__kwdefaults__ is kw
    left,right=expected(),actual()
    assert all(a is b for a,b in zip(left,right))
    replacement=values[rng.randrange(len(values))]
    assert ops.cell_get(cells[0],'owner',True) is owner
    ops.cell_set(cells[0],replacement)
    assert expected()[0] is actual()[0] is replacement
    ops.cell_delete(cells[0],'owner',True)
    for call in (lambda:ops.cell_get(cells[0],'owner',True),expected,actual):
        try:call()
        except NameError as error:
            assert type(error) is NameError and error.name=='owner'
            assert str(error)=="cannot access free variable 'owner' where it is not associated with a value in enclosing scope"
        else:raise AssertionError('missing unbound error')
    count+=1
print({'seed':seed,'checked':count,'wrong':0,'errors':0},flush=True)
