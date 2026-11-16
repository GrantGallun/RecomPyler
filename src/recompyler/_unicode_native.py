"""Numba extensions over pinned Unicode buffers, using this CPython's UCD.

Imported only by the native runtime. No process addresses enter generated code:
CPython symbols are ordinary external calls, including in the vendored AOT path.
"""
from llvmlite import ir
from numba import types
from numba.core import cgutils
from numba.extending import intrinsic, register_jitable
from numba.cpython.unicode import _get_code_point, _get_str_slice_view


def _property(symbol):
    def define(typing_context, character):
        if not isinstance(character,types.Integer):return
        def codegen(context,builder,signature,args):
            code=context.cast(builder,args[0],signature.args[0],types.uint32)
            fn=cgutils.get_or_insert_function(builder.module,ir.FunctionType(ir.IntType(32),[ir.IntType(32)]),symbol)
            return builder.icmp_signed('!=',builder.call(fn,[code]),ir.Constant(ir.IntType(32),0))
        return types.boolean(character),codegen
    return intrinsic(define)

_lower=_property('_PyUnicode_IsLowercase')
_upper=_property('_PyUnicode_IsUppercase')
_title=_property('_PyUnicode_IsTitlecase')
_space=_property('_PyUnicode_IsWhitespace')
_numeric=_property('_PyUnicode_IsNumeric')
_printable=_property('_PyUnicode_IsPrintable')
_alpha=_property('_PyUnicode_IsAlpha')
_digit=_property('_PyUnicode_IsDigit')
_decimal=_property('_PyUnicode_IsDecimalDigit')


@intrinsic
def _identifier(typing_context,text):
    if not isinstance(text,types.UnicodeType):return
    def codegen(context,builder,signature,args):
        value=cgutils.create_struct_proxy(signature.args[0])(context,builder,value=args[0])
        py=context.get_python_api(builder)
        slot=cgutils.alloca_once_value(builder,value.parent)
        temporary=cgutils.alloca_once_value(builder,ir.Constant(ir.IntType(1),0))
        with builder.if_then(cgutils.is_null(builder,value.parent)):
            obj=py.string_from_kind_and_data(value.kind,value.data,value.length)
            with builder.if_then(cgutils.is_null(builder,obj),likely=False):
                context.call_conv.return_exc(builder)
            builder.store(obj,slot);builder.store(ir.Constant(ir.IntType(1),1),temporary)
        fn=cgutils.get_or_insert_function(builder.module,ir.FunctionType(ir.IntType(32),[py.pyobj]),'PyUnicode_IsIdentifier')
        result=builder.call(fn,[builder.load(slot)])
        with builder.if_then(builder.load(temporary)):py.decref(builder.load(slot))
        return builder.icmp_signed('!=',result,ir.Constant(ir.IntType(32),0))
    return types.boolean(text),codegen


@register_jitable
def character(st,target,index):
    size=len(target)
    # Avoid signed addition overflow for extreme negative bounds.
    if index < -size or index >= size:
        st[0]=1
        return ''
    if index<0:index+=size
    return _get_str_slice_view(target,index,1)


@register_jitable
def _find(text,needle,start,end,reverse):
    n=len(text);m=len(needle)
    if start<0:start=max(0,start+n)
    if end<0:end=max(0,end+n)
    else:end=min(n,end)
    if start>n or end-start<m:return -1
    if reverse:
        i=end-m
        while i>=start:
            j=0
            while j<m and _get_code_point(text,i+j)==_get_code_point(needle,j):j+=1
            if j==m:return i
            i-=1
    else:
        i=start
        while i<=end-m:
            j=0
            while j<m and _get_code_point(text,i+j)==_get_code_point(needle,j):j+=1
            if j==m:return i
            i+=1
    return -1


PREDICATES={}
_SIMPLE={'isspace':'_space(c)','isnumeric':'_numeric(c)','isprintable':'_printable(c)',
         'isalpha':'_alpha(c)','isdecimal':'_decimal(c)','isdigit':'_digit(c)',
         'isalnum':'(_alpha(c) or _decimal(c) or _digit(c) or _numeric(c))',
         'isascii':'c<128'}
for name,expression in _SIMPLE.items():
    empty=name in ('isascii','isprintable')
    source=('def impl(st,obj,args):\n    if not len(obj):return '+str(empty)+
            '\n    for i in range(len(obj)):\n        c=_get_code_point(obj,i)\n        if not ('+expression+') :return False\n    return True\n')
    scope=dict(globals());exec(source,scope);PREDICATES[name]=register_jitable(scope['impl'])


def identifier(st,obj,args):return _identifier(obj)
PREDICATES['isidentifier']=register_jitable(identifier)


def lower(st,obj,args):
    cased=False
    for i in range(len(obj)):
        c=_get_code_point(obj,i)
        if _upper(c) or _title(c):return False
        if _lower(c):cased=True
    return cased
PREDICATES['islower']=register_jitable(lower)


def upper(st,obj,args):
    cased=False
    for i in range(len(obj)):
        c=_get_code_point(obj,i)
        if _lower(c) or _title(c):return False
        if _upper(c):cased=True
    return cased
PREDICATES['isupper']=register_jitable(upper)


def title(st,obj,args):
    cased=False;previous=False
    for i in range(len(obj)):
        c=_get_code_point(obj,i)
        if _upper(c) or _title(c):
            if previous:return False
            previous=True;cased=True
        elif _lower(c):
            if not previous:return False
            previous=True;cased=True
        else:previous=False
    return cased
PREDICATES['istitle']=register_jitable(title)


_SEARCHES={}
def method(name,argtypes):
    count=len(argtypes)
    if name in PREDICATES and not count:return PREDICATES[name]
    if name not in ('find','index','rfind','rindex','count','startswith','endswith') or not 1<=count<=3:return
    if not isinstance(types.unliteral(argtypes[0]),types.UnicodeType):return
    if any(not isinstance(types.unliteral(t),(types.Integer,types.Boolean,types.NoneType)) for t in argtypes[1:]):return
    key=name,tuple(argtypes)
    if key not in _SEARCHES:
        start='args[1]' if count>1 and argtypes[1]!=types.none else '0'
        end='args[2]' if count>2 and argtypes[2]!=types.none else 'len(obj)'
        body='    start='+start+'\n    end='+end+'\n'
        if name=='count':
            body+='    total=0\n    while True:\n        at=_find(obj,args[0],start,end,False)\n        if at<0:return total\n        total+=1\n        start=at+max(1,len(args[0]))\n'
        else:
            reverse=name in ('rfind','rindex','endswith')
            body+='    at=_find(obj,args[0],start,end,'+str(reverse)+')\n'
            if name in ('index','rindex'):body+='    if at<0:st[0]=1\n'
            if name=='startswith':body+='    return at>=0 and at==max(0,start+len(obj) if start<0 else start)\n'
            elif name=='endswith':body+='    stop=max(0,end+len(obj)) if end<0 else min(len(obj),end)\n    return at>=0 and at+len(args[0])==stop\n'
            else:body+='    return at\n'
        scope=dict(globals());exec('def impl(st,obj,args):\n'+body,scope)
        _SEARCHES[key]=scope['impl']
    return _SEARCHES[key]
