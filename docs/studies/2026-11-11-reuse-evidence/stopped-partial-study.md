# Stopped partial measurement: afd09b0

At coordinator instruction, the first wave3 fixed study was stopped after a static mixed-signature coverage regression was found in candidate `afd09b0b2b5e868a71b20a04e22907aade64b6a0`. Baseline remains `dba45a7379402ea33664a5754a2fe6f0927b6855`. `results/` is a partial, frozen evidence set and must not be resumed or overwritten. No final population performance claim is supported.

Windows read-only process inspection initially returned Access denied. Scoped elevated inspection then identified exact study parent PID39796. `taskkill /PID39796 /T /F` terminated that parent and its current child PID21544 only. The tracked execution session9264 exited1. Follow-up process inspection found neither PID, their descendants, nor any Python command targeting wave3-study/results. The exclusive measurement slot was explicitly released before product testing resumed.

Completed full workloads: async_generators, asyncio_tcp, asyncio_websockets, barnes_hut. Each has both fresh profiles, both compile-only warmups, all15 ordinary timing records and all10 untimed audit records. Their audits reconciled and their outputs/exits matched.

Base64 completed both profiles, both warmups and14 ordinary timing children; its last completed record is candidate-4 at 2026-11-12T00:28:57.993694+00:00. The plain-4 child was interrupted before a completed JSON record could be persisted. Base64 audits and subsequent workloads did not start. There are134 completed per-program subprocess records plus two successful native-extension import preflight records.

Existing raw stdout/stderr, plans, caches, bytecode inventories, summary and manifest were preserved. No frozen harness, product source or manifest was edited. The corrected candidate requires a new results-v2 directory, fresh profiles for both sources, and a new explicit measurement slot; this partial run will not resume automatically.
