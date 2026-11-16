"""Prepared raw-pointer structure primitives for the shared IR backend.

Not a compiler/frontend or an operation-retirement policy. Borrow operands;
loads return NEW references, stores/status operations return C int. The shared
opcode lowerer preserves original success/error retirement and handler edges.
The engine/entry must pin keepalive. No Numba/NRT or Python entry bridge.
"""
import ctypes
import dis
import sys
from dataclasses import dataclass, replace
from llvmlite import ir
from .llvm_semantics import annotate_access, assume

PTR=ir.IntType(8).as_pointer()
STATUS=ir.IntType(32)
GUARD_MISS=object()

@dataclass(frozen=True)
class _AttributePlan:
    name: str
    version: int
    offset: int


def attribute_plan(code,offset):
    """Snapshot CPython 3.14.4's INSTANCE_VALUE version and byte offset.

    This feedback selects guards, never a type proof. Other specializations
    and cold instructions retain the ordinary same-site primitive.
    Source: CPython v3.14.4 Python/bytecodes.c _LOAD_ATTR_INSTANCE_VALUE.
    """
    if sys.implementation.name!='cpython' or sys.version_info[:3]!=(3,14,4):
        return None
    for instruction in dis.get_instructions(code,adaptive=True):
        if instruction.offset!=offset:
            continue
        if instruction.opname!='LOAD_ATTR_INSTANCE_VALUE':
            return None
        cache=instruction.cache_info
        if not cache or len(cache)<3 or cache[0][1]!=1 or cache[1][1]!=2:
            return None
        raw=b''.join(item[2] for item in cache)
        if len(raw)<8 or type(instruction.argval) is not str:
            return None
        version=int.from_bytes(raw[2:6],'little')
        byte_offset=int.from_bytes(raw[6:8],'little')
        if not version or byte_offset<16 or byte_offset%8:
            return None
        return _AttributePlan(instruction.argval,version,byte_offset)
    return None

