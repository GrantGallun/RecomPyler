# S90/S91 current library execution and speed result

All15 workloads now execute native bodies and match independent fresh stock
process digests. The hot sample compiled675/675 attempted functions (100%).
Another1138 observed identities were not attempted: dead owners, colder shared
aliases or the128-function cap are named individually. This sample is separate
from the bounded loaded-package census:5113/5178 attempted (98.74%),
15253 unattempted. No library output mismatch has been observed.

| Workload | Compiled / attempted | Not attempted hot identities | Native entries in32 calls | Fresh stock digest |
|---|---:|---:|---:|---|
|networkx_shortest_paths|9/9|1|224|match|
|networkx_pagerank|51/51|307|16640|match|
|sympy_expand_simplify|125/125|533|89760|match|
|jinja2_render|8/8|0|160|match|
|markdown_convert|109/109|13|10976|match|
|pygments_highlight|14/14|1|1120|match|
|pyparsing_parse|45/45|2|48384|match|
|dateutil_parse|37/37|5|3808|match|
|yaml_load|90/90|0|31872|match|
|jsonschema_validate|22/22|79|14336|match|
|json_encode|5/5|0|32|match|
|difflib_diff|12/12|0|608|match|
|email_parse|125/125|193|13696|match|
|tomllib_load|22/22|4|2976|match|
|numpy_loop|1/1|0|32|match|

All native entries are counted at the actual retained LLVM body. CountedBody
and journal calls are excluded from timing; the reset occurs after the journal
begin event, so JSON logging cannot masquerade as workload execution. Each
workload is checked32 times. Source/function records use weak references and
retain no arguments or frames. Six formerly empty rows now contribute native
entries through actual hot-function identities, generated template/dispatch
functions and the NumPy benchmark driver.

## Ranked entry causes

| Rank | Cause | Evidence |
|---|---|---|
|1|Hot entries retired while seeding cold functions|Bulk Jinja active->inactive at install384; NetworkX shortest316. PageRank retires16 hot entries. All three bulk workloads then execute0 native entries.|
|2|Generated/closure definitions absent from module enumeration|Jinja root executes32 native entries; NetworkX argmap wrappers and wrapped algorithms are now explicit candidates.|
|3|Canonical seed refuses hot simple/property paths|Per-function reports preserve the exact CPython declined frame entry seed exception. Literal Environment.getattr RED is published.|
|4|Driver excluded from package scope|NumPy driver now compiles and executes32 native entries.|

Bulk pyparsing and email also retire4 and47 observed hot entries respectively,
but on current peers retain9664 and1184 native entries. Their historical0 counts
must not be presented as current failures. Targeted installation reaches48384
and13696 respectively. Cold collection is a candidate explanation for the
simultaneous retirement; the native provider does not expose a reason code,
so the exact invalidator is not yet established.

Reproduction: `bench/libs/repro_bulk_entry.py jinja2_render --expect-hot-entry`
and `bench/libs/repro_seed_entry.py`, both with PYTHON_JIT=1. Reports and exact
before/after transitions are in results/bulk-state-*.json. Shared entry code is
unchanged. The one diagnostic review found a repeated-run cleanup defect; its
literal RED was fixed. An additional JSON journal regression failed33 vs32,
then passed after moving the reset. Eight affected tests now pass.

## Delivery, throughput and speed

ACK S89/S90 and new S91. S91 authorizes wave20's narrow fork-only async flag;
wave21 keeps stock defaults and makes no shared entry/lowerer ownership change.
The opt-in import hook, CLI and persistent relocatable object cache accept only
exact artifact-bound hot/verified/fast receipts. Unmeasured bodies remain Python;
representative-call training is still external. Real JSON AOT:22 prepared,
21 portable,0 installed; immutable iterencode feedback declines explicitly.

[All15 workload timings](TIMINGS.md) now include CPython JIT-off and JIT-on,
ordinary native bodies and6 available warm PyPy environments. Every digest
matches. Three alternating development rounds were repeated once under recorded
correctness load. No clear native win over JIT-on; default installation pool0.
Initial email/difflib preparation failures under machine memory pressure are
preserved in paired-s90-all.json; retry and consolidated receipts are separate.
No corresponding library spike exists.

