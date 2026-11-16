# S85 boundary preparation

Direct C calls belong at the existing source-frame call barrier. A new provider
can export an identity-guarded borrowed-operand call helper; owner17 retains call
selection and owner18 retains original argument ownership, source PC, pending
checks, recursion/error and cleanup. No alternate compiler or argument binder.

The guard holds only a weak reference to the observed exact builtin function.
A live callable operand pins its own C function/self while the guard is checked.
A dead weak target or identity mismatch takes ordinary vectorcall at the same
operation. Never pin the observed bound receiver and never use a naked saved id.
Only exact METH_O (one positional argument) and exact METH_FASTCALL (no keywords)
are first candidates. Other flags, custom vectorcall, keywords and arity errors
retain the canonical path. Recursive-call checks match methodobject.c. Observer
admission stays with the canonical source-frame barrier. New tests must show
replacement, closure/finalizer lifetime, errors, callback recursion and no replay.
This component remains experimental until an actual library speed bound wins.

The NumPy adapter extends StructureCalls instead of changing the opcode emitter.
Get/set keep its borrowed operands / new load reference / C-int status contract.
A miss delegates to the already registered structure helper at the same site.
Exact ndarray, one dimension, native dtype, C contiguity, alignment, and in-range
exact Python-int index are checked before raw access. Read produces the actual
NumPy scalar type via PyArray_Scalar; a Python float would be a wrong result.
Unsupported dtype, subclass, view stride, byte order, boolean/huge index and
readonly stores use NumPy's original operation, preserving exact errors/effects.

First stores cover exact Python float to float64 and representable Python int to
int64 only. No conversion callback or failure precedes a generic retry. Pointer,
length, flags and dtype are read at every operation; no raw pointer survives a
Python callback, signal check, mutation or resize. Optional shape hoisting requires
an independent effect/lifetime proof. Aliases are allowed; never assert noalias.

NumPy headers, compiler and packages are already installed. Build an optional
local extension offline. New files own the provider/adapter; shared subscript
selection stays with owner16. An explicit low-level component is not public
installation or a complete-loop speed result. Numeric driver loops need their
own counted execution, separate from NumPy package functions.

S86 GPU work follows those models. Start only with independent pointwise float64
arithmetic, fresh output, no Python objects, no fast-math or fused operations.
Exact scalar dtype/value/bits and original iteration dependencies must hold;
transcendentals and reductions remain CPU until proved. Size selection counts
allocation, transfers, synchronization and copyback, using the ordinary measured
policy. Small arrays stay CPU. Guard miss does not duplicate visible effects.