class StructureCalls:
    def __init__(self,symbols,provider):
        self.symbols=symbols
        self.provider=provider
        self.library=ctypes.PyDLL(provider.__file__)
        self.caches=[]
        self.attribute_plans=[]
        self.identity_caches=[]
        self.layout=provider.inline_layout()
        for name in ('load_attr_uncounted','store_attr_uncounted','getitem','setitem','contains','try_load_attr','identity_dict_guard','identity_dict_guard_cached'):
            symbol='rc_structure_'+name
            address=ctypes.cast(getattr(self.library,symbol),ctypes.c_void_p).value
            symbols.register_external(symbol,address,(provider,self.library))

    @property
    def keepalive(self):
        return self.provider,self.library,tuple(self.caches),tuple(self.attribute_plans),tuple(self.identity_caches)

    def call(self,builder,name,result,arguments):
        function=self.symbols.declare(builder.module,'rc_structure_'+name,result,
                                      [value.type for value in arguments])
        return builder.call(function,arguments)

    def cache(self,builder):
        capsule=self.provider.new_cache()
        self.caches.append(capsule)
        return builder.inttoptr(ir.Constant(ir.IntType(64),self.provider.address(capsule)),PTR)

    def capi(self,builder,name,result,arguments):
        function=self.symbols.declare(builder.module,name,result,[value.type for value in arguments])
        return builder.call(function,arguments)

    def field(self,builder,pointer,offset,kind,*,semantic=None):
        at=builder.gep(pointer,[ir.Constant(ir.IntType(64),offset)])
        value=builder.load(builder.bitcast(at,kind.as_pointer()))
        if semantic is not None:
            annotate_access(value,semantic,nonnull=semantic=='object.type',
                            immutable=semantic=='type.basicsize',
                            value_range=(0,2**63) if semantic=='type.basicsize' else
                                        (0,2) if semantic=='values.valid' else None)
        return value

    def load_attr(self,builder,owner,name):
        return self._attribute(builder,owner,name,borrowed=False)

    def try_load_attr(self,builder,owner,name):
        """Nullable BORROWED hit, callback-free miss; no exception or replay.

        Only a caller with a complete callback/lifetime proof may use this.
        In particular this alone does not prove a rebinding cannot free an
        object with finalizers/weakref callbacks, or permit frame elision.
        """
        return self._attribute(builder,owner,name,borrowed=True)

    def load_attr_cached(self,builder,owner,name,plan):
        return self._cached_attribute(builder,owner,name,plan,borrowed=False)

    def try_load_attr_cached(self,builder,owner,name,plan):
        """Same nullable BORROWED contract and lifetime obligations as try_load_attr."""
        return self._cached_attribute(builder,owner,name,plan,borrowed=True)

    def new_reference(self,builder,value):
        """Pinned release-GIL Win64 Py_NewRef, without an out-of-line call."""
        if not self.layout.get('inline_newref'):
            return self.capi(builder,'Py_NewRef',PTR,[value])
        count_type=ir.IntType(self.layout['newref_size']*8)
        address=builder.gep(value,[ir.Constant(ir.IntType(64),self.layout['newref_offset'])])
        address=builder.bitcast(address,count_type.as_pointer())
        count=annotate_access(builder.load(address,name='return_refcount'),'object.refcount')
        mortal=builder.icmp_unsigned('<',count,ir.Constant(count_type,self.layout['newref_immortal']))
        with builder.if_then(mortal):
            annotate_access(builder.store(builder.add(count,ir.Constant(count_type,1)),address),'object.refcount')
        return value

    def prepare_attribute_loop(self,builder,current,plan):
        """Guard one callback-free interval; the caller supplies its lifetime proof.

        No application callback or GIL handoff may occur before the interval
        ends. Every later node still checks its exact type and instance storage.
        """
        if type(plan) is not _AttributePlan:
            raise TypeError('attribute plan must come from adaptive code feedback')
        self.attribute_plans.append(plan)
        size=ir.IntType(64)
        kind=self.field(builder,current,self.layout['object_type'],PTR,semantic='object.type')
        version=self.field(builder,kind,self.layout['type_version'],STATUS,semantic='type.version')
        version.name='readonly_attr_type_version'
        ready=builder.icmp_unsigned('==',version,ir.Constant(STATUS,plan.version))
        basicsize=self.field(builder,kind,self.layout['type_basicsize'],size,semantic='type.basicsize')
        return (kind,basicsize,plan.offset),ready

    def try_load_attr_loop(self,builder,owner,context):
        """Nullable borrowed load under a dominating prepare_attribute_loop proof."""
        expected,basicsize,offset=context;function=builder.function
        owner_type=self.field(builder,owner,self.layout['object_type'],PTR,semantic='object.type')
        storage=function.append_basic_block('loop_attribute_storage')
        item=function.append_basic_block('loop_attribute_item')
        miss=function.append_basic_block('loop_attribute_miss')
        done=function.append_basic_block('loop_attribute_done')
        builder.cbranch(builder.icmp_unsigned('==',owner_type,expected),storage,miss)
        builder.position_at_end(storage)
        assume(builder,builder.icmp_unsigned('==',owner_type,expected))
        valid=self.field(builder,builder.gep(owner,[basicsize]),self.layout['values_valid'],ir.IntType(8),semantic='values.valid')
        dictionary=self.field(builder,owner,self.layout['managed_dict'],PTR,semantic='instance.dict')
        ready=builder.and_(builder.icmp_unsigned('!=',valid,ir.Constant(ir.IntType(8),0)),
                           builder.icmp_unsigned('==',dictionary,ir.Constant(PTR,None)))
        builder.cbranch(ready,item,miss);builder.position_at_end(item)
        result=self.field(builder,owner,offset,PTR,semantic='instance.value');builder.branch(done);hit_end=builder.block
        builder.position_at_end(miss);builder.branch(done);miss_end=builder.block
        builder.position_at_end(done);value=builder.phi(PTR)
        value.add_incoming(result,hit_end);value.add_incoming(ir.Constant(PTR,None),miss_end)
        return value

    def _cached_attribute(self,builder,owner,name,plan,borrowed):
        if type(plan) is not _AttributePlan:
            raise TypeError('attribute plan must come from adaptive code feedback')
        self.attribute_plans.append(plan)
        layout=self.layout;size=ir.IntType(64);byte=ir.IntType(8)
        owner_type=self.field(builder,owner,layout['object_type'],PTR,semantic='object.type')
        current=self.field(builder,owner_type,layout['type_version'],STATUS,semantic='type.version')
        expected=ir.Constant(size,id(plan.name)).inttoptr(PTR)
        eligible=builder.and_(builder.icmp_unsigned('==',current,ir.Constant(STATUS,plan.version)),
                              builder.icmp_unsigned('==',name,expected))
        function=builder.function
        storage=function.append_basic_block('structure_cached_storage')
        item=function.append_basic_block('structure_cached_item')
        hit=function.append_basic_block('structure_cached_hit')
        miss=function.append_basic_block('structure_cached_miss')
        done=function.append_basic_block('structure_cached_done')
        builder.cbranch(eligible,storage,miss)
        builder.position_at_end(storage)
        basicsize=self.field(builder,owner_type,layout['type_basicsize'],size,semantic='type.basicsize')
        valid=self.field(builder,builder.gep(owner,[basicsize]),layout['values_valid'],byte,semantic='values.valid')
        present=builder.icmp_unsigned('!=',valid,ir.Constant(byte,0))
        if borrowed:
            dictionary=self.field(builder,owner,layout['managed_dict'],PTR,semantic='instance.dict')
            present=builder.and_(present,builder.icmp_unsigned('==',dictionary,ir.Constant(PTR,None)))
        builder.cbranch(present,item,miss)
        builder.position_at_end(item)
        value=self.field(builder,owner,plan.offset,PTR,semantic='instance.value')
        builder.cbranch(builder.icmp_unsigned('!=',value,ir.Constant(PTR,None)),hit,miss)
        builder.position_at_end(hit)
        if not borrowed:self.capi(builder,'Py_IncRef',ir.VoidType(),[value])
        builder.branch(done);hit_end=builder.block
        builder.position_at_end(miss)
        # The immutable guard already missed; keep the mutable cache's retry
        # out of line instead of duplicating its entire LLVM guard graph.
        fallback=self.call(builder,'try_load_attr' if borrowed else 'load_attr_uncounted',PTR,
                           [owner,name,self.cache(builder)])
        builder.branch(done);miss_end=builder.block
        builder.position_at_end(done)
        result=builder.phi(PTR);result.add_incoming(value,hit_end);result.add_incoming(fallback,miss_end)
        return result

    def _attribute(self,builder,owner,name,borrowed):
        # Same guarded inline-values representation as LOAD_ATTR_INSTANCE_VALUE.
        # Cache misses update through the shared helper at this operation, never
        # replaying the function. A nonnegative index certifies inline storage.
        layout=self.layout;size=ir.IntType(64);byte=ir.IntType(8)
        cache=self.cache(builder)
        owner_type=self.field(builder,owner,layout['object_type'],PTR,semantic='object.type')
        version=self.field(builder,cache,layout['cache_version'],STATUS,semantic='cache.version')
        current=self.field(builder,owner_type,layout['type_version'],STATUS,semantic='type.version')
        index=self.field(builder,cache,layout['cache_index'],size,semantic='cache.index')
        cached_name=self.field(builder,cache,layout['cache_name'],PTR,semantic='cache.name')
        eligible=builder.and_(builder.icmp_unsigned('!=',version,ir.Constant(STATUS,0)),builder.icmp_unsigned('==',version,current))
        eligible=builder.and_(eligible,builder.icmp_unsigned('==',cached_name,name))
        eligible=builder.and_(eligible,builder.icmp_signed('>=',index,ir.Constant(size,0)))
        function=builder.function
        storage=function.append_basic_block('structure_attr_storage')
        item=function.append_basic_block('structure_attr_item')
        hit=function.append_basic_block('structure_attr_hit')
        miss=function.append_basic_block('structure_attr_miss')
        done=function.append_basic_block('structure_attr_done')
        builder.cbranch(eligible,storage,miss)
        builder.position_at_end(storage)
        basicsize=self.field(builder,owner_type,layout['type_basicsize'],size,semantic='type.basicsize')
        values=builder.gep(owner,[basicsize])
        valid=self.field(builder,values,layout['values_valid'],byte,semantic='values.valid')
        capacity=builder.zext(self.field(builder,values,layout['values_capacity'],byte,semantic='values.capacity'),size)
        present=builder.and_(builder.icmp_unsigned('!=',valid,ir.Constant(byte,0)),builder.icmp_unsigned('<',index,capacity))
        if borrowed:
            dictionary=self.field(builder,owner,layout['managed_dict'],PTR,semantic='instance.dict')
            present=builder.and_(present,builder.icmp_unsigned('==',dictionary,ir.Constant(PTR,None)))
        builder.cbranch(present,item,miss)
        builder.position_at_end(item)
        items=builder.bitcast(builder.gep(values,[ir.Constant(size,layout['values_items'])]),PTR.as_pointer())
        value=annotate_access(builder.load(builder.gep(items,[index])),'instance.value')
        builder.cbranch(builder.icmp_unsigned('!=',value,ir.Constant(PTR,None)),hit,miss)
        builder.position_at_end(hit)
        if not borrowed:self.capi(builder,'Py_IncRef',ir.VoidType(),[value])
        builder.branch(done);hit_end=builder.block
        builder.position_at_end(miss)
        generic=self.call(builder,'try_load_attr' if borrowed else 'load_attr_uncounted',PTR,[owner,name,cache])
        builder.branch(done);miss_end=builder.block
        builder.position_at_end(done)
        result=builder.phi(PTR);result.add_incoming(value,hit_end);result.add_incoming(generic,miss_end)
        return result

    def store_attr(self,builder,owner,name,value):
        return self.call(builder,'store_attr_uncounted',STATUS,[owner,name,value,self.cache(builder)])

    def getitem(self,builder,owner,key):
        # The exact dictionary path calls the interpreter lookup once. Missing
        # keys must not retry hashing through a generic helper.
        dictionary=self.symbols.declare_global(builder.module,'PyDict_Type',ir.IntType(8))
        owner_type=self.field(builder,owner,self.layout['object_type'],PTR,semantic='object.type')
        function=builder.function
        lookup=function.append_basic_block('structure_dict_lookup')
        missing=function.append_basic_block('structure_dict_missing')
        error=function.append_basic_block('structure_dict_error')
        generic_block=function.append_basic_block('structure_item_generic')
        done=function.append_basic_block('structure_item_done')
        with builder.goto_entry_block():
            slot=builder.alloca(PTR,name='structure_dict_result')
        builder.cbranch(builder.icmp_unsigned('==',owner_type,dictionary),lookup,generic_block)
        builder.position_at_end(lookup)
        status=self.capi(builder,'PyDict_GetItemRef',STATUS,[owner,key,slot])
        result=builder.load(slot)
        builder.cbranch(builder.icmp_signed('==',status,ir.Constant(STATUS,0)),missing,done)
        lookup_end=builder.block
        builder.position_at_end(missing)
        signature=ir.FunctionType(PTR,[ir.IntType(64)],var_arg=True)
        self.symbols.install(['PyTuple_Pack'])
        pack=builder.module.globals.get('PyTuple_Pack')
        if pack is None:pack=ir.Function(builder.module,signature,name='PyTuple_Pack')
        elif pack.function_type!=signature:raise TypeError('conflicting PyTuple_Pack prototype')
        arguments=builder.call(pack,[ir.Constant(ir.IntType(64),1),key])
        builder.cbranch(builder.icmp_unsigned('==',arguments,ir.Constant(PTR,None)),error,function.append_basic_block('structure_dict_keyerror'))
        builder.position_at_end(function.blocks[-1])
        exception=self.symbols.declare_global(builder.module,'PyExc_KeyError',PTR)
        self.capi(builder,'PyErr_SetObject',ir.VoidType(),[builder.load(exception),arguments])
        self.capi(builder,'Py_DecRef',ir.VoidType(),[arguments])
        builder.branch(error)
        builder.position_at_end(error);builder.branch(done);error_end=builder.block
        builder.position_at_end(generic_block)
        generic=self.call(builder,'getitem',PTR,[owner,key]);builder.branch(done);generic_end=builder.block
        builder.position_at_end(done)
        merged=builder.phi(PTR)
        merged.add_incoming(result,lookup_end)
        merged.add_incoming(ir.Constant(PTR,None),error_end)
        merged.add_incoming(generic,generic_end)
        return merged

    def setitem(self,builder,owner,key,value):
        return self.call(builder,'setitem',STATUS,[owner,key,value])

    def contains(self,builder,owner,key):
        # Exact-type specialization with protocol fallback, including the
        # mutable-set-key -> frozenset conversion implemented by CPython.
        layout=self.layout
        owner_type=self.field(builder,owner,layout['object_type'],PTR,semantic='object.type')
        dictionary=self.symbols.declare_global(builder.module,'PyDict_Type',ir.IntType(8))
        set_type=self.symbols.declare_global(builder.module,'PySet_Type',ir.IntType(8))
        frozen=self.symbols.declare_global(builder.module,'PyFrozenSet_Type',ir.IntType(8))
        function=builder.function
        dict_block=function.append_basic_block('structure_contains_dict')
        check_set=function.append_basic_block('structure_contains_check_set')
        set_block=function.append_basic_block('structure_contains_set')
        hashable_key=function.append_basic_block('structure_contains_key')
        generic_block=function.append_basic_block('structure_contains_generic')
        done=function.append_basic_block('structure_contains_done')
        builder.cbranch(builder.icmp_unsigned('==',owner_type,dictionary),dict_block,check_set)
        results=[]
        builder.position_at_end(dict_block)
        value=self.capi(builder,'PyDict_Contains',STATUS,[owner,key]);results.append((value,builder.block));builder.branch(done)
        builder.position_at_end(check_set)
        is_set=builder.or_(builder.icmp_unsigned('==',owner_type,set_type),builder.icmp_unsigned('==',owner_type,frozen))
        builder.cbranch(is_set,set_block,generic_block)
        builder.position_at_end(set_block)
        key_type=self.field(builder,key,layout['object_type'],PTR,semantic='object.type')
        mutable_set=self.capi(builder,'PyType_IsSubtype',STATUS,[key_type,set_type])
        builder.cbranch(builder.icmp_signed('==',mutable_set,ir.Constant(STATUS,0)),hashable_key,generic_block)
        builder.position_at_end(hashable_key)
        value=self.capi(builder,'PySet_Contains',STATUS,[owner,key]);results.append((value,builder.block));builder.branch(done)
        builder.position_at_end(generic_block)
        value=self.capi(builder,'PySequence_Contains',STATUS,[owner,key]);results.append((value,builder.block));builder.branch(done)
        builder.position_at_end(done)
        result=builder.phi(STATUS)
        for value,block in results:result.add_incoming(value,block)
        return result

    def identity_key_guard(self,builder,key):
        """Class keys with the immutable ordinary type hash/equality slots."""
        kind=self.field(builder,key,self.layout['object_type'],PTR,semantic='object.type')
        plain_type=self.symbols.declare_global(builder.module,'PyType_Type',ir.IntType(8))
        return builder.zext(builder.icmp_unsigned('==',kind,plain_type),STATUS)

    def identity_dict_getitem(self,builder,owner,key):
        """Nullable borrowed lookup after BOTH identity domain/key proofs.

        The interval must remain callback-free. Pinned GIL64 CPython3.14.4
        PyType_Type inherits PyObject_GenericHash from object; its exact
        Py_HashPointer algorithm rotates uintptr_t right four bits and maps
        -1 to -2 (Python/pyhash.c, Include/internal/pycore_pyhash.h).
        The known-hash dict API keeps the ordinary collision/miss semantics.
        """
        word=ir.IntType(64);bits=builder.ptrtoint(key,word)
        hashed=builder.or_(builder.lshr(bits,ir.Constant(word,4)),
                           builder.shl(bits,ir.Constant(word,60)))
        hashed=builder.select(builder.icmp_signed('==',hashed,ir.Constant(word,-1)),
                              ir.Constant(word,-2),hashed)
        return self.capi(builder,'_PyDict_GetItem_KnownHash',PTR,[owner,key,hashed])

    def identity_dict_guard(self,builder,owner):
        """Prove resident keys callback-free once per mutation-free interval.

        The caller must combine this with identity_key_guard on EACH lookup
        key and end the proof interval before any Python callback or mutation.
        This makes contains+getitem CSE exact even for colliding dictionary keys.
        Positive key-domain proofs use CPython's unique key-state version;
        the metadata cache never retains runtime application objects.
        """
        capsule=self.provider.new_identity_cache();self.identity_caches.append(capsule)
        address=ir.Constant(ir.IntType(64),self.provider.identity_cache_address(capsule)).inttoptr(PTR)
        return self.call(builder,'identity_dict_guard_cached',STATUS,[owner,address])

    def build_map(self,builder,*values):
        # Exactly BUILD_MAP's original presized construction; this borrows
        # operands. The opcode lowerer retires stackrefs after this call.
        if len(values)%2:
            raise ValueError('BUILD_MAP requires key/value pairs')
        size=ir.IntType(64)
        # A source BUILD_MAP may execute repeatedly in a native loop. Its
        # fixed scratch buffer must not grow the machine stack per iteration.
        with builder.goto_entry_block():
            array=builder.alloca(ir.ArrayType(PTR,max(2,len(values))))
        zero=ir.Constant(size,0)
        for index,value in enumerate(values):
            builder.store(value,builder.gep(array,[zero,ir.Constant(size,index)]))
        keys=builder.gep(array,[zero,zero])
        items=builder.gep(array,[zero,ir.Constant(size,1)])
        function=self.symbols.declare(builder.module,'_PyDict_FromItems',PTR,
                                     [PTR.as_pointer(),size,PTR.as_pointer(),size,size])
        stride=ir.Constant(size,2)
        return builder.call(function,[keys,stride,items,stride,ir.Constant(size,len(values)//2)])


def select_structure_calls(graph,available):
    """Select local-dispatch helpers without changing opcode/retirement edges.

    Each helper checks dynamic types/layout and performs the generic operation
    at the same site on a miss. This adds no type proof and no replay/deopt.
    The shared lowerer must still own every opcode's distinct error policy.
    """
    from dataclasses import replace
    available=frozenset(available)
    blocks={};changed=False
    for key,block in graph.blocks.items():
        operations=[]
        for op in block.operations:
            selected=None
            if 'lowering' not in op.attributes:
                if op.name=='load_attr' and not op.attributes.get('method') and len(op.arguments)==1 and len(op.results)==1:
                    selected='load_attr'
                elif op.name=='store_attr':selected='store_attr'
                elif op.name=='subscr' or op.name=='binary' and op.attributes.get('oparg')==26:
                    # CPython3.14.4 NB_SUBSCR. Keep its BINARY_OP error envelope.
                    selected='getitem'
                elif op.name=='store_subscr':selected='setitem'
                elif op.name=='contains':selected='contains'
            if selected in available:
                op=replace(op,attributes={**op.attributes,'lowering':'structure.'+selected})
                changed=True
            operations.append(op)
        blocks[key]=replace(block,operations=operations,edges=list(block.edges))
    return replace(graph,blocks=blocks) if changed else graph


def specialize_structure_calls(graph,profile_types=None,*,immediate_offsets=False):
    """Use adaptive instruction feedback; observations select guards, not proofs.

    Immutable offsets are opt-in preparation for the shared borrowed loop lane;
    their current whole-helper measurements do not establish a speed win.
    Guards and generic fallback are inside each primitive, preserving the
    original opcode's PC, exception edges and operand retirement contract.
    """
    warmed={i.offset:i.opname for i in dis.get_instructions(graph.code,adaptive=True)}
    profiles=profile_types or {}
    families={
        'LOAD_ATTR_INSTANCE_VALUE':'load_attr', 'LOAD_ATTR_WITH_HINT':'load_attr',
        'LOAD_ATTR_SLOT':'load_attr', 'LOAD_ATTR_PROPERTY':'load_attr',
        'STORE_ATTR_INSTANCE_VALUE':'store_attr','STORE_ATTR_WITH_HINT':'store_attr',
        'STORE_ATTR_SLOT':'store_attr',
        'CONTAINS_OP_DICT':'contains','CONTAINS_OP_SET':'contains',
        'BINARY_OP_SUBSCR_DICT':'getitem','BINARY_OP_SUBSCR_LIST_INT':'getitem',
        'BINARY_OP_SUBSCR_TUPLE_INT':'getitem',
        'STORE_SUBSCR_DICT':'setitem','STORE_SUBSCR_LIST_INT':'setitem',
    }
    # Structural shape filtering stays with the existing selection pass.
    candidates=select_structure_calls(graph,{'load_attr','store_attr','getitem','setitem','contains'})
    blocks={};changed=False
    for offset,block in candidates.blocks.items():
        operations=[]
        originals=graph.blocks[offset].operations
        for old,op in zip(originals,block.operations):
            spelling=warmed.get(op.offset,'')
            helper=op.attributes.get('lowering','').removeprefix('structure.')
            observed=bool(profiles.get(op.offset))
            if 'lowering' not in old.attributes and helper and (families.get(spelling)==helper or observed):
                attributes={**op.attributes,'specialization':spelling if families.get(spelling)==helper else 'profile','fallback':'generic'}
                plan=attribute_plan(graph.code,op.offset) if immediate_offsets and helper=='load_attr' else None
                if plan is not None:attributes['attribute_plan']=plan
                op=replace(op,attributes=attributes)
                changed=True
            else:op=old
            operations.append(op)
        blocks[offset]=replace(block,operations=operations,edges=list(block.edges))
    return replace(graph,blocks=blocks) if changed else graph
