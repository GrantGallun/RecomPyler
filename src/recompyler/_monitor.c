/* The per-call path of recompyler.monitor.CallMonitor, in C.
 *
 * The callbacks here are registered with sys.monitoring directly. They keep the
 * timing stacks, the per-function totals, the argument-type signatures, list-reuse
 * counts and the reservoir decisions. Python is called only to decide whether a code
 * object is watched (once per code object), to copy an accepted sample, and to
 * finish a sample when its call returns. See monitor.py for the semantics; the two
 * implementations must agree.
 */
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <math.h>
#include <stdint.h>

#define SCRIPT 0
#define CCALL 1
#define PYCALL 2
#define MAX_SIGNATURES 64
#define MAX_RARE 16
#define LIST_CHECK_CALLS 64
/* Calling one of these returns an object without running its code. */
#define LAZY_FLAGS (0x20 | 0x80 | 0x100 | 0x200)
/* Code states kept in co_extra, tagged with the Core's generation. */
#define STATE_UNKNOWN 0
#define STATE_LIBRARY 1
#define STATE_PENDING 2
#define STATE_OTHER 3 /* not watched; not yet entered from watched code */
#define STATE_FIRST_INDEX 4

static Py_ssize_t extra_index = -1;
static uint32_t generations = 0;

typedef struct {
    long long calls;
    double self_s, cumulative_s, library_s;
    int size, argc, sampling, rare_left;
    long long seen, next;
    double weight;
    uint64_t rng;
    PyObject *names;      /* tuple of argument names */
    PyObject *signatures; /* list of tuples of types */
    long long *counts;
    long long other_signatures, with_lists, reused_lists;
    PyObject *previous_lists;
} Stat;

typedef struct {
    int kind;
    Py_ssize_t index;
    void *ref;    /* code (SCRIPT, PYCALL) or callable (CCALL); identity only */
    void *caller; /* the watched code that made a PYCALL */
    double start, child, library;
    PyObject *pending;
} Entry;

typedef struct {
    unsigned long ident;
    Entry *stack;
    Py_ssize_t size, capacity;
    double off;
    int *active;
    Py_ssize_t active_size;
} Thread;

typedef struct {
    PyObject_HEAD
    uint32_t generation;
    PyObject *disable, *watch, *classify, *capture, *leave;
    double bias;
    Stat *stats;
    Py_ssize_t nstats;
    Thread **threads;
    Py_ssize_t nthreads;
    Thread *last;
} Core;

static inline double now(void) {
    PyTime_t t;
    PyTime_PerfCounterRaw(&t);
    return (double)t * 1e-9;
}

static Py_ssize_t code_state(Core *core, PyObject *code) {
    void *extra = NULL;
    if (PyUnstable_Code_GetExtra(code, extra_index, &extra) < 0) {
        PyErr_Clear();
        return STATE_UNKNOWN;
    }
    uint64_t value = (uint64_t)(uintptr_t)extra;
    if ((uint32_t)(value >> 32) != core->generation) return STATE_UNKNOWN;
    return (Py_ssize_t)(value & 0xffffffffu);
}

static void set_state(Core *core, PyObject *code, Py_ssize_t state) {
    uint64_t value = ((uint64_t)core->generation << 32) | (uint64_t)state;
    if (PyUnstable_Code_SetExtra(code, extra_index, (void *)(uintptr_t)value) < 0) PyErr_Clear();
}

static int ensure_stats(Core *core, Py_ssize_t count) {
    if (count <= core->nstats) return 0;
    Py_ssize_t capacity = core->nstats ? core->nstats : 16;
    while (capacity < count) capacity *= 2;
    Stat *grown = PyMem_Realloc(core->stats, capacity * sizeof(Stat));
    if (grown == NULL) return -1;
    memset(grown + core->nstats, 0, (capacity - core->nstats) * sizeof(Stat));
    core->stats = grown;
    core->nstats = capacity;
    return 0;
}

static Thread *thread_for(Core *core, int create) {
    unsigned long ident = PyThread_get_thread_ident();
    if (core->last != NULL && core->last->ident == ident) return core->last;
    for (Py_ssize_t i = 0; i < core->nthreads; i++) {
        if (core->threads[i]->ident == ident) return core->last = core->threads[i];
    }
    if (!create) return NULL;
    Thread **grown = PyMem_Realloc(core->threads, (core->nthreads + 1) * sizeof(Thread *));
    if (grown == NULL) return NULL;
    core->threads = grown;
    Thread *thread = PyMem_Calloc(1, sizeof(Thread));
    if (thread == NULL) return NULL;
    thread->ident = ident;
    core->threads[core->nthreads++] = thread;
    return core->last = thread;
}

