/* CPython-owned source activations. Application values use the canonical
 * managed-reference ABI; this file adds only a nonescaping frame pointer.
 * The emitter must preserve original instruction/operand lifetimes. */
#define PY_SSIZE_T_CLEAN
#define Py_BUILD_CORE_MODULE
#include <Python.h>
#include <stdint.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error Source activations require CPython 3.14.4 release GIL ABI
#endif
#include "internal/pycore_interpframe.h"
#include "internal/pycore_ceval.h"
#include "internal/pycore_interp.h"
#include "internal/pycore_opcode_utils.h"
#include "internal/pycore_cell.h"
#include "internal/pycore_dict.h"
#include "internal/pycore_function.h"
#include "internal/pycore_list.h"
#include "internal/pycore_instruments.h"
#include "internal/pycore_object.h"
#include "internal/pycore_intrinsics.h"
#include "opcode_ids.h"
#include "ir/generator_ops.h"

#define MAX_NATIVE_DEPTH 1024
#define MAX_POSITIONAL 64
#ifdef _MSC_VER
#define RC_THREAD __declspec(thread)
#else
#define RC_THREAD _Thread_local
#endif
typedef struct {
    PyThreadState *thread;
    _PyInterpreterFrame *frame;
    int call_claimed;
} SourceRecord;
typedef struct Boundary {
    struct Boundary *previous;
    PyThreadState *thread;
    int depth;
    PyObject *actual_callable; /* borrowed for this native invocation */
} Boundary;
static RC_THREAD Boundary *boundary = NULL;
static RC_THREAD int depth = 0;
static RC_THREAD SourceRecord records[MAX_NATIVE_DEPTH];

static int observed(PyThreadState *thread, PyCodeObject *code) {
    if (thread->c_tracefunc || thread->c_profilefunc ||
        _PyInterpreterState_GetEvalFrameFunc(thread->interp) != _PyEval_EvalFrameDefault)
        return 1;
    for (int i = 0; i < _PY_MONITORING_UNGROUPED_EVENTS; i++)
        if (thread->interp->monitors.tools[i]) return 1;
    if (code->_co_monitoring)
        for (int i = 0; i < _PY_MONITORING_LOCAL_EVENTS; i++)
            if (code->_co_monitoring->local_monitors.tools[i]) return 1;
    return 0;
}
static int valid_pc(PyCodeObject *code, Py_ssize_t pc) {
    if (pc < code->_co_firsttraceable*2 || pc >= _PyCode_NBYTES(code) || pc&1) {
        PyErr_SetString(PyExc_ValueError, "invalid source instruction");
        return 0;
    }
    return 1;
}
static int current(_PyInterpreterFrame *frame) {
    PyThreadState *thread = PyThreadState_Get();
    /* Compare opaque pointers before accessing frame memory, including stale
       handles. Native frames may only be used by their owning entry/thread. */
    if (!boundary || boundary->thread != thread || depth <= boundary->depth ||
        records[depth-1].thread != thread || records[depth-1].frame != frame ||
        thread->current_frame != frame) {
        PyErr_SetString(PyExc_RuntimeError, "inactive source activation");
        return 0;
    }
    return 1;
}
static void pop_frame(_PyInterpreterFrame *frame) {
    PyThreadState *thread = PyThreadState_Get();
    depth--;
    thread->current_frame = frame->previous;
    thread->py_recursion_remaining++;
    _PyEval_FrameClearAndPop(thread, frame);
    Py_LeaveRecursiveCall();
}
static _PyInterpreterFrame *enter_common(PyObject *function, PyObject *expected,
        PyObject *const *args, Py_ssize_t nargs, PyObject *names, Py_ssize_t pc) {
    PyThreadState *thread = PyThreadState_Get();
    if (!boundary || boundary->thread != thread) {
        PyErr_SetString(PyExc_RuntimeError, "source activation requires run_entry");
        return NULL;
    }
    if (!PyFunction_Check(function) || PyFunction_GetCode(function) != expected) {
        PyErr_SetString(PyExc_TypeError, "source function/code changed");
        return NULL;
    }
    PyCodeObject *code = (PyCodeObject *)expected;
    if (names && !PyTuple_CheckExact(names)) {
        PyErr_SetString(PyExc_TypeError, "exact keyword name tuple required");
        return NULL;
    }
    Py_ssize_t keyword_count = names ? PyTuple_GET_SIZE(names) : 0;
    if (nargs < 0 || nargs > MAX_POSITIONAL || keyword_count > MAX_POSITIONAL-nargs ||
        (!names && nargs != code->co_argcount) ||
        (code->co_flags & (CO_OPTIMIZED|CO_NEWLOCALS)) != (CO_OPTIMIZED|CO_NEWLOCALS) ||
        code->co_flags & (CO_GENERATOR|CO_COROUTINE|CO_ASYNC_GENERATOR)) {
        PyErr_SetString(PyExc_TypeError, "source activation requires ordinary scope");
        return NULL;
    }
    if (!valid_pc(code, pc)) return NULL;
    if (observed(thread, code)) {
        PyErr_SetString(PyExc_RuntimeError, "source activation requires unobserved interpreter");
        return NULL;
    }
    if (depth == MAX_NATIVE_DEPTH || thread->py_recursion_remaining <= 0) {
        PyErr_SetString(PyExc_RecursionError, "maximum recursion depth exceeded");
        return NULL;
    }
    if (Py_EnterRecursiveCall(" while entering compiled source")) return NULL;
    _PyStackRef actuals[MAX_POSITIONAL];
    for (Py_ssize_t i=0; i<nargs+keyword_count; i++) actuals[i] = PyStackRef_FromPyObjectNew(args[i]);
    /* The interpreter binds defaults, keyword-only defaults, empty *args and
       **kwargs. No application body runs while constructing this real frame. */
    _PyInterpreterFrame *frame = _PyEvalFramePushAndInit(thread,
        PyStackRef_FromPyObjectNew(function), NULL, actuals, nargs, names, thread->current_frame);
    if (!frame) {Py_LeaveRecursiveCall(); return NULL;}
    /* MAKE_CELL and COPY_FREE_VARS precede RESUME. Keep the frame incomplete
       during allocation, just as CPython does, then publish its first site. */
    thread->py_recursion_remaining--;
    records[depth++] = (SourceRecord){thread, frame, 0};
    thread->current_frame = frame;
    int free_index = 0;
    PyObject *closure = PyFunction_GetClosure(function);
    for (int i=0; i<code->co_nlocalsplus; i++) {
        unsigned char kind = (unsigned char)PyBytes_AS_STRING(code->co_localspluskinds)[i];
        if (kind & CO_FAST_FREE) {
            frame->localsplus[i] = PyStackRef_FromPyObjectNew(PyTuple_GET_ITEM(closure, free_index++));
        } else if (kind & CO_FAST_CELL) {
            _PyStackRef previous = frame->localsplus[i];
            PyObject *cell = PyCell_New(PyStackRef_IsNull(previous) ? NULL : PyStackRef_AsPyObjectBorrow(previous));
            if (!cell) {pop_frame(frame); return NULL;}
            frame->localsplus[i] = PyStackRef_FromPyObjectSteal(cell);
            PyStackRef_XCLOSE(previous);
        }
    }
    frame->instr_ptr = _PyFrame_GetBytecode(frame) + pc/2;
    return frame;
}
/* Keep the established positional ABI unchanged. Keyword seeds use the same
   frame initialization and CPython's own binder, including variadic arguments. */
