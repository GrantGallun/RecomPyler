/* Original-function vectorcall installation. No source frame is created here.
 * Low-level bodies own admission and return a new reference; cold whole-function
 * fallback calls the saved slot passed as their fifth borrowed argument. */
#include "internal/pycore_runtime_structs.h"
#include "internal/pycore_audit.h"
#include "passive_audit.h"

typedef PyObject *(*VectorBody)(PyObject *,PyObject *const *,size_t,PyObject *,vectorcallfunc);
typedef struct VectorHandle VectorHandle;
struct VectorHandle {
    PyObject_HEAD
    PyObject *function; /* borrowed, cleared by the function DESTROY watcher */
    PyObject *keepalive,*module,*weakrefs;
    VectorBody body,cold_body;
    vectorcallfunc saved;
    VectorHandle *next;
    int valid,callback_free;
};
#define VECTOR_BUCKETS 4096
static VectorHandle *vector_handles[VECTOR_BUCKETS];
static PyTypeObject VectorHandleType;
static int vector_audit_registered=0;
static PyObject *vector_dispatch(PyObject *,PyObject *const *,size_t,PyObject *);
static size_t vector_bucket(PyObject *function) {
    return ((uintptr_t)function>>4)&(VECTOR_BUCKETS-1);
}
static int vector_active(VectorHandle *self) {
    return self->valid && self->function &&
        ((PyFunctionObject *)self->function)->vectorcall==
            (self->callback_free?(vectorcallfunc)self->body:vector_dispatch);
}
static void vector_detach(VectorHandle *self) {
    if(vector_active(self))PyFunction_SetVectorcall((PyFunctionObject *)self->function,self->saved);
    self->valid=0;
}
static void vector_function_changed(PyFunction_WatchEvent event,PyFunctionObject *function) {
    if(event!=PyFunction_EVENT_DESTROY && event!=PyFunction_EVENT_MODIFY_CODE &&
       event!=PyFunction_EVENT_MODIFY_DEFAULTS && event!=PyFunction_EVENT_MODIFY_KWDEFAULTS)return;
    for(VectorHandle *item=vector_handles[vector_bucket((PyObject *)function)];item;item=item->next) {
        if(item->function!=(PyObject *)function)continue;
        /* Watchers must not retire dependencies or call Python during mutation. */
        vector_detach(item);
        if(event==PyFunction_EVENT_DESTROY)item->function=NULL;
    }
}
/* A custom function slot makes INSTRUMENTED_CALL report C_RETURN/C_RAISE.
 * Restore it BEFORE observer activation, not after the CALL branch is chosen.
 * Dormant registered callbacks also block publication: set_events has no audit
 * event. Future callback registration has one and retires current entries.
 * This observer-only hook adds no Python call/frame hook to ordinary calls. */
