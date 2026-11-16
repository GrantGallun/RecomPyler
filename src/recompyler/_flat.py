"""Private flat-first JIT experiment; no default Region route or cache export.

Only one custom aggregate is unboxed. Checked Lifted lowering remains the body;
opaque list values cannot use ndarray layout, casts, slices or raw array reads.
"""
import ast
from array import array
import functools
import math
import operator
from . import lift
from . import _flat_native as native

lift._start_numba()
from numba import njit, types
from numba.core import cgutils
from numba.core.datamodel import models
from numba.core.imputils import iternext_impl, RefType, impl_ret_untracked
from numba.extending import (register_model, typeof_impl, unbox, NativeValue,
    make_attribute_wrapper, intrinsic, overload, lower_builtin)
from llvmlite import ir, binding

assert native.API_VERSION == 1
_ADDRESSES = native.addresses()
for _name, _address in _ADDRESSES.items():
    binding.add_symbol(_name, _address)


class FlatListType(types.IterableType):
    def __init__(self, dtype):
        self.dtype = dtype
        super().__init__("flat_checked_list(" + str(dtype) + ")")

    @property
    def key(self):
        return self.dtype

    @property
    def iterator_type(self):
        return FlatIterType(self)


class FlatBufferType(FlatListType):
    def __init__(self):
        self.dtype = types.float64
        types.IterableType.__init__(self, "flat_checked_buffer(float64)")


class FlatIterType(types.SimpleIteratorType):
    def __init__(self, owner):
        self.owner = owner
        super().__init__("flat_iterator(" + str(owner.dtype) + ")", owner.dtype)

    @property
    def key(self):
        return self.owner


class FlatObjectType(types.Type):
    def __init__(self, fields):
        self.fields = fields
        self.payload = types.Tuple(tuple(t for name,t in fields))
        super().__init__("flat_fields(" + repr(fields) + ")")

    @property
    def key(self):
        return self.fields


@register_model(FlatObjectType)
class ObjectModel(models.StructModel):
    def __init__(self, dmm, fe_type):
        super().__init__(dmm, fe_type, [('payload', fe_type.payload)])


@functools.cache
def _field_reader(field):
    @intrinsic
    def read(typingctx, obj):
        if not isinstance(obj, FlatObjectType):
            return
        for index,(name,kind) in enumerate(obj.fields):
            if name == field:
                break
        else:
            return
        def codegen(context,builder,sig,args):
            value=cgutils.create_struct_proxy(sig.args[0])(context,builder,value=args[0])
            return builder.extract_value(value.payload,index)
        return kind(obj),codegen
    return read


def field_getter(obj, field):
    if not isinstance(obj, FlatObjectType) or field not in dict(obj.fields):
        return
    read=_field_reader(field)
    def impl(st,obj):
        return read(obj)
    return impl


class CallType(types.Type):
    def __init__(self, schema, arguments):
        self.schema, self.arguments = schema, arguments
        self.payload = types.Tuple((types.Array(types.uint8, 1, 'C'), *arguments))
        super().__init__("flat_call(" + schema.decode() + ")")

    @property
    def key(self):
        return self.schema


@register_model(FlatBufferType)
@register_model(FlatListType)
class ListModel(models.StructModel):
    def __init__(self, dmm, fe_type):
        super().__init__(dmm, fe_type, [('ctx', types.voidptr), ('size', types.intp)])


@register_model(FlatIterType)
class IterModel(models.StructModel):
    def __init__(self, dmm, fe_type):
        super().__init__(dmm, fe_type, [('ctx', types.voidptr), ('size', types.intp),
            ('index', types.EphemeralPointer(types.intp))])


@register_model(CallType)
class CallModel(models.StructModel):
    def __init__(self, dmm, fe_type):
        super().__init__(dmm, fe_type, [('ctx', types.voidptr), ('payload', fe_type.payload)])

make_attribute_wrapper(CallType, 'payload', 'payload')


def _external(builder, name, result, arguments, values):
    fn = cgutils.get_or_insert_function(builder.module, ir.FunctionType(result, arguments), name)
    return builder.call(fn, values)