static _PyInterpreterFrame *enter(PyObject *function, PyObject *expected,
        PyObject *const *args, Py_ssize_t nargs, Py_ssize_t pc) {
    return enter_common(function,expected,args,nargs,NULL,pc);
}
static _PyInterpreterFrame *enter_keywords(PyObject *function, PyObject *expected,
        PyObject *const *args, Py_ssize_t nargs, PyObject *names, Py_ssize_t pc) {
    return enter_common(function,expected,args,nargs,names,pc);
}
/* Narrow ownership handoff for a validated, ordinary unbound interpreter CALL.
 * This is an internal primitive, not general entry admission. In particular
 * bound-self C scalars, keyword/expanded calls and synthetic native callers
 * are not inferred from the borrowed vectorcall input array. */
static int claim_call_args(_PyInterpreterFrame *frame, PyObject *actual_callable,
        PyObject *const *args, Py_ssize_t nargs) {
    if (!current(frame)) return -1;
    SourceRecord *record = &records[depth-1];
    if (record->call_claimed || !actual_callable || !args || nargs < 0 ||
        nargs > MAX_POSITIONAL || nargs != _PyFrame_GetCode(frame)->co_argcount)
        return 0;
    _PyInterpreterFrame *caller = frame->previous;
    if (!caller || caller->owner == FRAME_OWNED_BY_CSTACK || !caller->stackpointer)
        return 0;
    /* A generated source frame can describe CALL without the interpreter's
       live operand cleanup. Do not modify such a caller's SSA-owned words. */
    for (int i=0; i<depth-1; i++) if (records[i].frame == caller) return 0;
    int opcode = _Py_OPCODE(*caller->instr_ptr);
    /* A specialized Python-call guard can miss on NativeEntry while the
       saved instruction still names CALL_PY_EXACT_ARGS / CALL_PY_GENERAL.
       The unbound callee/prefix/word proof below is still required in full. */
    if ((opcode != CALL && opcode != CALL_NON_PY_GENERAL &&
         opcode != CALL_PY_EXACT_ARGS && opcode != CALL_PY_GENERAL) ||
        _Py_OPARG(*caller->instr_ptr) != nargs) return 0;
    _PyStackRef *sp = caller->stackpointer;
    _PyStackRef *base = _PyFrame_Stackbase(caller);
    if (sp < base+nargs+2 || sp > base+_PyFrame_GetCode(caller)->co_stacksize)
        return 0;
    if (!PyStackRef_IsNull(sp[-nargs-1])) return 0;
    _PyStackRef callable = sp[-nargs-2];
    if (PyStackRef_IsNull(callable) || PyStackRef_IsTaggedInt(callable) ||
        PyStackRef_AsPyObjectBorrow(callable) != actual_callable) return 0;
    /* Validate every word and its canonical owned local before any mutation. */
    for (Py_ssize_t i=0; i<nargs; i++) {
        _PyStackRef value = sp[-nargs+i], local = frame->localsplus[i];
        if (PyStackRef_IsNull(value) || PyStackRef_IsTaggedInt(value) ||
            PyStackRef_IsNull(local) || PyStackRef_IsTaggedInt(local) ||
            PyStackRef_AsPyObjectBorrow(value) != args[i]) return 0;
        PyObject *owned_local=PyStackRef_AsPyObjectBorrow(local);
        unsigned char kind=(unsigned char)PyBytes_AS_STRING(_PyFrame_GetCode(frame)->co_localspluskinds)[i];
        if (kind & CO_FAST_CELL) {
            /* MAKE_CELL transferred this argument to the real owning cell. */
            if (!PyCell_Check(owned_local) || PyCell_GET(owned_local)!=args[i]) return 0;
        } else if (owned_local!=args[i] ||
                   ((local.bits & Py_TAG_REFCNT) && !_Py_IsImmortal(args[i]))) return 0;
    }
    record->call_claimed = 1;
    for (Py_ssize_t i=0; i<nargs; i++) {
        _PyStackRef previous = sp[-nargs+i];
        sp[-nargs+i] = PyStackRef_None;
        PyStackRef_CLOSE(previous);
    }
    return 1;
}
static int mark(_PyInterpreterFrame *frame, Py_ssize_t pc) {
    if (!current(frame) || !valid_pc(_PyFrame_GetCode(frame), pc)) return -1;
    frame->instr_ptr = _PyFrame_GetBytecode(frame) + pc/2;
    return 0;
}
static int slot(_PyInterpreterFrame *frame, Py_ssize_t index) {
    if (!current(frame)) return 0;
    if (index < 0 || index >= _PyFrame_GetCode(frame)->co_nlocalsplus) {
        PyErr_SetString(PyExc_IndexError, "source local index");
        return 0;
    }
    return 1;
}
static int cell_kind(_PyInterpreterFrame *frame, Py_ssize_t index) {
    unsigned char kind = (unsigned char)PyBytes_AS_STRING(_PyFrame_GetCode(frame)->co_localspluskinds)[index];
    return kind & (CO_FAST_CELL|CO_FAST_FREE);
}
static void unbound(_PyInterpreterFrame *frame, Py_ssize_t index) {
    PyCodeObject *code = _PyFrame_GetCode(frame);
    unsigned char kind = (unsigned char)PyBytes_AS_STRING(code->co_localspluskinds)[index];
    PyObject *name = PyTuple_GET_ITEM(code->co_localsplusnames, index);
    if (kind & CO_FAST_FREE) {
        PyErr_Format(PyExc_NameError,
            "cannot access free variable '%U' where it is not associated with a value in enclosing scope", name);
        /* LOAD_DEREF also supplies NameError.name. */
        PyObject *error = PyErr_GetRaisedException();
        if (error) {PyObject_SetAttrString(error, "name", name); PyErr_SetRaisedException(error);}
    } else PyErr_Format(PyExc_UnboundLocalError,
        "cannot access local variable '%U' where it is not associated with a value", name);
}
static PyObject *load(_PyInterpreterFrame *frame, Py_ssize_t index) {
    if (!slot(frame,index)) return NULL;
    _PyStackRef value = frame->localsplus[index];
    PyObject *result = NULL;
    if (!PyStackRef_IsNull(value)) {
        PyObject *object = PyStackRef_AsPyObjectBorrow(value);
        result = cell_kind(frame,index) ? PyCell_GET(object) : object;
    }
    if (!result) {unbound(frame,index); return NULL;}
    return Py_NewRef(result);
}
static int store(_PyInterpreterFrame *frame, Py_ssize_t index, PyObject *value) {
    if (!slot(frame,index)) return -1;
    if (!value) {PyErr_SetString(PyExc_SystemError,"NULL source store"); return -1;}
    if (cell_kind(frame,index)) return PyCell_Set(PyStackRef_AsPyObjectBorrow(frame->localsplus[index]),value);
    _PyStackRef prior = frame->localsplus[index];
    frame->localsplus[index] = PyStackRef_FromPyObjectNew(value);
    PyStackRef_XCLOSE(prior);
    return 0;
}
static int delete_local(_PyInterpreterFrame *frame, Py_ssize_t index) {
    if (!slot(frame,index)) return -1;
    if (cell_kind(frame,index)) {
        PyObject *cell=PyStackRef_AsPyObjectBorrow(frame->localsplus[index]);
        if (!PyCell_GET(cell)) {unbound(frame,index); return -1;}
        return PyCell_Set(cell,NULL);
    }
    _PyStackRef prior=frame->localsplus[index];
    if (PyStackRef_IsNull(prior)) {unbound(frame,index); return -1;}
    frame->localsplus[index]=PyStackRef_NULL;
    PyStackRef_CLOSE(prior);
    return 0;
}
static PyObject *cell(_PyInterpreterFrame *frame, Py_ssize_t index) {
    if (!slot(frame,index)) return NULL;
    if (!cell_kind(frame,index)) {PyErr_SetString(PyExc_TypeError,"source slot is not a cell"); return NULL;}
    return PyStackRef_AsPyObjectNew(frame->localsplus[index]);
}
static int push(_PyInterpreterFrame *frame, PyObject *value) {
    if (!current(frame)) return -1;
    if (frame->stackpointer >= _PyFrame_Stackbase(frame)+_PyFrame_GetCode(frame)->co_stacksize) {
        PyErr_SetString(PyExc_OverflowError,"source operand stack full"); return -1;
    }
    _PyFrame_StackPush(frame,value ? PyStackRef_FromPyObjectNew(value) : PyStackRef_NULL);
    return 0;
}
static PyObject *pop(_PyInterpreterFrame *frame) {
    if (!current(frame)) return NULL;
    if (frame->stackpointer <= _PyFrame_Stackbase(frame)) {
        PyErr_SetString(PyExc_IndexError,"source operand stack empty"); return NULL;
    }
    _PyStackRef value=_PyFrame_StackPop(frame);
    if (PyStackRef_IsNull(value)) {PyErr_SetString(PyExc_SystemError,"NULL source operand"); return NULL;}
    return PyStackRef_AsPyObjectSteal(value);
}
static void clear_stack(_PyInterpreterFrame *frame) {
    while (frame->stackpointer > _PyFrame_Stackbase(frame)) {
        _PyStackRef value=_PyFrame_StackPop(frame);
        PyStackRef_XCLOSE(value);
    }
}
static int attach_error(void) {
    PyObject *error=PyErr_GetRaisedException();
    if (!error) {PyErr_SetString(PyExc_SystemError,"source unwind missing error"); return -1;}
    PyFrameObject *materialized=PyThreadState_GetFrame(PyThreadState_Get());
    if (!materialized) {Py_DECREF(error); return -1;}
    PyErr_SetRaisedException(error);
    int result=PyTraceBack_Here(materialized);
    Py_DECREF(materialized);
    return result;
}
static int leave(_PyInterpreterFrame *frame, PyObject *errors, int success, Py_ssize_t pc) {
    if (!current(frame)) return -1;
    int result=0;
    if (success) {
        result=mark(frame,pc);
        if (!result && frame->stackpointer != _PyFrame_Stackbase(frame)) {
            PyErr_SetString(PyExc_SystemError,"source return has live operands");result=-1;
        }
    } else if (!PyList_CheckExact(errors) || PyList_GET_SIZE(errors)!=1 ||
               !PyExceptionInstance_Check(PyList_GET_ITEM(errors,0))) {
        PyErr_SetString(PyExc_SystemError,"source unwind missing error packet");result=-1;
    } else {
        PyErr_SetRaisedException(Py_NewRef(PyList_GET_ITEM(errors,0)));
        attach_error();
        /* Exception creation/materialization precedes operand unwinding. */
        clear_stack(frame);
        PyObject *error=PyErr_GetRaisedException();
        if (!error) {PyErr_SetString(PyExc_SystemError,"source unwind lost error");result=-1;}
        else result=PyList_SetItem(errors,0,error);
    }
    if (result<0) clear_stack(frame);
    pop_frame(frame);
    return result;
}
/* Raw IR ABI: the same canonical frame provider, without Numba error packets. */
static int leave_raw(_PyInterpreterFrame *frame, int success, Py_ssize_t pc) {
    if (!current(frame)) return -1;
    int status=0;
    if (success) {
        status=mark(frame,pc);
        if (!status && frame->stackpointer != _PyFrame_Stackbase(frame)) {
            PyErr_SetString(PyExc_SystemError,"source return has live operands");status=-1;
        }
    } else {
        if (!PyErr_Occurred()) PyErr_SetString(PyExc_SystemError,"source unwind missing error");
        status=attach_error();
    }
    /* Keep the raised error alive independently while operand/local retirement
       can invoke arbitrary Python finalizers. */
    PyObject *error=PyErr_GetRaisedException();
    if (!success || status<0) clear_stack(frame);
    pop_frame(frame);
    if (error) PyErr_SetRaisedException(error);
    return status;
}
typedef PyObject *(*RawBody)(PyObject *,PyObject *const *,size_t,PyObject *);
static PyObject *run_owned_vectorcall(void *body, PyObject *original,
        PyObject *const *args, size_t nargsf, PyObject *kwnames, PyObject *actual_callable) {
    Boundary active={boundary,PyThreadState_Get(),depth,actual_callable};
    boundary=&active;
    PyObject *result=((RawBody)body)(original,args,nargsf,kwnames);
    while (depth>active.depth) {
        _PyInterpreterFrame *frame=records[depth-1].frame;
        if (result) {Py_DECREF(result);result=NULL;
            PyErr_SetString(PyExc_SystemError,"native body left active source frame");}
        leave_raw(frame,0,0);
    }
    boundary=active.previous;
    return result;
}
/* The legacy ABI intentionally exposes no actual-callable ownership claim. */
static PyObject *run_vectorcall(void *body, PyObject *original,
        PyObject *const *args, size_t nargsf, PyObject *kwnames) {
    return run_owned_vectorcall(body,original,args,nargsf,kwnames,NULL);
}
static PyObject *current_callable(void) {
    if (!boundary || boundary->thread != PyThreadState_Get()) return NULL;
    return boundary->actual_callable;
}
/* IR values are the actual CPython stack-reference words. No NRT owner or
   second application-value representation is introduced. */
