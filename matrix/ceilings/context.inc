/* Pure eligibility checks before any user callback. Frozen CPython 3.14 module
   context is part of this ceiling, not a universal base64 replacement. */
static PyObject *originals[3],*codes[4],*functions[4],*defaults[4],*kwdefaults[4],*kwcopies[4];
static PyObject *globals_dict,*builtin_dict,*struct_dict,*binascii_dict,*gc_dict;
struct binding { PyObject *dict,*key,*value; };
static struct binding bindings[64];static int nbindings;
static int inert_keys(PyObject *dict){
    if(!PyDict_CheckExact(dict))return 0;
    Py_ssize_t pos=0;PyObject *key,*value;
    while(PyDict_Next(dict,&pos,&key,&value))if(!PyUnicode_CheckExact(key))return 0;
    return 1;
}
static int bind_one(PyObject *dict,const char *name){
    struct binding *b=&bindings[nbindings++];b->dict=Py_NewRef(dict);b->key=PyUnicode_InternFromString(name);if(!b->key)return -1;
    b->value=Py_XNewRef(PyDict_GetItemWithError(dict,b->key));return PyErr_Occurred()?-1:0;
}
static int same_dict(PyObject *dict,PyObject *copy){
    if(dict==NULL||copy==NULL)return dict==copy;
    if(!inert_keys(dict)||PyDict_GET_SIZE(dict)!=PyDict_GET_SIZE(copy))return 0;
    Py_ssize_t pos=0;PyObject *key,*value;
    while(PyDict_Next(copy,&pos,&key,&value))if(PyDict_GetItemWithError(dict,key)!=value)return 0;
    return 1;
}
static int context_valid(void){
    if(!PyModule_CheckExact(base64mod))return 0;
    if(!inert_keys(globals_dict)||!inert_keys(builtin_dict)||!inert_keys(struct_dict)||!inert_keys(binascii_dict)||!inert_keys(gc_dict))return 0;
    for(int i=0;i<nbindings;i++)if(PyDict_GetItemWithError(bindings[i].dict,bindings[i].key)!=bindings[i].value)return 0;
    if(!PyModule_CheckExact(PyDict_GetItemString(globals_dict,"struct"))||!PyModule_CheckExact(PyDict_GetItemString(globals_dict,"binascii")))return 0;
    for(int i=0;i<4;i++)if(PyFunction_GetCode(functions[i])!=codes[i]||PyFunction_GetDefaults(functions[i])!=defaults[i]||!same_dict(PyFunction_GetKwDefaults(functions[i]),kwcopies[i]))return 0;
    PyObject *callbacks=PyDict_GetItemString(gc_dict,"callbacks");
    if(!callbacks||!PyList_CheckExact(callbacks)||PyList_GET_SIZE(callbacks))return 0;
    return 1;
}
static int cache_valid(PyObject *alphabet){
    if(!PyBytes_CheckExact(alphabet))return 0;
    PyObject *all=PyDict_GetItemString(globals_dict,"_b32rev");
    if(!all||!PyDict_CheckExact(all))return 0;
    Py_ssize_t pos=0;PyObject *key,*value;
    while(PyDict_Next(all,&pos,&key,&value))if(!PyBytes_CheckExact(key))return 0;
    PyObject *rev=PyDict_GetItemWithError(all,alphabet);if(!rev)return !PyErr_Occurred();
    if(!PyDict_CheckExact(rev)||PyDict_GET_SIZE(rev)!=PyBytes_GET_SIZE(alphabet))return 0;
    pos=0;
    while(PyDict_Next(rev,&pos,&key,&value)){
        if(!PyLong_CheckExact(key)||!PyLong_CheckExact(value))return 0;
        /* Exact int comparisons avoid overflowing arbitrary cache integers. */
        int ko=0,vo=0;long k=PyLong_AsLongAndOverflow(key,&ko),v=PyLong_AsLongAndOverflow(value,&vo);
        if(ko||vo||k<0||k>255||v<0||v>=PyBytes_GET_SIZE(alphabet)||(unsigned char)PyBytes_AS_STRING(alphabet)[v]!=k)return 0;
    }
    return 1;
}
static int init_context(void){
    globals_dict=PyModule_GetDict(base64mod);
    PyObject *builtins=PyImport_ImportModule("builtins"),*s=PyImport_ImportModule("struct"),*b=PyImport_ImportModule("binascii"),*gc=PyImport_ImportModule("gc");
    if(!builtins||!s||!b||!gc)return -1;
    builtin_dict=PyModule_GetDict(builtins);struct_dict=PyModule_GetDict(s);binascii_dict=PyModule_GetDict(b);gc_dict=PyModule_GetDict(gc);
    /* Process-lifetime diagnostic module retains these modules intentionally. */
    const char *names[]={"a85decode","_b32decode","_85encode","_bytes_from_decode_data"};
    for(int i=0;i<4;i++){
        functions[i]=PyObject_GetAttrString(base64mod,names[i]);if(!functions[i]||!PyFunction_Check(functions[i]))return -1;
        if(i<3)originals[i]=functions[i];
        codes[i]=Py_NewRef(PyFunction_GetCode(functions[i]));defaults[i]=Py_XNewRef(PyFunction_GetDefaults(functions[i]));
        kwdefaults[i]=Py_XNewRef(PyFunction_GetKwDefaults(functions[i]));kwcopies[i]=kwdefaults[i]?PyDict_Copy(kwdefaults[i]):NULL;
        if(bind_one(globals_dict,names[i])<0)return -1;
    }
    const char *globals[]={"struct","binascii","bytes_types",NULL};
    for(int i=0;globals[i];i++)if(bind_one(globals_dict,globals[i])<0)return -1;
    const char *names2[]={"len","range","bytes","bytearray","enumerate","isinstance","memoryview","ValueError","KeyError","TypeError","UnicodeEncodeError","str",NULL};
    for(int i=0;names2[i];i++)if(bind_one(globals_dict,names2[i])<0||bind_one(builtin_dict,names2[i])<0)return -1;
    if(bind_one(struct_dict,"Struct")<0||bind_one(struct_dict,"error")<0||bind_one(binascii_dict,"Error")<0||bind_one(gc_dict,"callbacks")<0)return -1;
    return 0;
}
