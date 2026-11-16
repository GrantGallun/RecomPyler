/* Isolated-test extension. It neither exposes offsets nor changes user state.
 * The real exported METH_O checker is invoked directly without callbacks. */
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#define Py_BUILD_CORE
#include "internal/pycore_runtime.h"
#include "internal/pycore_lock.h"
#undef Py_BUILD_CORE

static PyObject *exercise(PyObject *self, PyObject *const *args, Py_ssize_t nargs) {
    if (nargs!=2 || !PyCFunction_Check(args[0]) || !PyLong_CheckExact(args[1])) {
        PyErr_SetString(PyExc_TypeError,"expected native METH_O checker and mode");return NULL;
    }
    if (PyCFunction_GET_FLAGS(args[0])!=METH_O) {
        PyErr_SetString(PyExc_TypeError,"expected exact METH_O ABI");return NULL;
    }
    PyObject *dict=PyDict_New();if (dict==NULL) return NULL;
    PyCFunction fn=PyCFunction_GET_FUNCTION(args[0]);PyObject *owner=PyCFunction_GET_SELF(args[0]);
    long mode=PyLong_AsLong(args[1]);PyObject *result;
    if (mode==0) {
        if (!PyMutex_LockFast(&_PyRuntime.audit_hooks.mutex)) {Py_DECREF(dict);Py_RETURN_FALSE;}
        result=fn(owner,dict);
        PyMutex_Unlock(&_PyRuntime.audit_hooks.mutex);
        Py_DECREF(dict);
        if (result==NULL) return NULL;
        int declined=result==Py_None;Py_DECREF(result);
        return PyBool_FromLong(declined);
    }
    /* Force an owned worker NULL result, then verify the single outer cleanup.
     * Error allocation is before entry, not inside the held interval. */
    PyErr_SetString(PyExc_RuntimeError,"owned pending error");
    result=fn(owner,dict);
    int expected=result==NULL && PyErr_ExceptionMatches(PyExc_RuntimeError);
    Py_XDECREF(result);PyErr_Clear();Py_DECREF(dict);
    if (!PyMutex_LockFast(&_PyRuntime.audit_hooks.mutex)) Py_RETURN_FALSE;
    PyMutex_Unlock(&_PyRuntime.audit_hooks.mutex);
    return PyBool_FromLong(expected);
}
static PyObject *available(PyObject *self,PyObject *unused) {
    if (!PyMutex_LockFast(&_PyRuntime.audit_hooks.mutex)) Py_RETURN_FALSE;
    PyMutex_Unlock(&_PyRuntime.audit_hooks.mutex);Py_RETURN_TRUE;
}
static PyMethodDef methods[]={
 {"exercise",(PyCFunction)(void (*)(void))exercise,METH_FASTCALL,"Exercise busy and NULL-result cleanup in an isolated process."},
 {"available",available,METH_NOARGS,"Observe unlocked audit mutex in the isolated test process."},
 {NULL,NULL,0,NULL}};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_guard_probe",NULL,-1,methods};
PyMODINIT_FUNC PyInit__guard_probe(void){return PyModule_Create(&module);}
