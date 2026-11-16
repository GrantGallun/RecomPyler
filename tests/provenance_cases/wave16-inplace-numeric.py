"""wave16 CHECKPOINT80: twelve numeric identity failures on Step4a0ef65037.

Every argument is an exact builtin kind. Unknown/decline is valid; identity
is exempt under S49 for exact int/float/complex; type and value remain exact. External observations below are
historical CPython identity facts only; after S49 verify exact type/value on first and warm calls. Float value means bit-exact, including NaN payloads and signed zero.
"""

def forward_integer(value):
    """S49-exempt: value=int('1000009'): result is value, exact int1000009."""
    return value

def forward_float(value):
    """S49-exempt: value=float('12345.625'): result is value, exact float12345.625."""
    return value

def unary_positive_integer(value):
    """S49-exempt: value=int('1000009'): unary plus forwards the same int box."""
    return +value

def unary_positive_float(value):
    """S49-exempt: value=float('12345.625'): unary plus forwards the same float box."""
    return +value

def exact_float_conversion(value):
    """S49-exempt: value=float('12345.625'): float(value) is value, no new owner."""
    return float(value)

def positive_integer_absolute(value):
    """S49-exempt: value=int('1000009'): abs(value) is value; negative input differs."""
    return abs(value)

def code_integer_constant():
    """S49-exempt: Result int1000003 is the actual co_consts owner, shared across calls."""
    return 1000003

def code_float_constant():
    """S49-exempt: Result float12345.625 is the actual co_consts owner across calls."""
    return 12345.625

def folded_integer_constant():
    """S49-exempt: CPython folds1000003+2: result1000005 is code-owned across calls."""
    return 1000003+2

def existing_fresh_selection(flag,value):
    """S49-exempt: value=int('1000009'): true returns value; false returns fresh1000010.

    The false case is a passing control; true was the CHECKPOINT80 failure.
    The join must keep the executed origin, never choose by numeric equality.
    """
    return value if flag else value+1

def forwarded_negative_zero(value):
    """S49-exempt: value=-0.0: result is value, exact float with the negative-zero bits."""
    return value

def forwarded_nan(value):
    """S49-exempt: value=float('nan'): result is value; NaN payload equality is irrelevant."""
    return value
