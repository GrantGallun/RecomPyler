/* Exact-version native vectorcall entry; shared IR owns body semantics. */
#define PY_SSIZE_T_CLEAN
#define Py_BUILD_CORE_MODULE
#include <Python.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error IR entry requires release GIL-enabled CPython 3.14.4
#endif
#include "internal/pycore_interp_structs.h"
#include "internal/pycore_instruments.h"
#include "internal/pycore_ceval.h"
#include "opcode_ids.h"
#include "entry_invalidator.h"

typedef int (*Guard)(PyObject *);
typedef PyObject *(*Runner)(void *,PyObject *,PyObject *const *,size_t,PyObject *);
typedef PyObject *(*OwnedRunner)(void *,PyObject *,PyObject *const *,size_t,PyObject *,PyObject *);
typedef struct Entry Entry;
struct Entry {
    PyObject_HEAD
    vectorcallfunc vectorcall;
    vectorcallfunc body;
    Runner runner;
    OwnedRunner owned_runner;
    PyObject *original, *keepalive, *weakrefs;
    Guard *guards;
    Py_ssize_t guard_count;
    Entry *next;
    int valid;
};
static Entry *entries=NULL;
static int watcher=-1;
static vectorcallfunc standard_vectorcall=NULL;
static PyObject *CompilationChangedError=NULL;
static void frame_function_changed(PyFunction_WatchEvent,PyFunctionObject*);

static void vector_function_changed(PyFunction_WatchEvent,PyFunctionObject*);

static int changed(PyFunction_WatchEvent event,PyFunctionObject *function,PyObject *new_value) {
    if (event==PyFunction_EVENT_MODIFY_CODE || event==PyFunction_EVENT_MODIFY_DEFAULTS
            || event==PyFunction_EVENT_MODIFY_KWDEFAULTS) {
        for (Entry *entry=entries;entry;entry=entry->next)
            if (entry->original==(PyObject*)function) entry->valid=0;
    }
    vector_function_changed(event,function);
    frame_function_changed(event,function);
    return 0;
}

static int observed(PyThreadState *thread,PyCodeObject *code) {
    if ((_Py_atomic_load_uintptr_relaxed(&thread->eval_breaker)&_PY_EVAL_EVENTS_MASK)
            || thread->c_tracefunc || thread->c_profilefunc
            || (thread->exc_info && thread->exc_info->exc_value
                && thread->exc_info->exc_value!=Py_None)) return 1;
    _PyFrameEvalFunction eval=thread->interp->eval_frame;
    if (eval && eval!=_PyEval_EvalFrameDefault) return 1;
    for (int i=0;i<_PY_MONITORING_UNGROUPED_EVENTS;i++)
        if (thread->interp->monitors.tools[i]) return 1;
    if (code->_co_monitoring) {
        for (int i=0;i<_PY_MONITORING_LOCAL_EVENTS;i++)
            if (code->_co_monitoring->local_monitors.tools[i]) return 1;
    }
    return 0;
}

#include "vectorcall_entry.h"

static PyObject *entry_call(PyObject *object,PyObject *const *args,size_t nargsf,PyObject *names) {
    Entry *self=(Entry*)object;
    if (!self->original) {
        PyErr_SetString(PyExc_RuntimeError,"cleared IR entry");return NULL;
    }
    PyThreadState *thread=PyThreadState_Get();
    PyFunctionObject *function=(PyFunctionObject*)self->original;
    if (!self->valid || function->vectorcall!=standard_vectorcall || observed(thread,(PyCodeObject*)function->func_code))
        return PyObject_Vectorcall(self->original,args,nargsf,names);
    for (Py_ssize_t i=0;i<self->guard_count;i++) {
        int ok=self->guards[i](self->original);
        if (ok<0) {
            if (!PyErr_Occurred()) PyErr_SetString(PyExc_SystemError,"IR guard failed without an exception");
            return NULL;
        }
        if (!ok) return PyObject_Vectorcall(self->original,args,nargsf,names);
    }
    /* Same CPython stack-limit check; reuse the already-read thread state. */
    if (_Py_EnterRecursiveCallTstate(thread," while calling a Python object")) return NULL;
    PyObject *result=self->owned_runner
        ? self->owned_runner((void*)self->body,self->original,args,nargsf,names,object)
        : self->runner
        ? self->runner((void*)self->body,self->original,args,nargsf,names)
        : self->body(self->original,args,nargsf,names);
    _Py_LeaveRecursiveCallTstate(thread);
    if (!result && !PyErr_Occurred()) PyErr_SetString(PyExc_SystemError,"IR body returned NULL without an exception");
    return result;
}

