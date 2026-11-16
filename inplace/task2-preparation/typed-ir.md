# Typed effect IR and numeric-origin schema

Status: preparation design only; no product source has been changed or executed.
This schema is the concrete contract for `direct.py`, checked generation, R8
substitution, the runtime certificate, and draft analysis tests.

## Stable identifiers

Use deterministic program-local integer IDs in source/metadata. Never serialize
`id(object)`, process addresses, source-spelling equality, or an AST object's
memory address as a persistent semantic identifier.

```python
FunctionId = int      # stable traversal index plus original-source identity seal
BlockId = int         # structured CFG block
OpId = tuple[int, int]       # FunctionId, stable checked-op ordinal
ValueId = tuple[int, int, tuple[int, ...]]  # function, definition, leaf path
FamilyId = int        # canonical program.family root, renumbered after settle
ListCellId = int      # canonical _find(cell), renumbered after settle
AllocationId = tuple[int, int]  # function, allocation-op ordinal
```

The serialized identity of a function also seals its original origin/code
identity, specialization and clone context. Compilation-scoped records may temporarily retain actual class/function/code
objects. Persistent schemas use primitive dependency IDs and no-callback weak
dependencies unless an object is naturally rooted by the original callable.
All runtime pointers are resolved/pinned anew inside the fresh C walk; see
class-lifetime.md for the existing Program/global-cache retention prerequisite.
`FamilyId` and `ListCellId` are assigned only after type unification stabilizes.

## Exact checked-operation records

The pseudocode below specifies fields, not yet implementation:

```python
@dataclass(frozen=True)
class Leaf:
    path: tuple[int, ...]       # tuple/optional structural leaf, not raw code index
    kind: str                  # exact INT/FLOAT/BOOL/MIXED
    payload_parts: tuple[int, ...]
    presence_part: int | None   # optional nullable representation
    # MIXED's payload_parts contains payload and tag; there is ONE identity node.

@dataclass(frozen=True)
class SourceSite:
    function: FunctionId
    ast_path: tuple[str | int, ...]
    span: tuple[int, int, int, int]  # absolute lines/UTF-8 columns in original code
    bytecode_offsets: tuple[int, ...]
    context: tuple              # inlining/specialization/clone substitution

@dataclass(frozen=True)
class OriginRoot:
    category: str              # parameter/global/allocation/unknown
    key: int | AllocationId
    family: FamilyId | None
    list_cell: ListCellId | None

@dataclass(frozen=True)
class Place:
    roots: frozenset[OriginRoot]
    family: FamilyId | None
    field: str | None
    list_cell: ListCellId | None
    selector: tuple            # ('any',), ('constant', index), proven affine form
    leaf: tuple[int, ...]
    topology: tuple            # finite access path or widened wildcard

@dataclass(frozen=True)
class CheckedOp:
    id: OpId
    block: BlockId
    opcode: str
    site: SourceSite | None
    defs: tuple[ValueId, ...]
    uses: tuple[ValueId, ...]
    result_layout: tuple[Leaf, ...]
    place: Place | None
    callee: FunctionId | None
    argument_binding: tuple    # formal leaf -> actual ValueId/Place
    control_edges: tuple      # predecessor/edge -> selected value for a phi
    helper: str | None
    failure: str | None        # overflow/bounds/divzero/depth/capacity/etc.
    ownership: str             # borrowed-input/private-arena/result-only/none
    attributes: tuple         # opcode-specific immutable data
```

`opcode` is a closed enumeration: parameter, existing_constant,
existing_global, existing_default, move, phi, load_numeric, store_numeric,
load_reference, store_reference, alloc_record, alloc_list, list_copy,
list_slice, list_repeat, list_resize, builtin_numeric, numeric_unary,
numeric_binary, comparison, call, return, checked_exit, array_read,
array_write, rng, observer, unknown. A newly encountered operation is
`unknown` until a transfer/effect rule is supplied.

