# Bytes complete-call ceiling (S32)

Diagnostic only; no product capability, no new matrix-native rows. Three hottest retained complete byte bodies, all from base64: historical overlapping envelopes a85decode0.936106s, _85encode0.570016s and _b32decode0.346356s. Leave-base64-out bytes association is0.000510s. These envelopes overlap and are not speedup or additive time weights.

Three alternating pairs, same process and deterministic Random(12345) sequential input lengths20,127,3072,9000,102400,1048574 from the retained benchmark. CPython3.14.4, installed Numba0.68.1, existing Toolchain, no installs. Measurements include entry guards, boxing/ownership, output construction and cleanup; initialization/warmup is outside all calls. Exact fixture hashes/results and raw three samples are in bytes-bridge-v6.json.

Values below are median complete-call microseconds. C columns are ordinary hand-written extensions; managed AOT columns use NRT Python-object values and intrinsics through the existing nopython/CC pipeline to call those complete translated C bodies. This is a bridge-to-hand-C experiment, not automatic source recognition, intrinsic lowering for each byte operation, or a product backend. Managed njit direct-entry samples are retained in JSON.

| Function | Raw bytes | CPython | Boxed C | Borrowed C | Boxed AOT | Borrowed AOT |
|---|---:|---:|---:|---:|---:|---:|
| a85decode | 20 | 2.6173 | 2.6563 | 1.2378 | 3.4207 | 1.9671 |
| a85decode | 127 | 13.5100 | 7.8045 | 1.4155 | 8.9690 | 2.1415 |
| a85decode | 3072 | 302.1400 | 135.7900 | 3.5000 | 136.2800 | 4.2000 |
| a85decode | 9000 | 874.9000 | 393.2200 | 7.4200 | 393.4800 | 8.1000 |
| a85decode | 102400 | 9870.6000 | 4652.7500 | 69.0500 | 4667.8000 | 71.9500 |
| a85decode | 1048574 | 109876.2000 | 50754.4000 | 817.2000 | 54097.3000 | 869.9000 |
| _b32decode | 20 | 1.9597 | 3.0687 | 1.8510 | 3.8641 | 2.7144 |
| _b32decode | 127 | 10.2375 | 11.1220 | 1.9730 | 11.3110 | 2.7840 |
| _b32decode | 3072 | 250.6000 | 253.2700 | 5.1200 | 209.7300 | 5.8900 |
| _b32decode | 9000 | 777.1200 | 645.2000 | 10.4800 | 679.9800 | 11.4200 |
| _b32decode | 102400 | 7641.6000 | 7039.2000 | 120.8000 | 6976.1500 | 117.5000 |
| _b32decode | 1048574 | 76569.9000 | 71791.7000 | 1167.0000 | 71369.1000 | 1264.8000 |
| _85encode-a85 | 20 | 1.1605 | 2.2867 | 1.0983 | 3.2059 | 2.0521 |
| _85encode-a85 | 127 | 5.0540 | 5.4205 | 1.2120 | 6.3175 | 2.1760 |
| _85encode-a85 | 3072 | 124.0500 | 85.0800 | 4.1500 | 83.7400 | 5.1700 |
| _85encode-a85 | 9000 | 317.2400 | 242.9200 | 10.2000 | 241.7800 | 11.3400 |
| _85encode-a85 | 102400 | 3776.7000 | 2992.8000 | 99.9500 | 2994.2000 | 100.2000 |
| _85encode-a85 | 1048574 | 41428.6000 | 33241.0000 | 1083.1000 | 32585.9000 | 1102.6000 |
| _85encode-b85 | 20 | 1.0894 | 2.2854 | 1.1127 | 3.2749 | 2.0801 |
| _85encode-b85 | 127 | 5.2785 | 5.4230 | 1.2455 | 6.4685 | 2.3685 |
| _85encode-b85 | 3072 | 103.2400 | 83.2200 | 4.0100 | 83.4800 | 5.0300 |
| _85encode-b85 | 9000 | 357.2000 | 246.6600 | 10.0400 | 243.7400 | 11.3600 |
| _85encode-b85 | 102400 | 3743.0500 | 3247.9000 | 98.2500 | 2986.1000 | 98.3500 |
| _85encode-b85 | 1048574 | 43684.9000 | 33255.9000 | 1066.1000 | 32677.2000 | 1070.6000 |

## Decision and size

S36 withdraws the original half-absolute-saving rule: choose remaining time within2x of the best measured route. At1MiB, borrowed AOT is within2x of best direct-C time for all four controls; boxed AOT is far outside. Select borrowed native byte buffers for all four bodies, with boxed/original routes only for guard misses and small-input profitability misses. No implementation is authorized before the pending backend choice. The superseded half-saving arithmetic at the end remains historical evidence, not the selection rule.

