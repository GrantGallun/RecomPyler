"""Static source construct frequencies, with explicit type/binding ambiguity."""
from pathlib import Path
import ast,collections,hashlib,json,sys,sysconfig,tokenize
R=Path(__file__).resolve().parents[1];sys.path.insert(0,str(R/'matrix'))
from catalogue import cases
ROOT=R.parent/'wave14-capture/capture/inputs';stdlib=Path(sysconfig.get_path('stdlib'))
def imported(tree, package=''):
    for n in ast.walk(tree):
        if isinstance(n,ast.Import):yield from (a.name for a in n.names)
        if isinstance(n,ast.ImportFrom):
            if n.level:
                parts=package.split('.') if package else []
                base='.'.join(parts[:len(parts)-n.level+1])
                module='.'.join(x for x in (base,n.module) if x)
            else:module=n.module or ''
            if module:
                yield module
                for alias in n.names:
                    if alias.name!='*':yield module+'.'+alias.name

def features(tree):
    counts=collections.Counter()
    for n in ast.walk(tree):
        if isinstance(n,(ast.stmt,ast.expr,ast.operator,ast.unaryop,ast.boolop,ast.cmpop,ast.pattern,ast.excepthandler,ast.type_param)):
            counts['ast:'+type(n).__name__]+=1
        if isinstance(n,(ast.For,ast.While,ast.AsyncFor)) and n.orelse:counts['role:'+type(n).__name__+'.else']+=1
        if isinstance(n,ast.BinOp):counts['binary:'+type(n.op).__name__]+=1
        if isinstance(n,ast.AugAssign):counts['augmented:'+type(n.op).__name__]+=1
        if isinstance(n,ast.UnaryOp):counts['unary:'+type(n.op).__name__]+=1
        if isinstance(n,ast.BoolOp):counts['boolean:'+type(n.op).__name__]+=1
        if isinstance(n,ast.Compare):
            if len(n.ops)>1:counts['comparison:chain']+=1
            for op in n.ops:counts['comparison:'+type(op).__name__]+=1
        if isinstance(n,(ast.List,ast.Tuple,ast.Dict,ast.Set)) and (not hasattr(n,'ctx') or isinstance(n.ctx,ast.Load)):
            counts['literal:'+type(n).__name__]+=1
            if any(isinstance(x,ast.Starred) for x in getattr(n,'elts',[])):counts['literal:'+type(n).__name__+'.star']+=1
            if isinstance(n,ast.Dict) and None in n.keys:counts['literal:Dict.unpack']+=1
        if isinstance(n,ast.Constant):
            counts['constant:'+type(n.value).__name__]+=1
            if type(n.value) is int and n.value.bit_length()>63:counts['constant:int.over64']+=1
        if isinstance(n,(ast.Assign,ast.AugAssign,ast.AnnAssign)):
            targets=n.targets if isinstance(n,ast.Assign) else [n.target]
            for t in targets:
                if isinstance(t,ast.Subscript) and isinstance(t.slice,ast.Slice):counts['role:slice_store']+=1
                if isinstance(t,(ast.Tuple,ast.List)):counts['assignment:unpack']+=1
                if any(isinstance(x,ast.Starred) for x in ast.walk(t)):counts['assignment:star_unpack']+=1
        if isinstance(n,ast.Return) and isinstance(n.value,ast.Name):counts['role:return_name']+=1
        if isinstance(n,ast.Delete):
            for target in n.targets:
                label='slice' if isinstance(target,ast.Subscript) and isinstance(target.slice,ast.Slice) else type(target).__name__
                counts['delete:'+label]+=1
        if isinstance(n,ast.FormattedValue):
            counts['fstring:conversion:'+str(n.conversion)]+=1
            if n.format_spec is not None:counts['fstring:format_spec']+=1
        if isinstance(n,ast.Match):
            for case in n.cases:
                if case.guard is not None:counts['pattern:guard']+=1
                if isinstance(case.pattern,ast.MatchAs) and case.pattern.name is None and case.pattern.pattern is None:counts['pattern:wildcard']+=1
        if isinstance(n,ast.comprehension):
            if n.is_async:counts['comprehension:async']+=1
        if isinstance(n,(ast.With,ast.AsyncWith)):
            counts['with:'+type(n).__name__+('.multiple' if len(n.items)>1 else '.single')]+=1
        if isinstance(n,ast.AnnAssign):counts['annotation:only' if n.value is None else 'annotation:assign']+=1
        if isinstance(n,ast.ExceptHandler):
            if n.type is None:counts['except:bare']+=1
            if n.name is not None:counts['except:as']+=1
        if isinstance(n,ast.Raise):
            if n.exc is None:counts['raise:reraise']+=1
            if isinstance(n.cause,ast.Constant) and n.cause.value is None:counts['raise:suppressed']+=1
        if isinstance(n,ast.Try):
            if n.orelse:counts['try:else']+=1
            if n.finalbody:counts['try:finally']+=1
            if n.handlers:counts['try:except']+=1
            if n.handlers and n.orelse and n.finalbody:counts['try:all']+=1
        if isinstance(n,ast.Raise) and n.cause is not None:counts['raise:from']+=1
        if isinstance(n,ast.Call):
            if isinstance(n.func,ast.Name):counts['call:name:'+n.func.id]+=1;counts['builtin:'+n.func.id]+=1
            if isinstance(n.func,ast.Attribute):counts['call:method:'+n.func.attr]+=1;counts['call:method']+=1
            if not n.keywords and not any(isinstance(a,ast.Starred) for a in n.args):counts['call:positional']+=1
            if n.keywords:counts['call:keywords']+=1
            if any(k.arg is None for k in n.keywords):counts['call:double_star']+=1
            if any(isinstance(a,ast.Starred) for a in n.args):counts['call:star']+=1
        if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef,ast.ClassDef)):
            for dec in n.decorator_list:
                if isinstance(dec,ast.Name):counts['builtin:'+dec.id]+=1
            if n.decorator_list:counts['role:decorator']+=1
        if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)):
            if n.args.vararg:counts['signature:vararg']+=1
            if n.args.kwarg:counts['signature:kwarg']+=1
            if n.args.kwonlyargs:counts['signature:kwonly']+=1
            if n.args.posonlyargs:counts['signature:posonly']+=1
            if n.args.defaults or any(n.args.kw_defaults):counts['signature:defaults']+=1
            counts['role:function_definition']+=1
            for child in ast.walk(n):
                if isinstance(child,ast.Call) and isinstance(child.func,ast.Name) and child.func.id==n.name:counts['call:recursive_name_candidate']+=1
            def nested(statements):
                for child in statements:
                    if isinstance(child,(ast.FunctionDef,ast.AsyncFunctionDef)):
                        counts['role:nested_function']+=1
                    elif not isinstance(child,(ast.ClassDef,ast.Lambda)):
                        nested(list(ast.iter_child_nodes(child)))
            nested(n.body)
        if isinstance(n,ast.Assign) and isinstance(n.value,ast.Name):counts['value:named_reference']+=1
        if isinstance(n,ast.Assign) and isinstance(n.value,ast.Attribute):counts['value:bound_attribute']+=1
    return counts

