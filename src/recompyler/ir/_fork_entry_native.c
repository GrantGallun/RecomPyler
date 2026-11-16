/* Fork-only adapter for the canonical real-frame LLVM ABI. */
#define PY_SSIZE_T_CLEAN
#define Py_BUILD_CORE_MODULE
#include <Python.h>
#include <stdint.h>
#include "rp_native.h"
#include "internal/pycore_frame.h"
#include "internal/pycore_interpframe.h"
#include "opcode_ids.h"
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG)
#error Fork frame backend requires release GIL-enabled CPython 3.14.4
#endif

typedef _Py_CODEUNIT *(*FrameBody)(_PyInterpreterFrame *, _PyStackRef *, PyThreadState *);
typedef int (*Observers)(_PyInterpreterFrame *);
typedef struct {
    Py_ssize_t offset;
    FrameBody body;
    int event;
} ForkEntry;
typedef struct {
    PyObject_HEAD
    PyObject *function_ref, *code_ref, *owners, *bytecode, *provider;
    ForkEntry *entries;
    Py_ssize_t size;
    Observers observed;
    int count, borrow_guards;
    unsigned long long calls, start, resume, backedge, yields, returns, declines;
} ForkOwner;
static PyTypeObject ForkOwner_Type;

static int owner_traverse(ForkOwner *self, visitproc visit, void *arg) {
    Py_VISIT(self->function_ref); Py_VISIT(self->code_ref); Py_VISIT(self->owners);
    Py_VISIT(self->bytecode); Py_VISIT(self->provider); return 0;
}
static int owner_clear(ForkOwner *self) {
    Py_CLEAR(self->function_ref); Py_CLEAR(self->code_ref); Py_CLEAR(self->owners);
    Py_CLEAR(self->bytecode); Py_CLEAR(self->provider); return 0;
}
static void owner_dealloc(ForkOwner *self) {
    PyObject_GC_UnTrack(self); owner_clear(self); PyMem_Free(self->entries);
    Py_TYPE(self)->tp_free((PyObject *)self);
}
static PyTypeObject ForkOwner_Type = {
    PyVarObject_HEAD_INIT(NULL, 0)
    .tp_name="recompyler.ir.ForkExecutionOwner", .tp_basicsize=sizeof(ForkOwner),
    .tp_flags=Py_TPFLAGS_DEFAULT | Py_TPFLAGS_HAVE_GC,
    .tp_dealloc=(destructor)owner_dealloc, .tp_traverse=(traverseproc)owner_traverse,
    .tp_clear=(inquiry)owner_clear,
};
static int decline(ForkOwner *self) {
    if (self->count) self->declines++;
    return Py_RP_DECLINE;
}
static int dispatch(PyThreadState *thread, _PyInterpreterFrame *frame, int event,
                    PyObject *object, PyObject **result) {
    ForkOwner *self=(ForkOwner *)object;
    PyObject *function=NULL, *code_object=NULL;
    if (!self->function_ref || !self->code_ref) return decline(self);
    if (self->borrow_guards) {
        /* GIL-held, callback-free guards only. The executing real frame owns
           its function/code. No borrowed source survives the body call. */
        function=PyWeakref_GET_OBJECT(self->function_ref);
        code_object=PyWeakref_GET_OBJECT(self->code_ref);
        if (function==Py_None) function=NULL;
        if (code_object==Py_None) code_object=NULL;
    }
    else {
        if (PyWeakref_GetRef(self->function_ref, &function)<0) return Py_RP_ERROR;
        if (PyWeakref_GetRef(self->code_ref, &code_object)<0) { Py_XDECREF(function); return Py_RP_ERROR; }
    }
    PyCodeObject *code=_PyFrame_GetCode(frame);
    int valid=function && code_object && code_object==(PyObject *)code &&
        PyFunction_GET_CODE(function)==(PyObject *)code &&
        PyStackRef_AsPyObjectBorrow(frame->f_funcobj)==function &&
        thread->current_frame==frame;
    if (!self->borrow_guards) { Py_XDECREF(function); Py_XDECREF(code_object); }
    if (!valid) return decline(self);
    Py_ssize_t pc=(frame->instr_ptr-_PyCode_CODE(code))*2;
    FrameBody body=NULL;
    for (Py_ssize_t i=0;i<self->size;i++) {
        if (self->entries[i].offset==pc && self->entries[i].event==event) {
            body=self->entries[i].body; break;
        }
    }
    if (!body) return decline(self);
    if (self->count) {
        self->calls++;
        if (event==Py_RP_START) self->start++;
        else if (event==Py_RP_RESUME) self->resume++;
        else if (event==Py_RP_BACKEDGE) self->backedge++;
    }
    _Py_CODEUNIT *next=body(frame,frame->stackpointer,thread);
    if (!next) {
        if (!PyErr_Occurred()) PyErr_SetString(PyExc_SystemError,"fork LLVM body returned NULL without error");
        return Py_RP_ERROR;
    }
    uintptr_t base=(uintptr_t)_PyCode_CODE(code), address=(uintptr_t)next;
    Py_ssize_t byte_size=PyBytes_GET_SIZE(self->bytecode);
    if (address<base || address-base>=(uintptr_t)byte_size || (address-base)%2) {
        PyErr_SetString(PyExc_SystemError,"fork LLVM body returned invalid continuation");
        return Py_RP_ERROR;
    }
    frame->instr_ptr=next;
    /* An unknown call can install observers while LLVM is active. Leave its
       saved stack intact and execute the original next opcode in that case. */
    if (self->observed(frame)) return Py_RP_CONTINUE;
    unsigned char *bytes=(unsigned char *)PyBytes_AS_STRING(self->bytecode);
    Py_ssize_t offset=(Py_ssize_t)(address-base);
    int opcode=bytes[offset], arg=bytes[offset+1];
    _PyStackRef *stack_base=_PyFrame_Stackbase(frame);
    if (opcode==RETURN_VALUE && frame->stackpointer==stack_base+1) {
        *result=PyStackRef_AsPyObjectSteal(*--frame->stackpointer);
        if (self->count) self->returns++;
        return Py_RP_RETURN;
    }
    if (opcode==YIELD_VALUE && frame->owner==FRAME_OWNED_BY_GENERATOR &&
        frame->stackpointer>stack_base && (arg==0 || arg==1)) {
        *result=PyStackRef_AsPyObjectSteal(*--frame->stackpointer);
        frame->instr_ptr=next+1;
        if (self->count) self->yields++;
        return arg ? Py_RP_YIELD_FROM : Py_RP_YIELD;
    }
    return Py_RP_CONTINUE;
}

