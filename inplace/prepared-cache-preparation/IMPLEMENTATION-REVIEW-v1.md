# Independent implementation review — first pass

Reviewer: independent prepared_review agent; read-only review, no code edits or executions. Status: REQUEST CHANGES.

Confirmed blockers:

1. Fingerprinting precedes live identity snapshot attachment. A mutation between them can become the accepted guard. Capture identities first, validate, then require the same identities.
2. Broad `t.__module__ == 'builtins'` class-value classification accepts unrelated mutable class values; whole-class snapshots then retain them and delay finalizers/weakrefs. Type metadata reads on unsupported types can invoke hostile metaclass hooks. Use exact safe value/descriptor allowlists and hook-free primitive misses.
3. Bound MethodType values lack executable __func__ identity. Writable module/qualified names can disguise a replacement random.randrange while Random's actual class methods stay unchanged. Close over exact method function fingerprints and owner aliases.
4. Keys/recipes read globals' __builtins__, while Python executes fn.__builtins__. Fingerprint/resolve the actual function table and preserve namespace alias relations.

Additional explicit proof gap: substitution of another artifact's same-named pycc export during first native-module import is not covered by checks of builtin type/name/module or later-open identity snapshots. Prove native wrapper/Closure ownership or test and close the first-import observer boundary before acceptance. This is a review gap, not a reproduced defect yet.

The implementer has staged separate fail-first observer/review tests. No independent approval, cache timing or Step0 acceptance follows from this first pass. Later review must inspect the fixes and their raw red/green receipts.
