"""Independent shared-provenance review probes (S47/S49).

Every function needs a sound answer or explicit decline. Exact numeric
references are exempt from identity only; type/value remain exact.
"""


def shared_allocation():
    """The two return elements are the same list."""
    a = b = []
    return a, b


def distinct_allocations():
    """Return elements are distinct lists although both are equal."""
    a = []
    b = []
    return a, b


def dynamic_allocation_site(n):
    """n >= 2: out[0] is not out[1]; one static site has many instances."""
    out = []
    for _ in range(n):
        x = []
        out.append(x)
    return out


def dynamic_last_two(n):
    """n >= 2: a is not b; static site equality cannot prove must-alias."""
    a = b = None
    for _ in range(n):
        a = b
        b = []
    return a, b


def branch_alias(flag, x):
    """True selects external x; False selects a new list. Preserve union."""
    y = x
    if not flag:
        y = []
    return x, y


def return_aggregate_escape(x):
    """x escapes recursively through both nested tuples and a list."""
    return ([((x,),)],)


def store_aggregate_escape(box, x):
    """External box receives x recursively although result is None."""
    box.field = ([x],)


def call_aggregate_escape(callback, x):
    """callback may retain/inspect x through aggregate; unknown declines."""
    callback(([x],))


def sibling_call_invalidation(callback, box):
    """callback may replace box.field before second tuple child reads it."""
    old = box.field
    return old, callback(box), box.field


def aliased_external_store(left, right, value):
    """When left is right, right[0] becomes value, not old."""
    old = right[0]
    left[0] = value
    return old, right[0]


def dynamic_attribute(box):
    """A descriptor may return distinct objects per read; no cell proof."""
    a = box.field
    b = box.field
    return a, b


def overloaded_add_selects_left(x, y):
    """User __add__ may return x itself; operation does not imply freshness."""
    return x + y


def singleton_comparison(x):
    """x is None is allowed by S49 even when x may be an exact number."""
    return x is None


def possible_numeric_observation(x, y):
    """Decline unless guards prove singleton/nonexempt kinds as S49 permits."""
    return x is y


def indirect_numeric_observation(callback, x):
    """callback may inspect id(x); possible numeric x requires decline."""
    return callback((x,))


def numeric_bool_type(x):
    """When x is True return singleton True, never exempt int 1."""
    return x


def break_skips_else(flag, x, y):
    """flag true selects x via break; false selects y through loop else."""
    z = x
    for _ in (0,):
        if flag:
            break
    else:
        z = y
    return z


def for_target_store(values, old):
    """Empty values returns old; otherwise returns final iterated object."""
    item = old
    for item in values:
        pass
    return item


def finally_overrides_return(x, y):
    """Return is y; unsupported finally must decline, never certify x."""
    try:
        return x
    finally:
        return y


def walrus_store(x, y):
    """Return children both select y; unsupported named-expression declines."""
    return (x := y), x


def nested_function_scope(x):
    """Inner stores do not assign outer x; unsupported closure may decline."""
    def inner():
        x = []
        return x
    return x


def folded_original_constant():
    """Return original code tuple constant object and exact member owners."""
    return ("review_" "constant", (b"review_" b"bytes",))



def joined_aggregate_escape(choose, a, b):
    """Returned union escapes a or b; structural join must retain both may facts."""
    if choose:
        value = [a]
    else:
        value = [b]
    return value


def mutable_children_after_call(callback, a):
    """callback may replace list child; return children cannot still certify a."""
    value = [a]
    callback(value)
    return value


def annotation_without_value(a):
    """Result is a; local annotation is not an assignment to None."""
    value = a
    value: object
    return value


def repeated_while_observation(callback, number):
    """Second while test may send number to identity observer; S49 declines."""
    value = None
    while callback(value):
        value = number
    return value


def mutable_children_after_store(a, b):
    """Returned list child is b after store; no stale a child certificate."""
    value = [a]
    value[0] = b
    return value


def selected_structural_child_escape(a):
    """Return is a selected from a tuple; a definitely escapes."""
    value = (a,)
    return value[0]


def raised_argument_escape(error):
    """Caller receives exact error object as exception; error escapes."""
    raise error


def varargs_origin(*args):
    """Return is original argument tuple, never a same-named module global."""
    return args


def kwargs_origin(**kwargs):
    """Return is the newly bound kwargs dictionary, not a module global."""
    return kwargs


def subscript_key_observation(container, key):
    """__getitem__ may retain/return key or observe exact-number identity."""
    return container[key]


def augmented_operator_escape(left, right):
    """__iadd__ may retain right or return left; neither is known fresh."""
    left += right
    return left


def implicit_truth_callback(flag, a):
    """flag.__bool__ is an arbitrary callback; structural facts need guards."""
    value = [a]
    if flag:
        pass
    return value


def dictionary_hash_callback(key, value):
    """Custom __hash__/__eq__ can observe identities and arbitrary state."""
    return {key: value}


def set_hash_callback(key):
    """Custom key hashing is an unresolved callback, including hidden numbers."""
    return {key}


def starred_iteration_callback(sequence):
    """Star expansion invokes arbitrary iterator callbacks; result length unknown."""
    return [*sequence]


def raised_class_callback(error_class):
    """Raising a class instantiates it; constructors may observe numeric identity."""
    raise error_class


def set_unpack_order(left, right):
    """Exact set iteration order is not source order; left=2,right=1 returns 1,2."""
    a, b = {left, right}
    return a, b


def dict_unpack_members(value):
    """One-key dictionary unpack into two targets raises ValueError, no pair."""
    key, item = {'key': value}
    return key, item


def mapping_expansion_order(mapping):
    """mapping.keys/getitem may replace REVIEW_OWNER before the later read."""
    return {**mapping, 'selected': REVIEW_OWNER}


def starred_unpack_positions(prefix, middle, suffix):
    """prefix=(),middle=9,suffix=(1,2): result 9,1,2; second is not middle."""
    a, b, c = [*prefix, middle, *suffix]
    return a, b, c


def mixed_numeric_text_result(text, flag):
    """flag True returns exact int1; False exact float1.5; text owner exact."""
    if flag:
        value = 1
    else:
        value = 1.5
    return text, value