static int vector_observers_ready(PyThreadState *thread,PyCodeObject *code) {
    if(observed(thread,code))return 0;
    for(int tool=0;tool<PY_MONITORING_SYS_PROFILE_ID;tool++)
        for(int event=0;event<_PY_MONITORING_EVENTS;event++)
            if(thread->interp->monitoring_callables[tool][event])return 0;
    return 1;
}
static int vector_observer_audit(const char *event,PyObject *args,void *unused) {
    if(strcmp(event,"sys.monitoring.register_callback") && strcmp(event,"sys.settrace") &&
       strcmp(event,"sys.setprofile"))return 0;
    if(PyInterpreterState_GetID(PyInterpreterState_Get())!=0)return 0;
    for(size_t bucket=0;bucket<VECTOR_BUCKETS;bucket++)
        for(VectorHandle *item=vector_handles[bucket];item;item=item->next)vector_detach(item);
    return 0;
}
static RcPassiveAttributeAudit vector_passive_audit={1,vector_observer_audit,NULL};
/* Only the canonical native guard modules receive this private capability. */
static int vector_register_guard_provider(PyObject *module) {
    PyModuleDef *definition=PyModule_CheckExact(module)?PyModule_GetDef(module):NULL;
    if(!definition || (strcmp(definition->m_name,"recompyler._heap") &&
                      strcmp(definition->m_name,"_flat_native")))return 0;
    PyObject *method=PyDict_GetItemString(PyModule_GetDict(module),"_register_passive_attribute_audit");
    int canonical=method && Py_IS_TYPE(method,&PyCFunction_Type) &&
        PyCFunction_GET_SELF(method)==module && PyCFunction_GET_FLAGS(method)==METH_O &&
        !strcmp(((PyCFunctionObject *)method)->m_ml->ml_name,"_register_passive_attribute_audit");
    if(!canonical)return 0;
    Py_INCREF(method);
    PyObject *capsule=PyCapsule_New(&vector_passive_audit,RC_PASSIVE_AUDIT_CAPSULE,NULL);
    PyObject *result=capsule?PyObject_CallOneArg(method,capsule):NULL;
    Py_XDECREF(capsule);Py_DECREF(method);
    if(!result)return -1;
    int accepted=result==Py_True;Py_DECREF(result);return accepted;
}
static PyObject *register_guard_provider(PyObject *module,PyObject *provider) {
    int accepted=vector_register_guard_provider(provider);
    if(accepted<0)return NULL;
    return PyBool_FromLong(accepted);
}
static int vector_register_passive_audit(void) {
    PyObject *module=PyImport_ImportModule("recompyler._heap");
    if(!module)return -1;
    int accepted=vector_register_guard_provider(module);Py_DECREF(module);
    if(accepted<=0)return accepted;
    PyObject *name=PyUnicode_FromString("recompyler._flat_native");
    if(!name)return -1;
    module=PyImport_GetModule(name);Py_DECREF(name);
    if(!module)return PyErr_Occurred()?-1:accepted;
    accepted=vector_register_guard_provider(module);Py_DECREF(module);
    return accepted;
}
static int vector_hook_present(PyThreadState *thread) {
    /* AddAuditHook silently succeeds when an existing hook vetoes with a
     * RuntimeError. Inspect the pinned runtime registration, without emitting
     * a synthetic application audit event or assuming that return 0 installed. */
    _PyRuntimeState *runtime=thread->interp->runtime;
    int found=0;
    PyMutex_Lock(&runtime->audit_hooks.mutex);
    for(_Py_AuditHookEntry *entry=runtime->audit_hooks.head;entry;entry=entry->next)
        if(entry->hookCFunction==vector_observer_audit){found=1;break;}
    PyMutex_Unlock(&runtime->audit_hooks.mutex);
    return found;
}
static PyObject *vector_dispatch(PyObject *function,PyObject *const *args,size_t nargsf,PyObject *names) {
    VectorHandle *self=vector_handles[vector_bucket(function)];
    while(self && (self->function!=function || !self->valid))self=self->next;
    if(!self) {
        PyErr_SetString(PyExc_SystemError,"missing original-function vectorcall owner");return NULL;
    }
    vectorcallfunc saved=self->saved;
    PyThreadState *thread=PyThreadState_Get();
    if(observed(thread,(PyCodeObject *)((PyFunctionObject *)function)->func_code))
        return saved(function,args,nargsf,names);
    if(_Py_EnterRecursiveCallTstate(thread," while calling a Python object"))return NULL;
    /* A callback can close the handle or change the source while body machine
     * code is on the C stack. Pin BOTH objects before allowing that callback. */
    Py_INCREF(self);
    /* C API callers may borrow the function from a container that a callback
     * clears. Match the real Python frame's active function ownership. */
    Py_INCREF(function);
    PyObject *owner=Py_NewRef(self->keepalive);
    PyObject *result=self->body(function,args,nargsf,names,saved);
    _Py_LeaveRecursiveCallTstate(thread);
    if(!result && !PyErr_Occurred())PyErr_SetString(PyExc_SystemError,"IR body returned NULL without an exception");
    Py_DECREF(function);Py_DECREF(owner);Py_DECREF(self);
    return result;
}
static int vector_traverse(VectorHandle *self,visitproc visit,void *arg) {
    Py_VISIT(self->keepalive);Py_VISIT(self->module);return 0;
}
static int vector_clear(VectorHandle *self) {
    vector_detach(self);Py_CLEAR(self->keepalive);return 0;
}
static void vector_dealloc(VectorHandle *self) {
    PyObject_GC_UnTrack(self);
    vector_detach(self);
    /* The function may already be dead, so remove by handle, not its address. */
    for(size_t bucket=0;bucket<VECTOR_BUCKETS;bucket++) {
        VectorHandle **link=&vector_handles[bucket];
        while(*link && *link!=self)link=&(*link)->next;
        if(*link){*link=self->next;break;}
    }
    if(self->weakrefs)PyObject_ClearWeakRefs((PyObject *)self);
    vector_clear(self);Py_CLEAR(self->module);Py_TYPE(self)->tp_free((PyObject *)self);
}
static PyObject *vector_close(VectorHandle *self,PyObject *unused) {
    vector_clear(self);Py_RETURN_NONE;
}
static PyObject *vector_enter(VectorHandle *self,PyObject *unused) {
    return Py_NewRef((PyObject *)self);
}
static PyObject *vector_exit(VectorHandle *self,PyObject *args) {
    vector_clear(self);Py_RETURN_NONE;
}
static PyObject *vector_get_active(VectorHandle *self,void *unused) {
    return PyBool_FromLong(vector_active(self));
}
static PyObject *vector_get_function(VectorHandle *self,void *unused) {
    return Py_NewRef(self->function ? self->function : Py_None);
}
static PyObject *vector_get_saved(VectorHandle *self,void *unused) {
    return PyLong_FromVoidPtr((void *)self->saved);
}
static PyMethodDef vector_methods[]={
    {"close",(PyCFunction)vector_close,METH_NOARGS,NULL},
    {"__enter__",(PyCFunction)vector_enter,METH_NOARGS,NULL},
    {"__exit__",(PyCFunction)vector_exit,METH_VARARGS,NULL},{NULL}
};
static PyGetSetDef vector_getsets[]={
    {"active",(getter)vector_get_active,NULL,NULL,NULL},
    {"function",(getter)vector_get_function,NULL,NULL,NULL},
    {"saved_vectorcall",(getter)vector_get_saved,NULL,NULL,NULL},{NULL}
};
static PyTypeObject VectorHandleType={
    PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler.ir.VectorcallEntryHandle",.tp_basicsize=sizeof(VectorHandle),
    .tp_dealloc=(destructor)vector_dealloc,.tp_flags=Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC,
    .tp_traverse=(traverseproc)vector_traverse,.tp_clear=(inquiry)vector_clear,
    .tp_methods=vector_methods,.tp_getset=vector_getsets,
    .tp_weaklistoffset=offsetof(VectorHandle,weakrefs),
};
static PyObject *install_vectorcall_common(PyObject *module,PyObject *args,int callback_free) {
    PyObject *function,*address,*owner,*expected_code=Py_None,*cold_address=Py_None;
    if(!PyArg_ParseTuple(args,callback_free?"OOOO|O:_install_callback_free_entry":"OOO:install_vectorcall_entry",&function,&address,&owner,&expected_code,&cold_address))return NULL;
    if(!PyFunction_Check(function)){PyErr_SetString(PyExc_TypeError,"original Python function required");return NULL;}
    if(PyInterpreterState_GetID(PyInterpreterState_Get())!=0) {
        PyErr_SetString(PyExc_RuntimeError,"vectorcall entry requires main interpreter");return NULL;
    }
    VectorBody body=(VectorBody)PyLong_AsVoidPtr(address);
    if(!body){if(!PyErr_Occurred())PyErr_SetString(PyExc_ValueError,"nonzero body address required");return NULL;}
    VectorBody cold_body=cold_address==Py_None?NULL:(VectorBody)PyLong_AsVoidPtr(cold_address);
    if(PyErr_Occurred())return NULL;
    PyFunctionObject *fn=(PyFunctionObject *)function;
    if(callback_free && (!PyCode_Check(expected_code) || fn->func_code!=expected_code)) {
        PyErr_SetString(CompilationChangedError,"frameless source changed before installation");return NULL;
    }
    if(fn->vectorcall!=standard_vectorcall) {
        PyErr_SetString(PyExc_ValueError,"function already has a custom vectorcall entry");return NULL;
    }
    if(watcher<0){watcher=PyFunction_AddWatcher(changed);if(watcher<0)return NULL;}
    int source_changed=0;
    if(!vector_audit_registered) {
        PyObject *code=Py_NewRef(fn->func_code);
        PyObject *defaults=Py_XNewRef(fn->func_defaults),*kwdefaults=Py_XNewRef(fn->func_kwdefaults);
        int passive=vector_register_passive_audit();
        int status=passive>0?PySys_AddAuditHook(vector_observer_audit,NULL):passive;
        source_changed=fn->func_code!=code || fn->func_defaults!=defaults || fn->func_kwdefaults!=kwdefaults;
        Py_DECREF(code);Py_XDECREF(defaults);Py_XDECREF(kwdefaults);
        if(status<0)return NULL;
        vector_audit_registered=passive>0 && vector_hook_present(PyThreadState_Get());
        /* Existing Python audit hooks may have changed the slot. */
        if(fn->vectorcall!=standard_vectorcall) {
            PyErr_SetString(PyExc_ValueError,"function vectorcall changed during installation");return NULL;
        }
    }
    VectorHandle *self=PyObject_GC_New(VectorHandle,&VectorHandleType);
    if(!self)return NULL;
    self->function=function;self->keepalive=Py_NewRef(owner);self->module=Py_NewRef(module);
    self->weakrefs=NULL;self->body=body;self->cold_body=cold_body;self->saved=fn->vectorcall;self->valid=1;self->callback_free=callback_free;
    size_t bucket=vector_bucket(function);
    for(VectorHandle *old=vector_handles[bucket];old;old=old->next)
        if(old->function==function)old->valid=0;
    self->next=vector_handles[bucket];vector_handles[bucket]=self;
    PyObject_GC_Track(self);
    if(!source_changed && (!callback_free || fn->func_code==expected_code) && vector_audit_registered && vector_observers_ready(PyThreadState_Get(),(PyCodeObject *)fn->func_code))
        PyFunction_SetVectorcall(fn,callback_free?(vectorcallfunc)body:vector_dispatch);
    else self->valid=0;
    return (PyObject *)self;
}

