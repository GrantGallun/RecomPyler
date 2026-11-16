/* Global lookup modelled on CinderX Jit/hir/preload.cpp @ f3dc0e8.
MIT License

Copyright (c) Meta Platforms, Inc. and affiliates.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG)
#error Preloading requires release GIL-enabled CPython 3.14.4
#endif
static int unicode_keys(PyObject *dict) {
    Py_ssize_t position=0;PyObject *key,*value;
    while(PyDict_Next(dict,&position,&key,&value))
        if(!PyUnicode_CheckExact(key))return 0;
    return 1;
}
static PyObject *lookup(PyObject *module,PyObject *args) {
    PyObject *globals,*builtins,*name;
    if(!PyArg_ParseTuple(args,"OOO:lookup",&globals,&builtins,&name))return NULL;
    if(!PyDict_CheckExact(globals)||!PyDict_CheckExact(builtins)||!PyUnicode_CheckExact(name)) {
        PyErr_SetString(PyExc_TypeError,"exact dicts and Unicode global name required");return NULL;
    }
    /* No allocations/callbacks between key validation and lookup: foreign keys
       cannot inject equality/hash code into compilation's namespace reads. */
    if(!unicode_keys(globals)||!unicode_keys(builtins)) {
        PyErr_SetString(PyExc_ValueError,"namespace contains non-exact Unicode keys");return NULL;
    }
    PyObject *value=NULL;
    int origin=0;int found=PyDict_GetItemRef(globals,name,&value);
    if(found<0)return NULL;
    if(!found){origin=1;found=PyDict_GetItemRef(builtins,name,&value);if(found<0)return NULL;}
    if(!found){origin=-1;value=Py_NewRef(Py_None);}
    return Py_BuildValue("(iN)",origin,value);
}
static PyMethodDef methods[]={{"lookup",lookup,METH_VARARGS,NULL},{NULL}};
static PyModuleDef definition={PyModuleDef_HEAD_INIT,"_preload_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__preload_native(void){return PyModule_Create(&definition);}
