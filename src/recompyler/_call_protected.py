"""CPython protected control around compiled managed blocks."""
import ast
import ctypes
import operator
import sys

from ._call_bridge import UnsupportedCall, _exception_probe


def _transfer_functions():
    if _exception_probe is None or sys.implementation.name != 'cpython' or sys.version_info < (3, 12):
        raise UnsupportedCall('protected regions require CPython raised-exception transfer')
    try:
        incref = ctypes.PYFUNCTYPE(None, ctypes.py_object)(('Py_IncRef', ctypes.pythonapi))
        restore = ctypes.PYFUNCTYPE(None, ctypes.py_object)(('PyErr_SetRaisedException', ctypes.pythonapi))
    except AttributeError:
        raise UnsupportedCall('protected exception transfer is unavailable') from None
    return incref, restore


_INCREF, _RESTORE = _transfer_functions()


def _transfer_error(holder):
    # The setter steals the explicit reference and ctypes propagates that same
    # raised exception without RAISE_VARARGS replacing its existing context.
    # Pop before transfer: no traceback frame retains its own exception.
    _INCREF(holder[0])
    _RESTORE(holder.pop())


def _run_part(part, pool, frame, namespace, builtins, counts):
    errors = [None]
    result, ok = part(pool, frame, namespace, builtins, errors, counts)
    if not ok:
        _transfer_error(result)
    return result


def _driver(body, finalizer):
    def execute(pool, frame, namespace, builtins, counts):
        overridden = False
        failure = [None]
        try:
            try:
                result = _run_part(body, pool, frame, namespace, builtins, counts)
            finally:
                final = _run_part(finalizer, pool, frame, namespace, builtins, counts)
                if final is not None:
                    result, overridden = final, True
        except BaseException:
            if not overridden:
                failure[0] = _exception_probe()
        if failure[0] is not None:
            # Unwind the pending return after the handled exception has been
            # restored, so its finalizer sees the same exception state as Python.
            result = None
            _transfer_error(failure)
        # A suppressed exception can itself be the result. Its traceback includes
        # this frame: empty both packet locals before returning to avoid a cycle.
        returned = [result]
        result = final = None
        return returned.pop()
    return execute


def emit(compiler, node):
    if node.handlers or node.orelse or not node.finalbody:
        raise UnsupportedCall('protected except/else regions are not yet supported')
    if any(isinstance(item, (ast.Break, ast.Continue)) for item in ast.walk(node)):
        raise UnsupportedCall('protected loop exits require a continuation tag')
    body = compiler.compile_block(node.body)
    finalizer = compiler.compile_block(node.finalbody)
    counts = compiler.operation('_counts_owner', '_counts')
    packet = compiler.runtime_call(compiler.pooled(_driver(body, finalizer)),
        ['_pool', '_frame', '_namespace', '_builtins', counts], counted=True)
    returned = compiler.runtime_call(compiler.pooled(operator.is_not), [packet, compiler.pooled(None)])
    truth = compiler.operation('_truth_object', returned)
    compiler.line('if ' + truth + ':')
    compiler.indent += 1
    if compiler.packet_returns:
        compiler.line('return ' + packet + ', True')
    else:
        value = compiler.operation('_getitem_object', packet, compiler.pooled(1))
        compiler.line('return ' + value + ', True')
    compiler.indent -= 1
