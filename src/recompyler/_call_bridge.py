"""Compile Python control flow while keeping library values as CPython objects.

This opt-in path never converts an application heap and never retries an entry
once native execution begins. The shared managed-reference ABI owns all values.
"""
import ast
import __future__
import builtins
import ctypes
from functools import partial
import operator
import struct
import sys
from types import FunctionType, BuiltinFunctionType

from .provenance import bind_source, site, resolve_origin, _inert_namespaces


class UnsupportedCall(Exception):
    pass


_MISSING = object()
# CPython opcodes use interpreter exception classes even if builtins are rebound.
_NAME_ERROR = ctypes.py_object.in_dll(ctypes.pythonapi, 'PyExc_NameError').value
_UNBOUND_ERROR = ctypes.py_object.in_dll(ctypes.pythonapi, 'PyExc_UnboundLocalError').value

# Keep the original inert probe when the application later rebinds sys.exception.
_exception_probe = sys.exception
if not (type(_exception_probe) is BuiltinFunctionType
        and _exception_probe.__self__ is sys
        and _exception_probe.__name__ == 'exception'
        and _exception_probe.__module__ == 'sys'):
    _exception_probe = None


def handled_exception_clear():
    # Raising the captured native error from a Python wrapper would otherwise
    # replace its inner __context__ with the caller's currently handled error.
    return _exception_probe is not None and _exception_probe() is None


def _read_name(frame, namespace, builtins, name, local):
    if local:
        value = frame.get(name, _MISSING)
        if value is _MISSING:
            raise _UNBOUND_ERROR(f"cannot access local variable '{name}' where it is not associated with a value")
        return value
    value = namespace.get(name, _MISSING)
    if value is _MISSING:
        value = builtins.get(name, _MISSING)
    if value is _MISSING:
        raise _NAME_ERROR(f"name '{name}' is not defined", name=name)
    return value


def _store_name(frame, name, value):
    frame[name] = value


def _import_name(namespace, builtins, name, fromlist=None, level=0):
    if '__import__' not in builtins:
        raise ImportError('__import__ not found')
    importer = builtins['__import__']
    # Optimized ordinary CPython function frames pass None as import locals.
    return importer(name, namespace, None, fromlist, level)


def _context_functions():
    # Rebound application functions must remain ordinary calls.
    result = []
    for name in ('globals', 'locals', 'vars', 'dir', 'exec', 'eval'):
        value = getattr(builtins, name)
        if not (type(value) is BuiltinFunctionType and value.__self__ is builtins
                and value.__name__ == name and value.__module__ == 'builtins'):
            value = object()
        result.append(value)
    return tuple(result)


_CONTEXT_FUNCTIONS = _context_functions()


def _context_call(callee, args, keywords, frame, namespace, *, order=()):
    # Optimized function locals snapshots follow source slots, not assignment order.
    def snapshot():
        return {name: frame[name] for name in dict.fromkeys(order + tuple(frame)) if name in frame}
    global_fn, local_fn, vars_fn, dir_fn, exec_fn, eval_fn = _CONTEXT_FUNCTIONS
    if not args and not keywords:
        if callee is global_fn:
            return namespace
        if callee is local_fn or callee is vars_fn:
            return snapshot()
        if callee is dir_fn:
            return sorted(frame)
    if (callee is exec_fn or callee is eval_fn) and 1 <= len(args) <= 3:
        # Duplicate/invalid arguments remain the builtin's own errors.
        duplicate = (len(args) >= 2 and 'globals' in keywords) or (len(args) >= 3 and 'locals' in keywords)
        if not duplicate:
            globals_ = args[1] if len(args) >= 2 else keywords.get('globals')
            locals_ = args[2] if len(args) >= 3 else keywords.get('locals')
            if globals_ is None:
                globals_ = namespace
                if locals_ is None:
                    locals_ = snapshot()
                remaining = {key: value for key, value in keywords.items() if key not in ('globals', 'locals')}
                return callee(args[0], globals_, locals_, **remaining)
    return callee(*args, **keywords)


