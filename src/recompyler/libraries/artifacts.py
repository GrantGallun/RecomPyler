"""Relocatable native objects for the canonical frame and frameless ABIs.

Only recognised code-owned/immortal objects and fresh structure caches may be
relocated. Unknown addresses and process-specific attribute feedback decline.
Loading prepares a body; it never installs it or imports cached Python values.
"""
import ctypes
import hashlib
import json
import os
from pathlib import Path
import re
import tempfile
import threading

from .cache import compiler_identity, function_identity


_object_link_lock = threading.RLock()


class UnportableBody(ValueError):
    pass


def _digest(data):
    return hashlib.sha256(data).hexdigest()


def _manifest_digest(metadata):
    fields={key:value for key,value in metadata.items() if key!='manifest_digest'}
    return _digest(json.dumps(fields,sort_keys=True,separators=(',',':'),allow_nan=False).encode())


def _atomic(path, data):
    path.parent.mkdir(parents=True,exist_ok=True)
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(dir=path.parent,delete=False) as stream:
            temporary = Path(stream.name)
            stream.write(data)
        os.replace(temporary,path)
    finally:
        if temporary is not None: temporary.unlink(missing_ok=True)


def _immortals():
    # Builtin names are mutable application state, while these guards and error
    # paths name canonical CPython objects. Read the exported C storage.
    float_address=ctypes.addressof(ctypes.c_byte.in_dll(ctypes.pythonapi,'PyFloat_Type'))
    return {'None':None,'True':True,'False':False,'empty':'',
            'float_type':ctypes.cast(float_address,ctypes.py_object).value,
            'int_type':ctypes.cast(ctypes.addressof(ctypes.c_byte.in_dll(ctypes.pythonapi,'PyLong_Type')),ctypes.py_object).value,
            'SystemError':ctypes.py_object.in_dll(ctypes.pythonapi,'PyExc_SystemError').value}


def _normalise(function, owner):
    from recompyler import _structure_ops_native as structures, _source_frames_native as frames
    text = str(owner.module)
    if owner.module is None or owner.abi not in ('frame','callback-free-vectorcall'):
        raise UnportableBody('original LLVM module required; reuse the receipt for an already cached object')
    if 'structure_cached_' in text or 'inline_return' in text:
        raise UnportableBody('process-specific feedback or inline plans require explicit relocation support')
    targets = {}
    def add(value, descriptor): targets.setdefault(id(value),descriptor)
    code = function.__code__
    add(code, ['code'])
    for name,value in _immortals().items():
        add(value,['immortal',name])
    for index,value in enumerate(code.co_consts): add(value,['constant',index])
    for index,value in enumerate(code.co_names): add(value,['name',index])
    for value in range(256): add(value,['small_int',value])
    # These capsules belong to the compiler, not the application. Recreate them
    # empty; no type version, source object or cached attribute crosses processes.
    cache_index = 0
    for group in owner.providers:
        if type(group) is not tuple: continue
        for capsule in group:
            if type(capsule).__name__ != 'PyCapsule': continue
            try: address = structures.address(capsule)
            except (TypeError,ValueError): continue
            targets[address] = ['structure_cache',cache_index]
            cache_index += 1
    if owner.cold_state is not None:
        targets[ctypes.addressof(owner.cold_state)]=['cold_state']
    for plan in owner.cold_plans:targets[id(plan.capsule)]=['cold_plan',plan.offset]
    descriptors=[]; names={}
    def symbol(address):
        if address not in targets: raise UnportableBody('unrecognised embedded object address')
        if address not in names:
            names[address]='rc_library_object_'+str(len(descriptors))
            descriptors.append(targets[address])
        return '@"'+names[address]+'"'
    # Constant casts and explicit inttoptr instructions are the two forms used
    # by the shared lowerer and StructureCalls. Every literal cast must relocate.
    text=re.sub(r'inttoptr \(i64 (\d+) to i8\*\)',lambda m:symbol(int(m[1])),text)
    text=re.sub(r'inttoptr i64 (\d+) to i8\*',lambda m:'bitcast i8* '+symbol(int(m[1]))+' to i8*',text)
    if re.search(r'inttoptr (?:\(i64|i64) [-+]?\d',text):
        raise UnportableBody('unsupported literal pointer cast')
    tag=frames.layout()['tag_refcnt']
    tagged={address|tag:address for address in targets if targets[address][0] not in ('structure_cache','cold_state')}
    def tagged_value(match):
        value=int(match[1])
        if value not in tagged: return match[0]
        return 'i64 ptrtoint (i8* getelementptr (i8, i8* '+symbol(tagged[value])+', i64 '+str(tag)+') to i64)'
    text=re.sub(r'\bi64 (\d+)\b',tagged_value,text)
    for index in range(len(descriptors)):
        text+='\n@"rc_library_object_'+str(index)+'" = external global i8\n'
    return text,descriptors


