# Partial all-blockers census (S51)

This is a bounded diagnostic, not an exhaustive list or a completion forecast. It walks past refusals without compiling code. Once a refusal makes a type/state unknown, subsequent reasons are labelled after-unknown or structural. Unknown paths receive no completion credit.

Historical captured-not-native population: **135 functions**, 31 programs. Current reference baseline: **60/375 fully native**, **0/375 native with fallback (0 sites)**. One historical member is already native; it is not counted again. No product capability or deployment changes in this census.

Collection status: {'analysed': 134, 'already_native': 1}. Failed programs: none. Inclusive weights exist for 115 roots; 20 are missing. Timing wrappers (bench_* with perf_counter/range/elapsed return): 20.

The inclusive weights are existing capture cumulative times, counted once per root per family. They overlap across callers and callees, are specific to those captures, and cannot be added as whole-program time saved. Missing weights stay missing. This does not measure native/Python time shares in fallback regions.

## At-all and ONLY observed families

ONLY observed means exactly one family was seen. ONLY reliable additionally requires no unknown remainder; it alone could support a completion claim. At-all includes the authoritative current product first refusal plus diagnostic reasons. The JSON retains exact source, scope, line, call chain, reason and unknown flags for every distinct event.

| Family | Functions | Programs | ONLY observed | ONLY reliable | After unknown | Structural | Wrappers | Inclusive s | Missing weights |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| C/library calls (scalar/effect eligibility unknown) | 56 | 20 | 0 | 0 | 54 | 26 | 20 | 5.765050 | 13 |
| function/class/global values (identity guards) | 47 | 16 | 0 | 0 | 45 | 44 | 10 | 1.490926 | 15 |
| Slice at line N of '<name>' | 37 | 10 | 0 | 0 | 37 | 37 | 7 | 0.968486 | 12 |
| local definitions/global declarations | 36 | 8 | 0 | 0 | 0 | 0 | 8 | 2.235081 | 14 |
| class values | 34 | 8 | 0 | 0 | 34 | 29 | 6 | 0.094371 | 15 |
| GeneratorExp at line N of '<name>' | 32 | 7 | 0 | 0 | 32 | 29 | 4 | 0.573718 | 12 |
| object entry/constructor acceptance | 32 | 11 | 24 | 0 | 30 | 0 | 0 | 0.184539 | 4 |
| bytes literals | 31 | 6 | 0 | 0 | 31 | 29 | 8 | 0.604838 | 12 |
| isinstance() with something other than one class at line N of '<name>' | 31 | 7 | 0 | 0 | 7 | 2 | 9 | 0.324184 | 12 |
| str method '<name>' at line N of '<name>' | 31 | 6 | 0 | 0 | 27 | 7 | 8 | 0.105958 | 12 |
| ValueError() on str at line N of '<name>' | 29 | 5 | 0 | 0 | 29 | 29 | 8 | 0.093527 | 12 |
| attribute '<name>' of str at line N of '<name>' | 27 | 5 | 0 | 0 | 27 | 27 | 6 | 0.092302 | 12 |
| FunctionDef at line N of '<name>' | 26 | 3 | 0 | 0 | 26 | 24 | 4 | 0.082671 | 13 |
| a loop over None at line N of '<name>' | 26 | 5 | 0 | 0 | 26 | 0 | 5 | 0.385892 | 12 |
| FormattedValue at line N of '<name>' | 25 | 4 | 0 | 0 | 25 | 25 | 4 | 0.083124 | 12 |
| TypeError() on str at line N of '<name>' | 25 | 4 | 0 | 0 | 25 | 25 | 4 | 0.312184 | 12 |
| a keyword argument at line N of '<name>' | 25 | 4 | 0 | 0 | 25 | 24 | 5 | 0.083270 | 12 |
| bytearray() on nothing at line N of '<name>' | 25 | 4 | 0 | 0 | 24 | 0 | 4 | 0.159938 | 12 |
| '<name>' on None at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| '<name>', which holds builtin_function_or_method at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| Import at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 0 | 4 | 0.082546 | 12 |
| Nonlocal at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| Starred at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| a call of '<name>' that relies on a default that is _ZeroSentinel at line N of '<name>' | 24 | 2 | 0 | 0 | 24 | 0 | 2 | 0.056256 | 12 |
| an f-string field with a format or conversion at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| arithmetic on (nothing, nothing) at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| arithmetic on list[(nothing, (nothing, int))] at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| attribute '<name>' of int at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| attribute '<name>' of list[int] at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 0 | 4 | 0.082546 | 12 |
| attribute '<name>' of list[nothing] at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| bytearray() on int at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 0 | 4 | 0.082546 | 12 |
| len() on None at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| list method '<name>' at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| one value can be None or list[(nothing, (nothing, int))] | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| one value can be None or list[(nothing, nothing)] | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| one value can be None or list[nothing] | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| one value can be list[(nothing, (nothing, int))] or None | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| one value can be list[(nothing, int)] or None | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| operator Mod on str and (nothing) at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| operator Mod on str and (nothing, nothing) at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| operator Mod on str and (nothing, nothing, nothing, nothing) at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| operator Mod on str and (nothing, nothing, str) at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| print() on nothing at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| tuple() on list[None] at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 24 | 4 | 0.082546 | 12 |
| type() on str at line N of '<name>' | 24 | 3 | 0 | 0 | 24 | 0 | 4 | 0.082546 | 12 |
| '<name>' is not a plain method at line N of '<name>' | 18 | 2 | 0 | 0 | 0 | 0 | 0 | 0.024198 | 9 |
| bytes globals | 11 | 1 | 0 | 0 | 11 | 1 | 11 | 2.225951 | 0 |
| operator Mod on str and int at line N of '<name>' | 7 | 4 | 0 | 0 | 7 | 6 | 1 | 0.186679 | 1 |
| identity-guarded function values | 6 | 5 | 0 | 0 | 6 | 5 | 2 | 0.501310 | 1 |
| kwargs binding | 6 | 4 | 0 | 0 | 0 | 0 | 0 | 1.641099 | 0 |
| Global at line N of '<name>' | 5 | 3 | 0 | 0 | 5 | 0 | 1 | 0.242874 | 1 |
| Yield at line N of '<name>' | 4 | 3 | 0 | 0 | 4 | 4 | 0 | 0.479051 | 0 |
| a list that holds both ints and floats, or numbers and None at line N of '<name>' | 4 | 1 | 0 | 0 | 3 | 0 | 0 | 0.145618 | 0 |
| a range slice at line N of '<name>' | 4 | 2 | 0 | 0 | 4 | 4 | 1 | 0.779998 | 0 |
| one value can be None or list[list[int]] | 4 | 1 | 0 | 0 | 1 | 0 | 0 | 0.000842 | 0 |
| print() on str at line N of '<name>' | 4 | 2 | 0 | 0 | 4 | 4 | 0 | 0.027379 | 1 |
| '<name>', which holds function at line N of '<name>' | 3 | 3 | 0 | 0 | 3 | 1 | 2 | 0.257436 | 1 |
| '<name>', which holds type at line N of '<name>' | 3 | 3 | 0 | 0 | 1 | 1 | 1 | 0.390159 | 0 |
| With at line N of '<name>' | 3 | 2 | 0 | 0 | 1 | 1 | 0 | 0.535177 | 0 |
| a call of '<name>' that relies on a default that is type at line N of '<name>' | 3 | 1 | 0 | 0 | 0 | 0 | 0 | 1.481516 | 0 |
| a list holds both ints and floats, or floats and None | 3 | 1 | 2 | 0 | 0 | 0 | 0 | 0.000096 | 0 |
| a power other than ** 2 at line N of '<name>' | 3 | 1 | 0 | 0 | 3 | 0 | 0 | 1.481516 | 0 |
| generator '<name>' used other than by a loop or sum(), any(), ... at line N of '<name>' | 3 | 2 | 0 | 0 | 3 | 3 | 0 | 0.520346 | 0 |
| list() on range at line N of '<name>' | 3 | 2 | 1 | 0 | 1 | 0 | 1 | 0.073806 | 0 |
| tuple() on range at line N of '<name>' | 3 | 2 | 1 | 0 | 0 | 0 | 0 | 0.076185 | 0 |
| '<name>' customises allocation | 2 | 2 | 0 | 0 | 0 | 0 | 1 | 0.485683 | 0 |
| DictComp at line N of '<name>' | 2 | 2 | 0 | 0 | 0 | 0 | 2 | 0.027798 | 1 |
| a list comprehension inside another in '<name>' | 2 | 1 | 0 | 0 | 0 | 0 | 0 | 0.145522 | 0 |
| a loop with else in a generator at line N | 2 | 1 | 0 | 0 | 0 | 0 | 0 | 0.249172 | 0 |
| an argument of type bytes | 2 | 1 | 0 | 0 | 0 | 0 | 0 | 0.408666 | 0 |
| an int argument too large for 64 bits | 2 | 1 | 2 | 0 | 0 | 0 | 0 | 0.263655 | 0 |
| attribute '<name>' of str-or-None at line N of '<name>' | 2 | 1 | 0 | 0 | 2 | 2 | 2 | 0.001800 | 0 |
| memoryview() on str at line N of '<name>' | 2 | 1 | 0 | 0 | 2 | 0 | 2 | 0.009178 | 0 |
| memoryview() on str-or-None at line N of '<name>' | 2 | 1 | 0 | 0 | 2 | 0 | 2 | 0.001800 | 0 |
| no source for '<name>' | 2 | 1 | 0 | 0 | 0 | 0 | 0 | 0.237111 | 0 |
| repr() on str-or-None at line N of '<name>' | 2 | 1 | 0 | 0 | 2 | 2 | 2 | 0.001800 | 0 |
| result differs from a captured call | 2 | 1 | 0 | 0 | 0 | 0 | 0 | 0.007605 | 0 |
| '<name>' has a finalizer | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.011703 | 0 |
| '<name>', which holds bytes at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.000578 | 0 |
| '<name>', which holds str at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.229638 | 0 |
| ClassDef at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.000033 | 0 |
| Exception() on str at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.204381 | 0 |
| FileExistsError() on int, str at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.229638 | 0 |
| Lambda at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.270944 | 0 |
| a call of '<name>' that relies on a default that is bytes at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0.027842 | 0 |
| a call of '<name>' that relies on a default that is list at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.000067 | 0 |
| a list index that is None at line N of '<name>' | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.008695 | 0 |
| a list index that is str at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 1 | 0.008454 | 0 |
| a range in an aggregate or global | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.013629 | 0 |
| a repeated list of list[int] at line N of '<name>' | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.000067 | 0 |
| a slice with a step, or of an array at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0.000079 | 0 |
| aggregate/global values | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.204284 | 0 |
| an expression statement at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0.000337 | 0 |
| arithmetic on list[nothing] at line N of '<name>' | 1 | 1 | 1 | 0 | 1 | 0 | 0 | 0.000006 | 0 |
| as a region, only 8 of 10 captured calls ran compiled | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0.002732 | 0 |
| async for over something other than an async generator at line N of '<name>' | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.588555 | 0 |
| enumerate() on str at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 1 | 0.008454 | 0 |
| frozenset() on list[nothing] at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.000022 | 0 |
| globals() on nothing at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.022596 | 0 |
| list() on None at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0.073709 | 0 |
| list() on set[int] at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.000074 | 0 |
| math.cos at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0.000337 | 0 |
| one value can be None or list[None] | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.015399 | 0 |
| one value can be None or list[str] | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.229638 | 0 |
| one value can be int-or-float or str | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0.000337 | 0 |
| one value can be list[int] or (int, int, int) | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.000597 | 0 |
| one value can be range or list[None] | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.008695 | 0 |
| one value can be range or list[int] | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.008695 | 0 |
| operator Mod on str and (nothing, float, nothing, float) at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 1.801594 | 0 |
| operator Mod on str and (nothing, str) at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.011703 | 0 |
| operator Mod on str and None at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.229638 | 0 |
| operator Mod on str and str at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.022596 | 0 |
| range() needs one to three int/bool arguments at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.076062 | 0 |
| reversed() on list[(int, int)] at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0.000322 | 0 |
| reversed() on list[nothing] at line N of '<name>' | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0.000322 | 0 |
| setattr() on ManyInstanceVars, str, int at line N of '<name>' | 1 | 1 | 1 | 0 | 1 | 0 | 0 | 0.000001 | 0 |
| this del at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.008050 | 0 |
| unpacking list[int] into 10 names at line N of '<name>' | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0.000041 | 0 |

