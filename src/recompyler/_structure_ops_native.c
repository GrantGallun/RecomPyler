#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdint.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error S66 inline cache requires installed CPython 3.14.4 GIL ABI
#endif
#define Py_BUILD_CORE
#include "internal/pycore_dict.h"
#include "internal/pycore_interp_structs.h"
#undef Py_BUILD_CORE

typedef struct {
    PyObject *name;
    unsigned int version;
    Py_ssize_t index;
    unsigned long long hits;
} AttrCache;

typedef struct {
    int64_t interp_id;
    uint32_t version;
} IdentityKeyCache;

static void drop_identity_cache(PyObject *capsule) {
    void *cache=PyCapsule_GetPointer(capsule,"recompyler.identity-key-cache");
    if (cache) PyMem_Free(cache);
}
static PyObject *new_identity_cache(PyObject *self,PyObject *unused) {
    IdentityKeyCache *cache=PyMem_Calloc(1,sizeof(IdentityKeyCache));
    if (!cache) return PyErr_NoMemory();
    cache->interp_id=-1;
    PyObject *capsule=PyCapsule_New(cache,"recompyler.identity-key-cache",drop_identity_cache);
    if (!capsule) PyMem_Free(cache);
    return capsule;
}
static PyObject *identity_cache_address(PyObject *self,PyObject *capsule) {
    void *cache=PyCapsule_GetPointer(capsule,"recompyler.identity-key-cache");
    return cache ? PyLong_FromVoidPtr(cache) : NULL;
}
static PyObject *identity_cache_state(PyObject *self,PyObject *capsule) {
    IdentityKeyCache *cache=PyCapsule_GetPointer(capsule,"recompyler.identity-key-cache");
    return cache ? Py_BuildValue("(LK)",(long long)cache->interp_id,
                                (unsigned long long)cache->version) : NULL;
}


/* Same interpreter-initialized identity used by CPython specialization.
 * Module/name metadata and mutable builtins dictionaries cannot authenticate it. */
__declspec(dllexport) int rc_structure_isinstance_builtin(PyObject *callee) {
    return callee==PyInterpreterState_Get()->callable_cache.isinstance;
}

static PyCFunction append_function, add_function, get_function;
static int append_flags, add_flags, get_flags;

/* Inspect the captured callable after argument evaluation. Names are irrelevant. */
__declspec(dllexport) int rc_structure_method_kind(PyObject *callee) {
    if (!PyCFunction_Check(callee)) return 0;
    PyObject *self=PyCFunction_GET_SELF(callee);
    if (!self) return 0;
    PyCFunction function=PyCFunction_GET_FUNCTION(callee);
    int flags=PyCFunction_GET_FLAGS(callee);
    if (function==append_function && flags==append_flags && PyList_CheckExact(self)) return 1;
    if (function==add_function && flags==add_flags && PySet_CheckExact(self)) return 2;
    if (function==get_function && flags==get_flags && PyDict_CheckExact(self)) return 3;
    return 0;
}
__declspec(dllexport) PyObject *rc_structure_method_value(PyObject *callee,PyObject *first,PyObject *second,int kind) {
    PyObject *self=PyCFunction_GET_SELF(callee);
    if (kind==1) {
        if (PyList_Append(self,first)<0) return NULL;
        return Py_NewRef(Py_None);
    }
    if (kind==2) {
        if (PySet_Add(self,first)<0) return NULL;
        return Py_NewRef(Py_None);
    }
    PyObject *value=NULL;
    int found=PyDict_GetItemRef(self,first,&value);
    if (found<0) return NULL;
    return found ? value : Py_NewRef(second);
}
__declspec(dllexport) int rc_structure_sequence_matches(PyObject *value,Py_ssize_t count) {
    return (PyTuple_CheckExact(value) && PyTuple_GET_SIZE(value)==count) ||
           (PyList_CheckExact(value) && PyList_GET_SIZE(value)==count);
}
__declspec(dllexport) PyObject *rc_structure_unpack(PyObject *value) {
    /* Snapshot every value before the first target store can run a callback. */
    return PyTuple_CheckExact(value) ? Py_NewRef(value) : PyList_AsTuple(value);
}

