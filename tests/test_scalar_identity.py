"""An R8 no-op certificate skips work without skipping reachable optimizations."""
import ast
import pytest
from recompyler import heap,scalar

class Cell:
    def __init__(self,value):self.value=value
class Left(Cell):pass
class Right(Cell):pass

def plus(value):return value+2
def loops(count):
    total=0
    for i in range(count):total+=plus(i)
    return total

def publish(value,output):
    made=Cell(value)
    output.append(made)
    output.append(made)
    return made.value

def read(cell):return cell.value

def polymorphic(flag):
    if flag:made=Left(4)
    else:made=Right(4)
    return made.value

def make(value):return Cell(value)
def consume(cell):return cell.value
def local(value):
    made=Cell(value)
    return consume(made)
def fresh(value):
    made=make(value)
    return made.value+1

class SourceOnly(dict):
    def __bool__(self):return True
    def get(self,key,default=None):return True

def prepare(fn,args):
    region=heap.Region(fn,SourceOnly())
    program=region.program_for(args)
    assert program is not None,region.problem
    return program

def graph(program):return {i.name:sorted(x.name for x in calls) for i,calls in program.calls.items()}
def semantic_source(program):return ast.dump(ast.parse(program.source),include_attributes=False)

@pytest.mark.parametrize('fn,args',[(loops,(6,)),(publish,(7,[])),(read,(Cell(2),)),(polymorphic,(True,))])
def test_identity_proof_matches_full_r8_ir_and_metadata(monkeypatch,fn,args):
    optimized=prepare(fn,args)
    assert optimized.scalar_report.get('identity_noop') is True
    with monkeypatch.context() as patch:
        patch.setattr(scalar.ScalarReplacer,'_identity_proof',lambda self:None,raising=False)
        reference=prepare(fn,args)
    assert semantic_source(optimized)==semantic_source(reference)
    assert graph(optimized)==graph(reference)
    assert {i.name:i.recursive for i in optimized.order}=={i.name:i.recursive for i in reference.order}
    for key in ['removed_sites','blocked','field_clones','fresh_return_clones','fresh_sites','classes_enabled']:
        assert optimized.scalar_report.get(key)==reference.scalar_report.get(key)
    facts=[f for (family,key),f in optimized.facts.answers.items() if family=='F5' and key[0]=='scalar-identity']
    assert len(facts)==1 and facts[0].state=='proven'
    assert optimized.escape_analysis.summaries==reference.escape_analysis.summaries

@pytest.mark.parametrize('fn,field',[(local,'removed_sites'),(fresh,'fresh_return_clones')])
def test_representable_virtual_seed_retains_r8(fn,field):
    program=prepare(fn,(7,))
    assert not program.scalar_report.get('identity_noop',False)
    assert program.scalar_report[field]

@pytest.mark.parametrize('fn,args,expected',[(loops,(6,),27),(read,(Cell(2),),2),(polymorphic,(False,),4),(local,(7,),7),(fresh,(7,),8)])
def test_identity_rule_and_fallback_complete_natively(fn,args,expected):
    region=heap.Region(fn)
    assert region(*args)==expected
    assert region.compiled_calls==1 and region.fallback_calls==0,region.problem
    assert region.aot_calls+region.jit_calls==1

def test_published_alias_is_retained_after_identity_rule():
    output=[];region=heap.Region(publish)
    assert region(7,output)==7
    assert region.compiled_calls==1 and region.fallback_calls==0,region.problem
    assert len(output)==2 and output[0] is output[1]
    assert type(output[0]) is Cell and output[0].value==7


def checked_program(monkeypatch,fn):
    with monkeypatch.context() as patch:
        patch.setattr(scalar.ScalarReplacer,'run',lambda self:{})
        return prepare(fn,(7,))

@pytest.mark.parametrize('fn,classes,identity',[(local,('a',),True),(local,('b',),False),(fresh,('a','b'),True),(fresh,('c',),False)])
def test_identity_proof_respects_enabled_allocation_classes(monkeypatch,fn,classes,identity):
    program=checked_program(monkeypatch,fn)
    engine=scalar.ScalarReplacer(program,heap,classes=classes)
    assert (engine._identity_proof() is not None)==identity


def test_later_use_rejection_is_not_misclassified_as_identity(monkeypatch):
    def reject(*args,**kwargs):raise scalar.CannotScalar('later virtual use rejected')
    monkeypatch.setattr(scalar.ScalarReplacer,'lower',reject)
    program=prepare(local,(7,))
    assert not program.scalar_report.get('identity_noop',False)
    assert program.scalar_report['blocked']
    assert 'later virtual use rejected' in repr(program.scalar_report['blocked'])


def test_unexpected_eligibility_error_never_certifies_identity(monkeypatch):
    program=checked_program(monkeypatch,local)
    engine=scalar.ScalarReplacer(program,heap,classes=('a','b','c'))
    def unexpected(*args,**kwargs):raise RuntimeError('unexpected layout failure')
    monkeypatch.setattr(engine,'virtual',unexpected)
    with pytest.raises(RuntimeError,match='unexpected layout failure'):engine._identity_proof()
    assert not any(family=='F5' and key[0]=='scalar-identity' for family,key in program.facts.answers)