static int push(Thread *thread, Entry entry) {
    if (thread->size == thread->capacity) {
        Py_ssize_t capacity = thread->capacity ? thread->capacity * 2 : 64;
        Entry *grown = PyMem_Realloc(thread->stack, capacity * sizeof(Entry));
        if (grown == NULL) return -1;
        thread->stack = grown;
        thread->capacity = capacity;
    }
    thread->stack[thread->size++] = entry;
    return 0;
}

static int *active_slot(Thread *thread, Py_ssize_t index) {
    if (index >= thread->active_size) {
        Py_ssize_t size = thread->active_size ? thread->active_size : 16;
        while (size <= index) size *= 2;
        int *grown = PyMem_Realloc(thread->active, size * sizeof(int));
        if (grown == NULL) return NULL;
        memset(grown + thread->active_size, 0, (size - thread->active_size) * sizeof(int));
        thread->active = grown;
        thread->active_size = size;
    }
    return &thread->active[index];
}

/* Account for an entry just popped off the thread's stack. */
static void close_entry(Core *core, Thread *thread, Entry *entry, double at) {
    double total = at - entry->start;
    if (entry->kind == SCRIPT) {
        Stat *stat = &core->stats[entry->index];
        stat->self_s += total - entry->child;
        stat->library_s += entry->library;
        int *depth = active_slot(thread, entry->index);
        if (depth != NULL && --*depth <= 0) {
            *depth = 0;
            stat->cumulative_s += total;
        }
        if (thread->size) thread->stack[thread->size - 1].child += total;
    } else if (thread->size) {
        Entry *parent = &thread->stack[thread->size - 1];
        parent->child += total;
        parent->library += total - entry->child;
    }
    Py_CLEAR(entry->pending);
}

static void close_calls(Core *core, Thread *thread, double at) {
    /* Control is back in watched code, so any open call out of it has ended (one
       that failed before its frame started reports nothing). */
    while (thread->size && thread->stack[thread->size - 1].kind != SCRIPT) {
        Entry entry = thread->stack[--thread->size];
        close_entry(core, thread, &entry, at);
    }
}

static double uniform(Stat *stat) {
    uint64_t x = stat->rng;
    x ^= x >> 12;
    x ^= x << 25;
    x ^= x >> 27;
    stat->rng = x;
    double u = (double)((x * 0x2545F4914F6CDD1DULL) >> 11) * (1.0 / 9007199254740992.0);
    return u > 0.0 ? u : 0.5;
}

static void skip_ahead(Stat *stat) {
    double gap = floor(log(uniform(stat)) / log(1.0 - stat->weight)) + 1.0;
    stat->next += gap > 4e18 ? (long long)4e18 : (long long)gap;
}

/* Vitter's algorithm L: the reservoir slot for this call, or -1. */
static long long reservoir_slot(Stat *stat) {
    long long seen = stat->seen, size = stat->size;
    if (seen <= size) {
        if (seen == size) {
            stat->weight = fmin(exp(log(uniform(stat)) / size), 1.0 - 1e-12);
            stat->next = size;
            skip_ahead(stat);
        }
        return seen - 1;
    }
    if (seen != stat->next) return -1;
    stat->weight = fmin(stat->weight * exp(log(uniform(stat)) / size), 1.0 - 1e-12);
    skip_ahead(stat);
    return (long long)(uniform(stat) * size) % size;
}

static int lists_in(PyObject *values, PyObject *out, int depth) {
    Py_ssize_t count = PyTuple_GET_SIZE(values);
    for (Py_ssize_t i = 0; i < count; i++) {
        PyObject *value = PyTuple_GET_ITEM(values, i);
        if (PyList_CheckExact(value)) {
            if (PyList_Append(out, value) < 0) return -1;
        } else if (PyTuple_CheckExact(value) && depth < 2) {
            if (lists_in(value, out, depth + 1) < 0) return -1;
        }
    }
    return 0;
}

