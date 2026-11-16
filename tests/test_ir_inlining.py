"""Cinder-style call plans preserve canonical Python binding or decline."""
import dis
import pytest


def target(a,b=20,/,c=30,*args,d,**kwargs):
    return a,b,c,args,d,kwargs


def api():
    from recompyler.ir.inlining import map_call_args,DefaultArgument,InlineRefused
    return map_call_args,DefaultArgument,InlineRefused


def test_operand_positions_kwonly_varargs_and_excess_keywords():
    map_args,_,_=api()
    m=map_args(target.__code__,5,('extra','d'))
    assert m.parameters==(0,1,2,6)
    assert m.varargs==(3,4) and m.varkw==(('extra',5),)


def test_positional_defaults_are_indices_without_capturing_objects():
    map_args,D,_=api()
    def fn(a,b=object(),c=object()):return a,b,c
    m=map_args(fn.__code__,1,positional_defaults=2)
    assert m.parameters==(0,D(0),D(1))


@pytest.mark.parametrize('count,names',[(1,('a','d')),(3,('c','d')),(3,('x','x','d')),(0,('d',)),(3,())])
def test_ambiguous_or_missing_calls_decline(count,names):
    map_args,_,Refused=api()
    with pytest.raises(Refused):map_args(target.__code__,count,names,positional_defaults=2)


def test_foreign_keyword_name_never_runs_protocols():
    map_args,_,Refused=api()
    class Name(str):
        def __hash__(self):raise AssertionError('hash')
        def __eq__(self,other):raise AssertionError('eq')
    with pytest.raises(Refused):map_args(target.__code__,3,(Name('d'),))


def test_unknown_keyword_and_excess_positionals_decline_for_fixed_signature():
    map_args,_,Refused=api()
    def fn(a):return a
    for count,names in ((2,()),(1,('x',))):
        with pytest.raises(Refused):map_args(fn.__code__,count,names)


def test_supported_mappings_match_real_python_binding():
    map_args,D,Refused=api()
    checked=0
    for npos in range(1,7):
        for names in (('d',),('c','d'),('d','extra'),('extra','d'),('d','extra','more'),('b','d')):
            values=tuple(range(100,100+npos+len(names)))
            try:m=map_args(target.__code__,npos,names,positional_defaults=2)
            except Refused:continue
            def source(s):return target.__defaults__[s.index] if isinstance(s,D) else values[s]
            params=tuple(source(s) for s in m.parameters)
            expected=target(*values[:npos],**dict(zip(names,values[npos:])))
            actual=(*params[:3],tuple(values[i] for i in m.varargs),params[3],dict((k,values[i]) for k,i in m.varkw))
            assert actual==expected
            checked+=1
    assert checked>=15


def test_cost_counts_logical_instructions_and_stable_small_first_selection():
    from recompyler.ir.inlining import InlineCandidate,code_cost,plan_inlining
    def caller():return 0
    def small(x):return x
    def large(x):return x+x+x+x
    assert code_cost(large.__code__)==len(tuple(dis.get_instructions(large)))
    candidates=(InlineCandidate(large.__code__,10,(caller.__code__,)),InlineCandidate(small.__code__,20,(caller.__code__,)),InlineCandidate(small.__code__,30,(caller.__code__,)))
    budget=code_cost(caller.__code__)+2*code_cost(small.__code__)
    p=plan_inlining(caller.__code__,candidates,cost_limit=budget)
    assert tuple(c.site for c in p.accepted)==(20,30)
    assert p.refused==((candidates[0],'cost'),) and p.cost==budget


def test_recursive_deep_cold_and_suspending_candidates_are_refused():
    from recompyler.ir.inlining import InlineCandidate,plan_inlining
    def caller():return 0
    def other():return 1
    def gen():yield 1
    cases=(InlineCandidate(caller.__code__,1,(caller.__code__,),100),InlineCandidate(other.__code__,2,(caller.__code__,other.__code__),100),InlineCandidate(other.__code__,3,(caller.__code__,),0),InlineCandidate(gen.__code__,4,(caller.__code__,),100))
    p=plan_inlining(caller.__code__,cases,cost_limit=1000,depth_limit=1,caller_count=100)
    assert not p.accepted
    assert {c.site:reason for c,reason in p.refused}=={1:'recursive',2:'recursive',3:'cold',4:'suspending'}


def test_extra_leading_defaults_follow_cpython_right_alignment():
    map_args,D,_=api()
    def fn(a,b):return a,b
    fn.__defaults__=(10,20,30,40)
    m=map_args(fn.__code__,0,positional_defaults=4)
    assert m.parameters==(D(2),D(3))
    assert tuple(fn.__defaults__[s.index] for s in m.parameters)==fn()


def test_depth_limit_checks_nonrecursive_inline_stack():
    from recompyler.ir.inlining import InlineCandidate,plan_inlining
    def caller():return 0
    def middle():return 1
    def callee():return 2
    c=InlineCandidate(callee.__code__,1,(caller.__code__,middle.__code__),100)
    p=plan_inlining(caller.__code__,(c,),cost_limit=1000,depth_limit=1)
    assert p.refused==((c,'depth'),)
