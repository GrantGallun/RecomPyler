#ifndef RECOMPYLER_IR_ENTRY_INVALIDATOR_H
#define RECOMPYLER_IR_ENTRY_INVALIDATOR_H
#include <Python.h>
#define RC_ENTRY_INVALIDATOR_CAPSULE "recompyler.ir.EntryInvalidator.v1"
typedef struct {
    int version;
    int (*accepts)(PyObject *entry);
    void (*invalidate)(PyObject *entry);
} RcEntryInvalidator;
#endif
