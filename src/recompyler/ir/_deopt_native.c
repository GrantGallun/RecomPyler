/* Adapted from CinderX Jit/deopt.cpp reifyFrameImpl/MemoryView @ f3dc0e8.
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
#define Py_BUILD_CORE_MODULE
#include <Python.h>
#include <stdint.h>
#include <string.h>
#include "internal/pycore_interpframe.h"
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG)
#error Deopt requires release GIL-enabled CPython 3.14.4
#endif

typedef struct {
    PyObject_HEAD
    PyCodeObject *code;
    PyObject *weak_code;
    Py_ssize_t cause, next, nlocals, nstack, nvalues, required;
    Py_ssize_t *locals, *stack, *locations, *kinds;
} Plan;
static PyTypeObject PlanType;
static int traverse(Plan *p,visitproc visit,void *arg) {Py_VISIT(p->code);Py_VISIT(p->weak_code);return 0;}
static int clear(Plan *p) {Py_CLEAR(p->code);Py_CLEAR(p->weak_code);return 0;}
static void dealloc(Plan *p) {
    PyObject_GC_UnTrack(p);clear(p);PyMem_Free(p->locals);Py_TYPE(p)->tp_free((PyObject*)p);
}
static PyTypeObject PlanType={
    PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler.ir.DeoptPlan",.tp_basicsize=sizeof(Plan),
    .tp_flags=Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC,
    .tp_dealloc=(destructor)dealloc,.tp_traverse=(traverseproc)traverse,.tp_clear=(inquiry)clear
};
static PyObject *plan(PyObject *module,PyObject *args) {
    PyObject *code,*locals,*stack,*locations,*kinds;
    Py_ssize_t cause,next;int weak_code=0;
    if (!PyArg_ParseTuple(args,"O!nnO!O!O!O!|p:plan",&PyCode_Type,&code,&cause,&next,
            &PyTuple_Type,&locals,&PyTuple_Type,&stack,&PyTuple_Type,&locations,&PyTuple_Type,&kinds,&weak_code))return NULL;
    PyCodeObject *co=(PyCodeObject*)code;
    Py_ssize_t nl=PyTuple_GET_SIZE(locals),ns=PyTuple_GET_SIZE(stack),nv=PyTuple_GET_SIZE(locations);
    if (nl!=co->co_nlocalsplus || ns>co->co_stacksize || nv!=PyTuple_GET_SIZE(kinds)
            || cause<0 || next<0 || cause>=_PyCode_NBYTES(co) || next>=_PyCode_NBYTES(co) || (cause|next)&1) {
        PyErr_SetString(PyExc_ValueError,"invalid deopt plan shape or PC");return NULL;
    }
    Plan *p=PyObject_GC_New(Plan,&PlanType);
    if(!p)return NULL;
    p->code=weak_code?NULL:(PyCodeObject*)Py_NewRef(code);
    p->weak_code=weak_code?PyWeakref_NewRef(code,NULL):NULL;
    if(weak_code && !p->weak_code){PyObject_GC_Del(p);return NULL;}
    p->cause=cause;p->next=next;
    p->nlocals=nl;p->nstack=ns;p->nvalues=nv;p->required=0;
    p->locals=PyMem_Calloc((size_t)(nl+ns+2*nv+1),sizeof(Py_ssize_t));
    if(!p->locals){clear(p);PyObject_GC_Del(p);return PyErr_NoMemory();}
    p->stack=p->locals+nl;p->locations=p->stack+ns;p->kinds=p->locations+nv;
    PyObject_GC_Track(p);
    for(int group=0;group<4;group++) {
        PyObject *tuple=group==0?locals:group==1?stack:group==2?locations:kinds;
        Py_ssize_t *out=group==0?p->locals:group==1?p->stack:group==2?p->locations:p->kinds;
        for(Py_ssize_t j=0;j<PyTuple_GET_SIZE(tuple);j++) {
            PyObject *value=PyTuple_GET_ITEM(tuple,j);
            if(!PyLong_CheckExact(value)) {PyErr_SetString(PyExc_TypeError,"integer map required");Py_DECREF(p);return NULL;}
            Py_ssize_t v=PyLong_AsSsize_t(value);
            if(PyErr_Occurred()){Py_DECREF(p);return NULL;}
            if((group<2 && (v< -1 || v>=nv)) || (group==2 && (v<0 || v>65535)) || (group==3 && (v<0 || v>4))) {
                PyErr_SetString(PyExc_ValueError,"invalid deopt map entry");Py_DECREF(p);return NULL;
            }
            out[j]=v;
            if(group==2 && v>=p->required)p->required=v+1;
        }
    }
    return (PyObject*)p;
}
/* Trusted compiler ABI. frame must be the active original interpreter frame.
 * Reification fills absent slots or reproduces existing owners. It refuses stale
 * owners: retiring a source local late would itself change finalizer timing.
 * References in the spill table remain the caller's responsibility; object
 * inputs are borrowed and each destination acquires its own stackref.
 */