_FUTURE_FLAGS = sum(getattr(__future__, name).compiler_flag for name in __future__.all_feature_names
                    if getattr(__future__, name).compiler_flag >= (1 << 17))


class _Compiler:
    allow_closure_cells = False

    def __init__(self, fn):
        if type(fn) is not FunctionType or not _inert_namespaces(fn):
            raise UnsupportedCall('requires a plain function with inert namespaces')
        if fn.__code__.co_flags & _FUTURE_FLAGS:
            raise UnsupportedCall('future compilation context requires interpreter fallback')
        if (fn.__code__.co_flags & (0x20 | 0x80 | 0x200) or
                (fn.__code__.co_freevars or fn.__code__.co_cellvars) and not self.allow_closure_cells):
            raise UnsupportedCall('closures and suspended frames are not supported')
        self.fn = fn
        self.binding = bind_source(fn)
        self.node = self.binding.node
        if not isinstance(self.node, ast.FunctionDef):
            raise UnsupportedCall('requires an ordinary function')
        self.locals = set(fn.__code__.co_varnames) | set(fn.__code__.co_cellvars)
        self.pool = []
        self.call_counter_layout = None
        self._call_kind_vars = {}
        self._constant_strings = {}
        self.counter = 0
        self.lines = []
        self.intrinsics = {}
        self.packet_returns = False
        self.indent = 1
        self.names = list(fn.__code__.co_names) + list(fn.__code__.co_varnames)
        self.constants = []
        def collect(values):
            for value in values:
                self.constants.append(value)
                if type(value) is tuple:
                    collect(value)
        try:
            collect(fn.__code__.co_consts)
        finally:
            # The recursive helper must not keep self/function in a GC cycle.
            collect = None
        self.constants += self.names

    def fresh(self):
        self.counter += 1
        return f'_v{self.counter}'

    def line(self, text):
        self.lines.append('    ' * self.indent + text)

    def operation(self, name, *arguments):
        result = self.fresh()
        packed = ', '.join(arguments)
        if name in ('_tuple_object', '_list_object', '_dict_object'):
            packed = '(' + packed + (',' if len(arguments) == 1 else '') + ')'
        self.line(f'{result}, _ok = {name}({packed})')
        self.line('if not _ok:')
        self.indent += 1
        self.line('_capture_error(_errors)')
        self.line('return _errors, False')
        self.indent -= 1
        if name == '_getattr_object' and len(arguments) == 2:
            from ._call_kinds import named_kind
            attribute = self._constant_strings.get(arguments[1])
            if attribute is not None:
                self.register_call_kind(result, named_kind(attribute, method=True))
        return result

    def set_call_counter_layout(self, layout):
        self.call_counter_layout = layout
        child = getattr(self, 'child', None)
        if isinstance(child, _Compiler) and child is not self:
            child.set_call_counter_layout(layout)

    def register_call_kind(self, value, kind):
        self._call_kind_vars[value] = kind
        return value

    def record_managed_call(self, kind='function', counted=True):
        if counted:
            self.line('_counts[0] += 1')
        if self.call_counter_layout is not None:
            source, dispatch = self.call_counter_layout.slots(kind)
            if counted:
                self.line(f'_counts[{source}] += 1')
            self.line(f'_counts[{dispatch}] += 1')

    def pooled(self, value):
        index = next((i for i, old in enumerate(self.pool) if old is value), None)
        if index is None:
            index = len(self.pool)
            self.pool.append(value)
        result = self.operation('_pool_item', '_pool', str(index))
        if type(value) is str:
            self._constant_strings[result] = value
        else:
            from ._call_kinds import helper_kind
            self.register_call_kind(result, helper_kind(value))
        return result

    def constant(self, value):
        def key(item):
            if type(item) is float:
                return (float, struct.pack('!d', item))
            if type(item) is complex:
                return (complex, struct.pack('!dd', item.real, item.imag))
            if type(item) is tuple:
                return (tuple, tuple(map(key, item)))
            return (type(item), item)
        matches = [original for original in self.constants
                   if type(original) is type(value) and key(original) == key(value)]
        if matches:
            if any(original is not matches[0] for original in matches):
                raise UnsupportedCall('ambiguous original constant owner')
            return self.pooled(matches[0])
        if value is None:
            return self.pooled(None)
        raise UnsupportedCall('constant has no original-code owner: ' + repr(value))

    def _vector_arguments(self, args, keywords):
        values = list(args) + [value for key, value in keywords]
        packed = '(' + ', '.join(values) + (',' if len(values) == 1 else '') + ')'
        if keywords:
            try:
                names = tuple(self._constant_strings[key] for key, value in keywords)
            except KeyError:
                raise UnsupportedCall('keyword names require original code owners') from None
            keyword_names = self.constant(names)
        else:
            keyword_names = 'None'
        return packed, keyword_names

    def runtime_call_direct(self, callee, args, keywords=(), counted=False):
        """Call without implicit-frame builtins; native children use this on a miss."""
        packed, names = self._vector_arguments(args, keywords)
        self.record_managed_call(self._call_kind_vars.get(callee, 'function'), counted)
        return self.operation('_call_vector', callee, packed, names, str(len(args)))

    def runtime_call(self, callee, args, keywords=(), counted=False):
        if not counted:
            return self.runtime_call_direct(callee, args, keywords, counted=False)
        packed, names = self._vector_arguments(args, keywords)
        self.record_managed_call(self._call_kind_vars.get(callee, 'function'), counted=True)
        return self.operation('_call_vector_in_frame', callee, packed, names, str(len(args)),
                              '_frame', '_namespace', self.pooled(partial(_context_call, order=self.fn.__code__.co_varnames + self.fn.__code__.co_cellvars + self.fn.__code__.co_freevars)), self.pooled(_CONTEXT_FUNCTIONS))

    def discard_call(self, node):
        # The returned new CPython reference is consumed natively at POP_TOP.
        if any(isinstance(a, ast.Starred) for a in node.args) or any(k.arg is None for k in node.keywords):
            raise UnsupportedCall('expanded call arguments are not supported')
        callee = self.expression(node.func)
        args = [self.expression(arg) for arg in node.args]
        keywords = [(self.constant(key.arg), self.expression(key.value)) for key in node.keywords]
        packed, names = self._vector_arguments(args, keywords)
        self.record_managed_call(self._call_kind_vars.get(callee, 'function'), counted=True)
        self.line('_discarded, _ok = _call_vector_in_frame_result(' + ', '.join([callee, packed, names,
            str(len(args)), '_frame', '_namespace',
            self.pooled(partial(_context_call, order=self.fn.__code__.co_varnames + self.fn.__code__.co_cellvars + self.fn.__code__.co_freevars)),
            self.pooled(_CONTEXT_FUNCTIONS)]) + ')')
        self.line('if not _ok:')
        self.indent += 1
        self.line('_capture_error(_errors)')
        self.line('return _errors, False')
        self.indent -= 1
        self.line('_discard_vector_result(_discarded)')

    def name(self, name):
        from ._call_kinds import named_kind
        result = self.operation('_read_name_native', '_frame', '_namespace', '_builtins',
                                self.constant(name), str(name in self.locals))
        return self.register_call_kind(result, named_kind(name))

    def assign(self, target, value):
        if not isinstance(target, ast.Name):
            raise UnsupportedCall('only local name stores are supported')
        self.line(f'_ok = _store_name_native(_frame, {self.constant(target.id)}, {value})')
        self.line('if not _ok:')
        self.indent += 1
        self.line('_capture_error(_errors)')
        self.line('return _errors, False')
        self.indent -= 1

    def expression(self, node):
        if isinstance(node, (ast.JoinedStr, ast.FormattedValue)):
            from ._call_format import emit
            return emit(self, node)
        facts = self.binding.constants.get(site(node))
        if facts is not None and len(facts.origins) == 1:
            origin = next(iter(facts.origins))
            if origin.kind == 'constant':
                return self.pooled(resolve_origin(self.fn, origin))
            if origin.kind == 'operation':
                try:
                    value = ast.literal_eval(node)
                except (ValueError, TypeError):
                    pass
                else:
                    if type(value) is int:
                        # Shared LOAD_SMALL_INT fact; S49 exempts numeric identity.
                        return self.pooled(value)
        if isinstance(node, ast.Name):
            return self.name(node.id)
        if isinstance(node, ast.Constant):
            return self.constant(node.value)
        if isinstance(node, ast.Attribute):
            value = self.expression(node.value)
            return self.operation('_getattr_object', value, self.constant(node.attr))
        if isinstance(node, ast.Call):
            if any(isinstance(arg, ast.Starred) for arg in node.args) or any(key.arg is None for key in node.keywords):
                raise UnsupportedCall('expanded call arguments are not supported')
            callee = self.expression(node.func)
            args = [self.expression(arg) for arg in node.args]
            keywords = [(self.constant(key.arg), self.expression(key.value)) for key in node.keywords]
            return self.runtime_call(callee, args, keywords, counted=True)
        if isinstance(node, ast.Tuple):
            try:
                literal = ast.literal_eval(node)
            except (ValueError, TypeError):
                pass
            else:
                try:
                    return self.constant(literal)
                except UnsupportedCall:
                    pass
        if isinstance(node, (ast.Tuple, ast.List)):
            operation = '_tuple_object' if isinstance(node, ast.Tuple) else '_list_object'
            return self.operation(operation, *[self.expression(item) for item in node.elts])
        if isinstance(node, ast.Slice):
            bounds = [self.expression(bound) if bound is not None else self.pooled(None)
                      for bound in (node.lower, node.upper, node.step)]
            return self.operation('_slice_object', *bounds)
        if isinstance(node, ast.Subscript):
            return self.operation('_getitem_object', self.expression(node.value), self.expression(node.slice))
        if isinstance(node, ast.BinOp):
            operations = {ast.Div: operator.truediv, ast.Add: operator.add, ast.Sub: operator.sub,
                          ast.Mult: operator.mul, ast.Mod: operator.mod, ast.FloorDiv: operator.floordiv,
                          ast.BitAnd: operator.and_, ast.BitOr: operator.or_, ast.BitXor: operator.xor}
            op = operations.get(type(node.op))
            if op is None:
                raise UnsupportedCall('binary operator is unsupported')
            return self.runtime_call(self.pooled(op), [self.expression(node.left), self.expression(node.right)])
        raise UnsupportedCall('expression ' + type(node).__name__)

    def statements(self, body):
        for statement in body:
            if isinstance(statement, ast.Return):
                value = self.expression(statement.value) if statement.value is not None else self.pooled(None)
                if self.packet_returns:
                    value = self.operation('_tuple_object', self.pooled(True), value)
                self.line(f'return {value}, True')
            elif isinstance(statement, ast.Try):
                from ._call_protected import emit
                emit(self, statement)
            elif isinstance(statement, ast.ImportFrom):
                # This private interpreter ABI is versioned and checked before
                # execution; other runtimes decline the whole entry safely.
                import ctypes
                if (sys.implementation.name != 'cpython' or sys.version_info[:2] != (3, 14)
                        or not hasattr(ctypes.pythonapi, '_PyEval_ImportFrom')):
                    raise UnsupportedCall('import-from requires the CPython 3.14 runtime operation')
                if any(alias.name == '*' for alias in statement.names):
                    raise UnsupportedCall('star import is unsupported')
                names = self.constant(tuple(alias.name for alias in statement.names))
                module = self.runtime_call(self.pooled(_import_name),
                    ['_namespace', '_builtins', self.constant(statement.module or ''), names,
                     self.pooled(statement.level)], counted=True)
                for alias in statement.names:
                    value = self.operation('_import_from_object', module, self.constant(alias.name))
                    self.assign(ast.Name(id=alias.asname or alias.name, ctx=ast.Store()), value)
            elif isinstance(statement, ast.Import):
                for alias in statement.names:
                    if alias.asname is not None and '.' in alias.name:
                        raise UnsupportedCall('dotted import aliases require import-from handling')
                    value = self.runtime_call(self.pooled(_import_name),
                        ['_namespace', '_builtins', self.constant(alias.name)], counted=True)
                    self.assign(ast.Name(id=alias.asname or alias.name.split('.')[0], ctx=ast.Store()), value)
            elif isinstance(statement, ast.Assign):
                value = self.expression(statement.value)
                for target in statement.targets:
                    self.assign(target, value)
            elif isinstance(statement, ast.Expr):
                if isinstance(statement.value, ast.Call) and type(self) is _Compiler:
                    self.discard_call(statement.value)
                else:
                    self.expression(statement.value)
            elif isinstance(statement, ast.Pass):
                self.line('pass')
            elif isinstance(statement, ast.For):
                if statement.orelse:
                    raise UnsupportedCall('for-else is not supported')
                iterator = self.operation('_getiter_object', self.expression(statement.iter))
                self.line('while True:')
                self.indent += 1
                value = self.fresh()
                self.line(f'{value}, _ended, _ok = _next_object({iterator})')
                self.line('if not _ok:')
                self.indent += 1
                self.line('_capture_error(_errors)')
                self.line('return _errors, False')
                self.indent -= 1
                self.line('if _ended:')
                self.indent += 1
                self.line('break')
                self.indent -= 1
                self.assign(statement.target, value)
                self.statements(statement.body)
                self.indent -= 1
            else:
                raise UnsupportedCall('statement ' + type(statement).__name__)

    def native_namespace(self):
        """Shared operation bindings for sibling/hoisted compiler frontends."""
        from . import _managed_native as refs
        from . import _managed_calls as calls
        from . import _managed_names as names
        from . import _managed_vector as vector
        namespace = {'_capture_error': calls.capture_error, '_call_object': calls.call_object,
                     '_dict_object': calls.dict_object, '_call_in_frame': calls.call_in_frame,
                     '_slice_object': calls.slice_object, '_import_from_object': calls.import_from_object,
                     '_counts_owner': calls.counts_owner,
                     '_read_name_native': names.read_name, '_store_name_native': names.store_name,
                     '_read_global_owned': names.read_global_owned,
                     '_call_vector': vector.call_vector, '_call_vector_in_frame': vector.call_vector_in_frame}
        for name in ('pool_item', 'tuple_object', 'list_object', 'getattr_object', 'getitem_object',
                     'getiter_object', 'next_object', 'truth_object'):
            namespace['_' + name] = getattr(refs, name)
        from ._managed_vector import call_vector_in_frame_result, discard_vector_result
        namespace['_call_vector_in_frame_result'] = call_vector_in_frame_result
        namespace['_discard_vector_result'] = discard_vector_result
        namespace.update(self.intrinsics)
        return namespace

    def root_entry(self, dispatcher, signature):
        from ._managed_entry import prepare
        entry, adapter = prepare(dispatcher)
        self.root_dispatcher = dispatcher
        self.root_adapter = adapter
        return entry

    def lower(self, lines):
        from numba import njit, types
        from . import _managed_native as refs
        source = 'def _run(_pool, _frame, _namespace, _builtins, _errors, _counts):\n' + '\n'.join(lines)
        namespace = self.native_namespace()
        exec(compile(source, '<recompyler managed calls>', 'exec'), namespace)
        run = njit(namespace['_run'])
        signature = (refs.managed,) * 5 + (types.Array(types.int64, 1, 'C'),)
        run.compile(signature)
        return self.root_entry(run, signature), source

    def compile_block(self, body):
        saved = self.lines, self.indent, self.packet_returns
        self.lines, self.indent, self.packet_returns = [], 1, True
        try:
            self.statements(body)
            self.line(f'return {self.pooled(None)}, True')
            run, source = self.lower(self.lines)
            return run
        finally:
            self.lines, self.indent, self.packet_returns = saved

    def compile(self):
        body = self.node.body
        if body and isinstance(body[0], ast.Expr) and isinstance(body[0].value, ast.Constant) and type(body[0].value.value) is str:
            body = body[1:]
        self.statements(body)
        self.line(f'return {self.pooled(None)}, True')
        run, source = self.lower(self.lines)
        return run, tuple(self.pool), source


