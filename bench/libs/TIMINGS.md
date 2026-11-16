# S90 library development timings

Three alternating rounds per workload, repeated once with concurrent correctness
processes present. Preparation and32 correctness checks precede each lock; the
timed body has no CountedBody or primitive counter. CPython3.14.4 JIT-off and
JIT-on are separate resident processes; native uses JIT-on. PyPy3.11.17 warms
1000 calls where installed; CPython/native warm32. Values below are median
microseconds per workload call. Native/on is the median of paired ratios.

These are development measurements under recorded test load, not deployment
acceptance. Differences below about6% remain unresolved. No native workload
shows a clear win over JIT-on; the default-installation pool stays0. There is
no corresponding library spike provider. All15 measured digests match stock.

| Workload | CP JIT off us | CP JIT on us | Native us | PyPy us | Native/on |
|---|---:|---:|---:|---:|---:|
|networkx_shortest_paths|70.89|65.61|213.15|unavailable|3.414|
|networkx_pagerank|1125.42|1188.79|1283.53|unavailable|1.025|
|sympy_expand_simplify|5894.50|6555.49|9003.84|3523.70|1.331|
|jinja2_render|71.70|71.66|74.35|unavailable|1.055|
|markdown_convert|381.51|399.74|751.38|unavailable|1.823|
|pygments_highlight|2176.84|1841.16|1875.16|unavailable|1.065|
|pyparsing_parse|734.03|724.93|1559.08|unavailable|2.132|
|dateutil_parse|101.79|105.46|240.62|unavailable|2.290|
|yaml_load|290.02|300.73|782.41|36.91|2.602|
|jsonschema_validate|338.40|342.27|721.88|unavailable|2.160|
|json_encode|9.31|8.11|10.43|3.37|1.137|
|difflib_diff|38.86|34.56|102.33|8.05|3.106|
|email_parse|389.15|411.50|646.47|360.42|1.638|
|tomllib_load|18.79|18.43|60.07|3.70|3.179|
|numpy_loop|47.14|44.67|44.93|unavailable|1.047|

Email initially failed native preparation with LLVM section-memory allocation
failure; difflib initially failed child I/O. The original failures are retained.
Only those two were rerun after the owned full gate exited and released memory.
A literal cleanup regression exposed and fixed masking of child errors by pipe
close. The retries succeeded with exact outputs. No peer processes/settings
were changed. Timings describe8baa56cf plus resolved wave16c2a1c2d9 integration;
the new C-call and ndarray models were not enabled in these measurements.

## Compile throughput

Fresh24-function NetworkX hot samples compiled24/24 at12.00 and10.15 functions/s
under short separate locks; the second is the one disturbed-development repeat.
Instrumentation is included. In the repeat, exclusive phase costs per function
were approximately54.3ms LLVM codegen/link,19.1ms LLVM IR construction,10.3ms
MCJIT setup,5.6ms LLVM parse,5.2ms serialization,1.3ms IR build and0.8ms symbol
resolution. Total98.5ms/function. This supports profile-first compilation and
persistent objects; it is not a whole-package completion claim.

The hot correctness sample is675/675 attempted,1138 not attempted, native15/15.
The bounded loaded-package census remains5113/5178 attempted (98.74%) and15253
unattempted. No library mismatch was observed. Suspended functions may execute
only the S80 first native prefix; per-function records preserve that fact.
