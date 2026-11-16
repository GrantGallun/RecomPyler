"""Inlined comprehensions use the common IR and original CPython frame locals."""
import ctypes,gc,os,subprocess,sys,types
from pathlib import Path
import pytest
from recompyler import heap
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive


def list_values(values):return [value for value in values]
def set_values(values):return {value for value in values}
def dict_values(values):return {value:value for value in values}
def restore_value(values,value):
    result=[value for value in values]
    return result,value

def nested_pairs(rows):return {(key,value):value for row in rows for key,value in row}

def original_entry(value):return value


@pytest.mark.parametrize('function',[list_values,set_values,dict_values,restore_value,nested_pairs,heap._Program.constant_strings,heap._Program.written_set])
def test_prepare_real_inlined_comprehension_body(function):
    lowered=lower(build(function),frame_entry=True)
    assert lowered.body_address>0 and lowered.graph.code is function.__code__
    assert lowered.graph.exceptions


def native(function,args):
    owner=Keepalive(lower(build(function),frame_entry=True))
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=args)
    return owner,handle


def case_identity_and_local_restore():
    a=object();b=object();outer=object();values=[a,b,a]
    for function in (list_values,set_values,dict_values,restore_value,nested_pairs):
        args=(values,outer) if function is restore_value else ([[(a,b),(b,a)],[(a,a)]],) if function is nested_pairs else (values,)
        owner,handle=native(function,args)
        try:
            result=function(*args)
            assert owner.calls.value==1,(function.__name__,owner.calls.value)
            if function is restore_value:
                assert result[1] is outer;result=result[0]
            if function in (list_values,restore_value):assert result[0] is a and result[1] is b and result[2] is a
            elif function is nested_pairs:assert result[(a,b)] is b and result[(b,a)] is a and result[(a,a)] is a
            elif function is dict_values:assert result[a] is a and result[b] is b
            else:assert result=={a,b}
            empty=function([],outer) if function is restore_value else function([])
            assert (empty[0] if function is restore_value else empty)==([] if function in (list_values,restore_value) else {} if function in (dict_values,nested_pairs) else set())
            assert owner.calls.value==2
        finally:handle.close()


def case_original_inference_helpers():
    class First:pass
    class Second:pass
    program=heap._Program(original_entry)
    text=''.join(['original',' IR constant owner'])
    program.global_objects=[({},text,None)];program._constant_blocks=(12,{0:21},[])
    program.alias[Second]=First;program.written={(First,'x'),(Second,'y')}
    for function in (heap._Program.constant_strings,heap._Program.written_set):
        owner,handle=native(function,(program,))
        try:
            result=function(program);assert owner.calls.value==1
            if function is heap._Program.constant_strings:assert result==[(text,21)] and result[0][0] is text
            else:assert result=={(First,'x'),(First,'y')}
        finally:handle.close()


def case_partial_error_restores_original_shadowed_local():
    marker=object();outer=object();failure=ValueError('next failure');events=[]
    class Source:
        count=0
        def __iter__(self):return self
        def __next__(self):
            self.count+=1
            frame=sys._getframe(1);events.append((frame.f_code is restore_value.__code__,frame.f_lasti))
            if self.count==1:return marker
            raise failure
    # Seeding reads the original frame shape and never starts this iterator.
    source=Source();owner,handle=native(restore_value,(source,outer));assert source.count==0
    try:
        try:restore_value(source,outer)
        except ValueError as error:
            assert error is failure and owner.calls.value==1
            tb=error.__traceback__
            while tb and tb.tb_frame.f_code is not restore_value.__code__:tb=tb.tb_next
            assert tb and tb.tb_frame.f_locals['value'] is outer
            del tb;failure.__traceback__=None
        else:raise AssertionError('missing original iterator exception')
        assert len(events)==2 and all(event[0] for event in events)
    finally:handle.close()


def case_map_hash_failure_preserves_original_handler_and_exception():
    failure=ValueError('hash failed');events=[]
    class Key:
        def __hash__(self):
            frame=sys._getframe(1);events.append((frame.f_code is dict_values.__code__,frame.f_lasti));raise failure
    values=[Key()];owner,handle=native(dict_values,(values,))
    try:
        try:dict_values(values)
        except ValueError as error:
            assert error is failure and owner.calls.value==1
            tb=error.__traceback__
            while tb and tb.tb_frame.f_code is not dict_values.__code__:tb=tb.tb_next
            assert tb and 'value' not in tb.tb_frame.f_locals
            del tb;failure.__traceback__=None
        else:raise AssertionError('missing original hash exception')
        assert len(events)==1 and events[0][0]
    finally:handle.close()


@pytest.mark.slow
@pytest.mark.parametrize('case',['identity_and_local_restore','original_inference_helpers','partial_error_restores_original_shadowed_local','map_hash_failure_preserves_original_handler_and_exception'])
def test_actual_comprehension_execution(case):
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(Path(__file__).resolve()),case],cwd=root,env=env,capture_output=True,text=True,timeout=90,
        creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout


if __name__=='__main__':
    case=sys.argv[1];globals()['case_'+case]();print('PASS '+case,flush=True)
