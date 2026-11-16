"""Prepared exact-source kernel component observer; requires accepted Step0 and external lock."""
import argparse, ast, functools, hashlib, inspect, json, os, re, sys, textwrap, threading, time
from pathlib import Path
from collections import Counter
D=Path(__file__).resolve().parent; R=D.parent; W=R.parent
ARTIFACT_HASHES={}; NATIVE_IDENTITIES={}
LABELS = ("binding_ns", "program_lookup_ns", "load_ns", "guards_ns", "arrays_ns", "array_snapshot_rollback_ns", "arena_capacity_ns", "staged_payload_copy_ns", "control_writes_ns", "recursion_frame_scan_ns", "native_ns", "unloader_init_ns", "result_prepare_ns", "result_ns", "writeback_ns", "rng_store_ns", "shape_prepare_ns", "boundary_init_ns", "boundary_discard_ns", "result_validation_ns", "bookkeeping_ns")
BOUNDARY=("load_ns","guards_ns","result_ns","writeback_ns")
ACTIVE=threading.local()
clock=time.perf_counter_ns
class Ledger:
    """Clock transitions partition one outer attempt; nested envelopes also saved."""

    def __init__(self):
        self.exclusive = {label: 0 for label in LABELS}
        self.inclusive = {label: 0 for label in LABELS if label != 'bookkeeping_ns'}
        self.entries = {label: 0 for label in LABELS if label != 'bookkeeping_ns'}
        self.outer_entries = dict(self.entries)
        self.stack = [('bookkeeping_ns', 0, False)]
        self.native_events = []
        self.start = self.last = clock()

    def enter(self, label):
        now = clock()
        self.exclusive[self.stack[-1][0]] += now - self.last
        self.last = now
        outer = all((frame[0] != label for frame in self.stack))
        self.entries[label] += 1
        self.outer_entries[label] += int(outer)
        self.stack.append((label, now, outer))

    def leave(self, label):
        now = clock()
        current, start, outer = self.stack.pop()
        if current != label:
            raise RuntimeError('S18 scope stack mismatch')
        self.exclusive[label] += now - self.last
        self.last = now
        if outer:
            self.inclusive[label] += now - start

    def finish(self):
        now = clock()
        if len(self.stack) != 1:
            raise RuntimeError('S18 unclosed phase scope')
        self.exclusive['bookkeeping_ns'] += now - self.last
        total = now - self.start
        component_sum = sum(self.exclusive.values())
        if component_sum != total:
            raise RuntimeError('S18 exclusive phases do not sum to the attempt')
        boundary = sum((self.exclusive[label] for label in BOUNDARY))
        native = self.exclusive['native_ns']
        return dict(attempt_ns=total, native_events=list(self.native_events), native_entries=len(self.native_events), exclusive_ns=dict(self.exclusive), inclusive_outer_envelopes_ns=dict(self.inclusive), phase_entries=dict(self.entries), outer_phase_entries=dict(self.outer_entries), exclusive_boundary_ns=boundary, exclusive_native_ns=native, exclusive_other_ns=total - boundary - native, component_sum_ns=component_sum, components_reconcile=True)

class Scope:

    def __init__(self, label):
        self.label = label
        self.ledger = getattr(ACTIVE, 'ledger', None)

    def __enter__(self):
        if self.ledger is not None:
            self.ledger.enter(self.label)

    def __exit__(self, exc_type, exc, traceback):
        if self.ledger is not None:
            self.ledger.leave(self.label)
        return False

def scope(label):
    return Scope(label)

