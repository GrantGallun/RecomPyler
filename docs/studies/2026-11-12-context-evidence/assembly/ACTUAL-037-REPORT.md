# Refined037 actual AOT/C results

The refined strict implementation improves both selected kernels in this fresh
cohort. Actual AOT retains the compact recursive interface and eliminates the
repeated descriptor reads introduced by the first578 prototype. These are
separate instruction facts and timing observations; they do not apportion
elapsed time to instruction classes or establish universal Python speedups.

Candidate0373788 uses heap raw SHA2567904ae104331ea666cdcf0b577900771d2b2530f9b3ad28670480ef9e78c40b4.
Fresh study manifest095ecab621b1cf7876b3c165fb7bef5bc9ae4088512c3fcd7b8a6c3d63fe9133
compares saveda9b against037 and unchanged C. It does not reuse578 profiles,
artifacts or timings. The578 regression report/archive remains unchanged.

All output below is independently read-only: PE parsing/disassembly, raw-file
hashes, metadata/state JSON and timing arithmetic. This reviewer imported or
executed no product artifact and ran no build, test, profile or workload.

## Provenance and state/mode verification

|Case|Successful selected digest|PE SHA256|r0 wrapper|
|---|---|---|---|
|Barnes a9b|4f095fc3f839681cd997312fb93e461a3a5e9b27c02b2add4731ac34a6af14ae|e98cc4037b249ddd957948b03dea4a2cbe64d9f27b7e56b873471a903550e565|0x1800011d0|
|Barnes037|d3c0b7064c2162b37f8cfe6c6bd4c42d33f04cc03eec67c3863eaa7399ea9747|c01ad9455882cd8fe70eb45dc688a82e5486fb631d924a39935f1abd6ebc197c|0x1800011e0|
|Ray a9b|1252f9c7f38bf2286cae6fe9be2bc2afe878b51deb27878387b90211f68e6727|1880c8ad0d9a5057df6b4054e727be6e7b81236519dbbed02757c48997d21740|0x1800011a0|
|Ray037|87b0e9848828da183fd2cfab1512851568bd7597f3b68af8d257aecc05cb6193|deecad159593b89eaf8cb4d2859a74f832f62c17206ac49fa7d3215d55790d9d|0x1800011b0|

All four static PyMethodDef maps equal retained runtime wrapper maps; selected
audit digest→plan export→frozen PE hashes agree. Selected audits reconcile100
Barnes and1raytrace AOT calls/version, zero JIT/fallback/rejected/unknown and no
Numba import. Every retained Barnes100 numeric/type/alias checkpoint and complete
initial/final vector equals plain Python. Raytrace's30000RGB bytes and observed
types/dimensions/mutable-array identity also equal plain Python. These finite
inputs do not prove equivalence for arbitrary Python.

`inline-actual-artifacts/verification.json` verifies source hashes against the
fresh manifest, all40timing child exits, every raw kernel/process-wall sample
and recomputed median,5050timing AOT calls and zero timing JIT/fallback. Root
separately verified all58process records/116raw streams against the Git archive
and all61tested/frozen product/test/native inputs. Correctness validation was
599tests/52subtests with22known-category warnings; it was not rerun here.

## Barnes: compact recursion and reduced inline overhead

Wrappers call adapter1090→advance(a9b25d0/03725f0)→force(a9b2c30/0372b60).
Force ranges end3250/3100 at the next called insert helper. Identity follows
selected export/call targets and PE unwind entries, not nearby PyInit labels.

|Force static measure|a9b|037|Unchanged C|
|---|---:|---:|---:|
|Instructions including1nop each|334|316|116|
|Local stack reservation, bytes|280|248|88|
|Stack-operand instruction lines|67|45|22|
|Outgoing recursive stack words|6|2|0|
|Direct self calls|4|4|4|
|Exact2**53 references|6|6|0|

At2e68/2f14/2faa/3077, the four self calls forward contextR8 and child/selfR9;
hidden result/exception positions remainRCX/RDX. Particle and theta occupy
caller rsp+20/+28. The six-to-two hypothesis is confirmed in the actual selected
code. Status is checked before consuming each returned value/tag; depth-limit
checks, success-only decrements, child null tests and exactness exits remain.
Only self calls occur in force; no allocator/NRT call was added.

The public adapter still constructs one40B typed descriptor at rsp+50..70,
with five initialization stores1155–1169, then passes its address inR8. Existing
array validation precedes pointer extraction/construction. Synchronous calls
finish before its frame returns; growth/error exit discards it and retries
reconstruct it. Force itself reads F/I/top/status once (four descriptor reads)
and has no local length load or repeated record construction.

