"""Keep descriptor reads out of helpers selected for AOT always-inlining."""
import ast
import re
from types import SimpleNamespace

from recompyler import heap
from test_heap_compact_abi import State, even_walk, generated


RAW = ["_heap_F", "_heap_I", "_heap_top", "_heap_st", "_heap_len"]


class Cell:
    def __init__(self, value=2.0):
        self.value = value


def mutate_leaf(cell, amount):
    cell.value += amount
    return cell.value


def recursive_walk(cell, depth):
    if depth <= 0:
        return cell.value
    value = mutate_leaf(cell, 0.5)
    return value + recursive_walk(cell, depth - 1)


def kickoff(cell, depth):
    value = mutate_leaf(cell, 0.25)
    return value + recursive_walk(cell, depth)


def inline_heavy_entry(cell, depth):
    total = mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    total += mutate_leaf(cell, 0.125)
    return total + kickoff(cell, depth)


def explicit_even(cell, depth, amount):
    cell.value += amount
    if depth <= 0:
        return cell.value
    return explicit_odd(cell, depth - 1, amount)


def explicit_odd(cell, depth, amount):
    cell.value += amount
    if depth <= 0:
        return cell.value
    return explicit_even(cell, depth - 1, amount)


def is_inline(node):
    return any(isinstance(decorator, ast.Call) and any(
        keyword.arg == "inline" and isinstance(keyword.value, ast.Constant)
        and keyword.value.value == "always" for keyword in decorator.keywords)
        for decorator in node.decorator_list)


def check_source(program):
    functions = {node.name: node for node in ast.parse(program.source).body
                 if isinstance(node, ast.FunctionDef)}
    borrowed = {name: node for name, node in functions.items() if name.endswith("_borrowed")}
    assert borrowed
    for name, node in borrowed.items():
        leading = ["_heap_ctx"] + (RAW if is_inline(node) else [])
        assert [arg.arg for arg in node.args.args[:len(leading)]] == leading, name
        if not is_inline(node):
            assert not set(RAW).intersection(arg.arg for arg in node.args.args)
        unpack = [call for call in ast.walk(node) if isinstance(call, ast.Call)
                  and isinstance(call.func, ast.Name) and call.func.id == "_heap_context_unpack"]
        assert len(unpack) == (0 if is_inline(node) else 1), name
        for call in ast.walk(node):
            if not isinstance(call, ast.Call) or not isinstance(call.func, ast.Name):
                continue
            assert call.func.id != "_heap_context_pack"
            if call.func.id in borrowed:
                wanted = ["_heap_ctx"] + (RAW if is_inline(borrowed[call.func.id]) else [])
                assert [ast.unparse(arg) for arg in call.args[:len(wanted)]] == wanted
    public = functions[program.entry.name]
    packs = [call for call in ast.walk(public) if isinstance(call, ast.Call)
             and isinstance(call.func, ast.Name) and call.func.id == "_heap_context_pack"]
    assert len(packs) == 1
    assert [ast.unparse(arg) for arg in packs[0].args] == RAW
    entry_call = next(call for call in ast.walk(public) if isinstance(call, ast.Call)
                      and isinstance(call.func, ast.Name) and call.func.id == program.entry.name + "_borrowed")
    wanted = ["_heap_ctx"] + (RAW if is_inline(borrowed[entry_call.func.id]) else [])
    assert [ast.unparse(arg) for arg in entry_call.args[:len(wanted)]] == wanted
    return borrowed


def test_inline_helpers_receive_ssa_context_and_keep_recursive_calls_narrow():
    program = generated(inline_heavy_entry, Cell(), 2)
    borrowed = check_source(program)
    assert not is_inline(borrowed[program.entry.name + "_borrowed"])
    assert any(is_inline(node) for node in borrowed.values())
    assert any("recursive_walk" in name and not is_inline(node) for name, node in borrowed.items())


def test_mutual_recursive_wrappers_follow_their_actual_inline_markers():
    program = generated(even_walk, State(), 3, 1.0)
    borrowed = check_source(program)
    # Ordinary initial entry is not necessarily itself an SCC member: type
    # specialization can place the merged cycle behind that entry.
    assert any(is_inline(node) for node in borrowed.values())
    assert any(name.startswith("s0_") and not is_inline(node) for name, node in borrowed.items())


def test_inline_entry_wrapper_receives_public_adapter_ssa_values():
    entry = SimpleNamespace(name="entry", params=["value"], vars={"value": heap.FLOAT},
                            source=heap._INLINED + "\ndef entry(F, I, top, st, v_value):\n"
                                   "    return s0_entry(F, I, top, st, v_value)\n")
    merged = heap._DECORATOR + "\ndef s0_entry(F, I, top, st, v_value):\n" \
             "    if v_value > 0:\n        return s0_entry(F, I, top, st, v_value - 1.0)\n" \
             "    return v_value\n"
    program = SimpleNamespace(order=[entry], entry=entry)
    program.source = "\n".join(heap._borrow_heap_context(program, [merged]))
    borrowed = check_source(program)
    assert is_inline(borrowed["entry_borrowed"])
    assert not is_inline(borrowed["s0_entry_borrowed"])


