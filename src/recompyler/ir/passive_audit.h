#ifndef RECOMPYLER_PASSIVE_AUDIT_H
#define RECOMPYLER_PASSIVE_AUDIT_H
#include <Python.h>
#define RC_PASSIVE_AUDIT_CAPSULE "recompyler.PassiveAttributeAudit.v1"
/* Trusted native-only capability. This exact observer never handles attribute
 * read audit events and never calls Python for them. The constructor supplies
 * it directly to the canonical native guard provider; no Python factory exposes
 * it or allows arbitrary callback addresses to be registered. */
typedef struct {
    int version;
    Py_AuditHookFunction hook;
    void *user_data;
} RcPassiveAttributeAudit;
#endif