static void drop_cache(PyObject *capsule) {
    AttrCache *cache=PyCapsule_GetPointer(capsule,"recompyler.attribute-cache");
    if (cache) { Py_XDECREF(cache->name); PyMem_Free(cache); }
}
static PyObject *new_cache(PyObject *self,PyObject *unused) {
    AttrCache *cache=PyMem_Calloc(1,sizeof(AttrCache));
    if (!cache) return PyErr_NoMemory();
    cache->index=-1;
    PyObject *capsule=PyCapsule_New(cache,"recompyler.attribute-cache",drop_cache);
    if (!capsule) PyMem_Free(cache);
    return capsule;
}
static AttrCache *as_cache(PyObject *object) {
    return PyCapsule_GetPointer(object,"recompyler.attribute-cache");
}
static int specialize(PyObject *owner,PyObject *name,AttrCache *cache) {
    cache->version=0;cache->index=-1;
    Py_XSETREF(cache->name,Py_NewRef(name));
    PyTypeObject *type=Py_TYPE(owner);
    if (!type->tp_version_tag) PyUnstable_Type_AssignVersionTag(type);
    cache->version=type->tp_version_tag;
    if (!PyUnicode_CheckExact(name) || type->tp_getattro!=PyObject_GenericGetAttr) return 0;
    int legacy=!(type->tp_flags & Py_TPFLAGS_MANAGED_DICT) && type->tp_dictoffset>0;
    if (!legacy && (!(type->tp_flags & Py_TPFLAGS_INLINE_VALUES) ||
                    !(type->tp_flags & Py_TPFLAGS_MANAGED_DICT))) return 0;
    PyObject *descriptor=_PyType_LookupRef(type,name);
    int class_attribute=descriptor!=NULL;
    Py_XDECREF(descriptor);
    /* A descriptor's class can gain __set__ without invalidating this owner's
     * type version. No class attribute is a sufficient callback-free proof. */
    if (class_attribute) return 0;
    /* Traditional dictionaries (including ast.AST) have no inline values.
     * A negative marker keeps existing LLVM inline guards out of this lane. */
    if (legacy) { cache->version=type->tp_version_tag;cache->index=-2;return 0; }
    if (!type->tp_version_tag && !PyUnstable_Type_AssignVersionTag(type)) return 0;
    PyDictKeysObject *keys=((PyHeapTypeObject*)type)->ht_cached_keys;
    if (!keys || keys->dk_kind!=DICT_KEYS_SPLIT) return 0;
    PyDictUnicodeEntry *entries=DK_UNICODE_ENTRIES(keys);
    for (Py_ssize_t i=0;i<keys->dk_nentries;i++) {
        PyObject *key=entries[i].me_key;
        if (key==name || (PyUnicode_CheckExact(key) && PyUnicode_Compare(key,name)==0)) {
            cache->version=type->tp_version_tag;cache->index=i;return 1;
        }
    }
    return 0;
}
static PyDictValues *values_for(PyObject *owner,PyObject *name,AttrCache *cache) {
    PyTypeObject *type=Py_TYPE(owner);
    if (cache->name!=name || !cache->version || type->tp_version_tag!=cache->version) {
        if (!specialize(owner,name,cache)) return NULL;
        type=Py_TYPE(owner);
    }
    if (cache->index<0) return NULL;
    PyDictValues *values=_PyObject_InlineValues(owner);
    if (!values->valid || cache->index<0 || cache->index>=values->capacity) return NULL;
    return values;
}
/* No descriptor, hash or equality callbacks: exact Unicode-only dictionary.
 * GENERAL dictionaries may contain hostile colliding keys and must fall back
 * without a speculative lookup. This never materializes an instance dict. */