def row_feature(c):
    parts=c.id.split('.');role=parts[0];name=parts[-1]
    binary=['Add','Sub','Mult','Div','FloorDiv','Mod','Pow','LShift','RShift','BitAnd','BitOr','BitXor','MatMult']
    compare=['Eq','NotEq','Lt','LtE','Gt','GtE','Is','IsNot','In','NotIn']
    if c.id=='operator.matmul_valid':return 'binary:MatMult'
    if role=='operator' and len(parts)==3:
        form=parts[2]
        for prefix,table in [('binary',binary),('augmented',binary),('compare',compare),('unary',['UAdd','USub','Invert','Not'])]:
            if form.startswith(prefix):return ('comparison' if prefix=='compare' else prefix)+':'+table[int(form[len(prefix):])]
        return {'chain':'comparison:chain','and':'boolean:And','or':'boolean:Or'}[form]
    if role=='builtin':return 'builtin:'+('anext' if parts[1].startswith('anext_') else parts[1])
    if role=='method':return 'call:method:'+parts[2]
    if role=='call':return {'varargs':'signature:vararg','varkw':'signature:kwarg','kwonly':'signature:kwonly','posonly':'signature:posonly','defaults':'signature:defaults','keyword':'call:keywords','star':'call:star','double_star':'call:double_star','closure':'role:nested_function','decorator':'role:decorator','bound_value':'value:bound_attribute','function_value':'value:named_reference','method':'call:method','positional':'call:positional','recursion':'call:recursive_name_candidate'}.get(name,'unresolved:'+c.id)
    if role=='literal':
        if name in ['fstring_s','fstring_r','fstring_a']:return 'fstring:conversion:'+str(ord(name[-1]))
        if name in ['fstring_spec','fstring_nested']:return 'fstring:format_spec'
        if name.startswith('fstring'):return 'ast:JoinedStr'
        if name in ['format','format_map']:return 'call:method:'+name
        if name.startswith('slice'):return 'ast:Slice'
        if name=='dict_unpack':return 'literal:Dict.unpack'
        for kind in ['list','tuple','set','dict']:
            if name==kind or name==kind+'_star':return 'literal:'+kind.title()+('.star' if name.endswith('_star') else '')
        return {'str':'constant:str','bytes':'constant:bytes','float':'constant:float','complex':'constant:complex','bigint':'constant:int.over64','negative_bigint':'constant:int.over64','int64':'constant:int','negative_zero':'constant:float','inf':'builtin:float','nan':'builtin:float','template':'ast:TemplateStr'}.get(name,'unresolved:'+c.id)
    # This fallback reads only the target body, never fixture setup/wrapper.
    body=ast.parse(c.body)
    f=features(body)
    roles={'for_else':'role:For.else','while_else':'role:While.else','for_else':'role:For.else','with_multiple':'ast:AsyncWith' if role=='async' else 'ast:With','for_else':'role:AsyncFor.else' if role=='async' else 'role:For.else'}
    explicit={'function_def':'role:function_definition','class':'ast:ClassDef','lambda':'ast:Lambda','del_name':'delete:Name','del_item':'delete:Subscript','del_attribute':'delete:Attribute','del_slice':'delete:slice','try_else':'try:else','try_finally':'try:finally','raise':'ast:Raise','slice_store':'role:slice_store','raise_from':'raise:from','return':'ast:Return','boolean_roles':'boolean:And','none':'constant:NoneType','unpack_assign':'assignment:unpack','star_assign':'assignment:star_unpack','not':'unary:Not'}
    explicit.update({'pass':'ast:Pass','continue':'ast:Continue','for_break':'ast:Break','while_break':'ast:Break','del_attr':'delete:Attribute','type_parameters':'ast:TypeVar','type_var_tuple':'ast:TypeVarTuple','param_spec':'ast:ParamSpec','type_alias':'ast:TypeAlias','annotated_assign':'annotation:assign','annotation_only':'annotation:only','bare_except':'except:bare','except_as':'except:as','raise_reraise':'raise:reraise','raise_suppressed':'raise:suppressed','try_all':'try:all','try_except':'try:except','with_single':'with:With.single','with_multiple':'with:With.multiple'})
    if role=='statement' and name in explicit:return explicit[name]
    if role=='pattern' and name in ('guard','wildcard'):return 'pattern:'+name
    if role=='async' and name=='async_comprehension':return 'comprehension:async'
    if role=='async' and name=='async_def':return 'ast:AsyncFunctionDef'
    if name in roles:return roles[name]
    wanted={'pattern':['MatchValue','MatchSingleton','MatchSequence','MatchMapping','MatchClass','MatchStar','MatchAs','MatchOr'],'comprehension':['ListComp','SetComp','DictComp','GeneratorExp'],'async':['Await','AsyncFor','AsyncWith','Yield'],'statement':['TypeAlias','TypeVarTuple','ParamSpec','TypeVar','AnnAssign','Nonlocal','Global','ImportFrom','Import','Delete','Assert','TryStar','Try','With','ClassDef','FunctionDef','Lambda','YieldFrom','Yield','NamedExpr','IfExp','For','While','If']}.get(role,[])
    for n in wanted:
        if f['ast:'+n] :return 'ast:'+n
    if role=='stdlib':return 'call:method:'+name
    # Execution-boundary/review rows have runtime input predicates. Count only
    # their visible syntactic operation; do not infer those predicates in source.
    for n in ast.walk(body):
        if isinstance(n,ast.Compare):return 'comparison:chain' if len(n.ops)>1 else 'comparison:'+type(n.ops[0]).__name__
        if isinstance(n,ast.BoolOp):return 'boolean:'+type(n.op).__name__
        if isinstance(n,ast.BinOp):return 'binary:'+type(n.op).__name__
        if isinstance(n,ast.IfExp):return 'ast:IfExp'
        if isinstance(n,ast.Subscript):return 'ast:Subscript'
        if isinstance(n,ast.Dict):return 'literal:Dict'
    for n in ast.walk(body):
        if isinstance(n,ast.Call) and isinstance(n.func,ast.Attribute):return 'call:method:'+n.func.attr
    if f['role:return_name']:return 'role:return_name'
    if f['ast:Call']:return 'ast:Call'
    if role=='statement' and name=='return':return 'ast:Return'
    return 'unresolved:'+c.id