static void count_lists(Stat *stat, PyObject *given) {
    PyObject *lists = PyList_New(0);
    if (lists == NULL || lists_in(given, lists, 0) < 0) {
        Py_XDECREF(lists);
        PyErr_Clear();
        return;
    }
    Py_ssize_t count = PyList_GET_SIZE(lists);
    if (!count) {
        Py_DECREF(lists);
        return;
    }
    stat->with_lists++;
    PyObject *previous = stat->previous_lists;
    if (previous != NULL && PyList_GET_SIZE(previous) == count) {
        Py_ssize_t i = 0;
        while (i < count && PyList_GET_ITEM(previous, i) == PyList_GET_ITEM(lists, i)) i++;
        if (i == count) stat->reused_lists++;
    }
    /* Held so their ids cannot be reused. */
    Py_XSETREF(stat->previous_lists, lists);
}

/* Read this call's arguments, count its signature and lists, and capture it if the
   reservoir or a new signature wants it. Returns a new reference or NULL. */
static PyObject *sample_enter(Core *core, Py_ssize_t index) {
    Stat *stat = &core->stats[index];
    stat->seen++;
    PyFrameObject *frame = PyEval_GetFrame();
    if (frame == NULL) return NULL;
    int argc = stat->argc;
    PyObject *given = PyTuple_New(argc);
    if (given == NULL) {
        PyErr_Clear();
        return NULL;
    }
    for (int i = 0; i < argc; i++) {
        PyObject *value = PyFrame_GetVar(frame, PyTuple_GET_ITEM(stat->names, i));
        if (value == NULL) {
            PyErr_Clear();
            Py_DECREF(given);
            return NULL;
        }
        PyTuple_SET_ITEM(given, i, value);
    }
    int found = -1, fresh = 0;
    Py_ssize_t nsignatures = PyList_GET_SIZE(stat->signatures);
    for (Py_ssize_t j = 0; j < nsignatures && found < 0; j++) {
        PyObject *types = PyList_GET_ITEM(stat->signatures, j);
        int i = 0;
        while (i < argc && (PyObject *)Py_TYPE(PyTuple_GET_ITEM(given, i)) == PyTuple_GET_ITEM(types, i)) i++;
        if (i == argc) found = (int)j;
    }
    if (found >= 0) {
        stat->counts[found]++;
    } else if (nsignatures < MAX_SIGNATURES) {
        PyObject *types = PyTuple_New(argc);
        if (types != NULL) {
            for (int i = 0; i < argc; i++) {
                PyObject *type = (PyObject *)Py_TYPE(PyTuple_GET_ITEM(given, i));
                PyTuple_SET_ITEM(types, i, Py_NewRef(type));
            }
            if (PyList_Append(stat->signatures, types) == 0) {
                stat->counts[nsignatures] = 1;
                if (stat->rare_left > 0) {
                    stat->rare_left--;
                    fresh = 1;
                }
            }
            Py_DECREF(types);
        }
        PyErr_Clear();
    } else {
        stat->other_signatures++;
    }
    if (stat->with_lists || stat->seen <= LIST_CHECK_CALLS) count_lists(stat, given);
    long long slot = reservoir_slot(stat);
    if (slot < 0 && !fresh) {
        Py_DECREF(given);
        return NULL;
    }
    PyObject *pending = PyObject_CallFunction(core->capture, "nOLO", index, given, slot, fresh ? Py_True : Py_False);
    Py_DECREF(given);
    if (pending == NULL) {
        PyErr_WriteUnraisable(core->capture);
        return NULL;
    }
    if (pending == Py_None) {
        Py_DECREF(pending);
        return NULL;
    }
    return pending;
}

#define BEGIN double began = now()
#define END(thread) (thread)->off += now() - began + core->bias

/* Library code starting or resuming while a watched frame is on top of the stack was
   entered without a CALL event: an import, an operator or attribute hook, a library
   generator being iterated. Time it as a call out of that frame. */