_PTR = ir.IntType(8).as_pointer()
_I64 = ir.IntType(64)


@functools.cache
def _call_type(schema):
    position = 0
    def part():
        nonlocal position
        letter = chr(schema[position]); position += 1
        if letter == '(':
            members = []
            while chr(schema[position]) != ')':
                members.append(part())
            position += 1
            return types.Tuple(tuple(members))
        if letter == '{':
            fields = []
            while chr(schema[position]) != '}':
                end = schema.index(b':',position)
                name = schema[position:end].decode('ascii');position=end+1
                fields.append((name,part()))
                assert schema[position] == ord(';');position+=1
            position+=1
            return FlatObjectType(tuple(fields))
        return {'i': types.int64, 'f': types.float64, 'b': types.boolean,
                'n': types.none, 'I': FlatListType(types.int64),
                'F': FlatListType(types.float64), 'B': FlatBufferType(), 'D': types.Array(types.float64, 1, 'C')}[letter]
    arguments = part().types
    assert position == len(schema)
    return CallType(schema, arguments)


@typeof_impl.register(native.Call)
def typeof_call(value, context):
    return _call_type(value.schema)


@unbox(CallType)
def unbox_call(typ, obj, c):
    from numba.np.arrayobj import populate_array
    builder, context = c.builder, c.context
    ctx = _external(builder, 'rc_flat_open', _PTR, [_PTR], [obj])
    model = cgutils.create_struct_proxy(typ)(context, builder)
    model.ctx = ctx
    model.payload = cgutils.get_null_value(context.get_value_type(typ.payload))
    failed = cgutils.is_null(builder, ctx)
    with builder.if_then(builder.not_(failed)):
        extent = _external(builder, 'rc_flat_size', _I64, [_PTR], [ctx])
        slot = 0
        def decode(kind):
            nonlocal slot
            if isinstance(kind, types.BaseTuple):
                return context.make_tuple(builder, kind, [decode(t) for t in kind.types])
            if isinstance(kind, FlatObjectType):
                value = cgutils.create_struct_proxy(kind)(context,builder)
                value.payload = context.make_tuple(builder,kind.payload,[decode(t) for name,t in kind.fields])
                return value._getvalue()
            at = _I64(slot); slot += 1
            if kind == types.none:
                return context.get_dummy_value()
            if kind in (types.int64, types.boolean):
                value = _external(builder, 'rc_flat_i', _I64, [_PTR, _I64], [ctx, at])
                return builder.icmp_unsigned('!=', value, _I64(0)) if kind == types.boolean else value
            if kind == types.float64:
                return _external(builder, 'rc_flat_f', ir.DoubleType(), [_PTR, _I64], [ctx, at])
            if isinstance(kind, FlatListType):
                value = cgutils.create_struct_proxy(kind)(context, builder)
                value.ctx, value.size = ctx, extent
                return value._getvalue()
            assert isinstance(kind, types.Array) and kind.dtype == types.float64
            value = context.make_array(kind)(context, builder)
            data = _external(builder, 'rc_flat_data', _PTR, [_PTR], [ctx])
            populate_array(value, builder.bitcast(data, ir.DoubleType().as_pointer()),
                           (extent,), (_I64(8),), 8, meminfo=None, parent=None)
            return value._getvalue()
        flag_type = typ.payload.types[0]
        flag = context.make_array(flag_type)(context, builder)
        pointer = _external(builder, 'rc_flat_flag', _PTR, [_PTR], [ctx])
        populate_array(flag, pointer, (_I64(1),), (_I64(1),), 1, meminfo=None, parent=None)
        model.payload = context.make_tuple(builder, typ.payload,
                            [flag._getvalue(), *[decode(t) for t in typ.arguments]])
    def cleanup():
        _external(builder, 'rc_flat_close', ir.VoidType(), [_PTR], [ctx])
    return NativeValue(model._getvalue(), is_error=failed, cleanup=cleanup)


