# Item 1 first implementation design

Start with a general relational induction rule, not workload-name recognition. A stable one-dimensional numeric array plus range-derived index has bounds relative to an entry parameter or its length. Collect an extent guard once at function entry; emit a fast body only under that guard and retain the existing checked body as the other version. An extent guard also confirms signed integer size and a true fixed-size NumPy array, so mutable typed lists/records cannot enter the unchecked path. Arithmetic used to form the index is raw only if interval evaluation proves all integer intermediates within signed 64 bits. Decline loop-carried values, unknown induction, rebinding of parameters, branch joins not proved, and unrecognized calls.

The shared facts API returns proven / guarded / unknown plus reason and guard. Existing `_fixed_lists` and initialization/iterator facts feed F2/F3 through this API, rather than competing with a second escape proof. Rule declarations name required facts and emitted helpers; one versioning implementation collects their guards and builds the fast/checked selection. Each analyzed function retains fired and blocked sites and unknown facts. Cache identity includes analysis source.

The first measured payoff should be FFT_inverse range(N), along with any matching independent loops. This is a subset of the full FFT/fannkuch relational requirement; the remaining butterfly/bitreverse/permutation invariants must be enumerated and investigated before moving to item 2. This does not discharge floating arithmetic by itself.

Fail-first tests: guarded bounds with valid and invalid extents; negative/empty/too-large extents; affine i+1 through nested loops; reassigned induction variable; changing stop variable; array alias stores; source mutation; tuple/list fallback; uint64/float bound rejection; no speculative unsafe access when guard misses; raw arithmetic only when every intermediate is bounded. Compare full arrays including signed-zero/NaN bytes for the cases that perform FP arithmetic, and keep fallback/error behaviour.

## S17 per-check generated-source inventory

Every helper-call site is listed, including float helpers whose typed implementation already lacks integer checks. Loop status polls stay checked (F9 unknown). Function calls and copy/owner helpers are not relabelled as numeric/bounds checks.

