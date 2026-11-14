import ast
from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from recompyler.flow import analyse  # noqa: E402

CASES = {
    "def f(r):\n for i in r:\n  pass\n return i\n": {"i"},
    "def f(a):\n if a<0:\n  s=-1\n elif a>0:\n  s=1\n else:\n  s=0\n return s\n": set(),
    "def f(a):\n if a<0:\n  s=-1\n elif a>0:\n  s=1\n return s\n": {"s"},
    "def f(a):\n while True:\n  x=a\n  if x: break\n return x\n": set(),
    "def f(a):\n while True:\n  if a: break\n  x=a\n return x\n": {"x"},
    "def f(r):\n for i in r:\n  if i:\n   y=i\n   break\n else:\n  y=0\n return y\n": set(),
    "def f(a):\n try:\n  x=a\n except E:\n  return 0\n return x\n": set(),
    "def f(a):\n try:\n  x=a\n except E:\n  pass\n return x\n": {"x"},
    "def f(a):\n try:\n  pass\n finally:\n  x=1\n return x\n": set(),
    "def f(a):\n if a:\n  x=1\n else:\n  raise E\n return x\n": set(),
    "def f(cells):\n for cell in cells:\n  pass\n return sum(1 for cell in cells)\n": set(),
    "def f(a):\n if a:\n  t=0\n t+=1\n return t\n": {"t"},
    "def f(n):\n for i in range(n):\n  if i==0:\n   prev=0\n  else:\n   prev=prev+i\n return 0\n": {"prev"},
    "def f(a):\n x=1\n del x\n return x\n": {"x"},
    "def f(a):\n with a as b:\n  y=1\n return b, y\n": {"y"},
    "def f(a):\n if (n:=a): pass\n return n\n": set(),
    "def f(r):\n for i in r:\n  if i: continue\n  z=1\n  print(z)\n return 0\n": set(),
    "def f(a):\n x = [y for y in a]\n return y\n": set(),
    "def f(a):\n match a:\n  case [p]:\n   q=p\n  case _:\n   q=0\n return q\n": set(),
    "def f(a):\n global g\n g = 1\n return g\n": set(),
}


class FlowTests(unittest.TestCase):
    def test_reads_that_may_find_a_local_unbound(self):
        for source, expected in CASES.items():
            with self.subTest(source=source):
                self.assertEqual(analyse(ast.parse(source).body[0]).names, expected)

    def test_falling_off_the_end(self):
        def falls(source):
            return analyse(ast.parse(source).body[0]).falls_through

        self.assertFalse(falls("def f(a):\n if a:\n  return 1\n else:\n  return 2\n"))
        self.assertTrue(falls("def f(a):\n if a:\n  return 1\n"))
        self.assertFalse(falls("def f(a):\n while True:\n  pass\n"))
        self.assertTrue(falls("def f(a):\n try:\n  return 1\n except E:\n  pass\n"))


if __name__ == "__main__":
    unittest.main()