Advance falls320→282lines including2/1nop (318→281executable), frame248→200B
and stack operands60→32. Its descriptor reads are now five initial fields,
versus18in the separately preserved578 binary. Inline helpers consume the
caller's raw SSA pointer/length values; they do not reload the descriptor.
These pointer values remain stable while their pointees can mutate and alias.

All three particle iterator blocks retain direct current header/data accesses.
Matched item paths shrink6→3(insert),10→5(force),10→5(update). Their ranges are
in ranges.json. Physical signed wrapping is gone; logical body bounds, captured
list identity and mutation/relocation semantics remain. Other allocation and
tuple paths still retain their original signed rules.

## Raytrace: the actual repeated loads are removed

Adapter1090 calls render(a9b19d0/03719e0), then the recursive ray-colour merged
SCC(a9b2f10/0372e80). The SCC includes rayColour/colourAt and inline work.

|Static measure|a9b|037|
|---|---:|---:|
|Render executable instructions|997|995|
|Render padding nops excluded above|2|1|
|Render stack operands|118|103|
|Render local reservation, bytes|472|440|
|SCC executable instructions|2508|2400|
|SCC stack operands|353|276|
|SCC local reservation, bytes|680|648|

Render total including padding is999→996. SCC ranges end at unwind ends6178
and5daa, excluding following int3 alignment bytes; no padding instructions
are counted inside those body ranges. Static lines and stack operands are not
cycle counts or spill costs measured at runtime.

The037 render loads the five descriptor fields at1ae9..1af8, and the SCC at
2fe5..2ff4. The renderer keeps context inR14 for forwarding but no longer reads
descriptor fields throughR14 inside inline helpers. The earlier578 render had
75static descriptor read instructions;037 has five initial reads. That is a
static comparison of actual binaries, not a pooled timing comparison. Descriptor
values are forwarded as SSA only to source helpers already marked _INLINED;
other boundaries remain narrow. _plain's wider JIT helper interfaces and their
startup/profile costs remain an explicit tradeoff.

The firstIntersection list-item fetch is one direct load at3ef0, versus the
six-instruction a9b physical-wrap block5292–52ab. Payload cmov/signed reads at
3ef7–3f44 remain, including presence/type flags. Generated visibleLights and
_lightIsVisible list physical slots use the same proof; no blanket removal of
all signed-address work is claimed. Self calls5323/59fb retain status checks.
Numeric exactness, index overflow/bounds, RGB clamps and tagged returns remain.

Source review and executed native fixture assertions establish that no new
alias/readonly/invariant metadata was introduced. F/I still share the arena;
passing raw pointers does not freeze contents. Machine disassembly alone cannot
prove absence of LLVM metadata and is not presented as actual-AOT LLVM.

## Fresh timing results and practical limits

|Kernel median, ms|a9b|037|C|037/a9b time change|037/C|
|---|---:|---:|---:|---:|---:|
|Barnes|35.9731|33.0608|9.088993|-8.10%|3.637x|
|Raytrace|3.6609|3.4292|0.607967|-6.33%|5.640x|

All five paired samples are faster in this cohort. Barnes ranges35.1793–
38.9277 versus32.3649–33.6340ms do not overlap; ray3.6067–3.6996 versus
3.4015–3.6054ms also do not overlap, with a small0.0013ms gap. Five children
per cell and uncontrolled host background do not establish a universal or
precisely attributable gain. RP/Python use best-of-five reset states per child;
C uses its retained best-of-twenty protocol.

Process walls are separate: Barnes490.1197→475.1701ms and ray388.4918→385.8284ms.
These observations include boundary/startup costs; they are not native-cycle
measurements. Object packing/writeback and entry frequency remain, and C uses
direct records/bytes plus host CPU tuning and somewhat different numeric/
timing assumptions. No C parity or default whole-program coverage claim follows.

The C binaries were rehashed against this fresh manifest: Barnes
4fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff;
ray3913b4bb6c6203042230c72da1fa46b6cad7899281c3cd3f2764fce29f7a2abc.
Earlier C excerpts are valid only because these measured bytes remain identical.

Keep the578 cohort's6.11%Barnes gain and7.05%ray regression in its own report.
The positive8.10%/6.33%figures above belong only to fresh095ecab/a9b-versus037.
There is no fresh matched578-versus037 timing cell, so no cross-cohort subtraction
or per-transformation speed percentage is justified. Strict Python behavior
remains the default; no unchecked numeric contract was enabled by these patches.
