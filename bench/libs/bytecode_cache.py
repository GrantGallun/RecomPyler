"""Symmetric, clone-local bytecode preparation outside measured processes.

The package is precompiled to checked-hash pycs. Fixture preparation primes the
same dependencies for stock and RecomPyler; no workload body runs here. The
prefix confines every generated pyc to this clone, including stdlib/dependencies.
"""
import compileall
import json
import os
from pathlib import Path
import py_compile
import subprocess
import sys
from .runner import ROOT


def precompile():
    prefix=Path(sys.pycache_prefix or '').resolve()
    allowed=(ROOT/'.cache').resolve()
    if not sys.pycache_prefix or not prefix.is_relative_to(allowed):
        raise ValueError('clone-local bytecode prefix required')
    if sys.dont_write_bytecode:raise ValueError('bytecode writes must be enabled')
    count=0
    for folder in ('src','bench','tools'):
        directory=ROOT/folder
        if not directory.exists():continue
        count+=sum(1 for _ in directory.rglob('*.py'))
        if not compileall.compile_dir(directory,quiet=2,workers=1,invalidation_mode=py_compile.PycInvalidationMode.CHECKED_HASH):
            raise ValueError('runtime precompile failed')
    return dict(label='pyc-fixed',inherited_disable_unset='PYTHONDONTWRITEBYTECODE' not in os.environ,
        invalidation='checked-hash',prefix=str(prefix),files=count,python=sys.version,executable=sys.executable)


def prepare(executable,*,split,names):
    from .shared_harness import environment
    command=[str(executable),'-m','bench.libs.bytecode_cache','--split',split,'--only',*names]
    result=subprocess.run(command,cwd=ROOT,env=environment('cpython_off'),capture_output=True,text=True,timeout=300,
        creationflags=0x08004000 if os.name=='nt' else 0)
    if result.returncode:raise ValueError('bytecode preparation failed: '+result.stderr[-2000:])
    report=json.loads(result.stdout.splitlines()[-1])
    if report['label']!='pyc-fixed' or not report['inherited_disable_unset']:raise ValueError('bytecode policy not applied')
    return report


def main():
    import argparse
    from .programs import manifest,SPLITS
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--split',choices=SPLITS,default='train');parser.add_argument('--only',nargs='+',required=True)
    args=parser.parse_args();report=precompile();cases=manifest(args.split);prepared={}
    # Imports are allowed to populate this same prefix on both sides. Local
    # external fixtures explicitly suppress writes to their read-only origins.
    for name in args.only:
        try:cases[name].prepare();prepared[name]='ok'
        except ModuleNotFoundError as error:prepared[name]=str(error)
    report['dependency_preparation']=prepared
    print(json.dumps(report))


if __name__=='__main__':main()
