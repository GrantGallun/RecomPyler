/* Private S56 prototype: one aggregate argument and one borrowed owner. */
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <structmember.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "_guards.h"
#define Py_BUILD_CORE
#include "internal/pycore_dict.h"
#undef Py_BUILD_CORE
#define SLOTS 64
typedef struct {
    PyObject_HEAD
    PyObject *fn,*code,*checks,*maths,*args,*schema;
    int64_t ints[SLOTS]; double floats[SLOTS];
    PyObject *root; Py_buffer view; void *undo;
    Py_ssize_t size; int kind,locked,exported,active,committed,image_ready;
    unsigned char flag;
    int opened,closed,entries,commits,rollbacks,failed;
} FlatCall;
static PyTypeObject FlatCallType;
static PyTypeObject *array_type;
static PyObject *EntryDecline;
static void rc_flat_close(void *p) {
    FlatCall *c=p;
    if (!c || !c->active) return;
    if (!c->committed && c->exported && c->image_ready) {
        if (c->view.len) memcpy(c->view.buf,c->undo,(size_t)c->view.len);
        c->rollbacks++;
    }
    /* Exact array exporter release cannot invoke Python. No owning ref is
       destroyed under the mutex: args retain root, view adds one reference. */
    if (c->exported) {PyBuffer_Release(&c->view);c->exported=0;}
    if (c->locked) {guard_end();c->locked=0;}
    free(c->undo);c->undo=NULL;c->active=0;c->closed++;
}
/* No dictionary materialisation or application lookup protocol. The bounded
   field-only adapter accepts managed ordinary instances; methods/slots decline. */
