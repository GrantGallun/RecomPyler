"""Fail-first relational bounds examples for the shared fact interface."""
import ast
import unittest
from recompyler import facts


def analyze(source):
    node = ast.parse(source).body[0]
    return facts.FunctionFacts(node, [a.arg for a in node.args.args], lambda name: True)


class InductionFactsTests(unittest.TestCase):
    def test_parameter_extent_and_affine_index(self):
        f = analyze('def f(n, a):\n for i in range(1, n-1):\n  a[i+1] = a[i-1]\n')
        self.assertEqual(len(f.index_sites), 2)
        self.assertTrue(f.guards)
        self.assertTrue(f.operation_sites)
        self.assertEqual(f.report()['rules']['R6']['fired'], 2)

    def test_direct_length_extent(self):
        f = analyze('def f(a):\n for i in range(len(a)):\n  a[i] = a[i] + 1\n')
        self.assertEqual(len(f.index_sites), 2)
        self.assertTrue(f.guards)

    def test_modified_induction_is_not_a_proof(self):
        f = analyze('def f(n,a):\n for i in range(n):\n  i = n + 1\n  a[i] = 0\n')
        self.assertFalse(f.index_sites)

    def test_modified_stop_is_not_a_proof(self):
        f = analyze('def f(n,a):\n for i in range(n):\n  n = n+1\n  a[i] = 0\n')
        self.assertFalse(f.index_sites)

    def test_parameter_rebinding_invalidates_entry_extent(self):
        f = analyze('def f(n,a):\n a = [1]\n for i in range(n):\n  a[i] = 0\n')
        self.assertFalse(f.index_sites)

    def test_negative_index_stays_checked(self):
        f = analyze('def f(n,a):\n for i in range(n):\n  a[i-1] = 0\n')
        self.assertFalse(f.index_sites)
        self.assertGreater(f.report()['rules']['R6']['blocked'], 0)

    def test_overflowing_intermediate_not_raw(self):
        f = analyze('def f(n,a):\n for i in range(n):\n  a[i] = i * 9223372036854775807\n')
        mul = next(x for x in ast.walk(f.node) if isinstance(x,ast.BinOp))
        self.assertNotIn(id(mul), f.operation_sites)

    def test_unknown_control_invalidates_local_fact(self):
        f = analyze('def f(n,a):\n for i in range(n):\n  if i > 0:\n   j = n\n  else:\n   j = i\n  a[j] = 0\n')
        self.assertFalse(f.index_sites)

    def test_fact_three_states_and_declared_requirements(self):
        self.assertEqual(facts.Fact.proven(1).state, 'proven')
        self.assertEqual(facts.Fact.guarded(1, 'g').state, 'guarded')
        self.assertEqual(facts.Fact.unknown('loop carried').state, 'unknown')
        self.assertIn('F1', facts.RULES['R6'].requires)
