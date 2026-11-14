The source-only helper receipt describes the original coverage-worker copy.
Before this separate cohort's metadata freeze, the measurements owner added:

* Per-command Git safe.directory for the exact authorized source path, so the
  metadata reader works under both workspace and compiler execution identities.
  No global Git configuration is changed.
* Full package source/native/license inventory in state artifact identity,
  including the vendored C mixin and AOT builder. No source suffix is omitted.
* Raw state-audit export counters distinguish successful, arena-growth and other
  statuses. A 256x256 image plus list headers can exceed the initial 65536-slot
  arena, so one completed AOT call can legitimately enter its export repeatedly.
  All extra entries must be observed status2 growth retries; exact RNG/state
  equality and one successful completion remain mandatory.

These change provenance collection only. The workload, selection policy, source
compiler and loop counts are unchanged. The new study manifest records the
adapted helper hashes. No original helper or result was edited.
