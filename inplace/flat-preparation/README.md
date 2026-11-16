# Private flat JIT prototype

Build inside this clone with the installed exact Python 3.14.4 Windows toolchain:

    python inplace/flat-preparation/setup_flat.py build_ext --force --inplace

With src on PYTHONPATH, use recompyler._flat.FlatLifted(original_function).
This reuses checked Lifted lowering; it does not activate default Region routing,
saved AOT or deployment selection. See KNOWN-GAPS.md for current eligibility.

Tests: python -m pytest tests/test_flat_protocol.py -q
Real target checks: python -m pytest inplace/flat-preparation/test_flat_targets.py -q
Below-normal runner: python inplace/run_low.py <raw-log.txt> <command...>
Ten-minute shared-oracle consumer: python inplace/run_low.py <raw-log.txt> python inplace/flat-preparation/fuzz_flat.py 10
The oracle currently comes from the merged tools/difffuzz/core.py;
the consumer adds exact array typecode/itemsize/bytes/alias support.

Timing: python inplace/flat-preparation/time_locked.py <label> python inplace/flat-preparation/measure_flat.py
This holds TIMING.lock, compares unchanged20-loop bodies and complete calls in
three alternating warmed pairs, records exact boundary traces before timing,
and writes only a raw output file. Do not overlap your own correctness workers.

Field-only member focused tests: python -m pytest tests/test_flat_members.py -q
Ten-minute member oracle: python inplace/run_low.py <raw-log.txt> python inplace/flat-preparation/fuzz_members.py 10
The member type holds no application class metadata; array contents use the checked opaque buffer protocol with byte undo. Original methods and reference stores decline.
