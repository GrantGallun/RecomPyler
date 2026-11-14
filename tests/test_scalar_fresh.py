import unittest
import ast
from unittest import mock
from recompyler import heap
from test_scalar_fields import Cell,SourceOnly


class Triple:
    def __init__(self,x,y,z):
        self.x=x
        self.y=y
        self.z=z

def make_triple(x):return Triple(x,x,x)

def triple_sum(n):
    a=Triple(0,0,0)
    b=make_triple(float(n))
    return int((a.x+b.x+a.y+b.y+a.z+b.z)*1.0)

def make_cell(x):return Cell(x)

def read_for_check(c):return c.x

def discard_reader_result(x):
    c=make_cell(x)
    read_for_check(c)
    return c.x

def two_fresh_calls(x):
    a=make_cell(x)
    b=make_cell(x)
    a.x+=1
    return a.x+b.x

def fresh_chain(x):return make_cell(x)

def consume_chain(x):
    c=fresh_chain(x)
    return c.x+1

def recursive_fresh(x,n):
    if n:return recursive_fresh(x+1,n-1)
    return Cell(x)

def consume_recursive(x,n):
    c=recursive_fresh(x,n)
    return c.x

def fresh_container(x,out):
    c=make_cell(x)
    out.append(c)
    out.append(c)
    return c.x

def previous_iteration(x):
    prior=Cell(x)
    total=0
    for i in range(3):
        c=make_cell(i)
        total+=prior.x
        prior=c
    return total

def producer_error(x):return Cell(1//x)

def consume_producer_error(x):
    c=producer_error(x)
    return c.x

def producer_overflow(x):return Cell(x+1)

def consume_producer_overflow(x):
    c=producer_overflow(x)
    return c.x

def fresh_error(x):
    result=make_cell(1//x)
    return result.x


class FreshScalarSourceTests(unittest.TestCase):
    def test_fresh_clones_built_for_distinct_chained_and_recursive_uses(self):
        for fn,args in ((two_fresh_calls,(3,)),(consume_chain,(3,)),(consume_recursive,(3,2))):
            r=heap.Region(fn,ahead_of_time=SourceOnly());p=r.program_for(args)
            self.assertIsNotNone(p,r.problem)
            self.assertTrue(p.scalar_report.get('fresh_return_clones'),p.scalar_report)

    def test_float_unobservability_omits_only_unused_virtual_tags(self):
        r=heap.Region(triple_sum,ahead_of_time=SourceOnly());p=r.program_for((3,))
        self.assertIsNotNone(p,r.problem);self.assertTrue(p.fast_mixed)
        self.assertEqual(sum(k==heap.MIXED for k in p.fields[Triple].values()),3)
        clones=[i for i in p.order if getattr(i,'scalar_fresh',False) and '_make_triple' in i.name]
        self.assertTrue(clones)
        self.assertTrue(all(heap._width(i.ret)==3 for i in clones))

    def test_discarded_reader_still_allows_fresh_scalar(self):
        # The checked generator itself emits bare unused BOOL calls for object
        # protocol checks (e.g. isPoint); exercise that same valid IR shape.
        original=heap._Gen.run
        class Discard(ast.NodeTransformer):
            def visit_Assign(self,node):
                if isinstance(node.value,ast.Call) and isinstance(node.value.func,ast.Name) and node.value.func.id.endswith('_read_for_check'):
                    return ast.Expr(value=node.value)
                return self.generic_visit(node)
        def generate(gen):
            source=original(gen)
            return ast.unparse(ast.fix_missing_locations(Discard().visit(ast.parse(source)))) if gen.info.fn is discard_reader_result else source
        with mock.patch.object(heap._Gen,'run',generate):
            r=heap.Region(discard_reader_result,ahead_of_time=SourceOnly());p=r.program_for((3,))
            self.assertTrue(p.scalar_report['fresh_return_clones'],p.scalar_report)

class FreshScalarNativeTests(unittest.TestCase):
    def test_distinct_chain_recursive_and_previous_instance(self):
        for fn,args in ((two_fresh_calls,(3,)),(consume_chain,(3,)),(consume_recursive,(3,2)),(previous_iteration,(3,)),(triple_sum,(3,)),(discard_reader_result,(3,))):
            r=heap.Region(fn);self.assertEqual(r(*args),fn(*args));self.assertGreater(r.compiled_calls,0,r.problem)

    def test_container_identity_and_error_replay(self):
        out=[];r=heap.Region(fresh_container);self.assertEqual(r(3,out),3);self.assertIs(out[0],out[1])
        r=heap.Region(fresh_error)
        with self.assertRaises(ZeroDivisionError):r(0)
        self.assertEqual(r(2),fresh_error(2))
        r=heap.Region(consume_producer_error)
        with self.assertRaises(ZeroDivisionError):r(0)
        self.assertEqual(r(2),consume_producer_error(2));self.assertGreater(r.compiled_calls,0,r.problem)
        r=heap.Region(consume_producer_overflow)
        self.assertEqual(r(2**63-1),2**63)
        self.assertEqual(r(2),3);self.assertGreater(r.compiled_calls,0,r.problem)