static uintptr_t word_newref(PyObject *value) {
    return PyStackRef_FromPyObjectNew(value).bits;
}
static uintptr_t word_from_owned(PyObject *value) {
    return value ? PyStackRef_FromPyObjectSteal(value).bits : PyStackRef_NULL.bits;
}
static uintptr_t word_dup(uintptr_t value) {
    _PyStackRef ref={.bits=value};
    return PyStackRef_DUP(ref).bits;
}
static void word_close(uintptr_t value) {
    _PyStackRef ref={.bits=value};
    PyStackRef_XCLOSE(ref);
}
static PyObject *word_return(_PyInterpreterFrame *frame, uintptr_t value, Py_ssize_t pc) {
    _PyStackRef ref={.bits=value};
    ref=PyStackRef_MakeHeapSafe(ref);
    PyObject *result=PyStackRef_AsPyObjectSteal(ref);
    if (leave_raw(frame,1,pc)<0) {Py_DECREF(result);return NULL;}
    return result;
}
static PyObject *build_class_load(_PyInterpreterFrame *frame) {
    PyObject *result=NULL;
    if (PyMapping_GetOptionalItem(frame->f_builtins,&_Py_ID(__build_class__),&result)<0) return NULL;
    if (!result) PyErr_SetString(PyExc_NameError,"__build_class__ not found");
    return result;
}
/* Intrinsics and special lookups use the interpreter's own dispatch tables. */
static PyObject *intrinsic_unary(Py_ssize_t index, PyObject *value) {
    return _PyIntrinsics_UnaryFunctions[index].func(PyThreadState_Get(),value);
}
static PyObject *intrinsic_binary(Py_ssize_t index, PyObject *left, PyObject *right) {
    return _PyIntrinsics_BinaryFunctions[index].func(PyThreadState_Get(),left,right);
}
static int special_load(uintptr_t *words, Py_ssize_t index) {
    _PyStackRef *pair=(_PyStackRef *)words;
    int status=_PyObject_LookupSpecialMethod(_Py_SpecialMethods[index].name,pair);
    if (status==0) {
        PyObject *owner=PyStackRef_AsPyObjectBorrow(pair[1]);
        const char *format=_PyEval_SpecialMethodCanSuggest(owner,(int)index)
            ? _Py_SpecialMethods[index].error_suggestion : _Py_SpecialMethods[index].error;
        PyErr_Format(PyExc_TypeError,format,owner);
    }
    return status;
}
/* Closure opcodes use the actual frame's PyCellObject and stackref ownership. */
static uintptr_t cell_load(_PyInterpreterFrame *frame, Py_ssize_t index) {
    PyCellObject *cell=(PyCellObject *)PyStackRef_AsPyObjectBorrow(frame->localsplus[index]);
    _PyStackRef value=_PyCell_GetStackRef(cell);
    if (PyStackRef_IsNull(value)) unbound(frame,index);
    return value.bits;
}
static void cell_store(_PyInterpreterFrame *frame, Py_ssize_t index, uintptr_t bits) {
    _PyStackRef value={.bits=bits};
    PyCellObject *cell=(PyCellObject *)PyStackRef_AsPyObjectBorrow(frame->localsplus[index]);
    PyCell_SetTakeRef(cell,PyStackRef_AsPyObjectSteal(value));
}
static int cell_delete(_PyInterpreterFrame *frame, Py_ssize_t index) {
    PyCellObject *cell=(PyCellObject *)PyStackRef_AsPyObjectBorrow(frame->localsplus[index]);
    PyObject *previous=PyCell_SwapTakeRef(cell,NULL);
    if (!previous) {unbound(frame,index);return -1;}
    Py_DECREF(previous);return 0;
}
static uintptr_t function_new(_PyInterpreterFrame *frame, uintptr_t bits) {
    _PyStackRef code_ref={.bits=bits};
    PyCodeObject *code=(PyCodeObject *)PyStackRef_AsPyObjectBorrow(code_ref);
    PyObject *function=PyFunction_New((PyObject *)code,frame->f_globals);
    PyStackRef_CLOSE(code_ref);
    if (!function) return PyStackRef_NULL.bits;
    _PyFunction_SetVersion((PyFunctionObject *)function,code->co_version);
    return PyStackRef_FromPyObjectSteal(function).bits;
}
static void function_attribute(uintptr_t function_bits, uintptr_t attribute_bits, int flag) {
    _PyStackRef function_ref={.bits=function_bits}, attribute_ref={.bits=attribute_bits};
    PyFunctionObject *function=(PyFunctionObject *)PyStackRef_AsPyObjectBorrow(function_ref);
    PyObject **target=NULL;
    switch (flag) {
        case MAKE_FUNCTION_DEFAULTS: target=&function->func_defaults;break;
        case MAKE_FUNCTION_KWDEFAULTS: target=&function->func_kwdefaults;break;
        case MAKE_FUNCTION_ANNOTATIONS: target=&function->func_annotations;break;
        case MAKE_FUNCTION_CLOSURE: target=&function->func_closure;break;
        case MAKE_FUNCTION_ANNOTATE: target=&function->func_annotate;break;
        default: Py_FatalError("invalid compiled function attribute");
    }
    assert(*target==NULL);
    *target=PyStackRef_AsPyObjectSteal(attribute_ref);
}
/* The interpreter CALL path transfers normal Python operands into its binder.
 * Keeping them in a borrowed vectorcall array would extend temporary lifetime
 * until the child returns. Other callables use the same vectorcall conversion
 * and input retirement as CPython's non-Python CALL path. */
