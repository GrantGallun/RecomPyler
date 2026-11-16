"""S60: real analysis cells and unrelated tuple-field constructors."""
from recompyler import heap

class Pair:
    def __init__(self, left, right):
        self.left, self.right = left, right

def make_cell():
    return heap._Cell()

def pair_total(a, b):
    pair = Pair(a, b)
    return pair.left + pair.right

def parent_root(cell):
    while cell.left is not None:
        cell = cell.left
    return cell

def test_arena_cell_creation_keeps_text_owner_decline():
    region = heap.lift_region(make_cell)
    result = region()
    assert type(result) is heap._Cell and result.elem is heap.BOTTOM
    assert region.compiled_calls == 0 and region.fallback_calls == 1
    assert 'ownership' in region.problem

def test_unrelated_tuple_constructor():
    region = heap.lift_region(pair_total)
    for a, b in ((2, 3), (-7, 4)):
        assert region(a, b) == pair_total(a, b)
    assert region.compiled_calls == 2, region.problem

def test_unrelated_parent_identity():
    root, leaf = Pair(None, 1), Pair(None, 2)
    leaf.left = root
    region = heap.lift_region(parent_root)
    assert region(leaf) is root
    assert region.compiled_calls == 1, region.problem