@intrinsic
def _read(typingctx, value, index):
    if not isinstance(value, FlatListType) or not isinstance(index, types.Integer):
        return
    signature = value.dtype(value, index)
    def codegen(context, builder, sig, args):
        item = cgutils.create_struct_proxy(sig.args[0])(context, builder, value=args[0])
        at = context.cast(builder, args[1], sig.args[1], types.int64)
        name = 'rc_flat_read_f' if sig.return_type == types.float64 else 'rc_flat_read_i'
        return _external(builder, name, context.get_value_type(sig.return_type), [_PTR, _I64], [item.ctx, at])
    return signature, codegen


@overload(operator.getitem)
def list_getitem(value, index):
    if isinstance(value, FlatListType) and isinstance(index, types.Integer):
        # Checked Lifted index normalization precedes this, but the C reader
        # independently checks every bound and exact leaf kind/range.
        def impl(value, index):
            return _read(value, index)
        return impl


@intrinsic
def _write_buffer(typingctx, value, index, item):
    if not isinstance(value, FlatBufferType) or not isinstance(index, types.Integer) or item != types.float64:
        return
    def codegen(context,builder,sig,args):
        owner=cgutils.create_struct_proxy(sig.args[0])(context,builder,value=args[0])
        at=context.cast(builder,args[1],sig.args[1],types.int64)
        _external(builder,'rc_flat_write_f',ir.VoidType(),[_PTR,_I64,ir.DoubleType()],[owner.ctx,at,args[2]])
        return context.get_dummy_value()
    return types.none(value,index,item),codegen


@overload(operator.setitem)
def buffer_setitem(value,index,item):
    if isinstance(value,FlatBufferType) and isinstance(index,types.Integer) and item == types.float64:
        def impl(value,index,item):
            _write_buffer(value,index,item)
        return impl


@overload(len)
def list_len(value):
    if isinstance(value, FlatListType):
        def impl(value):
            return _length(value)
        return impl


@intrinsic
def _length(typingctx, value):
    if not isinstance(value, FlatListType):
        return
    def codegen(context, builder, sig, args):
        return cgutils.create_struct_proxy(sig.args[0])(context, builder, value=args[0]).size
    return types.intp(value), codegen


@lower_builtin('getiter', FlatListType)
def list_getiter(context, builder, sig, args):
    item = cgutils.create_struct_proxy(sig.args[0])(context, builder, value=args[0])
    result = cgutils.create_struct_proxy(sig.return_type)(context, builder)
    result.ctx, result.size = item.ctx, item.size
    result.index = cgutils.alloca_once_value(builder, _I64(0))
    return impl_ret_untracked(context, builder, sig.return_type, result._getvalue())


@lower_builtin('iternext', FlatIterType)
@iternext_impl(RefType.BORROWED)
def list_iternext(context, builder, sig, args, result):
    iterator = cgutils.create_struct_proxy(sig.args[0])(context, builder, value=args[0])
    index = builder.load(iterator.index)
    valid = builder.icmp_signed('<', index, iterator.size)
    result.set_valid(valid)
    with builder.if_then(valid):
        dtype = sig.args[0].yield_type
        name = 'rc_flat_read_f' if dtype == types.float64 else 'rc_flat_read_i'
        value = _external(builder, name, context.get_value_type(dtype), [_PTR, _I64], [iterator.ctx, index])
        result.yield_(value)
        builder.store(builder.add(index, _I64(1)), iterator.index)


def _mark(name):
    @intrinsic
    def mark(typingctx, value):
        if not isinstance(value, CallType):
            return
        def codegen(context, builder, sig, args):
            ctx = cgutils.create_struct_proxy(sig.args[0])(context, builder, value=args[0]).ctx
            _external(builder, name, ir.VoidType(), [_PTR], [ctx])
            return context.get_dummy_value()
        return types.none(value), codegen
    return mark

_enter = _mark('rc_flat_enter')
_commit = _mark('rc_flat_commit')