static int entry_traverse(Entry *self,visitproc visit,void *arg) {
    Py_VISIT(self->original);Py_VISIT(self->keepalive);return 0;
}
static int entry_clear(Entry *self) {
    self->valid=0;Py_CLEAR(self->original);Py_CLEAR(self->keepalive);return 0;
}
static void entry_dealloc(Entry *self) {
    PyObject_GC_UnTrack(self);
    Entry **link=&entries;
    while (*link && *link!=self) link=&(*link)->next;
    if (*link) *link=self->next;
    if(self->weakrefs)PyObject_ClearWeakRefs((PyObject *)self);
    entry_clear(self);PyMem_Free(self->guards);Py_TYPE(self)->tp_free((PyObject*)self);
}
static PyObject *metadata(Entry *self,void *closure) {
    if (!self->original) {PyErr_SetString(PyExc_RuntimeError,"cleared IR entry");return NULL;}
    return PyObject_GetAttrString(self->original,(const char*)closure);
}
static PyObject *wrapped(Entry *self,void *closure) {
    if (!self->original) Py_RETURN_NONE;
    return Py_NewRef(self->original);
}
static PyObject *descriptor(PyObject *self,PyObject *object,PyObject *type) {
    if (!object || object==Py_None) return Py_NewRef(self);
    return PyMethod_New(self,object);
}
static PyGetSetDef entry_getsets[]={
    {"__wrapped__",(getter)wrapped,NULL,NULL,NULL},
    {"__name__",(getter)metadata,NULL,NULL,"__name__"},
    {"__qualname__",(getter)metadata,NULL,NULL,"__qualname__"},
    {"__doc__",(getter)metadata,NULL,NULL,"__doc__"},
    {"__module__",(getter)metadata,NULL,NULL,"__module__"},
    {NULL}
};
static PyTypeObject EntryType={
    PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler.ir.NativeEntry",.tp_basicsize=sizeof(Entry),
    .tp_dealloc=(destructor)entry_dealloc,.tp_call=PyVectorcall_Call,
    .tp_vectorcall_offset=offsetof(Entry,vectorcall),
    .tp_flags=Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC|Py_TPFLAGS_HAVE_VECTORCALL,
    .tp_traverse=(traverseproc)entry_traverse,.tp_clear=(inquiry)entry_clear,
    .tp_getset=entry_getsets,.tp_descr_get=descriptor,
    .tp_weaklistoffset=offsetof(Entry,weakrefs),
};
static PyObject *create(PyObject *module,PyObject *args) {
    PyObject *original,*address,*keepalive,*guard_values,*runner_value,*owned_runner_value=NULL;
    if (!PyArg_ParseTuple(args,"OOOOO|O:create_callable",&original,&address,&keepalive,&guard_values,&runner_value,&owned_runner_value)) return NULL;
    if (!PyFunction_Check(original)) {PyErr_SetString(PyExc_TypeError,"original Python function required");return NULL;}
    void *body=PyLong_AsVoidPtr(address);
    if (!body) {if (!PyErr_Occurred()) PyErr_SetString(PyExc_ValueError,"nonzero body address required");return NULL;}
    Runner runner=(Runner)PyLong_AsVoidPtr(runner_value);
    if (!runner && PyErr_Occurred()) return NULL;
    OwnedRunner owned_runner=owned_runner_value ? (OwnedRunner)PyLong_AsVoidPtr(owned_runner_value):NULL;
    if (!owned_runner && PyErr_Occurred()) return NULL;
    if (runner && owned_runner) {PyErr_SetString(PyExc_ValueError,"runner hooks are mutually exclusive");return NULL;}
    if (!PyTuple_CheckExact(guard_values)) {PyErr_SetString(PyExc_TypeError,"guard address tuple required");return NULL;}
    if (PyInterpreterState_GetID(PyInterpreterState_Get())!=0) {
        PyErr_SetString(PyExc_RuntimeError,"IR native entry currently requires the main interpreter");return NULL;
    }
    Py_ssize_t count=PyTuple_GET_SIZE(guard_values);
    Guard *guards=count ? PyMem_Calloc((size_t)count,sizeof(Guard)):NULL;
    if (count && !guards) return PyErr_NoMemory();
    for (Py_ssize_t i=0;i<count;i++) {
        guards[i]=(Guard)PyLong_AsVoidPtr(PyTuple_GET_ITEM(guard_values,i));
        if (!guards[i]) {
            PyMem_Free(guards);
            if (!PyErr_Occurred()) PyErr_SetString(PyExc_ValueError,"nonzero guard address required");
            return NULL;
        }
    }
    if (watcher<0) {
        watcher=PyFunction_AddWatcher(changed);
        if (watcher<0) {PyMem_Free(guards);return NULL;}
    }
    Entry *entry=PyObject_GC_New(Entry,&EntryType);
    if (!entry) {PyMem_Free(guards);return NULL;}
    entry->vectorcall=entry_call;entry->body=(vectorcallfunc)body;entry->runner=runner;entry->owned_runner=owned_runner;
    entry->original=Py_NewRef(original);entry->keepalive=Py_NewRef(keepalive);entry->weakrefs=NULL;
    entry->guards=guards;entry->guard_count=count;entry->valid=1;
    entry->next=entries;entries=entry;PyObject_GC_Track(entry);
    return (PyObject*)entry;
}
/* Original functions enter after CPython has bound/owned their real frame.
 * This table is NON-OWNING: a retained compiler handle controls installation.
 * Pins live only in the stable C shim while LLVM code can still execute. */