/* Debug/canonical-vectorcall continuation: relinquish this activation to
 * Tier 1 at its published original PC without binding or replaying a prefix. */
static PyObject *resume_python(_PyInterpreterFrame *frame) {
    if (!current(frame)) return NULL;
    PyThreadState *thread=PyThreadState_Get();
    depth--;thread->current_frame=frame->previous;
    thread->py_recursion_remaining++;Py_LeaveRecursiveCall();
    return _PyEval_EvalFrameDefault(thread,frame,0);
}
static vectorcallfunc standard_function_vectorcall=NULL;
static int list_append_take_ref(PyObject *list, PyObject *value) {
    return _PyList_AppendTakeRef((PyListObject *)list,value);
}
static int list_extend(PyObject *list, PyObject *iterable) {
    PyObject *result=_PyList_Extend((PyListObject *)list,iterable);
    if (result==NULL) {
        if (PyErr_ExceptionMatches(PyExc_TypeError) &&
                Py_TYPE(iterable)->tp_iter==NULL && !PySequence_Check(iterable)) {
            PyErr_Clear();
            PyErr_Format(PyExc_TypeError,"Value after * must be an iterable, not %.200s",Py_TYPE(iterable)->tp_name);
        }
        return -1;
    }
    assert(result==Py_None);
    return 0;
}
static uintptr_t common_constant(Py_ssize_t index) {
    return PyStackRef_FromPyObjectNew(PyThreadState_Get()->interp->common_consts[index]).bits;
}
static uintptr_t global_load(_PyInterpreterFrame *frame, Py_ssize_t index) {
    _PyStackRef result=PyStackRef_NULL;
    _PyEval_LoadGlobalStackRef(frame->f_globals,frame->f_builtins,
        PyTuple_GET_ITEM(_PyFrame_GetCode(frame)->co_names,index),&result);
    return result.bits;
}
/* LOAD_FROM_DICT_OR_GLOBALS requires an owned result after its mapping retires. */
static PyObject *global_load_owned(_PyInterpreterFrame *frame, Py_ssize_t index) {
    _PyStackRef result={.bits=global_load(frame,index)};
    if (PyStackRef_IsNull(result)) return NULL;
    PyObject *value=Py_NewRef(PyStackRef_AsPyObjectBorrow(result));
    PyStackRef_CLOSE(result);
    return value;
}
static int global_store(_PyInterpreterFrame *frame, Py_ssize_t index, uintptr_t value) {
    PyObject *name=PyTuple_GET_ITEM(_PyFrame_GetCode(frame)->co_names,index);
    return PyDict_SetItem(frame->f_globals,name,PyStackRef_AsPyObjectBorrow((_PyStackRef){value}));
}
static int global_delete(_PyInterpreterFrame *frame, Py_ssize_t index) {
    PyObject *name=PyTuple_GET_ITEM(_PyFrame_GetCode(frame)->co_names,index);
    int found=PyDict_Pop(frame->f_globals,name,NULL);
    if(found<0)return -1;
    if(found)return 0;
    _PyEval_FormatExcCheckArg(PyThreadState_Get(),PyExc_NameError,"name '%s' is not defined",name);
    return -1;
}
static int dict_expand(PyObject *target, PyObject *update, PyObject *callable) {
    int status=callable ? _PyDict_MergeEx(target,update,2) : PyDict_Update(target,update);
    if(status<0) {
        if(callable)_PyEval_FormatKwargsError(PyThreadState_Get(),callable,update);
        else if(PyErr_ExceptionMatches(PyExc_AttributeError))
            PyErr_Format(PyExc_TypeError,"'%.200s' object is not a mapping",Py_TYPE(update)->tp_name);
    }
    return status;
}
/* CPython 3.14.4 GET_AITER: preserve the slot call, input retirement,
 * then result validation order from Python/bytecodes.c. The emitter closes
 * the original stack word between these two adapter calls. */