class AttemptScopes(ast.NodeTransformer):
    """Add phase contexts to existing statements without adding an attempt frame."""

    def __init__(self):
        self.sites = Counter()

    def wrap(self, node, label):
        self.sites[label] += 1
        return ast.copy_location(ast.With(items=[ast.withitem(context_expr=ast.Call(func=ast.Name(id='_s18_scope', ctx=ast.Load()), args=[ast.Constant(value=label)], keywords=[]))], body=[node], type_comment=None), node)

    def visit_Import(self, node):
        if any((alias.name == 'numpy' for alias in node.names)):
            return self.wrap(node, 'binding_ns')
        return node

    def visit_If(self, node):
        test = ast.unparse(node.test)
        if test in ('not _bound_entry', 'generator'):
            return self.wrap(node, 'binding_ns')
        if test in ('program is not None', 'program is None', 'program is not None and program.broken'):
            return self.wrap(self.generic_visit(node), 'program_lookup_ns')
        if test in ('loader.float_at', 'loader.int_at'):
            return self.wrap(node, 'staged_payload_copy_ns')
        if test == 'loader.top + 64 > self.slots':
            return self.wrap(node, 'arena_capacity_ns')
        if isinstance(node.test, ast.Call) and isinstance(node.test.func, ast.Name) and (node.test.func.id == 'getattr') and (len(node.test.args) >= 2) and isinstance(node.test.args[0], ast.Name) and (node.test.args[0].id == 'loader') and isinstance(node.test.args[1], ast.Constant) and (node.test.args[1].value == 'rngs'):
            return self.wrap(node, 'rng_store_ns')
        return self.generic_visit(node)

    def visit_While(self, node):
        if ast.unparse(node.test) == 'frame is not None':
            return self.wrap(node, 'recursion_frame_scan_ns')
        return self.generic_visit(node)

    def visit_For(self, node):
        if isinstance(node.iter, ast.Name) and node.iter.id == 'array_states':
            return self.wrap(node, 'array_snapshot_rollback_ns')
        if isinstance(node.iter, ast.Attribute) and isinstance(node.iter.value, ast.Name) and (node.iter.value.id == 'loader') and (node.iter.attr == 'blocks'):
            return self.wrap(node, 'staged_payload_copy_ns')
        return self.generic_visit(node)

    def visit_Assign(self, node):
        names = {part.id for target in node.targets for part in ast.walk(target) if isinstance(part, ast.Name)}
        if names in ({'code'}, {'generator'}):
            return self.wrap(node, 'binding_ns')
        if names == {'program', 'loaded'}:
            return self.wrap(node, 'program_lookup_ns')
        if names == {'array_states'}:
            return self.wrap(node, 'array_snapshot_rollback_ns')
        if names == {'frame', 'depth'}:
            return self.wrap(node, 'recursion_frame_scan_ns')
        if names == {'unloader'}:
            return self.wrap(node, 'unloader_init_ns')
        if names in ({'kind'}, {'codes'}):
            return self.wrap(node, 'result_prepare_ns')
        if any((isinstance(part, ast.Subscript) and isinstance(part.value, ast.Name) and (part.value.id in ('top', 'st')) for target in node.targets for part in ast.walk(target))):
            return self.wrap(node, 'control_writes_ns')
        return self.generic_visit(node)

def instrument_attempt(attempts):
    original = heap.Region.attempt
    source = textwrap.dedent(inspect.getsource(original))
    tree = ast.parse(source)
    if len(tree.body) != 1 or not isinstance(tree.body[0], ast.FunctionDef):
        raise RuntimeError('S18 expected one ordinary attempt definition')
    if tree.body[0].decorator_list:
        raise RuntimeError('S18 unexpected attempt decorator')
    transform = AttemptScopes()
    tree = ast.fix_missing_locations(transform.visit(tree))
    required = ('binding_ns', 'program_lookup_ns', 'array_snapshot_rollback_ns', 'arena_capacity_ns', 'staged_payload_copy_ns', 'control_writes_ns', 'recursion_frame_scan_ns', 'unloader_init_ns', 'result_prepare_ns', 'rng_store_ns')
    if any((transform.sites[label] == 0 for label in required)):
        raise RuntimeError('S18 source did not match all required phase sites')
    body = tree.body[0].body
    setup = ast.parse("assert getattr(ACTIVE, 'ledger', None) is None, 'Nested Region attempt unsupported'; _phase_aot = self.aot_calls; _phase_jit = self.jit_calls; _phase_ledger = Ledger(); ACTIVE.ledger = _phase_ledger").body
    finish = ast.parse("_phase_row = _phase_ledger.finish(); _phase_row['function'] = self.original.__qualname__; _phase_row['aot_calls'] = self.aot_calls - _phase_aot; _phase_row['jit_calls'] = self.jit_calls - _phase_jit; _phase_attempts.append(_phase_row); ACTIVE.ledger = None").body
    tree.body[0].body = setup + [ast.Try(body=body, handlers=[], orelse=[], finalbody=finish)]
    tree = ast.fix_missing_locations(tree)
    namespace = dict(heap.__dict__, _s18_scope=scope, Ledger=Ledger, ACTIVE=ACTIVE, _phase_attempts=attempts)
    generated = ast.unparse(tree)
    exec(compile(tree, '<S18 diagnostic Region.attempt>', 'exec'), namespace)
    replacement = namespace['attempt']
    replacement.__module__ = original.__module__
    replacement.__qualname__ = original.__qualname__
    return (replacement, dict(original_attempt_sha256=hashlib.sha256(source.encode()).hexdigest(), instrumented_ast_sha256=hashlib.sha256(generated.encode()).hexdigest(), inserted_sites=dict(transform.sites), semantics='Original attempt body and call frame retained; phase context managers finish entering before each body. No additional wrapper attempt frame is present while sys._getframe traverses callers.'))