static PyObject *install_vectorcall(PyObject *module,PyObject *args) {
    return install_vectorcall_common(module,args,0);
}
static PyObject *install_callback_free(PyObject *module,PyObject *args) {
    return install_vectorcall_common(module,args,1);
}

/* Every callee below is callback-free. A failed check takes a musttail jump to
 * the saved CPython slot; no JIT return address or executable owner is live. */
static int callback_free_guard(void) {
    PyThreadState *thread=PyThreadState_Get();
    _PyFrameEvalFunction eval=thread->interp->eval_frame;
    return !(_Py_atomic_load_uintptr_relaxed(&thread->eval_breaker)&_PY_EVAL_EVENTS_MASK) &&
        !thread->c_tracefunc && !thread->c_profilefunc &&
        !(thread->exc_info && thread->exc_info->exc_value && thread->exc_info->exc_value!=Py_None) &&
        (!eval || eval==_PyEval_EvalFrameDefault) && thread->py_recursion_remaining>0 &&
        !_Py_MakeRecCheck(thread);
}
/* The hot body tail-transfers here before any callback. Pin the executable
 * separately from the handle: close() may clear handle->keepalive in a callback.
 * The existing source runner/deopt thunk owns frame binding and resumption. */
static PyObject *callback_free_cold(PyObject *function,PyObject *const *args,size_t nargsf,PyObject *names) {
    VectorHandle *self=vector_handles[vector_bucket(function)];
    while(self && (self->function!=function || !self->valid || !self->callback_free || !self->cold_body || !vector_active(self)))self=self->next;
    if(!self){PyErr_SetString(PyExc_SystemError,"missing certified cold entry");return NULL;}
    Py_INCREF(self);Py_INCREF(function);
    PyObject *owner=Py_NewRef(self->keepalive);
    PyObject *result=self->cold_body(function,args,nargsf,names,self->saved);
    if(!result && !PyErr_Occurred())PyErr_SetString(PyExc_SystemError,"cold body returned NULL without an exception");
    Py_DECREF(function);Py_DECREF(owner);Py_DECREF(self);
    return result;
}
/* GIL-held, borrowed owner lookup. No allocation, reference-count operation,
 * error or callback. The result expires on entry retirement; a consumer must
 * tail-transfer to the pinned cold helper before allowing observation. */
static PyObject *callback_free_owner(PyObject *function) {
    VectorHandle *self=vector_handles[vector_bucket(function)];
    while(self && (self->function!=function || !self->valid || !self->callback_free || !vector_active(self)))self=self->next;
    return self ? self->keepalive : NULL;
}
static PyObject *callback_free_addresses(PyObject *module,PyObject *unused) {
    return Py_BuildValue("{s:K,s:K,s:n,s:K,s:K,s:K}","guard",(unsigned long long)(uintptr_t)callback_free_guard,
        "saved",(unsigned long long)(uintptr_t)standard_vectorcall,
        "refcount",(Py_ssize_t)offsetof(PyObject,ob_refcnt),
        "immortal",(unsigned long long)_Py_IMMORTAL_INITIAL_REFCNT,
        "cold",(unsigned long long)(uintptr_t)callback_free_cold,
        "owner",(unsigned long long)(uintptr_t)callback_free_owner);
}
