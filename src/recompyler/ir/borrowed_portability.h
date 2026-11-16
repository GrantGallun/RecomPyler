/* CPython internals copied under tools/borrowed/cpython-3.14.4/LICENSE. */
#pragma once
#ifndef Py_BUILD_CORE_MODULE
#define Py_BUILD_CORE_MODULE
#endif
#include <Python.h>
#if PY_VERSION_HEX != 0x030e04f0 || defined(Py_GIL_DISABLED) || defined(Py_DEBUG) || defined(Py_TRACE_REFS)
#error Borrowed internals require release GIL-enabled CPython 3.14.4
#endif
#include "internal/pycore_freelist.h"
#include "internal/pycore_object.h"
/* Same GC operation through the exported function, avoiding private symbols. */
#undef _PyObject_GC_TRACK
#define _PyObject_GC_TRACK PyObject_GC_Track
