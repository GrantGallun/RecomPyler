"""Exact, hook-free compatibility keys for prepared heap programs.

No compiler modules are imported here. A key is a snapshot, never a path/mtime
cache: the caller owns its validation lifetime.
"""
import builtins
import hashlib
import importlib.metadata
import os
from pathlib import Path
import struct
import sys
import sysconfig
from types import CodeType, FunctionType

SCHEMA = 1


class PreparedMiss(Exception):
    pass


def canonical(value):
    import json
    return json.dumps(value, sort_keys=True, separators=(',', ':'), ensure_ascii=True,
                      allow_nan=False).encode('ascii')


def digest(value):
    return hashlib.sha256(canonical(value)).hexdigest()


def literal_key(value, _depth=0):
    if _depth > 100:
        raise PreparedMiss('literal nesting')
    t = type(value)
    if value is None: return ['none']
    if value is Ellipsis: return ['ellipsis']
    if t is bool: return ['bool', value]
    if t is int: return ['int', str(value)]
    if t is float: return ['float', struct.pack('>d', value).hex()]
    if t is complex: return ['complex', struct.pack('>dd', value.real, value.imag).hex()]
    if t is str: return ['str', value]
    if t is bytes: return ['bytes', value.hex()]
    if t in (tuple, frozenset):
        items = [literal_key(v, _depth + 1) for v in value]
        if t is frozenset: items.sort(key=canonical)
        return [t.__name__, items]
    if t is slice:
        return ['slice', [literal_key(v, _depth + 1) for v in (value.start, value.stop, value.step)]]
    if t is CodeType:
        names = ('co_code', 'co_consts', 'co_names', 'co_varnames', 'co_freevars',
                 'co_cellvars', 'co_flags', 'co_argcount', 'co_posonlyargcount',
                 'co_kwonlyargcount', 'co_exceptiontable', 'co_stacksize', 'co_nlocals',
                 'co_linetable', 'co_firstlineno', 'co_name', 'co_qualname', 'co_filename')
        return ['code', [[n, literal_key(getattr(value, n, None), _depth + 1)] for n in names]]
    raise PreparedMiss('unsupported literal')


def unliteral(row):
    tag, *p = row
    if tag == 'none': return None
    if tag == 'ellipsis': return Ellipsis
    if tag == 'bool': return p[0]
    if tag == 'int': return int(p[0])
    if tag == 'float': return struct.unpack('>d', bytes.fromhex(p[0]))[0]
    if tag == 'complex': return complex(*struct.unpack('>dd', bytes.fromhex(p[0])))
    if tag == 'str': return p[0]
    if tag == 'bytes': return bytes.fromhex(p[0])
    if tag == 'tuple': return tuple(unliteral(v) for v in p[0])
    if tag == 'frozenset': return frozenset(unliteral(v) for v in p[0])
    if tag == 'slice': return slice(*(unliteral(v) for v in p[0]))
    raise PreparedMiss('invalid literal')


def file_key(path):
    path = Path(path).resolve()
    return dict(file=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest())


def function_key(fn, refs):
    from ._runner_wrapper import original
    fn = original(fn)
    if type(fn) is not FunctionType:
        raise PreparedMiss('function binding')
    kw = fn.__kwdefaults__
    if kw is not None and (type(kw) is not dict or any(type(k) is not str for k in kw)):
        raise PreparedMiss('keyword defaults')
    cells = []
    for name, cell in zip(fn.__code__.co_freevars, fn.__closure__ or ()):
        if name == '__class__':
            if type(cell.cell_contents) is not type: raise PreparedMiss('class closure')
            cells.append([name, refs.ref(cell.cell_contents)])
        else:
            cells.append([name, ['literal', literal_key(cell.cell_contents)]])
    builtin_space=fn.__builtins__
    if type(builtin_space) is not dict or any(type(k) is not str for k in builtin_space):
        raise PreparedMiss('builtins namespace')
    return dict(builtins_names=sorted(builtin_space), source=file_key(fn.__code__.co_filename), name=fn.__name__,
                qualname=fn.__qualname__, code=literal_key(fn.__code__),
                defaults=literal_key(fn.__defaults__),
                kwdefaults=None if kw is None else [[k, literal_key(v)] for k, v in sorted(kw.items())],
                closure=cells)


def compiler_key():
    root = Path(__file__).parent
    sources = {p.relative_to(root).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
               for p in sorted(root.rglob('*')) if p.suffix in ('.py', '.c', '.h', '.cpp')}
    def version(name):
        try:
            dist=importlib.metadata.distribution(name)
            return dict(version=dist.version, metadata_sha256=hashlib.sha256((dist.read_text('METADATA') or '').encode()).hexdigest(), record_sha256=hashlib.sha256((dist.read_text('RECORD') or '').encode()).hexdigest())
        except importlib.metadata.PackageNotFoundError: return None
    return dict(schema=SCHEMA, sources=sources, target_cpu='', target_environment={k:os.environ.get(k) for k in ('NUMBA_CPU_NAME','NUMBA_CPU_FEATURES','NUMBA_OPT')}, use_nrt=True,
                cflags=[], ldflags=['-pthread'] if sys.platform.startswith('linux') else [],
                numba_build=version('numba'), llvmlite_build=version('llvmlite'))


def runtime_key():
    import numpy as np
    from . import heap
    native = heap._native
    native_path = vars(native).get('__file__') if native else None
    include = Path(sysconfig.get_path('include'))
    headers = {str(p.relative_to(include)): hashlib.sha256(p.read_bytes()).hexdigest()
               for p in sorted(include.rglob('*.h'))}
    dll = Path(sys.base_prefix) / ('python%d%d.dll' % sys.version_info[:2])
    return dict(python=sys.version, implementation=sys.implementation.name,
                cache_tag=sys.implementation.cache_tag, api_version=sys.api_version,
                soabi=sysconfig.get_config_var('SOABI'), extension=sysconfig.get_config_var('EXT_SUFFIX'),
                pointer_bits=struct.calcsize('P') * 8, byteorder=sys.byteorder,
                numpy_abi=[np.__version__, int(np._core._multiarray_umath._get_ndarray_c_version()),file_key(np._core._multiarray_umath.__file__)],
                native_sha256=file_key(native_path) if native_path else None,
                load_contracts_version=getattr(native, 'LOAD_CONTRACTS_VERSION', None),
                prepared_origin_version=getattr(native, 'PREPARED_ORIGIN_VERSION', None),
                header_abi=digest(headers), python_binary_sha256=[file_key(sys.executable), file_key(dll) if dll.exists() else None],
                free_threaded=bool(sysconfig.get_config_var('Py_GIL_DISABLED')),
                debug=bool(sysconfig.get_config_var('Py_DEBUG')))


def plan_key(snapshot):
    """Versioned projection: remove only derived region artifact routing outputs."""
    def copy(value, path=()):
        if type(value) is dict:
            result = {}
            for k, v in value.items():
                if type(k) is not str: raise PreparedMiss('plan dictionary key')
                if path == () and k in ('candidate_ranking','uncaptured_hotspots','capture_inventory'): continue
                if path == ('plan', 'aot_regions') and k in ('prepared', 'module', 'folder'): continue
                if path == ('plan', 'aot_regions', 'functions', '*') and k == 'prepared': continue
                result[k] = copy(v, path + (k,))
            return result
        if type(value) in (list, tuple): return [copy(v, path + ('*',)) for v in value]
        if type(value) not in (str, int, float, bool, type(None)): raise PreparedMiss('nonprimitive plan')
        return value
    return dict(version=1, digest=digest(copy(snapshot)))