class CallRegion:
    """Opt-in compiled control flow with managed library calls and no entry replay."""
    compiler_type = _Compiler
    counter_slots = 1

    def __init__(self, fn, *, call_kinds=False):
        self.original = fn
        self.compiled_calls = self.managed_calls = self.fallback_calls = 0
        self.problem = None
        self.run = None
        self.code = fn.__code__
        from ._call_entry import EntryPlan
        self.entry = EntryPlan(fn)
        self._free_scratch = []
        self.managed_call_counts = {}
        self.managed_dispatch_counts = {}
        self.managed_dispatch_calls = 0
        self.call_counter_layout = None
        if call_kinds:
            from ._call_kinds import CounterLayout
            self.call_counter_layout = CounterLayout(self.counter_slots)
            self.counter_slots = self.call_counter_layout.width
        try:
            compiler = self.make_compiler(fn)
            compiler.set_call_counter_layout(self.call_counter_layout)
            self.run, self.pool, self.source = compiler.compile()
        except (UnsupportedCall, ValueError, OSError) as exc:
            self.problem = str(exc)

    def make_compiler(self, fn):
        return self.compiler_type(fn)

    def admit_entry(self, passed):
        return True

    def make_frame(self, passed):
        from ._managed_frames import Frame
        return Frame(self.original,zip(self.entry.names,passed))

    def native_frame(self,owner):
        return owner.native_data

    def record_counters(self, counts):
        self.managed_calls += int(counts[0])
        layout = self.call_counter_layout
        if layout is not None:
            for kind in layout.kinds:
                source, dispatch = layout.slots(kind)
                selected, total = int(counts[source]), int(counts[dispatch])
                if selected:
                    self.managed_call_counts[kind] = self.managed_call_counts.get(kind, 0) + selected
                if total:
                    self.managed_dispatch_counts[kind] = self.managed_dispatch_counts.get(kind, 0) + total
                    self.managed_dispatch_calls += total

    def __call__(self, /, *args, **kwargs):
        # Match a live CPython frame: callbacks may replace region.original.
        original = self.original
        if (not handled_exception_clear() or self.run is None
                or original.__code__ is not self.code or not self.entry.supported):
            self.fallback_calls += 1
            return original(*args, **kwargs)
        try:
            scratch = self._free_scratch.pop()
        except IndexError:
            from ._call_entry import CallScratch
            scratch = CallScratch(self.entry, self.counter_slots)
        try:
            passed = self.entry.bind(original, args, kwargs, scratch)
            if passed is None or not self.admit_entry(passed):
                self.fallback_calls += 1
                return original(*args, **kwargs)
            # A CPython call target/frame pins its function through return and
            # any retained traceback, even if application code replaces original.
            active_original = original
            frame_owner = self.make_frame(passed)
            frame = self.native_frame(frame_owner)
            errors = [None]
            self.compiled_calls += 1
            try:
                scratch.results.extend(self.run(self.pool, frame, original.__globals__,
                                                original.__builtins__, errors, scratch.counts))
            finally:
                self.record_counters(scratch.counts)
            if not scratch.results.pop():
                raise scratch.results.pop().pop()
            # Pop before releasing the slot: a returned exception may retain this
            # frame through a callback traceback. No result owner may remain here.
            return scratch.results.pop()
        finally:
            scratch.results.clear()
            scratch.counts.fill(0)
            self._free_scratch.append(scratch)
