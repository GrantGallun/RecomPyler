"""Fresh optional-extension build, required new API proof, then owned install."""
from pathlib import Path
import argparse, ctypes, hashlib, json, os, shutil, subprocess, sys, sysconfig
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,v):
    with p.open('x',encoding='utf-8') as f:json.dump(v,f,indent=2)
def runtime_dll():
    address=ctypes.cast(ctypes.pythonapi.Py_GetVersion,ctypes.c_void_p).value
    kernel=ctypes.WinDLL('kernel32',use_last_error=True)
    get_module=kernel.GetModuleHandleExW
    get_module.argtypes=[ctypes.c_ulong,ctypes.c_void_p,ctypes.POINTER(ctypes.c_void_p)]
    get_module.restype=ctypes.c_int
    module=ctypes.c_void_p()
    assert get_module(6,address,ctypes.byref(module)),ctypes.get_last_error()
    get_name=kernel.GetModuleFileNameW
    get_name.argtypes=[ctypes.c_void_p,ctypes.c_wchar_p,ctypes.c_ulong]
    get_name.restype=ctypes.c_ulong
    buffer=ctypes.create_unicode_buffer(32768)
    size=get_name(module,buffer,len(buffer));assert 0<size<len(buffer)
    path=Path(buffer.value).resolve();assert path.is_file()
    return dict(path=str(path),sha256=sha(path))
def inputs():
    paths=[R/'setup.py',R/'src/recompyler/_heap.c',R/'src/recompyler/_guards.h',D/'native_guards_probe.c',D/'native_guards_probe_setup.py',Path(__file__)]
    headers=Path(sysconfig.get_path('include'))
    return dict(files={str(p):sha(p) for p in paths},headers={p.relative_to(headers).as_posix():sha(p) for p in sorted(headers.rglob('*.h'))},header_root=str(headers),python=sys.version,executable=sys.executable,runtime_dll=runtime_dll(),abiflags=getattr(sys,"abiflags",""),flags=repr(sys.flags),configuration={name:sysconfig.get_config_var(name) for name in ("Py_DEBUG","Py_GIL_DISABLED","Py_TRACE_REFS","Py_STATS","WITH_PYMALLOC","SIZEOF_VOID_P","SOABI","EXT_SUFFIX")})
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);p.add_argument('--lock-label',required=True);o=p.parse_args()
    assert 'purpose: '+o.lock_label+'\n' in (W/'TIMING.lock/owner.txt').read_text()
    output=o.output.resolve();assert output.is_relative_to(D) and not output.exists();output.mkdir()
    frozen=inputs();write(output/'freeze.json',frozen)
    try:
        command=[sys.executable,'setup.py','build_ext','--force','--build-lib',str(output/'lib'),'--build-temp',str(output/'temp')]
        build=subprocess.run(command,cwd=R);write(output/'compile.receipt.json',dict(command=command,exit_code=build.returncode));assert build.returncode==0
        probe_command=[sys.executable,str(D/'native_guards_probe_setup.py'),'build_ext','--force','--build-lib',str(output/'probe'),'--build-temp',str(output/'probe-temp')]
        probe=subprocess.run(probe_command,cwd=R);assert probe.returncode==0
        assert len(list((output/'probe').glob('_guard_probe*.pyd')))==1
        binaries=list((output/'lib/recompyler').glob('_heap*.pyd'));assert len(binaries)==1,'Fresh optional _heap build produced no unique binary'
        binary=binaries[0]
        verify="import importlib.util,json,pathlib,sys;path=pathlib.Path(sys.argv[1]).resolve();spec=importlib.util.spec_from_file_location('recompyler._heap',path);module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module);assert pathlib.Path(module.__file__).resolve()==path;assert module.GUARD_BUILD_SIGNATURE==sys.version;assert module.GUARD_CHECKS_VERSION==1;assert module.GUARD_AUDIT_CAPABILITY==1;assert callable(module.check_heap_guards) and callable(module.check_lift_guards);assert module.check_heap_guards({}) is True;assert module.check_lift_guards(([],[],[]),{}) is True;assert module.check_heap_guards({0:('future',)}) is None;print(json.dumps(dict(path=str(path),version=module.GUARD_CHECKS_VERSION,verified=True)))"
        checked=subprocess.run([sys.executable,'-c',verify,str(binary)],cwd=R,capture_output=True)
        (output/'verify.stdout').write_bytes(checked.stdout);(output/'verify.stderr').write_bytes(checked.stderr);assert checked.returncode==0,checked.stderr
        assert inputs()==frozen
        target=R/'src/recompyler'/binary.name
        previous=sha(target) if target.exists() else None
        if target.exists():shutil.copy2(target,output/('previous-'+target.name))
        shutil.copy2(binary,target)
        env=os.environ.copy();env['PYTHONPATH']=str(R/'src')
        loaded=subprocess.run([sys.executable,'-c',"from recompyler import _heap as n;import pathlib,sys;assert pathlib.Path(n.__file__).resolve()==pathlib.Path(sys.argv[1]).resolve();assert n.GUARD_BUILD_SIGNATURE==sys.version;assert n.GUARD_CHECKS_VERSION==1;assert n.GUARD_AUDIT_CAPABILITY==1;assert n.check_heap_guards({}) is True;assert n.check_lift_guards(([],[],[]),{}) is True;print(n.__file__)",str(target)],cwd=R,env=env,capture_output=True)
        (output/'installed-verify.stdout').write_bytes(loaded.stdout);(output/'installed-verify.stderr').write_bytes(loaded.stderr);assert loaded.returncode==0,loaded.stderr
        assert inputs()==frozen and sha(binary)==sha(target)
        write(output/'complete.json',dict(complete=True,lock_label=o.lock_label,binary=str(binary),binary_sha256=sha(binary),installed=str(target),previous_sha256=previous,freeze_sha256=sha(output/'freeze.json'),new_apis_verified_in_fresh_processes=True))
    except BaseException as exc:
        write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False));raise
if __name__=='__main__':main()
