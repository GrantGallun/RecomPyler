
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <structmember.h>
#include <stddef.h>
static PyObject *one(PyObject *s,PyObject *a){return PyLong_FromLong(1);}
static PyObject *two(PyObject *s,PyObject *a){return PyLong_FromLong(2);}
static PyObject *vector_two(PyObject *s,PyObject *const *a,size_t n,PyObject *k){return PyLong_FromLong(2);}
static PyObject *get_one(PyObject *s,void *c){return PyLong_FromLong(1);}
static PyObject *get_two(PyObject *s,void *c){return PyLong_FromLong(2);}
static PyMethodDef a={"same",one,METH_NOARGS,NULL};
static PyMethodDef b={"same",two,METH_NOARGS,NULL};
static PyMethodDef c={"same",one,METH_O,NULL};
static PyGetSetDef ga={"same",get_one,NULL,NULL,NULL};
static PyGetSetDef gb={"same",get_two,NULL,NULL,NULL};
typedef struct {PyObject_HEAD PyObject *left,*right;} Probe;
static PyMemberDef ma={"same",T_OBJECT_EX,offsetof(Probe,left),0,NULL};
static PyMemberDef mb={"same",T_OBJECT_EX,offsetof(Probe,right),0,NULL};
static PyType_Slot slots[]={{Py_tp_new,PyType_GenericNew},{0,NULL}};
static PyType_Spec spec={"prepared_binding_probe.Probe",sizeof(Probe),0,Py_TPFLAGS_DEFAULT,slots};
static PyModuleDef module={PyModuleDef_HEAD_INIT,"prepared_binding_probe",NULL,-1,NULL};
PyMODINIT_FUNC PyInit_prepared_binding_probe(void){
 PyObject *m=PyModule_Create(&module),*name=NULL,*t=NULL;
 if(!m)return NULL;
 name=PyUnicode_FromString("prepared_binding_probe");t=PyType_FromSpec(&spec);
 if(!name||!t)goto fail;
 #define ADD(n,v) if(PyModule_AddObject(m,n,v)<0)goto fail
 ADD("one",PyCFunction_NewEx(&a,m,name));ADD("two",PyCFunction_NewEx(&b,m,name));
 ADD("other_flags",PyCFunction_NewEx(&c,m,name));
 PyObject *different_vector=PyCFunction_NewEx(&a,m,name);
 if(!different_vector)goto fail;
 ((PyCFunctionObject*)different_vector)->vectorcall=vector_two;
 ADD("other_vectorcall",different_vector);
 ADD("method_one",PyDescr_NewMethod((PyTypeObject*)t,&a));
 ADD("method_two",PyDescr_NewMethod((PyTypeObject*)t,&b));
 ADD("get_one",PyDescr_NewGetSet((PyTypeObject*)t,&ga));
 ADD("get_two",PyDescr_NewGetSet((PyTypeObject*)t,&gb));
 ADD("member_one",PyDescr_NewMember((PyTypeObject*)t,&ma));
 ADD("member_two",PyDescr_NewMember((PyTypeObject*)t,&mb));
 ADD("Probe",Py_NewRef(t));
 Py_DECREF(name);Py_DECREF(t);return m;
 fail:Py_XDECREF(name);Py_XDECREF(t);Py_DECREF(m);return NULL;
}