## Completion choices

Reliable greedy sequence: no eligible rows; baseline stays **60/375**.

The next tables are **optimistic observed-only conditional scenarios**, not predictions: they assume no additional blocker on every unknown path. Completion requires the entire observed family set, including callees, to be selected. Marginal counts are newly completed roots after prior choices; ties use known inclusive weight, then incidence, then family name. A zero marginal choice remains zero. Cumulative counts start at 60 and cannot count a root twice. Unsupported constructors/kwargs/defaults are not automatically solved by fallback calls. Broad call-family membership does not establish fallback safety.

### observed only

| Step | Family | Marginal | Conditional cumulative /375 | Known inclusive s newly covered | Missing weights |
|---:|---|---:|---:|---:|---:|
| 1 | object entry/constructor acceptance | 24 | 84 | 0.018562 | 2 |
| 2 | class values | 3 | 87 | 0.000069 | 2 |
| 3 | an int argument too large for 64 bits | 2 | 89 | 0.263655 | 0 |
| 4 | one value can be None or list[list[int]] | 2 | 91 | 0.000049 | 0 |
| 5 | Slice at line N of '<name>' | 2 | 93 | 0.000793 | 0 |
| 6 | a range slice at line N of '<name>' | 2 | 95 | 0.117734 | 0 |
| 7 | a list holds both ints and floats, or floats and None | 2 | 97 | 0.000022 | 0 |
| 8 | async for over something other than an async generator at line N of '<name>' | 1 | 98 | 0.588555 | 0 |
| 9 | as a region, only 8 of 10 captured calls ran compiled | 1 | 99 | 0.002732 | 0 |
| 10 | str method '<name>' at line N of '<name>' | 1 | 100 | 0.000153 | 0 |

