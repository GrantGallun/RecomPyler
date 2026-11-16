#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdint.h>
#include <string.h>
/* Hand-written complete-call ceilings, default flag domain. No interpreter loop.
   Boxed versions call CPython arithmetic/container APIs; borrowed versions read
   exact immutable bytes under the GIL and allocate their result once. */
static PyObject *base64mod, *error32,*struct_error,*overflow_pack;
static unsigned long native_fast[3],native_fallback[3];
#include "context.inc"
static int chained_error(PyObject *kind,const char *why){
    PyObject *context=PyErr_GetRaisedException(),*error=PyObject_CallFunction(kind,"s",why);
    if(!error){Py_XDECREF(context);return -1;}
    if(context)PyException_SetContext(error,context);
    PyException_SetCause(error,NULL);PyErr_SetRaisedException(error);return -1;
}
static PyObject *fallback(const char *name,PyObject *args){
    int i=strcmp(name,"a85decode")==0?0:strcmp(name,"_b32decode")==0?1:2;native_fallback[i]++;
    return PyObject_CallObject(originals[i],args);
}
static PyObject *convert(PyObject *value) {
    PyObject *fn=PyObject_GetAttrString(base64mod,"_bytes_from_decode_data");
    if(!fn)return NULL;
    PyObject *out=PyObject_CallOneArg(fn,value);Py_DECREF(fn);return out;
}
static PyObject *bad32(const char *why){PyErr_SetString(error32,why);return NULL;}
static PyObject *reverse_table(PyObject *alphabet) {
    PyObject *all=PyObject_GetAttrString(base64mod,"_b32rev");if(!all)return NULL;
    PyObject *rev=PyObject_GetItem(all,alphabet);
    if(!rev && PyErr_ExceptionMatches(PyExc_KeyError)) {
        PyErr_Clear();rev=PyDict_New();if(!rev){Py_DECREF(all);return NULL;}
        Py_ssize_t n=PyObject_Length(alphabet);
        for(Py_ssize_t i=0;i<n;i++){
            PyObject *key=PySequence_GetItem(alphabet,i),*v=PyLong_FromSsize_t(i);
            if(!key||!v||PyDict_SetItem(rev,key,v)<0){Py_XDECREF(key);Py_XDECREF(v);Py_DECREF(rev);Py_DECREF(all);return NULL;}
            Py_DECREF(key);Py_DECREF(v);
        }
        if(PyObject_SetItem(all,alphabet,rev)<0){Py_DECREF(rev);rev=NULL;}
    }
    Py_DECREF(all);return rev;
}
static PyObject *b32_boxed(PyObject *self,PyObject *args){
    PyObject *alphabet,*value,*s=NULL,*rev=NULL,*decoded=NULL,*acc=NULL,*five=NULL,*quantum=NULL,*packed=NULL,*key=NULL,*v=NULL,*shift=NULL,*next=NULL;
    if(!PyArg_ParseTuple(args,"OO",&alphabet,&value))return NULL;
    if(!context_valid()||!cache_valid(alphabet)||(!PyBytes_CheckExact(value)&&!PyUnicode_CheckExact(value)))return fallback("_b32decode",args);
    rev=reverse_table(alphabet);if(!rev)goto fail;
    s=convert(value);if(!s)goto fail;
    Py_ssize_t n=PyBytes_Size(s),end=n;
    if(n%8){bad32("Incorrect padding");goto fail;}
    const unsigned char *raw=(const unsigned char*)PyBytes_AS_STRING(s);
    while(end && raw[end-1]=='=')end--;
    Py_ssize_t padding=n-end;
    decoded=PyByteArray_FromStringAndSize(NULL,0);five=PyLong_FromLong(5);
    if(!decoded||!five)goto fail;
    for(Py_ssize_t i=0;i<end;i+=8){
        Py_XDECREF(acc);acc=PyLong_FromLong(0);if(!acc)goto fail;
        Py_ssize_t stop=i+8<end?i+8:end;
        for(Py_ssize_t j=i;j<stop;j++){
            key=PySequence_GetItem(s,j);if(!key)goto fail;
            v=PyObject_GetItem(rev,key);Py_CLEAR(key);
            if(!v){if(PyErr_ExceptionMatches(PyExc_KeyError)){chained_error(error32,"Non-base32 digit found");}goto fail;}
            shift=PyNumber_Lshift(acc,five);if(!shift)goto fail;
            next=PyNumber_Add(shift,v);Py_CLEAR(shift);Py_CLEAR(v);if(!next)goto fail;
            Py_SETREF(acc,next);next=NULL;
        }
        packed=PyObject_CallMethod(acc,"to_bytes","n",(Py_ssize_t)5);if(!packed)goto fail;
        next=PyNumber_InPlaceAdd(decoded,packed);Py_CLEAR(packed);if(!next)goto fail;
        Py_SETREF(decoded,next);next=NULL;
    }
    if(!(padding==0||padding==1||padding==3||padding==4||padding==6)){bad32("Incorrect padding");goto fail;}
    if(padding && PyByteArray_Size(decoded)){
        v=PyLong_FromSsize_t(5*padding);if(!v)goto fail;
        shift=PyNumber_Lshift(acc,v);Py_CLEAR(v);if(!shift)goto fail;
        packed=PyObject_CallMethod(shift,"to_bytes","n",(Py_ssize_t)5);Py_CLEAR(shift);if(!packed)goto fail;
        Py_ssize_t keep=(43-5*padding)/8,offset=PyByteArray_Size(decoded)-5;
        memcpy(PyByteArray_AS_STRING(decoded)+offset,PyBytes_AS_STRING(packed),(size_t)keep);Py_CLEAR(packed);
        if(PyByteArray_Resize(decoded,offset+keep)<0)goto fail;
    }
    next=PyBytes_FromObject(decoded);
fail:
    Py_XDECREF(s);Py_XDECREF(rev);Py_XDECREF(decoded);Py_XDECREF(acc);Py_XDECREF(five);Py_XDECREF(quantum);Py_XDECREF(packed);Py_XDECREF(key);Py_XDECREF(v);Py_XDECREF(shift);
    return next;
}
static PyObject *b32_borrowed(PyObject *self,PyObject *args){
    PyObject *alphabet,*value,*s=NULL,*rev=NULL,*out=NULL;
    if(!PyArg_ParseTuple(args,"OO",&alphabet,&value))return NULL;
    if(!context_valid()||!cache_valid(alphabet)||!PyBytes_CheckExact(value)||PyBytes_GET_SIZE(alphabet)!=32)return fallback("_b32decode",args);
    rev=reverse_table(alphabet);if(!rev)goto fail;s=convert(value);if(!s)goto fail;
    Py_ssize_t n=PyBytes_Size(s),end=n;if(n%8){bad32("Incorrect padding");goto fail;}
    const unsigned char *raw=(const unsigned char*)PyBytes_AS_STRING(s);while(end&&raw[end-1]=='=')end--;
    Py_ssize_t pad=n-end;
    int table[256];for(int i=0;i<256;i++)table[i]=-1;
    if(!PyDict_CheckExact(rev)||PyDict_GET_SIZE(rev)!=32){Py_CLEAR(s);Py_CLEAR(rev);return fallback("_b32decode",args);}
    Py_ssize_t pos=0;PyObject *key,*digit_obj;int canonical=1;
    while(PyDict_Next(rev,&pos,&key,&digit_obj)){
        if(!PyLong_CheckExact(key)||!PyLong_CheckExact(digit_obj)){canonical=0;break;}
        long k=PyLong_AsLong(key),digit=PyLong_AsLong(digit_obj);
        if(PyErr_Occurred()){if(PyErr_ExceptionMatches(PyExc_OverflowError)){PyErr_Clear();canonical=0;break;}goto fail;}
        if(k<0||k>255||digit<0||digit>=32||(unsigned char)PyBytes_AS_STRING(alphabet)[digit]!=k){canonical=0;break;}
        table[k]=(int)digit;
    }
    if(!canonical){Py_CLEAR(s);Py_CLEAR(rev);return fallback("_b32decode",args);}
    native_fast[1]++;
    out=PyBytes_FromStringAndSize(NULL,(end/8)*5+((end%8)*5)/8);if(!out)goto fail;
    unsigned char *dst=(unsigned char*)PyBytes_AS_STRING(out);uint64_t acc=0;int bits=0;Py_ssize_t at=0;
    for(Py_ssize_t i=0;i<end;i++){
        int digit=table[raw[i]];if(digit<0){PyObject *key=PyLong_FromLong(raw[i]);if(key){PyErr_SetObject(PyExc_KeyError,key);Py_DECREF(key);chained_error(error32,"Non-base32 digit found");}Py_CLEAR(out);goto fail;}
        acc=(acc<<5)|(unsigned)digit;bits+=5;
        if(bits>=8){bits-=8;dst[at++]=(unsigned char)(acc>>bits);}
        if(bits)acc&=(((uint64_t)1<<bits)-1);else acc=0;
    }
    if(!(pad==0||pad==1||pad==3||pad==4||pad==6)){Py_CLEAR(out);bad32("Incorrect padding");}
fail:Py_XDECREF(s);Py_XDECREF(rev);return out;
}
static int overflow85(uint64_t value){
    PyObject *arg=PyLong_FromUnsignedLongLong(value);if(!arg)return -1;
    PyObject *result=PyObject_CallOneArg(overflow_pack,arg);Py_DECREF(arg);
    if(result){Py_DECREF(result);PyErr_SetString(PyExc_SystemError,"expected struct overflow");return -1;}
    if(PyErr_ExceptionMatches(struct_error))return chained_error(PyExc_ValueError,"Ascii85 overflow");return -1;
}
static PyObject *a85_borrowed(PyObject *self,PyObject *value){
    if(!context_valid()||!PyBytes_CheckExact(value)){PyObject *args=PyTuple_Pack(1,value);if(!args)return NULL;PyObject *out=fallback("a85decode",args);Py_DECREF(args);return out;}
    native_fast[0]++;
    PyObject *s=convert(value),*out=NULL;if(!s)return NULL;
    Py_ssize_t n=PyBytes_GET_SIZE(s);
    if(n>(PY_SSIZE_T_MAX-4)/4){Py_DECREF(s);return PyErr_NoMemory();}
    out=PyBytes_FromStringAndSize(NULL,n*4+4);if(!out){Py_DECREF(s);return NULL;}
    const unsigned char *raw=(const unsigned char*)PyBytes_AS_STRING(s);unsigned char *dst=(unsigned char*)PyBytes_AS_STRING(out);
    uint64_t acc=0;int count=0;Py_ssize_t at=0;
    for(Py_ssize_t i=0;i<n+4;i++){
        unsigned x=i<n?raw[i]:'u';
        if(x>='!'&&x<='u'){
            acc=acc*85+(x-33);count++;
            if(count==5){
                if(acc>UINT32_MAX){overflow85(acc);goto fail;}
                dst[at++]=(unsigned char)(acc>>24);dst[at++]=(unsigned char)(acc>>16);dst[at++]=(unsigned char)(acc>>8);dst[at++]=(unsigned char)acc;
                count=0;acc=0;
            }
        } else if(x=='z'){
            if(count){PyErr_SetString(PyExc_ValueError,"z inside Ascii85 5-tuple");goto fail;}
            memset(dst+at,0,4);at+=4;
        } else if(x==' '||x=='\t'||x=='\n'||x=='\r'||x=='\v')continue;
        else {PyErr_Format(PyExc_ValueError,"Non-Ascii85 digit found: %c",x);goto fail;}
    }
    at-=4-count;if(at<0)at=0;
    if(_PyBytes_Resize(&out,at)<0){Py_DECREF(s);return NULL;}
    Py_DECREF(s);return out;
fail:Py_DECREF(s);Py_DECREF(out);return NULL;
}
static PyObject *a85_boxed(PyObject *self,PyObject *value){
    PyObject *s=NULL,*combined=NULL,*padding=NULL,*decoded=NULL,*curr=NULL,*acc=NULL,*eightyfive=NULL,*thirtythree=NULL,*x=NULL,*v=NULL,*mul=NULL,*next=NULL,*structmod=NULL,*factory=NULL,*pack=NULL,*format=NULL,*packer=NULL,*packed=NULL,*empty=NULL,*result=NULL;
    if(!context_valid()||(!PyBytes_CheckExact(value)&&!PyUnicode_CheckExact(value))){PyObject *args=PyTuple_Pack(1,value);if(!args)return NULL;PyObject *out=fallback("a85decode",args);Py_DECREF(args);return out;}
    s=convert(value);if(!s)goto fail;
    padding=PyBytes_FromStringAndSize("uuuu",4);if(!padding)goto fail;
    combined=PyNumber_Add(s,padding);if(!combined)goto fail;
    decoded=PyList_New(0);curr=PyList_New(0);eightyfive=PyLong_FromLong(85);thirtythree=PyLong_FromLong(33);
    structmod=PyObject_GetAttrString(base64mod,"struct");if(!structmod)goto fail;
    factory=PyObject_GetAttrString(structmod,"Struct");format=PyUnicode_FromString("!I");if(!factory||!format)goto fail;
    packer=PyObject_CallOneArg(factory,format);if(!packer)goto fail;pack=PyObject_GetAttrString(packer,"pack");if(!pack||!decoded||!curr||!eightyfive||!thirtythree)goto fail;
    for(Py_ssize_t i=0;i<PyBytes_Size(combined);i++){
        x=PySequence_GetItem(combined,i);if(!x)goto fail;long digit=PyLong_AsLong(x);if(PyErr_Occurred())goto fail;
        if(digit>='!'&&digit<='u'){
            if(PyList_Append(curr,x)<0)goto fail;
            if(PyList_Size(curr)==5){
                acc=PyLong_FromLong(0);if(!acc)goto fail;
                for(Py_ssize_t j=0;j<5;j++){
                    v=PyNumber_Subtract(PyList_GetItem(curr,j),thirtythree);if(!v)goto fail;
                    mul=PyNumber_Multiply(eightyfive,acc);if(!mul)goto fail;
                    next=PyNumber_Add(mul,v);Py_CLEAR(v);Py_CLEAR(mul);if(!next)goto fail;Py_SETREF(acc,next);next=NULL;
                }
                packed=PyObject_CallOneArg(pack,acc);Py_CLEAR(acc);
                if(!packed){if(PyErr_ExceptionMatches(struct_error))chained_error(PyExc_ValueError,"Ascii85 overflow");goto fail;}
                if(PyList_Append(decoded,packed)<0)goto fail;Py_CLEAR(packed);
                if(PyList_SetSlice(curr,0,5,NULL)<0)goto fail;
            }
        } else if(digit=='z'){
            if(PyList_Size(curr)){PyErr_SetString(PyExc_ValueError,"z inside Ascii85 5-tuple");goto fail;}
            packed=PyBytes_FromStringAndSize("\0\0\0\0",4);if(!packed||PyList_Append(decoded,packed)<0)goto fail;Py_CLEAR(packed);
        } else if(digit==' '||digit=='\t'||digit=='\n'||digit=='\r'||digit=='\v'){}
        else {PyErr_Format(PyExc_ValueError,"Non-Ascii85 digit found: %c",(int)digit);goto fail;}
        Py_CLEAR(x);
    }
    empty=PyBytes_FromStringAndSize("",0);if(!empty)goto fail;
    result=PyObject_CallMethod(empty,"join","O",decoded);if(!result)goto fail;
    Py_ssize_t remove=4-PyList_Size(curr);
    if(remove){next=PySequence_GetSlice(result,0,PyBytes_Size(result)-remove);Py_CLEAR(result);result=next;next=NULL;}
fail:
    Py_XDECREF(s);Py_XDECREF(combined);Py_XDECREF(padding);Py_XDECREF(decoded);Py_XDECREF(curr);Py_XDECREF(acc);Py_XDECREF(eightyfive);Py_XDECREF(thirtythree);Py_XDECREF(x);Py_XDECREF(v);Py_XDECREF(mul);Py_XDECREF(next);Py_XDECREF(structmod);Py_XDECREF(factory);Py_XDECREF(pack);Py_XDECREF(format);Py_XDECREF(packer);Py_XDECREF(packed);Py_XDECREF(empty);
    return result;
}
#include "encode85.inc"
static PyObject *stats(PyObject *self,PyObject *unused){return Py_BuildValue("{s:(kk),s:(kk),s:(kk)}","a85decode",native_fast[0],native_fallback[0],"b32decode",native_fast[1],native_fallback[1],"encode85",native_fast[2],native_fallback[2]);}
static PyMethodDef methods[]={
    {"stats",stats,METH_NOARGS,NULL},
    {"encode_boxed",encode_boxed,METH_VARARGS,NULL},{"encode_borrowed",encode_borrowed,METH_VARARGS,NULL},
    {"a85_boxed",a85_boxed,METH_O,NULL},{"a85_borrowed",a85_borrowed,METH_O,NULL},
    {"b32_boxed",b32_boxed,METH_VARARGS,NULL},{"b32_borrowed",b32_borrowed,METH_VARARGS,NULL},{NULL,NULL,0,NULL}};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"wave17_ceiling_bytes",NULL,-1,methods};
PyMODINIT_FUNC PyInit_wave17_ceiling_bytes(void){
    base64mod=PyImport_ImportModule("base64");if(!base64mod)return NULL;
    PyObject *binascii=PyImport_ImportModule("binascii");if(!binascii)return NULL;error32=PyObject_GetAttrString(binascii,"Error");Py_DECREF(binascii);if(!error32)return NULL;
    PyObject *structmod=PyImport_ImportModule("struct");if(!structmod)return NULL;
    struct_error=PyObject_GetAttrString(structmod,"error");
    PyObject *factory=PyObject_GetAttrString(structmod,"Struct"),*format=PyUnicode_FromString("!I");Py_DECREF(structmod);
    PyObject *packer=factory&&format?PyObject_CallOneArg(factory,format):NULL;Py_XDECREF(factory);Py_XDECREF(format);
    overflow_pack=packer?PyObject_GetAttrString(packer,"pack"):NULL;Py_XDECREF(packer);if(!overflow_pack||!struct_error)return NULL;
    if(init_context()<0)return NULL;
    return PyModule_Create(&module);
}
