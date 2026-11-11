/* The C half of recompyler.heap: copying arguments into a region's heap before a
 * compiled call, and writing changed attributes back afterwards.
 *
 * It does exactly what heap._Loader and heap._Unloader.write_back do, one object at a
 * time, without the Python bytecode around each attribute. Types come from the
 * program as small integers and lists (see heap._Program.c_kind):
 *
 *   0 float, 1 int-or-float ("mixed"), 2 int, 3 bool, 4 None, 9 anything else (no fit)
 *   [10, cls, nullable, [size, names, offsets, kinds]]   an object of class cls
 *   [11, item kind, ListT]                               a list
 *
 * A value that does not fit raises Mismatch, and the call is handed back to Python;
 * a heap too small for the arguments raises Grow, and the caller retries with more.
 */
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <math.h>

static PyObject *Mismatch, *Grow;

enum { K_FLOAT = 0, K_MIXED = 1, K_INT = 2, K_BOOL = 3, K_NONE = 4, K_BAD = 9, K_OBJ = 10, K_LIST = 11 };
/* Ints up to this size are exact as floats; heap.EXACT. */
#define EXACT 9007199254740992LL
/* Slots kept free above the arguments, as heap.Region.attempt keeps. */
#define SPARE 64

typedef struct {
    double *F;
    long long *I;
    Py_ssize_t cap, top;
    PyObject *handles, *objects, *lists;
} State;

static int mismatch(void) {
    PyErr_SetNone(Mismatch);
    return -1;
}

static long kind_code(PyObject *kind) {
    if (PyLong_CheckExact(kind))
        return PyLong_AsLong(kind);
    return PyLong_AsLong(PyList_GET_ITEM(kind, 0));
}

static int load_value(State *s, PyObject *kind, PyObject *value, long long *out);

static int put(State *s, PyObject *kind, Py_ssize_t where, PyObject *value) {
    long code = kind_code(kind);
    if (code == K_FLOAT) {
        if (!PyFloat_CheckExact(value))
            return mismatch();
        s->F[where] = PyFloat_AS_DOUBLE(value);
        return 0;
    }
    if (code == K_MIXED) {
        if (PyFloat_CheckExact(value)) {
            s->F[where] = PyFloat_AS_DOUBLE(value);
            s->I[where + 1] = 0;
            return 0;
        }
        if (PyLong_CheckExact(value)) {
            int overflow;
            long long v = PyLong_AsLongLongAndOverflow(value, &overflow);
            if (overflow || v < -EXACT || v > EXACT)
                return mismatch();
            s->F[where] = (double)v;
            s->I[where + 1] = 1;
            return 0;
        }
        return mismatch();
    }
    long long raw;
    if (load_value(s, kind, value, &raw) < 0)
        return -1;
    s->I[where] = raw;
    return 0;
}

/* The handle already given to ``value`` in this call: 1 and *out set, 0 if none. */
static int known(State *s, PyObject *value, PyObject **key, long long *out) {
    *key = PyLong_FromVoidPtr(value);
    if (*key == NULL)
        return -1;
    PyObject *found = PyDict_GetItemWithError(s->handles, *key);
    if (found != NULL) {
        *out = PyLong_AsLongLong(found);
        return 1;
    }
    return PyErr_Occurred() ? -1 : 0;
}

static int remember(State *s, PyObject *key, PyObject *value, long long handle, PyObject *tag, PyObject *into) {
    PyObject *number = PyLong_FromLongLong(handle);
    if (number == NULL)
        return -1;
    int failed = PyDict_SetItem(s->handles, key, number) < 0;
    if (!failed) {
        PyObject *entry = PyTuple_Pack(3, value, number, tag);
        failed = entry == NULL || PyList_Append(into, entry) < 0;
        Py_XDECREF(entry);
    }
    Py_DECREF(number);
    return failed ? -1 : 0;
}