static PyObject *async_iter_get(PyObject *object) {
    PyTypeObject *type=Py_TYPE(object);
    unaryfunc getter=type->tp_as_async ? type->tp_as_async->am_aiter : NULL;
    if (!getter) {
        PyErr_Format(PyExc_TypeError,
            "'async for' requires an object with __aiter__ method, got %.100s",
            type->tp_name);
        return NULL;
    }
    return getter(object);
}
static PyObject *async_iter_check(PyObject *iterator) {
    if (!iterator) return NULL;
    PyTypeObject *type=Py_TYPE(iterator);
    if (!type->tp_as_async || !type->tp_as_async->am_anext) {
        PyErr_Format(PyExc_TypeError,
            "'async for' received an object from __aiter__ that does not implement __anext__: %.100s",
            type->tp_name);
        Py_DECREF(iterator);
        return NULL;
    }
    return iterator;
}
static int iter_next(_PyInterpreterFrame *frame, PyObject *iterator, PyObject **output) {
    iternextfunc advance=Py_TYPE(iterator)->tp_iternext;
    *output=NULL;
    if(!advance) {
        PyErr_Format(PyExc_TypeError,"'%.100s' object is not an iterator",Py_TYPE(iterator)->tp_name);
        return -1;
    }
    PyObject *value=advance(iterator);
    if(!value && PyErr_Occurred()) {
        if(!PyErr_ExceptionMatches(PyExc_StopIteration))return -1;
        _PyEval_MonitorRaise(PyThreadState_Get(),frame,frame->instr_ptr);
        PyErr_Clear();
    }
    *output=value;
    return value ? 1 : 0;
}
/* Slice bytecodes consume the two bounds, temporarily shrink the source SP
 * for the item protocol, then retire container/value at their original sites. */
static PyObject *slice_bounds(_PyStackRef start, _PyStackRef stop) {
    /* The consuming internal constructor is not exported by python314.dll.
       PySlice_New uses that same constructor with new refs; retire the input
       refs in its start/stop error order once the slice owns them. */
    PyObject *slice=PySlice_New(PyStackRef_AsPyObjectBorrow(start),
                               PyStackRef_AsPyObjectBorrow(stop),NULL);
    PyStackRef_CLOSE(start);PyStackRef_CLOSE(stop);
    return slice;
}
static PyObject *slice_get(_PyInterpreterFrame *frame, _PyStackRef *base) {
    _PyStackRef container=base[0];
    PyObject *slice=slice_bounds(base[1],base[2]);
    PyObject *result=NULL;
    if(slice) {
        frame->stackpointer=base+1;
        result=PyObject_GetItem(PyStackRef_AsPyObjectBorrow(container),slice);
        Py_DECREF(slice);
    }
    frame->stackpointer=base;
    PyStackRef_CLOSE(container);
    return result;
}
static int slice_set(_PyInterpreterFrame *frame, _PyStackRef *base) {
    _PyStackRef value=base[0],container=base[1];
    PyObject *slice=slice_bounds(base[2],base[3]);
    int status=1;
    if(slice) {
        frame->stackpointer=base+2;
        status=PyObject_SetItem(PyStackRef_AsPyObjectBorrow(container),slice,
                               PyStackRef_AsPyObjectBorrow(value));
        Py_DECREF(slice);
    }
    frame->stackpointer=base+4;
    base[1]=PyStackRef_NULL;PyStackRef_CLOSE(container);
    base[0]=PyStackRef_NULL;PyStackRef_CLOSE(value);
    frame->stackpointer=base;
    return status;
}
static void retire_call(_PyInterpreterFrame *frame, _PyStackRef *base, Py_ssize_t count) {
    for (Py_ssize_t i=count;i-- > 0;) {
        _PyStackRef previous=base[i];base[i]=PyStackRef_NULL;
        PyStackRef_XCLOSE(previous);
    }
    frame->stackpointer=base;
}
/* The LLVM guard has established exact builtin type, one argument and no self.
 * Own the heap type before the ordinary CALL retirement can finalize its input. */
static PyObject *type_call_owned(_PyInterpreterFrame *frame, _PyStackRef *base, int *check_pending) {
    *check_pending=_Py_OPCODE(*frame->instr_ptr)==CALL_TYPE_1 ? 0 : 1;
    PyObject *result=Py_NewRef((PyObject *)Py_TYPE(PyStackRef_AsPyObjectBorrow(base[2])));
    retire_call(frame,base,3);
    return result;
}
/* Partial inlining may remove only a child frame that cannot be observed.
 * No guard invokes user code or changes the CALL operands on a miss. */
