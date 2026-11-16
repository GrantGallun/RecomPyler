"""Strict full-wrapper checks for the diagnostic; no timings in this file."""
import builtins, collections, gc, hashlib, importlib._bootstrap as bootstrap, io, json, os, random, shlex, subprocess, sys, types
from pathlib import Path
out=Path(sys.argv[1]).resolve();R=out.parents[2];sys.path[:0]=[str(out),str(R/'src')]
sys.stdin=io.StringIO("")  # controlled EOF for the None guard-miss case; never touch an external stream
from bridge import compile_bridges
entries,dispatchers,aot=compile_bridges(out)
import wave17_charloop as ext
import workload
assert 'importtime' not in sys._xoptions and os.environ.get('PYTHONPROFILEIMPORTTIME') in (None,'','0')
# PEP669 observers are an explicit diagnostic precondition, not covered by
# the C trace/profile guard. No normal/global or relevant local events are on.
observed_codes=[workload.token.__code__,shlex.shlex.__init__.__code__,shlex.shlex.read_token.__code__,shlex.shlex.punctuation_chars.fget.__code__,bootstrap._handle_fromlist.__code__]
assert all(sys.monitoring.get_events(tool)==0 and all(sys.monitoring.get_local_events(tool,code)==0 for code in observed_codes) for tool in range(6))
assert getattr(sys.flags,'gil',1)==1
ext.configure(workload.token)
routes=[('boxed-C',ext.boxed),('borrowed-C',ext.borrowed),('boxed-JIT',entries['boxed']),('borrowed-JIT',entries['borrowed']),('boxed-AOT',aot.boxed),('borrowed-AOT',aot.borrowed)]
constants=shlex.shlex.read_token.__code__.co_consts
messages=[v for v in constants if type(v) is str and v.startswith('No ')]
def observe(fn,text):
    try:
        result=fn(text)
        return {'kind':'result','type':type(result),'value':result,'input_alias':result is text,'cached_character_alias':type(result) is str and len(result)==1 and ord(result)<256 and result is chr(ord(result))}
    except Exception as exc:
        return {'kind':'exception','type':type(exc),'message':str(exc),'args':exc.args,'message_owner':[bool(exc.args) and exc.args[0] is msg for msg in messages]}
report={'complete':False,'gates':[],'ownership':[],'guard_misses':[]}
def check(index,text):
    expected=observe(workload.token,text)
    for name,fn in routes:
        before=ext.stats();got=observe(fn,text);after=ext.stats()
        delta=tuple(b-a for a,b in zip(before,after))
        expected_delta=(1,0,0) if name.startswith('boxed') else (0,1,0)
        if type(text) is not str:expected_delta=(0,0,1)
        row={'case':index,'route':name,'identical':got==expected and delta==expected_delta,'route_delta':delta}
        if not row['identical']:row.update(reference=expected,observed=got,text=ascii(text));print('MISMATCH',row,flush=True)
        report['gates'].append(row)
    (out/'behavior.json').write_text(json.dumps(report,indent=2,default=lambda item:{'type_name':item.__module__+'.'+item.__qualname__} if isinstance(item,type) else repr(item)))
cases=['',' ','\t\r\n','abc','a b','# ignored\nabc','abc#comment\nrest','\"\"',"''",'\"a b\"',"'a b'",'a\"b\"c','\\a','a\\ b','\"a\\q\"','\"a\\\"b\"','\"a\\\\b\"',"'a\\b'",'\"unterminated','\\','a\\','\"a\\','a;b',';abc','\x00','a\x00b','\"a\x00b\"',None,3,b'abc']
for char in ['a','\u00e9','\u0100','\u03bb','\ud800','\U0001f600']:
    cases.extend([''.join([char,'']), '"'+char+'"', '\\'+char, "'"+char+"'",char+'a','a'+char])
class Sub(str):pass
cases.extend([Sub('abc'),Sub('"\u03bb"')])
rng=random.Random(170038)
alphabet='abcXYZ019_ \t\r\n#\\\'";\x00\u00e9\u0100\u03bb\ud800\U0001f600'
cases.extend(''.join(rng.choices(alphabet,k=rng.randrange(0,100))) for _ in range(600))
for n in [20,127,4096,65536]:
    cases.extend(['a'*n,'"'+'\u03bb'*n+'"','"'+'\U0001f600'*n+'"'])
