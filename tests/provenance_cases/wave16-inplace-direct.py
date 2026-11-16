"""wave16 direct-read/store reviewer origin queries; decline unknown cases."""

def field_aliases(record,values):
    """If record.left is record.right is values, all returned numbers are values[0]."""
    return record.left[0],record.right[0],values[0]

def field_phi(left,right,choose):
    """Equal-valued distinct boxes: return the actually selected original field."""
    value=left.value
    if choose:value=right.value
    return value

def field_loop(left,right,count):
    """count0 returns left.value; positive count returns last executed selection."""
    value=left.value
    for index in range(count):
        if index%2==0:value=right.value
        else:value=left.value
    return value

def shared_fresh_producer(record):
    """Exact float field7.25 -> (8.25,8.25) with both leaves the SAME fresh box."""
    value=record.value+1.0
    return value,value

def distinct_equal_producers(record):
    """Exact float field7.25 -> equal8.25 leaves with DISTINCT fresh boxes."""
    left=record.value+1.0
    right=record.value+1.0
    return left,right

def dynamic_producer(record,count):
    """count2: equal fresh8.25 results from distinct dynamic loop executions."""
    first=last=record.value
    for index in range(count):
        value=record.value+1.0
        if index==0:first=value
        last=value
    return first,last

def returned_before_finally(record,replacement):
    """Return IS old record.value even though finally replaces the field."""
    try:return record.value
    finally:record.value=replacement

def first_equal_minimum(left,right):
    """Equal exact floats: min returns left.value, preserving first-owner choice."""
    return min(left.value,right.value)

def surviving_store_alias(record,values):
    """If values[0] aliases record.value, the return keeps that original box."""
    record.value=record.value+1.0
    return values[0]