#include "internal/pycore_interpframe.h"
#include "internal/pycore_frame.h"
#include "internal/pycore_optimizer.h"
typedef _Py_CODEUNIT *(*FrameBody)(_PyInterpreterFrame *,_PyStackRef *,PyThreadState *);
typedef struct FrameHandle FrameHandle;
struct FrameHandle {
    PyObject_HEAD
    PyObject *original,*code,*executor,*keepalive,*module,*weakrefs;
    FrameBody body,saved;
    FrameHandle *next,*managed_next;
    int installed,managed,valid,frameless;
    Py_ssize_t entry_offset;
};
#define FRAME_BUCKETS 4096
static FrameHandle *frame_handles[FRAME_BUCKETS];
/* Managed entries own executable memory, never a source function/code owner. */
static FrameHandle *managed_frames=NULL;
typedef struct FrameMutation {
    PyObject *function;
    struct FrameMutation *next;
} FrameMutation;
static FrameMutation *frame_mutations=NULL;
static size_t frame_bucket(PyObject *executor) {return ((uintptr_t)executor>>4)&(FRAME_BUCKETS-1);}
static FrameHandle *find_frame_handle(PyObject *executor) {
    for(FrameHandle *item=frame_handles[frame_bucket(executor)];item;item=item->next)
        if(item->executor==executor)return item;
    return NULL;
}
static _Py_CODEUNIT *frame_dispatch(_PyInterpreterFrame *frame,_PyStackRef *stack,PyThreadState *thread);
static void frame_detach_executor(FrameHandle *self) {
    if(!self->installed)return;
    FrameHandle **link=&frame_handles[frame_bucket(self->executor)];
    while(*link && *link!=self)link=&(*link)->next;
    if(*link)*link=self->next;
    self->next=NULL;self->installed=0;
    _PyExecutorObject *executor=(_PyExecutorObject*)self->executor;
    if(executor->jit_code==(void*)frame_dispatch)executor->jit_code=(void*)self->saved;
    self->saved=NULL;
    Py_CLEAR(self->executor);
}
static int frame_clear(FrameHandle *self) {
    self->valid=0;
    int managed=self->managed;
    if(managed) {
        FrameHandle **link=&managed_frames;
        while(*link && *link!=self)link=&(*link)->managed_next;
        if(*link)*link=self->managed_next;
        self->managed_next=NULL;self->managed=0;
    }
    frame_detach_executor(self);
    /* A running dispatch holds its OWN code keepalive until LLVM returns. */
    Py_CLEAR(self->keepalive);
    if(managed) {self->original=NULL;self->code=NULL;}
    else {Py_CLEAR(self->code);Py_CLEAR(self->original);}
    Py_CLEAR(self->module);
    if(managed)Py_DECREF(self); /* release the native registry's lifetime pin */
    return 0;
}
static void frame_function_changed(PyFunction_WatchEvent event,PyFunctionObject *function) {
    if(event!=PyFunction_EVENT_MODIFY_CODE && event!=PyFunction_EVENT_DESTROY)return;
    FrameMutation mutation={(PyObject*)function,frame_mutations};frame_mutations=&mutation;
    for(;;) {
        FrameHandle *found=NULL;
        for(int i=0;event!=PyFunction_EVENT_DESTROY && i<FRAME_BUCKETS && !found;i++)
            for(FrameHandle *item=frame_handles[i];item;item=item->next)
                if(item->original==(PyObject*)function){found=item;break;}
        if(!found)for(FrameHandle *item=managed_frames;item;item=item->managed_next)
            if(item->original==(PyObject*)function){found=item;break;}
        if(!found)break;
        Py_INCREF(found);frame_clear(found);Py_DECREF(found);
    }
    /* Callbacks may release the GIL and nest other threads' mutations. */
    FrameMutation **link=&frame_mutations;
    while(*link && *link!=&mutation)link=&(*link)->next;
    if(*link)*link=mutation.next;
}
static _Py_CODEUNIT *frame_dispatch(_PyInterpreterFrame *frame,_PyStackRef *stack,PyThreadState *thread) {
    FrameHandle *self=find_frame_handle((PyObject*)thread->current_executor);
    if(!self) {PyErr_SetString(PyExc_SystemError,"unregistered frame entry");return NULL;}
    Py_INCREF(self);
    PyObject *pin=Py_XNewRef(self->keepalive);
    FrameBody body=self->body,saved=self->saved;
    int valid=self->installed && self->valid && ((_PyExecutorObject*)self->executor)->vm_data.valid
        && _PyFrame_GetCode(frame)==(PyCodeObject*)self->code
        && thread->current_frame==frame
        && !PyStackRef_IsNull(frame->f_funcobj)
        && PyStackRef_AsPyObjectBorrow(frame->f_funcobj)==self->original
        && !observed(thread,(PyCodeObject*)self->code)
        && !(_Py_atomic_load_uintptr_relaxed(&thread->eval_breaker)&_PY_EVAL_EVENTS_MASK);
    if(valid) {
        /* Match CPython's _MAKE_WARM, which our replacement body bypasses.
         * A native entry that ran must survive the next cold-code sweep;
         * the saved interpreter executor performs its own bookkeeping. */
        ((_PyExecutorObject*)self->executor)->vm_data.warm=true;
        if(--thread->interp->trace_run_counter==0)
            _Py_set_eval_breaker_bit(thread,_PY_EVAL_JIT_INVALIDATE_COLD_BIT);
        /* LLVM owns separate executable memory, pinned above. We are no
         * longer executing CPython's saved trace. C/Python calls can invalidate
         * that trace and drain its deferred deletion list; retaining it as the
         * current executor can mark an invalid, still-pinned executor linked
         * again and corrupt CPython's active list. Saved-trace fallback keeps
         * the original marker and follows CPython's own handoff protocol. */
        thread->current_executor=NULL;
    }
    _Py_CODEUNIT *next=(valid?body:saved)(frame,stack,thread);
    if(!next && !PyErr_Occurred())PyErr_SetString(PyExc_SystemError,"frame body returned NULL without an exception");
    Py_XDECREF(pin);Py_DECREF(self);
    return next;
}
static int frame_traverse(FrameHandle *self,visitproc visit,void *arg) {
    if(!self->managed){Py_VISIT(self->original);Py_VISIT(self->code);}
    Py_VISIT(self->executor);
    Py_VISIT(self->keepalive);Py_VISIT(self->module);return 0;
}
static void frame_dealloc(FrameHandle *self) {
    PyObject_GC_UnTrack(self);
    if(self->weakrefs)PyObject_ClearWeakRefs((PyObject*)self);
    frame_clear(self);Py_TYPE(self)->tp_free((PyObject*)self);
}
static PyObject *frame_close(FrameHandle *self,PyObject *ignored) {frame_clear(self);Py_RETURN_NONE;}
static PyObject *frame_function(FrameHandle *self,void *ignored) {return Py_NewRef(self->original?self->original:Py_None);}
static int frame_is_active(FrameHandle *self) {
    return self->installed && self->valid && self->executor && ((_PyExecutorObject*)self->executor)->vm_data.valid
        && ((_PyExecutorObject*)self->executor)->vm_data.code==(PyCodeObject*)self->code
        && PyFunction_GetCode(self->original)==self->code;
}
static PyObject *frame_active(FrameHandle *self,void *ignored) {
    return PyBool_FromLong(frame_is_active(self));
}
static PyMethodDef frame_methods[]={{"close",(PyCFunction)frame_close,METH_NOARGS,NULL},{NULL}};
static PyGetSetDef frame_getsets[]={
    {"function",(getter)frame_function,NULL,NULL,NULL},{"active",(getter)frame_active,NULL,NULL,NULL},{NULL}};
