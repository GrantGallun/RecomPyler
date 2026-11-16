/* Adapted from CinderX Common/watchers.cpp and Jit/global_cache.cpp @ f3dc0e8.
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
#include <stdint.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG)
#error Watchers require release GIL-enabled CPython 3.14.4
#endif

#include "entry_invalidator.h"
#define INVALIDATOR_NAME RC_ENTRY_INVALIDATOR_CAPSULE
typedef struct Subscription Subscription;
struct Subscription {
    PyObject_HEAD
    PyObject *dicts, *types, *entry, *api_capsule, *callback;
    RcEntryInvalidator *api;
    Subscription *next;
    int valid, linked;
};
static Subscription *subscriptions = NULL; /* Non-owning, GIL protected. */
static int dict_watcher = -1, type_watcher = -1;

static int contains(PyObject *tuple, PyObject *object) {
    if (!tuple) return 0;
    for (Py_ssize_t i=0; i<PyTuple_GET_SIZE(tuple); i++)
        if (PyTuple_GET_ITEM(tuple,i)==object) return 1;
    return 0;
}
static void invalidate(Subscription *s) {
    if (!s->valid) return;
    s->valid=0;
    if (s->entry) {
        PyObject *entry=PyWeakref_GET_OBJECT(s->entry);
        if(entry!=Py_None)s->api->invalidate(entry);
    }
}
typedef struct {PyObject_HEAD Subscription *subscription;} WeakCallback;
static PyObject *weak_callback_call(PyObject *object,PyObject *args,PyObject *kwargs) {
    WeakCallback *self=(WeakCallback*)object;
    if(self->subscription)invalidate(self->subscription);
    Py_RETURN_NONE;
}
static PyTypeObject WeakCallbackType={
    PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler.ir._WatchDeathCallback",.tp_basicsize=sizeof(WeakCallback),
    .tp_flags=Py_TPFLAGS_DEFAULT,.tp_call=weak_callback_call
};
static int contains_type(PyObject *refs,PyObject *object) {
    if(!refs)return 0;
    for(Py_ssize_t i=0;i<PyTuple_GET_SIZE(refs);i++) {
        PyObject *ref=PyTuple_GET_ITEM(refs,i);
        if(ref && PyWeakref_GET_OBJECT(ref)==object)return 1;
    }
    return 0;
}
static int dict_changed(PyDict_WatchEvent event, PyObject *dict,
                        PyObject *key, PyObject *value) {
    for (Subscription *s=subscriptions; s; s=s->next)
        if (contains(s->dicts,dict)) invalidate(s);
    return 0;
}
static int type_changed(PyTypeObject *type) {
    for (Subscription *s=subscriptions; s; s=s->next)
        if (contains_type(s->types,(PyObject*)type)) invalidate(s);
    return 0;
}
static int used_elsewhere(PyObject *object, int is_type) {
    for (Subscription *s=subscriptions; s; s=s->next)
        if (is_type?contains_type(s->types,object):contains(s->dicts,object)) return 1;
    return 0;
}
static int clear(Subscription *s) {
    PyObject *pending=PyErr_GetRaisedException();
    invalidate(s);
    if (s->linked) {
        Subscription **link=&subscriptions;
        while (*link && *link!=s) link=&(*link)->next;
        if (*link) *link=s->next;
        s->linked=0; s->next=NULL;
        for (int kind=0;kind<2;kind++) {
            PyObject *tuple=kind?s->types:s->dicts;
            if (!tuple) continue;
            for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(tuple);i++) {
                PyObject *object=PyTuple_GET_ITEM(tuple,i);
                if(kind) {object=PyWeakref_GET_OBJECT(object);if(object==Py_None)continue;}
                /* Duplicate input dependencies are unwatched only once. */
                int duplicate=0;
                for (Py_ssize_t j=0;j<i;j++)
                    if ((kind?PyWeakref_GET_OBJECT(PyTuple_GET_ITEM(tuple,j)):PyTuple_GET_ITEM(tuple,j))==object) {duplicate=1;break;}
                if (!duplicate && !used_elsewhere(object,kind)) {
                    int result=kind?PyType_Unwatch(type_watcher,object)
                                   :PyDict_Unwatch(dict_watcher,object);
                    if (result<0) PyErr_Clear(); /* All objects were validated. */
                }
            }
        }
    }
    if(s->callback)((WeakCallback*)s->callback)->subscription=NULL;
    /* Unlink/unwatch before DECREF: destructors may mutate or resubscribe. */
    Py_CLEAR(s->dicts); Py_CLEAR(s->types);
    Py_CLEAR(s->entry); Py_CLEAR(s->api_capsule);Py_CLEAR(s->callback); s->api=NULL;
    if(pending)PyErr_SetRaisedException(pending);
    return 0;
}
static int traverse(Subscription *s,visitproc visit,void *arg) {
    Py_VISIT(s->dicts); Py_VISIT(s->types);
    Py_VISIT(s->entry); Py_VISIT(s->api_capsule);Py_VISIT(s->callback); return 0;
}
static void dealloc(Subscription *s) {
    PyObject_GC_UnTrack(s); clear(s); Py_TYPE(s)->tp_free((PyObject*)s);
}
static PyObject *close_subscription(Subscription *s,PyObject *ignored) {
    clear(s); Py_RETURN_NONE;
}
static PyObject *valid(Subscription *s,void *ignored) {return PyBool_FromLong(s->valid);}
static PyObject *bind_entry(Subscription *s,PyObject *args) {
    PyObject *entry,*capsule;
    if (!PyArg_ParseTuple(args,"OO:bind",&entry,&capsule)) return NULL;
    if (!s->valid || s->entry) {
        PyErr_SetString(PyExc_RuntimeError,"subscription is invalid or already bound");return NULL;
    }
    RcEntryInvalidator *api=PyCapsule_GetPointer(capsule,INVALIDATOR_NAME);
    if (!api) return NULL;
    if (api->version!=1 || !api->accepts || !api->invalidate) {
        PyErr_SetString(PyExc_ValueError,"incompatible entry invalidation API");return NULL;
    }
    if (!api->accepts(entry)) {
        PyErr_SetString(PyExc_TypeError,"native IR entry required");return NULL;
    }
    PyObject *ref=PyWeakref_NewRef(entry,s->callback);
    if(!ref)return NULL;
    s->api=api;s->entry=ref;s->api_capsule=Py_NewRef(capsule);
    Py_RETURN_NONE;
}
static PyMethodDef subscription_methods[]={
    {"bind",(PyCFunction)bind_entry,METH_VARARGS,NULL},
    {"close",(PyCFunction)close_subscription,METH_NOARGS,NULL},{NULL}};