| Function:line | Emitted check site | Needed inequality / fact | First design |
|---|---|---|---|
| _rcv1_int_log2:5 | `_rc_nmul(_rc_st, k, 2)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_int_log2:6 | `_rc_nadd(_rc_st, log, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_int_log2:7 | `_rc_lshift(_rc_st, 1, log)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:12 | `_rc_floordiv(_rc_st, N, 2)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:13 | `_rc_sub(_rc_st, n, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:18 | `_rc_lshift(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:19 | `_rc_lshift(_rc_st, j, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: carry relation missing |
| _rcv2_FFT_bitreverse:20 | `_rc_rshift(_rc_st, n, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:22 | `_rc_getitem(_rc_st, data, ii)` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | guard/prove |
| _rcv2_FFT_bitreverse:23 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, ii, 1))` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | guard/prove |
| _rcv2_FFT_bitreverse:23 | `_rc_add(_rc_st, ii, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:24 | `_rc_setitem(_rc_st, data, ii, _rc_getitem(_rc_st, data, jj))` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | leave: j/carry relation missing |
| _rcv2_FFT_bitreverse:24 | `_rc_getitem(_rc_st, data, jj)` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | leave: j/carry relation missing |
| _rcv2_FFT_bitreverse:25 | `_rc_setitem(_rc_st, data, _rc_add(_rc_st, ii, 1), _rc_getitem(_rc_st, data, _rc_add(_rc_st, jj, 1)))` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | leave: j/carry relation missing |
| _rcv2_FFT_bitreverse:25 | `_rc_add(_rc_st, ii, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv2_FFT_bitreverse:25 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, jj, 1))` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | leave: j/carry relation missing |
| _rcv2_FFT_bitreverse:25 | `_rc_add(_rc_st, jj, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: carry relation missing |
| _rcv2_FFT_bitreverse:26 | `_rc_setitem(_rc_st, data, jj, tmp_real)` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | leave: j/carry relation missing |
| _rcv2_FFT_bitreverse:27 | `_rc_setitem(_rc_st, data, _rc_add(_rc_st, jj, 1), tmp_imag)` | 0<=index<N<=len(data); i<n-1 proves ii and ii+1; j<n needs bit-reversal loop invariant | leave: j/carry relation missing |
| _rcv2_FFT_bitreverse:27 | `_rc_add(_rc_st, jj, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: carry relation missing |
| _rcv2_FFT_bitreverse:29 | `_rc_sub(_rc_st, j, k)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: carry relation missing |
| _rcv2_FFT_bitreverse:30 | `_rc_rshift(_rc_st, k, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: carry relation missing |
| _rcv2_FFT_bitreverse:31 | `_rc_nadd(_rc_st, j, k)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: carry relation missing |
| _rcv3_FFT_transform_internal:34 | `_rc_floordiv(_rc_st, N, 2)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:47 | `_rc_div(_rc_st, _rc_mul(_rc_st, _rc_mul(_rc_st, 2.0, direction), 3.141592653589793), _rc_mul(_rc_st, 2.0, float(dual)))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:47 | `_rc_mul(_rc_st, _rc_mul(_rc_st, 2.0, direction), 3.141592653589793)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:47 | `_rc_mul(_rc_st, 2.0, direction)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:47 | `_rc_mul(_rc_st, 2.0, float(dual))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:48 | `_rc_sin(_rc_st, theta)` | finite theta bounded by guarded direction and dual>=1; bounded entry direction + geometric dual | guard/prove |
| _rcv3_FFT_transform_internal:49 | `_rc_sin(_rc_st, _rc_div(_rc_st, theta, 2.0))` | finite theta bounded by guarded direction and dual>=1; bounded entry direction + geometric dual | guard/prove |
| _rcv3_FFT_transform_internal:49 | `_rc_div(_rc_st, theta, 2.0)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:50 | `_rc_mul(_rc_st, _rc_mul(_rc_st, 2.0, t), t)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:50 | `_rc_mul(_rc_st, 2.0, t)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:51 | `_rc_step(_rc_st, _rc_mul(_rc_st, 2, dual))` | 0<2*dual<=n<=2**24; geometric induction | guard/prove |
| _rcv3_FFT_transform_internal:51 | `_rc_mul(_rc_st, 2, dual)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:54 | `_rc_mul(_rc_st, 2, b)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:55 | `_rc_mul(_rc_st, 2, _rc_add(_rc_st, b, dual))` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:55 | `_rc_add(_rc_st, b, dual)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:56 | `_rc_getitem(_rc_st, data, j)` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:57 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, j, 1))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:57 | `_rc_add(_rc_st, j, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:58 | `_rc_setitem(_rc_st, data, j, _rc_sub(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:58 | `_rc_sub(_rc_st, _rc_getitem(_rc_st, data, i), wd_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:58 | `_rc_getitem(_rc_st, data, i)` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:59 | `_rc_setitem(_rc_st, data, _rc_add(_rc_st, j, 1), _rc_sub(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:59 | `_rc_add(_rc_st, j, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:59 | `_rc_sub(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:59 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:59 | `_rc_add(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:60 | `_rc_setitem(_rc_st, data, i, _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:60 | `_rc_nadd(_rc_st, _rc_getitem(_rc_st, data, i), wd_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:60 | `_rc_getitem(_rc_st, data, i)` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:61 | `_rc_setitem(_rc_st, data, _rc_add(_rc_st, i, 1), _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:61 | `_rc_add(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:61 | `_rc_nadd(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:61 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:61 | `_rc_add(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:65 | `_rc_sub(_rc_st, _rc_sub(_rc_st, w_real, _rc_mul(_rc_st, s, w_imag)), _rc_mul(_rc_st, s2, w_real))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:65 | `_rc_sub(_rc_st, w_real, _rc_mul(_rc_st, s, w_imag))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:65 | `_rc_mul(_rc_st, s, w_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:65 | `_rc_mul(_rc_st, s2, w_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:66 | `_rc_sub(_rc_st, _rc_add(_rc_st, w_imag, _rc_mul(_rc_st, s, w_real)), _rc_mul(_rc_st, s2, w_imag))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:66 | `_rc_add(_rc_st, w_imag, _rc_mul(_rc_st, s, w_real))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:66 | `_rc_mul(_rc_st, s, w_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:66 | `_rc_mul(_rc_st, s2, w_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:69 | `_rc_step(_rc_st, _rc_mul(_rc_st, 2, dual))` | 0<2*dual<=n<=2**24; geometric induction | guard/prove |
| _rcv3_FFT_transform_internal:69 | `_rc_mul(_rc_st, 2, dual)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:72 | `_rc_mul(_rc_st, 2, _rc_add(_rc_st, b, a))` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:72 | `_rc_add(_rc_st, b, a)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:73 | `_rc_mul(_rc_st, 2, _rc_add(_rc_st, _rc_add(_rc_st, b, a), dual))` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:73 | `_rc_add(_rc_st, _rc_add(_rc_st, b, a), dual)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:73 | `_rc_add(_rc_st, b, a)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:74 | `_rc_getitem(_rc_st, data, j)` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:75 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, j, 1))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:75 | `_rc_add(_rc_st, j, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:76 | `_rc_sub(_rc_st, _rc_mul(_rc_st, w_real, z1_real), _rc_mul(_rc_st, w_imag, z1_imag))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:76 | `_rc_mul(_rc_st, w_real, z1_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:76 | `_rc_mul(_rc_st, w_imag, z1_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:77 | `_rc_add(_rc_st, _rc_mul(_rc_st, w_real, z1_imag), _rc_mul(_rc_st, w_imag, z1_real))` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:77 | `_rc_mul(_rc_st, w_real, z1_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:77 | `_rc_mul(_rc_st, w_imag, z1_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:78 | `_rc_setitem(_rc_st, data, j, _rc_sub(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:78 | `_rc_sub(_rc_st, _rc_getitem(_rc_st, data, i), wd_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:78 | `_rc_getitem(_rc_st, data, i)` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:79 | `_rc_setitem(_rc_st, data, _rc_add(_rc_st, j, 1), _rc_sub(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:79 | `_rc_add(_rc_st, j, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:79 | `_rc_sub(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:79 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:79 | `_rc_add(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:80 | `_rc_setitem(_rc_st, data, i, _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, i), wd_real))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:80 | `_rc_nadd(_rc_st, _rc_getitem(_rc_st, data, i), wd_real)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:80 | `_rc_getitem(_rc_st, data, i)` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:81 | `_rc_setitem(_rc_st, data, _rc_add(_rc_st, i, 1), _rc_nadd(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:81 | `_rc_add(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:81 | `_rc_nadd(_rc_st, _rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1)), wd_imag)` | float/float has no integer overflow check; mixed operand must be exactly representable; divisor nonzero for division; existing typed overload; direction guard and dual>=1 for theta | guard/prove |
| _rcv3_FFT_transform_internal:81 | `_rc_getitem(_rc_st, data, _rc_add(_rc_st, i, 1))` | 0<=2*(b+a+dual)+1<=2*n-1=N-1; d power2,2d<=n; b<=n-2d; a<=d-1; len(data)=2n | guard/prove |
| _rcv3_FFT_transform_internal:81 | `_rc_add(_rc_st, i, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:82 | `_rc_nadd(_rc_st, bit, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv3_FFT_transform_internal:83 | `_rc_nmul(_rc_st, dual, 2)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_fannkuch:2 | `_rc_add(_rc_st, n, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_fannkuch:4 | `_rc_sub(_rc_st, n, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_fannkuch:12 | `_rc_setitem(_rc_st, count, _rc_sub(_rc_st, r, 1), r)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:12 | `_rc_sub(_rc_st, r, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_fannkuch:13 | `_rc_sub(_rc_st, r, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_fannkuch:14 | `_rc_index(_rc_st, perm1, 0)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:14 | `_rc_getitem(_rc_st, perm1, m)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:20 | `_rc_index(_rc_st, perm, 0)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:22 | `_rc_moveslice(_rc_st, perm, k, None, -1, None, _rc_add(_rc_st, k, 1), None)` | 1<=k<n, prefix k+1<=len(perm); same-list reversal preserves [0,n) content; permutation provenance + nonzero branch | guard/prove |
| _rcv1_fannkuch:22 | `_rc_add(_rc_st, k, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |
| _rcv1_fannkuch:23 | `_rc_nadd(_rc_st, flips_count, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: count content/flips-count bound missing |
| _rcv1_fannkuch:24 | `_rc_index(_rc_st, perm, 0)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:28 | `_rc_rotate(_rc_st, perm1, r, 0)` | 0<=0<r<n=len(perm1); rotation preserves [0,n) content; bounded r induction + permutation provenance | guard/prove |
| _rcv1_fannkuch:29 | `_rc_setitem(_rc_st, count, r, _rc_sub(_rc_st, _rc_getitem(_rc_st, count, r), 1))` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:29 | `_rc_sub(_rc_st, _rc_getitem(_rc_st, count, r), 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | leave: count content/flips-count bound missing |
| _rcv1_fannkuch:29 | `_rc_getitem(_rc_st, count, r)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:30 | `_rc_getitem(_rc_st, count, r)` | 0<=index<n=len(array); r decreases to 1 / increases to n; m=n-1; n>=1 | guard/prove |
| _rcv1_fannkuch:32 | `_rc_nadd(_rc_st, r, 1)` | every integer intermediate in int64; shift count in [0,63); nonzero divisor; bounded N/n/dual/a/b/r/k and literal positive divisors | guard/prove |

Counts (site hypotheses, not timing or emitted machine-check counts):

{
  "_rcv1_int_log2": {
    "total_helper_sites": 3,
    "guard_prove": 3,
    "leave": 0,
    "typed_float": 0
  },
  "_rcv2_FFT_bitreverse": {
    "total_helper_sites": 20,
    "guard_prove": 8,
    "leave": 12,
    "typed_float": 0
  },
  "_rcv3_FFT_transform_internal": {
    "total_helper_sites": 76,
    "guard_prove": 76,
    "leave": 0,
    "typed_float": 29
  },
  "_rcv1_fannkuch": {
    "total_helper_sites": 18,
    "guard_prove": 16,
    "leave": 2,
    "typed_float": 0
  }
}

## Revised first version after S17

The affine-only pilot is superseded before implementation. The first version must also prove geometric induction and nested dependent strides. Represent integer expressions as affine forms over ordered loop symbols; substitute bounds from innermost induction outward so `b <= n-2*dual` and `a <= dual-1` cancel the correlated `dual` terms in `2*(b+a+dual)+1`. A loop-count summary is admitted only from inspected source proving an exact power-of-two logarithm, not the callee name. With `dual=1`, `dual*=2`, `bit=0`, `bit+=1`, and `bit<log2(n)`, the body has `1<=dual<=n/2` and `2*dual` divides power-of-two n. A synthesized entry guard checks signed integer extent, positive even N, power-of-two N/2 and stable one-dimensional numeric array length N. General descending geometric induction can use the same domain where a positive power-of-two seed shrinks by a positive constant factor; unknown carry-dependent loops remain checked.

The design targets 8 of 20 bitreverse helper sites, all 47 transform numeric/bounds sites other than the 29 already-typed-float helper calls, plus 3 logarithm sites: 58 of 70 potentially checked sites (82.9%). This exceeds half without treating already-raw float helpers as a gain. Twelve bitreverse carry-related sites remain checked because proving j/k requires the relation between the outer iteration and carry state; no rollback substitutes for their bounds proof. Status polls and unknown failures remain.

For fannkuch, establish content provenance from private `list(range(n))`, propagate it through full copy, in-place prefix reversal and insert(pop) rotation only, and invalidate it for every other element write or escape. Content then proves loaded permutation elements in [0,n). Local r starts at n, decreases by one to literal 1, and increases by one to unchanged n; a bounded-control fixed point over these two loops proves 1<=r<=n and inside the increasing body r<n. Guard n>=1 and bounded int64 extent at entry. The first version targets 16 of 18 helper sites; flips_count growth and count-element subtraction remain checked. Construction/copy/owner work remains unchanged. Test the provenance on mutated, aliased, escaped, empty and float-element variants: all must retain checks or decline. These are design counts until generated-code review and timing confirm them.
