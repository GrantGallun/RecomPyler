"""Join executed rows to retained wave14 observations; never infer a verdict."""
import ast, collections, hashlib, json, re, sys, importlib
from pathlib import Path
R=Path(__file__).resolve().parents[1];W=R.parent/'wave14-capture/capture'
sys.path.insert(0,str(R/'matrix'))
from catalogue import cases

def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def category(reason):
    if "attributes" in reason and "__init__" in reason and "set" in reason:
        return 'object_layout'
    if 'declares globals or defines functions' in reason:
        return 'globals_or_closures'
    tests=[('bytes',r'\bbytes\b|bytearray'),('strings',r'\bstr\b|f-string|format|JoinedStr'),
      ('dict_set',r'\bdict\b|\bset\b|frozenset'),('closures',r'closure|defines functions'),('globals',r'global|used as a value'),
      ('calls',r'keyword|\*args|\*\*kwargs|a call of|plain method|callable'),
      ('generators',r'generator|GeneratorExp|yield'),('statements',r'\bWith\b|\bTry\b|AnnAssign|Import|Match'),
      ('operators',r'operator|arithmetic|comparison|and/or|\bin\b'),('capture',r'not captured|not considered|not observed|snapshot rule')]
    for name,pattern in tests:
        if re.search(pattern,reason):return name
    return 'other'

def evidence():
    path=W/'final-coverage-s23/summary.json';data=json.loads(path.read_text())
    frames=[];roots=[]
    for key,into in [('frames',frames),('roots',roots)]:
        for row in data[key]:
            if key=='roots' and row['convention']!='primary_entries':continue
            status=row['statuses']['final'];reason=status['next_actual_reason']
            into.append({'program':row['program'],'key':row['key'],'reason':reason,'category':category(reason),
              'old_self_s':row.get('old_trace_own_self_s',row.get('overlapping_envelope_old_self_s')),
              'captured':status.get('captured',False),'verified':status.get('verified',False),'deployed':status.get('deployed',False)})
    modules=('math','itertools','functools','collections','operator','re','struct')
    module_paths={m:str(getattr(importlib.import_module(m),'__file__','<builtin:'+m+'>')).lower().replace('\\','/') for m in modules}
    hot=[];seals={str(path):digest(path)}
    for p in sorted((W/'s12-s13-native-trace4').glob('*/data.json')):
        d=json.loads(p.read_text())
        if not d.get('complete'):continue
        seals[str(p)]=digest(p)
        for row in d['inventory']:
            file=row.get('file','').lower().replace('\\','/')
            module=next((m for m in modules if file==module_paths[m] or (module_paths[m].endswith('/__init__.py') and file.startswith(module_paths[m][:-11]))),None)
            if module:hot.append({'program':p.parent.name,'module':module,'function':row.get('qualname',row['function']),'calls':row['calls'],'self_s':row['self_s'],'cumulative_s':row['cumulative_s']})
    groups={}
    for name in sorted({r['category'] for r in frames}):
        selected=[r for r in frames if r['category']==name and not r['verified'] and not (r['program']=='fastapi' and r['old_self_s']>1)]
        byprogram=collections.defaultdict(float)
        for row in selected:byprogram[row['program']]+=row['old_self_s']
        largest=max(byprogram.values(),default=0)
        groups[name]={'associated_old_self_s':sum(byprogram.values()),'leave_largest_program_out_s':sum(byprogram.values())-largest,'top5_programs':sorted(byprogram.items(),key=lambda x:-x[1])[:5], 'frames':selected}
    return {'measurement':'existing wave14 only; no rerun and no unlocked-time prediction','source_sha256':seals,'excluded_artifacts':'fastapi failed-recording frames above 1s old own time excluded from category aggregates/rankings, retained raw root records labeled overlapping','groups':groups,'primary_entries':roots,'profiled_stdlib_python_calls':hot,'c_builtin_method_counts':None,'c_count_limit':'Wave14 accepted trace serializes Python code-object inventory and edges, not individual C builtin/method target call counts. All public methods are tested, rather than treating unavailable counts as zero.'}

def main():
    p=R/'matrix/heldout-evidence.json';p.write_text(json.dumps(evidence(),indent=2),encoding='utf-8')
    d=json.loads(p.read_text());print(json.dumps({'groups':{k:{a:b for a,b in v.items() if a!='frames'} for k,v in d['groups'].items()},'stdlib_python_hot_names':sorted({r['module']+'.'+r['function'] for r in d['profiled_stdlib_python_calls']})},indent=2))
if __name__=='__main__':main()
