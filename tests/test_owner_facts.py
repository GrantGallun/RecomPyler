import unittest
from recompyler import lift


def captured_owner(n):
    p=list(range(n))
    q=list(range(n))
    ins=p.insert
    pop=p.pop
    p=q[:]
    ins(0,pop(1))
    return p[0]


class OwnerFactsTests(unittest.TestCase):
    def test_captured_methods_keep_the_original_owner(self):
        self.assertEqual(captured_owner(2),0)
        with self.assertRaises(lift.Unsupported):lift.lift(captured_owner)
