# Evidence archive

Read [the combined report](../2026-11-11-integration.md) first. This directory retains historical reports and compact measurements, including failures and negative results. Individual track reports describe the state at their recorded revision; later findings in the combined report and AOT deployment audit supersede earlier interpretations.

- `study-v1.md` measured `75aefc1`; `study-v2.md` measured `dc02b95`. The corrected study uses fresh integrated profiles and fresh latency samples, but reuses unchanged baseline profiles with recorded provenance.
- Historical `ahead_of_time` flags indicate artifact availability, not proven AOT execution. The three `aot-*-audit*.json` files and `aot-deployment-audit.md` distinguish actual prepared execution, unexpected JIT, and the final budget safeguard.
- The benchmark kernel source was unchanged by the final runner-only commits `d25b225` and `ee03841`. The full 49-program timing study was not repeated after these commits. Focused process tests, three real longer-workload audits and the final full test suite cover their behavior.
- `final-suite.txt` is the complete final worker suite transcript. Its source and tests were compared byte-for-byte through Git with the integration branch before this documentation archive was added.
- `metrics.json` stores compact per-program measurements, source revisions and limitations. Full raw artifacts remain in the original workspace described by the combined report. Historical harnesses require that layout or adaptation and a new manifest.
- `archive-sha256.json` hashes every other file in this directory for local integrity checks. It is not a signature or independent attestation.

Archive text uses LF line endings and a single final newline; the original raw files remain at the recorded workspace locations.

Opportunity figures are the largest verified candidate's profiled share, not total native coverage. Warm kernel comparisons and the longer-workload diagnostic are separate from default complete-process headline results.
