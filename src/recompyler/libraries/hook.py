"""Opt-in import delivery. Cold and unverified functions remain original Python."""
import importlib.machinery
import os
from pathlib import Path
import sys
import types
import weakref
from .cache import DecisionCache

_active = None


def _function_references(module):
    # Finish callback-free discovery before cache I/O or compilation. Only weak
    # function identities survive; snapshots must not pin incidental resources.
    references=[];seen=set()
    module_name=vars(module).get('__name__')
    if type(module_name) is not str: return references
    def visit(value):
        if type(value) in (staticmethod,classmethod): value=value.__func__
        if type(value) is property:
            for function in (value.fget,value.fset,value.fdel):
                if function is not None: visit(function)
        elif (type(value) is types.FunctionType and type(value.__module__) is str
              and value.__module__==module_name and id(value) not in seen):
            seen.add(id(value));references.append(weakref.ref(value))
    for value in tuple(vars(module).values()):
        if issubclass(type(value),type):
            members=type.__dict__['__dict__'].__get__(value)
            if type(members.get('__module__')) is str and members['__module__']==module_name:
                for member in tuple(members.values()): visit(member)
        else: visit(value)
    return references


def _functions(module):
    for reference in _function_references(module):
        function=reference()
        if function is not None: yield function


class _Loader:
    def __init__(self, original, session): self.original,self.session = original,session
    def __getattr__(self, name): return getattr(self.original,name)
    def create_module(self, spec):
        spec.loader = self.original
        try: return self.original.create_module(spec)
        finally: spec.loader = self
    def exec_module(self, module):
        module.__loader__ = self.original
        module.__spec__.loader = self.original
        self.original.exec_module(module)
        self.session.process_module(module)


class _Finder:
    def __init__(self, session): self.session = session
    def find_spec(self, fullname, path=None, target=None):
        if not self.session.selected(fullname): return None
        spec = importlib.machinery.PathFinder.find_spec(fullname,path,target)
        if spec is not None and isinstance(spec.loader,importlib.machinery.SourceFileLoader):
            spec.loader = _Loader(spec.loader,self.session)
            return spec
        return None


