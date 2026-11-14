"""Exact approved task-local source interventions; no compiler edits."""
import ast

CASES = [("current-direct", "current", 0), ("current-wrapper1", "current", 1),
         ("current-wrapper4", "current", 4), ("forceonly-direct", "forceonly", 0),
         ("fullfloat-direct", "fullfloat", 0), ("fullfloat-wrapper4", "fullfloat", 4)]


def numeric_source(source, contract):
    if contract == "current":
        return source, []
    lines = source.splitlines(keepends=True)
    offsets, total = [], 0
    for line in lines:
        offsets.append(total)
        total += len(line)
    edits = []
    def add(node, text, reason):
        start, end = offsets[node.lineno-1]+node.col_offset, offsets[node.end_lineno-1]+node.end_col_offset
        edits.append((start, end, text, reason, source[start:end]))
    for cls in [n for n in ast.parse(source).body if isinstance(n, ast.ClassDef)]:
        for fn in [n for n in cls.body if isinstance(n, ast.FunctionDef)]:
            if cls.name == "QuadTree" and fn.name == "calculate_force":
                for node in ast.walk(fn):
                    if isinstance(node, ast.Return) and isinstance(node.value, ast.Tuple):
                        if all(isinstance(x, ast.Constant) and type(x.value) is int and x.value == 0 for x in node.value.elts):
                            for x in node.value.elts:
                                add(x, "0.0", "force-zero-return")
                    if isinstance(node, ast.Assign) and len(node.targets) == 1 and isinstance(node.targets[0], ast.Tuple):
                        if [x.id for x in node.targets[0].elts if isinstance(x, ast.Name)] == ["fx", "fy"]:
                            for x in node.value.elts:
                                assert isinstance(x, ast.Constant) and type(x.value) is int and x.value == 0
                                add(x, "0.0", "force-zero-accumulator")
            if contract != "fullfloat":
                continue
            for node in ast.walk(fn):
                if not isinstance(node, ast.Assign) or len(node.targets) != 1:
                    continue
                target = ast.unparse(node.targets[0])
                if cls.name == "Point" and fn.name == "__init__" and target in {"self.x", "self.y"}:
                    assert isinstance(node.value, ast.Name)
                    add(node.value, "float(" + node.value.id + ")", "Point-constructor-float-contract")
                elif ((cls.name == "Particle" and fn.name == "update" and target in {"self.acceleration.x", "self.acceleration.y"})
                      or (cls.name == "QuadTree" and fn.name == "__init__" and target == "self.total_mass")):
                    assert isinstance(node.value, ast.Constant) and type(node.value.value) is int and node.value.value == 0
                    add(node.value, "0.0", "float-reset-or-mass-contract")
    assert len(edits) == (6 if contract == "forceonly" else 11), edits
    for start, end, replacement, _, _ in sorted(edits, reverse=True):
        source = source[:start] + replacement + source[end:]
    return source, [{"start": a, "end": b, "replacement": c, "reason": d, "original": e} for a,b,c,d,e in edits]


def driver(source, contract, group):
    result, edits = numeric_source(source, contract)
    target = "advance_system"
    if group:
        assert group in (1, 4) and 100 % group == 0
        marker = "\n_times = []\n"
        at = result.rindex(marker)
        wrapper = "\ndef advance_block(particles, theta, time_step, width, height, count):\n    for step in range(count):\n        advance_system(particles, theta, time_step, width, height)\n\n"
        result = result[:at] + wrapper + result[at:]
        old = "    for _ in range(DEFAULT_ITERATIONS):\n        advance_system(_particles, DEFAULT_THETA, TIME_STEP, 1000, 800)\n"
        new = f"    for _ in range(DEFAULT_ITERATIONS // {group}):\n        advance_block(_particles, DEFAULT_THETA, TIME_STEP, 1000, 800, {group})\n"
        assert result.count(old) == 1
        result = result.replace(old, new)
        target = "advance_block"
    ast.parse(result)
    return result, target, edits
