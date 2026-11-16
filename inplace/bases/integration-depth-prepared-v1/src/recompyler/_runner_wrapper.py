"""Process-local proof of runner-created adapters; never persisted in plans.

Weak registry values contain no closure/state/argument graph. The wrapper's own
live closure supplies those values during each check, and identity guards detect
replacement before a prepared program bypasses a selected helper adapter.
"""
from types import FunctionType
import sys
import weakref

_RECORDS = weakref.WeakKeyDictionary()


def _attributes(fn):
    if type(fn) is not FunctionType: return None
    attrs=fn.__dict__
    if type(attrs) is not dict or any(type(key) is not str for key in attrs): return None
    return attrs


def _cells(fn):
    if type(fn) is not FunctionType:
        return None
    try:
        return dict(zip(fn.__code__.co_freevars,
                        (cell.cell_contents for cell in fn.__closure__ or ())))
    except ValueError:
        return None


def register(wrapper, fn, prepare, state):
    """Called only by runner.use for its freshly constructed exact adapter."""
    if any(type(value) is not FunctionType for value in (wrapper, fn, prepare)) or type(state) is not dict:
        return False
    cells = _cells(wrapper)
    if cells is None or cells.get('fn') is not fn or cells.get('prepare') is not prepare or cells.get('state') is not state:
        return False
    attrs=_attributes(wrapper)
    if attrs is None or attrs.get('__recompyler_original__') is not fn or attrs.get('__wrapped__') is not fn:
        return False
    prep = _cells(prepare)
    if prep is None or prep.get('fn') is not fn or prep.get('state') is not state:
        return False
    # Verify provenance using the actual runner's nested code, not an attribute
    # a caller can copy to an unrelated function.
    runner = sys.modules.get(__package__ + '.runner')
    outer = vars(runner).get('run_script') if runner is not None else None
    if type(outer) is not FunctionType:
        return False
    use = next((c for c in outer.__code__.co_consts if type(c) is type(outer.__code__) and c.co_name == 'use'), None)
    if use is None or not any(c is wrapper.__code__ for c in use.co_consts) or not any(c is prepare.__code__ for c in use.co_consts):
        return False
    _RECORDS[wrapper] = (wrapper.__code__, weakref.ref(fn), weakref.ref(prepare), prepare.__code__,
                         tuple((name, id(value)) for name, value in prep.items()), id(state),
                         state.get('region'), state.get('file'), None)
    return True


def _valid(wrapper, *, check_lifted=True):
    if type(wrapper) is not FunctionType:
        return False
    row = _RECORDS.get(wrapper)
    if row is None or wrapper.__code__ is not row[0]:
        return False
    fn, prepare = row[1](), row[2]()
    if fn is None or prepare is None or prepare.__code__ is not row[3]:
        return False
    attrs=_attributes(wrapper)
    if attrs is None or attrs.get('__recompyler_original__') is not fn or attrs.get('__wrapped__') is not fn:
        return False
    cells, prep = _cells(wrapper), _cells(prepare)
    if cells is None or prep is None or cells.get('fn') is not fn or cells.get('prepare') is not prepare:
        return False
    if tuple((name, id(value)) for name, value in prep.items()) != row[4]:
        return False
    state = cells.get('state')
    if type(state) is not dict or id(state) != row[5] or prep.get('state') is not state:
        return False
    if any(type(key) is not str for key in state) or set(state) != {'lifted', 'failed', 'aot_loaded', 'region', 'python_calls', 'file'}:
        return False
    if (type(state['region']) is not bool or state['region'] is not row[6]
            or type(state['file']) is not str or state['file'] != row[7]
            or type(state['failed']) is not bool or type(state['aot_loaded']) is not bool
            or type(state['python_calls']) is not int or state['python_calls'] < 0):
        return False
    if check_lifted:
        expected = row[8]() if row[8] is not None else None
        if state['lifted'] is not expected:
            return False
        if expected is not None and not _strict_lifted(expected, fn):
            return False
    return True


def _strict_lifted(value, fn):
    allowed = []
    for module_name, class_name in (('heap', 'Region'), ('lift', 'Lifted'), ('aot', 'AotLifted')):
        module = sys.modules.get(__package__ + '.' + module_name)
        cls = vars(module).get(class_name) if module is not None else None
        if cls is not None:
            allowed.append(cls)
    return any(type(value) is cls for cls in allowed) and vars(value).get('original') is fn


def record_lifted(wrapper):
    """Record a strict implementation issued by the trusted prepare closure."""
    if not _valid(wrapper, check_lifted=False):
        return False
    state = _cells(wrapper)['state']
    value = state['lifted']
    if value is None:
        reference = None
    else:
        if not _strict_lifted(value, _RECORDS[wrapper][1]()):
            return False
        try:
            reference = weakref.ref(value)
        except TypeError:
            return False
    row = _RECORDS[wrapper]
    _RECORDS[wrapper] = row[:8] + (reference,)
    return True


def guard(value):
    """Whether this registered adapter still has its trusted dispatch behavior."""
    return _valid(value)


def original(value):
    """Return a plain function or the original of a valid registered adapter."""
    if type(value) is not FunctionType:
        return None
    if value in _RECORDS:
        return _RECORDS[value][1]() if guard(value) else None
    attrs=_attributes(value)
    if attrs is None: return None
    if '__recompyler_original__' in attrs or '__recompyler_lifted__' in attrs:
        return None
    return value