def _runtime():
    from llvmlite import binding
    from recompyler import _structure_ops_native as structures, _source_frames_native as frames
    from recompyler.ir.symbols import CPythonSymbols
    from recompyler.ir.structure_lowerings import StructureCalls
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    symbols=CPythonSymbols()
    for name,address in frames.addresses().items():
        symbols.register_external('rc_ir_frame_'+name,address,frames)
    calls=StructureCalls(symbols,structures)
    from recompyler.ir import _entry_native
    entry=_entry_native._callback_free_addresses()
    for name,key in [('rc_ir_callback_free_guard','guard'),('rc_ir_saved_vectorcall','saved'),('rc_ir_callback_free_cold','cold'),('rc_ir_callback_free_owner','owner')]:
        symbols.register_external(name,entry[key],_entry_native)
    from recompyler.ir import _deopt_native
    symbols.register_external('rc_ir_deopt_reify',_deopt_native.addresses()['reify'],_deopt_native)
    return binding,symbols,calls


def _resolve(code, descriptors, calls):
    addresses=[]
    immortals=_immortals()
    caches={};resources=[];cold_state=None;cold_plans=[]
    for descriptor in descriptors:
        kind=descriptor[0]
        if kind=='code': address=id(code)
        elif kind=='immortal': address=id(immortals[descriptor[1]])
        elif kind=='constant': address=id(code.co_consts[descriptor[1]])
        elif kind=='name': address=id(code.co_names[descriptor[1]])
        elif kind=='small_int' and type(descriptor[1]) is int and 0<=descriptor[1]<256: address=id(descriptor[1])
        elif kind=='cold_state':
            if cold_state is None:
                cold_state=(ctypes.c_uint64*2)();resources.append(cold_state)
            address=ctypes.addressof(cold_state)
        elif kind=='cold_plan':
            from recompyler.ir.frameless import cold_plan
            plan=cold_plan(code,descriptor[1]);cold_plans.append(plan);resources.append(plan)
            address=id(plan.capsule)
        elif kind=='structure_cache':
            index=descriptor[1]
            if index not in caches:
                capsule=calls.provider.new_cache();calls.caches.append(capsule)
                caches[index]=calls.provider.address(capsule)
            address=caches[index]
        else: raise UnportableBody('unsupported object relocation')
        addresses.append(address)
    return addresses,tuple(resources),cold_state,tuple(cold_plans)


