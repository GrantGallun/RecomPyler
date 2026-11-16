"""Count real original stdlib frame entries for both S84 generic operations."""
import ctypes,dataclasses,configparser,traceback,sys
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
from ir_self_host import CountedBody,install_candidate
from recompyler.ir import compile_function,compilation_info,_entry_native

class Slots: __slots__='member'
functions=[dataclasses._get_slots,vars(configparser._ReadState)['__annotate_func__'],
           traceback.StackSummary._should_show_carets,traceback._extract_caret_anchors_from_line_segment]
arguments=[(Slots,),(1,),(traceback.StackSummary(),0,7,['x = f()'],None),('a + b',)]
expected=[]
for function,args in zip(functions,arguments):
    result=function(*args)
    expected.append(tuple(result) if function is dataclasses._get_slots else result)
resources=[]
try:
    for function,args,want in zip(functions,arguments,expected):
        code=function.__code__
        compile_function(function,strict=True)
        source,original=_entry_native._compilation_owner(function)
        owner=CountedBody(original)
        _entry_native.forget_compilation(function)
        _entry_native.prepare_frame_entry(function,owner.body_address,owner,source)
        resources.append((function,owner))
        assert install_candidate(function),function.__qualname__
        before=owner.calls.value
        result=function(*args)
        actual=tuple(result) if function is dataclasses._get_slots else result
        assert actual==want,(function.__qualname__,actual,want)
        assert function.__code__ is code and owner.calls.value==before+1,(function.__qualname__,owner.calls.value)
        print('PASS',function.__qualname__,'native entries=',owner.calls.value,flush=True)
finally:
    for function,owner in resources:_entry_native.forget_compilation(function)
print('PASS native stdlib entries=4')