Two locked, instrumented24-function NetworkX chunks compiled24/24 each at
12.00 and10.15 functions/s (334 unattempted each). Repeat exclusive costs per
function: LLVM codegen/link54.3ms, IR lowering19.1ms, MCJIT setup10.3ms,
LLVM parse5.6ms, serialization5.2ms, SSA construction1.3ms, symbols0.8ms.
Instrumentation and concurrent correctness load are recorded; these are
throughput diagnostics, not an optimization win.

## Guarded native library providers

New optional package providers implement weak identity-guarded METH_O/FASTCALL
borrowed C dispatch and exact aligned/contiguous1D float64/int64 ndarray
load/store/length. Misses leave canonical protocols untouched. The shared
StructureCalls adapter executes overlapping array views correctly: one native
body entry and10 raw primitive hits, with byte-identical output. Ten standard
provider tests and38 affected benchmark tests pass. Each capability had one
review; concrete findings were fixed. No new provider is enabled by default.

Canonical CALL needs owner17's borrowed-dispatch hook, preserving method binding,
argument retirement, pending checks and original PC. Public compile_function
needs the agreed StructureCalls factory. Both precise requests are in REQUESTS.
Until those hooks land, providers are explicit shared-lowerer clients. New NumPy
symbols are not claimed portable in the native artifact cache.

## S86 data-parallel GPU experiment

The explicit library candidate consumes canonical FunctionIR, with no source AST
frontend. It admits independent same-index float64 pointwise +,-,* loops only.
Reductions (including the512-element S85 NumPy workload), callbacks, neighbor
reads, aliases, unsafe layouts, nonfinite/overflow-risk values and nondefault
floating environments remain CPU. Allocation, guards, both transfers and
synchronization are inside GPU timings. First-shape CPU/GPU copies must match
bits before caller output changes. lto=False and fastmath=False are retained.

The single numeric review exposed a real one-bit FE_UPWARD mismatch after shape
reuse and an added tiny-grid warning. Literal REDs now pass: every call reads
CRT rounding/denormal/exception controls; idle grid padding avoids warning
handlers without changing global filters. Ten numeric checks pass, including
signed zero, subnormals, non-power-of-two coefficients and injected wrong bits.

Three alternating development rounds (disturbed cohorts repeated once):

| Elements | CP JIT-off ms | CP JIT-on ms | CPU model ms | GPU incl transfers ms |
|---:|---:|---:|---:|---:|
|512|0.05884|0.05640|0.07251|0.25623|
|65536|7.50334|7.68701|8.99633|0.52936|
|1048576|129.26335|125.72590|152.44190|3.66802|

All four modes have identical digests. Small arrays fail the speed criterion;
large arrays are promising candidates. These measurements do not install code
or satisfy final acceptance. Installed PyPy has no NumPy; no matching spike
exists. Raw cohort/entry/load receipts: results/gpu-s90-development.json.

## Current verification

The giant-process peer-union gate failed under MemoryError after3502 passes;
the two identified library nodes pass5 cases alone. That gate is not accepted.
The fresh-group complete fast gate covers all250 canonical test files:
4093 passed,276 deselected,5 xfailed,129 subtests passed,0 failures,12 groups,
one below-normal worker,743.1s. Persistent rc/Numba caches stay in this clone.
Inherited pytest filters are cleared; legitimate all-slow groups are recorded.
The gate client's one review found both edge cases and their literal REDs pass.
Self-host execution remains owner18's responsibility and is not claimed here.

---
# Historical bounded S85 census

Scope: loaded modules after fixture preparation/execution. Each package is
compiled in a fresh isolated process, with a 60-second compilation budget.
Counts cover the full loaded scope; not-attempted rows are never called refusals.