for i,text in enumerate(cases):check(i,text)
assert all(row['identical'] for row in report['gates'])
# Native input pins and new-result owners must balance on every success/error path.
for name,fn in routes:
    message_refs=[sys.getrefcount(msg) for msg in messages]
    for text in [''.join(['long','dynamic','word']),'"\u03bb\U0001f600"','"bad','\\',None]:
        observe(fn,text);before=sys.getrefcount(text)
        for _ in range(1000):observe(fn,text)
        after=sys.getrefcount(text);assert before==after,(name,ascii(text),before,after)
    text='"'+''.join(['wide','\u03bb\U0001f600'])*4+'"';result=fn(text)
    assert sys.getrefcount(result)==2,(name,'unexpected retained output',sys.getrefcount(result))
    assert message_refs==[sys.getrefcount(msg) for msg in messages],(name,'exception message owner leaked')
    report['ownership'].append({'route':name,'success_error_refs_stable':True,'fresh_output_refs':2})
# Each context change is restored before trying a different witness. The callback
# event sequence is compared on original and compiled execution separately.
real_import=builtins.__import__;real_deque=collections.deque;original_class=workload.LEXER
init=shlex.shlex.__init__;old_defaults=init.__defaults__;old_code=workload.token.__code__
events=[]
def hook(*args,**kw):events.append(('import',args[0]));return real_import(*args,**kw)
def deque_hook(*args,**kw):events.append(('deque',len(args)));return real_deque(*args,**kw)
class Alternate:
    def __init__(self,text,posix=False):events.append(('alternate',text,posix))
    def read_token(self):events.append(('read_token',));return 'alternate'
def other(text):return 'changed-wrapper'
def other_read(self):return 'changed-reader'
def other_init(self,*args,**kw):self.read_token=lambda:'changed-constructor'
def other_getter(self):return 'changed-punctuation'
read=shlex.shlex.read_token;getter=shlex.shlex.punctuation_chars.fget
read_code=read.__code__;init_code=init.__code__;getter_code=getter.__code__
stringio=shlex.StringIO;error_binding=shlex.__dict__.get('ValueError');had_error_binding='ValueError' in shlex.__dict__
def restore_error():
    if had_error_binding:shlex.ValueError=error_binding
    else:del shlex.ValueError
def module_replacement():
    module=types.ModuleType('collections');module.deque=deque_hook;return module
old_module=sys.modules['collections']
spec=collections.__spec__;initializing=spec._initializing
class Spec:
    @property
    def _initializing(self):events.append(('spec-property',));return False
class Truth:
    def __bool__(self):events.append(('spec-bool',));return False