### observed only weighted

| Step | Family | Marginal | Conditional cumulative /375 | Known inclusive s newly covered | Missing weights |
|---:|---|---:|---:|---:|---:|
| 1 | an int argument too large for 64 bits | 2 | 62 | 0.263655 | 0 |
| 2 | object entry/constructor acceptance | 24 | 86 | 0.018562 | 2 |
| 3 | as a region, only 8 of 10 captured calls ran compiled | 1 | 87 | 0.002732 | 0 |
| 4 | class values | 3 | 90 | 0.000069 | 2 |
| 5 | tuple() on range at line N of '<name>' | 1 | 91 | 0.000049 | 0 |
| 6 | list() on range at line N of '<name>' | 2 | 93 | 0.000097 | 0 |
| 7 | one value can be None or list[list[int]] | 2 | 95 | 0.000049 | 0 |
| 8 | Slice at line N of '<name>' | 2 | 97 | 0.000793 | 0 |
| 9 | a range slice at line N of '<name>' | 2 | 99 | 0.117734 | 0 |
| 10 | async for over something other than an async generator at line N of '<name>' | 1 | 100 | 0.588555 | 0 |

### observed only without wrappers

| Step | Family | Marginal | Conditional cumulative /375 | Known inclusive s newly covered | Missing weights |
|---:|---|---:|---:|---:|---:|
| 1 | object entry/constructor acceptance | 24 | 84 | 0.018562 | 2 |
| 2 | class values | 3 | 87 | 0.000069 | 2 |
| 3 | an int argument too large for 64 bits | 2 | 89 | 0.263655 | 0 |
| 4 | one value can be None or list[list[int]] | 2 | 91 | 0.000049 | 0 |
| 5 | Slice at line N of '<name>' | 2 | 93 | 0.000793 | 0 |
| 6 | a range slice at line N of '<name>' | 2 | 95 | 0.117734 | 0 |
| 7 | a list holds both ints and floats, or floats and None | 2 | 97 | 0.000022 | 0 |
| 8 | async for over something other than an async generator at line N of '<name>' | 1 | 98 | 0.588555 | 0 |
| 9 | as a region, only 8 of 10 captured calls ran compiled | 1 | 99 | 0.002732 | 0 |
| 10 | str method '<name>' at line N of '<name>' | 1 | 100 | 0.000153 | 0 |

