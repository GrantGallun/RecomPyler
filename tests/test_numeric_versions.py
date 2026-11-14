import math,struct
import pytest
from recompyler import heap

class Pair:
 def __init__(self,x,y):self.x=x;self.y=y

def multiply(p):return p.x*p.y

def reduce_pair(p):return p.x*p.x+p.y*p.y

def magnitude(p):return math.sqrt(reduce_pair(p))

def observed_product(a,b):
 marker=b.x+0.0
 return multiply(a)

def observed_magnitude(a,b):
 marker=b.x+0.0
 return magnitude(a)

def divide_pair(p):return p.x/p.y

def observed_division(a,b):
 marker=b.x+0.0
 return divide_pair(a)

def mutate_pair(p):
 p.x=1
 return p.x*p.y

def observed_mutation(a,b):
 marker=b.x+0.0
 return mutate_pair(a)

def reinitialize(p):
 p.__init__(1,2)
 return p.x*p.y

def observed_reinitialization(a,b):
 marker=b.x+0.0
 return reinitialize(a)

def internal_integer(p):
 value=9007199254740993
 wrong=value==9007199254740992
 return wrong or p.x>0

def observed_internal(a,b):
 marker=b.x+0.0
 return internal_integer(a)

def bits(x):return struct.pack('d',x)

def test_float_guard_versions_and_integer_miss_preserve_type():
 r=heap.Region(observed_product)
 for a,b in ((Pair(2.0,3.0),Pair(1,2)),(Pair(2,3),Pair(1.0,2.0)),(Pair(0,-1),Pair(1.0,2.0)),(Pair(-0.0,1.0),Pair(1,2))):
  expected=observed_product(a,b);actual=r(a,b)
  assert actual==expected and type(actual) is type(expected)
  if type(expected)is float:assert bits(actual)==bits(expected)
 assert r.compiled_calls>0
 assert any(p.numeric_report['versions'] for p in r.programs.values())
 assert '_kf_' in r.latest.source

def test_nan_infinity_signed_zero_and_division_errors():
 r=heap.Region(observed_division)
 for a,b in ((Pair(-0.0,2.0),Pair(1,2)),(Pair(float('inf'),2.0),Pair(1,2)),(Pair(float('nan'),1.0),Pair(1,2)),(Pair(7,2),Pair(1.0,2.0))):
  expected=observed_division(a,b);actual=r(a,b)
  assert (math.isnan(actual) and math.isnan(expected)) or bits(actual)==bits(expected)
 with pytest.raises(ZeroDivisionError):r(Pair(1.0,0.0),Pair(1,2))
 assert r(Pair(6.0,2.0),Pair(1,2))==3.0

def test_large_integer_and_internal_integer_stay_exact():
 r=heap.Region(observed_product)
 assert r(Pair(2**53+1,1),Pair(1.0,2.0))==2**53+1
 assert type(r(Pair(2**53+1,1),Pair(1.0,2.0)))is int
 s=heap.Region(observed_internal)
 assert s(Pair(-1.0,1.0),Pair(1,2))is False
 assert s(Pair(1.0,1.0),Pair(1,2))is True

def test_later_integer_store_and_reinit_are_not_assumed_float():
 for fn in (observed_mutation,observed_reinitialization):
  r=heap.Region(fn);a=Pair(3.0,-0.0);b=Pair(1,2)
  expected_a=Pair(3.0,-0.0);expected=fn(expected_a,b)
  actual=r(a,b)
  assert actual==expected and type(actual)is type(expected)
  assert type(a.x)is type(expected_a.x) and a.x==expected_a.x
  if r.latest is not None:assert not r.latest.numeric_report['versions']

def test_guarded_caller_calls_fixed_callee_without_retesting():
 r=heap.Region(observed_magnitude);assert r(Pair(3.0,4.0),Pair(1,2))==5.0
 report=r.latest.numeric_report
 assert report['versions'] and report['direct_edges']
 assert r(Pair(3,4),Pair(1.0,2.0))==5.0


def rebound_scalar(x):
 x=0
 return x

def observed_rebound(a,b):
 marker=b.x+0.0
 return rebound_scalar(a.x)

def test_rebound_scalar_tag_is_not_an_entry_constant():
 r=heap.Region(observed_rebound)
 actual=r(Pair(-0.0,2.0),Pair(1,2))
 assert actual==0 and type(actual)is int
 assert all('rebound_scalar' not in row['function'] for row in r.latest.numeric_report['versions'])