def _checked_native_call(cres):
    """Keep backend errors raw until undo/release, then replay original Python.

    No exception object is constructed in the audited interval. Dynamic native
    exception allocation is rejected by no-NRT and reachable-graph inspection.
    """
    @intrinsic
    def call(typingctx, value):
        if not isinstance(value, CallType):
            return
        def codegen(context, builder, signature, args):
            holder = cgutils.create_struct_proxy(signature.args[0])(context, builder, value=args[0])
            values = cgutils.unpack_tuple(builder, holder.payload)
            context.add_linking_libs((cres.library,))
            status, result = context.call_internal_no_propagate(builder, cres.fndesc, cres.signature, values)
            with builder.if_then(status.is_error):
                _external(builder, 'rc_flat_fail', ir.VoidType(), [_PTR], [holder.ctx])
            return context.get_dummy_value() if cres.signature.return_type == types.none else result
        return cres.signature.return_type(value), codegen
    return call


_ALLOWED_INTRINSICS = {'llvm.fabs.f64', 'llvm.sqrt.f64', 'llvm.floor.f64',
    'llvm.ceil.f64', 'llvm.trunc.f64', 'llvm.rint.f64', 'llvm.copysign.f64',
    'llvm.sadd.with.overflow.i64', 'llvm.ssub.with.overflow.i64',
    'llvm.smul.with.overflow.i64', 'llvm.uadd.with.overflow.i64',
    'llvm.umul.with.overflow.i64', 'llvm.smax.i64', 'llvm.smin.i64',
    'llvm.sin.f64', 'llvm.cos.f64', 'llvm.cttz.i64',
    'llvm.ctlz.i64', 'llvm.ctpop.i64'}
_BODY_HELPERS = {'rc_flat_enter', 'rc_flat_commit', 'rc_flat_read_i', 'rc_flat_read_f', 'rc_flat_write_f', 'rc_flat_fail'}


def _audit(cres):
    module = binding.parse_assembly(cres.library.get_llvm_str())
    functions = {fn.name: fn for fn in module.functions}
    pending, seen = [cres.fndesc.llvm_func_name], set()
    while pending:
        name = pending.pop()
        if name in seen:
            continue
        seen.add(name)
        fn = functions.get(name)
        if fn is None or fn.is_declaration:
            if name in _BODY_HELPERS | _ALLOWED_INTRINSICS:
                continue
            raise lift.Unsupported('flat unproved native helper: ' + name)
        for block in fn.blocks:
            for instruction in block.instructions:
                if instruction.opcode not in ('call', 'invoke', 'callbr'):
                    continue
                if instruction.opcode != 'call':
                    raise lift.Unsupported('flat unproved native control flow')
                called = tuple(instruction.operands)[-1].name
                if not called:
                    raise lift.Unsupported('flat unproved indirect native call')
                pending.append(called)
    return sorted(seen)


def _shape(args, fields=()):
    schema = native.member_shape(args, fields) if fields else native.shape(args)
    if schema is None:
        raise lift.Unsupported('flat exact single-owner argument shape declined')
    return schema