### observed only weighted without wrappers

| Step | Family | Marginal | Conditional cumulative /375 | Known inclusive s newly covered | Missing weights |
|---:|---|---:|---:|---:|---:|
| 1 | an int argument too large for 64 bits | 2 | 62 | 0.263655 | 0 |
| 2 | object entry/constructor acceptance | 24 | 86 | 0.018562 | 2 |
| 3 | as a region, only 8 of 10 captured calls ran compiled | 1 | 87 | 0.002732 | 0 |
| 4 | class values | 3 | 90 | 0.000069 | 2 |
| 5 | tuple() on range at line N of '<name>' | 1 | 91 | 0.000049 | 0 |
| 6 | list() on range at line N of '<name>' | 2 | 93 | 0.000097 | 0 |
| 7 | one value can be None or list[list[int]] | 2 | 95 | 0.000049 | 0 |
| 8 | Slice at line N of '<name>' | 2 | 97 | 0.000793 | 0 |
| 9 | a range slice at line N of '<name>' | 2 | 99 | 0.117734 | 0 |
| 10 | async for over something other than an async generator at line N of '<name>' | 1 | 100 | 0.588555 | 0 |

## Weight concentration and sensitivity

Top five contributors per family (also in JSON):

- C/library calls (scalar/effect eligibility unknown): mdp.bench_mdp:247 1.8015937246527756s; base64.bench_a85_large:210 1.1814469263044884s; base64.bench_b32_large:138 0.5437674963322934s; base64.bench_b85_large:246 0.4292698961799033s; decimal_pi.bench_decimal_pi:38 0.36967098010063637s
- local definitions/global declarations: base64.bench_a85_large:210 1.1814469263044884s; base64.bench_b85_large:246 0.4292698961799033s; pidigits.gen_pi_digits:39 0.2709438561287243s; pathlib.setup:29 0.22963775326206814s; regex_v8.bench_regex_v8:1768 0.028516457212390378s
- bytes globals: base64.bench_a85_large:210 1.1814469263044884s; base64.bench_b32_large:138 0.5437674963322934s; base64.bench_b85_large:246 0.4292698961799033s; base64.bench_a85_small:184 0.027842024792334996s; base64.bench_b64_large:86 0.012441696264431812s
- operator Mod on str and (nothing, float, nothing, float) at line N of '<name>': mdp.bench_mdp:247 1.8015937246527756s
- kwargs binding: sympy.bench_expand:7 0.760560290858848s; sympy.bench_sum:18 0.3622839550371282s; sympy.bench_str:23 0.35867173832957633s; meteor_contest.main:212 0.1453760903532384s; json_dumps.bench_json_dumps:19 0.013628720844280906s
- function/class/global values (identity guards): decimal_pi.bench_decimal_pi:38 0.36967098010063637s; decimal_factorial.bench_decimal_factorial:34 0.3377430917462334s; pidigits.gen_pi_digits:39 0.2709438561287243s; pathlib.setup:29 0.22963775326206814s; meteor_contest.main:212 0.1453760903532384s
- a power other than ** 2 at line N of '<name>': sympy.bench_expand:7 0.760560290858848s; sympy.bench_sum:18 0.3622839550371282s; sympy.bench_str:23 0.35867173832957633s
- a call of '<name>' that relies on a default that is type at line N of '<name>': sympy.bench_expand:7 0.760560290858848s; sympy.bench_sum:18 0.3622839550371282s; sympy.bench_str:23 0.35867173832957633s
- Slice at line N of '<name>': async_generators.bench_async_generators:38 0.5885552392574027s; async_generators.tree:31 0.07654738328710664s; nqueens.permutations:9 0.07606218497676309s; generators.bench_generators:36 0.07370850855659228s; generators.tree:29 0.04118643049150705s
- a range slice at line N of '<name>': async_generators.bench_async_generators:38 0.5885552392574027s; async_generators.tree:31 0.07654738328710664s; generators.bench_generators:36 0.07370850855659228s; generators.tree:29 0.04118643049150705s

