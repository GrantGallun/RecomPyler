"""Isolate review counterexamples after bypassing only the configure defect.
The extra shlex.deque global is diagnostic scaffolding, never an accepted bound.
"""
import builtins, collections, json, shlex, sys
from pathlib import Path
attempt=Path(sys.argv[1]);sys.path[:0]=[str(attempt),str(Path(__file__).parent)]
import wave17_charloop as ext
from workload import token
shlex.deque=collections.deque
ext.configure(token)
rows=[]
for char in ['a','\u00e9','\u0100','\u03bb','\U0001f600']:
    for text in [''.join([char,'']), '"'+char+'"', '\\'+char]:
        expected=token(text)
        rows.append({'text':ascii(text),'expected_alias':expected is text,'boxed_alias':ext.boxed(text) is text,'borrowed_alias':ext.borrowed(text) is text,'expected':ascii(expected),'boxed':ascii(ext.boxed(text)),'borrowed':ascii(ext.borrowed(text))})
real_import=builtins.__import__;calls=[]
def hooked(*args,**kwargs):
    calls.append(args[0]);return real_import(*args,**kwargs)
builtins.__import__=hooked
try:
    expected=token('abc');original_calls=list(calls);calls.clear()
    observed=ext.borrowed('abc');borrowed_calls=list(calls)
finally:
    builtins.__import__=real_import
witness={'scaffolding':'temporary unused shlex.deque global bypasses only initial configure defect','identity':rows,'import_context':{'original_calls':original_calls,'borrowed_calls':borrowed_calls,'same_result':expected==observed}}
assert original_calls==['collections'] and borrowed_calls==[],witness
(attempt/'context-red.json').write_text(json.dumps(witness,indent=2))
print('RED: borrowed skips observable deferred import; identity probes retained',flush=True)
