# Numeric allocator capability: local static preparation

No Python interpreter, product module or DLL function was imported or invoked.
Only installed-header reads, PE metadata reads and static llvm-objdump inspection
were used. No allocator was changed. This is future journal/allocation design,
not direct-store activation or proof of the current runtime allocator setting.

## Concrete installed evidence

Inspected DLL: C:/Python314/python314.dll, SHA-256
A07F7D09C3121492BB066535C6D0811DF5FBC2090CBCA7031A97BB47CE1480C9.

internal/pycore_pymem.h declares _PyMem_GetCurrentAllocatorName with PyAPI_FUNC,
for shared-extension use, returning NULL for an unknown configuration. The DLL
exports it. Its observed wrapper is saved in allocator-name-wrapper-static.txt;
the comparison helper is in allocator-name-comparison-static.txt. Numeric code
locations in those excerpts are evidence for this binary only, never constants
to copy into generated code or a runtime capability test.

The internal helper builds default allocator tables and compares complete
40-byte PyMemAllocatorEx records in this 64-bit build: ctx plus malloc/calloc/
realloc/free for RAW, MEM and OBJ. Its debug branches also compare the wrapped
underlying allocator tables. Observed constant return names are malloc,
pymalloc, mimalloc and their _debug variants; mismatch returns NULL. Thus it
provides materially stronger evidence than treating whatever PyMem_GetAllocator
returns at extension import as a trusted default. A custom wrapper installed
before import is not made trustworthy merely by being the initial observation.

Two limitations are proven by local inspection:

1. The exported name getter takes the runtime allocator mutex. Its contention
   path calls _PyMutex_LockTimed with flag 1. Installed pycore_lock.h explicitly
   defines that flag as _PY_LOCK_DETACH, permitting GIL release. Therefore it
   must run before ANY graph borrow/pin/raw mapping, never as the final in-
   interval layout guard. PyObject_GetArenaAllocator has the same detach-capable
   lock wrapper in this DLL.
2. The name-comparison helper checks standard/debug RAW/MEM/OBJ tables but not
   the separate PyObjectArenaAllocator. Installed pycore_runtime_structs.h and
   cpython/objimpl.h define that independent ctx/alloc/free tuple. A custom
   arena hook can remain reachable under a recognized pymalloc configuration.
   A recognized name alone is insufficient.

internal/pycore_pymem_init.h supplies the actual default arena initializer:
NULL context with _PyMem_ArenaAlloc/_PyMem_ArenaFree. Those two callback names
were not found in this DLL's exports. The public arena getter returns current
pointers, not an authoritative default identity. Do not turn its first returned
tuple into a default certificate. A future positive arena check needs a proved
source/build-linked identity for these defaults, with header-derived layout
facts. Static image initialization/symbol provenance is a route to investigate,
not an already implemented or verified resolver. A naturally configured malloc
path may avoid arena callbacks, but must have its own allocator call-graph proof;
never change the user's configuration to make that path eligible.

The installed source tree contains relevant headers, not the allocator C source
implementation. The static disassembly supports the bounded comparisons above;
complete allocator/lifetime/concurrency certification still needs source/API
review plus controlled activation evidence. No current runtime name was read.

## Ordering and bounded no-allocation interval

Candidate ordering for later numeric journaling:

1. Before any nested input ownership, obtain the allocator capability facts.
   These getters may detach, so this remains outside the atomic interval.
   Prove the recognized standard/debug configuration AND reachable arena path.
2. Before graph borrowing, preallocate raw journal/token capacity and unique
   numeric boxes needed by a statically bounded attempt. Arithmetic stores use
   those objects only after the fresh C walk. Preallocation itself requires the
   positive capability at the time of allocation; it cannot call custom hooks
   earlier than the corresponding original Python operation would.
3. Resolve/walk/pin the live graph and validate layout after all possible
   observers. Inside the interval use only existing box refs, checked raw
   capacity, header-derived numeric decoding and mutation of unpublished unique
   prepared numeric boxes. No allocator/getter/free call is permitted there.
   Capacity exhaustion takes a checked status; it does not grow tables/boxes.
4. End raw reads/publication scope and release non-result pins in the certified
   order before any observer-capable cleanup. Unused prepared-box release and
   old-value retirement need the same allocator/free lifetime audit as creation.

For int64, derive maximum digit capacity as ceil(64/PyLong_SHIFT), not a copied
three-digit constant. Prepare non-cached uniquely owned PyLong objects with
that capacity, then set digits/sign/size through installed-header definitions
only while unpublished and uniquely owned. Float boxes have analogous unique
ownership. Never mutate cached small-int/bool objects or an Existing input box;
canonical results use the actual cached references, and one shared producer
still maps to one token/box. Two fresh noncanonical producers need distinct
boxes even when equal. Special allocation/forwarding shortcuts must follow the
producer certificate, not generic numeric equality.

No claim is made that a preallocation count inferred from one sample is a bound.
Loops/recursion need a checked dynamic budget and replay/continuation proof.
Allocation failure before raw reads must preserve application behavior; output
or retired-value cleanup must not run unknown hooks while a journal is active.

## Concurrency and remaining proof

An earlier capability observation does not authorize later allocations. The
name and arena getters release their mutex, and native extensions may mutate
allocator tables independently of Python bytecode. Do not assume the GIL alone
freezes those tables. A candidate has to prove legal external setter exclusion
or provide an audited synchronization protocol spanning every affected
allocation/free, with no lock-order deadlock and no GIL release during the raw
interval. Holding the allocator mutex across allocation is NOT assumed safe:
allocator and debug-helper call graphs could reacquire it.

The stronger no-allocation interval avoids needing to authorize in-interval
allocation at all, but does not retroactively prove speculative preallocation
or later free semantics. Unknown custom/arena/tracemalloc/debug behavior must
select a computed arena/Python path, and the positive capability work remains
an explicit mechanism to complete. Untracked numeric allocation is not presumed
inert merely because it cannot trigger cyclic GC.

Counterexamples for later controlled tests (none executed): a custom RAW/MEM/OBJ
wrapper installed before extension import; default domain tables with a custom
arena allocator; known debug wrappers around a custom underlying allocator;
a c_call observer changing allocator configuration before fresh entry; native
setter concurrency; early-preallocation hook counts; capacity exhaustion with
no allocation after pinning; and same/different numeric producer identities
across small-int canonical boundaries, int64 extremes and float results.