def timed_method(cls,method,label):
 old=getattr(cls,method)
 @functools.wraps(old)
 def call(*args,**kwargs):
  with scope(label):return old(*args,**kwargs)
 setattr(cls,method,call)

def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def inventory(folder):
 return {p.relative_to(folder).as_posix():sha(p) for p in sorted(Path(folder).rglob('*')) if p.is_file() and '__pycache__' not in p.parts and p.suffix not in ('.pyc','.pyo','.nbi','.nbc')}

def gate(variant,checkpoint,label):
 assert variant and Path(variant).name==variant and variant not in ('.','..')
 lines=(W/'WAVE16-INPLACE-PLAN.md').read_text(encoding='utf-8-sig').splitlines()
 matches=[line for line in lines if line.startswith('CHECKPOINT '+str(checkpoint)+' RESULT:')]
 assert len(matches)==1, 'Explicit Step0 RESULT checkpoint required before this cohort'
 line=matches[0]; lower=line.lower()
 assert re.search(r'(?<![\w-])'+re.escape(variant)+r'(?![\w-])',line) and re.search(r'\bstep\s*0\b',lower) and re.search(r'\baccepted\b',lower) and 'unaccepted' not in lower, 'Checkpoint must explicitly accept Step0 for this source variant'
 owner=(W/'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
 assert 'wave16-inplace' in owner and 'purpose: '+label+'\n' in owner, 'Use run_locked with the exact label'
 return dict(checkpoint=checkpoint,line=line,ledger_sha256=sha(W/'WAVE16-INPLACE-PLAN.md'),lock_owner=owner)

def frozen_inputs(variant,name):
 source=D/'bases'/variant/'src';manifest=source.parent/'source-manifest.json'
 expected=json.loads(manifest.read_text(encoding='utf-8-sig'))
 assert inventory(source)==expected, 'Immutable source snapshot changed'
 folder=D/'artifacts'/variant/name;plan=folder/'plan.json'
 data=json.loads(plan.read_text(encoding='utf-8-sig'))
 script=W/'wave5-study/results/drivers'/(name+'.py')
 assert Path(data['script']).resolve()==script.resolve()
 for kind in ('aot','aot_regions'):
  section=data.get('plan',{}).get(kind)
  if section:
   assert Path(section['folder']).resolve()==folder.resolve()
   assert any(p.suffix in ('.pyd','.so','.dll') for p in folder.glob(section['module']+'*')), 'Missing immutable AOT extension'
 return dict(source_root=str(source),source_manifest_sha256=sha(manifest),source=expected,
             artifacts=inventory(folder),plan_sha256=sha(plan),script_sha256=sha(script),
             shim=inventory(W/'wave5-study/results/shim'))

def native_identity(native,digest):
 key=(id(native),digest)
 if key in NATIVE_IDENTITIES:return NATIVE_IDENTITIES[key]
 module=sys.modules.get(getattr(native,'__module__',''))
 filename=getattr(module,'__file__',None)
 export=getattr(native,'__name__',None)
 if not filename:
  owners=[m for m in list(sys.modules.values()) if type(m).__name__=='module' and vars(m).get(export) is native and vars(m).get('__file__')]
  assert len(owners)==1, 'Native export has ambiguous module ownership'
  filename=vars(owners[0])['__file__']
 path=str(Path(filename).resolve())
 assert path in ARTIFACT_HASHES, 'Native module is outside the sealed artifact set'
 event=dict(digest=digest,export=export,module=path,module_sha256=ARTIFACT_HASHES[path],mode='aot')
 NATIVE_IDENTITIES[key]=event
 return event

def native_call(native,event,args,kwargs,status=None):
 ledger=getattr(ACTIVE,'ledger',None)
 try:
  with scope('native_ns'):return native(*args,**kwargs)
 finally:
  if ledger is not None:
   row=dict(event,entry=len(ledger.native_events)+1)
   if status is not None:row['status_after']=int(status[0])
   ledger.native_events.append(row)

def install(plan):
 attempts=[];replacement,audit=instrument_attempt(attempts);heap.Region.attempt=replacement
 timed_method(heap.Region,'arrays','arrays_ns');timed_method(heap._Program,'guards_hold','guards_ns');timed_method(heap._Unloader,'result','result_ns');timed_method(heap._Unloader,'write_back','writeback_ns')
 old=heap.Region.load
 def load(region,*args,**kwargs):
  with scope('load_ns'):result=old(region,*args,**kwargs)
  program=args[0]
  if not getattr(program,'_wave16_phase_wrapped',False):
   assert program.ahead_of_time is True, 'Diagnostic must execute exact AOT only'
   native=program.run;event=native_identity(native,program.digest)
   def call(*args,**kwargs):return native_call(native,event,args,kwargs,args[3])
   program.run=call;program._wave16_phase_wrapped=True
  return result
 heap.Region.load=load
 for cls,method,label in [(lift.Lifted,'_complete','binding_ns'),(lift.Lifted,'_pack_call','load_ns'),(aot.AotLifted,'_prepare','program_lookup_ns'),(lift._Unit,'guards_hold','guards_ns'),(lift._Boundary,'__init__','boundary_init_ns'),(lift._Boundary,'discard','boundary_discard_ns'),(lift._Boundary,'write_back','writeback_ns'),(lift._Boundary,'rebuild','result_ns')]:timed_method(cls,method,label)
 for method,label in [('_scalar_shape','shape_prepare_ns'),('_suspect_result','result_validation_ns')]:timed_method(lift,method,label)
 entries={(str(Path(row.get('file',plan['script'])).resolve()),row['qualname']):row for row in plan.get('plan',{}).get('aot',{}).get('functions',[])}
 def run(lifted,packed):
  with scope('control_writes_ns'):lifted._flag[0]=0
  native=lifted._by_shape[lifted._last]
  entry=entries[str(Path(lifted.original.__code__.co_filename).resolve()),lifted.original.__qualname__]
  event=native_identity(native,entry['digest'])
  result=native_call(native,event,(lifted._flag,*packed),{},lifted._flag)
  assert result is None, 'Kernel lifted export returned a scalar; return-boxing attribution requires refinement'
  # Extension return-boxing stays inside native; this isolates Python status
  # conversion/result-tuple work. FFT's exported functions return None.
  with scope('result_ns'):return not lifted._flag[0],result
 aot.AotLifted._run=run
 oldcall=aot.AotLifted.__call__
 def call(lifted,*args,**kwargs):
  assert getattr(ACTIVE,'ledger',None) is None, 'Nested lifted call unsupported'
  before=lifted.compiled_calls;ledger=Ledger();ACTIVE.ledger=ledger
  try:return oldcall(lifted,*args,**kwargs)
  finally:
   row=ledger.finish();row['function']=lifted.original.__qualname__;row['aot_calls']=lifted.compiled_calls-before;row['jit_calls']=0;attempts.append(row);ACTIVE.ledger=None
 aot.AotLifted.__call__=call
 audit['lift_scopes']={'binding_ns':'Lifted._complete','load_ns':'Lifted._pack_call excluding named nested scopes; includes actual payload copying','program_lookup_ns':'AotLifted._prepare shape/export lookup','shape_prepare_ns':'lift._scalar_shape','boundary_init_ns':'_Boundary.__init__','boundary_discard_ns':'_Boundary.discard','guards_ns':'_Unit.guards_hold','result_validation_ns':'lift._suspect_result','control_writes_ns':'status reset','result_ns':'Python status/result tuple and _Boundary.rebuild','writeback_ns':'_Boundary.write_back','native_ns':'actual AOT extension invocation including its return boxing','bookkeeping_ns':'remaining dispatch/branches/shape tables/counters and observer transitions'}
 audit['lift_not_applicable']=['arrays_ns (Region arena views)','array_snapshot_rollback_ns (Region array snapshots)','arena_capacity_ns (Region arena growth)','staged_payload_copy_ns (Region staging)','recursion_frame_scan_ns (Region scan)','unloader_init_ns (Region unloader)','rng_store_ns (Region RNG export)']
 audit['outside_attempt']='Runner wrapper/AOT module construction and imports occur outside call timers; no subtraction from separate whole-process results.'
 return attempts,audit

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('name',choices=('barnes_hut','scimark','raytrace'))
 parser.add_argument('--variant',default='integration-cache')
 parser.add_argument('--mode',choices=('uninstrumented','instrumented'),required=True)
 parser.add_argument('--output',type=Path,required=True)
 parser.add_argument('--resets',type=int,default=5)
 parser.add_argument('--step0-result-checkpoint',type=int,required=True)
 parser.add_argument('--lock-label',required=True)
 options=parser.parse_args();assert options.resets>0
 accepted=gate(options.variant,options.step0_result_checkpoint,options.lock_label)
 frozen=frozen_inputs(options.variant,options.name)
 output=options.output.resolve();assert output.is_relative_to(D/'bounds') and not output.exists()
 prefix=Path(os.environ['PYTHONPYCACHEPREFIX']).resolve();assert prefix.is_relative_to(output.parent)
 sys.path[:0]=[str(W/'wave5-study/results/shim'),str(D/'bases'/options.variant/'src')]
 class NoNumba:
  def find_spec(self,fullname,path=None,target=None):
   if fullname=='numba' or fullname.startswith('numba.'):raise RuntimeError('Kernel boundary observer forbids JIT/compiler imports')
   return None
 sys.meta_path.insert(0,NoNumba())
 global heap,lift,aot
 from recompyler import heap,lift,aot
 from recompyler.runner import run_script
 plan_path=D/'artifacts'/options.variant/options.name/'plan.json';plan=json.loads(plan_path.read_text(encoding='utf-8-sig'))
 ARTIFACT_HASHES.update({str((plan_path.parent/relative).resolve()):digest for relative,digest in frozen['artifacts'].items()})
 attempts,audit=install(plan) if options.mode=='instrumented' else ([],{})
 report=run_script(W/'wave5-study/results/drivers'/(options.name+'.py'),[str(options.resets)],plan_path,True)
 assert report['exit_code'] in (None,0) and not report['not_found'] and not report['batches'] and not report.get('batch_failures')
 assert all(r['compiled_calls']==r['aot_calls'] and not r['fallback_calls'] and not r['jit_calls'] for r in report['functions'])
 assert frozen==frozen_inputs(options.variant,options.name), 'Immutable inputs/artifacts changed'
 loaded={}
 for name,module in list(sys.modules.items()):
  filename=getattr(module,'__file__',None)
  if filename and (name=='recompyler' or name.startswith('recompyler.')):
   path=Path(filename).resolve();relative=path.relative_to(D/'bases'/options.variant/'src').as_posix()
   assert frozen['source'][relative]==sha(path)
   loaded[name]=dict(path=str(path),sha256=sha(path))
 assert not any(n=='numba' or n.startswith('numba.') for n in sys.modules)
 result=dict(variant=options.variant,mode=options.mode,resets=options.resets,accepted_step0=accepted,numba_imported=False,
             timing_scope='Driver printed times are minima across complete resets. Per-attempt diagnostic components cover all resets, include cold preparation/retries and observer overhead, and are not additive to the printed minima.',
             frozen=frozen,loaded_product_modules=loaded,attempts=attempts,scope_audit=audit,report=report,
             diagnostic_only=True,selection_override=True,timing_eligible=False,
             limitations=['Observer overhead retained; exclusive integer phases partition only their own attempt.',
              'FFT extension return boxing remains in native; FFT returns None, Python status/result tuple is isolated in result_ns.',
              'Region native entries include growth retries: each entry records digest/export/module/mode/status; do not divide attempt work by retries or pool cold/warm contexts.',
              'All named other scopes and remaining bookkeeping are explicit; zero non-applicable Region components on FFT do not claim zero setup cost.',
              'No kernel/component timing is subtracted from separately measured whole-call or whole-process results.'])
 with output.open('x',encoding='utf-8') as stream:json.dump(result,stream,indent=2);stream.write('\n')

if __name__=='__main__':main()