static PyTypeObject FrameHandleType={
    PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler.ir.FrameEntryHandle",.tp_basicsize=sizeof(FrameHandle),
    .tp_flags=Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC,.tp_dealloc=(destructor)frame_dealloc,
    .tp_traverse=(traverseproc)frame_traverse,.tp_clear=(inquiry)frame_clear,
    .tp_methods=frame_methods,.tp_getset=frame_getsets,.tp_weaklistoffset=offsetof(FrameHandle,weakrefs)
};
typedef _PyInterpreterFrame *(*SeedEnter)(PyObject*,PyObject*,PyObject*const*,Py_ssize_t,Py_ssize_t);
typedef _PyInterpreterFrame *(*SeedEnterKeywords)(PyObject*,PyObject*,PyObject*const*,Py_ssize_t,PyObject*,Py_ssize_t);
typedef int (*SeedLeave)(_PyInterpreterFrame*,int,Py_ssize_t);
typedef PyObject *(*SeedRun)(void*,PyObject*,PyObject*const*,size_t,PyObject*);
typedef struct FrameSeed {SeedEnter enter;SeedEnterKeywords enter_keywords;SeedLeave leave;PyObject *code,*branches,*names;Py_ssize_t pc,nargs;struct FrameSeed *previous;} FrameSeed;
#ifdef _MSC_VER
static __declspec(thread) FrameSeed *frame_seed=NULL;
#else
static _Thread_local FrameSeed *frame_seed=NULL;
#endif
static int optimize_frame(_PyInterpreterFrame *frame,FrameSeed *seed) {
    _PyExecutorObject *executor=NULL;
    int result=_PyOptimizer_Optimize(frame,_PyFrame_GetBytecode(frame)+seed->pc/2,&executor,0);
    Py_XDECREF(executor);
    /* A root RETURN ends CPython tracing with refusal. For a loop, neutral
     * branch HISTORY (not a predicate/result) yields a bounded useful prefix.
     * Restore all histories before leaving compilation. No opcode is changed.
     */
    Py_ssize_t branches=PyTuple_GET_SIZE(seed->branches);
    if(result==0 && branches) {
        typedef struct { _Py_CODEUNIT *word;uint16_t previous; } History;
        History *history=PyMem_Calloc((size_t)branches,sizeof(History));
        if(!history){PyErr_NoMemory();result=-1;}
        else {
            Py_ssize_t saved=0;
            for(Py_ssize_t i=0;i<branches;i++) {
                Py_ssize_t offset=PyLong_AsSsize_t(PyTuple_GET_ITEM(seed->branches,i));
                if(PyErr_Occurred()){result=-1;break;}
                if(offset<0 || offset+2>=_PyCode_NBYTES((PyCodeObject*)seed->code) || offset&1) {
                    PyErr_SetString(PyExc_ValueError,"invalid branch feedback offset");result=-1;break;
                }
                _Py_CODEUNIT *instruction=_PyFrame_GetBytecode(frame)+offset/2;
                int op=instruction->op.code;
                if(op!=POP_JUMP_IF_NONE && op!=POP_JUMP_IF_NOT_NONE && op!=POP_JUMP_IF_FALSE && op!=POP_JUMP_IF_TRUE) {
                    PyErr_SetString(PyExc_ValueError,"branch feedback changed");result=-1;break;
                }
                history[saved++]=(History){instruction+1,instruction[1].cache};
                instruction[1].cache=0x00ff;
            }
            if(result>=0) {
                executor=NULL;
                result=_PyOptimizer_Optimize(frame,_PyFrame_GetBytecode(frame)+seed->pc/2,&executor,0);
                Py_XDECREF(executor);
            }
            while(saved){saved--;history[saved].word->cache=history[saved].previous;}
            PyMem_Free(history);
        }
    }
    return result;
}
static PyObject *seed_frame_body(PyObject *function,PyObject *const *args,size_t nargsf,PyObject *names) {
    FrameSeed *seed=frame_seed;
    _PyInterpreterFrame *frame=seed->enter_keywords
        ? seed->enter_keywords(function,seed->code,args,PyVectorcall_NARGS(nargsf),names,seed->pc)
        : seed->enter(function,seed->code,args,PyVectorcall_NARGS(nargsf),seed->pc);
    if(!frame)return NULL;
    int result=optimize_frame(frame,seed);
    if(seed->leave(frame,result>=0,seed->pc)<0)return NULL;
    if(result<0)return NULL;
    return PyLong_FromLong(result);
}
/* Close CREATED coroutines through CPython's actual public close implementation,
 * before DECREF could report an unawaited private compilation seed. No body can
 * run in this state; the exact-version type supplies this METH_NOARGS function. */
static void drop_seed(PyObject *object,PyCFunction close_created) {
    PyObject *error=PyErr_GetRaisedException();
    if(close_created) {
        PyObject *closed=close_created(object,NULL);
        Py_XDECREF(closed);
    }
    Py_DECREF(object);
    if(error)PyErr_SetRaisedException(error);
}
/* A standard suspended-function call executes only its validated creation prelude.
 * Optimize the REAL PyGenObject frame, then restore CREATED before dropping it.
 * No send/next/EvalFrameDefault of its application body occurs during seeding. */
