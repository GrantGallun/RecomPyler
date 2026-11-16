/* Guard-only ndarray primitives. Misses leave callbacks/errors to StructureCalls. */
#define PY_SSIZE_T_CLEAN
#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
#include <Python.h>
#include <numpy/arrayobject.h>
#include <stdint.h>
#include <string.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error Requires release GIL-enabled CPython 3.14.4
#endif

static PyArrayObject *array_guard(PyObject *owner) {
    if (!PyArray_CheckExact(owner))return NULL;
    PyArrayObject *array=(PyArrayObject *)owner;
    int kind=PyArray_TYPE(array);
    if (PyArray_NDIM(array)!=1 || !PyArray_IS_C_CONTIGUOUS(array) ||
            !PyArray_ISALIGNED(array) || !PyArray_ISNOTSWAPPED(array) ||
            (kind!=NPY_FLOAT64 && kind!=NPY_INT64))return NULL;
    return array;
}
static int index_guard(PyArrayObject *array,PyObject *key,npy_intp *index) {
    if (!PyLong_CheckExact(key))return 0;
    int overflow=0;
    long long value=PyLong_AsLongLongAndOverflow(key,&overflow);
    if (overflow)return 0;
    if (PyErr_Occurred())return -1;
    npy_intp size=PyArray_DIM(array,0);
    if (value<0)value+=size;
    if (value<0 || (unsigned long long)value>=(unsigned long long)size)return 0;
    *index=(npy_intp)value;return 1;
}

__declspec(dllexport) PyObject *rc_numpy_try_load(PyObject *owner,PyObject *key,int *matched) {
    *matched=0;
    PyArrayObject *array=array_guard(owner);
    if (!array)return NULL;
    npy_intp index;
    int status=index_guard(array,key,&index);
    if (!status)return NULL;
    *matched=1;
    if (status<0)return NULL;
    /* No pointer is retained across operations or the scalar allocation. */
    unsigned char value[sizeof(npy_int64)];
    memcpy(value,PyArray_BYTES(array)+index*PyArray_ITEMSIZE(array),sizeof(value));
    return PyArray_Scalar(value,PyArray_DESCR(array),NULL);
}
__declspec(dllexport) int rc_numpy_try_store(PyObject *owner,PyObject *key,PyObject *value,int *matched) {
    *matched=0;
    PyArrayObject *array=array_guard(owner);
    if (!array || !PyArray_ISWRITEABLE(array))return 0;
    npy_intp index;
    int status=index_guard(array,key,&index);
    if (!status)return 0;
    if (status<0) {*matched=1;return -1;}
    unsigned char raw[sizeof(npy_int64)];
    if (PyArray_TYPE(array)==NPY_FLOAT64) {
        double number;
        if (PyFloat_CheckExact(value))number=PyFloat_AS_DOUBLE(value);
        else if (Py_IS_TYPE(value,&PyFloat64ArrType_Type))PyArray_ScalarAsCtype(value,&number);
        else return 0;
        if (PyErr_Occurred()) {*matched=1;return -1;}
        memcpy(raw,&number,sizeof(number));
    } else {
        npy_int64 number;
        if (PyLong_CheckExact(value)) {
            int overflow=0;
            long long integer=PyLong_AsLongLongAndOverflow(value,&overflow);
            if (overflow)return 0;
            if (PyErr_Occurred()) {*matched=1;return -1;}
            number=(npy_int64)integer;
        } else if (Py_IS_TYPE(value,&PyInt64ArrType_Type)) {
            PyArray_ScalarAsCtype(value,&number);
            if (PyErr_Occurred()) {*matched=1;return -1;}
        } else return 0;
        memcpy(raw,&number,sizeof(number));
    }
    *matched=1;
    memcpy(PyArray_BYTES(array)+index*PyArray_ITEMSIZE(array),raw,sizeof(raw));
    return 0;
}
__declspec(dllexport) Py_ssize_t rc_numpy_try_length(PyObject *owner,int *matched) {
    PyArrayObject *array=array_guard(owner);
    *matched=array!=NULL;
    return array ? (Py_ssize_t)PyArray_DIM(array,0) : 0;
}

static PyObject *load(PyObject *self,PyObject *args) {
    PyObject *owner,*key;
    if (!PyArg_ParseTuple(args,"OO",&owner,&key))return NULL;
    int matched;PyObject *value=rc_numpy_try_load(owner,key,&matched);
    if (!value) {if (matched)return NULL;value=Py_NewRef(Py_None);}
    PyObject *result=PyTuple_New(2);
    if (!result) {Py_DECREF(value);return NULL;}
    PyTuple_SET_ITEM(result,0,value);PyTuple_SET_ITEM(result,1,PyBool_FromLong(matched));return result;
}
static PyObject *store(PyObject *self,PyObject *args) {
    PyObject *owner,*key,*value;
    if (!PyArg_ParseTuple(args,"OOO",&owner,&key,&value))return NULL;
    int matched;
    if (rc_numpy_try_store(owner,key,value,&matched)<0)return NULL;
    return PyBool_FromLong(matched);
}
static PyObject *length(PyObject *self,PyObject *owner) {
    int matched;Py_ssize_t value=rc_numpy_try_length(owner,&matched);
    return Py_BuildValue("nO",value,matched ? Py_True : Py_False);
}
static PyObject *addresses(PyObject *self,PyObject *unused) {
    return Py_BuildValue("{s:K,s:K,s:K}",
        "load",(unsigned long long)(uintptr_t)rc_numpy_try_load,
        "store",(unsigned long long)(uintptr_t)rc_numpy_try_store,
        "length",(unsigned long long)(uintptr_t)rc_numpy_try_length);
}
static PyMethodDef methods[]={
    {"load",load,METH_VARARGS,NULL},{"store",store,METH_VARARGS,NULL},
    {"length",length,METH_O,NULL},{"addresses",addresses,METH_NOARGS,NULL},{NULL,NULL,0,NULL}
};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_numpy_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__numpy_native(void) {
    if (Py_Version!=PY_VERSION_HEX) {PyErr_SetString(PyExc_ImportError,"ndarray ABI mismatch");return NULL;}
    if (_import_array()<0)return NULL;
    if (sizeof(npy_intp)!=sizeof(Py_ssize_t) || sizeof(npy_int64)!=8 || sizeof(double)!=8) {
        PyErr_SetString(PyExc_ImportError,"unsupported ndarray scalar layout");return NULL;
    }
    return PyModule_Create(&module);
}