def main():
    own=sorted(p for p in ROOT.rglob('*.py') if 'shim' not in p.relative_to(ROOT).parts);files={};queue=list(own);ownset=set(own);skipped=[]
    while queue:
        p=queue.pop()
        if p in files:continue
        try:
            with tokenize.open(p) as handle:text=handle.read()
            tree=ast.parse(text)
        except (OSError,SyntaxError,UnicodeError) as exc:
            skipped.append({'file':str(p),'reason':str(exc)});continue
        files[p]=(tree,hashlib.sha256(text.encode()).hexdigest())
        package=''
        if p.is_relative_to(stdlib):
            parts=list(p.relative_to(stdlib).with_suffix('').parts)
            if parts[-1]=='__init__':parts=parts[:-1]
            else:parts=parts[:-1]
            package='.'.join(parts)
        for module in imported(tree,package):
            parts=module.split('.')
            for end in range(1,len(parts)+1):
                candidate=stdlib.joinpath(*parts[:end]);q=candidate.with_suffix('.py')
                if not q.is_file():q=candidate/'__init__.py'
                if q.is_file() and q not in files:queue.append(q)
    total=collections.Counter();owncounts=collections.Counter();functions=0
    for p,(tree,sha) in files.items():
        total.update(features(tree))
        if p in ownset:
            owncounts.update(features(tree));functions+=sum(isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)) for n in ast.walk(tree))
    matrix=json.loads((R/'matrix/matrix.json').read_text());rows=matrix['rows'] if isinstance(matrix,dict) else matrix
    verdict={r['id']:r['verdict'] for r in rows};out=[]
    for c in cases():
        feature=row_feature(c);out.append({'id':c.id,'feature':feature,'own_occurrences':None if feature.startswith('unresolved:') else owncounts[feature],'own_and_imported_stdlib_occurrences':None if feature.startswith('unresolved:') else total[feature],'verdict':verdict.get(c.id,'pending execution')})
    unique={}
    for row in out:
        if row['own_and_imported_stdlib_occurrences'] is not None:unique.setdefault(row['feature'],[]).append(row)
    top=sorted(unique.items(),key=lambda kv:-kv[1][0]['own_and_imported_stdlib_occurrences'])[:40]
    data={'method':'AST-only possible-import closure over conditional absolute/relative/from imports resolved under installed stdlib; dynamic/unresolvable imports are not enumerated; benchmark shim excluded; no imports executed. Unresolved features have null counts, not zero. Literal computations, runtime receiver kinds and boundary-input predicates are not inferred; boundary/review rows count only their visible syntactic operation. Nested-function count is a closure candidate count, not a captured-free-variable proof. Features shared across runtime kinds are possible occurrences, not inferred receiver types or binding proofs. Method names can denote user classes. Features overlap and are not additive.','own_files':len(own),'own_manifest':[str(p) for p in own],'excluded_manifest':[str(p) for p in ROOT.rglob('*.py') if 'shim' in p.relative_to(ROOT).parts],'skipped':skipped,'verdict_source_sha256':hashlib.sha256((R/'matrix/matrix.json').read_bytes()).hexdigest(),'parsed_files':len(files),'own_function_definitions':functions,'sources':{str(p):sha for p,(_,sha) in files.items()},'rows':out,'top40_rows':sorted([row for row in out if row['own_and_imported_stdlib_occurrences'] is not None],key=lambda r:-r['own_and_imported_stdlib_occurrences'])[:40],'top40':[{'feature':k,'occurrences':v[0]['own_and_imported_stdlib_occurrences'],'own_occurrences':v[0]['own_occurrences'],'matrix_verdicts':dict(collections.Counter(r['verdict'] for r in v)),'row_ids':[r['id'] for r in v]} for k,v in top]}
    (R/'matrix/static-frequency.json').write_text(json.dumps(data,indent=2))
    lines=['# Ordinary-source frequency','',data['method'],'',f'{len(own)} held-out own files; {functions} function definitions (including methods/nested/async); {len(files)} total parsed own+stdlib source files. No dynamic compilation share is inferred from these counts.','','| Construct | Own count | Own + imported stdlib | Current matrix verdicts |','|---|---:|---:|---|']
    for row in data['top40']:lines.append('| '+row['feature']+' | '+str(row['own_occurrences'])+' | '+str(row['occurrences'])+' | '+str(row['matrix_verdicts'])+' |')
    lines+=['','## Top 40 matrix rows','','Runtime-kind rows share syntactic counts; these rows overlap.','','| Matrix row | Feature | Own | Own + stdlib | Verdict |','|---|---|---:|---:|---|']
    for row in data['top40_rows']:lines.append('| '+row['id']+' | '+row['feature']+' | '+str(row['own_occurrences'])+' | '+str(row['own_and_imported_stdlib_occurrences'])+' | '+row['verdict']+' |')
    (R/'matrix/STATIC-FREQUENCY.md').write_text('\n'.join(lines)+'\n');print(len(files),functions)
if __name__=='__main__':main()
