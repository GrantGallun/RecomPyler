/* Build-time only: each definition is compiled to one immutable stencil.
 * Runtime code only copies and patches these bytes. No LLVM runtime is used. */
#include "Python.h"
#include <stdint.h>
PyAPI_FUNC(int) rc_ir_callback_free_guard(void);
PyAPI_FUNC(PyObject *) rc_ir_saved_vectorcall(PyObject *, PyObject *const *, size_t, PyObject *);
PyAPI_FUNC(PyObject *) _JIT_CONTINUE(PyObject *, PyObject *const *, size_t, PyObject *);
PyAPI_DATA(const char) _JIT_OPERAND0;

PyObject *_JIT_ENTRY(PyObject *fn, PyObject *const *args, size_t aux, PyObject *top)
{
#if defined(RP_ENTRY)
    if (PyVectorcall_NARGS(aux) != (size_t)&_JIT_OPERAND0 || top || !rc_ir_callback_free_guard()) {
        __attribute__((musttail)) return rc_ir_saved_vectorcall(fn, args, aux, top);
    }
    __attribute__((musttail)) return _JIT_CONTINUE(fn, args, 0, NULL);
#elif defined(RP_ARG)
    __attribute__((musttail)) return _JIT_CONTINUE(fn, args, (size_t)top, args[(size_t)&_JIT_OPERAND0]);
#elif defined(RP_CONST)
    PyCodeObject *code = (PyCodeObject *)PyFunction_GET_CODE(fn);
    PyObject *value = PyTuple_GET_ITEM(code->co_consts, (size_t)&_JIT_OPERAND0);
    __attribute__((musttail)) return _JIT_CONTINUE(fn, args, (size_t)top, value);
#elif defined(RP_RETURN)
    Py_INCREF(top);
    return top;
#else
#error "Choose a stencil"
#endif
}
