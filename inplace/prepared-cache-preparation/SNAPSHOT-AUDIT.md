# Snapshot attachment audit (development; not independent approval)

The source under current-v2 is frozen while its tests wait/run. Static review identifies a further observer window to test before accepting:

- `_restore` currently fingerprints a function, then snapshots its current code/default/cell identities. A mutation after fingerprinting could become the new accepted guard. Capture identity references before validation and require the same references after it; use those original identities for live guards.
- Class dictionary/MRO snapshot attachment has the same ordering concern. Snapshot before `_class_key`, check identity equality afterward, and retain the before snapshot.
- Existing final live binding and per-call checks must remain. Do not treat pinning as a replacement for stable definitions.

`test_prepared_snapshot_window.py` injects mutations at the exact function/class fingerprint return boundary, without invoking native code or relying on a scheduler. Run it fail-first against the frozen current implementation only after current-v2 releases, then implement the fix and re-run the focused proofs. This note is the implementer's own audit, not the requested independent implementation review.
