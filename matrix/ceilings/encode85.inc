/* Complete _85encode bodies, profiled exact-bytes/table/boolean domain. */
static int parse85(PyObject *args,PyObject **b,PyObject **chars,PyObject **chars2,int *pad,int *foldnuls,int *foldspaces){
    PyObject *p=Py_False,*n=Py_False,*s=Py_False;
    if(!PyArg_ParseTuple(args,"OOO|OOO",b,chars,chars2,&p,&n,&s))return -1;
    if(!PyBool_Check(p)||!PyBool_Check(n)||!PyBool_Check(s)||!PyBytes_CheckExact(*b))return 0;
    *pad=p==Py_True;*foldnuls=n==Py_True;*foldspaces=s==Py_True;return 1;
}
static PyObject *encode_borrowed(PyObject *self,PyObject *args){
    PyObject *b,*chars,*chars2;int pad,foldnuls,foldspaces;
    int valid=parse85(args,&b,&chars,&chars2,&pad,&foldnuls,&foldspaces);if(valid<0)return NULL;if(!valid||!context_valid())return fallback("_85encode",args);
    if(!PyList_CheckExact(chars)||!PyList_CheckExact(chars2)||PyList_GET_SIZE(chars)!=85||PyList_GET_SIZE(chars2)!=7225)return fallback("_85encode",args);
    Py_ssize_t n=PyBytes_GET_SIZE(b),padding=(-n)&3,words=n/4+(padding!=0);
    if(words>PY_SSIZE_T_MAX/5)return PyErr_NoMemory();
    native_fast[2]++;
    PyObject *out=PyBytes_FromStringAndSize(NULL,words*5);if(!out)return NULL;
    unsigned char *dst=(unsigned char*)PyBytes_AS_STRING(out),*raw=(unsigned char*)PyBytes_AS_STRING(b);Py_ssize_t at=0;
    for(Py_ssize_t i=0;i<words;i++){
        uint32_t word=0;for(int j=0;j<4;j++)word=(word<<8)|(i*4+j<n?raw[i*4+j]:0);
        if(foldnuls&&!word){
            if(padding&&!pad&&i==words-1){
                PyObject *first=PyList_GET_ITEM(chars,0);
                if(!PyBytes_CheckExact(first)||PyBytes_GET_SIZE(first)!=1){Py_DECREF(out);return fallback("_85encode",args);}
                memset(dst+at,PyBytes_AS_STRING(first)[0],5);at+=5;
            }else dst[at++]='z';
            continue;
        }
        if(foldspaces&&word==0x20202020U){dst[at++]='y';continue;}
        PyObject *a=PyList_GET_ITEM(chars2,word/614125U),*c=PyList_GET_ITEM(chars2,(word/85U)%7225U),*d=PyList_GET_ITEM(chars,word%85U);
        if(!PyBytes_CheckExact(a)||!PyBytes_CheckExact(c)||!PyBytes_CheckExact(d)||PyBytes_GET_SIZE(a)!=2||PyBytes_GET_SIZE(c)!=2||PyBytes_GET_SIZE(d)!=1){Py_DECREF(out);return fallback("_85encode",args);}
        memcpy(dst+at,PyBytes_AS_STRING(a),2);memcpy(dst+at+2,PyBytes_AS_STRING(c),2);dst[at+4]=PyBytes_AS_STRING(d)[0];at+=5;
    }
    if(padding&&!pad)at-=padding;
    if(_PyBytes_Resize(&out,at)<0)return NULL;return out;
}
static PyObject *encode_boxed(PyObject *self,PyObject *args){
    PyObject *b,*chars,*chars2;int pad,foldnuls,foldspaces;
    int valid=parse85(args,&b,&chars,&chars2,&pad,&foldnuls,&foldspaces);if(valid<0)return NULL;if(!valid||!context_valid())return fallback("_85encode",args);
    PyObject *padded=NULL,*zeros=NULL,*structmod=NULL,*factory=NULL,*fmt=NULL,*packer=NULL,*words=NULL,*chunks=NULL,*a=NULL,*c=NULL,*d=NULL,*index=NULL,*tmp=NULL,*piece=NULL,*empty=NULL,*out=NULL;
    PyObject *base=PyLong_FromLong(85),*large=PyLong_FromLong(614125),*square=PyLong_FromLong(7225);if(!base||!large||!square)goto done;
    Py_ssize_t n=PyBytes_GET_SIZE(b),padding=(-n)&3;
    if(padding){zeros=PyBytes_FromStringAndSize("\0\0\0",padding);if(!zeros)goto done;padded=PyNumber_Add(b,zeros);if(!padded)goto done;}else padded=Py_NewRef(b);
    structmod=PyObject_GetAttrString(base64mod,"struct");if(!structmod)goto done;factory=PyObject_GetAttrString(structmod,"Struct");fmt=PyUnicode_FromFormat("!%zdI",PyBytes_GET_SIZE(padded)/4);if(!factory||!fmt)goto done;
    packer=PyObject_CallOneArg(factory,fmt);if(!packer)goto done;words=PyObject_CallMethod(packer,"unpack","O",padded);if(!words)goto done;
    chunks=PyList_New(PyTuple_GET_SIZE(words));if(!chunks)goto done;
    for(Py_ssize_t i=0;i<PyTuple_GET_SIZE(words);i++){
        PyObject *word=PyTuple_GET_ITEM(words,i);unsigned long number=PyLong_AsUnsignedLong(word);if(PyErr_Occurred())goto done;
        if(foldnuls&&!number)piece=PyBytes_FromStringAndSize("z",1);
        else if(foldspaces&&number==0x20202020UL)piece=PyBytes_FromStringAndSize("y",1);
        else{
            index=PyNumber_FloorDivide(word,large);if(!index)goto done;a=PyObject_GetItem(chars2,index);Py_CLEAR(index);if(!a)goto done;
            tmp=PyNumber_FloorDivide(word,base);if(!tmp)goto done;index=PyNumber_Remainder(tmp,square);Py_CLEAR(tmp);if(!index)goto done;c=PyObject_GetItem(chars2,index);Py_CLEAR(index);if(!c)goto done;
            tmp=PyNumber_Add(a,c);Py_CLEAR(a);Py_CLEAR(c);if(!tmp)goto done;
            index=PyNumber_Remainder(word,base);if(!index)goto done;d=PyObject_GetItem(chars,index);Py_CLEAR(index);if(!d)goto done;
            piece=PyNumber_Add(tmp,d);Py_CLEAR(tmp);Py_CLEAR(d);
        }
        if(!piece)goto done;PyList_SET_ITEM(chunks,i,piece);piece=NULL;
    }
    if(padding&&!pad){
        Py_ssize_t last=PyList_GET_SIZE(chunks)-1;PyObject *tail=PyList_GET_ITEM(chunks,last);
        a=PyBytes_FromStringAndSize("z",1);if(!a)goto done;int is_z=PyObject_RichCompareBool(tail,a,Py_EQ);Py_CLEAR(a);if(is_z<0)goto done;
        if(is_z){
            index=PyLong_FromLong(0);if(!index)goto done;tmp=PyObject_GetItem(chars,index);Py_CLEAR(index);if(!tmp)goto done;
            a=PyLong_FromLong(5);if(!a)goto done;piece=PyNumber_Multiply(tmp,a);Py_CLEAR(tmp);Py_CLEAR(a);if(!piece)goto done;
            if(PyList_SetItem(chunks,last,piece)<0){piece=NULL;goto done;}piece=NULL;tail=PyList_GET_ITEM(chunks,last);
        }
        index=PyLong_FromSsize_t(-padding);if(!index)goto done;tmp=PySlice_New(Py_None,index,Py_None);Py_CLEAR(index);if(!tmp)goto done;
        piece=PyObject_GetItem(tail,tmp);Py_CLEAR(tmp);if(!piece)goto done;
        if(PyList_SetItem(chunks,last,piece)<0){piece=NULL;goto done;}piece=NULL;
    }
    empty=PyBytes_FromStringAndSize("",0);if(!empty)goto done;out=PyObject_CallMethod(empty,"join","O",chunks);
 done:Py_XDECREF(padded);Py_XDECREF(zeros);Py_XDECREF(structmod);Py_XDECREF(factory);Py_XDECREF(fmt);Py_XDECREF(packer);Py_XDECREF(words);Py_XDECREF(chunks);Py_XDECREF(a);Py_XDECREF(c);Py_XDECREF(d);Py_XDECREF(index);Py_XDECREF(tmp);Py_XDECREF(piece);Py_XDECREF(empty);Py_XDECREF(base);Py_XDECREF(large);Py_XDECREF(square);return out;
}