static PyObject *seed_suspended_frame(PyObject *function,PyObject *values,
        FrameSeed *seed,Py_ssize_t stack_depth) {
    PyCodeObject *code=(PyCodeObject *)seed->code;
    int kind=code->co_flags & (CO_GENERATOR|CO_COROUTINE|CO_ASYNC_GENERATOR);
    PyCFunction close_created=NULL;
    if(kind==CO_COROUTINE) {
        for(PyMethodDef *method=PyCoro_Type.tp_methods;method && method->ml_name;method++)
            if(strcmp(method->ml_name,"close")==0 && method->ml_flags==METH_NOARGS) {
                close_created=method->ml_meth;break;
            }
        if(!close_created) {PyErr_SetString(PyExc_RuntimeError,"canonical coroutine close required");return NULL;}
    }
    PyThreadState *thread=PyThreadState_Get();
    if(observed(thread,code)) {
        PyErr_SetString(PyExc_RuntimeError,"generator seeding requires unobserved interpreter");return NULL;
    }
    _Py_CODEUNIT *words=_PyCode_CODE(code);
    Py_ssize_t first=code->_co_firsttraceable,i=0;
    while(i<first && (words[i].op.code==MAKE_CELL || words[i].op.code==COPY_FREE_VARS || words[i].op.code==EXTENDED_ARG))i++;
    if(i+2!=first || words[i].op.code!=RETURN_GENERATOR || words[i+1].op.code!=POP_TOP) {
        PyErr_SetString(PyExc_ValueError,"generator creation prelude required");return NULL;
    }
    if(stack_depth<0 || stack_depth>code->co_stacksize) {
        PyErr_SetString(PyExc_ValueError,"invalid generator seed stack depth");return NULL;
    }
    if(PyFunction_GetCode(function)!=(PyObject *)code) {
        PyErr_SetString(CompilationChangedError,"generator changed before seeding");return NULL;
    }
    PyObject *const *arguments=PyTuple_GET_SIZE(values)?&PyTuple_GET_ITEM(values,0):NULL;
    PyObject *object=PyObject_Vectorcall(function,arguments,(size_t)seed->nargs,seed->names);
    if(!object)return NULL;
    int exact=kind==CO_GENERATOR ? PyGen_CheckExact(object)
        : kind==CO_COROUTINE ? PyCoro_CheckExact(object) : PyAsyncGen_CheckExact(object);
    if(!exact) {
        PyErr_SetString(PyExc_TypeError,"exact original suspended object required");
        drop_seed(object,PyCoro_CheckExact(object)?close_created:NULL);return NULL;
    }
    PyGenObject *gen=(PyGenObject *)object;
    _PyInterpreterFrame *frame=&gen->gi_iframe;
    if(gen->gi_frame_state!=FRAME_CREATED || _PyFrame_GetCode(frame)!=code ||
            frame->stackpointer!=_PyFrame_Stackbase(frame) || frame->previous ||
            PyFunction_GetCode(function)!=(PyObject *)code) {
        PyErr_SetString(CompilationChangedError,"generator changed during creation");
        drop_seed(object,gen->gi_frame_state==FRAME_CREATED?close_created:NULL);return NULL;
    }
    if(thread->py_recursion_remaining<=0 || Py_EnterRecursiveCall(" while seeding generator")) {
        if(!PyErr_Occurred())PyErr_SetString(PyExc_RecursionError,"maximum recursion depth exceeded");
        drop_seed(object,close_created);return NULL;
    }
    _Py_CODEUNIT *saved_pc=frame->instr_ptr;
    _PyInterpreterFrame *previous=thread->current_frame;
    _PyErr_StackItem *previous_exc=thread->exc_info;
    for(Py_ssize_t j=0;j<stack_depth;j++)_PyFrame_StackPush(frame,PyStackRef_FromPyObjectNew(Py_None));
    frame->instr_ptr=_PyFrame_GetBytecode(frame)+seed->pc/2;
    frame->previous=previous;thread->current_frame=frame;
    gen->gi_exc_state.previous_item=previous_exc;thread->exc_info=&gen->gi_exc_state;
    gen->gi_frame_state=FRAME_EXECUTING;thread->py_recursion_remaining--;
    int result=optimize_frame(frame,seed);
    thread->py_recursion_remaining++;gen->gi_frame_state=FRAME_CREATED;
    thread->exc_info=previous_exc;gen->gi_exc_state.previous_item=NULL;
    thread->current_frame=previous;frame->previous=NULL;frame->instr_ptr=saved_pc;
    while(frame->stackpointer>_PyFrame_Stackbase(frame))PyStackRef_CLOSE(_PyFrame_StackPop(frame));
    Py_LeaveRecursiveCall();
    drop_seed(object,close_created);
    if(result<0 || PyErr_Occurred())return NULL;
    return PyLong_FromLong(result);
}
static FrameHandle *managed_for(PyObject *function);
static int prepared_matches(FrameHandle *self,PyObject *function,PyObject *code,
                            FrameBody body,PyObject *keepalive) {
    return self->valid && self->managed && !self->installed && !self->frameless
        && self->original==function && self->code==code
        && self->body==body && self->keepalive==keepalive
        && managed_for(function)==self;
}
static PyObject *install_frame(PyObject *module,PyObject *args) {
    PyObject *function,*address,*keepalive,*values,*enter_address,*leave_address,*run_address,*branches,*entry_offset=Py_None,*expected_code=Py_None,*expected_prepared=Py_None,*seed_names=Py_None,*keyword_enter_address=Py_None;
    Py_ssize_t seed_depth=0;
    if(!PyArg_ParseTuple(args,"OOOOOOOO|OOOnOO:install_frame_entry",&function,&address,&keepalive,&values,
                         &enter_address,&leave_address,&run_address,&branches,&entry_offset,&expected_code,&expected_prepared,&seed_depth,&seed_names,&keyword_enter_address))return NULL;
    if(!PyFunction_Check(function)||!PyTuple_CheckExact(values)||!PyTuple_CheckExact(branches)) {
        PyErr_SetString(PyExc_TypeError,"Python function and exact seed argument tuple required");return NULL;
    }
    if(seed_names!=Py_None && (!PyTuple_CheckExact(seed_names) || PyTuple_GET_SIZE(seed_names)>PyTuple_GET_SIZE(values))) {
        PyErr_SetString(PyExc_TypeError,"exact keyword names with corresponding seed values required");return NULL;
    }
    if(PyInterpreterState_GetID(PyInterpreterState_Get())!=0 || !PyThreadState_Get()->interp->jit) {
        PyErr_SetString(PyExc_RuntimeError,"frame entry requires enabled JIT in the main interpreter");return NULL;
    }
    if(((PyFunctionObject*)function)->vectorcall!=standard_vectorcall) {
        PyErr_SetString(PyExc_RuntimeError,"standard original-function vectorcall required");return NULL;
    }
    for(FrameMutation *item=frame_mutations;item;item=item->next)if(item->function==function) {
        PyErr_SetString(PyExc_RuntimeError,"function code is changing");return NULL;
    }
    FrameBody body=(FrameBody)PyLong_AsVoidPtr(address);
    if(!body){if(!PyErr_Occurred())PyErr_SetString(PyExc_ValueError,"nonzero frame body address required");return NULL;}
    if(expected_code!=Py_None && PyFunction_GetCode(function)!=expected_code) {
        PyErr_SetString(CompilationChangedError,"function changed before native installation");return NULL;
    }
    PyObject *code=Py_NewRef(PyFunction_GetCode(function));
    FrameHandle *prepared=NULL;
    if(expected_prepared!=Py_None) {
        if(Py_TYPE(expected_prepared)!=&FrameHandleType) {
            Py_DECREF(code);PyErr_SetString(PyExc_TypeError,"prepared frame handle required");return NULL;
        }
        prepared=(FrameHandle *)expected_prepared;
        /* Cold eviction retires CPython's executor, not the prepared LLVM
         * body or its watcher subscription. Reuse that same valid handle. */
        if(prepared->valid && prepared->managed && prepared->installed && prepared->executor
                && !((_PyExecutorObject*)prepared->executor)->vm_data.valid)
            frame_detach_executor(prepared);
        if(!prepared_matches(prepared,function,code,body,keepalive)) {
            Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"prepared frame changed before installation");return NULL;
        }
    }
    int kind=((PyCodeObject *)code)->co_flags & (CO_GENERATOR|CO_COROUTINE|CO_ASYNC_GENERATOR);
    int suspended=kind!=0;
    if(suspended && kind!=CO_GENERATOR && kind!=CO_COROUTINE && kind!=CO_ASYNC_GENERATOR) {
        Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"invalid suspended function flags");return NULL;
    }
    Py_ssize_t pc=((PyCodeObject*)code)->_co_firsttraceable*2;
    if(entry_offset!=Py_None) {
        Py_ssize_t requested=PyLong_AsSsize_t(entry_offset);
        if(PyErr_Occurred()){Py_DECREF(code);return NULL;}
        if((!suspended && requested!=pc) || requested<pc || requested>=_PyCode_NBYTES((PyCodeObject *)code) || requested&1) {
            Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"entry offset must identify first RESUME after the original prelude or a generator RESUME");return NULL;
        }
        pc=requested;
    }
    if(prepared && prepared->entry_offset!=pc) {Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"prepared entry offset changed");return NULL;}
    for(int i=0;i<FRAME_BUCKETS;i++)for(FrameHandle *item=frame_handles[i];item;item=item->next)
        if(item->code==code && item->entry_offset==pc) {Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"frame entry already installed for code offset");return NULL;}
    _PyExecutorObject *executor=_Py_GetExecutor((PyCodeObject*)code,(int)pc);
    if(!executor) {
        if(!PyErr_ExceptionMatches(PyExc_ValueError)){Py_DECREF(code);return NULL;}
        PyErr_Clear();
    }
    if(suspended) {
        int opcode=executor ? executor->vm_data.opcode : _PyCode_CODE((PyCodeObject *)code)[pc/2].op.code;
        if(opcode!=RESUME && opcode!=RESUME_CHECK) {
            Py_XDECREF(executor);Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"generator entry must identify RESUME");return NULL;
        }
    }
    if(executor && (!executor->vm_data.valid || !executor->jit_code))Py_CLEAR(executor);
    if(!executor) {
        FrameSeed seed={0};seed.code=code;seed.branches=branches;seed.pc=pc;seed.previous=frame_seed;
        seed.names=seed_names==Py_None?NULL:seed_names;
        seed.nargs=PyTuple_GET_SIZE(values)-(seed.names?PyTuple_GET_SIZE(seed.names):0);
        if(seed.names) {
            seed.enter_keywords=(SeedEnterKeywords)PyLong_AsVoidPtr(keyword_enter_address);
            if(!seed.enter_keywords) {
                Py_DECREF(code);if(!PyErr_Occurred())PyErr_SetString(PyExc_ValueError,"canonical keyword seed provider required");return NULL;
            }
        }
        seed.enter=(SeedEnter)PyLong_AsVoidPtr(enter_address);
        if(!PyErr_Occurred())seed.leave=(SeedLeave)PyLong_AsVoidPtr(leave_address);
        SeedRun run=NULL;if(!PyErr_Occurred())run=(SeedRun)PyLong_AsVoidPtr(run_address);
        if(PyErr_Occurred()||!seed.enter||!seed.leave||!run) {
            Py_DECREF(code);if(!PyErr_Occurred())PyErr_SetString(PyExc_ValueError,"canonical seed provider required");return NULL;
        }
        frame_seed=&seed;
        PyObject *result=suspended ? seed_suspended_frame(function,values,&seed,seed_depth)
            : run((void*)seed_frame_body,function,PyTuple_GET_SIZE(values)?&PyTuple_GET_ITEM(values,0):NULL,(size_t)seed.nargs,seed.names);
        frame_seed=seed.previous;
        if(!result){Py_DECREF(code);return NULL;}
        int admitted=PyObject_IsTrue(result);Py_DECREF(result);
        if(admitted<0){Py_DECREF(code);return NULL;}
        if(!admitted){Py_DECREF(code);PyErr_SetString(PyExc_ValueError,"CPython declined frame entry seed");return NULL;}
        executor=_Py_GetExecutor((PyCodeObject*)code,(int)pc);
        if(!executor){Py_DECREF(code);return NULL;}
    }
    if(find_frame_handle((PyObject*)executor)) {
        Py_DECREF(code);Py_DECREF(executor);PyErr_SetString(PyExc_ValueError,"frame entry installed during preparation");return NULL;
    }
    if(PyFunction_GetCode(function)!=code || !executor->vm_data.valid || !executor->jit_code) {
        Py_DECREF(code);Py_DECREF(executor);PyErr_SetString(PyExc_RuntimeError,"function changed during frame preparation");return NULL;
    }
    if(watcher<0){watcher=PyFunction_AddWatcher(changed);if(watcher<0){Py_DECREF(code);Py_DECREF(executor);return NULL;}}
    if(prepared) {
        /* Preserve the subscription target itself. The canonical seed may run
         * callbacks, so revalidate identity/owner/flags immediately before
         * publication. No allocation or Python call separates this check from
         * attaching the already-owned executor. */
        if(!prepared_matches(prepared,function,code,body,keepalive)) {
            Py_DECREF(code);Py_DECREF(executor);
            PyErr_SetString(PyExc_ValueError,"prepared frame changed during installation");return NULL;
        }
        prepared->executor=(PyObject *)executor;
        prepared->saved=(FrameBody)executor->jit_code;prepared->installed=1;
        size_t bucket=frame_bucket((PyObject *)executor);
        prepared->next=frame_handles[bucket];frame_handles[bucket]=prepared;
        executor->jit_code=(void *)frame_dispatch;
        Py_DECREF(code);
        return Py_NewRef((PyObject *)prepared);
    }
    FrameHandle *self=PyObject_GC_New(FrameHandle,&FrameHandleType);
    if(!self){Py_DECREF(code);Py_DECREF(executor);return NULL;}
    self->original=Py_NewRef(function);self->code=code;self->executor=(PyObject*)executor;
    self->keepalive=Py_NewRef(keepalive);self->module=Py_NewRef(module);self->weakrefs=NULL;
    self->body=body;self->saved=(FrameBody)executor->jit_code;self->installed=1;self->valid=1;self->entry_offset=pc;
    self->managed=0;self->frameless=0;self->managed_next=NULL;
    size_t bucket=frame_bucket((PyObject*)executor);self->next=frame_handles[bucket];frame_handles[bucket]=self;
    executor->jit_code=(void*)frame_dispatch;PyObject_GC_Track(self);
    return (PyObject*)self;
}

