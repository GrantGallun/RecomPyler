/* This private runtime layout is deliberately scoped to the installed ABI.
 * Other interpreters use the unchanged Python guard path. */
#if PY_MAJOR_VERSION == 3 && PY_MINOR_VERSION == 14 && PY_MICRO_VERSION == 4 && defined(_WIN32) && SIZEOF_VOID_P == 8 && !defined(Py_GIL_DISABLED) && !defined(WITH_DTRACE) && !defined(Py_DEBUG) && !defined(Py_TRACE_REFS) && !defined(Py_STATS) && defined(RECOMPYLER_GUARD_BUILD_SIGNATURE)
#define GUARD_AUDIT_CAPABILITY 1
#ifndef Py_BUILD_CORE
#define Py_BUILD_CORE
#define GUARD_UNDEF_BUILD_CORE
#endif
#include "internal/pycore_runtime.h"
#include "internal/pycore_lock.h"
#ifdef GUARD_UNDEF_BUILD_CORE
#undef Py_BUILD_CORE
#undef GUARD_UNDEF_BUILD_CORE
#endif
#else
#define GUARD_AUDIT_CAPABILITY 0
#endif

static int guard_begin(void) {
#if GUARD_AUDIT_CAPABILITY
    /* Public version check precedes every private-layout dereference. */
    if (Py_Version != PY_VERSION_HEX ||
            strcmp(Py_GetVersion(), RECOMPYLER_GUARD_BUILD_SIGNATURE) != 0) return 0;
    if (!PyMutex_LockFast(&_PyRuntime.audit_hooks.mutex)) return 0;
    PyInterpreterState *interp=PyInterpreterState_Get();
    if (_PyRuntime.audit_hooks.head!=NULL || interp->audit_hooks!=NULL) {
        PyMutex_Unlock(&_PyRuntime.audit_hooks.mutex);
        return 0;
    }
    return 1;
#else
    return 0;
#endif
}

static void guard_end(void) {
#if GUARD_AUDIT_CAPABILITY
    PyMutex_Unlock(&_PyRuntime.audit_hooks.mutex);
#endif
}

/* Live, allocation-free checks of the existing guard grammar. Unsupported
 * metadata returns None and is handled by the original ordered Python checker.
 * No dictionary-domain cache survives this GIL-held call. */
typedef struct { PyObject *dicts[64]; size_t used; } GuardScan;
enum { GUARD_UNKNOWN = -1, GUARD_NO = 0, GUARD_YES = 1 };

static int guard_dict(GuardScan *scan, PyObject *value) {
    if (value==NULL || !PyDict_CheckExact(value)) return 0;
    for (size_t i=0; i<scan->used; i++) if (scan->dicts[i]==value) return 1;
    Py_ssize_t at=0; PyObject *key, *item;
    while (PyDict_Next(value,&at,&key,&item))
        if (!PyUnicode_CheckExact(key)) return 0;
    if (scan->used<sizeof(scan->dicts)/sizeof(scan->dicts[0]))
        scan->dicts[scan->used++]=value;
    return 1;
}

/* PyType_GetDict handles interpreter-managed static builtin dictionaries.
 * It only returns a new reference; the still-live type/state owns the dict.
 * Balance that temporary reference before retaining a borrowed local pointer. */
static PyObject *guard_type_dict(PyTypeObject *type) {
    PyObject *dict=PyType_GetDict(type);
    if (dict!=NULL) Py_DECREF(dict);
    return dict;
}

static int guard_name(PyObject *name, const char *expected) {
    return PyUnicode_CheckExact(name) && PyUnicode_CompareWithASCIIString(name,expected)==0;
}

static PyObject *guard_named(PyObject *dict, const char *name) {
    Py_ssize_t at=0; PyObject *key, *value;
    while (PyDict_Next(dict,&at,&key,&value))
        if (guard_name(key,name)) return value;
    return NULL;
}

static PyObject *guard_get(PyObject *dict, PyObject *key) {
    PyObject *value=PyDict_GetItemWithError(dict,key);
    return value==NULL && !PyErr_Occurred() ? Py_None : value;
}