static void implicit_entry(Core *core, PyObject *code, Py_ssize_t state) {
    BEGIN;
    Thread *thread = thread_for(core, 0);
    if (thread == NULL || !thread->size || thread->stack[thread->size - 1].kind != SCRIPT) return;
    if (state != STATE_LIBRARY) {
        /* Gives the code local PY_RETURN, PY_YIELD and PY_RESUME events. */
        PyObject *watched = PyObject_CallOneArg(core->classify, code);
        if (watched == NULL) {
            PyErr_WriteUnraisable(core->classify);
            return;
        }
        int is_watched = PyObject_IsTrue(watched);
        Py_DECREF(watched);
        if (is_watched) return;
        set_state(core, code, STATE_LIBRARY);
    }
    Entry entry = {PYCALL, 0, (void *)code, thread->stack[thread->size - 1].ref, began - thread->off, 0.0, 0.0, NULL};
    if (push(thread, entry) < 0) PyErr_Clear();
    END(thread);
}

static PyObject *on_start(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    BEGIN;
    PyObject *code = args[0];
    Py_ssize_t state = code_state(core, code);
    if (state < STATE_FIRST_INDEX) {
        if (state == STATE_LIBRARY || state == STATE_OTHER) {
            implicit_entry(core, code, state);
            Py_RETURN_NONE;
        }
        PyFrameObject *frame = PyEval_GetFrame();
        PyObject *found = PyObject_CallFunctionObjArgs(core->watch, code, frame ? (PyObject *)frame : Py_None, NULL);
        if (found == NULL) {
            PyErr_WriteUnraisable(core->watch);
            Py_RETURN_NONE;
        }
        Py_ssize_t index = PyLong_AsSsize_t(found);
        Py_DECREF(found);
        if (index < 0) {
            /* Not watched. It stays enabled: code switched off here could not be seen
               later when watched code enters it without a CALL event. */
            PyErr_Clear();
            set_state(core, code, STATE_OTHER);
            implicit_entry(core, code, STATE_OTHER);
            Py_RETURN_NONE;
        }
        if (ensure_stats(core, index + 1) < 0) {
            PyErr_Clear();
            Py_RETURN_NONE;
        }
        state = STATE_FIRST_INDEX + index;
        set_state(core, code, state);
    }
    Py_ssize_t index = state - STATE_FIRST_INDEX;
    Thread *thread = thread_for(core, 1);
    if (thread == NULL) {
        PyErr_Clear();
        Py_RETURN_NONE;
    }
    double at = began - thread->off;
    core->stats[index].calls++;
    PyObject *pending = core->stats[index].sampling ? sample_enter(core, index) : NULL;
    int *depth = active_slot(thread, index);
    Entry entry = {SCRIPT, index, (void *)code, NULL, at, 0.0, 0.0, pending};
    if (depth == NULL || push(thread, entry) < 0) {
        Py_XDECREF(pending);
        PyErr_Clear();
    } else {
        ++*depth;
    }
    END(thread);
    Py_RETURN_NONE;
}

static PyObject *on_resume(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    Py_ssize_t state = code_state(core, args[0]);
    if (state < STATE_FIRST_INDEX) {
        if (state == STATE_LIBRARY || state == STATE_OTHER) implicit_entry(core, args[0], state);
        Py_RETURN_NONE;
    }
    BEGIN;
    Py_ssize_t index = state - STATE_FIRST_INDEX;
    Thread *thread = thread_for(core, 1);
    if (thread == NULL) {
        PyErr_Clear();
        Py_RETURN_NONE;
    }
    int *depth = active_slot(thread, index);
    Entry entry = {SCRIPT, index, (void *)args[0], NULL, began - thread->off, 0.0, 0.0, NULL};
    if (depth == NULL || push(thread, entry) < 0) PyErr_Clear();
    else ++*depth;
    END(thread);
    Py_RETURN_NONE;
}

static void leave(Core *core, Py_ssize_t index, PyObject *value, int returned) {
    BEGIN;
    Thread *thread = thread_for(core, 0);
    if (thread == NULL) return;
    double at = began - thread->off;
    Py_ssize_t position = thread->size - 1;
    while (position >= 0 && !(thread->stack[position].kind == SCRIPT && thread->stack[position].index == index))
        position--;
    if (position < 0) {
        /* A frame that began before monitoring started. */
        END(thread);
        return;
    }
    while (thread->size > position + 1) {
        Entry entry = thread->stack[--thread->size];
        close_entry(core, thread, &entry, at);
    }
    Entry entry = thread->stack[--thread->size];
    PyObject *pending = entry.pending;
    entry.pending = NULL;
    close_entry(core, thread, &entry, at);
    if (pending != NULL) {
        if (returned && core->stats[index].sampling) {
            PyObject *done = PyObject_CallFunction(core->leave, "nOO", index, pending, value ? value : Py_None);
            if (done == NULL) PyErr_WriteUnraisable(core->leave);
            Py_XDECREF(done);
        }
        Py_DECREF(pending);
    }
    END(thread);
}

