from pathlib import Path
import copy,json,random,sys
sys.path.insert(0,str(Path(__file__).resolve().parent));import run_c as r
sys.path.insert(0,str(r.R/'matrix/temp/s34'));import wave17_s34 as ext
for case in r.cases:copy.deepcopy(case[3]())
ext.configure(tuple(c[1] for c in r.cases),r.chaos['GVector'],random.Random,r.mdp['halfstate_t'],r.mdp['fixeddata_t'])
ns=r.jsonloads['mutate_dict'].__globals__;old=ns['sys'];events=[]
class Hook:
    @property
    def maxsize(self):events.append('maxsize');return old.maxsize
ns['sys']=Hook()
try:
    expected=r.jsonloads['mutate_dict']({'a':1,'b':2},random.Random(5));reference=list(events);events.clear()
    actual=ext.dict_loop({'a':1,'b':2},random.Random(5));got=list(events)
finally:ns['sys']=old
result={'reference_events':reference,'c_events':got,'same_result':expected==actual,'identical':reference==got,'counters':ext.stats()}
print(json.dumps(result));(r.D/('sys-order-'+sys.argv[1]+'.json')).write_text(json.dumps(result,indent=2))

old_str=ns.get('str');has_str='str' in ns;events.clear()
class Mapping:
    def keys(self):events.append('keys');return ['a','b']
    def __getitem__(self,key):events.append(key);ns['str']=lambda value:'rebound';return 1
try:
    expected=r.observe(r.jsonloads['mutate_dict'],(Mapping(),random.Random(5)));reference=list(events);events.clear()
    if has_str:ns['str']=old_str
    else:ns.pop('str',None)
    actual=r.observe(ext.dict_loop,(Mapping(),random.Random(5)));got=list(events)
finally:
    if has_str:ns['str']=old_str
    else:ns.pop('str',None)
result={'reference_error':expected[1],'c_error':actual[1],'reference_events':reference,'c_events':got,'identical':r.snapshot(expected)==r.snapshot(actual) and reference==got,'counters':ext.stats()}
print(json.dumps(result));(r.D/('mapping-rebind-'+sys.argv[1]+'.json')).write_text(json.dumps(result,indent=2))

class Key(str):
    __hash__=str.__hash__
    def __eq__(self,other):events.append(str(self));return False
obj=r.chaos['GVector'](1.,2.,3.);obj.__dict__={Key('x'):1.,'y':2.,'z':3.}
events.clear();expected=r.observe(r.chaos['GVector'].__str__,(obj,));reference=list(events);events.clear();actual=r.observe(ext.string_build,(obj,));got=list(events)
result={'reference_error':expected[1],'c_error':actual[1],'reference_events':reference,'c_events':got,'identical':expected[1]==actual[1] and reference==got,'counters':ext.stats()}
print(json.dumps(result));(r.D/('attribute-key-'+sys.argv[1]+'.json')).write_text(json.dumps(result,indent=2))
rs=random.Random(5);rs.__dict__[Key('random')]=object();events.clear();expected=r.jsonloads['mutate_dict']({'a':1,'b':2},rs);reference=list(events);rs.seed(5);events.clear();actual=ext.dict_loop({'a':1,'b':2},rs);got=list(events)
result={'reference_events':reference,'c_events':got,'same_result':expected==actual,'identical':reference==got and expected==actual,'counters':ext.stats()}
print(json.dumps(result));(r.D/('random-key-'+sys.argv[1]+'.json')).write_text(json.dumps(result,indent=2))

class TemporaryFixed:
    maxhp=63
    def __del__(self):events.append('fixed-finalized')
class State:
    @property
    def fixed(self):events.append('fixed');return TemporaryFixed()
    @property
    def hp(self):events.append('hp');return 63
    def _replace(self,**kw):events.append('replace');return kw['hp']
events.clear();expected=r.mdp['applyHPChange'](State(),-17);reference=list(events);events.clear();actual=ext.mixed_calls(State(),-17);got=list(events)
result={'reference_events':reference,'c_events':got,'same_result':expected==actual,'identical':reference==got and expected==actual,'counters':ext.stats()}
print(json.dumps(result));(r.D/('temporary-lifetime-'+sys.argv[1]+'.json')).write_text(json.dumps(result,indent=2))

class Operand:
    def __init__(self,name):self.name=name
    def __del__(self):events.append('del-'+self.name)
class LateError:
    @property
    def x(self):return Operand('x')
    @property
    def y(self):return Operand('y')
    @property
    def z(self):raise ValueError('z failed')
events.clear();expected=r.observe(r.chaos['GVector'].__str__,(LateError(),));reference=list(events);events.clear();actual=r.observe(ext.string_build,(LateError(),));got=list(events)
result={'reference_error':expected[1],'c_error':actual[1],'reference_events':reference,'c_events':got,'identical':expected[1]==actual[1] and reference==got,'counters':ext.stats()}
print(json.dumps(result));(r.D/('operand-unwind-'+sys.argv[1]+'.json')).write_text(json.dumps(result,indent=2))
