# Wave8 fresh selected AOT and C comparison

The actual binaries remove the intended redundant physical list-address work. The finite semantic/state checks pass. The fresh timing distributions overlap; this cohort does not establish a stable speedup or an instruction-to-cycle attribution.

Independent read-only review of current93986c89/producta033ca1 versus final411624630f818bc548a3183e3a25cecf13116640. The coordinator integrated the latter as162ef01 without changing tested product bytes. Both sources received fresh target-only profiles/builds for Barnes and raytrace; no old profiles, artifacts or latency samples were reused by this study. Reviewer executed only static disassembly and standard-library metadata/state checks, never the artifacts/workloads. Study manifest SHA256836382bb3dbdfdcf67a46c45a1f65ce8137a108e0a00cdcd404426a743fa00e2.

## Provenance and semantic checks

| Case | Actual selected digest | Artifact SHA256 | Export / wrapper |
|---|---|---|---|
| Barnes current | 8b850a3ec40ed1c9992ac80e245679f7e785fa6b866f2c2a6a64d7f9f892e495 | 04b0aa1bd9bfeda8e7ee5ff62c48387c2599e686202cffcaddbb1148db5ccf95 | r0 /0x1800011d0 |
| Barnes final | fbc6f83614deee922decaefa802a50c2e8ed8f00a510f99f3351a328c23eac71 | 7c1bfc3e5c3eae92a8a75e3fe13cf0bd93996274b762e4a3723d8ccd98f44c6c | r0 /0x1800011d0 |
| raytrace current | de39e8545ceea82bdcb2cf264e5dbfb9c41aa7fc53966b95558d1859f23f2fff | c90fe871bc362c55a1157754424a28dee9dac0e7aa531a3da67e0f156ccadac5 | r0 /0x1800011a0 |
| raytrace final | 42761df0d821422b7eb8eebdafa0dad92c55a6956b5f4571024fa84aafe924d8 | c5f726b445dec8376bac1500f13e6925c0c5ab232b0c2ba4d34d5706d7dde4d5 | r0 /0x1800011a0 |

Every static PyMethodDef map agrees with the study's runtime wrapper map. Each selected audit records100 successful AOT calls for Barnes or1 for raytrace, zero JIT/fallback/rejected/unknown and no Numba import. Reviewer checked selected digest→plan export→frozen PE hash, then independently compared retained state dictionaries against plain Python: Barnes initial/final vectors and all100 intermediate checkpoints; raytrace complete30000-byte image and before/after type/dimension/identity observations. These finite checks do not claim equivalence for arbitrary Python inputs.

All provenance, full disassemblies, bounded excerpts, counts and verification are under `actual-artifacts/`. `verification.json` binds state equality and maps; `static-counts.json` records exact ranges and counting rules. Old static C excerpts are reused only because the actually measured C binaries are byte-identical: Barnes SHA2564fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff; raytrace3913b4bb6c6203042230c72da1fa46b6cad7899281c3cd3f2764fce29f7a2abc.

## Barnes: two adjustments removed, one proof boundary remains

Both wrappers call public array adapter0x180001090, which calls borrowed advance body0x1800025d0. Its force call reaches0x180002c30. The source/call-target-bound force interval remains[0x180002c30,0x180003260); its four recursive calls remain at2f78/3034/30e4/31d5. Do not infer function identity from the nearest exported PyInit label printed by objdump.

| Static force measure | Current | Final | Unchanged C force |
|---|---:|---:|---:|
| Instruction lines, including padding |341|339|116|
| Padding instructions included |1|1|1|
| Address span, bytes |1584|1584|480|
| Stack-operand instruction lines |69|69|22|
| Local stack reservation, bytes |280|280|88|
| Outgoing recursive stack-argument slots |6|6|0|
| Exact2**53 constant references |6|6|0|

The C force interval is[0x140002710,0x1400028f0). Stack reservation excludes pushes/saved registers and is not total dynamic stack consumption. The six native outgoing slots occupy0x20..0x48; the C routine uses four register arguments (node/index/out-x/out-y) and specializes theta0.5. Final force has only four direct calls, all self-recursive; no new allocation or NRT ownership calls appear in this body. Tagged returned numeric values, recursion/status checks, field layout and precision guards remain.

Source `if len(self.particles) == 1 and self.particles[0] == particle` shows the bounded optimization's limitation. Current matched particle test[2cb6,2cf1) contains16 instructions; final[2cc6,2cf1) contains11. Final directly loads header+2 and the item, dropping their negative-address adjustments. But len() was deliberately out of scope: final2ccf/2cd3 still computes the signed length-header correction. LLVM cannot equate that signed address with the unsigned checked-index header. It therefore retains a separate `cmpq $0,(%rax)`/`jle` at2cdd/2ce1 before item access, with a dedicated failure block. This explains why the whole force body loses only two static instructions despite the smaller local test. It is an observed proof boundary, not a new correctness defect or a reason to silently expand the frozen patch.

