import ast
import unittest
from recompyler.facts import FunctionFacts
from recompyler.lift import _fixed_lists


def facts(source):
    node=ast.parse(source).body[0]
    params=[a.arg for a in node.args.args]
    arrays,aliases=_fixed_lists(node,params,lambda _:True)
    return FunctionFacts(node,params,lambda _:True,arrays,aliases)


class ReviewProofTests(unittest.TestCase):
    def test_unsupported_iterable_kills_stale_target(self):
        f=facts('def f():\n p=list(range(1))\n i=0\n for i in (100,):\n  p[i]=1\n')
        self.assertFalse(f.index_sites)

    def test_two_unit_updates_are_not_one_step_induction(self):
        f=facts('def f(n,a):\n r=n\n while r != 1:\n  r-=1\n  r-=1\n  a[r]=1\n')
        self.assertFalse(f.index_sites)

    def test_unrecognized_endpoint_does_not_refine_to_n(self):
        f=facts('def f(n,a):\n r=n\n while r!=1:\n  r-=1\n while r!=0:\n  a[r]=1\n  break\n')
        self.assertFalse(f.index_sites)

    def test_permutation_loop_initial_value_must_have_content_fact(self):
        f=facts('def f(n,a):\n p=list(range(n))\n k=100\n while k:\n  a[k]=1\n  k=p[0]\n')
        target=next(x for x in ast.walk(f.node) if isinstance(x,ast.Subscript) and isinstance(x.value,ast.Name) and x.value.id=='a')
        self.assertNotIn(id(target),f.index_sites)

    def test_unsafe_intermediate_cannot_cancel_into_a_proof(self):
        f=facts('def f(n):\n p=list(range(1))\n j=(n*9223372036854775807-(n-1)*9223372036854775807)-9223372036854775807\n p[j]=1\n')
        self.assertFalse(f.index_sites)

    def test_checked_content_read_is_not_a_validity_fact(self):
        f=facts('def f(n,a):\n p=list(range(n))\n k=p[0]\n a[k]=1\n')
        targets=[x for x in ast.walk(f.node) if isinstance(x,ast.Subscript) and isinstance(x.value,ast.Name) and x.value.id=='a']
        for t in targets:self.assertNotIn(id(t),f.index_sites)

    def test_future_creation_is_not_dominating(self):
        f=facts('def f(n,a):\n for i in range(n):\n  a[p[0]]=1\n p=list(range(n))\n')
        self.assertFalse(f.index_sites)

    def test_resizing_slice_invalidates_all_copy_extents(self):
        f=facts('def f(n):\n p=list(range(n))\n q=p[:]\n p[:]=p[:0]\n q=p[:]\n for i in range(n):\n  q[i]=1\n')
        self.assertFalse(f.index_sites)

    def test_negative_prefix_is_not_a_permutation(self):
        f=facts('def f(n,a):\n p=list(range(n))\n k=-1\n p[:k+1]=p[k::-1]\n for i in range(len(p)):\n  a[i]=1\n')
        self.assertFalse(f.index_sites)

    def test_sin_parameter_domain_is_guarded(self):
        import math
        node=ast.parse('def f(n):\n return math.sin(n)\n').body[0]
        f=FunctionFacts(node,['n'],lambda _:True,namespace={'math':math})
        self.assertTrue(f.guards)

    def test_unhandled_store_kills_prior_numeric_fact(self):
        for statement in ('i:int=100', '(i:=100)'):
            f=facts('def f():\n p=list(range(1))\n i=0\n '+statement+'\n p[i]=1\n')
            self.assertFalse(f.index_sites)

    def test_local_math_receiver_is_not_a_module_fact(self):
        import math
        for source in ('def f(math,n):\n return math.sin(float(n))\n', 'def f(n):\n math=n\n return math.sin(1.0)\n'):
            node=ast.parse(source).body[0]
            f=FunctionFacts(node,[a.arg for a in node.args.args],lambda _:True,namespace={'math':math})
            calls=[x for x in ast.walk(node) if isinstance(x,ast.Call) and isinstance(x.func,ast.Attribute)]
            self.assertFalse(any(id(c) in f.operation_sites for c in calls))

    def test_unit_update_inside_repeating_inner_loop_is_not_induction(self):
        f=facts('def f(n,a):\n r=n\n while r!=1:\n  for z in range(n+5):\n   r-=1\n  break\n a[r-1]=1\n')
        self.assertFalse(f.index_sites)

    def test_negative_range_extent_requires_guard(self):
        f=facts('def f(n):\n p=list(range(n))\n q=list(range(1))\n q[len(p)-n]=1\n')
        if f.index_sites:
            self.assertTrue(any(g[0]=='int' and g[1]=='n' and g[2]>=0 for g in f.guards.values()))

    def test_negative_constant_range_extent_is_empty(self):
        f=facts('def f(n):\n p=list(range(n,n-1))\n q=list(range(1))\n q[len(p)+1]=1\n')
        self.assertFalse(f.index_sites)

    def test_constructor_bound_intermediate_must_be_safe(self):
        f=facts('def f(n):\n p=list(range(n+9223372036854775807))\n p[0]=1\n')
        self.assertFalse(f.index_sites)

    def test_every_permutation_carried_write_must_be_a_content_read(self):
        f=facts('def f(n,a):\n r=n\n while r!=1:\n  r-=1\n p=list(range(n))\n p.insert(0,p.pop(-1))\n k=p[0]\n while k:\n  a[k]=1\n  k=p[0]\n  k+=100\n')
        target=next(x for x in ast.walk(f.node) if isinstance(x,ast.Subscript) and isinstance(x.value,ast.Name) and x.value.id=='a')
        self.assertNotIn(id(target),f.index_sites)

    def test_parameter_value_cannot_supply_prefix_content_provenance(self):
        f=facts('def f(n,k,a):\n p=list(range(n))\n p[:k+1]=p[k::-1]\n k=p[0]\n for i in range(n):\n  a[p[i]]=1\n')
        self.assertFalse(f.index_sites)