def _engine(text, descriptors, code, *, abi='frame'):
    """Offline export only: compile relocated IR once, capturing its object."""
    binding,symbols,calls=_runtime()
    native=binding.parse_assembly(text);native.verify()
    if native.triple!=binding.get_process_triple(): raise UnportableBody('native target mismatch')
    target=binding.Target.from_default_triple().create_target_machine(opt=3)
    from recompyler.ir.llvm_semantics import optimize_module
    optimize_module(native,target)
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),target)
    engine.add_module(native)
    addresses,resources,cold_state,cold_plans=_resolve(code,descriptors,calls)
    globals_by_name={value.name:value for value in native.global_variables}
    for index,address in enumerate(addresses):
        value=globals_by_name.get('rc_library_object_'+str(index))
        if value is not None:engine.add_global_mapping(value,address)
    for value in list(native.functions)+list(native.global_variables):
        if (value.is_declaration and not value.name.startswith('rc_library_object_')
                and not (value.is_function and value.name.startswith('llvm.'))):
            engine.add_global_mapping(value,symbols.resolve(value.name))
    captured=[]
    def notify(module, data):
        if module is native: captured.append(bytes(data))
    engine.set_object_cache(notify)
    engine.finalize_object()
    address=engine.get_function_address('body')
    engine.set_object_cache()
    if not address: raise UnportableBody('cached native body missing')
    from recompyler.ir.lower_llvm import ExecutionOwner
    cold_address=engine.get_function_address('cold_body') if cold_state is not None else 0
    if cold_state is not None and not cold_address:raise UnportableBody('cached cold body missing')
    owner=ExecutionOwner(text,native,engine,address,(symbols,calls.keepalive)+resources,abi,0,cold_address,cold_state,cold_plans)
    return owner,captured,False


def _load_object(object_bytes, descriptors, code, external_symbols, *, abi='frame'):
    """Link persisted machine code without rebuilding, parsing or optimizing IR."""
    binding,symbols,calls=_runtime()
    target=binding.Target.from_default_triple().create_target_machine(opt=0)
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),target)
    addresses,resources,cold_state,cold_plans=_resolve(code,descriptors,calls)
    resolved={name:symbols.resolve(name) for name in external_symbols}
    obj=binding.ObjectFileRef.from_data(object_bytes)
    # LLVM's symbol table is process-global. Relocation names may be reused by
    # another instance of this artifact, so publish and link as one transaction.
    with _object_link_lock:
        for name,address in resolved.items():binding.add_symbol(name,address)
        for index,address in enumerate(addresses):
            binding.add_symbol('rc_library_object_'+str(index),address)
        engine.add_object_file(obj)
        engine.finalize_object()
        address=engine.get_function_address('body')
    if not address: raise UnportableBody('cached native body missing')
    from recompyler.ir.lower_llvm import ExecutionOwner
    cold_address=engine.get_function_address('cold_body') if cold_state is not None else 0
    if cold_state is not None and not cold_address:raise UnportableBody('cached cold body missing')
    return ExecutionOwner(None,None,engine,address,(symbols,calls.keepalive,obj,object_bytes)+resources,abi,0,cold_address,cold_state,cold_plans)