static PyObject *install(PyObject *module, PyObject *args) {
    PyObject *function, *code_object, *entries, *observer_address, *provider;
    int count, borrow_guards=0;
    if (!PyArg_ParseTuple(args,"OOOOOp|p",&function,&code_object,&entries,
                          &observer_address,&provider,&count,&borrow_guards)) return NULL;
    if (!PyFunction_Check(function) || !PyCode_Check(code_object) || !PyTuple_CheckExact(entries) ||
        PyTuple_GET_SIZE(entries)==0 || PyFunction_GET_CODE(function)!=code_object) {
        PyErr_SetString(PyExc_ValueError,"unchanged function/code and native entries required"); return NULL;
    }
    if (PyType_Ready(&ForkOwner_Type)<0) return NULL;
    ForkOwner *self=PyObject_GC_New(ForkOwner,&ForkOwner_Type);
    if (!self) return NULL;
    self->function_ref=self->code_ref=self->owners=self->bytecode=self->provider=NULL;
    self->entries=NULL; self->size=PyTuple_GET_SIZE(entries); self->observed=NULL;
    self->count=count; self->borrow_guards=borrow_guards; self->calls=self->start=self->resume=self->backedge=0;
    self->yields=self->returns=self->declines=0;
    self->function_ref=PyWeakref_NewRef(function,NULL);
    self->code_ref=PyWeakref_NewRef(code_object,NULL);
    self->bytecode=PyCode_GetCode((PyCodeObject *)code_object);
    self->owners=Py_NewRef(entries); self->provider=Py_NewRef(provider);
    self->entries=PyMem_Calloc((size_t)self->size,sizeof(ForkEntry));
    self->observed=(Observers)PyLong_AsVoidPtr(observer_address);
    if (!self->entries && !PyErr_Occurred()) PyErr_NoMemory();
    if (!self->observed && !PyErr_Occurred())
        PyErr_SetString(PyExc_ValueError,"nonzero observer address required");
    if (!self->function_ref || !self->code_ref || !self->bytecode || !self->entries ||
        !self->observed || PyErr_Occurred()) { Py_DECREF(self); return NULL; }
    unsigned int events=0;
    for (Py_ssize_t i=0;i<self->size;i++) {
        PyObject *item=PyTuple_GET_ITEM(entries,i);
        if (!PyTuple_CheckExact(item) || PyTuple_GET_SIZE(item)!=4) {
            PyErr_SetString(PyExc_ValueError,"native entry must be (offset,address,owner,event)"); Py_DECREF(self); return NULL;
        }
        ForkEntry *entry=&self->entries[i];
        entry->offset=PyLong_AsSsize_t(PyTuple_GET_ITEM(item,0));
        entry->body=(FrameBody)PyLong_AsVoidPtr(PyTuple_GET_ITEM(item,1));
        entry->event=(int)PyLong_AsLong(PyTuple_GET_ITEM(item,3));
        if (PyErr_Occurred()) { Py_DECREF(self); return NULL; }
        if (!entry->body || entry->offset<0 || entry->offset%2 ||
            entry->offset>=PyBytes_GET_SIZE(self->bytecode) ||
            (entry->event!=1 && entry->event!=2 && entry->event!=4)) {
            PyErr_SetString(PyExc_ValueError,"invalid fork native entry"); Py_DECREF(self); return NULL;
        }
        for (Py_ssize_t j=0;j<i;j++) if (self->entries[j].offset==entry->offset && self->entries[j].event==entry->event) {
            PyErr_SetString(PyExc_ValueError,"duplicate fork native entry"); Py_DECREF(self); return NULL;
        }
        events|=entry->event;
    }
    PyObject_GC_Track(self);
    PyObject *handle=PyUnstable_RPCode_SetNative((PyCodeObject *)code_object,dispatch,(PyObject *)self,events);
    Py_DECREF(self);
    if (handle && PyFunction_GET_CODE(function)!=code_object) {
        PyUnstable_RPNative_Close(handle); Py_DECREF(handle);
        PyErr_SetString(PyExc_RuntimeError,"source code changed during fork installation"); return NULL;
    }
    return handle;
}
static PyObject *stats(PyObject *module, PyObject *object) {
    if (Py_TYPE(object)!=&ForkOwner_Type) { PyErr_SetString(PyExc_TypeError,"active fork execution owner required"); return NULL; }
    ForkOwner *self=(ForkOwner *)object;
    return Py_BuildValue("{s:K,s:K,s:K,s:K,s:K,s:K,s:K}",
        "calls",self->calls,"start",self->start,"resume",self->resume,"backedge",self->backedge,
        "yield",self->yields,"return",self->returns,"decline",self->declines);
}
static PyMethodDef methods[]={
    {"install",install,METH_VARARGS,NULL},{"stats",stats,METH_O,NULL},{NULL}
};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_fork_entry_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__fork_entry_native(void) { return PyModule_Create(&module); }