static int inline_call_guard(_PyInterpreterFrame *frame, _PyStackRef *base,
        Py_ssize_t nargs, PyObject *expected) {
    PyThreadState *thread=PyThreadState_Get();
    if (!PyStackRef_IsNull(base[1])) return 0;
    PyObject *function=PyStackRef_AsPyObjectBorrow(base[0]);
    if (!PyFunction_Check(function) || PyFunction_GetCode(function)!=expected ||
            ((PyFunctionObject *)function)->vectorcall!=standard_function_vectorcall ||
            (!(base[0].bits&Py_TAG_REFCNT) && Py_REFCNT(function)<=1) ||
            thread->py_recursion_remaining<=2 || observed(thread,(PyCodeObject *)expected) ||
            (_Py_atomic_load_uintptr_relaxed(&thread->eval_breaker)&_PY_EVAL_EVENTS_MASK)) return 0;
    for (Py_ssize_t i=0;i<nargs;i++) {
        PyObject *value=PyStackRef_AsPyObjectBorrow(base[i+2]);
        if (value!=Py_None && !PyBool_Check(value) && !PyLong_CheckExact(value) &&
                !PyFloat_CheckExact(value) && !PyComplex_CheckExact(value) &&
                !PyUnicode_CheckExact(value) && !PyBytes_CheckExact(value)) return 0;
    }
    return 1;
}
static PyObject *inline_return_owned(_PyInterpreterFrame *frame, _PyStackRef *base,
        Py_ssize_t nargs, PyObject *expected, Py_ssize_t condition_index,
        PyObject *condition_value, Py_ssize_t result_index, PyObject *constant) {
    if (condition_index>=0 && PyStackRef_AsPyObjectBorrow(base[condition_index+2])!=condition_value)
        return NULL;
    if (!inline_call_guard(frame,base,nargs,expected)) return NULL;
    PyObject *result=Py_NewRef(result_index<0 ? constant : PyStackRef_AsPyObjectBorrow(base[result_index+2]));
    retire_call(frame,base,nargs+2);
    return result;
}
typedef PyObject *(*LibraryBorrowedCall)(PyObject *,PyObject *const *,size_t,PyObject *,void *);
static PyObject *call_owned_dispatch(_PyInterpreterFrame *frame, _PyStackRef *base,
        Py_ssize_t nargs, int keywords, int *check_pending,
        LibraryBorrowedCall dispatch, void *context) {
    PyThreadState *thread=PyThreadState_Get();
    *check_pending=0;
    Py_ssize_t count=nargs+2+keywords;
    _PyStackRef *args=base+2;
    PyObject *names=keywords ? PyStackRef_AsPyObjectBorrow(base[nargs+2]) : NULL;
    PyObject *callable=PyStackRef_AsPyObjectBorrow(base[0]);
    if (Py_TYPE(callable)==&PyMethod_Type && PyStackRef_IsNull(base[1])) {
        _PyStackRef previous=base[0];
        base[1]=PyStackRef_FromPyObjectNew(((PyMethodObject *)callable)->im_self);
        base[0]=PyStackRef_FromPyObjectNew(((PyMethodObject *)callable)->im_func);
        PyStackRef_CLOSE(previous);callable=PyStackRef_AsPyObjectBorrow(base[0]);
    }
    Py_ssize_t total=nargs;
    if (!PyStackRef_IsNull(base[1])) {args--;total++;}
    if (Py_TYPE(callable)==&PyFunction_Type && thread->interp->eval_frame==NULL &&
            ((PyFunctionObject *)callable)->vectorcall==standard_function_vectorcall) {
        _PyThreadStateImpl *state=(_PyThreadStateImpl *)thread;
        uintptr_t here=_Py_get_machine_stack_pointer();
        if (!state->c_stack_hard_limit) _Py_InitializeRecursionLimits(thread);
#if _Py_STACK_GROWS_DOWN
        int near_limit=here<=state->c_stack_soft_limit+2*_PyOS_STACK_MARGIN_BYTES;
#else
        int near_limit=here>=state->c_stack_soft_limit-2*_PyOS_STACK_MARGIN_BYTES;
#endif
        if (near_limit) {*check_pending=-1;return NULL;}
        PyCodeObject *code=(PyCodeObject *)PyFunction_GET_CODE(callable);
        PyObject *locals=code->co_flags&CO_OPTIMIZED ? NULL : Py_NewRef(PyFunction_GET_GLOBALS(callable));
        Py_ssize_t positional=total-(names ? PyTuple_GET_SIZE(names) : 0);
        _PyInterpreterFrame *child=_PyEvalFramePushAndInit(thread,base[0],locals,
            args,positional,names,frame);
        /* The canonical binder consumed callable/self/argument references even
           on failure. Only the keyword tuple remains ours to close. */
        frame->stackpointer=base;
        if (keywords) {
            _PyStackRef previous=base[nargs+2];base[nargs+2]=PyStackRef_NULL;
            PyStackRef_CLOSE(previous);
        }
        if (!child) return NULL;
        return _PyEval_EvalFrameDefault(thread,child,0);
    }
    /* Generic CALL_KW and specialized CALL_KW_NON_PY have different pending
       boundaries. Let Tier 1 execute the current original instruction, including
       its adaptive counter/guard, instead of guessing its future specialization. */
    if (keywords) {*check_pending=-1;return NULL;}
    /* CALL_TYPE_1 has no _CHECK_PERIODIC. A stale specialization whose guard
       misses must still use the generic CALL boundary. Capture it before input
       retirement can run a finalizer and change the interpreter state. */
    *check_pending=!(_Py_OPCODE(*frame->instr_ptr)==CALL_TYPE_1 &&
        callable==(PyObject *)&PyType_Type && PyStackRef_IsNull(base[1]) && nargs==1);
    /* MAX_STACKREF_SCRATCH is 10 in pinned CPython ceval_macros.h; the extra
       leading slot is reserved by PY_VECTORCALL_ARGUMENTS_OFFSET. */
    PyObject *scratch[11];
    PyObject **objects=_PyObjectArray_FromStackRefArray(args,total,scratch+1);
    PyObject *result=NULL;
    if (objects) {
        Py_ssize_t positional=total-(names ? PyTuple_GET_SIZE(names) : 0);
        size_t nargsf=(size_t)positional|PY_VECTORCALL_ARGUMENTS_OFFSET;
        result=dispatch ? dispatch(callable,objects,nargsf,names,context) :
                          PyObject_Vectorcall(callable,objects,nargsf,names);
        _PyObjectArray_Free(objects-1,scratch);
    }
    retire_call(frame,base,count);
    return result;
}
static PyObject *call_owned(_PyInterpreterFrame *frame, _PyStackRef *base,
        Py_ssize_t nargs, int keywords, int *check_pending) {
    return call_owned_dispatch(frame,base,nargs,keywords,check_pending,NULL,NULL);
}
static PyObject *call_library_owned(_PyInterpreterFrame *frame, _PyStackRef *base,
        Py_ssize_t nargs, int keywords, int *check_pending,void *dispatch,void *context) {
    return call_owned_dispatch(frame,base,nargs,keywords,check_pending,
                               (LibraryBorrowedCall)dispatch,context);
}
/* Ordinary unprotected children use CPython's binder and real frame. The body
 * returns an original PC; CPython executes that continuation, including RETURN.
 * No generated function, cell or private argument binder is introduced. */