static int load_instance(State *s, PyObject *kind, PyObject *value, long long *out) {
    PyObject *cls = PyList_GET_ITEM(kind, 1), *plan = PyList_GET_ITEM(kind, 3), *key;
    int found = known(s, value, &key, out);
    if (found != 0) {
        Py_XDECREF(key);
        return found < 0 ? -1 : 0;
    }
    if ((PyObject *)Py_TYPE(value) != cls) {
        Py_DECREF(key);
        return mismatch();
    }
    Py_ssize_t size = PyLong_AsSsize_t(PyList_GET_ITEM(plan, 0));
    PyObject *names = PyList_GET_ITEM(plan, 1), *offsets = PyList_GET_ITEM(plan, 2), *kinds = PyList_GET_ITEM(plan, 3);
    Py_ssize_t count = PyTuple_GET_SIZE(names);
    PyObject *attributes = PyObject_GenericGetDict(value, NULL);
    if (attributes == NULL)
        PyErr_Clear();
    else if (PyDict_GET_SIZE(attributes) != count) {
        Py_DECREF(attributes);
        Py_DECREF(key);
        return mismatch();
    }
    long long handle = s->top;
    if (handle + size + SPARE > s->cap) {
        Py_XDECREF(attributes);
        Py_DECREF(key);
        PyErr_SetNone(Grow);
        return -1;
    }
    s->top += size;
    int failed = remember(s, key, value, handle, cls, s->objects) < 0;
    Py_DECREF(key);
    for (Py_ssize_t i = 0; !failed && i < count; i++) {
        PyObject *name = PyTuple_GET_ITEM(names, i), *item;
        if (attributes != NULL) {
            item = PyDict_GetItemWithError(attributes, name);
            Py_XINCREF(item);
        } else
            item = PyObject_GetAttr(value, name);
        if (item == NULL) {
            if (!PyErr_Occurred() || PyErr_ExceptionMatches(PyExc_AttributeError)) {
                PyErr_Clear();
                mismatch();
            }
            failed = 1;
            break;
        }
        failed = put(s, PyList_GET_ITEM(kinds, i), handle + PyLong_AsSsize_t(PyTuple_GET_ITEM(offsets, i)), item) < 0;
        Py_DECREF(item);
    }
    Py_XDECREF(attributes);
    if (failed)
        return -1;
    *out = handle;
    return 0;
}

static int load_list(State *s, PyObject *kind, PyObject *value, long long *out) {
    PyObject *key;
    int found = known(s, value, &key, out);
    if (found != 0) {
        Py_XDECREF(key);
        return found < 0 ? -1 : 0;
    }
    if (!PyList_CheckExact(value)) {
        Py_DECREF(key);
        return mismatch();
    }
    PyObject *item_kind = PyList_GET_ITEM(kind, 1);
    Py_ssize_t count = PyList_GET_SIZE(value);
    if (count && kind_code(item_kind) == K_BAD) {
        Py_DECREF(key);
        return mismatch();
    }
    long long handle = s->top, data = handle + 3;
    if (data + count + SPARE > s->cap) {
        Py_DECREF(key);
        PyErr_SetNone(Grow);
        return -1;
    }
    s->top = data + count;
    int failed = remember(s, key, value, handle, PyList_GET_ITEM(kind, 2), s->lists) < 0;
    Py_DECREF(key);
    if (failed)
        return -1;
    s->I[handle] = count;
    s->I[handle + 1] = count;
    s->I[handle + 2] = data;
    for (Py_ssize_t i = 0; i < count; i++) {
        if (i >= PyList_GET_SIZE(value))
            return mismatch();
        PyObject *item = PyList_GET_ITEM(value, i);
        Py_INCREF(item);
        failed = put(s, item_kind, data + i, item) < 0;
        Py_DECREF(item);
        if (failed)
            return -1;
    }
    *out = handle;
    return 0;
}

