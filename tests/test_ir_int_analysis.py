"""Facts must be universal across joins, mutations, callbacks and errors."""
import dis
from recompyler.ir.builder import build
from recompyler.ir.int_analysis import analyze_intbounds


def binaries(function):
    graph=build(function)
    facts=analyze_intbounds(graph)
    return graph,facts,[facts.at[op.offset] for block in graph.blocks.values()
                       for op in block.operations if op.name=='binary']


def test_exact_local_arithmetic_and_overflow():
    def f(flag):
        return (12 if flag is None else 13)+7
    _,_,ops=binaries(f)
    assert ops[0].no_overflow
    assert any(op.results[0] is not None and op.results[0].contains(20) for op in ops)
    def overflow(flag):
        return (((1<<63)-1) if flag is None else ((1<<63)-1))+1
    _,_,ops=binaries(overflow)
    assert not ops[0].no_overflow
    assert ops[0].results==(None,)


def test_unknown_bool_subclass_and_callback_are_not_integer_premises():
    def unknown(x):return x+0
    def boolean():
        x=True
        return x+1
    def callback(fn):
        x=12
        fn()
        return x+7
    for f in (unknown,boolean,callback):
        _,_,ops=binaries(f)
        assert not ops[0].no_overflow


def test_diamond_joins_all_predecessors():
    def f(flag):
        return (((((12 if flag is None else 30)+1)+2)+3)+4)+5
    _,facts,ops=binaries(f)
    assert ops[0].no_overflow
    assert ops[0].results[0].contains(13)
    assert ops[0].results[0].contains(31)
    def mixed(flag,x):
        if flag is None:x=12
        return x+1
    assert not binaries(mixed)[2][0].no_overflow


def test_loop_converges_and_exception_path_drops_facts():
    def loop(n):
        x=1
        while n:
            x=x+1
            n=n-1
        return x+1
    graph,facts,ops=binaries(loop)
    assert facts.iterations<100
    assert any(not op.no_overflow for op in ops)
    def handler(fn):
        x=1
        try:fn()
        except ValueError:return x+1
    assert not binaries(handler)[2][0].no_overflow


def test_store_finalizer_can_mutate_other_locals():
    def f(old):
        x=12
        old=1
        return x+1
    assert not binaries(f)[2][0].no_overflow


def test_suspension_is_a_barrier():
    def f():
        x=12
        yield x
        return x+1
    assert not binaries(f)[2][0].no_overflow




def test_pending_resume_can_publish_an_unknown_local_owner():
    # Pending Python work at RESUME can find/mutate this real frame before its
    # first STORE. A later replacement can therefore finalize an unknown owner.
    def f():
        x=12
        return x+1
    assert not binaries(f)[2][0].no_overflow




