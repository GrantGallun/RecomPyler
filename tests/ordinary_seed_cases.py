"""Fresh original-frame canonical argument binding during ordinary seeding."""
import ctypes,sys
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)


def prepare(function,args):
    owner=Keepalive(lower(build(function),frame_entry=True))
    code=function.__code__
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=args)
    assert owner.calls.value==0 and function.__code__ is code and handle.active
    return owner,handle


def case_defaulted_keywords():
    events=[];marker=object();default=object();override=object()
    def observe(value,flag):
        assert sys._getframe(1).f_code is function.__code__
        events.append((value,flag));return flag
    def function(action,value,/,*,flag=default):
        return action(value,flag)
    code=function.__code__;owner,handle=prepare(function,(observe,marker))
    assert events==[]
    try:
        assert function(observe,marker) is default
        assert function(observe,marker,flag=override) is override
        assert owner.calls.value==2 and events==[(marker,default),(marker,override)]
        before=owner.calls.value
        try:function(observe,marker,unknown=marker)
        except TypeError as error:assert 'unexpected keyword' in str(error)
        else:raise AssertionError('lost original argument error')
        assert owner.calls.value==before and function.__code__ is code
    finally:handle.close()


def case_variadic_keywords():
    events=[];marker=object();default=object();extra=object();override=object()
    def observe(value,items,flag,keywords):
        assert sys._getframe(1).f_code is function.__code__
        events.append((value,items,flag,keywords));return flag
    def function(action,value,/,*items,flag=default,**keywords):
        return action(value,items,flag,keywords)
    owner,handle=prepare(function,(observe,marker))
    assert events==[]
    try:
        assert function(observe,marker) is default
        assert function(observe,marker,extra,marker,flag=override,other=extra) is override
        assert owner.calls.value==2
        assert events==[(marker,(),default,{}),(marker,(extra,marker),override,{'other':extra})]
    finally:handle.close()


def case_required_keyword():
    events=[]
    def function(value,*,required):
        events.append(value);return required
    owner=Keepalive(lower(build(function),frame_entry=True));code=function.__code__
    try:install_frame_entry(function,owner.address,owner,seed_arguments=(None,))
    except TypeError as error:
        assert "missing 1 required keyword-only argument: 'required'" in str(error)
    else:raise AssertionError('seed accepted missing required keyword')
    assert function.__code__ is code and owner.calls.value==0 and events==[]


def case_actual_lowerer():
    from recompyler.ir import builder
    def target(value):
        def child(other):return value+other
        return child(2)
    target_graph=build(target)
    prepared=[];handles=[];declined=[]
    for function in (builder.build,lower):
        prepared.append((function,function.__code__,Keepalive(lower(build(function),frame_entry=True))))
    try:
        for function,code,owner in prepared:
            try:
                handle=install_frame_entry(function,owner.address,owner,seed_arguments=(None if function is builder.build else target_graph,))
            except ValueError as error:
                assert function is lower and 'declined frame entry seed' in str(error)
                declined.append(function)
            else:handles.append(handle)
            assert owner.calls.value==0 and function.__code__ is code
        graph=build(target);compiled=lower(graph,frame_entry=True)
        assert graph.code is target.__code__ and compiled.body_address>0
        for function,code,owner in prepared:
            assert owner.calls.value>=(0 if function in declined else 1) and function.__code__ is code
            if function in declined:assert owner.calls.value==0
        print('actual_native_helpers='+repr({function.__qualname__:owner.calls.value for function,code,owner in prepared})+' canonical_seed_declined='+repr([function.__qualname__ for function in declined]),flush=True)
    finally:
        for handle in reversed(handles):handle.close()


if __name__=='__main__':
    case=sys.argv[1];globals()['case_'+case]();print('PASS '+case,flush=True)