The six exact-magnitude checks around mixed coordinate arithmetic remain. Removing them requires a different proof about runtime numeric kinds/values; C's double-only structs and specialized parameter are different assumptions. Static339 versus116 is not a threefold runtime tax.

## Raytrace: repeated pixel-store pattern removed

Wrapper0x1800011a0 calls array adapter0x180001090, then borrowed render0x1800019d0. The render interval ends at the next called helper: current0x180002fc0, final0x180002f10. That helper contains ray-colour work; the table counts the render body and inlined work only, not the complete recursive renderer.

| Static render measure | Current | Final |
|---|---:|---:|
| Instruction lines, including padding |1037|999|
| Padding instructions included |1|2|
| Non-padding instruction lines |1036|997|
| Address span, bytes |5616|5440|
| Stack-operand instruction lines |133|118|
| Local stack reservation, bytes |488|472|
| Exact2**53 constant references |37|37|

The matched RGB conversion/clamp/index/store block is current[2c28,2ea4),132 instructions, versus final[2c49,2ded),93. Its indexed-store subranges are red24→13, green27→11, blue22→11 instructions. The current block contains six `sarq $0x3f` sign adjustments (header and final item address for each channel) and three `cmovlq` header+2 adjustments. All nine physical-address adjustments disappear in final. The broad clamp/conversion block also changes register allocation/spills, so the39-instruction difference is not nine instructions or a dynamic-cycle estimate.

Example final red path2c9b–2cc9: load canvas byte-array handle, load length directly, retain logical sign test/negative adjustment and lower/upper failure branches, load data base directly, store at data+normalized-index. Green and blue retain corresponding logical checks. Integer index-overflow/status guards and RGB conversion/clamping remain; byte storage still uses int64 heap slots. C's corresponding RGB clamp/store context uses direct byte stores at0x140001a02/1a1c/1a39. Its fixed-width output loop, direct object structs and byte buffer are a different representation/contract, so no full C-versus-Python render instruction ratio is asserted.

## Fresh timings and remaining gap

Five rotating fresh children per mode/workload; Python/RP report best of five reset states per child, C best of twenty. All raw samples and process walls remain in the study. Kernel medians:

| Workload | Current ms | Final ms | C ms | Final/current time change | Current/C | Final/C |
|---|---:|---:|---:|---:|---:|---:|
| Barnes |36.3475|36.2738|9.134054|-0.20%|3.9793x|3.9713x|
| raytrace |3.9311|3.8272|0.604630|-2.64%|6.5017x|6.3298x|

Barnes current range35.7194–39.4751ms overlaps final35.7056–36.6420ms. Raytrace current3.6813–4.0087ms overlaps final3.6470–4.6544ms. These small cohorts do not establish a stable gain. Process-wall medians are separate: Barnes512.0595→509.1083ms; raytrace420.3720→430.0978ms. Do not turn the lower ray kernel median into a whole-process improvement claim. There are no phase measurements in this cohort.

Ordinary timing counters total2500AOT/source for Barnes and25AOT/source for raytrace, with zero JIT/fallback. Kernel boundaries retain setup/energy behavior: Barnes final energy is inside its timed interval but outside selected advance_system; raytrace times fresh Canvas/Scene construction and rendering while C allocates its byte buffer outside its timed loop. Generic RP AOT CPU targeting versus C -march=native remains an unmeasured tuning difference, and background host load is uncontrolled.

## Attribution and verdict

AST inspection of both unchanged complete driver sources finds zero subscript AugAssign nodes. The inherited mutating-RHS repair therefore has no direct lowering site in these two workloads. Fixture before/after captures isolate the physical-index annotation on top of the already-repaired base. Startup changes occur in the runner and can affect process wall; they are not native instruction removal. The current/final timing comparison still contains all three changes and does not isolate causal percentages.

Verdict: actual selected AOT substantiates the bounded instruction-removal claim while retaining Python checks and the validated finite outputs/types/aliases. It also exposes remaining signed len()/physical-address CSE limits and substantial representation/semantic differences from C. The implementation remains a verified general proof rule plus a separately tested correctness repair; a stable workload speedup is unproven here.

After this report's411 evidence was collected, the coordinator authorized a separate bounded follow-up to apply the identical validated-list-header proof at ListT/ArrT len/truth reads. That future change uses a new source freeze, tests and native cohort; it does not alter or supersede these raw411 results. Its motivation is the actual address-consistency/CSE gap, not an inference of significant speedup from the overlapping timings.
