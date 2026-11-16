"""Select affected tests, classify slow tests, and share per-clone warm caches."""
import argparse
import ast
import os
from pathlib import Path
import re
import subprocess
import sys

SLOW_NAME=re.compile(r'ahead_of_time|without_numba|disk_cache|new_process|fresh_process|subprocess|ten_minute|10_minute')
BUILD_CALLS={'compile_ahead_of_time','build_ahead_of_time','build_regions_ahead_of_time','compile_objects','link_shared','link_shared_object','build_extensions','build_aot','export_native'}


def imports(source,package=""):
    used=set()
    for node in ast.walk(ast.parse(source.removeprefix("\ufeff"))):
        if isinstance(node,ast.Import):
            used.update(alias.name for alias in node.names)
        elif isinstance(node,ast.ImportFrom):
            parent=package.split('.')
            prefix='.'.join(parent[:len(parent)-node.level+1]) if node.level else ''
            module='.'.join(part for part in (prefix,node.module) if part)
            if module:
                if module!="recompyler":used.add(module)
                used.update(module+'.'+alias.name for alias in node.names)
    return used


def affected_tests(root_or_changed,changed=None,*,root=None):
    if root is None:
        root=Path(root_or_changed)
    else:
        changed=root_or_changed
        root=Path(root)
    tests={p.relative_to(root).as_posix():p for p in (root/'tests').glob('test_*.py')}
    changed={str(p).replace('\\','/') for p in changed}
    if changed & {'tests/conftest.py','pyproject.toml','setup.py'}:
        return sorted(tests)
    selected=changed & tests.keys()
    modules={p[4:].rsplit('.',1)[0].replace('/','.').removesuffix('.__init__')
             for p in changed if p.startswith('src/') and Path(p).suffix in ('.py','.c')}
    # Native providers are also exposed through the matching Python facade.
    modules.update(m.removesuffix('_native') for m in tuple(modules) if m.endswith('_native'))
    modules.update(m.removesuffix('_native').replace('._','.') for m in tuple(modules) if m.endswith('_native'))
    sources={}
    for path in (root/'src').rglob('*.py'):
        module=path.relative_to(root/'src').with_suffix('').as_posix().replace('/','.').removesuffix('.__init__')
        package=module if path.name=='__init__.py' else module.rpartition('.')[0]
        sources[module]=imports(path.read_text(encoding='utf-8-sig'),package)
    while True:
        old=len(modules)
        modules.update(name for name,used in sources.items() if used & modules)
        if old==len(modules):break
    texts={name:path.read_text(encoding='utf-8-sig') for name,path in tests.items()}
    changed_tools={Path(p).name for p in changed if p.startswith('tools/')}
    selected.update(name for name,source in texts.items() if any(tool in source for tool in changed_tools))
    dependencies={name:imports(source) for name,source in texts.items()}
    for name,used in dependencies.items():
        if any(item==module or item.startswith(module+'.') for item in used for module in modules):
            selected.add(name)
    while True:
        old=len(selected)
        helpers={Path(p).stem for p in selected}
        selected.update(name for name,used in dependencies.items()
                        if any(item.removeprefix('tests.').split('.')[0] in helpers for item in used))
        if len(selected)==old:
            return sorted(selected)


def slow_test_names(source):
    tree=ast.parse(source.removeprefix("\ufeff"))
    aliases={'subprocess'}
    aliases.update(a.asname or a.name for n in ast.walk(tree) if isinstance(n,ast.Import)
                   for a in n.names if a.name=='subprocess')
    direct_process={a.asname or a.name for n in ast.walk(tree)
                    if isinstance(n,ast.ImportFrom) and n.module=='subprocess' for a in n.names}
    functions={n.name:n for n in ast.walk(tree) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef))}
    calls={};slow=set()
    for name,node in functions.items():
        used={a.arg for a in (*node.args.posonlyargs,*node.args.args,*node.args.kwonlyargs)}
        direct=bool(SLOW_NAME.search(name))
        for call in ast.walk(node):
            if not isinstance(call,ast.Call):continue
            target=call.func
            if isinstance(target,ast.Name):
                used.add(target.id)
                direct |= target.id in direct_process or target.id in BUILD_CALLS
            elif isinstance(target,ast.Attribute):
                used.add(target.attr)
                direct |= target.attr in BUILD_CALLS
                direct |= isinstance(target.value,ast.Name) and target.value.id in aliases and target.attr in {'run','Popen','call','check_call','check_output'}
        calls[name]=used
        if direct:slow.add(name)
    while True:
        old=len(slow)
        slow.update(name for name,used in calls.items() if used & slow)
        if old==len(slow):break
    if slow & {'setUp','setUpClass','setup_module','setup_function'}:
        return {name for name in functions if name.startswith('test_')}
    return {name for name in slow if name.startswith('test_')}


def cache_environment(root,base=None,*,force=False):
    root=Path(root).resolve()
    env=dict(os.environ if base is None else base)
    env["PYTHONPATH"]=str(root/"src")
    for name,folder in [('RECOMPYLER_CACHE','rc'),('NUMBA_CACHE_DIR','numba')]:
        path=root/'.cache'/folder
        path.mkdir(parents=True,exist_ok=True)
        if force:env[name]=str(path)
        else:env.setdefault(name,str(path))
    return env


def changed_paths(root,base):
    result=set()
    for command in [ ['git','-c','safe.directory=*','diff','--name-only',base,'--','src','tests','tools','setup.py','pyproject.toml'],
                     ['git','-c','safe.directory=*','ls-files','--others','--exclude-standard','--','src','tests','tools'] ]:
        result.update(subprocess.check_output(command,cwd=root,text=True).splitlines())
    return sorted(result)


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('paths',nargs='*')
    parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    parser.add_argument('--base',default='HEAD')
    parser.add_argument('--run',action='store_true')
    args=parser.parse_args(argv)
    tests=affected_tests(args.root,args.paths or changed_paths(args.root,args.base))
    if not args.run:
        print('\n'.join(tests));return 0
    if not tests:
        print('No affected tests.');return 0
    (args.root/'.cache'/'test-runs'/'temp').mkdir(parents=True,exist_ok=True)
    flags=0x4000|0x08000000 if os.name=='nt' else 0
    return subprocess.call([sys.executable,'-m','pytest','-q','-m','not slow',
                            '--basetemp='+str(args.root/'.cache'/'test-runs'/'temp'/('affected-'+str(os.getpid()))),*tests],
                           cwd=args.root,env=cache_environment(args.root,force=True),creationflags=flags,
                           stdout=sys.stdout,stderr=sys.stderr)

if __name__=='__main__':raise SystemExit(main())