static int name_equal(PyObject *key,const char *name) {
    if (!PyUnicode_CheckExact(key)) return 0;
    Py_ssize_t n=(Py_ssize_t)strlen(name);
    if (PyUnicode_GET_LENGTH(key)!=n) return 0;
    int kind=PyUnicode_KIND(key);void *data=PyUnicode_DATA(key);
    for (Py_ssize_t i=0;i<n;i++)
        if (PyUnicode_READ(kind,data,i)!=(unsigned char)name[i]) return 0;
    return 1;
}
static int dict_field(PyObject *dict,const char *name,PyObject **answer) {
    if (!dict || !PyDict_CheckExact(dict) || PyDict_GET_SIZE(dict)>64) return 0;
    Py_ssize_t at=0;PyObject *key,*value;*answer=NULL;
    while (PyDict_Next(dict,&at,&key,&value)) {
        if (!PyUnicode_CheckExact(key)) return 0;
        if (name_equal(key,name)) *answer=value;
    }
    return 1;
}
static PyObject *member_field(PyObject *obj,const char *name) {
    /* Selector and decode precede guard_begin: reject a different runtime before
       touching its private managed/inline-instance layout. */
    if (Py_Version!=PY_VERSION_HEX || strcmp(Py_GetVersion(),RECOMPYLER_GUARD_BUILD_SIGNATURE)) return NULL;
    PyTypeObject *tp=Py_TYPE(obj);
    if (Py_TYPE(tp)!=&PyType_Type || !(tp->tp_flags&Py_TPFLAGS_HEAPTYPE) ||
        !(tp->tp_flags&Py_TPFLAGS_MANAGED_DICT) || tp->tp_getattro!=PyObject_GenericGetAttr ||
        !tp->tp_mro || !PyTuple_CheckExact(tp->tp_mro) || PyTuple_GET_SIZE(tp->tp_mro)>8) return NULL;
    /* Match GenericGetAttr data-descriptor precedence, without invoking it. */
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(tp->tp_mro);i++) {
        PyObject *base=PyTuple_GET_ITEM(tp->tp_mro,i),*descriptor;
        if (!PyType_Check(base) || !dict_field(guard_type_dict((PyTypeObject *)base),name,&descriptor)) return NULL;
        if (descriptor) {
            if (Py_TYPE(descriptor)->tp_descr_get && Py_TYPE(descriptor)->tp_descr_set) return NULL;
            break;
        }
    }
    PyDictObject *dict=_PyObject_GetManagedDict(obj);
    if (dict) {
        PyObject *value;
        return dict_field((PyObject *)dict,name,&value)?value:NULL;
    }
    if (!(tp->tp_flags&Py_TPFLAGS_INLINE_VALUES)) return NULL;
    PyDictValues *values=_PyObject_InlineValues(obj);
    PyDictKeysObject *keys=((PyHeapTypeObject *)tp)->ht_cached_keys;
    if (!values->valid || !keys || keys->dk_kind!=DICT_KEYS_SPLIT || keys->dk_nentries>64 ||
        keys->dk_nentries>values->capacity) return NULL;
    PyDictUnicodeEntry *entries=DK_UNICODE_ENTRIES(keys);PyObject *answer=NULL;
    for (Py_ssize_t i=0;i<keys->dk_nentries;i++) {
        PyObject *key=entries[i].me_key;
        if (!key || !PyUnicode_CheckExact(key)) return NULL;
        if (name_equal(key,name)) answer=values->values[i];
    }
    return answer;
}
static int field_name(const char **spec,char name[33]) {
    int n=0;
    while (**spec && **spec!=':') {
        unsigned char ch=(unsigned char)*(*spec)++;
        if (n>=32 || !((ch>='a'&&ch<='z') || (ch>='A'&&ch<='Z') || ch=='_' || (n && ch>='0'&&ch<='9'))) return 0;
        name[n++]=(char)ch;
    }
    if (!n || **spec!=':') return 0;
    (*spec)++;name[n]=0;return 1;
}
static int decode(FlatCall *c, PyObject *obj, const char **spec, int *slot, int depth) {
    if (depth>16 || *slot>=SLOTS) return 0;
    char ch=*(*spec)++;
    if (ch=='(') {
        if (!PyTuple_CheckExact(obj)) return 0;
        Py_ssize_t n=0;
        while (**spec && **spec!=')') {
            if (n>=PyTuple_GET_SIZE(obj) || !decode(c,PyTuple_GET_ITEM(obj,n++),spec,slot,depth+1)) return 0;
        }
        if (**spec!=')' || n!=PyTuple_GET_SIZE(obj)) return 0;
        (*spec)++;return 1;
    }
    if (ch=='{') {
        int fields=0;
        while (**spec && **spec!='}') {
            char name[33];
            if (++fields>8 || !field_name(spec,name)) return 0;
            PyObject *value=member_field(obj,name);
            if (!value || !(**spec=='i' || **spec=='f' || **spec=='b' || **spec=='n' || **spec=='D' || **spec=='B') ||
                !decode(c,value,spec,slot,depth+1) || **spec!=';') return 0;
            (*spec)++;
        }
        if (!fields || **spec!='}') return 0;
        (*spec)++;return 1;
    }
    int at=(*slot)++;
    if (ch=='n') return obj==Py_None;
    if (ch=='b') {if (!PyBool_Check(obj)) return 0;c->ints[at]=obj==Py_True;return 1;}
    if (ch=='i') {
        if (!PyLong_CheckExact(obj)) return 0;
        int overflow=0;long long v=PyLong_AsLongLongAndOverflow(obj,&overflow);
        if (overflow || PyErr_Occurred()) return 0;
        c->ints[at]=(int64_t)v;return 1;
    }
    if (ch=='f') {if (!PyFloat_CheckExact(obj)) return 0;c->floats[at]=PyFloat_AS_DOUBLE(obj);return 1;}
    if (ch=='I' || ch=='F' || ch=='D' || ch=='B') {
        if (c->root) return 0;
        if (ch=='D' || ch=='B') {if (Py_TYPE(obj)!=array_type) return 0;c->kind=3;}
        else {if (!PyList_CheckExact(obj)) return 0;c->kind=ch=='I'?1:2;}
        c->root=obj;return 1;
    }
    return 0;
}
static void *rc_flat_open(PyObject *obj) {
    if (Py_TYPE(obj)!=&FlatCallType) {PyErr_SetString(PyExc_TypeError,"flat holder required");return NULL;}
    FlatCall *c=(FlatCall *)obj;
    if (c->opened || c->active) {PyErr_SetString(PyExc_RuntimeError,"flat holder already consumed");return NULL;}
    c->opened++;c->active=1;c->root=NULL;c->flag=0;
    /* Decode exact inert metadata first. No borrowed storage yet. */
    const char *spec=PyBytes_AS_STRING(c->schema);int slot=0;
    if (!decode(c,c->args,&spec,&slot,0) || *spec || !c->root) goto fail;
    if (c->kind==3) {
        /* Export acquisition on the exact built-in array has no user hook.
           Allocate raw undo before the audited interval, then recheck bindings. */
        if (PyObject_GetBuffer(c->root,&c->view,PyBUF_FULL)!=0) goto fail;
        c->exported=1;
        if (c->view.readonly || c->view.ndim!=1 || c->view.itemsize!=8 ||
            !c->view.format || strcmp(c->view.format,"d") ||
            c->view.len<0 || c->view.len%8 || !PyBuffer_IsContiguous(&c->view,'C') ||
            (c->view.len && ((uintptr_t)c->view.buf%sizeof(double)))) goto fail;
        c->size=c->view.len/8;
        c->undo=malloc(c->view.len ? (size_t)c->view.len : 1);
        if (!c->undo) goto fail;
    } else c->size=PyList_GET_SIZE(c->root);
    if (!guard_begin()) goto fail;
    c->locked=1;
    if (PyFunction_GET_CODE(c->fn)!=c->code) goto fail;
    PyObject *argv[2]={c->checks,c->maths};
    PyObject *ok=check_lift_guards_scan(NULL,argv,2);
    int good=ok==Py_True;Py_XDECREF(ok);
    if (!good) goto fail;
    if (c->kind==3) {if (c->view.len) memcpy(c->undo,c->view.buf,(size_t)c->view.len);c->image_ready=1;}
    return c;
fail:
    c->failed=1;rc_flat_close(c);
    if (!PyErr_Occurred()) PyErr_SetString(EntryDecline,"flat entry declined");
    return NULL;
}
static int64_t rc_flat_i(void *p,int64_t slot) {return ((FlatCall *)p)->ints[slot];}
static double rc_flat_f(void *p,int64_t slot) {return ((FlatCall *)p)->floats[slot];}
static int64_t rc_flat_size(void *p) {return ((FlatCall *)p)->size;}
static void *rc_flat_data(void *p) {FlatCall *c=p;return c->kind==3?c->view.buf:NULL;}
static void *rc_flat_flag(void *p) {return &((FlatCall *)p)->flag;}
static void rc_flat_fail(void *p) {FlatCall *c=p;c->flag=1;c->failed=1;}
static void rc_flat_enter(void *p) {((FlatCall *)p)->entries++;}
static void rc_flat_commit(void *p) {
    FlatCall *c=p;if (!c->flag && !c->failed) {c->committed=1;c->commits++;}
}
static PyObject *item(FlatCall *c,int64_t index) {
    /* Header access only after exact open. Signed/unsigned callers are bounded
       here even if a checked-source extent proof removed its ordinary guard. */
    if (c->kind==3 || PyList_GET_SIZE(c->root)!=c->size || index<0 || index>=c->size) goto bad;
    return PyList_GET_ITEM(c->root,(Py_ssize_t)index);
bad:c->flag=1;c->failed=1;return NULL;
}
static int64_t rc_flat_read_i(void *p,int64_t index) {
    FlatCall *c=p;PyObject *v=item(c,index);
    if (v && PyLong_CheckExact(v)) {
        int overflow=0;long long n=PyLong_AsLongLongAndOverflow(v,&overflow);
        if (!overflow && !PyErr_Occurred()) return (int64_t)n;
    }
    c->flag=1;c->failed=1;return 0;
}
static double rc_flat_read_f(void *p,int64_t index) {
    FlatCall *c=p;
    if (c->kind==3) {
        if (index>=0 && index<c->size) return ((double *)c->view.buf)[index];
        c->flag=1;c->failed=1;return 0.0;
    }
    PyObject *v=item(c,index);
    if (v && PyFloat_CheckExact(v)) return PyFloat_AS_DOUBLE(v);
    c->flag=1;c->failed=1;return 0.0;
}
static void rc_flat_write_f(void *p,int64_t index,double value) {
    FlatCall *c=p;
    if (c->kind!=3 || index<0 || index>=c->size) {c->flag=1;c->failed=1;return;}
    ((double *)c->view.buf)[index]=value;
}
static int call_traverse(FlatCall *c,visitproc visit,void *arg) {
    Py_VISIT(c->fn);Py_VISIT(c->code);Py_VISIT(c->checks);Py_VISIT(c->maths);Py_VISIT(c->args);Py_VISIT(c->schema);return 0;
}
static int call_clear(FlatCall *c) {
    rc_flat_close(c);Py_CLEAR(c->fn);Py_CLEAR(c->code);Py_CLEAR(c->checks);Py_CLEAR(c->maths);Py_CLEAR(c->args);Py_CLEAR(c->schema);return 0;
}
static void call_dealloc(FlatCall *c) {PyObject_GC_UnTrack(c);call_clear(c);Py_TYPE(c)->tp_free((PyObject *)c);}
static PyObject *make_call(PyObject *self,PyObject *args) {
    PyObject *fn,*code,*checks,*maths,*values,*schema;
    if (!PyArg_ParseTuple(args,"OOOOOO",&fn,&code,&checks,&maths,&values,&schema)) return NULL;
    if (Py_TYPE(fn)!=&PyFunction_Type || !PyCode_Check(code) || !PyTuple_CheckExact(values) || !PyBytes_CheckExact(schema)) {
        PyErr_SetString(PyExc_TypeError,"invalid flat metadata");return NULL;
    }
    FlatCall *c=PyObject_GC_New(FlatCall,&FlatCallType);if (!c) return NULL;
    memset((char *)c+sizeof(PyObject),0,sizeof(*c)-sizeof(PyObject));
    c->fn=Py_NewRef(fn);c->code=Py_NewRef(code);c->checks=Py_NewRef(checks);c->maths=Py_NewRef(maths);c->args=Py_NewRef(values);c->schema=Py_NewRef(schema);
    PyObject_GC_Track(c);return (PyObject *)c;
}
static PyObject *audit(PyObject *self,PyObject *obj) {
    if (Py_TYPE(obj)!=&FlatCallType) {PyErr_SetString(PyExc_TypeError,"flat holder required");return NULL;}
    FlatCall *c=(FlatCall *)obj;
    return Py_BuildValue("{s:i,s:i,s:i,s:i,s:i,s:i,s:i,s:i}","open",c->opened,"close",c->closed,"native_entries",c->entries,"commits",c->commits,"rollbacks",c->rollbacks,"active",c->active,"failed",c->failed,"flag",c->flag);
}
/* Entry selection only: never walk numeric list payloads, call user protocols,
   or hold a borrowed export after returning to Python. Final open revalidates. */