static int load_value(State *s, PyObject *kind, PyObject *value, long long *out) {
    switch (kind_code(kind)) {
    case K_INT:
        if (PyLong_CheckExact(value)) {
            int overflow;
            *out = PyLong_AsLongLongAndOverflow(value, &overflow);
            if (!overflow)
                return 0;
        }
        return mismatch();
    case K_BOOL:
        if (!PyBool_Check(value))
            return mismatch();
        *out = value == Py_True;
        return 0;
    case K_NONE:
        if (value != Py_None)
            return mismatch();
        *out = -1;
        return 0;
    case K_OBJ:
        if (value == Py_None) {
            if (!PyObject_IsTrue(PyList_GET_ITEM(kind, 2)))
                return mismatch();
            *out = -1;
            return 0;
        }
        if (Py_EnterRecursiveCall(" while loading a region's arguments"))
            return -1;
        {
            int result = load_instance(s, kind, value, out);
            Py_LeaveRecursiveCall();
            return result;
        }
    case K_LIST:
        if (Py_EnterRecursiveCall(" while loading a region's arguments"))
            return -1;
        {
            int result = load_list(s, kind, value, out);
            Py_LeaveRecursiveCall();
            return result;
        }
    default:
        return mismatch();
    }
}

static int heap_views(PyObject *F, PyObject *I, Py_buffer *fb, Py_buffer *ib) {
    if (PyObject_GetBuffer(F, fb, PyBUF_WRITABLE | PyBUF_C_CONTIGUOUS) < 0)
        return -1;
    if (PyObject_GetBuffer(I, ib, PyBUF_WRITABLE | PyBUF_C_CONTIGUOUS) < 0) {
        PyBuffer_Release(fb);
        return -1;
    }
    if (fb->itemsize != 8 || ib->itemsize != 8 || fb->len != ib->len) {
        PyBuffer_Release(fb);
        PyBuffer_Release(ib);
        PyErr_SetString(PyExc_ValueError, "the heap must be two 8-byte views of one array");
        return -1;
    }
    return 0;
}

/* load(kind, value, F, I, top, handles, objects, lists) -> (handle, top) */
static PyObject *load(PyObject *self, PyObject *const *args, Py_ssize_t nargs) {
    if (nargs != 8) {
        PyErr_SetString(PyExc_TypeError, "load takes 8 arguments");
        return NULL;
    }
    Py_buffer fb, ib;
    if (heap_views(args[2], args[3], &fb, &ib) < 0)
        return NULL;
    State s = {(double *)fb.buf, (long long *)ib.buf, fb.len / 8, PyLong_AsSsize_t(args[4]), args[5], args[6], args[7]};
    long long handle = 0;
    int failed = s.top < 0 || load_value(&s, args[0], args[1], &handle) < 0;
    PyBuffer_Release(&fb);
    PyBuffer_Release(&ib);
    if (failed)
        return NULL;
    return Py_BuildValue("Ln", handle, s.top);
}

static int same_float(PyObject *old, double value) {
    if (!PyFloat_CheckExact(old))
        return 0;
    double was = PyFloat_AS_DOUBLE(old);
    return was == value && copysign(1.0, was) == copysign(1.0, value);
}

static int same_int(PyObject *old, long long value) {
    if (!PyLong_CheckExact(old))
        return 0;
    int overflow;
    long long was = PyLong_AsLongLongAndOverflow(old, &overflow);
    return !overflow && was == value;
}

/* write_back(objects, plans, F, I, handles, fallback): store the attributes the
 * region wrote into the objects that came in. ``plans`` maps a class to
 * ((name, offset, code, kind), ...) for its written attributes; ``fallback(kind,
 * where)`` makes the Python value of an object or list handle not loaded as is. */