static PyObject *legacy_value(PyObject *owner,PyObject *name,AttrCache *cache) {
    PyTypeObject *type=Py_TYPE(owner);
    if (cache->index!=-2 || cache->name!=name || !cache->version ||
            type->tp_version_tag!=cache->version) return NULL;
    PyObject *dictionary=*(PyObject **)((char *)owner+type->tp_dictoffset);
    if (!dictionary || !PyDict_CheckExact(dictionary) ||
            ((PyDictObject *)dictionary)->ma_keys->dk_kind==DICT_KEYS_GENERAL) return NULL;
    return PyDict_GetItemWithError(dictionary,name);
}
/* Nullable BORROWED result for a proved callback-free loop. A miss does not
 * invoke Python or set an exception. The shared lowerer owns current-state
 * fallback and the lifetime proof for borrowed operands/results. */
__declspec(dllexport) PyObject *rc_structure_try_load_attr(PyObject *owner,PyObject *name,AttrCache *cache) {
    if (!PyUnicode_CheckExact(name)) return NULL;
    PyDictValues *values=values_for(owner,name,cache);
    if (!values) return legacy_value(owner,name,cache);
    if (_PyObject_GetManagedDict(owner)) return NULL;
    return values->values[cache->index];
}
/* Dictionary resident keys matter: a hostile colliding key may invoke equality
 * even when the lookup key itself has identity hashing. No user code here. */
__declspec(dllexport) int rc_structure_identity_dict_guard(PyObject *owner) {
    if (!PyDict_CheckExact(owner)) return 0;
    Py_ssize_t position=0;PyObject *key,*value;
    while (PyDict_Next(owner,&position,&key,&value)) {
        if (Py_TYPE(key)!=&PyType_Type) return 0;
    }
    return 1;
}
/* A positive domain proof owns no dictionary, keys, values or key table.
 * CPython resets dk_version on every key change; versions are unique within
 * the interpreter. Zero after the uint32 counter wraps is never cached.
 * The counter assignment is the installed 3.14.4 GIL implementation of
 * get_next_dict_keys_version/_PyDictKeys_GetVersionForCurrentState. */
