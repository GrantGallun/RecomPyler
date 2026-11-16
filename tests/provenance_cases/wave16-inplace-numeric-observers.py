"""S49 identity observers: never exempt merely because result is bool.
Expected CPython identity/numeric type facts, original arguments evaluated left to right.
"""
def numeric_dict_identity(value,mapping):
 """value=0..31 exact int, mapping={1:2}: always False; is-not always True.
 A live dict handle must never be compared to the numeric payload. Decline is valid.
 """
 return value is mapping

def numeric_set_identity(value,items):
 """value=0..31 exact int, items={1,2}: always False; decline is valid."""
 return value is items

def numeric_identity(left,right):
 """Distinct int('1000009') objects: False; same object: True. Must decline under S49.3."""
 return left is right


def mixed_numeric_identity(flag,value,mapping):
 """For mapping dict, selected int/float/MIXED operand always differs in identity; unknown may decline."""
 return (value if flag else 0.5) is mapping

def indexed_numeric_identity(values,index,mapping):
 """Numeric element vs dict is False after evaluating indexing; bad index must still raise IndexError."""
 return values[index] is mapping

def chained_numeric_identity(value,mapping,later):
 """Exact number vs dict is False; chained later operand is skipped. Numeric identity itself is not value equality."""
 return value is mapping is later
