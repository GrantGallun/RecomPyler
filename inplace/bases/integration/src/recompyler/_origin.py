"""Source/version identities for pure-Python deployment origins."""
import hashlib
import os
from functools import lru_cache
from types import CodeType
from pathlib import Path
import sys


@lru_cache(maxsize=256)
def _version(module):
    if not module:
        return None
    # Versions are descriptive in addition to exact file/code content. Editable
    # or vendored modules without distribution metadata still have full hashes.
    if module in sys.stdlib_module_names:
        return sys.version
    from importlib.metadata import version, PackageNotFoundError
    try:return version(module)
    except PackageNotFoundError:return None


def _code_parts(code):
    def value(item):
        if type(item) is CodeType:
            return ('code',_code_parts(item))
        if type(item) is tuple:
            return ('tuple',tuple(value(part) for part in item))
        if type(item) is slice:
            return ('slice',value(item.start),value(item.stop),value(item.step))
        if type(item) is frozenset:
            return ('frozenset',tuple(sorted((value(part) for part in item),key=repr)))
        if item is None or item is Ellipsis or type(item) in (bool,int,float,complex,str,bytes):
            return (type(item).__name__,repr(item))
        from .lift import Unsupported
        raise Unsupported("an origin contains an unsupported code constant")
    # Marshal embeds incidental string-interning/reference-sharing flags. Hash
    # executable fields deterministically, keeping live bytecode and constants.
    return (code.co_code.hex(),tuple(value(c) for c in code.co_consts),code.co_names,
            code.co_varnames,code.co_freevars,code.co_cellvars,code.co_flags,
            code.co_argcount,code.co_posonlyargcount,code.co_kwonlyargcount,
            code.co_exceptiontable.hex())


def identity(fn):
    """Content identity, including the defining file, runtime and live code.

    Distribution labels are diagnostic; the full file and code hashes remain
    authoritative for editable, vendored and stdlib modules alike.
    """
    path=Path(fn.__code__.co_filename)
    try: source=hashlib.sha256(path.read_bytes()).hexdigest()
    except OSError: source=None
    module=fn.__module__ if type(fn.__module__) is str else None
    return dict(file=os.path.normcase(str(path.resolve())),sha256=source,module=module,
                code_sha256=hashlib.sha256(repr(_code_parts(fn.__code__)).encode()).hexdigest(),
                python=sys.version,library_version=_version((module or '').split('.')[0]))


def key(row,script=None):
    file=row.get('file')
    if file and (script is None or Path(file).resolve()!=Path(script).resolve()):
        return (os.path.normcase(str(Path(file).resolve())),row['function'],row['line'])
    return (row['function'],row['line'])


def cache_identity(fn):
    value=identity(fn)
    # __module__ is mutable descriptive metadata, not executable semantics.
    value.pop('module')
    return value
