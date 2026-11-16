"""wave18 S49 reviewer nonnumeric identity/escape cases; exact ownership required."""

def repeated_range_literal(n):
    """Returned list contains the same newly created range object twice."""
    return [range(n)] * 2

def repeated_range_local(n):
    """Returned list contains the same r twice; ranges are not S49-exempt."""
    r = range(n)
    return [r] * 2

def temporary_range_tuple_owner(n, owner):
    """For owner=(10000,), the result IS owner; tuples are not S49-exempt."""
    len(range(n))
    return owner


def selected_tuple(r, owner):
    """For tuple owner, result IS owner despite range len consumption."""
    count = len(r)
    return owner


def tuple_in_mutated_list(r, values):
    """For values=[owner_tuple], appended (9,) must leave values[0] IS owner_tuple."""
    count = len(r)
    values.append((9,))
    return None
