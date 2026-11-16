# Future Step4 routes sharing the Step2 descriptor

Preparation only. These are later mechanisms to develop and review, not Step2
acceptance claims or implementation authorization. No workload-specific fast
path is proposed, and create_gc_cycles/its observed output cost is motivation,
not an eligibility predicate.

## C vectorcall entry without a Python delegation floor

A Python Region.__call__ -> attempt -> preparation chain cannot plausibly beat
the same tiny Python field/comparison if that chain remains on every call.
Keep the typed descriptor, numeric/shape/effect guards and audit bank usable
from a C vectorcall entry. An unbound/uncompiled call delegates to the existing
bootstrap path; a valid sealed descriptor dispatches directly through fresh C
layout validation and the native adapter on later calls. Descriptor validity
must be established after any profile event at the actual C-call boundary.
Runtime counters can remain raw in C and materialize Python integers only when
attributes are read outside the atomic interval.

Do not promise a drop-in wrapper solely because it is callable. Preserve the
public Region interface, original function identity, qualified name/source
identity used by the runner, counters, diagnostic attributes, seeds/AOT maps,
subclass hooks and supported monkeypatch behavior. A separate proxy would
change exact type checks and method interception; a C-backed public Region type
or compatible heap subtype must be evaluated against existing tests before
choosing the representation. If an override changes attempt/__call__ or another
assumption, invalidate the fast descriptor and use the authorized dynamic path.
Never secretly bypass a user override. Rebinding/dead weak dependencies likewise
returns to bootstrap; persistent descriptors must not retain unbound classes.

The raw native audit records remain authoritative even if Python attempt is
bypassed. Later C vectorcall completion needs its own explicit public-outcome
record and an independent outer observation path; today's attempt wrappers
cannot be credited with observing it. No Python audit callback is inserted
inside direct execution. Timed calls use the same compiled entry/guards, with
optional audit recording disabled only according to its documented protocol.

Counterexamples: descriptor rebound after class hook installation; profile
c_call mutates a field/detaches its owner; subclasses override attempt; two
wrappers share a generated function but retain distinct canonical call records;
class weakref fires after last instance/binding disappears; exceptions preserve
the same object and do not count a completion. These supplement the trivial
before/after measurement, not substitute for it.

## Native output allocation with explicit observer safepoints

For a region whose mutable graph is entirely newly allocated, bulk arena
execution followed by reconstruction may spend most complete-call time on
output. A general later rule can allocate Python output objects natively and
maintain logical-handle -> actual-object identity from their creation. Exact
plain constructors and metaclasses, known allocation/attribute semantics,
absence of speculative input stores, and explicit publication/observer effects
are proof inputs. Source names and a particular node/list count are not.

A coherent compiler route has four parts:

1. Extend the typed effect IR with allocation/potential-observer operations and
   continuation IDs. Split native work into segments at every operation that
   can expose a collection, signal, finalizer, weakref or other observer. Carry
   exact Python-live references, numeric tokens, partial outputs, exception/
   finally state and control position across each boundary.
2. End a raw-read segment before the observer-capable allocation operation.
   Select only Python-live references and release unrelated raw-read pins/maps.
   Execute the certified CPython allocation/tracking/initialization operation
   with the same observable ordering as its source operation. Do not call
   gc.collect at arbitrary intervals or materialize the entire final graph at
   one checkpoint: both would change observable allocation/collection behavior.
3. After that operation/observer, rebuild and validate fresh mappings from live
   state before another raw segment. A callback may replace layouts, mutate a
   partial output found through gc.get_objects, add a finalizer, capture it in a
   global, or detach a child. No pre-safepoint pointer/type/value assumption
   survives without proof. The native state must reflect callback mutations;
   stale arena data cannot overwrite them during later reconstruction.
4. If a guard fails after observable progress, resume at the exact continuation
   using already-created objects and preserved tokens. Whole-function replay
   would repeat allocations/callbacks and destroy identity. This requires a
   real continuation/deoptimization mechanism, not a normal entry fallback.

The exact allocation/GC checkpoint contract needs installed-CPython source/API
proof. Scheduling GC and actually running it are distinct. A raw PyObject
allocation may schedule an interpreter check without immediately dispatching
it; manually forcing a collection is not equivalent. If a certified native
checkpoint cannot reproduce the necessary operation, execute that source
operation through a real resumable interpreter boundary, then rebuild state.
The continuation mechanism and checkpoints are work to build, not an assumed
existing facility.

An observer may publish a previously private tracked object by discovering it
through gc.get_objects. From that boundary onward, treat it as possibly shared.
Source-ordered native updates to that object can remain valid only with a
committed-prefix/continuation proof; arbitrary speculative mutation followed by
replay is unsound. New graph cycles and alias identity must exist at the points
Python would create them, including partially initialized objects that a
collection could inspect.

For regions that mutate input objects, a journal cannot remain speculative
across an observer. A later design needs source-correct transaction cuts and
continuations: either commit the exact prefix before the observer or prove the
observer cannot see the affected state. Never publish speculative input stores
or discard already-visible stores on whole-function replay. This extension is
separate from Step2's read-only interval and from its current status fallback.

Counterexamples to stage before implementation:

- A GC callback counts/records newly tracked nodes and list contents at several
  allocation points; one final bulk reconstruction changes the trace.
- GC captures a new node, mutates a field/next link, and later native reads must
  observe it. The returned graph preserves that very captured object's identity.
- GC installs __del__ and detaches a partially built child; finalization occurs
  at the source-equivalent reference drop, with no extra retained pin.
- Allocation/guard failure after the observer resumes a finally/exception path
  once, without repeating prior allocations or callbacks.
- A cyclic output is held by a weakref/observer and then collected; exact node
  aliases, cycle links and lifetime match the original function.
- A mutating-input version has an observer between two stores; it observes the
  committed prefix exactly once, never an uncommitted journal or duplicate
  whole-function replay.

The expected future benefit is reduced Python reconstruction/delegation work.
No speedup, preserved-GC proof, backend reach or stage completion is claimed.
