"""Observe selected scalar object identity through the public lift API."""
from pathlib import Path
import json,sys
R=Path(__file__).resolve().parents[1];sys.path.insert(0,str(R/'matrix'))
import run_matrix as m
from catalogue import Case
rows=[]
for label,op,args in [('float_or','or',(float('1.25'),0.0)),('negative_zero_and','and',(float('-0.0'),1.0)),('int_or','or',(int('1000'),0)),('float_right','or',(0.0,float('1.25')))]:
    c=Case('review.identity.'+label,'review','return a '+op+' b','a,b')
    module,_=m.fixture(c);fn=module.construct;wrapper=m.lift(fn);expected=fn(*args);got=wrapper(*args)
    before=[expected is a for a in args];after=[got is a for a in args]
    rows.append({'id':c.id,'operator':op,'expected_aliases':before,'compiled_aliases':after,'native_calls':wrapper.compiled_calls,'fallback_calls':wrapper.fallback_calls,'verdict':'wrong' if before!=after else 'native' if wrapper.compiled_calls else 'declined'})
    print(rows[-1],flush=True)
(R/sys.argv[1]).write_text(json.dumps(rows,indent=2))
