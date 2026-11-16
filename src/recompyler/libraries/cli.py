"""Opt-in script runner and offline preparation of library native artifacts."""
import builtins
import importlib
import os
from pathlib import Path
import sys
import subprocess
import time
import types

from .cache import DecisionCache
from . import hook
from .hook import enable, disable, _functions
from .artifacts import ArtifactCache


def cache_directory(directory=None):
    if directory is not None: return Path(directory)
    configured=os.environ.get('RECOMPYLER_LIBRARY_CACHE')
    return Path(configured) if configured else Path(os.environ.get('RECOMPYLER_CACHE','.recompyler-cache'))/'libraries'


def ensure_entry_backend():
    """Start the opt-in CLI with CPython's required native-entry facility."""
    marker=os.environ.pop('RECOMPYLER_ENTRY_REEXEC',None)
    jit=getattr(sys,'_jit',None)
    if marker=='1' or jit is None or not jit.is_available() or jit.is_enabled(): return
    environment=dict(os.environ,PYTHON_JIT='1',RECOMPYLER_ENTRY_REEXEC='1')
    # Windows exec overlays do not preserve the process handle waited on by
    # callers. Wait for the one child and propagate its actual exit status.
    result=subprocess.run([sys.executable,*sys.orig_argv[1:]],env=environment)
    raise SystemExit(result.returncode)


def run_script(script, arguments=(), *, cache_dir=None, packages=(), profile=False, restore=True):
    """Run original source once; imports use the opt-in measured delivery policy."""
    script=Path(script).resolve()
    code=compile(script.read_bytes(),str(script),'exec')
    module=types.ModuleType('__main__')
    module.__dict__.update(__file__=str(script),__builtins__=builtins,
                           __package__=None,__spec__=None,__loader__=None,__cached__=None)
    previous=sys.modules.get('__main__'),sys.argv,sys.path[:]
    session=None
    previous_session=hook._active
    report=None
    try:
        sys.modules['__main__']=module
        sys.argv=[str(script),*arguments]
        sys.path.insert(0,str(script.parent))
        session=enable(packages=packages,cache_dir=cache_directory(cache_dir),profile=profile)
        exit_code=None;exit_message=None
        try: exec(code,module.__dict__)
        except SystemExit as exc:
            if exc.code is None: pass
            elif isinstance(exc.code,int): exit_code=int.__int__(exc.code)
            else: exit_code=1;exit_message=str(exc.code)
        report=dict(session.report,exit_code=exit_code,exit_message=exit_message,observed_calls=sum(session.counts.values()))
    finally:
        if session is not None and session is not previous_session:
            session.close()
            if hook._active is session: disable()
        if restore:
            sys.modules['__main__'],sys.argv=previous[0],previous[1]
            sys.path[:]=previous[2]
    return report


def compile_package(package, *, cache_dir=None, budget=120):
    """Import and prepare loaded package definitions; never invoke a target."""
    from recompyler.ir import compile_function,compilation_info
    importlib.import_module(package)
    decisions=DecisionCache(cache_directory(cache_dir))
    artifacts=ArtifactCache(decisions.directory/'native',compiler_tag=decisions.compiler_tag)
    targets=[];seen=set();source_files=set()
    for name,module in tuple(sys.modules.items()):
        if type(module) is types.ModuleType and (name==package or name.startswith(package+'.')):
            filename=vars(module).get('__file__')
            if type(filename) is str: source_files.add(str(Path(filename).resolve()))
            for function in _functions(module):
                if id(function) not in seen:
                    seen.add(id(function));targets.append(function)
                    source_files.add(str(Path(function.__code__.co_filename).resolve()))
    report=dict(package=package,scope='loaded modules after package import',total=len(targets),
                prepared=0,portable=0,installed=0,not_attempted=0,declined=[],source_files=sorted(source_files))
    started=time.monotonic()
    for index,function in enumerate(targets):
        if time.monotonic()-started>budget:
            report['not_attempted']=len(targets)-index;break
        name=function.__module__+'.'+function.__qualname__
        try:
            if compilation_info(function) is None:
                loaded=artifacts.load(function)
                if loaded:
                    report['prepared']+=1;report['portable']+=1;continue
            compile_function(function,strict=True)
            report['prepared']+=1
            artifacts.store(function)
            report['portable']+=1
        except Exception as exc:
            report['declined'].append(dict(function=name,reason=type(exc).__name__+': '+str(exc)))
    report['installed']=sum(bool((compilation_info(f) or {}).get('installed')) for f in targets)
    return report