class ArtifactCache:
    """Store native objects with code/compiler identity and explicit relocations."""
    def __init__(self,directory,*,compiler_tag=None):
        self.directory=Path(directory)
        self.compiler_tag=compiler_tag if compiler_tag is not None else compiler_identity()

    def key(self,function): return function_identity(function,self.compiler_tag)

    def store(self,function):
        from recompyler.ir import _entry_native
        state=_entry_native._compilation_owner(function)
        if state is None: raise ValueError('prepare the function before exporting it')
        code,owner=state
        from recompyler.ir.compiler import _frameless_candidates
        candidate=_frameless_candidates.get(function)
        if candidate is not None:
            if candidate.counted or not candidate.source_matches(function):
                raise UnportableBody('current ordinary frameless source required')
            owner=candidate.owner
        if code is not function.__code__: raise UnportableBody('function code changed')
        if owner.optimization_level!=3:raise UnportableBody('artifact export requires the available LLVM O3 pipeline')
        text,relocations=_normalise(function,owner)
        # Generate the object from the relocated IR, never from an object which
        # already contains absolute pointers. No target/application call occurs.
        relocated,buffers,_=_engine(text,relocations,code,abi=owner.abi)
        if not buffers: raise UnportableBody('LLVM did not supply native object bytes')
        object_bytes=buffers[-1]
        if function.__code__ is not code: raise UnportableBody('function changed during artifact export')
        key=self.key(function)
        if function.__code__ is not code: raise UnportableBody('function changed during artifact export')
        external_symbols=[value.name for value in list(relocated.native_module.functions)+list(relocated.native_module.global_variables)
                          if value.is_declaration and not value.name.startswith(('rc_library_object_','llvm.'))]
        metadata=dict(schema=2,key=key,compiler=self.compiler_tag,abi=owner.abi,
                      entry_offset=owner.entry_offset,relocations=relocations,external_symbols=external_symbols,
                      target_triple=relocated.native_module.triple,object_digest=_digest(object_bytes))
        metadata['provenance']=dict(backend='llvm',tier='T2',pipeline='llvm-O3',optimization_level=3,
                                    abi=owner.abi,compile_options=dict(owner.compile_options))
        metadata['manifest_digest']=_manifest_digest(metadata)
        _atomic(self.directory/(key+'.o'),object_bytes)
        _atomic(self.directory/(key+'.json'),json.dumps(metadata,allow_nan=False).encode())
        return dict(status='portable-native',key=key,abi=owner.abi,relocations=len(relocations),object_bytes=len(object_bytes),object_digest=metadata['object_digest'],manifest_digest=metadata['manifest_digest'])

    def load(self,function):
        from recompyler.ir import _entry_native
        # Existing installation belongs to its caller; loading cannot replace it.
        if _entry_native.compilation_info(function) is not None: return None
        expected=function.__code__
        key=self.key(function)
        try:
            metadata=json.loads((self.directory/(key+'.json')).read_text())
            if type(metadata) is not dict or metadata.get('manifest_digest')!=_manifest_digest(metadata): return None
            object_bytes=(self.directory/(key+'.o')).read_bytes()
            if (metadata.get('schema')!=2 or metadata.get('key')!=key or metadata.get('compiler')!=self.compiler_tag
                or metadata.get('abi') not in ('frame','callback-free-vectorcall') or metadata.get('object_digest')!=_digest(object_bytes)): return None
            provenance=metadata.get('provenance')
            if (type(provenance) is not dict or provenance.get('backend')!='llvm' or provenance.get('tier')!='T2'
                or provenance.get('pipeline')!='llvm-O3' or provenance.get('optimization_level')!=3
                or provenance.get('abi')!=metadata['abi'] or type(provenance.get('compile_options')) is not dict):return None
            from llvmlite import binding
            if metadata.get('target_triple')!=binding.get_process_triple(): return None
            if function.__code__ is not expected or self.key(function)!=key: return None
            owner=_load_object(object_bytes,metadata['relocations'],expected,metadata['external_symbols'],abi=metadata['abi'])
            hit=True
            if function.__code__ is not expected or self.key(function)!=key: return None
            if not hit: return None
            from dataclasses import replace
            owner=replace(owner,entry_offset=metadata['entry_offset'],optimization_level=3,
                          compile_options=tuple(sorted(provenance['compile_options'].items())))
            if owner.abi=='callback-free-vectorcall':
                from recompyler.ir.frameless import FramelessCandidate
                from recompyler.ir.compiler import _frameless_candidates
                prepared=_entry_native.prepare_frameless_entry(function,owner.body_address,owner,expected)
                _frameless_candidates[function]=FramelessCandidate(function,expected,owner,None)
            else:
                prepared=_entry_native.prepare_frame_entry(function,owner.body_address,owner,expected)
            return dict(status='loaded',key=key,abi=owner.abi,object_cache_hit=hit,object_digest=metadata['object_digest'],manifest_digest=metadata['manifest_digest'],
                        _code=expected,_owner=owner,_prepared=prepared)
        except (OSError,ValueError,KeyError,TypeError,IndexError,RuntimeError): return None
