# Non-escaping sets: measured whole-function reach

Final product source after the S40 rule; before is edbd8bd lift.py with the same other product files. All35 non-network programs completed with identical capture-monitor on/off application stdout/stderr, manifest hashes and before/after input hashes. All retained uniform and rare shapes are passed through the ordinary verifier together; unfinished generator captures never count native. No native eligibility is inferred for unobserved calls or definitions.

Before and after:365 own definitions exercised as a source population;194 functions captured,59 verified and59 native whole functions on every retained complete call. Fixed all-program denominator375:59/375=15.7333%. The10 definitions in three network programs are excluded from execution;181 definitions are uncaptured or excluded. New native whole functions:0. No runner deployment was performed:deployed0 is collector activity, not a measured selection outcome. Recommendations/timings are diagnostic because the retained sample mix is combined.

Largest native contributor:richards_super22/59. Leaving its39 definitions out gives37 observed native functions/336 all remaining definitions=11.0119%. No sum of syntactic row weights or prediction of unlocked runtime is used.

| Program | Own definitions | Captured before/after | Verified before/after | Whole native before/after |
|---|---:|---:|---:|---:|
| async_generators | 4 | 3/3 | 0/0 | 0/0 |
| base64 | 11 | 11/11 | 0/0 | 0/0 |
| chaos | 23 | 16/16 | 13/13 | 13/13 |
| comprehensions | 6 | 2/2 | 0/0 | 0/0 |
| concurrent_imap | 3 | 3/3 | 1/1 | 1/1 |
| decimal_factorial | 2 | 1/1 | 0/0 | 0/0 |
| decimal_pi | 2 | 1/1 | 0/0 | 0/0 |
| deepcopy | 6 | 3/3 | 0/0 | 0/0 |
| deltablue | 66 | 8/8 | 1/1 | 1/1 |
| gc_collect | 5 | 4/4 | 2/2 | 2/2 |
| gc_traversal | 2 | 1/1 | 0/0 | 0/0 |
| generators | 4 | 4/4 | 1/1 | 1/1 |
| hexiom | 37 | 26/26 | 15/15 | 15/15 |
| json_dumps | 3 | 2/2 | 0/0 | 0/0 |
| json_loads | 2 | 1/1 | 0/0 | 0/0 |
| logging | 5 | 0/0 | 0/0 | 0/0 |
| mdp | 17 | 3/3 | 2/2 | 2/2 |
| meteor_contest | 10 | 6/6 | 0/0 | 0/0 |
| nqueens | 3 | 3/3 | 0/0 | 0/0 |
| pathlib | 3 | 3/3 | 0/0 | 0/0 |
| pidigits | 6 | 4/4 | 0/0 | 0/0 |
| pprint | 0 | 0/0 | 0/0 | 0/0 |
| python_startup | 1 | 0/0 | 0/0 | 0/0 |
| regex_compile | 25 | 15/15 | 0/0 | 0/0 |
| regex_dna | 7 | 4/4 | 0/0 | 0/0 |
| regex_effbot | 7 | 2/2 | 0/0 | 0/0 |
| regex_v8 | 13 | 13/13 | 0/0 | 0/0 |
| richards_super | 39 | 38/38 | 22/22 | 22/22 |
| sqlalchemy_declarative | 2 | 1/1 | 0/0 | 0/0 |
| sqlite_synth | 4 | 4/4 | 2/2 | 2/2 |
| sympy | 6 | 3/3 | 0/0 | 0/0 |
| typing_runtime_protocols | 25 | 4/4 | 0/0 | 0/0 |
| unpack_sequence | 5 | 4/4 | 0/0 | 0/0 |
| xml_etree | 9 | 0/0 | 0/0 | 0/0 |
| yaml | 2 | 1/1 | 0/0 | 0/0 |

## Next recorded first failures

