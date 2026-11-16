import importlib.util
from pathlib import Path
import pytest
from test_prepared_cache import artifact,row_for,standalone,load_source

C_SOURCE = r"""
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
"""

@pytest.fixture(scope='module')
def native_bindings(tmp_path_factory):
    from setuptools import Distribution,Extension
    root=tmp_path_factory.mktemp('native-binding-probe')
    source=root/'probe.c';source.write_text(C_SOURCE)
    dist=Distribution({'name':'prepared_binding_probe','ext_modules':[Extension('prepared_binding_probe',[str(source)])]})
    command=dist.get_command_obj('build_ext')
    command.build_lib=str(root/'lib');command.build_temp=str(root/'temp')
    dist.run_command('build_ext')
    path=Path(command.get_ext_fullpath('prepared_binding_probe'))
    spec=importlib.util.spec_from_file_location('prepared_binding_probe',path)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    assert module.one()==1 and module.two()==2 and module.other_vectorcall()==2
    return module

@pytest.mark.parametrize('left,right',[('one','two'),('one','other_flags'),('one','other_vectorcall'),('method_one','method_two'),('get_one','get_two'),('member_one','member_two')])
def test_native_code_or_contract_changes_are_distinct(native_bindings,left,right):
    from recompyler import _prepared as pc
    assert pc._binding_key(getattr(native_bindings,left))!=pc._binding_key(getattr(native_bindings,right))

@pytest.mark.parametrize('path',['class-key','record-key'])
def test_malformed_class_module_is_rejected_without_user_equality(artifact,monkeypatch,path):
    pc,heap,module,source,section=artifact
    module=load_source(source)
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work),pc.last_miss()
    box=module.Box(1);events=[]
    class Hostile:
        def __eq__(self,other):events.append('equal');return False
        def __str__(self):events.append('str');return 'hostile'
    monkeypatch.setattr(module.Box,'__module__',Hostile())
    if path=='class-key':assert index.bind(module.work)==[]
    else:
        with pytest.raises(pc.PreparedMiss):pc._binding_key(box,pc.References(module.work))
    assert events==[]

def test_module_global_range_is_sealed_by_exact_bounds(tmp_path,monkeypatch):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'global_range.py'
    source.write_text('VALUES=range(5)\ndef work():\n    total=0\n    for item in VALUES: total+=item\n    return total\n')
    module=load_source(source)
    region=heap.lift_region(module.work);assert region()==10 and region.compiled_calls==1
    section=heap.build_regions([(('work',module.work.__code__.co_firstlineno),module.work,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work),pc.last_miss()
    def forbidden(*a,**k):raise AssertionError('regeneration on global range hit')
    monkeypatch.setattr(heap.Region,'_make_program',forbidden)
    fast=heap.lift_region(module.work,index.exports,prepared=index)
    assert fast()==10 and fast.aot_calls==fast.prepared_hits==1
    module.VALUES=range(6)
    assert index.bind(module.work)==[]
