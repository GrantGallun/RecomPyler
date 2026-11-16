/* Exact-version borrowed internals exported to the shared IR backend. */
#include "borrowed_portability.h"
#include "borrowed_314.c"
#include <stdint.h>
static PyObject *make_slice(PyObject *module,PyObject *args) {
    PyObject *start,*stop;
    if(!PyArg_ParseTuple(args,"OO:make_slice",&start,&stop))return NULL;
    return RcBorrow_BuildSliceConsumeRefs(Py_NewRef(start),Py_NewRef(stop));
}
static PyObject *addresses(PyObject *module,PyObject *unused) {
    return Py_BuildValue("{s:K}","build_slice_consume_refs",(unsigned long long)(uintptr_t)RcBorrow_BuildSliceConsumeRefs);
}
static PyMethodDef methods[]={{"make_slice",make_slice,METH_VARARGS,NULL},{"addresses",addresses,METH_NOARGS,NULL},{NULL}};
static PyModuleDef definition={PyModuleDef_HEAD_INIT,"_borrowed_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__borrowed_native(void){return PyModule_Create(&definition);}
