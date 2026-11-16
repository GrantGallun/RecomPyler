"""Persistent, invalidatable admission and speed decisions; never raw addresses."""
import hashlib
import json
import marshal
import math
import os
from pathlib import Path
import platform
import re
import sys
import sysconfig
import tempfile


def compiler_identity():
    root = Path(__file__).resolve().parents[1]
    digest = hashlib.sha256()
    for path in sorted(root.rglob('*')):
        if path.suffix in ('.py','.c','.h'):
            digest.update(path.relative_to(root).as_posix().encode())
            digest.update(path.read_bytes())
    import llvmlite
    digest.update(repr((sys.version, sys.implementation.cache_tag, sysconfig.get_config_var('SOABI'),
                        platform.machine(), llvmlite.__version__)).encode())
    return digest.hexdigest()


def function_identity(function, compiler_tag):
    digest = hashlib.sha256()
    digest.update(compiler_tag.encode())
    digest.update(marshal.dumps(function.__code__))
    source = Path(function.__code__.co_filename)
    try: digest.update(source.read_bytes())
    except (OSError, ValueError): pass
    return digest.hexdigest()


def _positive(value):
    return type(value) is int and value>0 or type(value) is float and math.isfinite(value) and value>0


class DecisionCache:
    """A verified receipt makes a hot function eligible, never silently installed."""
    def __init__(self, directory, *, compiler_tag=None, minimum_calls=100):
        if type(minimum_calls) is not int or minimum_calls < 1:
            raise ValueError('minimum_calls must be a positive integer')
        self.directory = Path(directory)
        self._compiler_tag = compiler_tag
        self.minimum_calls = minimum_calls

    @property
    def compiler_tag(self):
        if self._compiler_tag is None:
            self._compiler_tag = compiler_identity()
        return self._compiler_tag

    def key(self, function):
        return function_identity(function, self.compiler_tag)

    def record(self, function, *, calls, cpython_ns, native_ns, verified, artifact_digest=None, artifact_manifest_digest=None):
        """Persist externally measured evidence; this method takes no timings."""
        if type(calls) is not int or calls < 0: raise ValueError('nonnegative call count required')
        if not _positive(cpython_ns) or not _positive(native_ns):
            raise ValueError('positive finite timings required')
        if type(verified) is not bool: raise ValueError('verification verdict required')
        if artifact_digest is not None and (type(artifact_digest) is not str or re.fullmatch('[0-9a-f]{64}',artifact_digest) is None):
            raise ValueError('SHA256 native artifact identity required')
        if artifact_manifest_digest is not None and (type(artifact_manifest_digest) is not str or re.fullmatch('[0-9a-f]{64}',artifact_manifest_digest) is None):
            raise ValueError('SHA256 artifact manifest identity required')
        key = self.key(function)
        row = dict(schema=1,key=key,compiler=self.compiler_tag,calls=calls,
                   cpython_ns=cpython_ns,native_ns=native_ns,verified=verified,artifact_digest=artifact_digest,artifact_manifest_digest=artifact_manifest_digest)
        self.directory.mkdir(parents=True, exist_ok=True)
        temporary = None
        try:
            with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', dir=self.directory, delete=False) as stream:
                temporary = Path(stream.name)
                json.dump(row, stream, allow_nan=False)
            os.replace(temporary, self.directory/(key+'.json'))
        finally:
            if temporary is not None: temporary.unlink(missing_ok=True)
        return row

    def receipt(self, function):
        # A cold run has no evidence to validate and needs no LLVM dependency.
        if not any(self.directory.glob('*.json')):
            return None
        key = self.key(function)
        try: row = json.loads((self.directory/(key+'.json')).read_text(encoding='utf-8'))
        except (OSError, ValueError, TypeError): return None
        if type(row) is not dict or row.get('schema') != 1 or row.get('key') != key or row.get('compiler') != self.compiler_tag:
            return None
        if type(row.get('calls')) is not int or row['calls'] < 0 or type(row.get('verified')) is not bool:
            return None
        artifact=row.get('artifact_digest')
        if artifact is not None and (type(artifact) is not str or re.fullmatch('[0-9a-f]{64}',artifact) is None): return None
        manifest=row.get('artifact_manifest_digest')
        if manifest is not None and (type(manifest) is not str or re.fullmatch('[0-9a-f]{64}',manifest) is None):return None
        if not _positive(row.get('cpython_ns')) or not _positive(row.get('native_ns')): return None
        return row

    def eligible(self, function):
        row = self.receipt(function)
        return bool(row and row['verified'] and row['calls'] >= self.minimum_calls
                    and row['native_ns'] <= row['cpython_ns'])