static PyObject *write_back(PyObject *self, PyObject *const *args, Py_ssize_t nargs) {
    if (nargs != 6) {
        PyErr_SetString(PyExc_TypeError, "write_back takes 6 arguments");
        return NULL;
    }
    PyObject *objects = args[0], *plans = args[1], *handles = args[4], *fallback = args[5];
    Py_buffer fb, ib;
    if (heap_views(args[2], args[3], &fb, &ib) < 0)
        return NULL;
    double *F = (double *)fb.buf;
    long long *I = (long long *)ib.buf;
    int failed = 0;
    Py_ssize_t total = PyList_GET_SIZE(objects);
    for (Py_ssize_t n = 0; !failed && n < total; n++) {
        PyObject *entry = PyList_GET_ITEM(objects, n);
        PyObject *value = PyTuple_GET_ITEM(entry, 0);
        long long handle = PyLong_AsLongLong(PyTuple_GET_ITEM(entry, 1));
        PyObject *plan = PyDict_GetItemWithError(plans, PyTuple_GET_ITEM(entry, 2));
        if (plan == NULL) {
            failed = PyErr_Occurred() != NULL;
            continue;
        }
        Py_ssize_t fields = PyTuple_GET_SIZE(plan);
        for (Py_ssize_t i = 0; !failed && i < fields; i++) {
            PyObject *field = PyTuple_GET_ITEM(plan, i);
            PyObject *name = PyTuple_GET_ITEM(field, 0);
            Py_ssize_t where = handle + PyLong_AsSsize_t(PyTuple_GET_ITEM(field, 1));
            long code = PyLong_AsLong(PyTuple_GET_ITEM(field, 2));
            PyObject *old = PyObject_GetAttr(value, name), *made = NULL;
            if (old == NULL) {
                failed = 1;
                break;
            }
            if (code == K_FLOAT) {
                if (!same_float(old, F[where]))
                    made = PyFloat_FromDouble(F[where]);
            } else if (code == K_MIXED) {
                double number = F[where];
                if (I[where + 1]) {
                    if (!same_int(old, (long long)number))
                        made = PyLong_FromDouble(number);
                } else if (!same_float(old, number))
                    made = PyFloat_FromDouble(number);
            } else if (code == K_INT) {
                if (!same_int(old, I[where]))
                    made = PyLong_FromLongLong(I[where]);
            } else if (code == K_BOOL) {
                PyObject *now = I[where] ? Py_True : Py_False;
                if (old != now)
                    made = Py_NewRef(now);
            } else {
                long long raw = I[where];
                if (code == K_NONE || raw < 0) {
                    if (old != Py_None)
                        made = Py_NewRef(Py_None);
                } else {
                    /* The object or list that came in at this handle is still there. */
                    int kept = 0;
                    if (old != Py_None) {
                        PyObject *key = PyLong_FromVoidPtr(old);
                        PyObject *had = key ? PyDict_GetItemWithError(handles, key) : NULL;
                        Py_XDECREF(key);
                        if (had != NULL)
                            kept = PyLong_AsLongLong(had) == raw;
                        else if (PyErr_Occurred())
                            failed = 1;
                    }
                    if (!kept && !failed) {
                        PyObject *where_number = PyLong_FromSsize_t(where);
                        PyObject *now = where_number ? PyObject_CallFunctionObjArgs(
                            fallback, PyTuple_GET_ITEM(field, 3), where_number, NULL) : NULL;
                        Py_XDECREF(where_number);
                        if (now == NULL)
                            failed = 1;
                        else if (now != old)
                            made = now;
                        else
                            Py_DECREF(now);
                    }
                }
            }
            if (!failed && made == NULL && PyErr_Occurred())
                failed = 1;
            if (made != NULL) {
                failed = PyObject_SetAttr(value, name, made) < 0;
                Py_DECREF(made);
            }
            Py_DECREF(old);
        }
    }
    PyBuffer_Release(&fb);
    PyBuffer_Release(&ib);
    if (failed)
        return NULL;
    Py_RETURN_NONE;
}

static PyMethodDef methods[] = {
    {"load", (PyCFunction)(void (*)(void))load, METH_FASTCALL, "Copy one argument into the heap."},
    {"write_back", (PyCFunction)(void (*)(void))write_back, METH_FASTCALL, "Store written attributes back."},
    {NULL, NULL, 0, NULL},
};

static int exec_module(PyObject *module) {
    Mismatch = PyErr_NewException("recompyler._heap.Mismatch", NULL, NULL);
    Grow = PyErr_NewException("recompyler._heap.Grow", NULL, NULL);
    if (Mismatch == NULL || Grow == NULL)
        return -1;
    if (PyModule_AddObjectRef(module, "Mismatch", Mismatch) < 0 || PyModule_AddObjectRef(module, "Grow", Grow) < 0)
        return -1;
    return 0;
}

static PyModuleDef_Slot slots[] = {{Py_mod_exec, exec_module}, {0, NULL}};

static struct PyModuleDef definition = {PyModuleDef_HEAD_INIT, "recompyler._heap", NULL, 0, methods, slots};

PyMODINIT_FUNC PyInit__heap(void) { return PyModuleDef_Init(&definition); }
