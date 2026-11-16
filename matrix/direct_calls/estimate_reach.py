"""Explicit syntax reach estimate only; no compiler verdict is produced here."""
from pathlib import Path
import ast,json,sys,collections
R=Path(__file__).resolve().parents[2];sys.path.insert(0,str(R/'matrix'))
from catalogue import cases
baseline={r['id']:r for r in map(json.loads,(R/'matrix/baseline-v1.jsonl').read_text().splitlines())}
blocked=(ast.AsyncFunctionDef,ast.Await,ast.AsyncFor,ast.AsyncWith,ast.Yield,ast.YieldFrom,ast.GeneratorExp,ast.ListComp,ast.SetComp,ast.DictComp,ast.ClassDef,ast.Lambda,ast.Try,ast.TryStar,ast.With,ast.Import,ast.ImportFrom,ast.Global,ast.Nonlocal,ast.Match,ast.TypeAlias,ast.JoinedStr,ast.TemplateStr,ast.NamedExpr,ast.Delete,ast.MatMult)
excluded_builtins={'eval','exec','globals','locals','vars','dir','super','breakpoint','help','license','copyright','credits','exit','quit','property','classmethod','staticmethod'}
rows=[]
for c in cases():
    if c.id not in baseline or baseline[c.id]['verdict']!='declined':continue
    tree=ast.parse(c.source());target=next(n for n in reversed(tree.body) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)))
    reasons=[]
    if isinstance(target,ast.AsyncFunctionDef):reasons.append('async body')
    if target.args.vararg or target.args.kwarg or target.args.kwonlyargs:reasons.append('signature integration not provided')
    for n in ast.walk(ast.Module(body=target.body,type_ignores=[])):
        if isinstance(n,blocked):reasons.append(type(n).__name__)
        if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)):reasons.append('nested body')
        if isinstance(n,ast.Call) and isinstance(n.func,ast.Name) and n.func.id in excluded_builtins:reasons.append('frame/context-sensitive or untested builtin '+n.func.id)
        if isinstance(n,ast.Call) and any(isinstance(a,ast.Starred) for a in n.args):reasons.append('call unpack integration untested')
        if isinstance(n,ast.Call) and any(k.arg is None for k in n.keywords):reasons.append('keyword unpack integration untested')
    rows.append({'id':c.id,'estimated_expression_mechanism_candidate':not reasons,'excluded_reasons':sorted(set(reasons))})
result={'label':'ESTIMATE, NOT EXECUTED NATIVE VERDICTS','baseline_declines':655,'candidate_count':sum(r['estimated_expression_mechanism_candidate'] for r in rows),'production_rows_newly_native':0,'interpretation':'Syntactic estimate for a future whole-body boxed object emitter/integrated object-mode backend. Generic CPython calls can express these bodies, but this prototype has no automatic capture/guards/emitter/AOT/deployment integration. AOT feasibility and speed remain separate. Each included row must be executed before any future native claim; exclusions are scope limits of this estimate, not Python impossibility.','rows':rows}
(R/'matrix/direct_calls/estimated-reach.json').write_text(json.dumps(result,indent=2));print(result['candidate_count'],len(rows))
