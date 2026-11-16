# CinderX simplification checklist

Studied source: `reference/cinderx/cinderx/Jit/hir/simplify.cpp` at f3dc0e8 (MIT, Meta). Names below identify upstream functions, not a promise that copying a rewrite preserves this project's stricter lifetime/frame requirements. Every row is a **candidate**: no measured bound, gain, reach or deployment is claimed.

| Family / upstream function | Fact and its source | Candidate emitted form | Remaining proof before activation |
|---|---|---|---|
| `simplifyCheck`, `simplifyGuardType`, `simplifyRefineType` | Dominating non-null or type proof | Reuse operand / remove redundant check | Preserve proof dependencies and deopt snapshot; optional `type_guard` query now available |
| `simplifyGuard`, `simplifyCondBranch` | Proved constant predicate | Keep only reachable edge | Source exception state, CFG phi/ownership repair; distinguish unreachable from false |
| `simplifyCheckSequenceBounds` | Exact tuple length and exact constant index | Normalize negative index, omit proved bounds check | No `__index__`, correct source IndexError and owner retirement; optional index query now available |
| `simplifyIsTruthy` | Exact immutable scalar literal or stable exact-container length | Constant bool / direct length test | Keep type proof; never call user `__bool__` during compile; numeric/None literal query now available |
| `simplifyCompare`, `simplifyLongCompare`, `simplifyUnicodeCompare` | Exact operand types or safe constant literals | Exact-type comparison helper | NaN, signed zero, huge ints, reflected dispatch, original exception PC |
| `simplifyLoadTupleItem`, `simplifyLoadArrayItem`, `simplifyLoadVarObjectSize` | Exact shape, valid bounds, stable container | Borrowed element/size read | Borrow support invalidation across callbacks; no pinned cached application value |
| `simplifyLoadMethod`, `simplifyLoadAttr*`, `simplifyLoadField` | Watched type/descriptor identity plus exact layout | Cached method/field access | Descriptor semantics, inherited type invalidation, lifetime, post-callback guard |
| `simplifySubscript`, `simplifyStoreSubscr` | Exact tuple/list/dict/string plus index/key proofs | Exact container helper | Slice/index/key callbacks, mutation and decref order; no negative-index guess |
| `simplifyBinaryOp`, `simplifyInPlaceOp`, `simplifyUnaryOp` | Exact builtins, proved range or helper contract | Long/float/string helper | Unbounded int result, CPython result type incl complex power, inplace/reflected dispatch; no algebraic float reassociation |
| `simplifyIntBinaryOp`, `simplifyPrimitiveUnaryOp`, `simplifyPrimitiveCompare`, `simplifyPrimitiveConvert` | Primitive width/sign and range proofs | Native arithmetic / comparisons | Overflow/zero checks and deopt before wrong result; boxed/native types stay disjoint |
| `simplifyPrimitiveBox`, `simplifyPrimitiveBoxBool`, `simplifyUnbox` | Exact matching representation and scalar constant | Constant materialization / box-unbox forwarding | Exact numeric type/value and allocation failures; don't remove an observable owner or overflow check |
| `simplifyCallMethod`, `simplifyVectorCall*`, `simplifyTypeCall`, `simplifyGetAttrStr` | Preloaded exact callee and full argument map | Direct exact helper or inline candidate | Function/code/default watcher guards, original frames, argument retirement, callback effects; mapper/cost plan now available |
| `simplifyIsCompactLong`, `simplifyIsNegativeAndErrOccurred`, `simplifyCIntToCBool` | Proven compact integer or exact status contract | Cheaper predicate | Preserve pending exception and distinguish NULL sentinel from Python None |

Consumers must re-run type/effect/ownership dataflow after graph changes. A removed operation cannot silently retire an object earlier, move a finalizer later, replay an effect, hide a frame or replace an original traceback PC. The generic canonical helper is the fallback whenever the complete fact is absent.
