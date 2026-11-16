"""wave18 S54 fallback correctness cases; no private provenance permissions.

Each function is an original-Python witness. Unknown/decline remains valid.
Numeric leaf identity is S49-exempt; callback counts, object identity and state
visibility are exact. Harness setup is stated in each function's docstring.
"""


def effect_before_result_kind_miss(callback):
    """callback logs once and returns 'x': TypeError after ONE callback, never replay twice."""
    value = callback()
    return value + 1


def effect_before_later_overflow(callback, n):
    """callback logs once; n=2**63-1 returns exact int 2**63 after ONE callback."""
    callback()
    return n + 1


def callback_observes_pending_store(values, callback):
    """values=[0], callback closes over values: it must observe1 after the store."""
    values[0] += 1
    return callback()


def callback_invalidates_converted_value(values, callback):
    """values=[0], callback changes original values[0] to9: result exact int9."""
    initial = values[0]
    callback()
    return values[0]


def opaque_selected_owner(callback, owner):
    """callback=lambda x:x: result True; callback's returned reference IS owner."""
    result = callback(owner)
    return result is owner


def opaque_survives_next_callback(make, callback):
    """make returns a new object; callback does gc.collect: returned object remains alive."""
    value = make()
    callback()
    return value


def callback_exception_is_final(callback):
    """callback logs then raises ValueError('once'): identical exception and one log entry."""
    callback()
    return 3


def positional_keyword_order(callee, make):
    """make logs tags: a,b,c in order, then callee receives those exact objects."""
    return callee(make('a'), second=make('b'), third=make('c'))


def recursive_reentry(callback, n):
    """callback re-enters this region with n-1 until0: exact result n, safe nested owners."""
    if n == 0:
        return 0
    return callback(n - 1) + 1
