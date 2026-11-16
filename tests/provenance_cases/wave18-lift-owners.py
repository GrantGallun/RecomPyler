"""wave18 ownership counterexamples for the shared S47 provenance layer.

Each function is one case. Unknown/decline is valid; an incorrect native answer
is not. Integer owners in examples use int('10000') to avoid the small-int cache.
"""


def code_constant_float(x):
    """S49-exempt (numeric identity only): expected exact float 3.0 (bit-exact). Historical CPython fact: Repeated calls return the SAME inner code-owned float object, value 3.0."""
    def inner(y):
        return 1.0 + 2.0
    return inner(x)


def code_constant_integer(x):
    """S49-exempt (numeric identity only): expected exact int 10001. Historical CPython fact: Repeated calls return the SAME code-owned int object, value 10001."""
    def inner(y):
        return 10000 + 1
    return inner(x)


def discarded_helper_selected_input(x):
    """S49-exempt (numeric identity only): expected exact int x for exact-int x. Historical CPython fact: For x=int('10000'), the return IS x, despite the discarded fresh call."""
    def inner(y):
        return y + 1
    inner(x)
    return x


def early_selected_input(x, choose):
    """S49-exempt (numeric identity only): expected exact int x or x+1 for exact-int x. Historical CPython fact: choose=True returns x by identity; false returns fresh x+1."""
    def inner(y):
        return y + 1
    if choose:
        return x
    return inner(x)


def constant_alias(x):
    """S49-exempt (numeric identity only): expected exact int 10000. Historical CPython fact: Repeated calls return the SAME code-owned int 10000 through two names."""
    constant = 10000
    alias = constant
    def inner(y):
        return y + 1
    inner(x)
    return alias


def input_alias(x):
    """S49-exempt (numeric identity only): expected exact int x for exact-int x. Historical CPython fact: The result IS x through old and alias, even after a discarded helper."""
    old = x
    alias = old
    def inner(y):
        return y + 1
    inner(x)
    return alias


def record_add_selection(value):
    """For an object whose __add__ returns value.field, result IS that field."""
    def inner(a):
        return a + 1
    return inner(value)


def record_neg_selection(value):
    """For an object whose __neg__ returns value.field, result IS that field."""
    def inner(a):
        return -a
    return inner(value)


def nested_record_selection(value, x):
    """Custom __neg__ is called once before adding x; all leaves need kind proof."""
    def inner(a):
        return (-a) + x
    return inner(value)


def discarded_record_effect(value, x):
    """Custom __neg__ is called ONCE though its result is discarded; return x+1."""
    def inner(a):
        return -a
    inner(value)
    return x + 1


def remainder_selected_input(a, b):
    """S49-exempt (numeric identity only): expected exact int 1099511627776 for documented inputs. Historical CPython fact: a=int('1099511627776'), b=int('1152921504606846976'): result IS a."""
    def inner(x, y):
        return x % y
    return inner(a, b)


def borrowed_list_surviving_owner(values):
    """[owner,10,20] -> 40 and [owner]; surviving values[0] IS original owner."""
    def inner(a, b):
        return a + a
    return inner(values.pop(), values.pop())


def nonlocal_fresh_update(x):
    """S49-exempt (numeric identity only): expected exact int 10001 for x=10000. Historical CPython fact: x=int('10000') -> int 10001, result is fresh and is NOT x."""
    y = x
    def update():
        nonlocal y
        y += 1
    update()
    return y


def nonlocal_old_alias(x):
    """S49-exempt (numeric identity only): expected exact int x for exact-int x. Historical CPython fact: After updating y, old retains its pre-update owner: result IS x."""
    y = x
    old = y
    def update():
        nonlocal y
        y += 1
    update()
    return old


def nonlocal_late_shared_read(x):
    """S49-exempt (numeric identity only): expected exact int 6 for x=3. Historical CPython fact: x=3 -> int 6; read observes the single updated outer cell."""
    y = x
    def update():
        nonlocal y
        y += 1
    def read():
        return y + 2
    update()
    return read()


def nonlocal_rebind_and_snapshot(x):
    """S49-exempt (numeric identity only): expected exact int 207 for x=3. Historical CPython fact: x=3 -> int 207; update(y) snapshots y before its store, then repeats."""
    y = x
    def update(a):
        nonlocal y
        y += a
    y = x + 100
    update(y)
    update(1)
    return y


def nonlocal_unbound_cell(x):
    """Raises free-variable NameError, not UnboundLocalError; preserve exact args."""
    def update():
        nonlocal y
        y += 1
    update()
    y = x
    return y


def nonlocal_subclass_iadd(x):
    """An int subclass returning self from __iadd__ is invoked ONCE; result IS x."""
    y = x
    def update():
        nonlocal y
        y += 1
    update()
    return y


def fresh_alias(x):
    """S49-exempt (numeric identity only): expected exact int 10001 for x=10000. Historical CPython fact: x=int('10000') -> fresh int10001; assigning alias preserves fresh origin."""
    def inner(a):
        return a + 1
    fresh = inner(x)
    alias = fresh
    return alias


def literal_actual_runtime(x):
    """S49-exempt (numeric identity only): expected exact int 10001. Historical CPython fact: 10001 is computed at runtime inside helper; repeated returns are distinct."""
    def inner(a):
        return a + 10000
    return inner(1)


def numeric_identity(a, b):
    """Equal noncached ints can be distinct; result is (a is b), never value eq."""
    def inner(x, y):
        return x is y
    return inner(a, b)
