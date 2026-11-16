/* Correctness-only function-identity probe; never used in timed code. */
#define PY_SSIZE_T_CLEAN
#define Py_BUILD_CORE_MODULE
#include <Python.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error Requires release GIL-enabled CPython 3.14.4
#endif
#include "internal/pycore_frame.h"
#include "internal/pycore_interpframe.h"

static PyObject *function(PyObject *module, PyObject *object) {
    if (!PyFrame_Check(object)) {
        PyErr_SetString(PyExc_TypeError, "expected a frame");
        return NULL;
    }
    _PyInterpreterFrame *frame = ((PyFrameObject *)object)->f_frame;
    if (!frame || PyStackRef_IsNull(frame->f_funcobj)) Py_RETURN_NONE;
    PyObject *target = PyStackRef_AsPyObjectBorrow(frame->f_funcobj);
    if (!PyFunction_Check(target)) Py_RETURN_NONE;
    return Py_NewRef(target);
}
static PyMethodDef methods[] = {
    {"function", function, METH_O, "Return the actual function owning a frame."},
    {NULL, NULL, 0, NULL}
};
static struct PyModuleDef module = {PyModuleDef_HEAD_INIT, "_frame_function_native", NULL, -1, methods};
PyMODINIT_FUNC PyInit__frame_function_native(void) {
    if (Py_Version != PY_VERSION_HEX) {
        PyErr_SetString(PyExc_ImportError, "frame probe requires matching CPython build");
        return NULL;
    }
    return PyModule_Create(&module);
}
