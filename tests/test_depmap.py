import ast
from pathlib import Path
import sys
import textwrap
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from recompyler.depmap import DependencyMap  # noqa: E402
from recompyler.variants import _variant_rows, add_variants, parse  # noqa: E402


def make(source):
    return DependencyMap(ast.parse(textwrap.dedent(source)))


def key(found, name):
    return next(k for k in found.functions if k[0] == name)


FLAGS = """
    import argparse, math, os, sys

    def walk(position, step, n, scale):
        total = position
        for _ in range(n):
            position = (position * 3 + step) % 1000003
            total += position * scale
        return total

    def helper(x):
        return x

    def main(args):
        zero = 0 if args.exact else 0.0
        if args.exact:
            step = 7
        else:
            step = 7.0
        n = int(sys.argv[1])
        scale = 1.0 / n
        return walk(helper(zero), step, n, scale)

    parser = argparse.ArgumentParser()
    parser.add_argument("--exact", action="store_true")
    parser.add_argument("--rounds", type=int)
    main(parser.parse_args())
    level = os.environ.get("LEVEL")
"""


class DependenceTests(unittest.TestCase):
    def setUp(self):
        self.found = make(FLAGS)
        self.walk = key(self.found, "walk")

    def test_sources(self):
        self.assertEqual(self.found.sources(), ["args.exact", "argv[1]", "env:LEVEL"])
        self.assertEqual(self.found.options, {"exact": "bool", "rounds": "int"})

    def test_type_versus_value(self):
        position = self.found.parameter(self.walk, "position")
        step = self.found.parameter(self.walk, "step")
        n = self.found.parameter(self.walk, "n")
        scale = self.found.parameter(self.walk, "scale")
        # Picked by an if-expression, through a helper's return value.
        self.assertIn("args.exact", position[1])
        # Picked by an if statement assigning different number types.
        self.assertIn("args.exact", step[1])
        # int(...) and 1.0 / n fix the type; only the value depends on argv.
        self.assertEqual((n[1], n[2]), (set(), "int"))
        self.assertEqual((scale[1], scale[2]), (set(), "float"))
        self.assertIn("argv[1]", scale[0])

    def test_depends_on(self):
        found = self.found.depends_on("args.exact")
        self.assertEqual(found[self.walk]["type"], ["position", "step"])
        self.assertNotIn(self.walk, self.found.depends_on("env:LEVEL"))


class RegionTests(unittest.TestCase):
    def test_tiers(self):
        found = make("""
            import math, random

            def leaf(x):
                return math.sqrt(x)

            def native(xs):
                out = []
                push = out.append
                for x in xs:
                    push(leaf(x))
                return out

            def boundary(x):
                return x + random.random()

            def escape(x):
                return eval("x")

            def caller(xs):
                return native(xs), escape(1)
        """)
        tiers = {name: found.region(key(found, name))[1] for name in ("native", "boundary", "escape", "caller")}
        self.assertEqual(tiers, {"native": "native", "boundary": "boundary", "escape": "escape",
                                 "caller": "escape"})
        self.assertEqual(found.region(key(found, "native"))[0], {key(found, "native"), key(found, "leaf")})

    def test_passed_functions_and_methods(self):
        found = make("""
            def eval_a(i, j):
                return 1.0 / (i + j + 1)

            def times(func, u):
                return [func(i, j) for i, j in u]

            class Body:
                def __init__(self, x):
                    self.x = x

                def move(self, dt):
                    self.x += dt
                    raise ValueError("stop")

            def run(u):
                body = Body(0.0)
                body.move(0.1)
                return times(eval_a, u)
        """)
        members, tier, _ = found.region(key(found, "run"))
        names = {k[0] for k in members}
        self.assertEqual(names, {"run", "times", "eval_a", "__init__", "move"})
        self.assertEqual(tier, "native")


class VariantTests(unittest.TestCase):
    def test_parse(self):
        self.assertEqual(parse(["args.exact=int,float", "argv[1]=int"]),
                         {"args.exact": ["int", "float"], "argv[1]": ["int"]})
        with self.assertRaises(ValueError):
            parse(["args.exact"])
        with self.assertRaises(ValueError):
            parse(["args.exact=str"])

    def test_rows_convert_only_the_chosen_arguments(self):
        rows = [(1.5, 7.0, 400), (2.0, 7.0, 400)]
        self.assertEqual(_variant_rows(rows, [0, 1], int), [(1, 7, 400), (2, 7, 400)])
        self.assertEqual(_variant_rows(rows, [0, 1], float), [])
        self.assertEqual(_variant_rows([(float("inf"), 1.0, 1)], [0], int), [])

    def test_add_variants_checks_and_extends_rows(self):
        import tempfile

        from recompyler.lift import lift

        source = textwrap.dedent("""
            import argparse

            def walk(position, step, n):
                total = position
                for _ in range(n):
                    position = (position * 3 + step) % 1000003
                    total += position
                return total

            if __name__ == "__main__":
                parser = argparse.ArgumentParser()
                parser.add_argument("--exact", action="store_true")
                args = parser.parse_args()
                start = 1 if args.exact else 1.0
                print(walk(start, 7 if args.exact else 7.0, 50))
        """)
        with tempfile.TemporaryDirectory() as folder:
            script = Path(folder) / "script.py"
            script.write_text(source, encoding="utf-8")
            scope = {"__name__": "variant_test"}
            exec(compile(source, str(script), "exec"), scope)
            walk = scope["walk"]
            captured = [(1.0 + k, 7.0, 50) for k in range(4)]
            candidate = {"status": "verified", "_lifted": lift(walk), "_rows": list(captured)}
            rows = [{"function": "walk", "line": 4, "candidate": candidate}]
            section = add_variants(script, rows, {"args.exact": ["int", "float"], "argv[3]": ["int"]})
        entry = next(item for item in section["functions"] if item["function"] == "walk")
        self.assertEqual(entry["type_params"], ["position", "step"])
        statuses = {variant["type"]: variant["status"] for variant in entry["variants"]}
        self.assertEqual(statuses, {"int": "verified", "float": "same as profiled"})
        self.assertEqual(len(candidate["_rows"]), len(captured) + 4)
        self.assertTrue(all(type(row[0]) is int for row in candidate["_rows"][len(captured):]))
        self.assertEqual(section["unknown_sources"], ["argv[3]"])


if __name__ == "__main__":
    unittest.main()