def test_real_mutual_member_as_entry_runs_public_wide_wrapper(monkeypatch):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(explicit_even)
    assert region(Cell(), 2, 1.25) == explicit_even(Cell(), 2, 1.25)
    program = region.latest
    # Normal Region entries start with the shared key=None, whereas calls use
    # typed copies even with all arguments explicit. Select an already generated
    # real SCC member as this test program's entry to exercise the wrapper entry
    # branch without changing specialization limits or cycle/inline eligibility.
    program.entry = next(info for info in program.order if info.fn is explicit_even
                         and info is not program.entry and info.recursive)
    program.compile()
    borrowed = check_source(program)
    assert is_inline(borrowed[program.entry.name + "_borrowed"])
    expected_cell, actual_cell = Cell(), Cell()
    assert region(actual_cell, 4, 1.25) == explicit_even(expected_cell, 4, 1.25)
    assert actual_cell.value == expected_cell.value
    assert region.latest is program
    assert region.compiled_calls == 2 and region.fallback_calls == 0, region.problem


def test_only_exact_inline_marker_changes_signature_including_large_helpers():
    def info(name, decorator, statements):
        return SimpleNamespace(name=name, params=["value"], vars={"value": heap.FLOAT},
                               source=decorator + "\ndef " + name + "(F, I, top, st, v_value):\n" + statements)
    entry = info("entry", heap._DECORATOR,
                 "    return small(F, I, top, st, v_value) + large(F, I, top, st, v_value)\n")
    small = info("small", heap._INLINED, "    return v_value\n")
    large = info("large", heap._DECORATOR,
                 "".join(f"    t{index} = v_value\n" for index in range(heap.INLINE_LINES + 1))
                 + "    return v_value\n")
    program = SimpleNamespace(order=[entry, small, large], entry=entry)
    program.source = "\n".join(heap._borrow_heap_context(program, []))
    borrowed = check_source(program)
    assert is_inline(borrowed["small_borrowed"])
    assert not is_inline(borrowed["large_borrowed"])


def native_body(dispatcher, signature):
    symbol = dispatcher.overloads[signature].fndesc.llvm_func_name
    return next(block.split("\n}", 1)[0] for block in dispatcher.inspect_llvm(signature).split("define ")[1:]
                if "@" + symbol + "(" in block.splitlines()[0])


def descriptor_loads(native):
    """Count loads from the descriptor itself, never from loaded arena pointers."""
    declaration = native.splitlines()[0]
    match = re.search(r"(%arg\._heap_ctx(?:\.\d+)?)(?=,|\))", declaration)
    assert match is not None
    pointers = {match.group(1)}
    lines = native.splitlines()[1:]
    changed = True
    while changed:
        changed = False
        for line in lines:
            result = re.match(r"\s*(%[-a-zA-Z0-9._]+) = (?:getelementptr|bitcast)\b", line)
            if result and any(re.search(r"(?<![-a-zA-Z0-9._])" + re.escape(pointer) + r"(?=[, )])", line)
                              for pointer in pointers) and result.group(1) not in pointers:
                pointers.add(result.group(1))
                changed = True
    return [line for line in lines if re.search(r"= load\b", line)
            and any(re.search(r"\bptr " + re.escape(pointer) + r"(?=[, )])", line) for pointer in pointers)]


def test_native_inline_helper_has_raw_pointer_parameters_without_unpack(monkeypatch):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(inline_heavy_entry)
    expected_cell, actual_cell = Cell(), Cell()
    expected = inline_heavy_entry(expected_cell, 2)
    assert region(actual_cell, 2) == expected
    assert actual_cell.value == expected_cell.value
    assert region.compiled_calls == 1, region.problem
    from numba import types

    seen_inline = seen_recursive = False
    for info in region.latest.order:
        body = getattr(region.latest.module, info.name + "_borrowed")
        for signature in body.signatures:
            native = native_body(body, signature)
            if info.source.startswith(heap._INLINED + "\ndef "):
                assert sum(isinstance(kind, types.CPointer) for kind in signature) == 5
                assert signature[5] == types.int64
                assert not descriptor_loads(native), native
                seen_inline = True
            else:
                assert sum(isinstance(kind, types.CPointer) for kind in signature) == 1
                if info.recursive:
                    seen_recursive = True
    assert seen_inline and seen_recursive


def test_aot_style_inline_expansion_does_not_repeat_descriptor_reads(monkeypatch):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(inline_heavy_entry)
    assert region(Cell(), 2) == inline_heavy_entry(Cell(), 2)
    program = region.latest
    from numba import njit

    entry = heap._inlined_entry(program)
    program.run = njit(error_model="numpy")(entry)
    expected_cell, actual_cell = Cell(), Cell()
    assert region(actual_cell, 2) == inline_heavy_entry(expected_cell, 2)
    assert actual_cell.value == expected_cell.value
    assert region.compiled_calls == 2, region.problem
    borrowed = entry.__globals__[program.entry.name + "_borrowed"]
    assert borrowed.signatures
    native = native_body(borrowed, borrowed.signatures[0])
    reads = descriptor_loads(native)
    assert len(reads) <= 5, "\n".join(reads)
    assert not re.search(r"call[^\n]*@NRT_(?:incref|decref|MemInfo_alloc)", native)
