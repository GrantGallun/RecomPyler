"""Verification comparison without dispatching to application comparison hooks."""
import array
import struct

class ComparisonUnsupported(ValueError):
    pass

def _is_class(value):
    return any(base is type for base in type.__dict__['__mro__'].__get__(type(value)))

def _numpy_value(value):
    """Read only exact immutable native numeric numpy types, never subclasses."""
    kind=type(value)
    if type(kind) is not type:return None
    flags=type.__dict__['__flags__'].__get__(kind)
    # Pure-Python lookalikes and NumPy subclasses are heap types. Only the
    # immutable static native types defined by NumPy own these C readers.
    if not flags & 256 or flags & 512:return None
    module=type.__dict__['__module__'].__get__(kind)
    name=type.__dict__['__name__'].__get__(kind)
    names=('ndarray','float64','int64','bool','float32','int32','int16','int8','uint8','uint16','uint32','uint64','complex64','complex128')
    if module!='numpy' or name not in names:return None
    dtype=value.dtype
    if dtype.isbuiltin != 1 or dtype.hasobject or dtype.fields is not None or dtype.metadata is not None:
        raise ComparisonUnsupported('comparison rule: non-primitive native numeric dtype')
    return dtype.str, value.shape, value.tobytes()

def _validate(value):
    from .profiler import _INERT_SCALARS, _object_fields, _plain_value
    pending=[value];seen=set()
    while pending:
        item=pending.pop();kind=type(item)
        if _is_class(item):continue
        if any(kind is cls for cls in _INERT_SCALARS) or kind is array.array:continue
        if id(item) in seen:continue
        seen.add(id(item))
        if kind is tuple or kind is list:pending.extend(item)
        elif kind is dict:
            if not all(_plain_value(key) for key in item):
                raise ComparisonUnsupported('comparison rule: non-inert dictionary key')
            pending.extend(item.values())
        elif kind is set or kind is frozenset:
            if not all(_plain_value(part) for part in item):
                raise ComparisonUnsupported('comparison rule: non-inert set element')
        elif _numpy_value(item) is not None:continue
        else:
            try:pending.extend(_object_fields(item).values())
            except ValueError as exc:raise ComparisonUnsupported('comparison rule: '+str(exc)) from None

def same(a,b):
    """Exact types, scalar bits and inert fields; unsafe shapes are unverified."""
    try:
        _validate(a);_validate(b)
        return _same(a,b,set())
    except ComparisonUnsupported:
        raise
    except ValueError as exc:
        raise ComparisonUnsupported('comparison rule: '+str(exc)) from None
    except RecursionError:
        raise ComparisonUnsupported('comparison rule: graph too deep to compare structurally') from None

def _same(a,b,seen):
    from .profiler import _object_fields
    kind=type(a)
    if kind is not type(b):return False
    if _is_class(a):return a is b
    if kind is float:return struct.pack('d',a)==struct.pack('d',b)
    if kind is complex:return struct.pack('dd',a.real,a.imag)==struct.pack('dd',b.real,b.imag)
    if kind is bool or kind is int or kind is str or kind is bytes or kind is range or kind is type(None):return a==b
    if kind is array.array:return a.typecode==b.typecode and a.tobytes()==b.tobytes()
    native_a=_numpy_value(a)
    if native_a is not None:return native_a==_numpy_value(b)
    pair=id(a),id(b)
    if pair in seen:return True
    seen.add(pair)
    if kind is tuple or kind is list:
        return len(a)==len(b) and all(_same(x,y,seen) for x,y in zip(a,b))
    if kind is dict:
        return len(a)==len(b) and all(_same(k,m,seen) and _same(v,w,seen) for (k,v),(m,w) in zip(a.items(),b.items()))
    if kind is set or kind is frozenset:
        # Iteration order is observable too; never use container equality or
        # hashing to compare elements, even for supported sets.
        return len(a)==len(b) and all(_same(x,y,seen) for x,y in zip(a,b))
    fields_a,fields_b=_object_fields(a),_object_fields(b)
    return fields_a.keys()==fields_b.keys() and all(_same(fields_a[name],fields_b[name],seen) for name in fields_a)
