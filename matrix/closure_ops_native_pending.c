/* CPython function/cell operations used by compiled closure lowering. */
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdint.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error Closure primitives require CPython 3.14.4 release GIL ABI
#endif

static PyObject *make_function_known(PyObject *code,PyObject *globals,PyObject *closure,
        PyObject *defaults,PyObject *kwdefaults) {
    PyObject *value=PyFunction_New(code,globals);
    if (!value) return NULL;
    /* These are freshly NULL fields. SET_FUNCTION_ATTRIBUTE installs original
       owners directly, not three calls through the mutation API. */
    PyFunctionObject *function=(PyFunctionObject *)value;
    if (closure!=Py_None) function->func_closure=Py_NewRef(closure);
    if (defaults!=Py_None) function->func_defaults=Py_NewRef(defaults);
    if (kwdefaults!=Py_None) function->func_kwdefaults=Py_NewRef(kwdefaults);
    return value;
}
static PyObject *make_function(PyObject *code,PyObject *globals,PyObject *closure,
        PyObject *defaults,PyObject *kwdefaults) {
    if (!PyCode_Check(code) || !PyDict_Check(globals)) {
        PyErr_SetString(PyExc_TypeError,"function requires code and globals dict");return NULL;
    }
    Py_ssize_t freevars=PyCode_GetNumFree((PyCodeObject *)code);
    if (closure!=Py_None && !PyTuple_Check(closure)) {
        PyErr_SetString(PyExc_TypeError,"function closure requires cell tuple");return NULL;
    }
    Py_ssize_t count=closure==Py_None ? 0 : PyTuple_GET_SIZE(closure);
    if (count!=freevars) {
        PyErr_SetString(PyExc_ValueError,"function closure length differs from code");return NULL;
    }
    for (Py_ssize_t i=0;i<count;i++)
        if (!PyCell_Check(PyTuple_GET_ITEM(closure,i))) {
            PyErr_SetString(PyExc_TypeError,"function closure item is not a cell");return NULL;
        }
    if (defaults!=Py_None && !PyTuple_Check(defaults)) {
        PyErr_SetString(PyExc_TypeError,"function defaults require tuple");return NULL;
    }
    if (kwdefaults!=Py_None && !PyDict_Check(kwdefaults)) {
        PyErr_SetString(PyExc_TypeError,"function keyword defaults require dict");return NULL;
    }
    return make_function_known(code,globals,closure,defaults,kwdefaults);
}
static int bind_function(PyObject *owner,PyObject *name,PyObject *code,
        PyObject *globals,PyObject *closure,PyObject *defaults,PyObject *kwdefaults) {
    if (!PyDict_CheckExact(owner) && !PyCell_Check(owner)) {
        PyErr_SetString(PyExc_TypeError,"function binding requires source dict or cell");return -1;
    }
    PyObject *value=make_function(code,globals,closure,defaults,kwdefaults);
    if (!value)return -1;
    int status;
    if (PyCell_Check(owner)) {
        PyObject *prior=PyCell_GET(owner);
        PyCell_SET(owner,value);
        Py_XDECREF(prior);
        status=0;
    } else {
        status=PyDict_SetItem(owner,name,value);
        Py_DECREF(value);
    }
    return status;
}
static int bind_function_known(PyObject *owner,PyObject *name,PyObject *code,
        PyObject *globals,PyObject *closure,PyObject *defaults,PyObject *kwdefaults) {
    if (!PyDict_CheckExact(owner) && !PyCell_Check(owner)) {
        PyErr_SetString(PyExc_TypeError,"function binding requires source dict or cell");return -1;
    }
    PyObject *value=make_function_known(code,globals,closure,defaults,kwdefaults);
    if (!value)return -1;
    int status;
    if (PyCell_Check(owner)) {
        PyObject *prior=PyCell_GET(owner);
        PyCell_SET(owner,value);
        Py_XDECREF(prior);
        status=0;
    } else {
        status=PyDict_SetItem(owner,name,value);
        Py_DECREF(value);
    }
    return status;
}
static void empty_cell(PyObject *name,int freevar) {
    if (freevar) {
        PyErr_Format(PyExc_NameError,
            "cannot access free variable '%U' where it is not associated with a value in enclosing scope",name);
        PyObject *error=PyErr_GetRaisedException();
        if (error) {PyObject_SetAttrString(error,"name",name);PyErr_SetRaisedException(error);}
    } else PyErr_Format(PyExc_UnboundLocalError,
        "cannot access local variable '%U' where it is not associated with a value",name);
}
static PyObject *cell_get(PyObject *cell,PyObject *name,int freevar) {
    if (!PyCell_Check(cell) || !PyUnicode_Check(name)) {
        PyErr_SetString(PyExc_TypeError,"cell and source name required");return NULL;
    }
    PyObject *value=PyCell_GET(cell);
    if (!value) {empty_cell(name,freevar);return NULL;}
    return Py_NewRef(value);
}
static int cell_set(PyObject *cell,PyObject *value) {
    if (!PyCell_Check(cell) || !value) {
        PyErr_SetString(PyExc_TypeError,"cell and value required");return -1;
    }
    PyObject *prior=PyCell_GET(cell);
    PyCell_SET(cell,Py_NewRef(value));
    Py_XDECREF(prior);
    return 0;
}
static int cell_delete(PyObject *cell,PyObject *name,int freevar) {
    if (!PyCell_Check(cell) || !PyUnicode_Check(name)) {
        PyErr_SetString(PyExc_TypeError,"cell and source name required");return -1;
    }
    PyObject *prior=PyCell_GET(cell);
    if (!prior) {empty_cell(name,freevar);return -1;}
    PyCell_SET(cell,NULL);
    Py_DECREF(prior);
    return 0;
}
static PyObject *py_make_function(PyObject *self,PyObject *const *args,Py_ssize_t nargs) {
    if (nargs!=5) {PyErr_SetString(PyExc_TypeError,"make_function requires five arguments");return NULL;}
    return make_function(args[0],args[1],args[2],args[3],args[4]);
}
static PyObject *py_bind_function(PyObject *self,PyObject *const *args,Py_ssize_t nargs) {
    if (nargs!=7) {PyErr_SetString(PyExc_TypeError,"bind_function requires seven arguments");return NULL;}
    if (bind_function(args[0],args[1],args[2],args[3],args[4],args[5],args[6]))return NULL;
    Py_RETURN_NONE;
}
static PyObject *py_cell_get(PyObject *self,PyObject *const *args,Py_ssize_t nargs) {
    if (nargs!=3 || !PyBool_Check(args[2])) {PyErr_SetString(PyExc_TypeError,"cell_get requires cell,name,bool");return NULL;}
    return cell_get(args[0],args[1],args[2]==Py_True);
}
static PyObject *py_cell_set(PyObject *self,PyObject *const *args,Py_ssize_t nargs) {
    if (nargs!=2) {PyErr_SetString(PyExc_TypeError,"cell_set requires two arguments");return NULL;}
    if (cell_set(args[0],args[1]))return NULL;
    Py_RETURN_NONE;
}
static PyObject *py_cell_delete(PyObject *self,PyObject *const *args,Py_ssize_t nargs) {
    if (nargs!=3 || !PyBool_Check(args[2])) {PyErr_SetString(PyExc_TypeError,"cell_delete requires cell,name,bool");return NULL;}
    if (cell_delete(args[0],args[1],args[2]==Py_True))return NULL;
    Py_RETURN_NONE;
}
static PyObject *addresses(PyObject *self,PyObject *unused) {
    return Py_BuildValue("{s:K,s:K,s:K,s:K,s:K,s:K}",
        "make_function",(unsigned long long)(uintptr_t)make_function,
        "bind_function",(unsigned long long)(uintptr_t)bind_function,
        "bind_function_known",(unsigned long long)(uintptr_t)bind_function_known,
        "cell_get",(unsigned long long)(uintptr_t)cell_get,
        "cell_set",(unsigned long long)(uintptr_t)cell_set,
        "cell_delete",(unsigned long long)(uintptr_t)cell_delete);
}
static PyMethodDef methods[]={
    {"make_function",(PyCFunction)py_make_function,METH_FASTCALL,NULL},
    {"bind_function",(PyCFunction)py_bind_function,METH_FASTCALL,NULL},
    {"cell_get",(PyCFunction)py_cell_get,METH_FASTCALL,NULL},
    {"cell_set",(PyCFunction)py_cell_set,METH_FASTCALL,NULL},
    {"cell_delete",(PyCFunction)py_cell_delete,METH_FASTCALL,NULL},
    {"addresses",addresses,METH_NOARGS,NULL},{NULL}
};
static struct PyModuleDef module={PyModuleDef_HEAD_INIT,"_closure_ops_native",NULL,-1,methods};
PyMODINIT_FUNC PyInit__closure_ops_native(void){return PyModule_Create(&module);}

