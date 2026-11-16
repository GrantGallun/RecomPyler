/* Experimental borrowed-operand dispatcher. Canonical source calls own cleanup. */
#define PY_SSIZE_T_CLEAN
#define Py_BUILD_CORE_MODULE
#include <Python.h>
#include "internal/pycore_call.h"
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error Requires release GIL-enabled CPython 3.14.4
#endif

typedef PyObject *(*FastCall)(PyObject *, PyObject *const *, Py_ssize_t);
typedef struct { PyObject *weak; PyCFunction entry; vectorcallfunc vectorcall; int flags; } Guard;
static vectorcallfunc canonical_o, canonical_fast;
static const char *guard_name="recompyler.library.c_guard";

static void guard_free(PyObject *capsule) {
    Guard *guard=PyCapsule_GetPointer(capsule,guard_name);
    if (guard) { Py_DECREF(guard->weak); PyMem_Free(guard); }
    else PyErr_Clear();
}
static PyObject *new_guard(PyObject *self, PyObject *target) {
    if (Py_TYPE(target)!=&PyCFunction_Type) {
        PyErr_SetString(PyExc_TypeError,"an exact builtin function is required");return NULL;
    }
    PyObject *weak=PyWeakref_NewRef(target,NULL);
    if (!weak)return NULL;
    Guard *guard=PyMem_Malloc(sizeof(*guard));
    if (!guard) {Py_DECREF(weak);return PyErr_NoMemory();}
    guard->weak=weak;guard->flags=PyCFunction_GET_FLAGS(target);
    guard->entry=PyCFunction_GET_FUNCTION(target);
    guard->vectorcall=PyVectorcall_Function(target);
    PyObject *capsule=PyCapsule_New(guard,guard_name,guard_free);
    if (!capsule) {Py_DECREF(weak);PyMem_Free(guard);}
    return capsule;
}

__declspec(dllexport) PyObject *rc_library_c_call(PyObject *callable,
        PyObject *const *arguments, size_t nargsf, PyObject *names, void *opaque) {
    Guard *guard=(Guard *)opaque;
    Py_ssize_t nargs=PyVectorcall_NARGS(nargsf);
    if (!guard || names || Py_TYPE(callable)!=&PyCFunction_Type ||
            PyWeakref_GetObject(guard->weak)!=callable ||
            PyCFunction_GET_FUNCTION(callable)!=guard->entry ||
            PyCFunction_GET_FLAGS(callable)!=guard->flags ||
            PyVectorcall_Function(callable)!=guard->vectorcall ||
            !((guard->flags==METH_O && nargs==1 && guard->vectorcall==canonical_o) ||
              (guard->flags==METH_FASTCALL && guard->vectorcall==canonical_fast))) {
        return PyObject_Vectorcall(callable,arguments,nargsf,names);
    }
    if (Py_EnterRecursiveCall(" while calling a Python object"))return NULL;
    PyObject *result;
    if (guard->flags==METH_O)
        result=guard->entry(PyCFunction_GET_SELF(callable),arguments[0]);
    else
        result=((FastCall)guard->entry)(PyCFunction_GET_SELF(callable),arguments,nargs);
    Py_LeaveRecursiveCall();
    return _Py_CheckFunctionResult(PyThreadState_Get(),callable,result,NULL);
}

static int eligible(Guard *guard,PyObject *callable,Py_ssize_t nargs) {
    return Py_TYPE(callable)==&PyCFunction_Type && PyWeakref_GetObject(guard->weak)==callable &&
        guard->entry==PyCFunction_GET_FUNCTION(callable) && guard->flags==PyCFunction_GET_FLAGS(callable) &&
        guard->vectorcall==PyVectorcall_Function(callable) &&
        ((guard->flags==METH_O && nargs==1 && guard->vectorcall==canonical_o) ||
         (guard->flags==METH_FASTCALL && guard->vectorcall==canonical_fast));
}
static PyObject *invoke(PyObject *self,PyObject *args) {
    PyObject *capsule,*callable,*arguments,*keywords=Py_None;
    if (!PyArg_ParseTuple(args,"OOO!|O",&capsule,&callable,&PyTuple_Type,&arguments,&keywords))return NULL;
    Guard *guard=PyCapsule_GetPointer(capsule,guard_name);
    if (!guard)return NULL;
    PyObject *result;int hit=0;
    if (keywords!=Py_None) {
        if (!PyDict_Check(keywords)) {PyErr_SetString(PyExc_TypeError,"keyword dictionary required");return NULL;}
        result=PyObject_Call(callable,arguments,keywords);
    } else {
        Py_ssize_t count=PyTuple_GET_SIZE(arguments);
        hit=eligible(guard,callable,count);
        result=rc_library_c_call(callable,((PyTupleObject *)arguments)->ob_item,(size_t)count,NULL,guard);
    }
    if (!result)return NULL;
    PyObject *tuple=PyTuple_New(2);
    if (!tuple) {Py_DECREF(result);return NULL;}
    PyTuple_SET_ITEM(tuple,0,result);PyTuple_SET_ITEM(tuple,1,PyBool_FromLong(hit));
    return tuple;
}
static PyObject *address(PyObject *self,PyObject *capsule) {
    Guard *guard=PyCapsule_GetPointer(capsule,guard_name);
    return guard ? PyLong_FromVoidPtr(guard) : NULL;
}
static PyObject *dispatcher_address(PyObject *self,PyObject *unused) {
    return PyLong_FromVoidPtr((void *)rc_library_c_call);
}
static PyObject *dummy_o(PyObject *self,PyObject *value) {return Py_NewRef(value);}
static PyObject *dummy_fast(PyObject *self,PyObject *const *values,Py_ssize_t count) {Py_RETURN_NONE;}
static PyMethodDef dummy_methods[]={
    {"_o",dummy_o,METH_O,NULL},
    {"_fast",(PyCFunction)dummy_fast,METH_FASTCALL,NULL}
};
static PyMethodDef methods[]={
    {"new_guard",new_guard,METH_O,NULL},
    {"invoke",invoke,METH_VARARGS,NULL},
    {"address",address,METH_O,NULL},
    {"dispatcher_address",dispatcher_address,METH_NOARGS,NULL},
    {NULL,NULL,0,NULL}
};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_boundary_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__boundary_native(void) {
    if (Py_Version!=PY_VERSION_HEX) {PyErr_SetString(PyExc_ImportError,"boundary ABI mismatch");return NULL;}
    PyObject *o=PyCFunction_New(&dummy_methods[0],NULL),*fast=PyCFunction_New(&dummy_methods[1],NULL);
    if (!o || !fast) {Py_XDECREF(o);Py_XDECREF(fast);return NULL;}
    canonical_o=PyVectorcall_Function(o);canonical_fast=PyVectorcall_Function(fast);
    Py_DECREF(o);Py_DECREF(fast);
    return PyModule_Create(&module);
}
