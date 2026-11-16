# Independent preactivation guard and journal review

Read-only review by prepared_review, no executions or edits by reviewer. Step0 is still pending; this is design preparation, not activation or acceptance of Steps2?3.

The common raw JIT/AOT adapter plus fresh callback-free C graph walk is the right invariant. Start with pure reads of exact numeric list items and ordinary fields, returning Existing numeric/object references, bool or None. Fixed preallocated capacity and checked fallback establish an end-to-end slice without in-interval numeric boxing. A list-only skeleton is not full Step2 acceptance.

Required broader implementation: preserve typed load roles across helpers/R8; remove persistent class pins from the complete Program/cache/_ESCAPES/adapter/diagnostic closure; nonmaterializing managed-inline/split/combined reads; certify native return/NRT/exception cleanup and no GIL/pending-call/callback paths. The older materialization wording was corrected in DIRECT-DESIGN and design-refinement to match the refined C interval.

Original-operation allocation observability also needs an explicit certificate: deferring a box after raw reads alone does not preserve a custom allocator callback which could mutate a later input. Example t=c.x+1.0 followed by a read of c.y. No blanket independently-boxable arithmetic permission is inferred.

For the first journal development slice, forward Existing numeric references into fixed list/member slots, with entry guards proving old/new boxes remain naturally rooted by unchanged original arguments. Fixed-capacity canonical first-write journaling can preserve alias and repeated-write rollback with no zero refcount retirement. This is not full Step3 acceptance. General fresh boxes/arbitrary old values require allocator/arena/concurrency/retirement proof; dictionaries need watcher/metadata/GC/storage-transition proof. Cached Step2 boxes must become live-cell reads before stores. Every failure rolls back before native exception reconstruction, replay or any observer.

These are concrete mechanisms to build and review, not missing-proof closures. Actual direct success counters, lifetime/failure cases, full acceptance and achieved/bound evidence remain outstanding.