static PyObject *guard_staticmethod(GuardScan *scan, PyObject *value) {
    if (Py_TYPE(value)!=&PyStaticMethod_Type ||
            !guard_dict(scan,guard_type_dict(&PyStaticMethod_Type))) return NULL;
    PyObject *descriptor=guard_named(guard_type_dict(&PyStaticMethod_Type),"__func__");
    if (descriptor==NULL || Py_TYPE(descriptor)!=&PyMemberDescr_Type ||
            PyDescr_TYPE(descriptor)!=&PyStaticMethod_Type) return NULL;
    PyMemberDef *member=((PyMemberDescrObject *)descriptor)->d_member;
    if (member==NULL || (member->type!=_Py_T_OBJECT && member->type!=Py_T_OBJECT_EX) ||
            !(member->flags&Py_READONLY) || (member->flags&(Py_AUDIT_READ|Py_RELATIVE_OFFSET)) || member->offset<(Py_ssize_t)sizeof(PyObject) ||
            PyStaticMethod_Type.tp_basicsize<(Py_ssize_t)sizeof(PyObject *) ||
            member->offset>PyStaticMethod_Type.tp_basicsize-(Py_ssize_t)sizeof(PyObject *)) return NULL;
    PyObject *callable;
    memcpy(&callable,(const char *)value+member->offset,sizeof(callable));
    return callable;  /* NULL is unsupported, including uninitialized OBJECT_EX. */
}

static int guard_mro(GuardScan *scan, PyObject *value) {
    if (Py_TYPE(value)!=&PyType_Type) return 0;
    PyObject *mro=((PyTypeObject *)value)->tp_mro;
    if (mro==NULL || !PyTuple_CheckExact(mro)) return 0;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(mro);i++) {
        PyObject *base=PyTuple_GET_ITEM(mro,i);
        if (Py_TYPE(base)!=&PyType_Type || !guard_dict(scan,guard_type_dict((PyTypeObject *)base))) return 0;
    }
    return 1;
}

static int guard_lifetime(GuardScan *scan, PyObject *value) {
    if (!guard_mro(scan,value) || !guard_dict(scan,guard_type_dict(&PyBaseObject_Type))) return GUARD_UNKNOWN;
    PyObject *mro=((PyTypeObject *)value)->tp_mro, *allocator=NULL;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(mro);i++) {
        PyObject *dict=guard_type_dict((PyTypeObject *)PyTuple_GET_ITEM(mro,i));
        if (guard_named(dict,"__del__")!=NULL) return GUARD_NO;
        if (allocator==NULL) allocator=guard_named(dict,"__new__");
    }
    if (allocator==NULL) return GUARD_NO;
    if (Py_TYPE(allocator)==&PyStaticMethod_Type) {
        allocator=guard_staticmethod(scan,allocator);
        if (allocator==NULL) return GUARD_UNKNOWN;
    }
    return allocator==guard_named(guard_type_dict(&PyBaseObject_Type),"__new__");
}

/* Borrow an attribute only where class getattr cannot invoke user code. */
static int guard_attribute(GuardScan *scan, PyObject *owner, PyObject *name, PyObject **out) {
    if (!PyUnicode_CheckExact(name)) return 0;
    if (Py_TYPE(owner)==&PyFunction_Type) {
        if (guard_name(name,"__defaults__")) *out=PyFunction_GET_DEFAULTS(owner);
        else if (guard_name(name,"__kwdefaults__")) *out=PyFunction_GET_KW_DEFAULTS(owner);
        else if (guard_name(name,"__code__")) *out=PyFunction_GET_CODE(owner);
        else return 0;
        if (*out==NULL) *out=Py_None;
        return 1;
    }
    if (!guard_mro(scan,owner) || !guard_mro(scan,(PyObject *)&PyType_Type)) return 0;
    PyObject *metamro=PyType_Type.tp_mro; int meta_found=0;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(metamro);i++) {
        PyObject *meta=PyDict_GetItemWithError(guard_type_dict((PyTypeObject *)PyTuple_GET_ITEM(metamro,i)),name);
        if (meta!=NULL) {
            meta_found=1;
            if (Py_TYPE(meta)->tp_descr_set!=NULL) return 0;
            break;
        }
    }
    PyObject *mro=((PyTypeObject *)owner)->tp_mro, *value=NULL;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(mro);i++) {
        value=PyDict_GetItemWithError(guard_type_dict((PyTypeObject *)PyTuple_GET_ITEM(mro,i)),name);
        if (value!=NULL) break;
    }
    if (value==NULL) { if (meta_found) return 0; *out=Py_None;return !PyErr_Occurred(); }
    if (Py_TYPE(value)==&PyStaticMethod_Type) {
        value=guard_staticmethod(scan,value);
        if (value==NULL) return 0;
    } else if (Py_TYPE(value)!=&PyFunction_Type &&
            Py_TYPE(value)!=&PyMemberDescr_Type && Py_TYPE(value)!=&PyGetSetDescr_Type &&
            Py_TYPE(value)!=&PyMethodDescr_Type && Py_TYPE(value)!=&PyWrapperDescr_Type &&
            Py_TYPE(value)->tp_descr_get!=NULL) return 0;
    *out=value;return 1;
}