static void library_exit(Core *core, PyObject *code) {
    BEGIN;
    Thread *thread = thread_for(core, 0);
    if (thread == NULL) return;
    if (thread->size) {
        Entry *top = &thread->stack[thread->size - 1];
        if (top->kind == PYCALL && top->ref == (void *)code) {
            /* Only the call made from watched code ends it, not a recursive one. */
            PyFrameObject *frame = PyEval_GetFrame();
            PyFrameObject *back = frame ? PyFrame_GetBack(frame) : NULL;
            if (back != NULL) {
                PyCodeObject *caller = PyFrame_GetCode(back);
                if ((void *)caller == top->caller) {
                    Entry entry = thread->stack[--thread->size];
                    close_entry(core, thread, &entry, began - thread->off);
                }
                Py_DECREF(caller);
                Py_DECREF(back);
            }
        }
    }
    END(thread);
}

static PyObject *on_return(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    Py_ssize_t state = code_state(core, args[0]);
    if (state >= STATE_FIRST_INDEX) leave(core, state - STATE_FIRST_INDEX, nargs > 2 ? args[2] : NULL, 1);
    else if (state == STATE_LIBRARY) library_exit(core, args[0]);
    Py_RETURN_NONE;
}

static PyObject *on_yield(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    Py_ssize_t state = code_state(core, args[0]);
    if (state >= STATE_FIRST_INDEX) leave(core, state - STATE_FIRST_INDEX, NULL, 0);
    else if (state == STATE_LIBRARY) library_exit(core, args[0]);
    Py_RETURN_NONE;
}

static PyObject *on_unwind(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    Py_ssize_t state = code_state(core, args[0]);
    if (state >= STATE_FIRST_INDEX) leave(core, state - STATE_FIRST_INDEX, NULL, 0);
    else if (state == STATE_LIBRARY) library_exit(core, args[0]);
    Py_RETURN_NONE;
}

static PyObject *on_call(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    BEGIN;
    Thread *thread = thread_for(core, 1);
    if (thread == NULL) {
        PyErr_Clear();
        Py_RETURN_NONE;
    }
    double at = began - thread->off;
    close_calls(core, thread, at);
    PyObject *callee = args[2], *function = NULL;
    if (PyFunction_Check(callee)) function = callee;
    else if (PyMethod_Check(callee) && PyFunction_Check(PyMethod_GET_FUNCTION(callee)))
        function = PyMethod_GET_FUNCTION(callee);
    Entry entry = {CCALL, 0, (void *)callee, NULL, at, 0.0, 0.0, NULL};
    if (function != NULL) {
        PyObject *called = PyFunction_GET_CODE(function);
        if (((PyCodeObject *)called)->co_flags & LAZY_FLAGS) goto done;
        Py_ssize_t state = code_state(core, called);
        if (state == STATE_UNKNOWN || state == STATE_OTHER) {
            PyObject *watched = PyObject_CallOneArg(core->classify, called);
            if (watched == NULL) {
                PyErr_WriteUnraisable(core->classify);
                goto done;
            }
            state = PyObject_IsTrue(watched) ? STATE_PENDING : STATE_LIBRARY;
            Py_DECREF(watched);
            set_state(core, called, state);
        }
        if (state != STATE_LIBRARY) goto done;
        entry.kind = PYCALL;
        entry.ref = (void *)called;
        entry.caller = (void *)args[0];
    }
    if (push(thread, entry) < 0) PyErr_Clear();
done:
    END(thread);
    Py_RETURN_NONE;
}

static PyObject *on_c_return(Core *core, PyObject *const *args, Py_ssize_t nargs) {
    BEGIN;
    Thread *thread = thread_for(core, 0);
    if (thread == NULL) Py_RETURN_NONE;
    if (thread->size) {
        Entry *top = &thread->stack[thread->size - 1];
        PyObject *callee = args[2];
        /* A Python function reports C_RETURN too when called through a non-default
           vectorcall; its PY_RETURN may then not be seen. */
        if ((top->kind == CCALL && top->ref == (void *)callee) ||
            (top->kind == PYCALL && PyFunction_Check(callee) && (void *)PyFunction_GET_CODE(callee) == top->ref)) {
            Entry entry = thread->stack[--thread->size];
            close_entry(core, thread, &entry, began - thread->off);
        }
    }
    END(thread);
    Py_RETURN_NONE;
}

