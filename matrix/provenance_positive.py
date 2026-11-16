"""S52 useful positive queries, separate from adversarial refusing contracts."""
import ast,collections,hashlib,inspect,json,linecache,os,sys,textwrap,types
from pathlib import Path
from recompyler import provenance as p
R=Path(__file__).resolve().parents[1]

def root_keys(origins):
    return sorted([['argument',x.key[0]] if x.kind=='argument' else ['global',*x.key] for x in origins if x.kind in ('argument','global')],key=repr)

def origin_contract(case,node,value,summary,fn):
    if not summary.valid or value.unknown or not value.origins:return False
    reachable=p.descendants(value)
    if any(x.kind=='unknown' or (x.scope!=id(fn.__code__) and not (x.scope==0 and x.kind in ('argument','singleton'))) for x in reachable):return False
    if root_keys(reachable)!=sorted(case['expected_roots'],key=repr):return False
    if not all(x.kind==case['expected_kind'] for x in value.origins):return False
    if case.get('lexical_function') or case.get('required_parent'):return False  # explicit nested-scope transfer absent
    if case['expected_kind']=='attribute':
        if not all(x.key==(node.attr,*p.site(node)) and x.scope==id(fn.__code__) for x in value.origins):return False
    elif case['expected_kind']=='element':
        if not all(x.key==p.site(node.slice) and x.scope==id(fn.__code__) for x in value.origins):return False
    elif case['expected_kind']=='argument':
        if not all(x.key==(case['argument'],) for x in value.origins):return False
    if 'expected_fields' in case and sorted(x.key[0] for x in reachable if x.kind=='attribute')!=sorted(case['expected_fields']):return False
    if case.get('required_members'):
        # No API yet certifies the required dynamic member producers/escapes.
        # Even 21 known children cannot substitute for that consumer contract.
        return False
    return True

def evaluate():
    base=Path(os.environ.get('PROVENANCE_CORPUS',R.parent/'provenance-cases'))
    path=base/'wave17-matrix-should-prove.py'
    if not path.exists() and 'PROVENANCE_CORPUS' not in os.environ:path=R/'tests/provenance_cases'/path.name
    data={};exec(compile(path.read_text(encoding='utf-8-sig'),str(path),'exec'),data)
    modules={};support=data['SUPPORT']
    assert hashlib.sha256(support['text'].encode()).hexdigest()==support['text_sha256']
    absent=object();previous=sys.modules.get('pyperf',absent);shim=types.ModuleType('pyperf')
    exec(compile(support['text'],str(path)+':pyperf','exec',dont_inherit=True),shim.__dict__)
    sys.modules['pyperf']=shim
    try:
        for name,source in data['SOURCES'].items():
            filename=str(path)+':'+name;text=source['text']
            assert hashlib.sha256(text.encode()).hexdigest()==source['text_sha256']
            linecache.cache[filename]=(len(text),None,text.splitlines(True),filename)
            module=types.ModuleType('wave17_positive_'+name);module.__file__=filename
            exec(compile(text,filename,'exec',dont_inherit=True),module.__dict__)
            modules[name]=module
    finally:
        if previous is absent:sys.modules.pop('pyperf',None)
        else:sys.modules['pyperf']=previous
    rows=[]
    for case in data['CASES']:
        fn=modules[case['module']]
        for name in case['function'].split('.'):fn=getattr(fn,name)
        tree=ast.parse(textwrap.dedent(inspect.getsource(fn)))
        targets=[n for n in ast.walk(tree) if isinstance(n,ast.expr) and list(p.site(n))==case['site']]
        if len(targets)!=1:raise ValueError('positive site missing: '+case['id'])
        node=targets[0]
        assert ast.unparse(node)==case['expression']
        assert (type(node.ctx).__name__ if hasattr(node,'ctx') else None)==case['context']
        summary=p.analyze(fn);value=summary.expressions.get(p.site(node),p.UNKNOWN)
        origins=p.descendants(value)
        facts={'valid':summary.valid,'reason':summary.reason,'origin_kinds':sorted({x.kind for x in origins}),'roots':root_keys(origins)}
        proved=case['action'] in ('origin','aggregate') and origin_contract(case,node,value,summary,fn)
        if case['action']=='physical':proved=summary.naturally_rooted(value) is True
        # Earliest observed failure is distinct from the downstream requested API.
        if not summary.valid:
            blocking=('original source/bytecode binding' if 'bind original' in summary.reason or 'instruction positions' in summary.reason else 'unsupported CFG/closure')
        elif p.site(node) not in summary.expressions or any(x.kind=='unknown' for x in origins):blocking='queried source owner absent or widened'
        elif case.get('lexical_function') or case.get('required_parent'):blocking='nested-scope transfer API'
        elif case['action'] in ('physical','journal','virtual','callee'):blocking=case['missing_fact']
        elif case.get('required_members'):blocking='aggregate member producer/escape API'
        else:blocking='exact source origin contract'
        rows.append({**case,**facts,'blocking_fact':None if proved else blocking,'verdict':'proved' if proved else 'missing',
                     'obligations':['consumer exact type/layout guard','consumer callback/effect guard','runtime origin resolution at this operation'] if proved else []})
    missing=collections.Counter(x['blocking_fact'] for x in rows if x['verdict']=='missing')
    categories={
      'nested closures/nonlocal':['nested closure','nested __class__ closure','nested closure and fresh-list contents','nested-scope closure-cell transfer','nested-scope formal substitution'],
      'generators/async':[],
      'unsupported CFG':['unsupported CFG','comprehension CFG'],
      'loop dynamic instance correlation':['loop-carried selected owner','borrowed iterable element'],
      'unknown callback or call result':['callee return transfer','callee selected-return transfer'],
      'nonweak dependency live pins':[],
      'physical roots':['physical roots'],'journal topology':['journal topology'],
      'virtual-field transfer':['virtual-field transfer'],'callee allocation tags':['callee allocation tags'],
    }
    limits={key:[x['id'] for x in rows if x['verdict']=='missing' and x['missing_fact'] in labels] for key,labels in categories.items()}
    return {'complete':True,'corpus_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'should_prove':{'proved':sum(x['verdict']=='proved' for x in rows),'total':len(rows)},
            'rows':rows,'missing_facts_ranked':[{'missing_fact':k,'cases':v} for k,v in missing.most_common()],
            'limitations':limits,'limits_note':'Limits map requested downstream obligations even behind earlier binding refusal. Ranked blocking_fact records earliest actual refusal. Zero sampled cases does not establish universal absence.',
            'auxiliary_parked_local_fixture':data['AUXILIARY'],
            'note':'Source queries on unchanged real functions, with frozen original pyperf support. A source proof never authorizes native field loads, callbacks or publication. No layer source change or extra native function claimed.'}

if __name__=='__main__':
    report=evaluate();Path(sys.argv[1]).write_text(json.dumps(report,indent=2),encoding='utf-8')
    print(json.dumps({k:v for k,v in report.items() if k not in ('rows','auxiliary_parked_local_fixture')}))