fromlist=bootstrap._handle_fromlist;fromlist_code=fromlist.__code__
fromlist_kw=fromlist.__kwdefaults__;fromlist_kw_copy=dict(fromlist_kw)
real_hasattr=builtins.hasattr
def hasattr_hook(*args):events.append(('hasattr',args[1]));return real_hasattr(*args)
def other_fromlist(module,fromlist,import_,*,recursive=False):return module
mutations=[('spec-property',lambda:setattr(collections,'__spec__',Spec()),lambda:setattr(collections,'__spec__',spec)),('initializing-truth',lambda:setattr(spec,'_initializing',Truth()),lambda:setattr(spec,'_initializing',initializing)),('spec-class',lambda:setattr(type(spec),'diagnostic_extra',1),lambda:delattr(type(spec),'diagnostic_extra')),('fromlist-code',lambda:setattr(fromlist,'__code__',other_fromlist.__code__),lambda:setattr(fromlist,'__code__',fromlist_code)),('fromlist-keyword-defaults',lambda:fromlist_kw.__setitem__('recursive',True),lambda:fromlist_kw.update(fromlist_kw_copy)),('hasattr-binding',lambda:setattr(builtins,'hasattr',hasattr_hook),lambda:setattr(builtins,'hasattr',real_hasattr)),('reader-code',lambda:setattr(read,'__code__',other_read.__code__),lambda:setattr(read,'__code__',read_code)),('constructor-code',lambda:setattr(init,'__code__',other_init.__code__),lambda:setattr(init,'__code__',init_code)),('punctuation-getter-code',lambda:setattr(getter,'__code__',other_getter.__code__),lambda:setattr(getter,'__code__',getter_code)),('StringIO-binding',lambda:setattr(shlex,'StringIO',lambda text:io.StringIO('alternate')),lambda:setattr(shlex,'StringIO',stringio)),('ValueError-binding',lambda:setattr(shlex,'ValueError',RuntimeError),restore_error),('builtin-import',lambda:setattr(builtins,'__import__',hook),lambda:setattr(builtins,'__import__',real_import)),('collections-deque',lambda:setattr(collections,'deque',deque_hook),lambda:setattr(collections,'deque',real_deque)),('collections-module',lambda:sys.modules.__setitem__('collections',module_replacement()),lambda:sys.modules.__setitem__('collections',old_module)),('lexer-binding',lambda:setattr(workload,'LEXER',Alternate),lambda:setattr(workload,'LEXER',original_class)),('class-dictionary',lambda:setattr(original_class,'diagnostic_extra',1),lambda:delattr(original_class,'diagnostic_extra')),('constructor-defaults',lambda:setattr(init,'__defaults__',tuple(list(old_defaults))),lambda:setattr(init,'__defaults__',old_defaults)),('wrapper-code',lambda:setattr(workload.token,'__code__',other.__code__),lambda:setattr(workload.token,'__code__',old_code)),('gc-callback',lambda:gc.callbacks.append(gc_probe),lambda:gc.callbacks.remove(gc_probe))]
def gc_probe(*args):pass
for witness,change,restore in mutations:
    change()
    try:
        for name,fn in routes:
            events.clear();expected=observe(workload.token,'abc');expected_events=list(events)
            events.clear();before=ext.stats();got=observe(fn,'abc');after=ext.stats()
            actual_events=list(events);delta=tuple(b-a for a,b in zip(before,after))
            row={'witness':witness,'route':name,'identical':got==expected and actual_events==expected_events and delta==(0,0,1),'events':actual_events,'expected_events':expected_events,'route_delta':delta}
            report['guard_misses'].append(row)
            if not row['identical']:print('MISMATCH',row,got,expected,flush=True)
    finally:restore()
(out/'behavior.json').write_text(json.dumps(report,indent=2,default=lambda item:{'type_name':item.__module__+'.'+item.__qualname__} if isinstance(item,type) else repr(item)))
assert all(row['identical'] for row in report['guard_misses'])
# Active frame observers are outside the native ceiling precondition. The
# guard must still delegate; compare the original wrapper's call events and
# semantic result, without claiming native entry frames are Python frames.
for observer,setter in [('trace',sys.settrace),('profile',sys.setprofile)]:
    def watch(frame,event,arg):
        if frame.f_code is workload.token.__code__ and event=='call':events.append(('token-call',))
        return watch
    for name,fn in routes:
        setter(watch)
        try:
            events.clear();expected=observe(workload.token,'abc');expected_events=list(events)
            events.clear();before=ext.stats();got=observe(fn,'abc');delta=tuple(b-a for a,b in zip(before,ext.stats()))
            row={'witness':observer,'route':name,'identical':got==expected and events==expected_events and delta==(0,0,1),'target_events':list(events),'route_delta':delta}
        finally:setter(None)
        report['guard_misses'].append(row)
        assert row['identical'],row
child=subprocess.run([sys.executable,str(out/'fresh.py'),str(out)],text=True,capture_output=True)
report['fresh_aot']={'exit_code':child.returncode,'stdout':child.stdout,'stderr':child.stderr};assert child.returncode==0,report['fresh_aot']
report['reference']={'path':shlex.__file__,'sha256':hashlib.sha256(Path(shlex.__file__).read_bytes()).hexdigest()}
report['complete']=True;(out/'behavior.json').write_text(json.dumps(report,indent=2,default=lambda item:{'type_name':item.__module__+'.'+item.__qualname__} if isinstance(item,type) else repr(item)))
print(json.dumps({'complete':True,'gates':len(report['gates']),'guard_misses':len(report['guard_misses']),'ownership_groups':len(report['ownership']),'fresh_aot':report['fresh_aot']}),flush=True)