static int reify(_PyInterpreterFrame *frame,PyObject *plan_object,const uint64_t *raw,Py_ssize_t count) {
    if(!Py_IS_TYPE(plan_object,&PlanType)) {PyErr_SetString(PyExc_TypeError,"deopt plan required");return -1;}
    Plan *p=(Plan*)plan_object;
    PyObject *expected=p->weak_code?PyWeakref_GetObject(p->weak_code):(PyObject *)p->code;
    PyCodeObject *code=(PyCodeObject *)expected;
    if(!expected || !PyCode_Check(expected) || !frame || PyThreadState_Get()->current_frame!=frame || _PyFrame_GetCode(frame)!=code
            || count<p->required || !frame->stackpointer || (count && !raw)) {
        PyErr_SetString(PyExc_RuntimeError,"deopt requires matching active frame and live table");return -1;
    }
    PyObject *pending=PyErr_GetRaisedException();
    PyObject **boxed=PyMem_Calloc((size_t)(p->nvalues+1),sizeof(PyObject*));
    _PyStackRef *slots=PyMem_Calloc((size_t)(p->nlocals+p->nstack+1),sizeof(_PyStackRef));
    Py_ssize_t built=0;
    int status=-1;
    if(!boxed || !slots){PyErr_NoMemory();goto done;}
    for(Py_ssize_t j=0;j<p->nvalues;j++) {
        uint64_t value=raw[p->locations[j]];
        switch(p->kinds[j]) {
            case 0: boxed[j]=value?Py_NewRef((PyObject*)(uintptr_t)value):NULL;break;
            case 1: boxed[j]=PyLong_FromLongLong((int64_t)value);break;
            case 2: boxed[j]=PyLong_FromUnsignedLongLong(value);break;
            case 3: {double d;memcpy(&d,&value,sizeof(d));boxed[j]=PyFloat_FromDouble(d);break;}
            case 4: boxed[j]=PyBool_FromLong(value!=0);break;
        }
        if(!boxed[j] && (p->kinds[j]!=0 || value)){goto done;}
    }
    for(Py_ssize_t j=0;j<p->nlocals+p->nstack;j++) {
        Py_ssize_t index=j<p->nlocals?p->locals[j]:p->stack[j-p->nlocals];
        PyObject *value=index<0?NULL:boxed[index];
        if(j>=p->nlocals && index>=0 && !value) {
            PyErr_SetString(PyExc_RuntimeError,"NULL live object cannot populate an operand slot");goto done;
        }
        if(j<p->nlocals && (PyBytes_AS_STRING(code->co_localspluskinds)[j] & (CO_FAST_CELL|CO_FAST_FREE))
                && (!value || !PyCell_Check(value))) {
            PyErr_SetString(PyExc_RuntimeError,"deopt cell slot requires a real cell");goto done;
        }
        slots[j]=value?PyStackRef_FromPyObjectNew(value):PyStackRef_NULL;
        built++;
    }
    Py_ssize_t old_count=frame->stackpointer-frame->localsplus;
    if(old_count<p->nlocals || old_count>p->nlocals+code->co_stacksize) {
        PyErr_SetString(PyExc_RuntimeError,"invalid published frame stack");goto done;
    }
    for(Py_ssize_t j=0;j<old_count;j++) {
        _PyStackRef old=frame->localsplus[j];
        if(!PyStackRef_IsNull(old) && (j>=built || PyStackRef_IsNull(slots[j]) ||
                PyStackRef_AsPyObjectBorrow(old)!=PyStackRef_AsPyObjectBorrow(slots[j]))) {
            PyErr_SetString(PyExc_RuntimeError,"stale source owner must be retired before deopt");goto done;
        }
    }
    /* Every old owner has an identical new owner, so no finalizer can run here. */
    for(Py_ssize_t j=0;j<built;j++) {
        _PyStackRef old=j<old_count?frame->localsplus[j]:PyStackRef_NULL;
        frame->localsplus[j]=slots[j];slots[j]=PyStackRef_NULL;
        PyStackRef_XCLOSE(old);
    }
    frame->stackpointer=frame->localsplus+built;
    frame->instr_ptr=_PyFrame_GetBytecode(frame)+(pending?p->cause:p->next)/2;
    status=0;
 done:
    for(Py_ssize_t j=0;j<built;j++)PyStackRef_XCLOSE(slots[j]);
    if(boxed)for(Py_ssize_t j=0;j<p->nvalues;j++)Py_XDECREF(boxed[j]);
    PyMem_Free(slots);PyMem_Free(boxed);
    if(status==0 && pending)PyErr_SetRaisedException(pending);else Py_XDECREF(pending);
    return status;
}
static PyObject *addresses(PyObject *module,PyObject *ignored) {
    return Py_BuildValue("{s:K}","reify",(unsigned long long)(uintptr_t)reify);
}
static PyMethodDef methods[]={{"plan",plan,METH_VARARGS,NULL},{"addresses",addresses,METH_NOARGS,NULL},{NULL}};
static PyModuleDef definition={PyModuleDef_HEAD_INIT,"_deopt_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__deopt_native(void) {
    if(PyType_Ready(&PlanType)<0)return NULL;
    return PyModule_Create(&definition);
}