static int guard_constant(PyObject *current, PyObject *saved) {
    if (Py_TYPE(current)!=Py_TYPE(saved)) return GUARD_NO;
    if (current==Py_None || PyBool_Check(current)) return current==saved;
    if (PyLong_CheckExact(current)) return PyObject_RichCompareBool(current,saved,Py_EQ);
    if (PyFloat_CheckExact(current)) {
        double a=PyFloat_AS_DOUBLE(current),b=PyFloat_AS_DOUBLE(saved);
        return a==b && memcmp(&a,&b,sizeof(a))==0; /* NaN fails, signed zeros differ. */
    }
    if (PyUnicode_CheckExact(current)) return PyUnicode_Compare(current,saved)==0;
    if (PyBytes_CheckExact(current)) return PyBytes_GET_SIZE(current)==PyBytes_GET_SIZE(saved) &&
        memcmp(PyBytes_AS_STRING(current),PyBytes_AS_STRING(saved),(size_t)PyBytes_GET_SIZE(current))==0;
    return GUARD_UNKNOWN;
}

static PyObject *guard_answer(int answer) {
    if (PyErr_Occurred()) return NULL;
    if (answer==GUARD_UNKNOWN) Py_RETURN_NONE;
    return PyBool_FromLong(answer);
}

static PyObject *check_heap_guards_scan(PyObject *self, PyObject *guards) {
#ifdef Py_GIL_DISABLED
    Py_RETURN_NONE;
#else
    if (!PyDict_CheckExact(guards)) Py_RETURN_NONE;
    GuardScan scan={0}; Py_ssize_t at=0; PyObject *key,*guard;
    while (PyDict_Next(guards,&at,&key,&guard)) {
        if (!PyTuple_CheckExact(guard) || PyTuple_GET_SIZE(guard)==0) Py_RETURN_NONE;
        Py_ssize_t n=PyTuple_GET_SIZE(guard); PyObject *tag=PyTuple_GET_ITEM(guard,0);
        if (!PyUnicode_CheckExact(tag)) Py_RETURN_NONE;
#define G(i) PyTuple_GET_ITEM(guard,i)
        int answer=GUARD_UNKNOWN;
        if (guard_name(tag,"code") && n==3) {
            if (Py_TYPE(G(1))!=&PyFunction_Type) Py_RETURN_NONE;
            answer=PyFunction_GET_CODE(G(1))==G(2);
        } else if (guard_name(tag,"lifetime") && n==2) answer=guard_lifetime(&scan,G(1));
        else if (guard_name(tag,"attr") && n==4) {
            PyObject *value;
            if (!guard_attribute(&scan,G(1),G(2),&value)) return guard_answer(GUARD_UNKNOWN);
            answer=value==G(3);
        } else if (guard_name(tag,"own") && n==4) {
            if (Py_TYPE(G(1))!=&PyType_Type || !guard_dict(&scan,guard_type_dict((PyTypeObject *)G(1))) || !PyUnicode_CheckExact(G(2))) Py_RETURN_NONE;
            answer=guard_get(guard_type_dict((PyTypeObject *)G(1)),G(2))==G(3);
        } else if ((guard_name(tag,"item") || guard_name(tag,"const")) && n==4) {
            if (!guard_dict(&scan,G(1)) || !PyUnicode_CheckExact(G(2))) Py_RETURN_NONE;
            PyObject *value=guard_get(G(1),G(2));
            if (value==NULL) return NULL;
            answer=guard_name(tag,"item") ? value==G(3) : guard_constant(value,G(3));
        } else if (guard_name(tag,"builtin") && n==5) {
            if (!guard_dict(&scan,G(1)) || !guard_dict(&scan,G(3)) || !PyUnicode_CheckExact(G(2))) Py_RETURN_NONE;
            PyObject *present=PyDict_GetItemWithError(G(1),G(2));
            answer=present==NULL && guard_get(G(3),G(2))==G(4);
        } else if (guard_name(tag,"kwdefaults") && n==4) {
            if (Py_TYPE(G(1))!=&PyFunction_Type || !PyTuple_CheckExact(G(3))) Py_RETURN_NONE;
            PyObject *current=PyFunction_GET_KW_DEFAULTS(G(1));
            if (current!=G(2) || current==NULL || !PyDict_CheckExact(current) || PyDict_GET_SIZE(current)!=PyTuple_GET_SIZE(G(3))) return guard_answer(GUARD_NO);
            if (!guard_dict(&scan,current)) Py_RETURN_NONE;
            answer=GUARD_YES;
            for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(G(3));i++) {
                PyObject *item=PyTuple_GET_ITEM(G(3),i);
                if (!PyTuple_CheckExact(item) || PyTuple_GET_SIZE(item)!=2 || !PyUnicode_CheckExact(PyTuple_GET_ITEM(item,0))) Py_RETURN_NONE;
                PyObject *value=PyDict_GetItemWithError(current,PyTuple_GET_ITEM(item,0));
                if (value==NULL || value!=PyTuple_GET_ITEM(item,1)) {answer=GUARD_NO;break;}
            }
        }
#undef G
        if (answer!=GUARD_YES) return guard_answer(answer);
    }
    return guard_answer(GUARD_YES);