def late_boolean(p,flag):
 value=p.x*p.y
 if flag:return value+1.0
 flag=True
 return value+2.0

def observed_late_boolean(a,b,flag):
 marker=b.x+0.0
 return late_boolean(a,flag)

def test_boolean_entry_definition_survives_later_assignment():
 r=heap.Region(observed_late_boolean)
 for flag in (False,True):
  assert r(Pair(2.0,3.0),Pair(1,2),flag)==observed_late_boolean(Pair(2.0,3.0),Pair(1,2),flag)


def test_boolean_folder_preserves_short_circuiting():
 import ast
 from recompyler.numeric_versions import fold_boolean_flags
 tree=ast.parse("def f():\n flag=False and unknown()\n if flag:return 1\n return 2").body[0]
 folded=ast.fix_missing_locations(fold_boolean_flags(tree));ns={}
 exec(compile(ast.Module(body=[folded],type_ignores=[]),'<test>','exec'),ns)
 assert ns['f']()==2 and 'unknown()' not in ast.unparse(folded)
 tree=ast.parse("def f():\n flag=unknown() and False\n return flag").body[0]
 assert 'unknown()' in ast.unparse(fold_boolean_flags(tree))


def test_version_preserves_exact_decorator_contract():
 class SourceOnly(dict):
  def __bool__(self):return True
  def get(self,key,default=None):return True
 p=heap.Region(observed_product,ahead_of_time=SourceOnly()).program_for((Pair(2.0,3.0),Pair(1,2)))
 assert p.numeric_report['versions']
 for info in p.order:
  if getattr(info,'numeric_fixed',False):
   prefix=info.source.split('\ndef ',1)[0]
   assert prefix in (heap._DECORATOR,heap._INLINED)


def test_dominating_boolean_annihilator_drops_only_inert_load():
 import ast
 from recompyler.numeric_versions import fold_boolean_flags
 text="def f(x):\n flag=x!=0\n result=flag and False\n if result:return 1\n return 2"
 tree=fold_boolean_flags(ast.parse(text).body[0]);assert 'if result' not in ast.unparse(tree)
 for text in ("def f(x):\n if x:flag=x!=0\n return flag and False", "def f(x):\n return x and False", "def f():\n return unknown() and False"):
  tree=fold_boolean_flags(ast.parse(text).body[0]);assert 'and False' in ast.unparse(tree)


def repeated_conversion(p,n):
 p.x=p.x+1.0
 return n/2+n/3+n/4

def rebound_conversion(p,n):
 a=n/2
 n=2**53+1
 return a+n/3

def test_repeated_conversion_guard_on_immutable_scalar_with_mutation():
 class SourceOnly(dict):
  def __bool__(self):return True
  def get(self,key,default=None):return True
 p=heap.Region(repeated_conversion,ahead_of_time=SourceOnly()).program_for((Pair(1.0,2.0),4))
 assert p.numeric_report['versions']
 fixed=[i.source for i in p.order if getattr(i,'numeric_fixed',False) and 'repeated_conversion' in i.name]
 assert fixed and '9007199254740992' not in fixed[0]
 r=heap.Region(repeated_conversion)
 for n in (4,2**53,-2**53,2**53+1,-2**53-1):
  a=Pair(1.0,2.0);b=Pair(1.0,2.0)
  assert bits(r(a,n))==bits(repeated_conversion(b,n)) and bits(a.x)==bits(b.x)
 s=heap.Region(rebound_conversion,ahead_of_time=SourceOnly()).program_for((Pair(1.0,2.0),4))
 assert s is None or not s.numeric_report['versions']
 t=heap.Region(rebound_conversion);assert bits(t(Pair(1.0,2.0),4))==bits(rebound_conversion(Pair(1.0,2.0),4))


def recursive_mutating(p,n):
 p.x+=n/2
 if n>0:recursive_mutating(p,n-1)

def test_recursive_void_guard_wrapper_keeps_effects():
 r=heap.Region(recursive_mutating);a=Pair(1.0,2.0);b=Pair(1.0,2.0)
 recursive_mutating(b,3);assert r(a,3)is None and bits(a.x)==bits(b.x)
 assert r.compiled_calls==1,r.problem

def test_recursive_tuple_guard_wrapper_preserves_flat_returns():
 from unittest import mock
 from test_heap_zero_facts import recursive_nonzero
 with mock.patch.object(heap,'_cached_module',lambda source:None):
  r=heap.Region(recursive_nonzero);assert r(4,2.5,0)==recursive_nonzero(4,2.5,0)
  assert r.compiled_calls==1,r.problem
