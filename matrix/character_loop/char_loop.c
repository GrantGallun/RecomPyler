#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdint.h>
#include <string.h>
/* Diagnostic only: the complete default-POSIX shlex.read_token body, reached
   through workload.token(text). The fresh lexer is private; nondefault modes
   are not inputs to this wrapper. Boxed retains read/concat; borrowed scalar
   replaces private lexer/StringIO state and constructs one result. */
static PyObject *original, *original_code, *lexer, *class_dict, *bases;
static PyObject *functions[3], *codes[3], *defaults[3], *globals_dict, *builtins_dict;
static PyObject *keys[4], *bindings[4], *importfn, *collections_module, *deque_type, *gcmod, *callbacks, *messages[2];
static PyObject *spec, *spec_type, *spec_class_dict, *spec_bases;
static PyObject *boot_module, *boot_fn, *boot_code, *boot_defaults, *boot_kw, *boot_kw_copy;
static PyObject *boot_globals, *boot_builtins, *boot_keys[3], *boot_values[3];
static unsigned char words[256];
static unsigned long boxed_calls, borrowed_calls, fallback_calls;
static int inert(PyObject *d) {
    Py_ssize_t p=0; PyObject *k,*v;
    if (!PyDict_CheckExact(d)) return 0;
    while (PyDict_Next(d,&p,&k,&v)) if (!PyUnicode_CheckExact(k)) return 0;
    return 1;
}
static int same_dict(PyObject *a, PyObject *b) {
    Py_ssize_t p=0; PyObject *k,*v;
    if (!inert(a) || PyDict_Size(a)!=PyDict_Size(b)) return 0;
    while (PyDict_Next(b,&p,&k,&v)) if (PyDict_GetItemWithError(a,k)!=v) return 0;
    return 1;
}
static PyObject *resolve(PyObject *gd,PyObject *bd,PyObject *key) {
    PyObject *v=PyDict_GetItemWithError(gd,key);
    return v ? v : PyDict_GetItemWithError(bd,key);
}
static PyObject *construct(PyObject *text) {
    PyObject *args=PyTuple_Pack(1,text), *kw=NULL, *result=NULL;
    if (!args) return NULL;
    kw=PyDict_New();
    if (kw && PyDict_SetItemString(kw,"posix",Py_True)==0) result=PyObject_Call(lexer,args,kw);
    Py_XDECREF(kw); Py_DECREF(args); return result;
}
static int eligible(PyObject *text) {
    PyThreadState *thread=PyThreadState_Get();
    if (thread->c_tracefunc || thread->c_profilefunc) return 0;
    if (!original || !PyUnicode_CheckExact(text) || PyFunction_GetCode(original)!=original_code) return 0;
    PyObject *gd=PyFunction_GetGlobals(original);
    if (!inert(gd) || PyDict_GetItemString(gd,"LEXER")!=lexer) return 0;
    PyTypeObject *t=(PyTypeObject *)lexer;
    if (Py_TYPE(lexer)!=&PyType_Type || t->tp_bases!=bases ||
        t->tp_getattro!=PyObject_GenericGetAttr || t->tp_setattro!=PyObject_GenericSetAttr ||
        t->tp_new!=PyBaseObject_Type.tp_new || t->tp_finalize || !same_dict(t->tp_dict,class_dict)) return 0;
    for (int i=0;i<3;i++) if (PyFunction_GetCode(functions[i])!=codes[i] ||
                            PyFunction_GetDefaults(functions[i])!=defaults[i]) return 0;
    if (!inert(globals_dict) || !inert(builtins_dict)) return 0;
    for (int i=0;i<4;i++) if (resolve(globals_dict,builtins_dict,keys[i])!=bindings[i]) return 0;
    /* __init__ performs a deferred local import. Omit it only while the
       builtin importer sees the same cached exact module and immutable deque.
       String-key allowlists ensure even failed guard lookups invoke no user hash. */
    if (PyDict_GetItemString(builtins_dict,"__import__")!=importfn) return 0;
    PyObject *modules=PyImport_GetModuleDict();
    if (!inert(modules) || PyDict_GetItemString(modules,"collections")!=collections_module ||
        !PyModule_CheckExact(collections_module)) return 0;
    PyObject *cd=PyModule_GetDict(collections_module);
    if (!inert(cd) || PyDict_GetItemString(cd,"deque")!=deque_type ||
        PyDict_GetItemString(cd,"__spec__")!=spec || !PyDict_GetItemString(cd,"__path__")) return 0;
    PyTypeObject *st=(PyTypeObject *)spec_type;
    if ((PyObject *)Py_TYPE(spec)!=spec_type || Py_TYPE(spec_type)!=&PyType_Type ||
        st->tp_getattro!=PyObject_GenericGetAttr || st->tp_bases!=spec_bases ||
        !same_dict(st->tp_dict,spec_class_dict)) return 0;
    PyObject *sd=PyObject_GenericGetDict(spec,NULL);
    if (!sd) return -1;
    int ready=inert(sd) && PyDict_GetItemString(sd,"_initializing")==Py_False;
    Py_DECREF(sd); if (!ready) return 0;
    if (PyDict_GetItemString(modules,"_frozen_importlib")!=boot_module || !PyModule_CheckExact(boot_module)) return 0;
    PyObject *bd=PyModule_GetDict(boot_module);
    if (!inert(bd) || PyDict_GetItemString(bd,"_handle_fromlist")!=boot_fn ||
        PyFunction_GetCode(boot_fn)!=boot_code || PyFunction_GetDefaults(boot_fn)!=boot_defaults ||
        PyFunction_GET_KW_DEFAULTS(boot_fn)!=boot_kw || !same_dict(boot_kw,boot_kw_copy) ||
        !inert(boot_globals) || !inert(boot_builtins)) return 0;
    for (int i=0;i<3;i++) if (resolve(boot_globals,boot_builtins,boot_keys[i])!=boot_values[i]) return 0;
    if (!PyModule_CheckExact(gcmod)) return 0;
    PyObject *d=PyModule_GetDict(gcmod);
    if (!inert(d)) return 0;
    PyObject *current=PyDict_GetItemString(d,"callbacks");
    return current==callbacks && PyList_CheckExact(current) && PyList_GET_SIZE(current)==0;
}
static PyObject *delegate(PyObject *text) {
    fallback_calls++;
    if (!original) { PyErr_SetString(PyExc_RuntimeError,"not configured"); return NULL; }
    return PyObject_CallOneArg(original,text);
}
#define END ((Py_UCS4)0x110000)
typedef struct {
    int borrowed,kind; const void *data; Py_ssize_t at,n;
    PyObject *stream,*current;
} Reader;
static int next(Reader *r,Py_UCS4 *c) {
    if (r->borrowed) { *c=r->at<r->n ? PyUnicode_READ(r->kind,r->data,r->at++) : END; return 0; }
    PyObject *v=PyObject_CallMethod(r->stream,"read","i",1);
    if (!v) return -1;
    Py_XSETREF(r->current,v);
    Py_ssize_t n=PyUnicode_GetLength(v);
    if (n<0) return -1;
    if (n>1) { PyErr_SetString(PyExc_RuntimeError,"unexpected StringIO read size"); return -1; }
    *c=n ? PyUnicode_ReadChar(v,0) : END;
    return *c==(Py_UCS4)-1 && PyErr_Occurred() ? -1 : 0;
}
static int comment(Reader *r) {
    if (r->borrowed) {
        while (r->at<r->n) if (PyUnicode_READ(r->kind,r->data,r->at++)=='\n') break;
        return 0;
    }
    PyObject *line=PyObject_CallMethod(r->stream,"readline",NULL);
    if (!line) return -1;
    Py_DECREF(line); return 0;
}
typedef struct { int borrowed; PyObject *boxed; Py_UCS4 *data; Py_ssize_t used; } Token;
static int append(Token *t,Py_UCS4 c,PyObject *character) {
    if (t->borrowed) { t->data[t->used++]=c; return 0; }
    PyObject *part=character ? Py_NewRef(character) : PyUnicode_FromOrdinal((int)c),*v;
    if (!part) return -1;
    v=PyUnicode_Concat(t->boxed,part); Py_DECREF(part);
    if (!v) return -1;
    Py_SETREF(t->boxed,v); t->used++; return 0;
}
static int white(Py_UCS4 c) { return c==' ' || c=='\t' || c=='\r' || c=='\n'; }
static int quote(Py_UCS4 c) { return c=='\'' || c=='"'; }
static int word(Py_UCS4 c) { return c<256 && words[c]; }
static PyObject *run(PyObject *text,int borrowed) {
    int safe=eligible(text);
    if (safe<0) return NULL;
    if (!safe) return delegate(text);
    if (borrowed) borrowed_calls++; else boxed_calls++;
    Reader r={0}; Token token={0}; PyObject *obj=NULL,*result=NULL;
    r.borrowed=token.borrowed=borrowed;
    if (borrowed) {
        r.kind=PyUnicode_KIND(text); r.data=PyUnicode_DATA(text); r.n=PyUnicode_GET_LENGTH(text);
        if ((size_t)r.n>SIZE_MAX/sizeof(Py_UCS4)) { PyErr_NoMemory(); goto done; }
        token.data=PyMem_Malloc((r.n ? (size_t)r.n : 1)*sizeof(Py_UCS4));
        if (!token.data) { PyErr_NoMemory(); goto done; }
    } else {
        obj=construct(text); if (!obj) goto done;
        r.stream=PyObject_GetAttrString(obj,"instream"); if (!r.stream) goto done;
        token.boxed=PyUnicode_FromString(""); if (!token.boxed) goto done;
    }
    Py_UCS4 state=' ',escaped=' '; int quoted=0;
    for (;;) {
        Py_UCS4 c; if (next(&r,&c)<0) goto done;
        if (state==' ') {
            if (c==END) break;
            if (white(c)) { if (token.used || quoted) break; else continue; }
            if (c=='#') { if (comment(&r)<0) goto done; continue; }
            if (c=='\\') { escaped='a'; state=c; }
            else if (word(c)) { if (append(&token,c,r.current)<0) goto done; state='a'; }
            else if (quote(c)) state=c;
            else { if (append(&token,c,r.current)<0) goto done; break; }
        } else if (quote(state)) {
            quoted=1;
            if (c==END) { PyErr_SetObject(PyExc_ValueError,messages[0]); goto done; }
            if (c==state) state='a';
            else if (c=='\\' && state=='"') { escaped=state; state=c; }
            else if (append(&token,c,r.current)<0) goto done;
        } else if (state=='\\') {
            if (c==END) { PyErr_SetObject(PyExc_ValueError,messages[1]); goto done; }
            if (quote(escaped) && c!=state && c!=escaped) if (append(&token,state,NULL)<0) goto done;
            if (append(&token,c,r.current)<0) goto done;
            state=escaped;
        } else { /* word state; punctuation_chars is empty by constructor proof */
            if (c==END || white(c)) break;
            if (c=='#') { if (comment(&r)<0) goto done; break; }
            if (quote(c)) state=c;
            else if (c=='\\') { escaped='a'; state=c; }
            else if (word(c)) { if (append(&token,c,r.current)<0) goto done; }
            else break; /* the discarded private lexer would push this character */
        }
    }
    if (!quoted && !token.used) { result=Py_NewRef(Py_None); goto done; }
    if (borrowed) result=PyUnicode_FromKindAndData(PyUnicode_4BYTE_KIND,token.data,token.used);
    else result=Py_NewRef(token.boxed);
done:
    Py_XDECREF(token.boxed); PyMem_Free(token.data); Py_XDECREF(r.current);
    Py_XDECREF(r.stream); Py_XDECREF(obj); return result;
}
static PyObject *boxed(PyObject *self,PyObject *text) { return run(text,0); }
static PyObject *borrowed(PyObject *self,PyObject *text) { return run(text,1); }
static PyObject *stats(PyObject *self,PyObject *unused) { return Py_BuildValue("(kkk)",boxed_calls,borrowed_calls,fallback_calls); }
static PyObject *configure(PyObject *self,PyObject *fn) {
    if (original) { PyErr_SetString(PyExc_RuntimeError,"already configured"); return NULL; }
    if (!PyFunction_Check(fn)) { PyErr_SetString(PyExc_TypeError,"expected wrapper function"); return NULL; }
    original=Py_NewRef(fn); original_code=Py_NewRef(PyFunction_GetCode(fn));
    lexer=Py_XNewRef(PyDict_GetItemString(PyFunction_GetGlobals(fn),"LEXER"));
    if (!lexer || Py_TYPE(lexer)!=&PyType_Type) { PyErr_SetString(PyExc_TypeError,"expected exact lexer class"); return NULL; }
    PyTypeObject *t=(PyTypeObject *)lexer; class_dict=PyDict_Copy(t->tp_dict); bases=Py_NewRef(t->tp_bases);
    functions[0]=Py_XNewRef(PyDict_GetItemString(t->tp_dict,"__init__"));
    functions[1]=Py_XNewRef(PyDict_GetItemString(t->tp_dict,"read_token"));
    PyObject *property=PyDict_GetItemString(t->tp_dict,"punctuation_chars");
    functions[2]=property ? PyObject_GetAttrString(property,"fget") : NULL;
    for (int i=0;i<3;i++) {
        if (!functions[i] || !PyFunction_Check(functions[i])) { PyErr_SetString(PyExc_TypeError,"unexpected lexer implementation"); return NULL; }
        codes[i]=Py_NewRef(PyFunction_GetCode(functions[i]));
        defaults[i]=Py_XNewRef(PyFunction_GetDefaults(functions[i]));
    }
    globals_dict=PyFunction_GetGlobals(functions[0]); builtins_dict=PyObject_GetAttrString(functions[0],"__builtins__");
    const char *names[]={"isinstance","str","StringIO","ValueError"};
    for (int i=0;i<4;i++) {
        keys[i]=PyUnicode_InternFromString(names[i]);
        bindings[i]=keys[i] ? Py_XNewRef(resolve(globals_dict,builtins_dict,keys[i])) : NULL;
        if (!bindings[i]) { PyErr_SetString(PyExc_RuntimeError,"missing lexer binding"); return NULL; }
    }
    if (!builtins_dict || !inert(builtins_dict) || !inert(globals_dict)) {
        PyErr_SetString(PyExc_RuntimeError,"non-inert lexer context"); return NULL;
    }
    importfn=Py_XNewRef(PyDict_GetItemString(builtins_dict,"__import__"));
    collections_module=PyImport_ImportModule("collections");
    deque_type=collections_module && PyModule_CheckExact(collections_module) ?
        Py_XNewRef(PyDict_GetItemString(PyModule_GetDict(collections_module),"deque")) : NULL;
    if (!importfn || !PyCFunction_Check(importfn) || !deque_type || !PyType_Check(deque_type) ||
        !(((PyTypeObject *)deque_type)->tp_flags & Py_TPFLAGS_IMMUTABLETYPE) ||
        bindings[1]!=(PyObject *)&PyUnicode_Type || bindings[3]!=(PyObject *)PyExc_ValueError ||
        !PyType_Check(bindings[2]) || !(((PyTypeObject *)bindings[2])->tp_flags & Py_TPFLAGS_IMMUTABLETYPE)) {
        PyErr_SetString(PyExc_RuntimeError,"unexpected trusted stdlib context"); return NULL;
    }
    spec=Py_XNewRef(PyDict_GetItemString(PyModule_GetDict(collections_module),"__spec__"));
    if (!spec) { PyErr_SetString(PyExc_RuntimeError,"missing import spec"); return NULL; }
    spec_type=Py_NewRef((PyObject *)Py_TYPE(spec));
    PyTypeObject *st=(PyTypeObject *)spec_type;
    spec_class_dict=PyDict_Copy(st->tp_dict); spec_bases=Py_NewRef(st->tp_bases);
    if (!spec_class_dict || !PyTuple_CheckExact(spec_bases) || PyTuple_GET_SIZE(spec_bases)!=1 ||
        PyTuple_GET_ITEM(spec_bases,0)!=(PyObject *)&PyBaseObject_Type ||
        PyDict_GetItemString(st->tp_dict,"_initializing")) {
        PyErr_SetString(PyExc_RuntimeError,"unexpected import spec type"); return NULL;
    }
    boot_module=PyImport_ImportModule("_frozen_importlib");
    if (!boot_module || !PyModule_CheckExact(boot_module)) return NULL;
    boot_fn=Py_XNewRef(PyDict_GetItemString(PyModule_GetDict(boot_module),"_handle_fromlist"));
    if (!boot_fn || !PyFunction_Check(boot_fn)) { PyErr_SetString(PyExc_RuntimeError,"unexpected fromlist handler"); return NULL; }
    boot_code=Py_NewRef(PyFunction_GetCode(boot_fn)); boot_defaults=Py_XNewRef(PyFunction_GetDefaults(boot_fn));
    boot_kw=Py_XNewRef(PyFunction_GET_KW_DEFAULTS(boot_fn)); boot_kw_copy=boot_kw ? PyDict_Copy(boot_kw) : NULL;
    if (!boot_kw_copy) { PyErr_SetString(PyExc_RuntimeError,"unexpected fromlist defaults"); return NULL; }
    boot_globals=PyFunction_GetGlobals(boot_fn); boot_builtins=PyObject_GetAttrString(boot_fn,"__builtins__");
    const char *boot_names[]={"isinstance","str","hasattr"};
    if (!boot_builtins) return NULL;
    for (int i=0;i<3;i++) {
        boot_keys[i]=PyUnicode_InternFromString(boot_names[i]);
        boot_values[i]=boot_keys[i] ? Py_XNewRef(resolve(boot_globals,boot_builtins,boot_keys[i])) : NULL;
        if (!boot_values[i]) { PyErr_SetString(PyExc_RuntimeError,"missing fromlist binding"); return NULL; }
    }
    PyObject *constants=PyObject_GetAttrString(codes[1],"co_consts");
    if (!constants) return NULL;
    for (Py_ssize_t i=0;i<PyTuple_GET_SIZE(constants);i++) {
        PyObject *v=PyTuple_GET_ITEM(constants,i);
        if (PyUnicode_CheckExact(v)) {
            if (PyUnicode_CompareWithASCIIString(v,"No closing quotation")==0) messages[0]=Py_NewRef(v);
            if (PyUnicode_CompareWithASCIIString(v,"No escaped character")==0) messages[1]=Py_NewRef(v);
        }
    }
    Py_DECREF(constants);
    if (!messages[0] || !messages[1]) { PyErr_SetString(PyExc_RuntimeError,"missing lexer exception constants"); return NULL; }
    gcmod=PyImport_ImportModule("gc"); if (!gcmod) return NULL;
    callbacks=Py_XNewRef(PyDict_GetItemString(PyModule_GetDict(gcmod),"callbacks"));
    PyObject *empty=PyUnicode_FromString(""),*probe=empty ? construct(empty) : NULL; Py_XDECREF(empty);
    if (!probe) return NULL;
    PyObject *chars=PyObject_GetAttrString(probe,"wordchars"); Py_DECREF(probe);
    if (!chars) return NULL;
    for (Py_ssize_t i=0;i<PyUnicode_GET_LENGTH(chars);i++) {
        Py_UCS4 c=PyUnicode_ReadChar(chars,i);
        if (c>=256) { Py_DECREF(chars); PyErr_SetString(PyExc_RuntimeError,"unexpected default word alphabet"); return NULL; }
        words[c]=1;
    }
    Py_DECREF(chars); Py_RETURN_NONE;
}
static PyMethodDef methods[]={{"configure",configure,METH_O,NULL},{"boxed",boxed,METH_O,NULL},{"borrowed",borrowed,METH_O,NULL},{"stats",stats,METH_NOARGS,NULL},{NULL,NULL,0,NULL}};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"wave17_charloop",NULL,-1,methods};
PyMODINIT_FUNC PyInit_wave17_charloop(void) { return PyModule_Create(&module); }