Every captured but non-verified entry follows. Uncaptured entries have no executed candidate first failure and remain in summary.json; they are not inferred supported. Baseline and final candidate status/native flags have no changes. Two richards_super native candidate rejections (fn and release) occur in both sources and were excluded by verification; zero wrong matrix rows does not assert these candidates passed.

| Program | Entry:line | Status | First failure / region alternative |
|---|---|---|---|
| async_generators | bench_async_generators:38 | skipped | outside the supported subset: 'bench_async_generators' has a closure, keyword-only arguments, *args or is a generator; as a region: async for over something other than an async generator at line 2 of 'bench_async_generators' |
| async_generators | tree:31 | skipped | outside the supported subset: 'tree' returns a value on some paths and None on others; as a region: an argument of type range |
| async_generators | __init__:16 | skipped | the compiled version did not apply to the captured calls; as a region: a 'Tree' object with attributes its __init__ does not set |
| base64 | bench_b64_small:68 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b64_small' |
| base64 | bench_b64_large:86 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b64_large' |
| base64 | bench_urlsafe_b64_small:100 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_urlsafe_b64_small' |
| base64 | bench_b32_small:120 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b32_small' |
| base64 | bench_b32_large:138 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b32_large' |
| base64 | bench_b16_small:152 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b16_small' |
| base64 | bench_b16_large:170 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b16_large' |
| base64 | bench_a85_small:184 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_a85_small' |
| base64 | bench_a85_large:210 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_a85_large' |
| base64 | bench_b85_small:228 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b85_small' |
| base64 | bench_b85_large:246 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_b85_large' |
| chaos | __init__:21 | skipped | the compiled version did not apply to the captured calls; as a region: a 'GVector' object with attributes its __init__ does not set |
| chaos | __init__:66 | skipped | the compiled version did not apply to the captured calls; as a region: a 'Spline' object with attributes its __init__ does not set |
| chaos | __init__:147 | skipped | outside the supported subset: comprehension at line 4; as a region: a 'Chaosgame' object with attributes its __init__ does not set |
| comprehensions | bench_comprehensions:82 | skipped | outside the supported subset: global 'WidgetKind' is not a numeric constant; as a region: range() on int at line 2 of 'bench_comprehensions' |
| comprehensions | _any_knobby:35 | skipped | outside the supported subset: GeneratorExp at line 2; as a region: 'WidgetTray.__init__' uses the new object before setting all its attributes |
| concurrent_imap | bench_mp_pool:13 | skipped | outside the supported subset: With at line 2; as a region: With at line 2 of 'bench_mp_pool' |
| concurrent_imap | bench_thread_pool:19 | skipped | outside the supported subset: With at line 2; as a region: With at line 2 of 'bench_thread_pool' |
| decimal_factorial | bench_decimal_factorial:34 | skipped | outside the supported subset: global 'decimal' is not a numeric constant; as a region: a call of 'decimal.getcontext' at line 2 of 'bench_decimal_factorial' |
| decimal_pi | bench_decimal_pi:38 | skipped | outside the supported subset: assignment to an attribute of a call result at line 3; as a region: a call of 'decimal.getcontext' at line 3 of 'bench_decimal_pi' |
| deepcopy | benchmark:54 | skipped | outside the supported subset: Dict at line 3; as a region: one value can be list[int] or (int, int, int) |
| deepcopy | benchmark_reduce:21 | skipped | outside the supported subset: ClassDef at line 3; as a region: 'benchmark_reduce' declares globals or defines functions inside itself |
| deepcopy | benchmark_memo:42 | skipped | outside the supported subset: Dict at line 4; as a region: a repeated list of list[int] at line 4 of 'benchmark_memo' |
| deltablue | __init__:39 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: 'Strength.__init__' uses the new object before setting all its attributes |
| deltablue | delta_blue:626 | skipped | outside the supported subset: Global at line 15; as a region: 'chain_test' declares globals or defines functions inside itself |
| deltablue | chain_test:513 | skipped | outside the supported subset: Global at line 15; as a region: 'chain_test' declares globals or defines functions inside itself |
| deltablue | __init__:382 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: 'Planner.__init__' uses the new object before setting all its attributes |
| deltablue | __init__:92 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: 'Strength.__init__' uses the new object before setting all its attributes |
| deltablue | projection_test:561 | skipped | outside the supported subset: 'dst' may be read before assignment at line 25; as a region: 'projection_test' declares globals or defines functions inside itself |
| deltablue | next_weaker:66 | skipped | outside the supported subset: Dict at line 2; as a region: 'Strength.__init__' uses the new object before setting all its attributes |
| gc_collect | benchamark_collection:44 | skipped | outside the supported subset: global 'gc' is not a numeric constant; as a region: a call of 'gc.collect' at line 4 of 'benchamark_collection' |
| gc_collect | __init__:9 | skipped | outside the supported subset: constant None at line 2; as a region: a 'Node' object with attributes its __init__ does not set |
| gc_traversal | benchamark_collection:19 | skipped | outside the supported subset: constant None at line 5; as a region: a call of 'gc.collect' at line 5 of 'benchamark_collection' |
| generators | bench_generators:36 | skipped | outside the supported subset: Assert at line 2; as a region: range() on int at line 2 of 'bench_generators' |
| generators | tree:29 | skipped | outside the supported subset: 'tree' returns a value on some paths and None on others; as a region: an argument of type range |
| generators | __init__:16 | skipped | the compiled version did not apply to the captured calls; as a region: a 'Tree' object with attributes its __init__ does not set |
| hexiom | __init__:22 | skipped | the compiled version did not apply to the captured calls; as a region: a 'Dir' object with attributes its __init__ does not set |
| hexiom | main:621 | skipped | outside the supported subset: 'output' may be read before assignment at line 21; as a region: 'StringIO' has a finalizer |
| hexiom | read_file:471 | skipped | outside the supported subset: constant '\r\n' at line 2; as a region: str method 'splitlines' at line 2 of 'read_file' |
| hexiom | __init__:182 | skipped | outside the supported subset: constant None at line 4; as a region: a 'Hex' object with attributes its __init__ does not set |
| hexiom | __init__:172 | skipped | the compiled version did not apply to the captured calls; as a region: a 'Node' object with attributes its __init__ does not set |
| hexiom | __init__:47 | skipped | outside the supported subset: constant None at line 3; as a region: a 'Done' object with attributes its __init__ does not set |
| hexiom | __init__:226 | skipped | outside the supported subset: comparison at line 4; as a region: a 'Pos' object with attributes its __init__ does not set |
| hexiom | clone:231 | skipped | outside the supported subset: comparison at line 4; as a region: one value can be None or list[list[int]] |
| hexiom | clone:52 | skipped | outside the supported subset: constant None at line 3; as a region: one value can be None or list[list[int]] |
| hexiom | constraint_pass:237 | skipped | outside the supported subset: comparison at line 7; as a region: range() on int at line 7 of 'constraint_pass' |
| hexiom | find_moves:322 | skipped | outside the supported subset: call at line 11; as a region: reversed() on list[nothing] at line 11 of 'find_moves' |
| json_dumps | main:30 | skipped | outside the supported subset: keyword or starred argument at line 2; as a region: name 'add_cmdline_args' used as a value at line 2 of 'main' |
| json_dumps | bench_json_dumps:19 | skipped | outside the supported subset: global 'json' is not a numeric constant; as a region: an argument of type range |
| json_loads | bench_json_loads:72 | skipped | outside the supported subset: global 'json' is not a numeric constant; as a region: 'loads' takes **kwargs |
| mdp | bench_mdp:247 | skipped | outside the supported subset: 'result' may be read before assignment at line 11; as a region: range() on int at line 4 of 'bench_mdp' |
| meteor_contest | main:212 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: 'Runner.__init__' takes **kwargs |
| meteor_contest | get_puzzle:135 | skipped | outside the supported subset: comprehension at line 2; as a region: a list comprehension inside another in 'get_puzzle' |
| meteor_contest | rotate:88 | skipped | the compiled version did not apply to the captured calls; as a region: a list holds both ints and floats, or floats and None |
| meteor_contest | flip:92 | skipped | the compiled version did not apply to the captured calls; as a region: a list holds both ints and floats, or floats and None |
| meteor_contest | convert:107 | skipped | outside the supported subset: call at line 6; as a region: a list holds both ints and floats, or floats and None |
| meteor_contest | get_senh:126 | skipped | outside the supported subset: comparison at line 6; as a region: a list that holds both ints and floats, or numbers and None at line 4 of 'get_senh' |
| nqueens | bench_n_queens:53 | skipped | outside the supported subset: 'n_queens' has a closure, keyword-only arguments, *args or is a generator; as a region: range() on int at line 13 of 'bench_n_queens' |
| nqueens | n_queens:34 | skipped | outside the supported subset: 'n_queens' has a closure, keyword-only arguments, *args or is a generator; as a region: range() on int at line 13 of 'n_queens' |
| nqueens | permutations:9 | skipped | outside the supported subset: 'permutations' has a closure, keyword-only arguments, *args or is a generator; as a region: an argument of type range |
| pathlib | setup:29 | skipped | outside the supported subset: global 'tempfile' is not a numeric constant; as a region: no source for 'join' |
| pathlib | generate_filenames:20 | skipped | outside the supported subset: 'generate_filenames' has a closure, keyword-only arguments, *args or is a generator; as a region: no source for 'join' |
| pathlib | bench_pathlib:38 | skipped | outside the supported subset: global 'pathlib' is not a numeric constant; as a region: 'Path' customises allocation |
| pidigits | calc_ndigits:51 | skipped | outside the supported subset: 'gen_pi_digits' has a closure, keyword-only arguments, *args or is a generator; as a region: 'islice' customises allocation |
| pidigits | gen_pi_digits:39 | skipped | outside the supported subset: 'gen_pi_digits' has a closure, keyword-only arguments, *args or is a generator; as a region: 'gen_x' declares globals or defines functions inside itself |
| pidigits | extract:34 | skipped | the compiled version did not apply to the captured calls; as a region: an int argument too large for 64 bits |
| pidigits | compose:25 | skipped | the compiled version did not apply to the captured calls; as a region: an int argument too large for 64 bits |
| regex_compile | bench_regex_effbot:128 | skipped | outside the supported subset: comparison at line 2; as a region: name 'bench_regex_effbot' used as a value at line 2 of 'bench_regex_effbot' |
| regex_compile | gen_string_table:59 | skipped | outside the supported subset: FunctionDef at line 9; as a region: 'gen_string_table' declares globals or defines functions inside itself |
| regex_compile | bench_regex_v8:1768 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: a call of 'pyperf.perf_counter' at line 2 of 'bench_regex_v8' |
| regex_compile | block0:275 | skipped | outside the supported subset: constant 'pyvpx' at line 3; as a region: 'Pattern.search' is not a plain method at line 3 of 'block0' |
| regex_compile | block1:354 | skipped | outside the supported subset: constant 'VC=74.125.75.1' at line 3; as a region: 'Pattern.search' is not a plain method at line 3 of 'block1' |
| regex_compile | block2:427 | skipped | outside the supported subset: constant '' at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block2' |
| regex_compile | block3:490 | skipped | outside the supported subset: constant '[A-Za-z]' at line 3; as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 3 of 'block3' |
| regex_compile | block4:603 | skipped | outside the supported subset: constant '\\*' at line 3; as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 3 of 'block4' |
| regex_compile | block5:675 | skipped | outside the supported subset: constant '' at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block5' |
| regex_compile | block6:736 | skipped | outside the supported subset: constant '(?i)##yv0##' at line 3; as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 3 of 'block6' |
| regex_compile | block7:828 | skipped | outside the supported subset: constant '' at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block7' |
| regex_compile | block8:896 | skipped | outside the supported subset: constant '\\d+' at line 3; as a region: 'Pattern.sub' is not a plain method at line 4 of 'block8' |
| regex_compile | block9:980 | skipped | outside the supported subset: global 'strings' is not a numeric constant; as a region: 'Pattern.split' is not a plain method at line 3 of 'block9' |
| regex_compile | block10:1162 | skipped | outside the supported subset: constant '' at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block10' |
| regex_compile | block11:1316 | skipped | outside the supported subset: constant '' at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block11' |
| regex_dna | init_benchmarks:134 | skipped | outside the supported subset: call at line 2; as a region: bytearray() on nothing at line 2 of 'init_benchmarks' |
| regex_dna | make_cumulative:45 | skipped | outside the supported subset: call at line 8; as a region: arithmetic on list[nothing] at line 7 of 'make_cumulative' |
| regex_dna | bench_regex_dna:187 | skipped | outside the supported subset: 'res' may be read before assignment at line 9; as a region: an argument of type bytes |
| regex_dna | run_benchmarks:171 | skipped | outside the supported subset: constant b'>.*\n / \n' at line 4; as a region: an argument of type bytes |
| regex_effbot | bench_regex_effbot:128 | skipped | outside the supported subset: comparison at line 2; as a region: name 'bench_regex_effbot' used as a value at line 2 of 'bench_regex_effbot' |
| regex_effbot | gen_string_table:59 | skipped | outside the supported subset: FunctionDef at line 9; as a region: 'gen_string_table' declares globals or defines functions inside itself |
| regex_v8 | bench_regex_v8:1768 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: a call of 'pyperf.perf_counter' at line 2 of 'bench_regex_v8' |
| regex_v8 | block0:275 | skipped | outside the supported subset: constant 'pyvpx' at line 3; as a region: 'Pattern.search' is not a plain method at line 3 of 'block0' |
| regex_v8 | block1:354 | skipped | outside the supported subset: constant 'VC=74.125.75.1' at line 3; as a region: 'Pattern.search' is not a plain method at line 3 of 'block1' |
| regex_v8 | block2:427 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block2' |
| regex_v8 | block3:490 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 3 of 'block3' |
| regex_v8 | block4:603 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 3 of 'block4' |
| regex_v8 | block5:675 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block5' |
| regex_v8 | block6:736 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 3 of 'block6' |
| regex_v8 | block7:828 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block7' |
| regex_v8 | block8:896 | skipped | outside the supported subset: constant '\\d+' at line 3; as a region: 'Pattern.sub' is not a plain method at line 4 of 'block8' |
| regex_v8 | block9:980 | skipped | outside the supported subset: global 'strings' is not a numeric constant; as a region: 'Pattern.split' is not a plain method at line 3 of 'block9' |
| regex_v8 | block10:1162 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block10' |
| regex_v8 | block11:1316 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: 'Pattern.sub' is not a plain method at line 3 of 'block11' |
| richards_super | __init__:165 | skipped | outside the supported subset: constant None at line 2; as a region: a 'TaskWorkArea' object with attributes its __init__ does not set |
| richards_super | __init__:102 | skipped | the compiled version did not apply to the captured calls; as a region: a 'TaskState' object with attributes its __init__ does not set |
| richards_super | __init__:72 | skipped | the compiled version did not apply to the captured calls; as a region: a 'IdleTaskRec' object with attributes its __init__ does not set |
| richards_super | __init__:315 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: a 'IdleTask' object with attributes its __init__ does not set |
| richards_super | __init__:179 | skipped | outside the supported subset: global 'taskWorkArea' is not a numeric constant; as a region: a 'DeviceTask' object with attributes its __init__ does not set |
| richards_super | __init__:37 | skipped | the compiled version did not apply to the captured calls; as a region: a 'Packet' object with attributes its __init__ does not set |
| richards_super | __init__:94 | skipped | the compiled version did not apply to the captured calls; as a region: a 'WorkerTaskRec' object with attributes its __init__ does not set |
| richards_super | __init__:341 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: a 'WorkTask' object with attributes its __init__ does not set |
| richards_super | __init__:79 | skipped | outside the supported subset: constant None at line 2; as a region: a 'HandlerTaskRec' object with attributes its __init__ does not set |
| richards_super | __init__:281 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: a 'HandlerTask' object with attributes its __init__ does not set |
| richards_super | __init__:66 | skipped | outside the supported subset: constant None at line 2; as a region: a 'DeviceTaskRec' object with attributes its __init__ does not set |
| richards_super | __init__:258 | skipped | outside the supported subset: '__init__' has a closure, keyword-only arguments, *args or is a generator; as a region: a 'DeviceTask' object with attributes its __init__ does not set |
| richards_super | fn:284 | skipped | outside the supported subset: 'fn' has a closure, keyword-only arguments, *args or is a generator; as a region, only 6 of 8 captured calls ran compiled |
| richards_super | fn:196 | skipped | the compiled version did not apply to the captured calls; as a region, only 8 of 10 captured calls ran compiled |
| richards_super | fn:344 | rejected | result differs from a captured call |
| richards_super | release:231 | rejected | result differs from a captured call |
| sqlalchemy_declarative | bench_sqlalchemy:58 | skipped | outside the supported subset: keyword or starred argument at line 6; as a region: 'Session.__init__' uses the new object before setting all its attributes |
| sqlite_synth | bench_sqlite:30 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: a call of 'pyperf.perf_counter' at line 2 of 'bench_sqlite' |
| sqlite_synth | __init__:17 | skipped | the compiled version did not apply to the captured calls; as a region: a 'AvgLength' object with attributes its __init__ does not set |
| sympy | bench_expand:7 | skipped | outside the supported subset: constant 'x y z' at line 2; as a region: 'symbols' takes **kwargs |
| sympy | bench_sum:18 | skipped | outside the supported subset: constant 'x i' at line 2; as a region: 'symbols' takes **kwargs |
| sympy | bench_str:23 | skipped | outside the supported subset: constant 'x y z' at line 2; as a region: 'symbols' takes **kwargs |
| typing_runtime_protocols | bench_protocols:151 | skipped | outside the supported subset: global 'HasX' is not a numeric constant; as a region: name 'HasX' used as a value at line 3 of 'bench_protocols' |
| typing_runtime_protocols | __init__:114 | skipped | the compiled version did not apply to the captured calls; as a region: a 'InstanceVarX' object with attributes its __init__ does not set |
| typing_runtime_protocols | __init__:119 | skipped | outside the supported subset: constant 'abcde' at line 2; as a region: setattr() on ManyInstanceVars, str, int at line 3 of 'ManyInstanceVars.__init__' |
| typing_runtime_protocols | __init__:125 | skipped | the compiled version did not apply to the captured calls; as a region: a 'InstanceVarXWithInt' object with attributes its __init__ does not set |
| unpack_sequence | bench_all:427 | skipped | outside the supported subset: call at line 2; as a region: range() on int at line 2 of 'bench_tuple_unpacking' |
| unpack_sequence | bench_tuple_unpacking:416 | skipped | outside the supported subset: call at line 2; as a region: range() on int at line 2 of 'bench_tuple_unpacking' |
| unpack_sequence | do_unpacking:6 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'do_unpacking' |
| unpack_sequence | bench_list_unpacking:421 | skipped | outside the supported subset: global 'pyperf' is not a numeric constant; as a region: range() on int at line 2 of 'bench_list_unpacking' |
| yaml | bench_yaml:77 | skipped | outside the supported subset: keyword or starred argument at line 3; as a region: 'yaml.Loader', which holds type at line 3 of 'bench_yaml' |

Evidence:sets-heldout-v1/summary.json, its complete.json hash receipt, per-program raw data and matrix/logs/step3-sets-heldout-v1.*. Two-program collector smoke-v2 and independent review-native-sets.md preceded the full run.