typedef struct {char text[512];Py_ssize_t used;int owners,objects;PyObject *fields;} ShapeScan;
static int shape_put(ShapeScan *s,char ch) {
    if (s->used>=(Py_ssize_t)sizeof(s->text)) return 0;
    s->text[s->used++]=ch;return 1;
}
static int shape_walk(ShapeScan *s,PyObject *v,int depth) {
    if (depth>16) return 0;
    if (PyTuple_CheckExact(v)) {
        if (!shape_put(s,'(')) return 0;
        for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(v);i++) {
            int answer=shape_walk(s,PyTuple_GET_ITEM(v,i),depth+1);
            if (answer<=0) return answer;
        }
        return shape_put(s,')');
    }
    if (PyList_CheckExact(v)) {
        if (++s->owners>1) return 0;
        if (!PyList_GET_SIZE(v) || PyFloat_CheckExact(PyList_GET_ITEM(v,0))) return shape_put(s,'F');
        if (PyLong_CheckExact(PyList_GET_ITEM(v,0))) return shape_put(s,'I');
        return 0;
    }
    if (Py_TYPE(v)==array_type) {
        if (++s->owners>1) return 0;
        Py_buffer view;
        if (PyObject_GetBuffer(v,&view,PyBUF_FORMAT)!=0) return -1;
        int good=view.itemsize==8 && view.format && strcmp(view.format,"d")==0;
        PyBuffer_Release(&view);
        return good ? shape_put(s,'D') : 0;
    }
    if (v==Py_None) return shape_put(s,'n');
    if (PyBool_Check(v)) return shape_put(s,'b');
    if (PyFloat_CheckExact(v)) return shape_put(s,'f');
    if (PyLong_CheckExact(v)) {
        int overflow=0;PyLong_AsLongLongAndOverflow(v,&overflow);
        if (PyErr_Occurred()) return -1;
        return overflow ? 0 : shape_put(s,'i');
    }
    if (s->fields) {
        if (++s->objects>1 || !shape_put(s,'{')) return 0;
        for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(s->fields);i++) {
            PyObject *key=PyTuple_GET_ITEM(s->fields,i);
            const char *name=PyUnicode_AsUTF8(key);
            if (!name) return -1;
            PyObject *field=member_field(v,name);
            if (!field || !(PyLong_CheckExact(field) || PyFloat_CheckExact(field) ||
                PyBool_Check(field) || field==Py_None || Py_TYPE(field)==array_type)) return 0;
            for (const char *p=name;*p;p++) if (!shape_put(s,*p)) return 0;
            if (!shape_put(s,':')) return 0;
            int answer=shape_walk(s,field,depth+1);
            if (answer<=0) return answer;
            if (Py_TYPE(field)==array_type) s->text[s->used-1]='B';
            if (!shape_put(s,';')) return 0;
        }
        return shape_put(s,'}');
    }
    return 0;
}
static PyObject *shape(PyObject *self,PyObject *args) {
    if (!PyTuple_CheckExact(args)) Py_RETURN_NONE;
    ShapeScan scan={0};int ok=shape_walk(&scan,args,0);
    if (ok<0 || PyErr_Occurred()) return NULL;
    if (!ok || scan.owners!=1) Py_RETURN_NONE;
    return PyBytes_FromStringAndSize(scan.text,scan.used);
}
static PyObject *member_shape(PyObject *self,PyObject *args) {
    PyObject *values,*fields;
    if (!PyArg_ParseTuple(args,"OO",&values,&fields)) return NULL;
    if (!PyTuple_CheckExact(values) || !PyTuple_CheckExact(fields) ||
        !PyTuple_GET_SIZE(fields) || PyTuple_GET_SIZE(fields)>8) Py_RETURN_NONE;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(fields);i++) {
        PyObject *key=PyTuple_GET_ITEM(fields,i);
        if (!PyUnicode_CheckExact(key) || !PyUnicode_IS_ASCII(key)) Py_RETURN_NONE;
        const char *p=PyUnicode_AsUTF8(key);char name[33];
        if (!p) return NULL;
        Py_ssize_t length=PyUnicode_GET_LENGTH(key);
        if (length<1 || length>32) Py_RETURN_NONE;
        /* Reuse the schema identifier validator on a bounded local copy. */
        char spec[35];memcpy(spec,p,(size_t)length);spec[length]=':';spec[length+1]=0;
        const char *at=spec;if (!field_name(&at,name)) Py_RETURN_NONE;
    }
    ShapeScan scan={0};scan.fields=fields;
    int ok=shape_walk(&scan,values,0);
    if (ok<0 || PyErr_Occurred()) return NULL;
    if (!ok || scan.owners!=1 || scan.objects!=1) Py_RETURN_NONE;
    return PyBytes_FromStringAndSize(scan.text,scan.used);
}
static PyObject *addresses(PyObject *self,PyObject *unused) {
    PyObject *d=PyDict_New();if (!d) return NULL;
#define ADD(name) {PyObject *v=PyLong_FromVoidPtr((void *)&name);if (!v || PyDict_SetItemString(d,#name,v)<0) {Py_XDECREF(v);Py_DECREF(d);return NULL;}Py_DECREF(v);}
    ADD(rc_flat_open);ADD(rc_flat_close);ADD(rc_flat_i);ADD(rc_flat_f);ADD(rc_flat_size);ADD(rc_flat_data);ADD(rc_flat_flag);ADD(rc_flat_enter);ADD(rc_flat_commit);ADD(rc_flat_fail);ADD(rc_flat_read_i);ADD(rc_flat_read_f);ADD(rc_flat_write_f);
#undef ADD
    return d;
}
static PyMemberDef call_members[]={{"schema",Py_T_OBJECT_EX,offsetof(FlatCall,schema),Py_READONLY,NULL},{NULL,0,0,0,NULL}};
static PyTypeObject FlatCallType={PyVarObject_HEAD_INIT(NULL,0)
    .tp_name="recompyler._flat_native.Call",.tp_basicsize=sizeof(FlatCall),
    .tp_members=call_members,.tp_flags=Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC,.tp_traverse=(traverseproc)call_traverse,.tp_clear=(inquiry)call_clear,.tp_dealloc=(destructor)call_dealloc};
