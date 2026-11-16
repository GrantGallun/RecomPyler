# S45.10 held-out range forms; baseline executed declined before RangeT wiring.
# The local dict forces the real heap-region path, where retained programs stop;
# a standalone scalar sum can already pass the scalar lifter and hide this gap.
from catalogue import Case

RANGE_CASES = [
    Case('range_value.assigned', 'range_values', 'd={0:x}\nr=range(x)\nfor i in r:\n    d[0]+=i\nreturn d'),
    Case('range_value.repeated', 'range_values', 'd={0:0}\nr=range(x)\nfor i in r:\n    d[0]+=i\nfor i in r:\n    d[0]+=i\nreturn d'),
    Case('range_value.argument', 'range_values', 'd={0:0}\nfor i in r:\n    d[0]+=i\nreturn d', 'r', '(range(1,7,2),)'),
    Case('range_value.internal_argument', 'range_values', 'd={0:0}\nr=range(x)\nreturn consume(r,d)', setup='def consume(r,d):\n    for i in r: d[0]+=i\n    return d\n'),
    Case('range_value.internal_return', 'range_values', 'd={0:0}\nr=make_range(x)\nfor i in r:\n    d[0]+=i\nreturn d', setup='def make_range(n): return range(n)\n'),
    Case('range_value.length', 'range_values', 'd={0:len(r)}\nreturn d', 'r', '(range(7,1,-2),)'),
    Case('range_value.index', 'range_values', 'd={0:r[-1]}\nreturn d', 'r', '(range(7,1,-2),)'),
    Case('range_value.contains', 'range_values', 'd={0:x in r}\nreturn d', 'r,x', '(range(7,1,-2),3)'),
    Case('range_value.zero_step_unused', 'range_values', 'd={0:x}\nr=range(5,5,0)\nreturn d'),
    Case('range_value.huge', 'range_values', 'd={0:len(r)}\nreturn d', 'r', '(range(2**100),)'),
]