typedef _Py_CODEUNIT *(*NativeChildBody)(_PyInterpreterFrame *,_PyStackRef *,PyThreadState *);
static _Py_CODEUNIT *native_child_monitor_pc(_PyInterpreterFrame *child) {
    PyCodeObject *code=_PyFrame_GetCode(child);
    Py_ssize_t index=child->instr_ptr-_PyFrame_GetBytecode(child);
    /* The shared builder materializes canonical co_code, whose reserved CACHE
       words are zeroed. CPython error events use next_instr-1 (the final cache
       word), while traceback f_lasti remains the original opcode address. */
    _Py_CODEUNIT *original=(_Py_CODEUNIT *)PyBytes_AS_STRING(code->_co_cached->_co_code);
    Py_ssize_t end=PyBytes_GET_SIZE(code->_co_cached->_co_code)/2;
    while(index+1<end && _Py_OPCODE(original[index+1])==CACHE)index++;
    return _PyFrame_GetBytecode(child)+index;
}
static void native_child_unwind(_PyInterpreterFrame *child) {
    PyThreadState *thread=PyThreadState_Get();
    if(!PyErr_Occurred())PyErr_SetString(PyExc_SystemError,"native child returned NULL without an exception");
    attach_error();
    _Py_CODEUNIT *event_pc=native_child_monitor_pc(child);
    _PyEval_MonitorRaise(thread,child,event_pc);
    clear_stack(child);
    /* monitor_unwind is interpreter-static. Its public monitoring C path has
       the same raised-exception ownership and original code/offset contract. */
    PyCodeObject *code=_PyFrame_GetCode(child);
    if(!thread->tracing && !(code->co_flags&CO_NO_MONITORING_EVENTS) && !_PyEval_NoToolsForUnwind(thread)) {
        PyMonitoringState state={0};uint64_t version=UINT64_MAX;
        const uint8_t event=PY_MONITORING_EVENT_PY_UNWIND;
        if(PyMonitoring_EnterScope(&state,&version,&event,1)==0) {
            PyMonitoring_FirePyUnwindEvent(&state,(PyObject *)code,
                (int32_t)((event_pc-_PyFrame_GetBytecode(child))*2));
            PyMonitoring_ExitScope();
        }
    }
    PyObject *error=PyErr_GetRaisedException();
    pop_frame(child);
    if(error)PyErr_SetRaisedException(error);
}
static PyObject *call_native_owned(_PyInterpreterFrame *frame,_PyStackRef *base,
        Py_ssize_t nargs,int keywords,int *check_pending,PyObject *expected,
        void *body,Py_ssize_t entry_offset,PyObject *owner) {
    PyThreadState *thread=PyThreadState_Get();
    PyObject *function=PyStackRef_AsPyObjectBorrow(base[0]);
    if(Py_TYPE(function)==&PyMethod_Type && PyStackRef_IsNull(base[1]))
        function=((PyMethodObject *)function)->im_func;
    if(!body || !owner || !PyCode_Check(expected) || !PyFunction_Check(function) ||
       PyFunction_GetCode(function)!=expected || ((PyFunctionObject *)function)->vectorcall!=standard_function_vectorcall)
        return call_owned(frame,base,nargs,keywords,check_pending);
    PyCodeObject *code=(PyCodeObject *)expected;
    if(!code->_co_cached || !code->_co_cached->_co_code ||
       code->co_flags&(CO_GENERATOR|CO_COROUTINE|CO_ASYNC_GENERATOR) || code->co_ncellvars ||
       PyBytes_GET_SIZE(code->co_exceptiontable) ||
       (code->co_flags&(CO_OPTIMIZED|CO_NEWLOCALS))!=(CO_OPTIMIZED|CO_NEWLOCALS) ||
       entry_offset!=code->_co_firsttraceable*2 || depth==MAX_NATIVE_DEPTH ||
       thread->py_recursion_remaining<=1 || observed(thread,code) ||
       (_Py_atomic_load_uintptr_relaxed(&thread->eval_breaker)&_PY_EVAL_EVENTS_MASK))
        return call_owned(frame,base,nargs,keywords,check_pending);
    /* Match the existing CALL provider's fail-closed machine-stack guard. */
    _PyThreadStateImpl *state=(_PyThreadStateImpl *)thread;
    if(!state->c_stack_hard_limit)_Py_InitializeRecursionLimits(thread);
    uintptr_t here=_Py_get_machine_stack_pointer();
#if _Py_STACK_GROWS_DOWN
    if(here<=state->c_stack_soft_limit+2*_PyOS_STACK_MARGIN_BYTES)
#else
    if(here>=state->c_stack_soft_limit-2*_PyOS_STACK_MARGIN_BYTES)
#endif
        return call_owned(frame,base,nargs,keywords,check_pending);
    Py_INCREF(owner);*check_pending=0;
    if(Py_TYPE(PyStackRef_AsPyObjectBorrow(base[0]))==&PyMethod_Type && PyStackRef_IsNull(base[1])) {
        PyObject *method=PyStackRef_AsPyObjectBorrow(base[0]);_PyStackRef previous=base[0];
        base[1]=PyStackRef_FromPyObjectNew(((PyMethodObject *)method)->im_self);
        base[0]=PyStackRef_FromPyObjectNew(((PyMethodObject *)method)->im_func);
        PyStackRef_CLOSE(previous);
    }
    function=PyStackRef_AsPyObjectBorrow(base[0]);
    if(PyFunction_GetCode(function)!=expected || observed(thread,code) ||
       ((PyFunctionObject *)function)->vectorcall!=standard_function_vectorcall) {
        PyObject *result=call_owned(frame,base,nargs,keywords,check_pending);Py_DECREF(owner);return result;
    }
    _PyStackRef *args=base+2;Py_ssize_t total=nargs;
    if(!PyStackRef_IsNull(base[1])){args--;total++;}
    PyObject *names=keywords ? PyStackRef_AsPyObjectBorrow(base[nargs+2]) : NULL;
    Py_ssize_t positional=total-(names ? PyTuple_GET_SIZE(names) : 0);
    _PyInterpreterFrame *child=_PyEvalFramePushAndInit(thread,base[0],NULL,args,positional,names,frame);
    frame->stackpointer=base;
    if(keywords){_PyStackRef previous=base[nargs+2];base[nargs+2]=PyStackRef_NULL;PyStackRef_CLOSE(previous);}
    if(!child){Py_DECREF(owner);return NULL;}
    /* Binding can allocate/collect, run finalizers and change a live function.
       The already-bound real frame is then continued once by CPython. */
    if(_PyFrame_GetCode(child)!=code || PyFunction_GetCode(PyStackRef_AsPyObjectBorrow(child->f_funcobj))!=expected ||
       ((PyFunctionObject *)PyStackRef_AsPyObjectBorrow(child->f_funcobj))->vectorcall!=standard_function_vectorcall ||
       thread->py_recursion_remaining<=1 || observed(thread,code) ||
       (_Py_atomic_load_uintptr_relaxed(&thread->eval_breaker)&_PY_EVAL_EVENTS_MASK)) {
        PyObject *result=_PyEval_EvalFrameDefault(thread,child,0);Py_DECREF(owner);return result;
    }
    if(Py_EnterRecursiveCall("")){_PyEval_FrameClearAndPop(thread,child);Py_DECREF(owner);return NULL;}
    Boundary active={boundary,thread,depth,NULL};boundary=&active;
    PyObject *saved_executor=thread->current_executor;
    Py_XINCREF((PyObject *)saved_executor);thread->current_executor=NULL;
    records[depth++]=(SourceRecord){thread,child,1};thread->current_frame=child;thread->py_recursion_remaining--;
    /* This slice copies real free cells. MAKE_CELL remains canonical fallback. */
    PyObject *closure=PyFunction_GetClosure(PyStackRef_AsPyObjectBorrow(child->f_funcobj));int free_index=0;
    for(int i=0;i<code->co_nlocalsplus;i++)
        if((unsigned char)PyBytes_AS_STRING(code->co_localspluskinds)[i]&CO_FAST_FREE)
            child->localsplus[i]=PyStackRef_FromPyObjectNew(PyTuple_GET_ITEM(closure,free_index++));
    child->instr_ptr=_PyFrame_GetBytecode(child)+entry_offset/2;
    _Py_CODEUNIT *next=((NativeChildBody)body)(child,_PyFrame_Stackbase(child),thread);
    PyObject *result=NULL;
    if(!next)native_child_unwind(child);
    else {
        child->instr_ptr=next;
        depth--;thread->current_frame=child->previous;thread->py_recursion_remaining++;Py_LeaveRecursiveCall();
        thread->current_executor=saved_executor;
        result=_PyEval_EvalFrameDefault(thread,child,0);
    }
    thread->current_executor=saved_executor;boundary=active.previous;
    Py_XDECREF((PyObject *)saved_executor);Py_DECREF(owner);
    return result;
}

static PyObject *localsplus_count(PyObject *self, PyObject *code) {
    if (!PyCode_Check(code)) {PyErr_SetString(PyExc_TypeError,"code object required");return NULL;}
    return PyLong_FromLong(((PyCodeObject *)code)->co_nlocalsplus);
}
static PyObject *layout(PyObject *self, PyObject *unused) {
    return Py_BuildValue("{s:n,s:n,s:n,s:n,s:K,s:K,s:n,s:n,s:n,s:n,s:K,s:n,s:n,s:n,s:n,s:n}",
        "locals_offset",(Py_ssize_t)offsetof(_PyInterpreterFrame,localsplus),
        "stackpointer_offset",(Py_ssize_t)offsetof(_PyInterpreterFrame,stackpointer),
        "instrptr_offset",(Py_ssize_t)offsetof(_PyInterpreterFrame,instr_ptr),
        "code_data_offset",(Py_ssize_t)offsetof(PyCodeObject,co_code_adaptive),
        "null_bits",(unsigned long long)PyStackRef_NULL.bits,
        "tag_refcnt",(unsigned long long)Py_TAG_REFCNT,
        "frame_executable_offset",(Py_ssize_t)offsetof(_PyInterpreterFrame,f_executable),
        "thread_frame_offset",(Py_ssize_t)offsetof(PyThreadState,current_frame),
        "thread_executor_offset",(Py_ssize_t)offsetof(PyThreadState,current_executor),
        "thread_eval_breaker_offset",(Py_ssize_t)offsetof(PyThreadState,eval_breaker),
        "eval_events_mask",(unsigned long long)_PY_EVAL_EVENTS_MASK,
        "object_refcount_offset",(Py_ssize_t)offsetof(PyObject,ob_refcnt),
        "object_refcount_size",(Py_ssize_t)sizeof(((PyObject *)0)->ob_refcnt),
        "frame_globals_offset",(Py_ssize_t)offsetof(_PyInterpreterFrame,f_globals),
        "object_type_offset",(Py_ssize_t)offsetof(PyObject,ob_type),
        "float_value_offset",(Py_ssize_t)offsetof(PyFloatObject,ob_fval));
}
/* Re-enter Tier 1 at the NEXT original opcode when a completed operation
 * enabled observers. The caller owns the real frame and publishes its stack. */