#endif
}
/* Flat Lift guards: a plain identity miss needs its existing full equivalence
 * path, so only definitive inert code/builtin/math failures return False. */
static PyObject *check_lift_guards_scan(PyObject *self, PyObject *const *args, Py_ssize_t nargs) {
#ifdef Py_GIL_DISABLED
    Py_RETURN_NONE;
#else
    if (nargs!=2 || !PyTuple_CheckExact(args[0]) || PyTuple_GET_SIZE(args[0])!=3) Py_RETURN_NONE;
    GuardScan scan={0};
    for (Py_ssize_t group=0;group<3;group++) {
        PyObject *rows=PyTuple_GET_ITEM(args[0],group);
        if (!PyList_CheckExact(rows)) Py_RETURN_NONE;
        for (Py_ssize_t i=0;i<PyList_GET_SIZE(rows);i++) {
            PyObject *row=PyList_GET_ITEM(rows,i);
            if (!PyTuple_CheckExact(row) || PyTuple_GET_SIZE(row)!=(group==2 ? 2 : 4)) Py_RETURN_NONE;
            if (group==0) {
                PyObject *space=PyTuple_GET_ITEM(row,0),*name=PyTuple_GET_ITEM(row,1),*expected=PyTuple_GET_ITEM(row,2),*code=PyTuple_GET_ITEM(row,3);
                if (!guard_dict(&scan,space) || !PyUnicode_CheckExact(name)) Py_RETURN_NONE;
                PyObject *value=guard_get(space,name);
                if (value==NULL) return NULL;
                if (value!=expected) Py_RETURN_NONE;
                if (code!=Py_None) {
                    if (Py_TYPE(value)!=&PyFunction_Type) Py_RETURN_NONE;
                    if (PyFunction_GET_CODE(value)!=code) Py_RETURN_FALSE;
                }
            } else if (group==1) {
                PyObject *space=PyTuple_GET_ITEM(row,0),*name=PyTuple_GET_ITEM(row,1),*lookup=PyTuple_GET_ITEM(row,2),*expected=PyTuple_GET_ITEM(row,3);
                if (!guard_dict(&scan,space) || !guard_dict(&scan,lookup) || !PyUnicode_CheckExact(name)) Py_RETURN_NONE;
                PyObject *value=PyDict_GetItemWithError(space,name);
                if (value==NULL && !PyErr_Occurred()) value=guard_get(lookup,name);
                if (value==NULL) return NULL;
                if (value!=expected) Py_RETURN_FALSE;
            } else {
                PyObject *name=PyTuple_GET_ITEM(row,0),*expected=PyTuple_GET_ITEM(row,1);
                if (!guard_dict(&scan,args[1]) || !PyUnicode_CheckExact(name)) Py_RETURN_NONE;
                if (guard_get(args[1],name)!=expected) return guard_answer(GUARD_NO);
            }
        }
    }
    return guard_answer(GUARD_YES);
#endif
}

/* Even NULL/error and unsupported results leave through the one unlock site.
 * No Python checker or audited getter is invoked while this mutex is held. */
static PyObject *check_heap_guards(PyObject *self, PyObject *guards) {
    if (!guard_begin()) Py_RETURN_NONE;
    PyObject *answer=check_heap_guards_scan(self,guards);
    guard_end();
    return answer;
}

static PyObject *check_lift_guards(PyObject *self, PyObject *const *args, Py_ssize_t nargs) {
    if (!guard_begin()) Py_RETURN_NONE;
    PyObject *answer=check_lift_guards_scan(self,args,nargs);
    guard_end();
    return answer;
}