leave largest function: ['mdp', 'bench_mdp', 247]
Recomputed weighted sequence: an int argument too large for 64 bits (+2, 62/375); object entry/constructor acceptance (+24, 86/375); as a region, only 8 of 10 captured calls ran compiled (+1, 87/375); class values (+3, 90/375); tuple() on range at line N of '<name>' (+1, 91/375); list() on range at line N of '<name>' (+2, 93/375); one value can be None or list[list[int]] (+2, 95/375); Slice at line N of '<name>' (+2, 97/375); a range slice at line N of '<name>' (+2, 99/375); async for over something other than an async generator at line N of '<name>' (+1, 100/375)

leave largest program: base64
Recomputed weighted sequence: an int argument too large for 64 bits (+2, 62/375); object entry/constructor acceptance (+24, 86/375); as a region, only 8 of 10 captured calls ran compiled (+1, 87/375); class values (+3, 90/375); tuple() on range at line N of '<name>' (+1, 91/375); list() on range at line N of '<name>' (+2, 93/375); one value can be None or list[list[int]] (+2, 95/375); Slice at line N of '<name>' (+2, 97/375); a range slice at line N of '<name>' (+2, 99/375); async for over something other than an async generator at line N of '<name>' (+1, 100/375)

## S50 and next capability

The S54 construct-level fallback capability is next by steering, ahead of native table choices. The function-value target is spectral_norm eval_times_u; constructor-helper target is scimark Random.__init__ calling initialize. They must be tested on those programs, regardless of count-only table rank. The diagnostic does not prove that either outer function completes. Exact fallbacks, callable guards, constructor state, opaque lifetime and post-effect guard handling remain requirements.

Existing three-pair, 20-loop unmodified selection: scimark CPython 7.454360s / RecomPyler 4.408065s (1.6911x); spectral_norm 1.593662s / 1.369898s (1.1633x). Both deploy two fully native functions, with 0 fallback sites; test activity was recorded. No census gain or newly unlocked wall time is inferred. A new S54 result must remeasure these programs and newly deploying programs.

## Limits and steering request

The strict completion table is empty because the bounded continuation does not recover sound types/state beyond every refusal. Treat the observed-only ordering as leads for tests, not reliable marginal benefit. Please accept this partial census under S51.3 and let S54 proceed using executable target cases; exhaustive forecasts would require a separate analysis capability. This diagnostic does not change default product acceptance.

A captured function in a nested input path may be omitted by the collector basename prefilter and stays unknown. Structural traversal may visit unreachable branches and nested declarations. Inlined reasons carry callsite locations separately from callee source. None of these are proof of a supported or unsupported executable path.