/* The compiler passes a source-independent execution owner (no graph, function,
 * code constants or application objects). Function watchers delimit its lifetime.
 * The executor owns no code reference; its GC edges are only executor exits. */
static FrameHandle *managed_for(PyObject *function) {
    for(FrameHandle *item=managed_frames;item;item=item->managed_next)
        if(item->original==function)return item;
    return NULL;
}
static PyObject *prepare_compilation(PyObject *module,PyObject *args,int frameless) {
    PyObject *function,*address,*keepalive,*expected_code;
    if(!PyArg_ParseTuple(args,"OOOO:prepare_frame_entry",&function,&address,&keepalive,&expected_code))return NULL;
    if(!PyFunction_Check(function)) {PyErr_SetString(PyExc_TypeError,"Python function required");return NULL;}
    if(PyInterpreterState_GetID(PyInterpreterState_Get())!=0) {
        PyErr_SetString(PyExc_RuntimeError,"frame compilation requires main interpreter");return NULL;
    }
    if(!PyCode_Check(expected_code) || PyFunction_GetCode(function)!=expected_code) {
        PyErr_SetString(CompilationChangedError,"function changed during compilation");return NULL;
    }
    for(FrameMutation *item=frame_mutations;item;item=item->next)if(item->function==function) {
        PyErr_SetString(CompilationChangedError,"function code is changing");return NULL;
    }
    if(managed_for(function)){PyErr_SetString(PyExc_ValueError,"function already compiled");return NULL;}
    FrameBody body=(FrameBody)PyLong_AsVoidPtr(address);
    if(!body){if(!PyErr_Occurred())PyErr_SetString(PyExc_ValueError,"nonzero body required");return NULL;}
    if(watcher<0){watcher=PyFunction_AddWatcher(changed);if(watcher<0)return NULL;}
    FrameHandle *self=PyObject_GC_New(FrameHandle,&FrameHandleType);
    if(!self)return NULL;
    self->original=function;self->code=PyFunction_GetCode(function); /* non-owning */
    self->executor=NULL;self->keepalive=Py_NewRef(keepalive);self->module=Py_NewRef(module);self->weakrefs=NULL;
    self->body=body;self->saved=NULL;self->installed=0;self->valid=1;self->entry_offset=((PyCodeObject *)expected_code)->_co_firsttraceable*2;self->next=NULL;self->managed=1;self->frameless=frameless;
    self->managed_next=managed_frames;managed_frames=self;
    Py_INCREF(self);PyObject_GC_Track(self);
    return (PyObject*)self;
}
static PyObject *prepare_frame(PyObject *module,PyObject *args) {
    return prepare_compilation(module,args,0);
}
static PyObject *prepare_frameless(PyObject *module,PyObject *args) {
    return prepare_compilation(module,args,1);
}
static PyObject *retain_frame(PyObject *module,PyObject *args) {
    PyObject *object,*keepalive;
    if(!PyArg_ParseTuple(args,"OO:retain_frame_entry",&object,&keepalive))return NULL;
    if(Py_TYPE(object)!=&FrameHandleType){PyErr_SetString(PyExc_TypeError,"frame handle required");return NULL;}
    FrameHandle *self=(FrameHandle*)object;
    if(!self->installed || self->managed || managed_for(self->original)) {
        PyErr_SetString(PyExc_ValueError,"unmanaged active frame handle required");return NULL;
    }
    PyObject *original=self->original,*code=self->code;
    self->managed=1;self->managed_next=managed_frames;managed_frames=self;Py_INCREF(self);
    Py_SETREF(self->keepalive,Py_NewRef(keepalive));
    Py_DECREF(original);Py_DECREF(code); /* registry stores only borrowed identities */
    Py_RETURN_NONE;
}
static PyObject *compilation_info(PyObject *module,PyObject *function) {
    FrameHandle *self=managed_for(function);
    if(!self)Py_RETURN_NONE;
    int prefix=(((PyCodeObject *)self->code)->co_flags & (CO_GENERATOR|CO_COROUTINE|CO_ASYNC_GENERATOR))!=0;
    return Py_BuildValue("{s:O,s:O,s:K,s:s,s:O,s:s}","compiled",Py_True,"installed",frame_is_active(self)?Py_True:Py_False,
        "body_address",(unsigned long long)(uintptr_t)self->body,"abi",self->frameless?"callback-free-vectorcall":"frame",
        "native_prefix",prefix?Py_True:Py_False,"compilation_kind",prefix?"native-prefix":"native-body");
}
static PyObject *compilation_owner(PyObject *module,PyObject *function) {
    FrameHandle *self=managed_for(function);
    if(!self || !self->valid)Py_RETURN_NONE;
    return Py_BuildValue("(OO)",self->code,self->keepalive);
}
static PyObject *forget_compilation(PyObject *module,PyObject *function) {
    for(VectorHandle *item=vector_handles[vector_bucket(function)];item;item=item->next)
        if(item->function==function)vector_detach(item);
    FrameHandle *self=managed_for(function);
    if(self){Py_INCREF(self);frame_clear(self);Py_DECREF(self);}
    Py_RETURN_NONE;
}