static int observers_active(_PyInterpreterFrame *frame) {
    PyThreadState *thread=PyThreadState_Get();
    if(thread->c_tracefunc || thread->c_profilefunc)return 1;
    _PyFrameEvalFunction eval=thread->interp->eval_frame;
    if(eval && eval!=_PyEval_EvalFrameDefault)return 1;
    for(int i=0;i<_PY_MONITORING_UNGROUPED_EVENTS;i++)
        if(thread->interp->monitors.tools[i])return 1;
    PyCodeObject *code=_PyFrame_GetCode(frame);
    if(code->_co_monitoring)for(int i=0;i<_PY_MONITORING_LOCAL_EVENTS;i++)
        if(code->_co_monitoring->local_monitors.tools[i])return 1;
    return 0;
}

static PyObject *addresses(PyObject *self, PyObject *unused) {
    PyObject *result=PyDict_New();
    if (!result)return NULL;
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)enter);
     if (!address || PyDict_SetItemString(result,"enter",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)enter_keywords);
     if (!address || PyDict_SetItemString(result,"enter_keywords",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)mark);
     if (!address || PyDict_SetItemString(result,"mark",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)load);
     if (!address || PyDict_SetItemString(result,"load",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)store);
     if (!address || PyDict_SetItemString(result,"store",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)delete_local);
     if (!address || PyDict_SetItemString(result,"delete",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)cell);
     if (!address || PyDict_SetItemString(result,"cell",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)push);
     if (!address || PyDict_SetItemString(result,"push",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)pop);
     if (!address || PyDict_SetItemString(result,"pop",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)leave);
     if (!address || PyDict_SetItemString(result,"leave",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)leave_raw);
     if (!address || PyDict_SetItemString(result,"leave_raw",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)run_vectorcall);
     if (!address || PyDict_SetItemString(result,"run_vectorcall",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)run_owned_vectorcall);
     if (!address || PyDict_SetItemString(result,"run_owned_vectorcall",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)current_callable);
     if (!address || PyDict_SetItemString(result,"current_callable",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)claim_call_args);
     if (!address || PyDict_SetItemString(result,"claim_call_args",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)word_newref);
     if (!address || PyDict_SetItemString(result,"word_newref",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)word_from_owned);
     if (!address || PyDict_SetItemString(result,"word_from_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)word_dup);
     if (!address || PyDict_SetItemString(result,"word_dup",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)word_close);
     if (!address || PyDict_SetItemString(result,"word_close",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)word_return);
     if (!address || PyDict_SetItemString(result,"word_return",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)unbound);
     if (!address || PyDict_SetItemString(result,"unbound",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)resume_python);
     if (!address || PyDict_SetItemString(result,"resume_python",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)list_append_take_ref);
     if (!address || PyDict_SetItemString(result,"list_append_take_ref",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)list_extend);
     if (!address || PyDict_SetItemString(result,"list_extend",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)common_constant);
     if (!address || PyDict_SetItemString(result,"common_constant",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)global_load);
     if (!address || PyDict_SetItemString(result,"global_load",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)call_owned);
     if (!address || PyDict_SetItemString(result,"call_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)call_library_owned);
     if (!address || PyDict_SetItemString(result,"call_library_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)cell_load);
     if (!address || PyDict_SetItemString(result,"cell_load",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)cell_store);
     if (!address || PyDict_SetItemString(result,"cell_store",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)build_class_load);
     if (!address || PyDict_SetItemString(result,"build_class_load",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)intrinsic_unary);
     if (!address || PyDict_SetItemString(result,"intrinsic_unary",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)intrinsic_binary);
     if (!address || PyDict_SetItemString(result,"intrinsic_binary",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)special_load);
     if (!address || PyDict_SetItemString(result,"special_load",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)cell_delete);
     if (!address || PyDict_SetItemString(result,"cell_delete",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)function_new);
     if (!address || PyDict_SetItemString(result,"function_new",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)function_attribute);
     if (!address || PyDict_SetItemString(result,"function_attribute",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)observers_active);
     if (!address || PyDict_SetItemString(result,"observers_active",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)global_store);
     if (!address || PyDict_SetItemString(result,"global_store",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)global_delete);
     if (!address || PyDict_SetItemString(result,"global_delete",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)dict_expand);
     if (!address || PyDict_SetItemString(result,"dict_expand",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)async_iter_get);
     if (!address || PyDict_SetItemString(result,"async_iter_get",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)async_iter_check);
     if (!address || PyDict_SetItemString(result,"async_iter_check",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)iter_next);
     if (!address || PyDict_SetItemString(result,"iter_next",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)slice_get);
     if (!address || PyDict_SetItemString(result,"slice_get",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)slice_set);
     if (!address || PyDict_SetItemString(result,"slice_set",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)generator_get_iter);
     if (!address || PyDict_SetItemString(result,"generator_get_iter",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)global_load_owned);
     if (!address || PyDict_SetItemString(result,"global_load_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)call_native_owned);
     if (!address || PyDict_SetItemString(result,"call_native_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)type_call_owned);
     if (!address || PyDict_SetItemString(result,"type_call_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    {PyObject *address=PyLong_FromVoidPtr((void *)(uintptr_t)inline_return_owned);
     if (!address || PyDict_SetItemString(result,"inline_return_owned",address)<0) {Py_XDECREF(address);Py_DECREF(result);return NULL;}
     Py_DECREF(address);}
    return result;
}
static PyObject *run_entry(PyObject *self, PyObject *args) {
    PyObject *callable,*arguments;
    if (!PyArg_ParseTuple(args,"OO!",&callable,&PyTuple_Type,&arguments)) return NULL;
    if (!PyCFunction_Check(callable)) {
        PyErr_SetString(PyExc_TypeError,"source barrier requires direct native entry");return NULL;
    }
    Boundary active={boundary,PyThreadState_Get(),depth,NULL};
    boundary=&active;
    PyObject *result=PyObject_CallObject(callable,arguments);
    while (depth>active.depth) {
        _PyInterpreterFrame *frame=records[depth-1].frame;
        if (result) {Py_DECREF(result);result=NULL;
            PyErr_SetString(PyExc_SystemError,"native body left active source frame");}
        if (!PyErr_Occurred()) PyErr_SetString(PyExc_SystemError,"native body missing error");
        attach_error();
        clear_stack(frame);
        pop_frame(frame);
    }
    boundary=active.previous;
    return result;
}
static PyObject *state(PyObject *self, PyObject *unused) {
    return PyLong_FromLong(depth);
}
static PyMethodDef methods[]={
    {"addresses",addresses,METH_NOARGS,NULL},
    {"layout",layout,METH_NOARGS,NULL},
    {"localsplus_count",localsplus_count,METH_O,NULL},
    {"run_entry",run_entry,METH_VARARGS,NULL},
    {"active_depth",state,METH_NOARGS,NULL},
    {NULL}
};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_source_frames_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__source_frames_native(void) {
    /* Capture the pinned runtime's standard pointer once, without retaining a
       source function/code or allocating anything on a native call path. */
    PyCodeObject *code=PyCode_NewEmpty("<ir-call-runtime>","<ir-call-runtime>",1);
    if (!code) return NULL;
    PyObject *globals=PyDict_New();
    if (!globals) {Py_DECREF(code);return NULL;}
    PyObject *function=PyFunction_New((PyObject *)code,globals);
    Py_DECREF(globals);Py_DECREF(code);
    if (!function) return NULL;
    standard_function_vectorcall=((PyFunctionObject *)function)->vectorcall;
    Py_DECREF(function);
    return PyModule_Create(&module);
}