Estimated first sound product slice: 300-600 lines for an owned Python-bytes/native-span model and AOT boxing, 500-900 lines for read-only indexing/length/slices/concatenation/comparison recognizers with exact scalar semantics, and 300-600 lines for guards/callback/error/ownership regression integration. These are engineering estimates, not measured reach. Reuse Numba bytes lowering where strict oracle gates permit it; the accepted plain-njit experiment matched12 current byte-method fixtures, not universal semantics. Automatic whole-function native counts and new captured/verified/deployed counts remain unmeasured because no capability has been built.

## Correctness and eligibility

Final cohort passed 1614 behavior/exception/event gates,18 success/error ownership groups,1000-call reference loops and fresh-process AOT success/error calls without importing Numba. All timed borrowed entries assert fast-count equals call count and every timed variant asserts zero fallback. Source/artifact/receipt/audit hashes are in bytes-seal.json.

Decoder flags are the default slice: a85decode foldspaces=False/adobe=False/default ignorechars and _b32decode casefold=False/map01=None. ASCII strings and non-exact-byte inputs use faithful boxed or original fallback. All eight boolean _85encode flag combinations, both actual alphabets, altered tables, lengths0..32 and large inputs, errors/padding/overflow, full exception chains and callback order are executed. The public a85encode wrapping/adobe wrapper is outside _85encode and is not credited.

Entry guards require exact inert module/builtin dictionaries and captured helper/function code/default bindings; struct/binascii modules are exact, reverse-cache keys and entries are known-inert canonical objects before conversion. Unsupported or rebound helpers/caches/module subclasses fall back to the captured original function before body effects. Actual converter/cache/import-cache/module-subclass red witnesses are retained, then included green through all six C/njit/AOT routes.

The measured domain is a GIL-held CPython3.14 experiment with trusted initial module context. Nonempty gc.callbacks forces fallback. Ambient cyclic finalizers, concurrent/asynchronous mutation, OOM injection, free-threading/subinterpreters and hostile import-time mutation are not proven. No universal base64 or public ABI promise follows from these diagnostics. Borrowed encode list entries are immutable exact bytes and held under the GIL; result construction may allocate then resize with private _PyBytes_Resize, so this is not Stable ABI. a85decode reserves4*n+4 bytes before shrinking: up to about5 times the usual decoded output for ordinary encoded input, or roughly5.24MB for the1MiB raw recipe, besides input/output bridge state. No claim of one physical allocation or measured peak memory is made.

All three strong byte controls belong to one program; they do not establish Unicode representation performance. A separate real SQLAlchemy-docstring dedent control is required before choosing a Unicode kind.

## Failed development runs

v1/v2 exposed bytearray assumptions, altered partial-zero table behavior and callback/slice ordering; fixed with actual red/green gates. Bridge v1 exposed intrinsic vararg signature folding; v2 reached all gates then failed a runner name collision; v3 completed cells but failed an external source-seal path. v4/v5 are superseded by review-driven import-cache and module-subclass corrections. Only final v6 is accepted for the table above. Raw failures remain in logs and JSON; no partial-run aggregate is used.

|1MiB complete body | Boxed AOT fraction of best direct-C saving | Borrowed AOT fraction |
|---|---:|---:|
|a85decode | 0.511 | 1.000 |
|_b32decode | 0.069 | 0.999 |
|_85encode-a85 | 0.219 | 1.000 |
|_85encode-b85 | 0.258 | 1.000 |

## S36 small inputs and observed crossovers

Pipeline decision compares CPython with managed boxed/borrowed AOT complete calls; direct-C minima are shown separately because a direct C export omits the existing-pipeline boundary. Three medians at sparse measured sizes establish an observed crossing interval, not an exact threshold or statistical significance.

| Body |20 bytes: CPython / boxed AOT / borrowed AOT us; winner |127 bytes: same; winner | First measured borrowed AOT win / crossing interval |
|---|---|---|---|
|a85decode|2.6173/3.4207/1.9671; borrowed-AOT|13.5100/8.9690/2.1415; borrowed-AOT|20 bytes; already at smallest measured size|
|_b32decode|1.9597/3.8641/2.7144; cpython|10.2375/11.3110/2.7840; borrowed-AOT|127 bytes; (20,127] bytes|
|_85encode-a85|1.1605/3.2059/2.0521; cpython|5.0540/6.3175/2.1760; borrowed-AOT|127 bytes; (20,127] bytes|
|_85encode-b85|1.0894/3.2749/2.0801; cpython|5.2785/6.4685/2.3685; borrowed-AOT|127 bytes; (20,127] bytes|

Direct-C winner at20/127 bytes (context for boundary overhead):

- a85decode: 20: borrowed-C 1.2378us, 127: borrowed-C 1.4155us.
- _b32decode: 20: borrowed-C 1.8510us, 127: borrowed-C 1.9730us.
- _85encode-a85: 20: borrowed-C 1.0983us, 127: borrowed-C 1.2120us.
- _85encode-b85: 20: cpython 1.0894us, 127: borrowed-C 1.2455us.