static PyMethodDef methods[]={{"_register_passive_attribute_audit",register_passive_audit,METH_O,NULL},{"make_call",make_call,METH_VARARGS,NULL},{"audit",audit,METH_O,NULL},{"shape",shape,METH_O,NULL},{"member_shape",member_shape,METH_VARARGS,NULL},{"addresses",addresses,METH_NOARGS,NULL},{NULL,NULL,0,NULL}};
static struct PyModuleDef mod={PyModuleDef_HEAD_INIT,"_flat_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__flat_native(void) {
    if (!GUARD_AUDIT_CAPABILITY || PyType_Ready(&FlatCallType)<0 || PyType_Ready(&GuardAttributeType)<0) return NULL;
    PyObject *a=PyImport_ImportModule("array");if (!a) return NULL;
    PyObject *t=PyObject_GetAttrString(a,"array");Py_DECREF(a);if (!t) return NULL;
    if (!PyType_Check(t) || Py_TYPE(t)!=&PyType_Type ||
        !(((PyTypeObject *)t)->tp_flags&Py_TPFLAGS_IMMUTABLETYPE) ||
        strcmp(((PyTypeObject *)t)->tp_name,"array.array") ||
        !((PyTypeObject *)t)->tp_as_buffer || !((PyTypeObject *)t)->tp_as_buffer->bf_getbuffer ||
        !((PyTypeObject *)t)->tp_as_buffer->bf_releasebuffer) {
        Py_DECREF(t);PyErr_SetString(PyExc_ImportError,"flat requires the built-in immutable array.array type");return NULL;
    }
    array_type=(PyTypeObject *)t;
    PyObject *m=PyModule_Create(&mod);if (!m) return NULL;
    /* If entry installation preceded this optional provider, register its
       already-existing trusted capability without importing compiler modules. */
    PyObject *name=PyUnicode_FromString("recompyler.ir._entry_native");
    PyObject *entry=name?PyImport_GetModule(name):NULL;Py_XDECREF(name);
    if(!entry && PyErr_Occurred()){Py_DECREF(m);return NULL;}
    if(entry) {
        PyObject *method=PyModule_CheckExact(entry)?
            PyDict_GetItemString(PyModule_GetDict(entry),"_register_passive_guard_provider"):NULL;
        if(method && Py_IS_TYPE(method,&PyCFunction_Type) &&
           PyCFunction_GET_SELF(method)==entry && PyCFunction_GET_FLAGS(method)==METH_O &&
           !strcmp(((PyCFunctionObject *)method)->m_ml->ml_name,"_register_passive_guard_provider")) {
            PyObject *accepted=PyObject_CallOneArg(method,m);
            if(!accepted){Py_DECREF(entry);Py_DECREF(m);return NULL;}
            Py_DECREF(accepted);
        }
        Py_DECREF(entry);
    }
    EntryDecline=PyErr_NewException("recompyler._flat_native.EntryDecline",NULL,NULL);
    if (!EntryDecline || PyModule_AddObjectRef(m,"EntryDecline",EntryDecline)<0) {Py_DECREF(m);return NULL;}
    if (PyModule_AddObjectRef(m,"Call",(PyObject *)&FlatCallType)<0 || PyModule_AddObjectRef(m,"GuardAttribute",(PyObject *)&GuardAttributeType)<0 ||
        PyModule_AddStringConstant(m,"BUILD_SIGNATURE",RECOMPYLER_GUARD_BUILD_SIGNATURE)<0 || PyModule_AddIntConstant(m,"API_VERSION",1)<0) {Py_DECREF(m);return NULL;}
    return m;
}