`FunctionIR` contains parameter/result leaf layouts, blocks/successors,
operations, logical memory classes, source bindings, guarded origins and typed
allocation records. It extends or sits alongside `escape.FunctionIR`; it does
not infer pointer origins from arbitrary numeric arithmetic. The existing F2
summaries are reused where they already prove origins/escape.

Raw generated accesses also receive a `StorageRole`: numeric payload,
MIXED tag, optional flag, record type tag, object/list handle, list length,
list capacity, list data handle, status/control, or opaque bytes. This role is
required to distinguish an integer value from a float bit-copy or a pointer-like
arena handle. A source F/I load without a known role is not rewritten live.

## Effect summaries and fixed point

```python
@dataclass(frozen=True)
class EffectSummary:
    reads: frozenset[Place]
    writes: frozenset[Place]     # replacements, regardless of numeric equality
    topology: frozenset[Place]   # resize, shape/link/key-set mutation
    escaped_values: frozenset[ValueId]
    returned_origins: frozenset[OriginRoot]
    helpers: frozenset[str]
    observers: frozenset[str]
    arrays_read: bool
    arrays_written: bool
    rng: bool
    recursive: bool
    private_allocation: bool
    checked_failures: frozenset[str]
    unknown: frozenset[OpId]
```

Effects form a finite union lattice. A function summary substitutes formal-root
places with actual-root places at each call; it unions all possible dispatch
targets and every reachable branch, including loop-carried states. Worklist
iteration over recursive SCCs continues until no set widens. Recursive path
growth widens at a repeated family/list-cell path segment to a wildcard; it must
not silently truncate a path to no effect. Unknown callees/operators/helpers
widen to unknown/observer/topology for their reachable reference arguments.

Record families and list cells are canonicalized before comparison. Distinct
parameter roots are NOT automatically disjoint: without a proven/guarded
disjointness fact they may alias through every field/tuple/list path. The first
implementation may conservatively block every matching family/field or
canonical list cell on any may-write. Private allocation origins proven
non-aliasing by F2 do not contaminate input writes. This matters when a region
constructs/mutates a temporary of the same class it reads from its input.

A more precise later eligibility step can resolve root-based may-writes to
physical locations during the fresh C walk, canonicalize aliases there, and
borrow only non-intersecting slots. An unknown selector means the whole list
content; no speculative element-specific disjointness is inferred from a
sample index.

Stable layout and effect freedom are separate certificates. A numeric value can
fit an INT/FLOAT shape while its owner has a descriptor or callback-capable
access path. Conversely a pure helper can receive an unsupported shape. Both
conditions must pass.

## Producer association before and after R8

A `Producer` describes semantic object origin, independently of numeric payload
lowering:

```python
@dataclass(frozen=True)
class Producer:
    value: ValueId
    site: SourceSite
    rule: str      # existing/forward/select/independent/deferred-exact/unsupported
    operands: tuple[ValueId, ...]
    exact_kinds: tuple[str, ...]
    original_constant: tuple[FunctionId, int] | None
    opcode: str | None
    box_recipe: str | None
    certified_no_python: bool
    certified_bounded_work: bool
    certified_no_pending_calls: bool
    certified_no_observing_allocation: bool
```

Original bytecode positions are consulted BEFORE classifying a source expression
as arithmetic. If CPython folded the expression to a LOAD_CONST covering the
expression span, its producer is `existing_constant` referring to that exact
original `co_consts[index]`. For example source `1.25 + 2.5` and
`-9007199254740993` can be constant loads, not dynamic arithmetic producers.
The test compares returns with the original Python function across calls.

Use `dis.get_instructions(original_code, adaptive=False)` and each instruction's
positions; offset the source AST's dedented coordinates to original positions.
Include nested/inlined source context in the mapping. Validate exact kind and
numeric bits/value when associating a constant, but do NOT choose an origin
merely because another constant compares equal. Multiple candidate constants
are allowed only when they are the same actual object and every candidate
position represents the same expression's value. Otherwise emit the concrete
`ambiguous-original-constant` direct decline. Synthesized AST constants used for
globals/defaults keep their distinct origin tags and do not enter this search.

Each semantic node has a stable emitted binding:

```python
EmittedBinding(
    op_id, value_id, role,
    statement_path, expression_path,
    variable_name_or_slot, source_fingerprint)
```

Do not rely solely on custom AST attributes across string round-trips. Introduce
a typed-tree snapshot carrying `source` plus deterministic binding paths. Parse
source once, bind/check each path and role, and attach semantic IDs to AST nodes.
`copy.deepcopy` preserves them. Every R8 rewrite emits an explicit
`ScalarSubstitution` and transfers annotations to its replacement nodes:

```python
ScalarSubstitution(
    original_allocation, clone_context,
    memory_leaf_to_scalar,       # (origin, space, offset, leaf) -> ValueId/name
    formal_to_actual_leaves,
    return_leaf_map,
    mutation_leaf_map,
    original_callee_to_clone)
```

Specific R8 changes:

- `virtual` associates each numeric field leaf with its payload/tag scalar names
  and semantic memory origin. MIXED still has one token origin.
- `visit_Subscript` maps the old typed field use to the new scalar Name and
  records the value/memory substitution, rather than discarding it.
- `clone` creates a new context identity while retaining each producer's original
  SourceSite and original code-constant reference; new scalar formal names map
  to original parameter field leaves.
- `Lower.call` records both ordinary result and mutation-return substitutions.
  A fresh-return clone maps every demanded returned virtual field.
- `visit_Return` remaps demanded leaves in returned values and appended updates.
- `checked_lower` currently caches only unparsed source in a Fact. Its direct
  metadata payload must instead cache a typed-tree snapshot and verify bindings
  when restored. Final `info.source` and `info.direct_ir` are saved together.

After R8, reconstruct/revalidate all bindings and solve demand again on the
substituted graph. Every demanded numeric use must have exactly one transfer
rule; every demanded definition must have a producer. A lost/orphaned annotation
is a checked direct decline with its site, not a guessed origin. Only then emit
numeric tokens/live reads. This protects R8 pattern matching and makes metadata
loss auditable.

Demand roots are entry numeric result leaves, numeric leaves of escaping output
graphs, stores into escaping inputs, and supported identity observations. Move,
phi, memory and call edges propagate demand. Independent certified producers
stop operand demand. Deferred exact recipes demand only the operands they need.
Clone hidden-argument counts are computed from this fixed point, not from the
number of scalar parameters.

## Native adapter certificate and binding API

The descriptor must contain more than function type information:

```python
AdapterCertificate(
    version, compiled_source_sha256, compiled_headers_sha256,
    python_header_fingerprint, pointer_width, endian,
    source_digest, direct_plan_digest, adapter_signature,
    argument_layout, result_layout, context_field_offsets,
    borrowed_arrays,             # null meminfo and parent; no reflection
    native_result_ownership,     # raw scalars/handles/token IDs only initially
    nrt_calls, nrt_owned_results, # enumerated, never assumed absent
    static_exception_sites,
    dynamic_exception_policy,    # reject initially or explicit raw cleanup
    helper_effects,
    callbacks=False, releases_gil=False, pending_call_checks=False)
```

Use a concrete binding entry point:

```python
_native.direct_bind(capsule, expected_abi, expected_source_digest, owner)
    -> DirectEntry
```

It validates capsule name/version, ABI fields and source/plan identities in C
before creating a callable descriptor. `owner` pins the actual compiled module
or linked JIT libraries/environment. Mismatch raises the native Mismatch used
by preparation to select ordinary arena execution. The draft ABI test perturbs
the expected version at this production binding boundary, asserts binding was
actually attempted, and verifies ordinary compiled fallback still succeeds.

The adapter's actual lowered return values must contain only scalar payloads,
logical handles and token IDs for this initial rule. Native array/record
ownership, reflected values and arbitrary meminfo destructors are unsupported
unless named in a cleanup certificate. On Numba status failure, inspect
exception kind before touching its pointer. Static descriptors need no dynamic
free. Dynamic exception buffers must be rejected by certificate or freed by an
audited bounded raw cleanup path; do not leak them or reconstruct Python
exceptions before releasing raw-read state.