class FlatLifted:
    def __init__(self, fn):
        self.original = fn
        self.base = lift.Lifted(fn)
        self.compiled_calls = self.fallback_calls = self.flat_calls = 0
        self.last_audit = {}
        self.problem = None
        self._variants = {}
        self._fields = tuple(sorted(name for family,name in self.base._unit.names if family == "getattr"))

    def _compile(self, schema, args):
        base = self.base
        # Promotion/ownership/traversal checks run on independent copies only.
        def clone(value):
            if type(value) is tuple:
                return tuple(clone(v) for v in value)
            if type(value) is list:
                if not value or not all(type(v) is type(value[0]) and
                        (type(v) is float or type(v) is int and lift.INT_MIN <= v <= lift.INT_MAX)
                        for v in value):
                    raise lift.Unsupported('flat cold list needs exact homogeneous numeric leaves')
                return value.copy()
            if type(value) is array:
                return array('d', value)
            return value
        if b'{' not in schema:
            copies = clone(args)
            packed, shape, boundary = base._pack_call(copies)
            if shape is None or not base._prepare(shape, packed):
                raise lift.Unsupported(base.problem or 'flat baseline signature declined')
        # Field-only signatures contain no application classes in compiler metadata.
        # Compile their opaque payload directly; the checked type audit below is
        # authoritative, and no preparation executes on caller-owned instances.
        if base._records.infos or base._unit.native_sets:
            raise lift.Unsupported('flat records/sets not admitted')
        loaded = base._load(lambda fn: njit(fn, inline='always', _nrt=False), cache=False, build=False)
        call_type = _call_type(schema)
        actual = loaded[base._root]
        actual.compile(tuple(call_type.payload.types))
        body = actual.overloads[tuple(call_type.payload.types)]
        if body.signature.return_type not in (types.int64, types.float64, types.boolean, types.none):
            raise lift.Unsupported('flat scalar result only')
        verdict = base._unstable(body)
        if verdict:
            raise lift.Unsupported('flat checked body signature declined: ' + repr(verdict))
        _audit(body)
        scope = dict(root=_checked_native_call(body), _enter=_enter, _commit=_commit)
        arguments = ', '.join('payload[' + str(i) + ']' for i in range(len(call_type.payload.types)))
        source = ('def run(call):\n    payload = call.payload\n    _enter(call)\n'
                  '    result = root(call)\n'
                  '    if payload[0][0] == 0:\n        _commit(call)\n    return result\n')
        exec(compile(source, '<recompyler-flat-wrapper>', 'exec'), scope)
        dispatcher = njit(scope['run'], _nrt=False)
        dispatcher.compile((call_type,))
        result = dispatcher.overloads[(call_type,)]
        if result.signature.return_type not in (types.int64, types.float64, types.boolean, types.none):
            raise lift.Unsupported('flat scalar result only')
        verdict = base._unstable(result)
        if verdict:
            raise lift.Unsupported('flat final checked signature declined: ' + repr(verdict))
        graph = _audit(result)
        base._unit.guards_hold()  # materialise existing metadata, not authority.
        guards = []
        for namespace, name, value, code in base._unit._fast_guards[0]:
            if type(namespace) is lift._Attribute:
                namespace = native.GuardAttribute(namespace.owner)
            elif type(namespace) is not dict:
                raise lift.Unsupported('flat unknown guard holder')
            guards.append((namespace, name, value, code))
        checks = (guards, list(base._unit._fast_guards[1]), list(base._unit._fast_guards[2]))
        return dispatcher, checks, self.original.__code__, graph

    def _invoke(self, dispatcher, holder):
        return dispatcher(holder)

    def _fallback(self, args, kwargs):
        self.fallback_calls += 1
        return self.original(*args, **kwargs)

    def __call__(self, *args, **kwargs):
        full = None if kwargs else self.base._complete(args)
        try:
            if full is None:
                raise lift.Unsupported('flat positional signature')
            schema = _shape(full, self._fields)
            variant = self._variants.get(schema)
            if variant is None:
                variant = self._variants[schema] = self._compile(schema, full)
        except (lift.Unsupported, self.base._compile_error) as exc:
            self.problem = str(exc)
            variant = None
        if variant is None:
            return self._fallback(args, kwargs)
        dispatcher, checks, code, graph = variant
        holder = native.make_call(self.original, code, checks, math.__dict__, full, schema)
        declined = False
        try:
            result = self._invoke(dispatcher, holder)
        except (native.EntryDecline, lift._Fallback):
            # The marker alone is not authority: a Python observer can raise
            # the same class before open or after a committed native return.
            audit = self.last_audit = native.audit(holder)
            if (audit['active'] or audit['commits'] or audit['open'] != 1
                    or audit['close'] != 1 or not (audit['failed'] or audit['native_entries'])):
                raise
            self.problem = 'flat authenticated native decline'
            declined = True
        if declined:
            return self._fallback(args, kwargs)
        # No replay-catching block spans result boxing, profile callbacks,
        # audit observation or accounting after a normal native return.
        audit = self.last_audit = native.audit(holder)
        if audit['active']:
            raise RuntimeError('flat native cleanup incomplete')
        if not audit['commits']:
            if audit['open'] != 1 or audit['close'] != 1 or not (audit['failed'] or audit['flag']):
                raise RuntimeError('flat unauthenticated native exit')
            self.problem = 'flat checked body declined'
            return self._fallback(args, kwargs)
        self.compiled_calls += 1
        self.flat_calls += 1
        return result