static PyObject *core_configure(Core *core, PyObject *args) {
    Py_ssize_t index;
    int size;
    PyObject *names;
    unsigned long long seed;
    if (!PyArg_ParseTuple(args, "niO!K", &index, &size, &PyTuple_Type, &names, &seed)) return NULL;
    if (index < 0 || ensure_stats(core, index + 1) < 0) return PyErr_NoMemory();
    Stat *stat = &core->stats[index];
    if (stat->signatures != NULL) Py_RETURN_NONE;
    stat->signatures = PyList_New(0);
    stat->counts = PyMem_Calloc(MAX_SIGNATURES, sizeof(long long));
    if (stat->signatures == NULL || stat->counts == NULL) return PyErr_NoMemory();
    stat->names = Py_NewRef(names);
    stat->argc = (int)PyTuple_GET_SIZE(names);
    stat->size = size;
    stat->sampling = size > 0;
    stat->rare_left = MAX_RARE;
    stat->rng = seed ? seed : 0x9E3779B97F4A7C15ULL;
    Py_RETURN_NONE;
}

static PyObject *core_stop_sampling(Core *core, PyObject *arg) {
    Py_ssize_t index = PyLong_AsSsize_t(arg);
    if (index == -1 && PyErr_Occurred()) return NULL;
    if (index >= 0 && index < core->nstats) core->stats[index].sampling = 0;
    Py_RETURN_NONE;
}

static PyObject *core_stats(Core *core, PyObject *arg) {
    Py_ssize_t index = PyLong_AsSsize_t(arg);
    if (index == -1 && PyErr_Occurred()) return NULL;
    if (index < 0 || index >= core->nstats) return Py_BuildValue("(Lddd)", 0LL, 0.0, 0.0, 0.0);
    Stat *stat = &core->stats[index];
    return Py_BuildValue("(Lddd)", stat->calls, stat->self_s, stat->cumulative_s, stat->library_s);
}

static PyObject *core_sampling(Core *core, PyObject *arg) {
    Py_ssize_t index = PyLong_AsSsize_t(arg);
    if (index == -1 && PyErr_Occurred()) return NULL;
    if (index < 0 || index >= core->nstats || core->stats[index].signatures == NULL) Py_RETURN_NONE;
    Stat *stat = &core->stats[index];
    PyObject *counts = PyDict_New();
    if (counts == NULL) return NULL;
    for (Py_ssize_t j = 0; j < PyList_GET_SIZE(stat->signatures); j++) {
        PyObject *count = PyLong_FromLongLong(stat->counts[j]);
        if (count == NULL || PyDict_SetItem(counts, PyList_GET_ITEM(stat->signatures, j), count) < 0) {
            Py_XDECREF(count);
            Py_DECREF(counts);
            return NULL;
        }
        Py_DECREF(count);
    }
    return Py_BuildValue("(LNLLL)", stat->seen, counts, stat->other_signatures, stat->with_lists, stat->reused_lists);
}

static PyObject *core_offset(Core *core, PyObject *arg) {
    unsigned long ident = PyLong_AsUnsignedLong(arg);
    if (PyErr_Occurred()) return NULL;
    for (Py_ssize_t i = 0; i < core->nthreads; i++)
        if (core->threads[i]->ident == ident) return PyFloat_FromDouble(core->threads[i]->off);
    return PyFloat_FromDouble(0.0);
}

static int core_init(Core *core, PyObject *args, PyObject *kwargs) {
    PyObject *disable, *watch, *classify, *capture, *leave_hook;
    double bias;
    if (!PyArg_ParseTuple(args, "OOOOOd", &disable, &watch, &classify, &capture, &leave_hook, &bias)) return -1;
    Py_XSETREF(core->disable, Py_NewRef(disable));
    Py_XSETREF(core->watch, Py_NewRef(watch));
    Py_XSETREF(core->classify, Py_NewRef(classify));
    Py_XSETREF(core->capture, Py_NewRef(capture));
    Py_XSETREF(core->leave, Py_NewRef(leave_hook));
    core->bias = bias;
    core->generation = ++generations;
    return 0;
}

