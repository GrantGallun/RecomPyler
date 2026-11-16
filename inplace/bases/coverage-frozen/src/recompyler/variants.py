"""Declared types: compile, ahead of time, the argument types a script's inputs can select.

A profile sees one run, so it only captures the types that run used. When a flag
picks the number type of the work (``--exact`` switching counts from float to int,
say), a later run with the other value would meet a type nobody compiled. The user
declares the choice instead of profiling every combination:

    recompyler profile --types args.exact=int,float script.py

``args.exact`` is a source in the dependency map (``recompyler.depmap``): an argparse
option, ``argv[N]`` or ``env:NAME``. The map says which parameters' *types* depend
on it. For each verified function with such parameters and each declared type,
the captured calls are copied with those arguments converted to that type. The
copies are run compiled and in Python and must match exactly. Variants that pass
join the function's verified rows, so the ahead-of-time module exports them too
and ``recompyler run`` starts any declared variant without compiling.

Parameters whose value but not type depends on the source are left alone: their
type is fixed whatever the input is, so no new variant is needed.
"""

import math

NUMBER_TYPES = {"int": int, "float": float, "bool": bool}
PER_VARIANT = 16  # captured calls converted and checked for each variant


def parse(items):
    """``["args.exact=int,float"]`` -> ``{"args.exact": ["int", "float"]}``."""
    declared = {}
    for item in items:
        source, separator, kinds = item.partition("=")
        names = [kind.strip() for kind in kinds.split(",") if kind.strip()]
        if not separator or not source.strip() or not names:
            raise ValueError(f"expected SOURCE=TYPE[,TYPE...], got {item!r}")
        unknown = [name for name in names if name not in NUMBER_TYPES]
        if unknown:
            raise ValueError(f"unsupported type {unknown[0]!r}: use int, float or bool")
        declared.setdefault(source.strip(), [])
        declared[source.strip()] += [name for name in names if name not in declared[source.strip()]]
    return declared


def _convert(value, kind):
    """``value`` as a number of type ``kind``, or None if that would not be the same number kind."""
    if type(value) not in (int, float, bool):
        return None
    if kind is int and type(value) is float:
        return int(value) if math.isfinite(value) else None
    return kind(value)


def _variant_rows(rows, positions, kind):
    made = []
    for row in rows:
        if any(position >= len(row) for position in positions):
            continue
        new = list(row)
        for position in positions:
            converted = _convert(row[position], kind)
            if converted is None:
                break
            new[position] = converted
        else:
            new = tuple(new)
            if any(type(a) is not type(b) for a, b in zip(new, row)):
                made.append(new)
        if len(made) >= PER_VARIANT:
            break
    return made


def add_variants(script, rows, declared):
    """Check and add declared variants to the verified candidates in a profile's ``rows``.

    ``rows`` are the profiler's rows, whose candidates still hold their compiled
    function (``_lifted``) and captured calls (``_rows``). Returns the report section.
    """
    from .depmap import build

    found = build(script)
    section = {"declared": declared, "sources": found.sources(), "functions": []}
    unknown = [source for source in declared if source not in section["sources"]]
    if unknown:
        section["unknown_sources"] = unknown
    by_key = {(row["function"], row["line"]): row for row in rows}
    for source, kinds in declared.items():
        for key, uses in sorted(found.depends_on(source).items()):
            params = found.functions[key].params
            positions = [params.index(name) for name in uses["type"]]
            row = by_key.get(key)
            entry = {"function": key[0], "line": key[1], "source": source, "type_params": uses["type"],
                     "value_params": uses["value"], "variants": []}
            section["functions"].append(entry)
            if not positions:
                entry["note"] = "only values depend on this input; the types are fixed"
                continue
            candidate = row and row.get("candidate")
            lifted = candidate and candidate.get("_lifted")
            if lifted is None:
                entry["note"] = ("not profiled" if row is None else
                                 f"no compiled version ({candidate.get('status')}"
                                 f"{', compiled as a region' if candidate.get('engine') == 'region' else ''})")
                continue
            # Variants come from the calls the profile captured, not from each other.
            captured = candidate.setdefault("_captured", list(candidate["_rows"]))
            for name in kinds:
                entry["variants"].append(_check(lifted, candidate, captured, positions, name))
    return section


def _check(lifted, candidate, captured, positions, name):
    made = _variant_rows(captured, positions, NUMBER_TYPES[name])
    result = {"type": name, "rows": len(made)}
    if not made:
        result["status"] = "same as profiled"
        return result
    try:
        checked, mismatches = lifted.verify(made)
    except Exception as exc:
        result.update(status="failed", reason=f"{type(exc).__name__}: {exc}"[:160])
        return result
    shapes = set()
    for args in made:
        full = lifted._complete(args)
        packed = full and lifted._pack_call(full)
        if packed and packed[1] is not None:
            packed[2].discard()
            shapes.add(packed[1])
    compiled = [shape for shape in shapes if lifted._shapes.get(shape) is True]
    if mismatches:
        result.update(status="rejected", reason="compiled results differ from Python")
    elif not compiled:
        result.update(status="not compiled", reason="these types run in Python")
    else:
        result.update(status="verified", checked=checked, shapes=sorted(map(repr, compiled)))
        candidate["_rows"] = list(candidate["_rows"]) + made
    return result


def print_variants(section, out):
    if not section:
        return
    print("\nDeclared types", file=out)
    for source in section.get("unknown_sources", []):
        known = ", ".join(section["sources"]) or "none"
        print(f"  {source}: the script never reads this input (inputs found: {known})", file=out)
    for entry in section["functions"]:
        where = f"{entry['function']}:{entry['line']}"
        if entry.get("note"):
            print(f"  {where} ({entry['source']}): {entry['note']}", file=out)
            continue
        params = ", ".join(entry["type_params"])
        for variant in entry["variants"]:
            detail = (f"{variant['checked']} calls matched Python, built ahead of time if recommended"
                      if variant["status"] == "verified" else variant.get("reason", ""))
            print(f"  {where} {params} as {variant['type']} ({entry['source']}): {variant['status']}"
                  f"{'; ' + detail if detail else ''}", file=out)