class LibrarySession:
    def __init__(self, packages, cache, profile):
        self.packages = tuple(packages)
        self.cache = cache
        self.profile = profile
        self.finder = _Finder(self)
        self.handles = []
        self.codes = {}
        self.counts = {}
        self.tool_id = None
        self.closed = False
        self.report = {'eligible':0,'prepared':0,'installed':0,'declined':[],'artifact_cache':'relocatable native objects; unsupported bodies remain Python'}

    def selected(self, name):
        return type(name) is str and not (name == 'recompyler' or name.startswith('recompyler.')) and (
            not self.packages or any(name == p or name.startswith(p+'.') for p in self.packages))

    def _enroll(self, function):
        code = function.__code__
        key = id(code)
        if key not in self.codes:
            def remove(reference):
                if self.codes.get(key) is reference:
                    self.codes.pop(key,None);self.counts.pop(key,None)
            self.codes[key] = weakref.ref(code,remove)
            self.counts[key] = 0

    def hotness(self, function):
        code = function.__code__
        reference = self.codes.get(id(code))
        return self.counts.get(id(code),0) if reference and reference() is code else 0

    def _start(self):
        if self.profile:
            monitoring = getattr(sys,'monitoring',None)
            if monitoring is None: raise RuntimeError('library hotness profiling requires sys.monitoring')
            for tool_id in range(5,-1,-1):
                try: monitoring.use_tool_id(tool_id,'recompyler-library-hotness')
                except ValueError: continue
                self.tool_id = tool_id;break
            if self.tool_id is None: raise RuntimeError('no free monitoring tool ID')
            def started(code,offset):
                key = id(code)
                reference = self.codes.get(key)
                if reference and reference() is code: self.counts[key] += 1
            monitoring.register_callback(self.tool_id,monitoring.events.PY_START,started)
            monitoring.set_events(self.tool_id,monitoring.events.PY_START)
        index = next((i for i,finder in enumerate(sys.meta_path) if finder is importlib.machinery.PathFinder),len(sys.meta_path))
        sys.meta_path.insert(index,self.finder)

    def _install_artifact(self,function,receipt):
        # Keep source-code witnesses scoped to this operation. The returned
        # native handle borrows its source identities and does not extend life.
        from .artifacts import ArtifactCache
        from recompyler.ir.entry import install_frame_entry
        artifacts=ArtifactCache(self.cache.directory/'native',compiler_tag=self.cache.compiler_tag)
        loaded=artifacts.load(function)
        if loaded is None: raise ValueError('verified native artifact unavailable')
        self.report['prepared'] += 1
        if (loaded['key']!=receipt['key'] or loaded['object_digest']!=receipt['artifact_digest']
                or loaded['manifest_digest']!=receipt.get('artifact_manifest_digest')):
            raise ValueError('measurement refers to different native artifact provenance')
        code,owner,prepared=loaded['_code'],loaded['_owner'],loaded['_prepared']
        if owner.abi=='callback-free-vectorcall':
            from recompyler.ir import _entry_native
            from recompyler.ir.compiler import _frameless_candidates
            candidate=_frameless_candidates.get(function)
            if (_entry_native._compilation_handle(function) is not prepared or candidate is None
                    or candidate.owner is not owner or not candidate.source_matches(function)):
                raise ValueError('cached frameless owner changed')
            candidate.install()
            if not candidate.active:raise ValueError('canonical cached frameless entry declined')
            return candidate
        handle=install_frame_entry(function,owner.body_address,owner,
            seed_arguments=(None,)*code.co_argcount,entry_offset=owner.entry_offset,
            expected_code=code,expected_prepared=prepared)
        if handle is not prepared or not handle.active:
            raise ValueError('canonical artifact entry declined')
        return handle

    def process_module(self, module):
        if type(module) is not types.ModuleType or self.closed: return
        module_name=vars(module).get('__name__')
        if not self.selected(module_name): return
        if (not self.profile and type(self.cache) is DecisionCache and 'receipt' not in vars(self.cache)
                and not any(self.cache.directory.glob('*.json'))): return
        for function in _functions(module):
            self._enroll(function)
            try:
                receipt=self.cache.receipt(function)
                if not (receipt and receipt['verified'] and receipt['calls']>=self.cache.minimum_calls
                        and receipt['native_ns']<=receipt['cpython_ns']): continue
                self.report['eligible'] += 1
                if not receipt.get('artifact_digest') or not receipt.get('artifact_manifest_digest'):
                    self.report['declined'].append({'function':function.__qualname__,'reason':'verified native artifact required; prepare offline'})
                    continue
                from recompyler.ir import compilation_info
                before=compilation_info(function)
                if before and before.get('installed'): continue
                if before is not None:
                    raise ValueError('existing prepared body has no cached artifact provenance')
                handle=self._install_artifact(function,receipt)
                if handle is not None and handle.active:
                    self.handles.append(handle)
                    self.report['installed'] += 1
                else:
                    self.report['declined'].append({'function':function.__qualname__,'reason':'new native body has no current measurement; portable artifact unavailable'})
            except Exception as exc:
                self.report['declined'].append({'function':function.__qualname__,'reason':type(exc).__name__+': '+str(exc)})

    def close(self):
        if self.closed: return
        self.closed = True
        if self.finder in sys.meta_path: sys.meta_path.remove(self.finder)
        if self.tool_id is not None:
            monitoring = sys.monitoring
            monitoring.set_events(self.tool_id,0)
            monitoring.register_callback(self.tool_id,monitoring.events.PY_START,None)
            monitoring.free_tool_id(self.tool_id)
        for handle in reversed(self.handles): handle.close()
        self.handles.clear()


def enable(*, packages=(), cache_dir=None, cache=None, profile=False):
    """Enable only verified hot library decisions; returns a closable session.

    Eligible receipts must name the exact verified relocatable native object.
    Missing or stale artifacts remain Python; this path never compiles a body.
    Persistent decisions never supply raw process addresses or invented timings.
    """
    global _active
    if _active is not None and not _active.closed: return _active
    if isinstance(packages,str): packages = (packages,)
    if cache is None:
        directory = cache_dir if cache_dir is not None else os.environ.get('RECOMPYLER_LIBRARY_CACHE') or Path(os.environ.get('RECOMPYLER_CACHE','.recompyler-cache'))/'libraries'
        cache = DecisionCache(directory)
    session = LibrarySession(packages,cache,profile)
    try:
        session._start()
        for name,module in tuple(sys.modules.items()):
            if type(module) is types.ModuleType and session.selected(name): session.process_module(module)
    except BaseException:
        session.close();raise
    _active = session
    return session


def disable():
    global _active
    if _active is not None: _active.close()
    _active = None

