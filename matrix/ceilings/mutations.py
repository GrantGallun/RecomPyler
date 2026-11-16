from pathlib import Path
import base64,json,sys
R=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(R/'matrix'),str(R/'matrix/temp/ceilings')]
import wave17_ceiling_bytes as ext
from run_matrix import exception

def observe(fn,args):
    try:
        out=fn(*args);return [type(out).__name__,repr(out)]
    except Exception as exc:return exception(exc)

def gates(variants):
    records=[];events=[];converter=base64._bytes_from_decode_data
    def compare(name,ref,args,candidates):
        events.clear();a=observe(ref,args);ae=list(events)
        for variant,fn in candidates:
            events.clear();b=observe(fn,args);be=list(events)
            records.append(dict(case=name,variant=variant,reference=a,compiled=b,reference_events=ae,compiled_events=be,identical=a==b and ae==be))
    def replacement(value):
        events.append('convert');return bytearray(value)
    base64._bytes_from_decode_data=replacement
    try:
        compare('converter-a85',base64.a85decode,(b'!!!!!',),variants(ext.a85_boxed,ext.a85_borrowed))
        compare('converter-b32',base64._b32decode,(base64._b32alphabet,b'MY======'),variants(ext.b32_boxed,ext.b32_borrowed))
    finally:base64._bytes_from_decode_data=converter
    base64.b32decode(b'MY======');cache=base64._b32rev
    class Hook(dict):
        def __contains__(self,key):events.append('contains');return super().__contains__(key)
        def __getitem__(self,key):events.append('getitem');return super().__getitem__(key)
    base64._b32rev=Hook(cache)
    try:compare('cache-subclass',base64._b32decode,(base64._b32alphabet,b'MY======'),variants(ext.b32_boxed,ext.b32_borrowed))
    finally:base64._b32rev=cache
    saved=base64._b32rev;custom=dict(saved);custom[base64._b32alphabet]=Hook(saved[base64._b32alphabet]);base64._b32rev=custom
    try:compare('inner-cache-subclass',base64._b32decode,(base64._b32alphabet,b'MY======'),variants(ext.b32_boxed,ext.b32_borrowed))
    finally:base64._b32rev=saved
    import struct
    original_struct=struct.Struct
    class Packer:
        def pack(self,value):events.append('pack');return b'ABCD'
    def struct_factory(fmt):events.append('Struct');return Packer()
    struct.Struct=struct_factory
    try:compare('rebound-Struct',base64.a85decode,(b'!!!!!',),variants(ext.a85_boxed,ext.a85_borrowed))
    finally:struct.Struct=original_struct
    import types
    original_module=sys.modules['struct'];replacement_module=types.ModuleType('struct');replacement_module.Struct=struct_factory;sys.modules['struct']=replacement_module
    try:compare('rebound-import-cache',base64.a85decode,(b'!!!!!',),variants(ext.a85_boxed,ext.a85_borrowed))
    finally:sys.modules['struct']=original_module
    class ModuleHook(types.ModuleType):
        def __getattribute__(self,name):
            if name=='_bytes_from_decode_data':
                def changed(value):events.append('module-hook');return b'!!!!!'
                return changed
            return super().__getattribute__(name)
    original_decoder=base64.a85decode;base64.__class__=ModuleHook
    try:compare('module-subclass',original_decoder,(b'',),variants(ext.a85_boxed,ext.a85_borrowed))
    finally:base64.__class__=types.ModuleType
    original_code=converter.__code__
    def substitute(value):return bytearray(value)
    converter.__code__=substitute.__code__
    try:compare('converter-code',base64.a85decode,(b'!!!!!',),variants(ext.a85_boxed,ext.a85_borrowed))
    finally:converter.__code__=original_code
    kw=base64.a85decode.__kwdefaults__;old_ignore=kw['ignorechars'];kw['ignorechars']=b'~'
    try:compare('mutated-kwdefault',base64.a85decode,(b'~',),variants(ext.a85_boxed,ext.a85_borrowed))
    finally:kw['ignorechars']=old_ignore
    return records

def main():
    def variants(boxed,borrowed):return [('boxed-C',boxed),('borrowed-C',borrowed)]
    records=gates(variants)
    print(json.dumps(records,indent=2));Path(sys.argv[1]).write_text(json.dumps(records,indent=2))
    return 0 if all(r['identical'] for r in records) else 1
if __name__=='__main__':sys.exit(main())
