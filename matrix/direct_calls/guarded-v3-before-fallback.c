#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdint.h>
#include <limits.h>
/* S34 diagnostic only: CPython 3.14 ABI, GIL held, no product backend changes. */
static PyObject *original[3],*globals_[3],*builtins_[3],*codes[3];
static PyTypeObject *gvtype,*randomtype,*halftype,*fixedtype;
static unsigned int gvversion,randomversion,halfversion,fixedversion;
static PyObject *nx,*ny,*nz,*nfixed,*nhp,*nmaxhp,*nreplace,*nrandom,*nitems,*nmaxsize;
static PyObject *format,*zero,*isinstance_fn,*maxsize_obj,*min_expected,*max_expected,*sys_expected;
static PyCFunction random_pointer;
static unsigned long counts[3][3];
typedef struct {PyObject *fn,*code,*cells;} FunGuard;
static FunGuard replace_guard,make_guard;
static PyObject *fail_count(const char *name,Py_ssize_t expected,Py_ssize_t found){PyErr_Format(PyExc_TypeError,"%s() takes %zd arguments (%zd given)",name,expected,found);return NULL;}
static PyObject *lookup(int i,const char *name){
    PyObject *out=NULL;int status=PyDict_GetItemStringRef(globals_[i],name,&out);
    if(status<0)return NULL;if(status)return out;
    status=PyDict_GetItemStringRef(builtins_[i],name,&out);
    if(status<0)return NULL;if(status)return out;
    PyErr_Format(PyExc_NameError,"name '%s' is not defined",name);return NULL;
}
static int name_is(int i,const char *name,PyObject *expected){PyObject *v=lookup(i,name);if(!v){if(PyErr_ExceptionMatches(PyExc_NameError)){PyErr_Clear();return 0;}return -1;}int same=v==expected;Py_DECREF(v);return same;}
static PyObject *fallback(int i,PyObject *const *args,Py_ssize_t n){counts[i][2]++;return PyObject_Vectorcall(original[i],args,n,NULL);}
static int inert_string_keys(PyObject *dict);
static int code_ok(int i){return PyFunction_GetCode(original[i])==codes[i]&&inert_string_keys(globals_[i])&&inert_string_keys(builtins_[i]);}
static int init_guard(FunGuard *g,PyObject *fn){
    if(!PyFunction_Check(fn)){PyErr_SetString(PyExc_TypeError,"expected Python method");return -1;}
    g->fn=Py_NewRef(fn);g->code=Py_NewRef(PyFunction_GetCode(fn));PyObject *closure=PyFunction_GetClosure(fn);
    Py_ssize_t n=closure?PyTuple_GET_SIZE(closure):0;g->cells=PyTuple_New(n);if(!g->cells)return -1;
    for(Py_ssize_t i=0;i<n;i++){PyObject *v=PyCell_Get(PyTuple_GET_ITEM(closure,i));if(!v){if(!PyErr_Occurred())PyErr_SetString(PyExc_ValueError,"empty cell");return -1;}PyTuple_SET_ITEM(g->cells,i,v);}return 0;
}
static int guard_ok(FunGuard *g){
    if(PyFunction_GetCode(g->fn)!=g->code)return 0;PyObject *closure=PyFunction_GetClosure(g->fn);Py_ssize_t n=closure?PyTuple_GET_SIZE(closure):0;
    if(n!=PyTuple_GET_SIZE(g->cells))return 0;for(Py_ssize_t i=0;i<n;i++)if(PyCell_GET(PyTuple_GET_ITEM(closure,i))!=PyTuple_GET_ITEM(g->cells,i))return 0;return 1;
}
static unsigned int version(PyTypeObject *type){return PyUnstable_Type_AssignVersionTag(type)?type->tp_version_tag:0;}
static int version_ok(PyObject *value,PyTypeObject *type,unsigned int tag){return Py_TYPE(value)==type&&tag&&type->tp_version_tag==tag;}
static int inert_string_keys(PyObject *dict){
    Py_ssize_t pos=0;PyObject *key,*value;
    while(PyDict_Next(dict,&pos,&key,&value))if(!PyUnicode_CheckExact(key))return 0;
    return 1;
}
static int inert_instance(PyObject *value){
    PyObject *dict=PyObject_GenericGetDict(value,NULL);if(!dict)return -1;
    int inert=inert_string_keys(dict);Py_DECREF(dict);return inert;
}
static PyObject *string_build(PyObject *self,PyObject *const *args,Py_ssize_t nargs){
    if(nargs!=1)return fail_count("string_build",1,nargs);if(!code_ok(0))return fallback(0,args,nargs);
    PyObject *a=args[0],*x=NULL,*y=NULL,*z=NULL,*values=NULL,*out=NULL,*dict=NULL;
    int fast=version_ok(a,gvtype,gvversion);
    if(fast){dict=PyObject_GenericGetDict(a,NULL);if(!dict)goto done;fast=inert_string_keys(dict);}
    if(fast){
        counts[0][0]++;
        int found=PyDict_GetItemRef(dict,nx,&x);if(found<0)goto done;if(!found){x=PyObject_GetAttr(a,nx);if(!x)goto done;}
        found=PyDict_GetItemRef(dict,ny,&y);if(found<0)goto done;if(!found){y=PyObject_GetAttr(a,ny);if(!y)goto done;}
        found=PyDict_GetItemRef(dict,nz,&z);if(found<0)goto done;if(!found){z=PyObject_GetAttr(a,nz);if(!z)goto done;}
    }else{counts[0][1]++;x=PyObject_GetAttr(a,nx);if(!x)goto done;y=PyObject_GetAttr(a,ny);if(!y)goto done;z=PyObject_GetAttr(a,nz);if(!z)goto done;}
    values=PyTuple_Pack(3,x,y,z);if(values)out=PyUnicode_Format(format,values);
 done:Py_XDECREF(x);Py_XDECREF(y);Py_XDECREF(z);Py_XDECREF(values);Py_XDECREF(dict);return out;
}
static int dict_names_ok(void){
    struct {const char *name;PyObject *value;} bindings[]={{"dict",(PyObject*)&PyDict_Type},{"type",(PyObject*)&PyType_Type},{"int",(PyObject*)&PyLong_Type},{"str",(PyObject*)&PyUnicode_Type},{"bytes",(PyObject*)&PyBytes_Type},{"isinstance",isinstance_fn}};
    for(int j=0;j<6;j++){int ok=name_is(1,bindings[j].name,bindings[j].value);if(ok<=0)return ok;}return 1;
}
static int inert_keys(PyObject *dict){
    Py_ssize_t pos=0;PyObject *key,*value;while(PyDict_Next(dict,&pos,&key,&value))if(!PyUnicode_CheckExact(key)&&!PyLong_CheckExact(key)&&!PyBytes_CheckExact(key)&&!PyBool_Check(key))return 0;return 1;
}
static PyObject *dict_loop(PyObject *self,PyObject *const *args,Py_ssize_t nargs){
    if(nargs!=2)return fail_count("dict_loop",2,nargs);if(!code_ok(1))return fallback(1,args,nargs);
    int names=dict_names_ok();if(names<0)return NULL;if(!names)return fallback(1,args,nargs);
    PyObject *source=args[0],*random=args[1],*dict=NULL,*method=NULL,*sysmod=NULL,*maximum=NULL,*items=NULL,*iterator=NULL,*item=NULL,*draw=NULL,*scaled=NULL,*replacement=NULL,*types=NULL,*instance_check=NULL,*int_type=NULL,*bytes_type=NULL,*str_type=NULL,*type_fn=NULL,*key_type=NULL,*eligible_result=NULL,*out=NULL;
    dict=PyDict_CheckExact(source)?PyDict_Copy(source):PyObject_CallOneArg((PyObject*)&PyDict_Type,source);if(!dict)goto done;
    int fast=PyDict_CheckExact(source)&&version_ok(random,randomtype,randomversion)&&inert_keys(dict);
    if(fast){int inert=inert_instance(random);if(inert<0)goto done;fast=inert;}
    if(fast){
        sysmod=lookup(1,"sys");
        if(!sysmod){if(PyErr_ExceptionMatches(PyExc_NameError)){PyErr_Clear();fast=0;}else goto done;}
        else fast=sysmod==sys_expected&&PyModule_CheckExact(sysmod)&&inert_string_keys(PyModule_GetDict(sysmod));
        if(fast){int found=PyDict_GetItemRef(PyModule_GetDict(sysmod),nmaxsize,&maximum);if(found<0)goto done;fast=found&&maximum==maxsize_obj&&PyLong_CheckExact(maximum);}
    }
    if(fast){
        method=PyObject_GetAttr(random,nrandom);if(!method)goto done;
        fast=PyCFunction_Check(method)&&PyCFunction_GetFunction(method)==random_pointer&&PyCFunction_GetSelf(method)==random;
        if(!fast)Py_CLEAR(method);
    }
    if(fast){
        counts[1][0]++;double multiplier=PyLong_AsDouble(maximum);if(PyErr_Occurred())goto done;
        Py_ssize_t pos=0;PyObject *key,*value;
        while(PyDict_Next(dict,&pos,&key,&value)){
            draw=PyObject_Vectorcall(method,NULL,0,NULL);if(!draw)goto done;
            if(!PyFloat_CheckExact(draw)){PyErr_SetString(PyExc_TypeError,"guarded Random returned a non-float");goto done;}
            double number=PyFloat_AS_DOUBLE(draw)*multiplier;Py_CLEAR(draw);
            scaled=PyFloat_FromDouble(number);if(!scaled)goto done;
            if(PyUnicode_CheckExact(key))replacement=PyObject_Str(scaled);
            else if(PyLong_CheckExact(key))replacement=PyLong_FromDouble(number);
            else if(PyBool_Check(key))replacement=PyBool_FromLong(number!=0.0);
            else replacement=PyObject_CallOneArg((PyObject*)&PyBytes_Type,scaled);
            Py_CLEAR(scaled);if(!replacement)goto done;
            if(PyDict_SetItem(dict,key,replacement)<0)goto done;Py_CLEAR(replacement);
        }
    }else{
        counts[1][1]++;Py_CLEAR(method);Py_CLEAR(sysmod);Py_CLEAR(maximum);
        items=PyObject_CallMethodNoArgs(dict,nitems);if(!items)goto done;iterator=PyObject_GetIter(items);if(!iterator)goto done;
        while((item=PyIter_Next(iterator))){
            PyObject *key=PyTuple_GET_ITEM(item,0);
            method=PyObject_GetAttr(random,nrandom);if(!method)goto done;
            draw=PyObject_Vectorcall(method,NULL,0,NULL);Py_CLEAR(method);if(!draw)goto done;
            sysmod=lookup(1,"sys");if(!sysmod)goto done;maximum=PyObject_GetAttr(sysmod,nmaxsize);Py_CLEAR(sysmod);if(!maximum)goto done;
            scaled=PyNumber_Multiply(draw,maximum);Py_CLEAR(draw);Py_CLEAR(maximum);if(!scaled)goto done;
            instance_check=lookup(1,"isinstance");if(!instance_check)goto done;
            int_type=lookup(1,"int");if(!int_type)goto done;bytes_type=lookup(1,"bytes");if(!bytes_type)goto done;str_type=lookup(1,"str");if(!str_type)goto done;
            types=PyTuple_Pack(3,int_type,bytes_type,str_type);Py_CLEAR(int_type);Py_CLEAR(bytes_type);Py_CLEAR(str_type);if(!types)goto done;
            PyObject *check_args[]={key,types};eligible_result=PyObject_Vectorcall(instance_check,check_args,2,NULL);Py_CLEAR(instance_check);Py_CLEAR(types);if(!eligible_result)goto done;
            int eligible=PyObject_IsTrue(eligible_result);Py_CLEAR(eligible_result);if(eligible<0)goto done;
            if(eligible){type_fn=lookup(1,"type");if(!type_fn)goto done;key_type=PyObject_CallOneArg(type_fn,key);Py_CLEAR(type_fn);if(!key_type)goto done;
                replacement=PyObject_CallOneArg(key_type,scaled);Py_CLEAR(key_type);if(!replacement)goto done;if(PyDict_SetItem(dict,key,replacement)<0)goto done;Py_CLEAR(replacement);}
            Py_CLEAR(scaled);Py_CLEAR(item);
        }
        if(PyErr_Occurred())goto done;
    }
    out=dict;dict=NULL;
 done:Py_XDECREF(dict);Py_XDECREF(method);Py_XDECREF(sysmod);Py_XDECREF(maximum);Py_XDECREF(items);Py_XDECREF(iterator);Py_XDECREF(item);Py_XDECREF(draw);Py_XDECREF(scaled);Py_XDECREF(replacement);Py_XDECREF(types);Py_XDECREF(instance_check);Py_XDECREF(int_type);Py_XDECREF(bytes_type);Py_XDECREF(str_type);Py_XDECREF(type_fn);Py_XDECREF(key_type);Py_XDECREF(eligible_result);return out;
}
static PyObject *mixed_calls(PyObject *self,PyObject *const *args,Py_ssize_t nargs){
    if(nargs!=2)return fail_count("mixed_calls",2,nargs);if(!code_ok(2))return fallback(2,args,nargs);
    PyObject *state=args[0],*change=args[1],*fixed=NULL,*maximum=NULL,*oldhp=NULL,*sum=NULL,*inner=NULL,*hp=NULL,*minfn=NULL,*maxfn=NULL,*method=NULL,*values=NULL,*one=NULL,*out=NULL;
    int normal=name_is(2,"min",min_expected);if(normal<0)return NULL;
    int other=name_is(2,"max",max_expected);if(other<0)return NULL;
    if(!normal||!other)return fallback(2,args,nargs);
    int fast=version_ok(state,halftype,halfversion)&&guard_ok(&replace_guard)&&guard_ok(&make_guard)&&PyTuple_GET_SIZE(state)==5;
    if(fast){
        PyObject *fixed_borrowed=PyTuple_GET_ITEM(state,0),*hp_borrowed=PyTuple_GET_ITEM(state,1);
        fast=version_ok(fixed_borrowed,fixedtype,fixedversion)&&PyTuple_GET_SIZE(fixed_borrowed)==5&&PyLong_CheckExact(hp_borrowed)&&PyLong_CheckExact(change)&&PyLong_CheckExact(PyTuple_GET_ITEM(fixed_borrowed,0));
        if(fast){
            Py_ssize_t a=PyLong_AsSsize_t(hp_borrowed);if(PyErr_Occurred()){if(PyErr_ExceptionMatches(PyExc_OverflowError)){PyErr_Clear();fast=0;}else goto done;}
            Py_ssize_t b=fast?PyLong_AsSsize_t(change):0;if(PyErr_Occurred()){if(PyErr_ExceptionMatches(PyExc_OverflowError)){PyErr_Clear();fast=0;}else goto done;}
            PyObject *max_borrowed=PyTuple_GET_ITEM(fixed_borrowed,0);Py_ssize_t limit=fast?PyLong_AsSsize_t(max_borrowed):0;
            if(PyErr_Occurred()){if(PyErr_ExceptionMatches(PyExc_OverflowError)){PyErr_Clear();fast=0;}else goto done;}
            if(fast&&((b>0&&a>PY_SSIZE_T_MAX-b)||(b<0&&a<PY_SSIZE_T_MIN-b)))fast=0;
            if(fast){
                counts[2][0]++;Py_ssize_t total=a+b,clamped=total>0?total:0;
                hp=limit<=clamped?Py_NewRef(max_borrowed):PyLong_FromSsize_t(clamped);if(!hp)goto done;
                values=PyTuple_New(5);if(!values)goto done;
                for(Py_ssize_t j=0;j<5;j++)PyTuple_SET_ITEM(values,j,Py_NewRef(j==1?hp:PyTuple_GET_ITEM(state,j)));
                one=PyTuple_Pack(1,values);if(!one)goto done;
                newfunc tuple_new=(newfunc)PyType_GetSlot(&PyTuple_Type,Py_tp_new);out=tuple_new(halftype,one,NULL);goto done;
            }
        }
    }
    counts[2][1]++;
    minfn=lookup(2,"min");if(!minfn)goto done;
    fixed=PyObject_GetAttr(state,nfixed);if(!fixed)goto done;maximum=PyObject_GetAttr(fixed,nmaxhp);if(!maximum)goto done;
    maxfn=lookup(2,"max");if(!maxfn)goto done;oldhp=PyObject_GetAttr(state,nhp);if(!oldhp)goto done;sum=PyNumber_Add(oldhp,change);if(!sum)goto done;
    PyObject *maxargs[]={zero,sum};inner=PyObject_Vectorcall(maxfn,maxargs,2,NULL);if(!inner)goto done;
    PyObject *minargs[]={maximum,inner};hp=PyObject_Vectorcall(minfn,minargs,2,NULL);if(!hp)goto done;
    method=PyObject_GetAttr(state,nreplace);if(!method)goto done;
    PyObject *kw=PyTuple_Pack(1,nhp);if(!kw)goto done;PyObject *replaceargs[]={hp};out=PyObject_Vectorcall(method,replaceargs,0,kw);Py_DECREF(kw);
 done:Py_XDECREF(fixed);Py_XDECREF(maximum);Py_XDECREF(oldhp);Py_XDECREF(sum);Py_XDECREF(inner);Py_XDECREF(hp);Py_XDECREF(minfn);Py_XDECREF(maxfn);Py_XDECREF(method);Py_XDECREF(values);Py_XDECREF(one);return out;
}
static PyObject *configure(PyObject *self,PyObject *args){
    PyObject *functions,*gv,*random,*half,*fixed;if(!PyArg_ParseTuple(args,"OOOOO",&functions,&gv,&random,&half,&fixed))return NULL;
    for(int i=0;i<3;i++){original[i]=Py_NewRef(PyTuple_GET_ITEM(functions,i));globals_[i]=Py_NewRef(PyFunction_GetGlobals(original[i]));builtins_[i]=PyObject_GetAttrString(original[i],"__builtins__");codes[i]=Py_NewRef(PyFunction_GetCode(original[i]));if(!builtins_[i])return NULL;}
    gvtype=(PyTypeObject*)Py_NewRef(gv);randomtype=(PyTypeObject*)Py_NewRef(random);halftype=(PyTypeObject*)Py_NewRef(half);fixedtype=(PyTypeObject*)Py_NewRef(fixed);
    PyObject *replacement=PyObject_GetAttrString(half,"_replace"),*make=PyObject_GetAttrString(half,"_make");if(!replacement||!make){Py_XDECREF(replacement);Py_XDECREF(make);return NULL;}
    if(init_guard(&replace_guard,replacement)<0||init_guard(&make_guard,PyMethod_Function(make))<0){Py_DECREF(replacement);Py_DECREF(make);return NULL;}Py_DECREF(replacement);Py_DECREF(make);
    PyObject *sample=PyObject_CallNoArgs(random),*method=sample?PyObject_GetAttr(sample,nrandom):NULL;if(!method){Py_XDECREF(sample);return NULL;}random_pointer=PyCFunction_GetFunction(method);Py_DECREF(method);Py_DECREF(sample);
    min_expected=lookup(2,"min");max_expected=lookup(2,"max");if(!min_expected||!max_expected)return NULL;
    isinstance_fn=lookup(1,"isinstance");PyObject *sysmod=lookup(1,"sys");maxsize_obj=sysmod?PyObject_GetAttr(sysmod,nmaxsize):NULL;sys_expected=sysmod;if(!isinstance_fn||!maxsize_obj)return NULL;
    /* Cache only the recorded inert layouts; tag changes force generic operations. */
    if(PyType_GetSlot(gvtype,Py_tp_getattro)==PyObject_GenericGetAttr&&gvtype->tp_base==&PyBaseObject_Type){PyObject *d=PyType_GetDict(gvtype);if(!PyDict_GetItemWithError(d,nx)&&!PyDict_GetItemWithError(d,ny)&&!PyDict_GetItemWithError(d,nz))gvversion=version(gvtype);}
    if(PyType_GetSlot(randomtype,Py_tp_getattro)==PyObject_GenericGetAttr)randomversion=version(randomtype);
    if(halftype->tp_base==&PyTuple_Type&&fixedtype->tp_base==&PyTuple_Type&&PyType_GetSlot(halftype,Py_tp_getattro)==PyObject_GenericGetAttr&&PyType_GetSlot(fixedtype,Py_tp_getattro)==PyObject_GenericGetAttr){halfversion=version(halftype);fixedversion=version(fixedtype);}
    if(PyErr_Occurred())return NULL;Py_RETURN_NONE;
}
static PyObject *stats(PyObject *self,PyObject *unused){return Py_BuildValue("{s:(kkk),s:(kkk),s:(kkk)}","string",counts[0][0],counts[0][1],counts[0][2],"dict",counts[1][0],counts[1][1],counts[1][2],"mixed",counts[2][0],counts[2][1],counts[2][2]);}
static PyMethodDef methods[]={{"configure",configure,METH_VARARGS,NULL},{"stats",stats,METH_NOARGS,NULL},{"string_build",(PyCFunction)string_build,METH_FASTCALL,NULL},{"dict_loop",(PyCFunction)dict_loop,METH_FASTCALL,NULL},{"mixed_calls",(PyCFunction)mixed_calls,METH_FASTCALL,NULL},{NULL,NULL,0,NULL}};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"wave17_s34",NULL,-1,methods};
PyMODINIT_FUNC PyInit_wave17_s34(void){
    nx=PyUnicode_InternFromString("x");ny=PyUnicode_InternFromString("y");nz=PyUnicode_InternFromString("z");nfixed=PyUnicode_InternFromString("fixed");nhp=PyUnicode_InternFromString("hp");nmaxhp=PyUnicode_InternFromString("maxhp");nreplace=PyUnicode_InternFromString("_replace");nrandom=PyUnicode_InternFromString("random");nitems=PyUnicode_InternFromString("items");nmaxsize=PyUnicode_InternFromString("maxsize");format=PyUnicode_FromString("<%f, %f, %f>");zero=PyLong_FromLong(0);
    if(!nx||!ny||!nz||!nfixed||!nhp||!nmaxhp||!nreplace||!nrandom||!nitems||!nmaxsize||!format||!zero)return NULL;return PyModule_Create(&module);
}
