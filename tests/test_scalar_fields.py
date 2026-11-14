import copy
import math
import struct
import unittest
from unittest import mock
from recompyler import heap


class Cell:
    def __init__(self,x):self.x=x


def local_alias(n):
    c=Cell(n)
    other=c
    other.x+=1
    return c.x


def mutate_and_read(a,b):
    a.x+=1
    return b.x


def distinct_call(n):
    a=Cell(n)
    b=Cell(n+10)
    mutate_and_read(a,b)
    return a.x+b.x


def fresh_reader(c):
    return Cell(c.x+1)


def fresh_while_passing(n):
    c=Cell(n)
    result=fresh_reader(c)
    return result.x+c.x


def readonly(c):return c.x


def readonly_use(n):
    c=Cell(n)
    return readonly(c)


def recursive_consumer(c,n):
    if n:
        new=Cell(n)
        return c.x+recursive_consumer(new,n-1)
    return c.x


def recursive_local_use(n):
    c=Cell(n)
    return recursive_consumer(c,n)


class Parent:
    def __init__(self,child):self.child=child


def shared_child(n):
    c=Cell(n)
    a=Parent(c)
    b=Parent(c)
    a.child.x+=1
    return b.child.x


def mixed_virtual(value,flag):
    c=Cell(0)
    if flag:c.x=value
    return c.x


def scalar_checked_overflow(n):
    c=Cell(n)
    c.x+=1
    return c.x


def nested_mutation(c):
    mutate_and_read(c,c)
    return c.x


def nested_use(n):
    c=Cell(n)
    return nested_mutation(c)


def shared_call(n):
    c=Cell(n)
    return mutate_and_read(c,c)


def recursive_alias(c,n):
    if n:
        alias=recursive_alias(c,n-1)
        alias.x+=1
    return c


def recursive_use(n):
    c=Cell(0)
    alias=recursive_alias(c,n)
    return alias.x


def identity_after_join(n,flag):
    a=Cell(n)
    b=Cell(n)
    current=a if flag else b
    return current is a


def escaped_aliases(n,out,flag):
    p=Cell(n)
    if flag:
        out.append(p)
        out.append(p)
    p.x+=1
    return p.x


def failure_after_creation(n,out):
    p=Cell(n)
    p.x+=1
    out.append(p)
    return 1//0


class SourceOnly(dict):
    def __bool__(self):return True
    def get(self,key,default=None):return True