An exact builtin C numeric operation can still allocate, do unbounded work or
check pending calls/signals. No recipe gets callback-free status merely because
operand types are exact. Prefer retaining operand token references and forcing
`deferred-exact` recipes after all raw reads stop. If a recipe must run inside
the interval, require explicit bounded-work, no-pending-call and allocator
certificates. Generic large-integer power is not covered by an int64 label on
its operands. Custom allocation hooks likewise cannot be waved away as inert.

## Backend reach

The initial implementation targets `heap.Region`. FFT's selected kernel
currently uses `lift.py/AotLifted`, so a heap direct-read mechanism cannot be
credited with FFT boundary removal. Preserve both existing backends. Reports
must give backend-specific direct-site/direct-call reach; later shared
direct-store ABI work must explicitly integrate lift if FFT coverage is claimed.

## Test status

All metadata APIs above are proposed and unimplemented. New test files remain
under `inplace/task2-preparation/`; no tests/builds or syntax checks ran.
`test-eligibility.md` separates source-inspected current rejection from required
new direct execution. No claim of current pass/fail behavior is inferred from
static inspection alone.


## Header-derived inline load ABI

The following immutable value records are exported by the compiled extension;
all offsets, alignments, sizeof values and masks are obtained by compiling the
installed headers. They are examples of required fields, never copied constants:

```python
DirectABI(
    version, compiled_source_sha256, compiled_headers_sha256,
    python_version_hex, soabi, pointer_bits, byteorder, gil_disabled,
    object_layout=(ob_type_offset, pointer_alignment),
    float_layout=(ob_fval_offset, double_size, double_alignment),
    long_layout=(tag_offset, digits_offset, digit_size, digit_alignment,
                 digit_bits, sign_mask, size_shift, sign_encodings),
    slot_layout=(stride, physical_cell_offset, pinned_box_offset,
                 numeric_kind_offset, token_offset),
    context_layout=(size, alignment, slot_map_offset, slot_count_offset,
                    raw_token_table_offset, status_offset, audit_bank_offset),
    supported_layout_kinds, supported_numeric_kinds)
```

The Python descriptor stores only serializable facts and hashes. Actual map,
cell, box and helper pointers arrive through the current invocation's C context.
`direct_bind` requires exact ABI/source/plan compatibility before a descriptor
can become callable. Every direct source/AOT digest incorporates this ABI; old
artifacts must choose ordinary execution when the current extension disagrees.
The ordinary arena digest remains independent.

A live slot holds the actual PyObject** storage address discovered during the
fresh C walk, its retained owner/value, validated exact numeric kind, and token
ID. Inline LLVM code bounds-checks/selects the slot map, loads that physical
cell, and directly decodes the value using the validated ABI facts. An absent
live entry takes the existing F/I path. Float loads and bounded PyLong digit
loads are inline instructions, with no per-use Python/C or indirect-C boundary.
Magnitude arithmetic is unsigned, with a checked separate sign conversion for
INT64_MIN. MIXED loads one box into one SSA value and derives both parts/token
from that same value. Initial range validation occurs inside the fresh C walk;
the read-only interval admits no mutation that could invalidate it.

A cache of the pinned box instead of physical-cell dereference is sound only
for this proven read-only step. Future direct stores must refresh that cache or
switch to physical cells before publication. Physical cells also provide the
future alias-journal key, subject to canonicalization across every path. Avoid
invariant-load/TBAA/noalias claims that could make later alias-visible writes
invisible to live loads. Step2 does not activate or simulate those stores.

`native-build-proof.md` defines current-source verification after compilation.
A Python manifest alone is insufficient evidence: the compared source hash must
be an actual constant in the loaded extension. Likewise layout facts must come
from compiled offsetof/sizeof expressions, not an independently guessed Python
layout table.
Native audit fields have a separate versioned raw-record ABI, described in
native-entry-audit.md. C/LLVM prologue, raw status and cleanup events are distinct
from independently observed complete-call success. No counter event retains
arguments, classes, numeric boxes or exceptions, and no Python event occurs
inside the raw-read interval.