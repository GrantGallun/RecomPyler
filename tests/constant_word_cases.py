"""Fresh original-frame checks for compile-time immortal constant words."""
import dis,gc,sys,types,weakref
from functools import partial
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive


def install(function,args):
    body=lower(build(function),frame_entry=True,constant_words=True)
    owner=Keepalive(body)
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=args)
    # Execution resources must not keep source/code constants alive themselves.
    owner.lowered=body.execution_owner
    return owner,handle


def case_contract():
    from recompyler.ir.semantics import contract
    from recompyler.ir.types import ValueType
    instructions=list(dis.get_instructions(ValueType.__eq__))
    expected=[contract(i) for i in instructions]
    owner,handle=install(contract,(instructions[0],));target=partial(contract)
    try:
        for _ in range(4):assert [target(i) for i in instructions]==expected
        assert owner.calls.value==4*len(instructions)
    finally:handle.close()


def mortal_subject(callback,flag=False):
    while flag:flag=False
    value='mortal_word_marker'
    callback()
    return value


def replacement(callback,flag=False):return None


def case_mortal_lifetime():
    events=[]
    class Marker:
        def __del__(self):events.append('drop')
    value=Marker();ref=weakref.ref(value)
    constants=tuple(value if item=='mortal_word_marker' else item for item in mortal_subject.__code__.co_consts)
    function=types.FunctionType(mortal_subject.__code__.replace(co_consts=constants),globals(),argdefs=(False,))
    del constants,value
    def mutate():
        function.__code__=replacement.__code__
        events.append('changed');assert ref() is not None
    owner,handle=install(function,(None,False))
    try:
        result=partial(function)(mutate)
        assert owner.calls.value==1 and result is ref() and events==['changed']
        del result;gc.collect()
        assert ref() is None and events==['changed','drop']
    finally:handle.close()


def exception_subject(callback,flag=False):
    while flag:flag=False
    value='exception_word_marker'
    callback()
    return value


def case_error_handoff():
    marker=object();constants=tuple(marker if item=='exception_word_marker' else item for item in exception_subject.__code__.co_consts)
    function=types.FunctionType(exception_subject.__code__.replace(co_consts=constants),globals(),argdefs=(False,))
    error=LookupError('constant handoff')
    def fail():raise error
    owner,handle=install(function,(None,False))
    try:
        try:partial(function)(fail)
        except LookupError as caught:
            assert caught is error and owner.calls.value==1
            tb=caught.__traceback__
            while tb and tb.tb_frame.f_code is not function.__code__:tb=tb.tb_next
            assert tb is not None and tb.tb_frame.f_locals['value'] is marker
            del tb;error.__traceback__=None
        else:raise AssertionError('missing original exception')
    finally:handle.close()


if __name__=='__main__':
    name=sys.argv[1];globals()['case_'+name]();print('PASS '+name,flush=True)
