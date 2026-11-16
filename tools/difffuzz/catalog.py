"""Inventory real matrix rows and statically extracted test/corpus subjects."""
import ast
import copy
import importlib.util
from pathlib import Path

SAFE_IMPORTS={'ast','time','math','cmath','struct','operator','itertools','functools','collections','re','decimal','array','random','copy','types','typing','dataclasses','unittest','pytest','string','enum'}


def literal(node):
    try:ast.literal_eval(node);return True
    except (ValueError,TypeError):return isinstance(node,ast.Constant)


def safe_function(node):
    return (not node.decorator_list and all(literal(x) for x in node.args.defaults+list(filter(None,node.args.kw_defaults))))


def filtered_source(source):
    """Never execute a test module's test runner, fixture setup, or imports of it."""
    tree=ast.parse(source);body=[]
    for node in tree.body:
        if isinstance(node,(ast.Import,ast.ImportFrom)):
            names=[a.name.split('.')[0] for a in node.names] if isinstance(node,ast.Import) else [(node.module or '').split('.')[0]]
            if all(name in SAFE_IMPORTS for name in names):body.append(node)
        elif isinstance(node,(ast.Assign,ast.AnnAssign)) and node.value is not None and literal(node.value):body.append(node)
        elif isinstance(node,ast.FunctionDef) and not node.name.startswith('test_') and safe_function(node):body.append(node)
        elif isinstance(node,ast.ClassDef) and not node.decorator_list and not node.keywords:
            if all(isinstance(b,ast.Name) for b in node.bases) and all(isinstance(n,(ast.Pass,ast.Expr)) and (not isinstance(n,ast.Expr) or literal(n.value)) or isinstance(n,ast.FunctionDef) and safe_function(n) or isinstance(n,ast.Assign) and literal(n.value) for n in node.body):body.append(node)
    tree.body=body
    return ast.unparse(tree)+'\n'


def discover(root,sources=('matrix','tests','corpus'),files=()):
    descriptors=[]
    if 'matrix' in sources:
        spec=importlib.util.spec_from_file_location('difffuzz_catalogue',root/'matrix/catalogue.py')
        import sys
        oldpath=sys.path[:]
        try:
            sys.path.insert(0,str(root/'matrix'))
            module=importlib.util.module_from_spec(spec);sys.modules[spec.name]=module;spec.loader.exec_module(module)
            for case in module.cases():
                descriptors.append(dict(id='matrix:'+case.id,source=module.source(case),name='construct',args=case.args,kwargs=case.kwargs,origin='matrix',owner='lift/heap',path=str(root/'matrix/catalogue.py')))
        finally:sys.path[:]=oldpath
    paths=[]
    if 'tests' in sources:paths+=sorted((root/'tests').glob('test_*.py'))
    if 'corpus' in sources:
        corpus=root.parent/'provenance-cases'
        if not corpus.exists():corpus=root/'tests/provenance_cases'
        paths+=sorted(corpus.glob('*.py'))
    paths+=list(map(Path,files))
    for path in dict.fromkeys(paths):
        try:
            raw=path.read_text(encoding='utf-8-sig');rawtree=ast.parse(raw)
            source=filtered_source(raw);tree=ast.parse(source)
        except (OSError,SyntaxError):continue
        explicit={}
        for assignment in tree.body:
            if isinstance(assignment,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='FUZZ_ARGUMENTS' for t in assignment.targets):
                try:explicit=ast.literal_eval(assignment.value)
                except (ValueError,TypeError):pass
        for node in tree.body:
            if not isinstance(node,ast.FunctionDef) or node.name.startswith(('test_','check_')):continue
            # A function which performs orchestration is not a compiled subject.
            if any(isinstance(n,ast.Assert) for n in ast.walk(node)):continue
            descriptors.append(dict(id=path.name+':'+node.name,source=source,name=node.name,args=explicit.get(node.name) if type(explicit.get(node.name)) is str else None,kwargs=None,origin='tests' if path.parent.name=='tests' else 'corpus',owner='lift/heap',path=str(path.resolve())))
    return descriptors


def mutate(descriptor,index):
    """Small deterministic edits to an existing subject; no generated grammar."""
    d=dict(descriptor);tree=ast.parse(d['source']);fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name==d['name'])
    operators={ast.Add:ast.Sub,ast.Sub:ast.Add,ast.Mult:ast.Add,ast.BitAnd:ast.BitOr,ast.BitOr:ast.BitXor}
    options=[n for n in ast.walk(fn) if isinstance(n,ast.BinOp) and type(n.op) in operators]
    constants=[n for n in ast.walk(fn) if isinstance(n,ast.Constant) and type(n.value) is int]
    mode=index%4
    if mode==0 and options:
        node=options[(index//4)%len(options)];node.op=operators[type(node.op)]()
    elif mode==1 and constants:constants[(index//4)%len(constants)].value=(0,-1,2**63-1,2**63)[(index//4)%4]
    elif mode==2:
        fn.body=[ast.If(test=ast.Constant(True),body=fn.body,orelse=[])]
    else:
        assignments=[i for i,n in enumerate(fn.body[:-1]) if isinstance(n,ast.Assign) and isinstance(fn.body[i+1],ast.Assign)]
        if assignments:
            at=assignments[(index//4)%len(assignments)];fn.body[at],fn.body[at+1]=fn.body[at+1],fn.body[at]
        else:fn.body=[ast.For(target=ast.Name(id='_difffuzz_once',ctx=ast.Store()),iter=ast.Call(func=ast.Name(id='range',ctx=ast.Load()),args=[ast.Constant(1)],keywords=[]),body=fn.body,orelse=[])]
    ast.fix_missing_locations(tree);d['source']=ast.unparse(tree)+'\n';d['id']+=':mutation'+str(index);d['mutation']=index
    return d


def resource_risk(source,args,kwargs):
    """Skip unbounded boundary probes before allocating giant powers or loops."""
    values=list(args)+list(kwargs.values())
    large=any(type(v) in (int,float) and (not isinstance(v,int) or abs(v)>256) for v in values)
    tree=ast.parse(source)
    growing=any(isinstance(n,(ast.For,ast.While,ast.comprehension)) or isinstance(n,ast.BinOp) and isinstance(n.op,(ast.Pow,ast.LShift,ast.Mult)) for n in ast.walk(tree))
    return large and growing
