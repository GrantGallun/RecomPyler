"""Canonical function identities and independent native-count reconciliation."""
import dataclasses
import json
import os
from pathlib import Path


def canonical_file(path):
    return os.path.normcase(str(Path(path).resolve()))


def function_identity(fn):
    code = fn.__code__
    return dict(file=canonical_file(code.co_filename), canonical_file=canonical_file(code.co_filename),
                qualname=fn.__qualname__, function=fn.__qualname__, line=code.co_firstlineno)


def key(row):
    return (canonical_file(row.get('canonical_file', row['file'])), row['qualname'], int(row['line']))


def planned_functions(plan):
    result = {}
    for row in plan.get('functions', []):
        identity = dict(file=canonical_file(row.get('file', plan['script'])),
                        qualname=row.get('qualname', row['function']), line=int(row['line']))
        identity['canonical_file'] = identity['file']
        result.setdefault((identity['file'], identity['qualname']), []).append(identity)
    return result


def product_functions(report, plan):
    lookup = planned_functions(plan)
    rows, seen = [], set()
    for row in report['functions']:
        file = canonical_file(row.get('file', report['script']))
        # Runner explicitly emits fn.__qualname__, while candidate.function is
        # lexical and may be only a short method name.
        matches = lookup.get((file, row['function']), [])
        assert len(matches) == 1, ('Missing/ambiguous product identity', file, row['function'], matches)
        assert row.get('line') is None or int(row['line']) == matches[0]['line'], 'Product line conflicts with unique plan identity'
        result = dict(row, **matches[0], runner_line=row.get('line'),
                      identity_line_source='product' if row.get('line') is not None else 'unique canonical file/qualified-name plan match')
        assert key(result) not in seen, ('Duplicate product function', result)
        seen.add(key(result))
        rows.append(result)
    return rows


def aggregate_native(rows):
    result = {}
    for row in rows:
        identity = (*key(row), row.get('kind', 'region' if row.get('region') else 'ordinary'))
        counts = result.setdefault(identity, {'aot_calls': 0, 'jit_calls': 0, 'unknown_native_calls': 0})
        for name in counts:
            counts[name] += int(row.get(name, 0))
    return result


def native_reconciles(product, independent):
    left, right = aggregate_native(product), aggregate_native(independent)
    zero = {'aot_calls': 0, 'jit_calls': 0, 'unknown_native_calls': 0}
    return all(left.get(identity, zero) == right.get(identity, zero) for identity in left.keys() | right.keys())


def jsonable(value):
    if value is None or type(value) in (str, int, float, bool):
        return value
    if dataclasses.is_dataclass(value) and not isinstance(value, type):
        return jsonable(dataclasses.asdict(value))
    if isinstance(value, dict):
        return {str(k): jsonable(v) for k, v in value.items()}
    if isinstance(value, (tuple, list)):
        return [jsonable(v) for v in value]
    if isinstance(value, (set, frozenset)):
        return [jsonable(v) for v in sorted(value, key=repr)]
    if isinstance(value, Path):
        return str(value)
    return {'unserialized_type': type(value).__qualname__, 'repr': repr(value)}


def counter_state(value, names):
    result = {}
    for name in names:
        number = getattr(value, name, None)
        assert number is None or type(number) is int and number >= 0, ('Invalid rule counter', name, number)
        result[name] = number
    return result


def rule_deltas(before, after, successful):
    result = {}
    for name in before:
        assert (before[name] is None) == (after[name] is None), ('Rule interface changed during call', name)
        if before[name] is None:
            result[name] = dict(implemented=False, backend_reach='unimplemented')
        else:
            delta = after[name] - before[name]
            assert 0 <= delta <= int(successful), ('Rule count is not a successful complete call', name, delta, successful)
            result[name] = dict(implemented=True, successful_calls=delta)
    return result