static int core_traverse(Core *core, visitproc visit, void *arg) {
    Py_VISIT(core->disable);
    Py_VISIT(core->watch);
    Py_VISIT(core->classify);
    Py_VISIT(core->capture);
    Py_VISIT(core->leave);
    for (Py_ssize_t i = 0; i < core->nstats; i++) {
        Py_VISIT(core->stats[i].previous_lists);
        Py_VISIT(core->stats[i].signatures);
    }
    for (Py_ssize_t t = 0; t < core->nthreads; t++)
        for (Py_ssize_t i = 0; i < core->threads[t]->size; i++) Py_VISIT(core->threads[t]->stack[i].pending);
    return 0;
}

static int core_clear(Core *core) {
    Py_CLEAR(core->disable);
    Py_CLEAR(core->watch);
    Py_CLEAR(core->classify);
    Py_CLEAR(core->capture);
    Py_CLEAR(core->leave);
    for (Py_ssize_t i = 0; i < core->nstats; i++) {
        Stat *stat = &core->stats[i];
        Py_CLEAR(stat->names);
        Py_CLEAR(stat->signatures);
        Py_CLEAR(stat->previous_lists);
        PyMem_Free(stat->counts);
        stat->counts = NULL;
    }
    PyMem_Free(core->stats);
    core->stats = NULL;
    core->nstats = 0;
    for (Py_ssize_t t = 0; t < core->nthreads; t++) {
        Thread *thread = core->threads[t];
        for (Py_ssize_t i = 0; i < thread->size; i++) Py_CLEAR(thread->stack[i].pending);
        PyMem_Free(thread->stack);
        PyMem_Free(thread->active);
        PyMem_Free(thread);
    }
    PyMem_Free(core->threads);
    core->threads = NULL;
    core->nthreads = 0;
    core->last = NULL;
    return 0;
}

static void core_dealloc(Core *core) {
    PyObject_GC_UnTrack(core);
    core_clear(core);
    Py_TYPE(core)->tp_free((PyObject *)core);
}

#define FAST(name) {#name, (PyCFunction)(void (*)(void))name, METH_FASTCALL, NULL}
static PyMethodDef core_methods[] = {
    FAST(on_start), FAST(on_resume), FAST(on_return), FAST(on_yield), FAST(on_unwind), FAST(on_call),
    FAST(on_c_return),
    {"configure", (PyCFunction)core_configure, METH_VARARGS, "configure(index, size, names, seed)"},
    {"stop_sampling", (PyCFunction)core_stop_sampling, METH_O, NULL},
    {"stats", (PyCFunction)core_stats, METH_O, "(calls, self_s, cumulative_s, library_s)"},
    {"sampling", (PyCFunction)core_sampling, METH_O,
     "(seen, {signature: calls}, other_signature_calls, calls_with_lists, calls_reusing_lists)"},
    {"offset", (PyCFunction)core_offset, METH_O, "seconds of callback time on a thread's clock"},
    {NULL}};

static PyTypeObject CoreType = {
    PyVarObject_HEAD_INIT(NULL, 0)
    .tp_name = "recompyler._monitor.Core",
    .tp_basicsize = sizeof(Core),
    .tp_flags = Py_TPFLAGS_DEFAULT | Py_TPFLAGS_HAVE_GC,
    .tp_new = PyType_GenericNew,
    .tp_init = (initproc)core_init,
    .tp_dealloc = (destructor)core_dealloc,
    .tp_traverse = (traverseproc)core_traverse,
    .tp_clear = (inquiry)core_clear,
    .tp_methods = core_methods,
};

static struct PyModuleDef module = {PyModuleDef_HEAD_INIT, "_monitor", NULL, -1, NULL};

PyMODINIT_FUNC PyInit__monitor(void) {
    if (extra_index < 0) {
        extra_index = PyUnstable_Eval_RequestCodeExtraIndex(NULL);
        if (extra_index < 0) return NULL;
    }
    if (PyType_Ready(&CoreType) < 0) return NULL;
    PyObject *m = PyModule_Create(&module);
    if (m == NULL) return NULL;
    if (PyModule_AddObjectRef(m, "Core", (PyObject *)&CoreType) < 0) {
        Py_DECREF(m);
        return NULL;
    }
    return m;
}