/* Mutation callbacks only change dispatch flags. They must not retire code,
 * decref dependencies, allocate, or call Python while a watched object mutates. */
static int invalidator_accepts(PyObject *entry) {
    return Py_TYPE(entry)==&EntryType || Py_TYPE(entry)==&FrameHandleType || Py_TYPE(entry)==&VectorHandleType;
}
static void invalidator_invalidate(PyObject *entry) {
    if(Py_TYPE(entry)==&EntryType)((Entry *)entry)->valid=0;
    else if(Py_TYPE(entry)==&FrameHandleType)((FrameHandle *)entry)->valid=0;
    else if(Py_TYPE(entry)==&VectorHandleType)vector_detach((VectorHandle *)entry);
}
static RcEntryInvalidator entry_invalidator={1,invalidator_accepts,invalidator_invalidate};
static PyObject *invalidation_api(PyObject *module,PyObject *unused) {
    return PyCapsule_New(&entry_invalidator,RC_ENTRY_INVALIDATOR_CAPSULE,NULL);
}
static PyObject *compilation_handle(PyObject *module,PyObject *function) {
    FrameHandle *self=managed_for(function);
    if(!self)Py_RETURN_NONE;
    return Py_NewRef((PyObject *)self);
}
static PyMethodDef methods[]={
    {"install_vectorcall_entry",install_vectorcall,METH_VARARGS,NULL},
    {"_install_callback_free_entry",install_callback_free,METH_VARARGS,NULL},
    {"_callback_free_addresses",callback_free_addresses,METH_NOARGS,NULL},
    {"_register_passive_guard_provider",register_guard_provider,METH_O,NULL},
    {"invalidation_api",invalidation_api,METH_NOARGS,NULL},
    {"_compilation_handle",compilation_handle,METH_O,NULL},
    {"prepare_frame_entry",prepare_frame,METH_VARARGS,NULL},
    {"prepare_frameless_entry",prepare_frameless,METH_VARARGS,NULL},
    {"retain_frame_entry",retain_frame,METH_VARARGS,NULL},
    {"compilation_info",compilation_info,METH_O,NULL},
    {"forget_compilation",forget_compilation,METH_O,NULL},
    {"_compilation_owner",compilation_owner,METH_O,NULL},
    {"install_frame_entry",install_frame,METH_VARARGS,NULL},{"create_callable",create,METH_VARARGS,NULL},{NULL}};