static PyGetSetDef subscription_getsets[]={
    {"valid",(getter)valid,NULL,NULL,NULL},{NULL}};
static PyTypeObject SubscriptionType={
    PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler.ir.WatchSubscription",.tp_basicsize=sizeof(Subscription),
    .tp_flags=Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC,
    .tp_dealloc=(destructor)dealloc,.tp_traverse=(traverseproc)traverse,
    .tp_clear=(inquiry)clear,.tp_methods=subscription_methods,.tp_getset=subscription_getsets
};
static PyObject *watch(PyObject *module,PyObject *args) {
    PyObject *dicts,*types;
    if (!PyArg_ParseTuple(args,"O!O!:watch",&PyTuple_Type,&dicts,&PyTuple_Type,&types)) return NULL;
    if (PyInterpreterState_GetID(PyInterpreterState_Get())!=0) {
        PyErr_SetString(PyExc_RuntimeError,"watchers require the main interpreter");return NULL;
    }
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(dicts);i++)
        if (!PyDict_CheckExact(PyTuple_GET_ITEM(dicts,i))) {
            PyErr_SetString(PyExc_TypeError,"exact dict dependency required");return NULL;
        }
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(types);i++)
        if (!PyType_Check(PyTuple_GET_ITEM(types,i))) {
            PyErr_SetString(PyExc_TypeError,"type dependency required");return NULL;
        }
    if (dict_watcher<0) {dict_watcher=PyDict_AddWatcher(dict_changed);if(dict_watcher<0)return NULL;}
    if (type_watcher<0) {type_watcher=PyType_AddWatcher(type_changed);if(type_watcher<0)return NULL;}
    Subscription *s=PyObject_GC_New(Subscription,&SubscriptionType);
    if (!s) return NULL;
    s->dicts=Py_NewRef(dicts);s->types=NULL;s->entry=NULL;s->api_capsule=NULL;s->callback=NULL;s->api=NULL;s->valid=0;
    s->linked=0;s->next=NULL;
    PyObject_GC_Track(s);
    WeakCallback *token=PyObject_New(WeakCallback,&WeakCallbackType);
    if(!token){clear(s);Py_DECREF(s);return NULL;}
    token->subscription=s;s->callback=(PyObject*)token;
    PyObject *callback=s->callback;
    s->types=PyTuple_New(PyTuple_GET_SIZE(types));
    if(!s->types){clear(s);Py_DECREF(s);return NULL;}
    for(Py_ssize_t i=0;i<PyTuple_GET_SIZE(types);i++) {
        PyObject *ref=PyWeakref_NewRef(PyTuple_GET_ITEM(types,i),callback);
        if(!ref){clear(s);Py_DECREF(s);return NULL;}
        PyTuple_SET_ITEM(s->types,i,ref);
    }
    s->linked=1;s->next=subscriptions;subscriptions=s;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(dicts);i++)
        if (PyDict_Watch(dict_watcher,PyTuple_GET_ITEM(dicts,i))<0) {clear(s);Py_DECREF(s);return NULL;}
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(types);i++) {
        PyObject *type=PyTuple_GET_ITEM(types,i);
        /* Without a valid tag CPython may coalesce mutations without notifying. */
        if (!PyUnstable_Type_AssignVersionTag((PyTypeObject*)type)) {
            if (!PyErr_Occurred()) PyErr_SetString(PyExc_RuntimeError,"type has no watchable version tag");
            clear(s);Py_DECREF(s);return NULL;
        }
        if (PyType_Watch(type_watcher,type)<0) {clear(s);Py_DECREF(s);return NULL;}
    }
    s->valid=1;
    return (PyObject*)s;
}
static int check_valid(PyObject *object) {
    return Py_IS_TYPE(object,&SubscriptionType) && ((Subscription*)object)->valid;
}
static PyObject *addresses(PyObject *module,PyObject *unused) {
    return Py_BuildValue("{s:K}","valid",(unsigned long long)(uintptr_t)check_valid);
}
static PyMethodDef methods[]={{"watch",watch,METH_VARARGS,NULL},{"addresses",addresses,METH_NOARGS,NULL},{NULL}};
static PyModuleDef definition={PyModuleDef_HEAD_INIT,"_watchers_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__watchers_native(void) {
    if (PyType_Ready(&WeakCallbackType)<0 || PyType_Ready(&SubscriptionType)<0)return NULL;
    return PyModule_Create(&definition);
}
