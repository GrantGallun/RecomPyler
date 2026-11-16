#define PY_SSIZE_T_CLEAN
#include <Python.h>
static PyObject *original,*code,*gd,*bd,*gcmod,*gc_dict,*gc_callbacks,*keys[3],*builtins_values[3];
static unsigned long fast_calls,boxed_calls,fallback_calls;
static int inert(PyObject *d){Py_ssize_t pos=0;PyObject *k,*v;if(!PyDict_CheckExact(d))return 0;while(PyDict_Next(d,&pos,&k,&v))if(!PyUnicode_CheckExact(k))return 0;return 1;}
static int eligible(PyObject *value){
 if(!PyUnicode_CheckExact(value)||PyFunction_GetCode(original)!=code||!inert(gd)||!inert(bd))return 0;
 for(int i=0;i<3;i++)if(PyDict_GetItemWithError(gd,keys[i])||PyDict_GetItemWithError(bd,keys[i])!=builtins_values[i])return 0;
 if(!PyModule_CheckExact(gcmod)||!inert(gc_dict))return 0;
 PyObject *callbacks=PyDict_GetItemString(gc_dict,"callbacks");
 return callbacks&&callbacks==gc_callbacks&&PyList_CheckExact(callbacks)&&!PyList_GET_SIZE(callbacks);
}
static PyObject *delegate(PyObject *v){fallback_calls++;return PyObject_CallOneArg(original,v);}
static int blank(PyObject *line){PyObject *b=PyObject_CallMethod(line,"isspace",NULL);if(!b)return -1;int result=PyObject_IsTrue(b);Py_DECREF(b);return result;}
static PyObject *dedent_boxed(PyObject *self,PyObject *value){
 int ok=eligible(value);if(ok<0)return NULL;if(!ok)return delegate(value);boxed_calls++;
 PyObject *sep=PyUnicode_FromString("\n"),*lines=NULL,*out=NULL,*result=NULL;PyObject *lo=NULL,*hi=NULL;
 if(!sep)return NULL;lines=PyUnicode_Split(value,sep,-1);if(!lines)goto done;
 for(Py_ssize_t i=0;i<PyList_GET_SIZE(lines);i++){
  PyObject *line=PyList_GET_ITEM(lines,i);int is_blank=blank(line);if(is_blank<0)goto done;
  if(!PyUnicode_GET_LENGTH(line)||is_blank)continue;
  if(!lo){lo=line;hi=line;}else{
   int less=PyObject_RichCompareBool(line,lo,Py_LT),greater=less<0?-1:PyObject_RichCompareBool(line,hi,Py_GT);if(less<0||greater<0)goto done;
   if(less)lo=line;if(greater)hi=line;
  }
 }
 Py_ssize_t margin=0;
 if(lo)for(Py_ssize_t j=0;j<PyUnicode_GET_LENGTH(lo);j++){
  margin=j;Py_UCS4 c=PyUnicode_ReadChar(lo,j);
  if(c!=PyUnicode_ReadChar(hi,j)||(c!=' '&&c!='\t'))break;
 }
 out=PyList_New(PyList_GET_SIZE(lines));if(!out)goto done;
 for(Py_ssize_t i=0;i<PyList_GET_SIZE(lines);i++){
  PyObject *line=PyList_GET_ITEM(lines,i);int is_blank=blank(line);if(is_blank<0)goto done;
  PyObject *piece=is_blank?PyUnicode_FromString(""):PyUnicode_Substring(line,margin,PyUnicode_GET_LENGTH(line));
  if(!piece)goto done;PyList_SET_ITEM(out,i,piece);
 }
 result=PyUnicode_Join(sep,out);
done:Py_XDECREF(out);Py_XDECREF(lines);Py_DECREF(sep);return result;
}
static PyObject *dedent_borrowed(PyObject *self,PyObject *value){
 int ok=eligible(value);if(ok<0)return NULL;if(!ok)return delegate(value);fast_calls++;
 int kind=PyUnicode_KIND(value);const void *data=PyUnicode_DATA(value);Py_ssize_t n=PyUnicode_GET_LENGTH(value),margin=-1,first=0,newlines=0;
 for(Py_ssize_t start=0;start<=n;){
  Py_ssize_t end=start;int is_blank=1;while(end<n&&PyUnicode_READ(kind,data,end)!='\n'){if(!Py_UNICODE_ISSPACE(PyUnicode_READ(kind,data,end)))is_blank=0;end++;}
  if(end>start&&!is_blank){
   Py_ssize_t indent=0;while(start+indent<end){Py_UCS4 c=PyUnicode_READ(kind,data,start+indent);if(c!=' '&&c!='\t')break;indent++;}
   if(margin<0){margin=indent;first=start;}else{if(indent<margin)margin=indent;Py_ssize_t j=0;while(j<margin&&PyUnicode_READ(kind,data,first+j)==PyUnicode_READ(kind,data,start+j))j++;margin=j;}
  }
  if(end==n)break;newlines++;start=end+1;
 }
 if(margin<0)margin=0;
 /* Single-line join/slice aliasing matches CPython; multi-line join allocates. */
 if(!newlines){int allblank=n>0;for(Py_ssize_t i=0;i<n;i++)if(!Py_UNICODE_ISSPACE(PyUnicode_READ(kind,data,i))){allblank=0;break;}
  if(allblank)return PyUnicode_FromString("");return PyUnicode_Substring(value,margin,n);
 }
 Py_ssize_t length=newlines;Py_UCS4 maximum='\n';
 for(Py_ssize_t start=0;start<=n;){
  Py_ssize_t end=start;int is_blank=1;while(end<n&&PyUnicode_READ(kind,data,end)!='\n'){if(!Py_UNICODE_ISSPACE(PyUnicode_READ(kind,data,end)))is_blank=0;end++;}
  if(!is_blank){Py_ssize_t begin=margin<end-start?start+margin:end;length+=end-begin;for(Py_ssize_t i=begin;i<end;i++){Py_UCS4 c=PyUnicode_READ(kind,data,i);if(c>maximum)maximum=c;}}
  if(end==n)break;start=end+1;
 }
 PyObject *out=PyUnicode_New(length,maximum);if(!out)return NULL;int outkind=PyUnicode_KIND(out);void *dst=PyUnicode_DATA(out);Py_ssize_t at=0;
 for(Py_ssize_t start=0;start<=n;){
  Py_ssize_t end=start;int is_blank=1;while(end<n&&PyUnicode_READ(kind,data,end)!='\n'){if(!Py_UNICODE_ISSPACE(PyUnicode_READ(kind,data,end)))is_blank=0;end++;}
  if(!is_blank){Py_ssize_t begin=margin<end-start?start+margin:end;for(Py_ssize_t i=begin;i<end;i++)PyUnicode_WRITE(outkind,dst,at++,PyUnicode_READ(kind,data,i));}
  if(end==n)break;PyUnicode_WRITE(outkind,dst,at++,'\n');start=end+1;
 }
 return out;
}
static PyObject *stats(PyObject *self,PyObject *unused){return Py_BuildValue("(kkk)",boxed_calls,fast_calls,fallback_calls);}
static PyMethodDef methods[]={{"dedent_boxed",dedent_boxed,METH_O,NULL},{"dedent_borrowed",dedent_borrowed,METH_O,NULL},{"stats",stats,METH_NOARGS,NULL},{NULL,NULL,0,NULL}};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"wave17_ceiling_unicode",NULL,-1,methods};
PyMODINIT_FUNC PyInit_wave17_ceiling_unicode(void){
 PyObject *textwrap=PyImport_ImportModule("textwrap"),*builtins=PyImport_ImportModule("builtins");gcmod=PyImport_ImportModule("gc");if(!textwrap||!builtins||!gcmod)return NULL;
 gc_dict=PyModule_GetDict(gcmod);gc_callbacks=Py_XNewRef(PyDict_GetItemString(gc_dict,"callbacks"));
 original=PyObject_GetAttrString(textwrap,"dedent");if(!original||!PyFunction_Check(original))return NULL;
 code=Py_NewRef(PyFunction_GetCode(original));gd=PyFunction_GetGlobals(original);bd=PyModule_GetDict(builtins);
 const char *names[]={"min","max","enumerate"};for(int i=0;i<3;i++){keys[i]=PyUnicode_InternFromString(names[i]);if(!keys[i])return NULL;builtins_values[i]=Py_XNewRef(PyDict_GetItemWithError(bd,keys[i]));if(!builtins_values[i]){PyErr_SetString(PyExc_RuntimeError,"missing expected builtin");return NULL;}}
 return PyModule_Create(&module);
}