__declspec(dllexport) int rc_structure_identity_dict_guard_cached(PyObject *owner,IdentityKeyCache *cache) {
    if (!PyDict_CheckExact(owner)) return 0;
    PyInterpreterState *interp=PyInterpreterState_Get();
    /* Shared split keys do not describe each dictionary's live values. */
    if (((PyDictObject *)owner)->ma_values) return rc_structure_identity_dict_guard(owner);
    PyDictKeysObject *keys=((PyDictObject *)owner)->ma_keys;
    uint32_t version=keys->dk_version;
    if (version && cache->interp_id==interp->id && cache->version==version) return 1;
    if (!rc_structure_identity_dict_guard(owner)) return 0;
    if (!version && interp->dict_state.next_keys_version) {
        version=interp->dict_state.next_keys_version++;
        keys->dk_version=version;
    }
    cache->interp_id=interp->id;cache->version=version;
    return 1;
}
static __forceinline PyObject *structure_load_attr(PyObject *owner,PyObject *name,AttrCache *cache,int counted) {
    PyDictValues *values=values_for(owner,name,cache);
    if (values) {
        PyObject *value=values->values[cache->index];
        if (value) { if (counted) cache->hits++;return Py_NewRef(value); }
    }
    /* Traditional-dict borrowing is prepared for proved read-only IR loops.
     * Keep the existing owned generic path until a whole-helper gain is shown. */
    return PyObject_GetAttr(owner,name);
}
__declspec(dllexport) PyObject *rc_structure_load_attr(PyObject *owner,PyObject *name,AttrCache *cache) {
    return structure_load_attr(owner,name,cache,1);
}
__declspec(dllexport) PyObject *rc_structure_load_attr_uncounted(PyObject *owner,PyObject *name,AttrCache *cache) {
    return structure_load_attr(owner,name,cache,0);
}
static __forceinline int structure_store_attr(PyObject *owner,PyObject *name,PyObject *value,AttrCache *cache,int counted) {
    PyDictValues *values=values_for(owner,name,cache);
    if (values && Py_TYPE(owner)->tp_setattro==PyObject_GenericSetAttr && !_PyObject_GetManagedDict(owner)) {
        PyObject *old=values->values[cache->index];
        if (!old) _PyDictValues_AddToInsertionOrder(values,cache->index);
        values->values[cache->index]=Py_NewRef(value);
        if (counted) cache->hits++;
        /* Publishing precedes decref: finalizers may change type/dictionary. */
        Py_XDECREF(old);
        return 0;
    }
    return PyObject_SetAttr(owner,name,value);
}
__declspec(dllexport) int rc_structure_store_attr(PyObject *owner,PyObject *name,PyObject *value,AttrCache *cache) {
    return structure_store_attr(owner,name,value,cache,1);
}
__declspec(dllexport) int rc_structure_store_attr_uncounted(PyObject *owner,PyObject *name,PyObject *value,AttrCache *cache) {
    return structure_store_attr(owner,name,value,cache,0);
}
__declspec(dllexport) PyObject *rc_structure_getitem(PyObject *owner,PyObject *key) {
    if (PyDict_CheckExact(owner)) {
        PyObject *value=NULL;
        int found=PyDict_GetItemRef(owner,key,&value);
        if (found>0) return value;
        if (found==0) {
            PyObject *arguments=PyTuple_Pack(1,key);
            if (arguments) {PyErr_SetObject(PyExc_KeyError,arguments);Py_DECREF(arguments);}
        }
        return NULL;
    }
    if ((PyList_CheckExact(owner) || PyTuple_CheckExact(owner)) && PyLong_CheckExact(key)) {
        Py_ssize_t index=PyNumber_AsSsize_t(key,PyExc_IndexError);
        if (index==-1 && PyErr_Occurred()) return NULL;
        Py_ssize_t size=Py_SIZE(owner);
        if (index<0) index+=size;
        if (index<0 || index>=size) {
            PyErr_SetString(PyExc_IndexError,PyList_CheckExact(owner) ? "list index out of range" : "tuple index out of range");
            return NULL;
        }
        return Py_NewRef(PyList_CheckExact(owner) ? PyList_GET_ITEM(owner,index) : PyTuple_GET_ITEM(owner,index));
    }
    return PyObject_GetItem(owner,key);
}
__declspec(dllexport) int rc_structure_setitem(PyObject *owner,PyObject *key,PyObject *value) {
    if (PyDict_CheckExact(owner)) return PyDict_SetItem(owner,key,value);
    return PyObject_SetItem(owner,key,value);
}
__declspec(dllexport) int rc_structure_contains(PyObject *owner,PyObject *key) {
    if (PyDict_CheckExact(owner)) return PyDict_Contains(owner,key);
    /* The language protocol converts an unhashable set key to frozenset;
       PySet_Contains deliberately does not. Preserve that special case. */
    if (PyAnySet_CheckExact(owner) && !PySet_Check(key)) return PySet_Contains(owner,key);
    return PySequence_Contains(owner,key);
}
static PyObject *load(PyObject *self,PyObject *args) {
    PyObject *owner,*name,*capsule;
    if (!PyArg_ParseTuple(args,"OOO",&owner,&name,&capsule)) return NULL;
    AttrCache *cache=as_cache(capsule);if (!cache) return NULL;
    return rc_structure_load_attr(owner,name,cache);
}
static PyObject *store(PyObject *self,PyObject *args) {
    PyObject *owner,*name,*value,*capsule;
    if (!PyArg_ParseTuple(args,"OOOO",&owner,&name,&value,&capsule)) return NULL;
    AttrCache *cache=as_cache(capsule);if (!cache) return NULL;
    if (rc_structure_store_attr(owner,name,value,cache)<0) return NULL;
    Py_RETURN_NONE;
}
static PyObject *address(PyObject *self,PyObject *capsule) {
    AttrCache *cache=as_cache(capsule);if (!cache) return NULL;
    return PyLong_FromVoidPtr(cache);
}
static PyObject *hits(PyObject *self,PyObject *capsule) {
    AttrCache *cache=as_cache(capsule);if (!cache) return NULL;
    return PyLong_FromUnsignedLongLong(cache->hits);
}
#if defined(_WIN64) && !defined(Py_STATS) && !defined(Py_REF_DEBUG)
#define RC_INLINE_NEWREF 1
#define RC_NEWREF_IMMORTAL _Py_IMMORTAL_INITIAL_REFCNT
#else
#define RC_INLINE_NEWREF 0
#define RC_NEWREF_IMMORTAL 0
#endif
/* Header-derived layout for the shared LLVM fast path. No copied offsets. */
static PyObject *inline_layout(PyObject *self,PyObject *unused) {
    return Py_BuildValue("{s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n,s:n}",
        "pointer_size",(Py_ssize_t)sizeof(void *),
        "managed_dict",(Py_ssize_t)MANAGED_DICT_OFFSET,
        "object_type",(Py_ssize_t)offsetof(PyObject,ob_type),
        "type_version",(Py_ssize_t)offsetof(PyTypeObject,tp_version_tag),
        "type_basicsize",(Py_ssize_t)offsetof(PyTypeObject,tp_basicsize),
        "cache_name",(Py_ssize_t)offsetof(AttrCache,name),
        "cache_version",(Py_ssize_t)offsetof(AttrCache,version),
        "cache_index",(Py_ssize_t)offsetof(AttrCache,index),
        "values_valid",(Py_ssize_t)offsetof(PyDictValues,valid),
        "values_capacity",(Py_ssize_t)offsetof(PyDictValues,capacity),
        "values_items",(Py_ssize_t)offsetof(PyDictValues,values),
        "inline_newref",(Py_ssize_t)RC_INLINE_NEWREF,
        "newref_offset",(Py_ssize_t)offsetof(PyObject,ob_refcnt),
        "newref_size",(Py_ssize_t)sizeof(((PyObject*)0)->ob_refcnt),
        "newref_immortal",(Py_ssize_t)RC_NEWREF_IMMORTAL);
}
static PyObject *is_immortal(PyObject *self,PyObject *value) {
    return PyBool_FromLong(_Py_IsImmortal(value));
}
static PyMethodDef methods[]={
    {"new_identity_cache",new_identity_cache,METH_NOARGS,NULL},
    {"identity_cache_address",identity_cache_address,METH_O,NULL},
    {"identity_cache_state",identity_cache_state,METH_O,NULL},
    {"is_immortal",is_immortal,METH_O,NULL},
    {"inline_layout",inline_layout,METH_NOARGS,NULL},
    {"new_cache",new_cache,METH_NOARGS,NULL},{"load",load,METH_VARARGS,NULL},
    {"store",store,METH_VARARGS,NULL},{"address",address,METH_O,NULL},{"hits",hits,METH_O,NULL},
    {NULL,NULL,0,NULL}
};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_structure_ops_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__structure_ops_native(void) {
    if (Py_Version!=PY_VERSION_HEX) {PyErr_SetString(PyExc_ImportError,"structure cache ABI mismatch");return NULL;}
    PyObject *list=PyList_New(0),*set=PySet_New(NULL),*dict=PyDict_New();
    if (!list || !set || !dict) {Py_XDECREF(list);Py_XDECREF(set);Py_XDECREF(dict);return NULL;}
    PyObject *append=PyObject_GetAttrString(list,"append"),*add=PyObject_GetAttrString(set,"add"),*get=PyObject_GetAttrString(dict,"get");
    if (append && add && get) {
        append_function=PyCFunction_GET_FUNCTION(append);
        add_function=PyCFunction_GET_FUNCTION(add);
        get_function=PyCFunction_GET_FUNCTION(get);
        append_flags=PyCFunction_GET_FLAGS(append);
        add_flags=PyCFunction_GET_FLAGS(add);
        get_flags=PyCFunction_GET_FLAGS(get);
    }
    Py_XDECREF(append);Py_XDECREF(add);Py_XDECREF(get);Py_DECREF(list);Py_DECREF(set);Py_DECREF(dict);
    if (!append_function || !add_function || !get_function) return NULL;
    return PyModule_Create(&module);
}