static struct PyModuleDef definition={PyModuleDef_HEAD_INIT,"_entry_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__entry_native(void) {
    if (Py_Version!=PY_VERSION_HEX) {PyErr_SetString(PyExc_ImportError,"IR entry CPython ABI mismatch");return NULL;}
    if (!standard_vectorcall) {
        /* Discover the non-exported standard slot from a real CPython function,
         * without executing its code or retaining application default owners. */
        PyCodeObject *code=PyCode_NewEmpty("<recompyler.ir>","vectorcall ABI probe",1);
        if (!code) return NULL;
        PyObject *globals=PyDict_New();
        if (!globals) {Py_DECREF(code);return NULL;}
        PyObject *function=PyFunction_New((PyObject*)code,globals);
        Py_DECREF(code);Py_DECREF(globals);
        if (!function) return NULL;
        standard_vectorcall=((PyFunctionObject*)function)->vectorcall;
        Py_DECREF(function);
    }
    if (PyType_Ready(&EntryType)<0 || PyType_Ready(&FrameHandleType)<0 || PyType_Ready(&VectorHandleType)<0) return NULL;
    PyObject *module=PyModule_Create(&definition);
    if (!module) return NULL;
    if(!CompilationChangedError) {
        CompilationChangedError=PyErr_NewException("recompyler.ir._entry_native.CompilationChanged",PyExc_RuntimeError,NULL);
        if(!CompilationChangedError){Py_DECREF(module);return NULL;}
    }
    if(PyModule_AddObjectRef(module,"CompilationChanged",CompilationChangedError)<0){Py_DECREF(module);return NULL;}
    if (PyModule_AddObjectRef(module,"NativeEntry",(PyObject*)&EntryType)<0) {Py_DECREF(module);return NULL;}
    if (PyModule_AddObjectRef(module,"FrameEntryHandle",(PyObject*)&FrameHandleType)<0) {Py_DECREF(module);return NULL;}
    return module;
}