class ScalarSourceTests(unittest.TestCase):
    def program(self,fn,args):
        region=heap.Region(fn,ahead_of_time=SourceOnly())
        p=region.program_for(args)
        self.assertIsNotNone(p,region.problem)
        return p

    def test_local_alias_uses_scalar_fields(self):
        p=self.program(local_alias,(3,))
        self.assertTrue(p.scalar_report['removed_sites'])
        self.assertIn('_sr_',p.source)

    def test_shared_parameter_clone_preserves_alias_group(self):
        p=self.program(shared_call,(3,))
        self.assertTrue(p.scalar_report['removed_sites'])
        self.assertTrue(p.scalar_report['field_clones'])

    def test_small_clone_retains_inline_policy(self):
        p=self.program(shared_call,(3,))
        constructor=next(i for i in p.order if i.name.startswith('sr') and '__init__' in i.name)
        self.assertIn('inline="always"',constructor.source.split('def ',1)[0])

    def test_readonly_clone_has_no_unchanged_update_return(self):
        p=self.program(readonly_use,(3,))
        reader=next(i for i in p.order if i.name.startswith('sr') and '_readonly' in i.name)
        self.assertEqual(reader.ret,heap.INT)

    def test_recursive_clone_also_virtualizes_its_local_site(self):
        p=self.program(recursive_local_use,(3,))
        consumers=[i for i in p.order if i.name.startswith('sr') and '_recursive_consumer' in i.name]
        self.assertTrue(consumers)
        self.assertTrue(all('= alloc(' not in i.source for i in consumers))

    def test_incomplete_mutation_summary_declines_field_clone(self):
        original=heap._escape.EscapeAnalysis.__init__
        def incomplete(analysis,functions):
            original(analysis,functions)
            for name,summary in analysis.summaries.items():
                if name.endswith('_nested_mutation'):
                    for parameter in summary['parameters']:parameter['mutated']=[]
        with mock.patch.object(heap._escape.EscapeAnalysis,'__init__',incomplete):
            p=self.program(nested_use,(3,))
        self.assertFalse(p.scalar_report['removed_sites'])
        self.assertTrue(p.scalar_report['blocked'])

    def test_second_phase_decline_restores_checked_program(self):
        original=heap._scalar.ScalarReplacer.check_clones
        def reject_second_phase(engine,tree):
            if engine.final_locals is not None:raise heap._scalar.CannotScalar('test context decline')
            return original(engine,tree)
        with mock.patch.object(heap._scalar.ScalarReplacer,'check_clones',reject_second_phase):
            fallback=self.program(shared_call,(3,))
        self.assertFalse(fallback.scalar_report['removed_sites'])
        with mock.patch.object(heap._scalar.ScalarReplacer,'run',lambda engine:{}):
            original_program=self.program(shared_call,(3,))
        self.assertEqual(fallback.source,original_program.source)
        self.assertFalse(any(i.name.startswith('sr') for i in fallback.order))

    def test_identity_and_conditional_escape_keep_handles(self):
        for fn,args in ((identity_after_join,(3,True)),(escaped_aliases,(3,[],True)),(failure_after_creation,(3,[]))):
            p=self.program(fn,args)
            self.assertFalse(p.scalar_report['removed_sites'])


class ScalarNativeTests(unittest.TestCase):
    def test_alias_mutation_and_recursive_call(self):
        for fn,args in ((local_alias,(3,)),(shared_call,(4,)),(distinct_call,(4,)),(fresh_while_passing,(4,)),(readonly_use,(4,)),(recursive_local_use,(3,)),(recursive_use,(3,))):
            r=heap.Region(fn);self.assertEqual(r(*args),fn(*args));self.assertGreater(r.compiled_calls,0,r.problem);self.assertTrue(r.program_for(args).scalar_report["removed_sites"])

    def test_mixed_tags_signed_zero_nan_and_shared_child(self):
        p=heap.Region(mixed_virtual,ahead_of_time=SourceOnly()).program_for((-0.0,True))
        self.assertFalse(p.fast_mixed)
        self.assertTrue(p.scalar_report["removed_sites"],p.scalar_report)

        for value in (-0.0,0.0,1.5,float('nan'),float('inf')):
            for flag in (False,True):
                r=heap.Region(mixed_virtual);actual=r(value,flag);expected=mixed_virtual(value,flag)
                self.assertEqual(type(actual),type(expected))
                if type(expected) is float:
                    self.assertEqual(struct.pack('d',actual),struct.pack('d',expected))
                else:self.assertEqual(actual,expected)
                self.assertGreater(r.compiled_calls,0,r.problem)
        r=heap.Region(shared_child);self.assertEqual(r(4),5);self.assertGreater(r.compiled_calls,0,r.problem)
        r=heap.Region(scalar_checked_overflow);self.assertEqual(r(2**63-1),2**63)

    def test_distinct_identity_conditional_escape_and_replay(self):
        for flag in (False,True):
            r=heap.Region(identity_after_join);self.assertEqual(r(3,flag),identity_after_join(3,flag))
            out=[];r=heap.Region(escaped_aliases);self.assertEqual(r(3,out,flag),4)
            if flag:self.assertIs(out[0],out[1]);self.assertEqual(out[0].x,4)
        out=[];r=heap.Region(failure_after_creation)
        with self.assertRaises(ZeroDivisionError):r(3,out)
        self.assertEqual(len(out),1);self.assertEqual(out[0].x,4)
