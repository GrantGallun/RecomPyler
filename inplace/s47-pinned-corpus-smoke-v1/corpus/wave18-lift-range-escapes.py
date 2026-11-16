"""Range escape counterexamples for the shared provenance layer (S47)."""


def public_range_identity(r):
    """Result IS r; an equal bounds triple is not an owner representation."""
    return r


def nested_range_return(r):
    """Returned tuple[0][0] IS r; root result kind alone misses this escape."""
    return ([r],)


def borrowed_range_store(r, out):
    """Return None, but out gains the SAME r; return-kind-only proof is invalid."""
    out.append(r)
    return None


def field_range_store(r, box):
    """box.value becomes the SAME r, even though the return is None."""
    box.value = r
    return None


def range_identity_query(r, other):
    """For equal distinct ranges, false; for aliases, true. Bounds do not decide."""
    return r is other


def generator_range_escape(r):
    """The first yielded value IS r; collecting bounds would lose owner identity."""
    yield r

def ignored_range_selected_input(n):
    """S49-exempt (numeric identity only): expected exact int n for exact-int n. Historical CPython fact: n=int('10000'): result IS n although a range was constructed and unused."""
    r = range(n)
    return n


def repeated_iteration_numeric_alias(r):
    """S49-exempt (numeric identity only): expected list of exact ints [10000,10000]; list identity remains exact. Historical CPython fact: For r=range(10000,10001), result[0] IS result[1] (one iteration value)."""
    for x in r:
        return [x, x]
    return []


def longrange_first_owner(r):
    """S49-exempt (numeric identity only): expected exact int r.start when nonempty; None singleton when empty. Historical CPython fact: When CPython uses longrange_iterator, first result IS the stored r.start.

    Windows examples: range(2**40,2**40+1), range(10000,10001,2**40),
    range(2**31-2,2**31-1,3). Native C-long iterator cases box a new value.
    """
    for x in r:
        return x
    return None


def constructed_longrange_first_owner(start, stop, step):
    """S49-exempt (numeric identity only): expected exact int start when nonempty; None singleton when empty. Historical CPython fact: If constructed range uses longrange_iterator, result IS exact input start."""
    r = range(start, stop, step)
    for x in r:
        return x
    return None
