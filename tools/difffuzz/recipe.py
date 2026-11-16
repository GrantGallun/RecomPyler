"""Portable input reconstruction, with aliases and cycles kept explicit."""
import ast
import struct
from .core import UnsupportedOracle,fields,_AST_TYPES


def recipe(args,kwargs):
    lines=['import ast','import struct','class DifffuzzInt(int): pass','class DifffuzzFloat(float): pass'];seen={};later=[]
    def emit(value):
        cls=type(value)
        if cls is float:return "struct.unpack('!d',bytes.fromhex(%r))[0]"%struct.pack('!d',value).hex()
        if cls is complex:return 'complex(%s,%s)'%(emit(value.real),emit(value.imag))
        if cls in (type(None),bool,int,str,bytes):return repr(value)
        if id(value) in seen:return seen[id(value)]
        name='_v'+str(len(seen));seen[id(value)]=name
        if cls in (list,dict,set,bytearray):
            init={list:'[]',dict:'{}',set:'set()',bytearray:repr(value)}[cls];lines.append(name+'='+init)
            if cls is list:
                for item in value:
                    expr=emit(item);later.append(name+'.append('+expr+')')
            elif cls is dict:
                for k,v in value.items():
                    key=emit(k);val=emit(v);later.append(name+'['+key+']='+val)
            elif cls is set:
                for item in sorted(value,key=repr):later.append(name+'.add('+emit(item)+')')
        elif cls is tuple:
            exprs=[emit(x) for x in value];lines.append(name+'=('+','.join(exprs)+',)' if exprs else name+'=()')
        elif cls in _AST_TYPES:
            lines.append(name+'=ast.AST.__new__(ast.'+cls.__name__+')')
            for key,child in fields(value).items():
                expression=emit(child);later.append(name+'.'+key+'='+expression)
        elif cls is range:lines.append(name+'=range(%r,%r,%r)'%(value.start,value.stop,value.step))
        elif cls is frozenset:
            values=[emit(v) for v in sorted(value,key=lambda v:(type(v).__name__,repr(v)))]
            lines.append(name+'=frozenset(('+','.join(values)+(',' if values else '')+'))')
        elif isinstance(value,int) and cls.__module__=='difffuzz.core':lines.append(name+'=DifffuzzInt('+str(int(value))+')')
        elif isinstance(value,float) and cls.__module__=='difffuzz.core':lines.append(name+'=DifffuzzFloat('+emit(float(value))+')')
        else:raise UnsupportedOracle('portable input recipe: '+cls.__name__)
        return name
    a=emit(args);k=emit(kwargs)
    return '\n'.join(lines+later+['ARGS='+a,'KWARGS='+k])+'\n'