| Workload | Native bodies / scope | Declined | Not attempted | Live before run | Native entries | Verdict |
|---|---:|---:|---:|---:|---:|---|
| networkx_shortest_paths | 519/1900 | 0 | 1381 | 115 | 0 | not-exercised |
| networkx_pagerank | 652/1902 | 0 | 1250 | 120 | 0 | not-exercised |
| sympy_expand_simplify | 393/12901 | 7 | 12501 | 46 | 4288 | ok |
| jinja2_render | 657/710 | 53 | 0 | 367 | 0 | not-exercised |
| markdown_convert | 215/215 | 0 | 0 | 151 | 11008 | ok |
| pygments_highlight | 178/178 | 0 | 0 | 146 | 352 | ok |
| pyparsing_parse | 445/450 | 5 | 0 | 225 | 0 | not-exercised |
| dateutil_parse | 224/224 | 0 | 0 | 175 | 5120 | ok |
| yaml_load | 347/347 | 0 | 0 | 265 | 576 | ok |
| jsonschema_validate | 266/266 | 0 | 0 | 181 | 7680 | ok |
| json_encode | 22/22 | 0 | 0 | 20 | 32 | ok |
| difflib_diff | 43/43 | 0 | 0 | 41 | 608 | ok |
| email_parse | 480/480 | 0 | 0 | 246 | 0 | not-exercised |
| tomllib_load | 37/37 | 0 | 0 | 28 | 2976 | ok |
| numpy_loop | 635/756 | 0 | 121 | 232 | 0 | not-exercised |

Attempted: 5,178/20,431. Compiled: 5,113/5,178 (98.74% of attempted).
Not attempted:15,253. The former25.03% budget fraction is not coverage.
Execution verified: 9/15 workloads. Observed digest mismatches: 0.

The six not-exercised rows have no counted native workload entries. Their
matching digests and unrelated live installations do not establish compiled
correctness. The NumPy fixture loop is a benchmark driver function, not a
NumPy package function; package census alone cannot install that loop.

Counters wrap the actual retained LLVM body using owner18's CountedBody.
Every workload call is checked against the independent typed stock digest.
These wrappers are correctness-only and are never used for timing. The same
process profiles stock call counts, warms normally, prepares bodies, explicitly
installs candidates, resets counters, and performs 32 checked workload calls.

The 57 annotation-scope refusals in the first bounded census were routed to
wave17. Their accepted generic lowering is now merged; this historic counted
rerun predates that merge. Fresh fast-suite evidence covers the merged source.

Timing: deferred while peer self-host, correctness gates and CPython PGO workers
are active. No library speedup or measured default-installation claim is made.
Hook: opt-in prototype with weak hotness and keyed decision receipts; native
artifact persistence is experimental and new bodies stay Python without actual
current measurements. Self-host: owner18, not exercised by this report.

## Refusal breakdown in the counted pass
The counted rerun has 65 refusals: 56 annotation-scope lowering refusals (53
Jinja2 and three pyparsing), plus nine compiler IndexError failures (seven
SymPy and two pyparsing). These are separate from 15,253 functions not attempted
within the bounded chunks. The annotation fix is now integrated. Literal
IndexError reproducers and hot seed-refusal journals are next affected probes.

## Delivery capability update
The native-object experiment now passes fresh-process execution for traversal,
relocated constants, large integers, signed zero and exceptions. The sole artifact
review's corrupt-metadata findings are fixed by whole-manifest verification and
exact shape checks. The sole delivery-consumer review's stale-receipt and
substituted-owner findings are fixed by coherent evidence and precise installer
witnesses. CLI review fixes preserve caller sessions, SystemExit, shutdown
context and every loaded package source file. Real JSON AOT:22/22 prepared,
21 portable,0 installed; iterencode's immutable feedback is an explicit refusal.
No library speedup is claimed. Representative-call training and speed receipt
production remain separate from preparation. Current package source is frozen
for the full fast gate; the six prior binding refusals occurred while compiler
fingerprints changed and all affected files now pass (66 tests with libraries).

## Accepted peer union update

The accepted wave18 union3dec6a5f contains wave16 94283cb5 and wave17 b5aa0096.
Only the lower() keyword-signature conflict was resolved by retaining every
accepted option. Offline native rebuild and48 affected tests pass. GPU candidate
code moved unchanged into libraries/gpu.py with10 standard-suite numeric tests;
15 package/resident checks pass. Timing receipts describe the earlier1103 tree,
not this newer union. No automatic GPU admission was added.

New complete fast gate: 4128 passed,289 deselected,5 xfailed,129 subtests,
0 failures,254 files,12 fresh groups,2 below-normal workers,517.1s.
The proposed shared hooks remain unapplied:4 files,61 added lines,clean
apply-check and one read-only review with no concrete findings. Three explicit
REDs show the missing factory/C-call API. S79 ownership handoff is requested.
