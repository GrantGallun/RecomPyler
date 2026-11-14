# Actual combined578 AOT comparison

Barnes improves in this fresh cohort; raytrace's kernel regresses. The compact
recursive interface reaches the actual AOT binary, but repeated descriptor
reads in inline work create substantial raytrace code growth. Keep both results.
No instruction-count-to-cycle attribution is established.

Frozen candidate57835fa8a89d0d846e291abc7f9f6f335aa272a8, heap raw SHA256
9eb440c9bcbf3683411a78af706f05a1ba44bae2228d484b9df8aaea6bebe4fa.
New study manifestd058c448e449e26f405b9f1d5f508291ab61227500d9e6b9a66e564ea57d2806.
`current` in this cohort means saveda9b, never939. All profiles/artifacts/timing
children are fresh. This reviewer only parsed/disassembled/hashed PE files and
read metadata/state JSON; no product/native artifact imported or executed.

## Provenance and finite correctness

| Case |Successful digest|PE SHA256|r0 wrapper|
|---|---|---|---|
|Barnes a9b|4f095fc3f839681cd997312fb93e461a3a5e9b27c02b2add4731ac34a6af14ae|9e73d909458c695174cdd9573cd89eb1cf7b4b6ebe8ce34a156a735ccaec2e2c|0x1800011d0|
|Barnes578|015a21b4f2375a90aa153cc4be9363dd8d95816213c4b8693fa68f342c3060d5|4eca7ed0ce783f4bd046a993e7664326759ed226b3ff3d7101af899dfff697f4|0x1800011e0|
|Ray a9b|1252f9c7f38bf2286cae6fe9be2bc2afe878b51deb27878387b90211f68e6727|9a56a685e3889e2ed57417d8e99c241c21593c4651bef66736b821bed8c5d10a|0x1800011a0|
|Ray578|cfe8a6127d7e30e2b2c9d51c331bc84faf143925d3419e94a4c6d72026e65a1a|e809094d29df79049fc7b587e99009d1430f662ae74548e961ffbedddb06c714|0x1800011b0|

All static PyMethodDef maps equal retained runtime wrapper maps. Selected audit
digest→export→frozen PE hashes agree, with100 successful Barnes AOT calls and1
ray call/version, zero JIT/fallback/rejected/unknown and no Numba import.
All retained Barnes100 numeric/type/alias checkpoints plus initial/final vectors
equal plain Python. Raytrace30000RGB bytes and observed types/dimensions/array
identity equal plain Python. Source hashes equal the fresh frozen manifest.
See candidate-actual-artifacts/verification.json and each provenance file.

## Barnes: actual six-to-two interface

Wrapper→adapter1090→advance is a9b25d0 or57825f0. Their mapped force targets
are respectively2c30 and2c10; ranges end3250 and31b0 at the next insert helper.
Do not use nearby printed PyInit names as native function identity.

|Force static measure|a9b|578|Unchanged C|
|---|---:|---:|---:|
|Instruction lines including1nop each|334|316|116|
|Address span bytes|1568|1440|480|
|Local stack reservation bytes|280|248|88|
|Stack-operand lines|67|45|22|
|Outgoing recursive stack words|6|2|0|
|Direct self calls|4|4|4|
|Exact2**53 references|6|6|0|

New first recursive call2f18 passes hidden result RCX/exception RDX, contextR8,
child/selfR9, particle at caller rsp+20 and theta at+28. The same pointer is
forwarded at2fc4/305a/3127. Status checks follow every call before result/tag
consumption; all four depth/limit tests and success-only decrements remain.
Only self calls appear in force; no allocator/NRT call was introduced.

Force reads descriptorF/I/top/status at2c56/2c89/2c8d/2c91. Arena length is
unused locally and is not loaded. At mass-zero exit only F is needed. These
four static field-read instructions replace incoming raw heap parameters;
they are real additional indirection, not free context compression.

The public adapter initializes exactly one40B record at rsp+50,+58,+60,+68,+70
at1155–1169, then passes rsp+50 inR8 at1197→119f. The five fields are F,I,top,
status,length. There is no repeated record construction in recursive bodies.
The adapter's frame stays live through synchronous borrowed calls; growth exits
rebuild the record on the next attempt. Validation remains before initialization.

Advance stays320lines including2nop, but frame248→216B and stack operands60→46.
All three ordinary particle loops lose physical wrapping. Matched item blocks
are insert6→3instructions, force10→5, update10→5, at the ranges recorded in
ranges.json. Current length/data reads and captured list identity remain;
ordinary mutations are covered by focused/full validation. Signed allocation
helper adjustments remain outside the proved iterator paths.

Tradeoff: advance including inline constructors/apply_force/update has18static
descriptor field-read instructions. These are counted with exact addresses in
descriptor-inventory.json. Smaller iterator blocks do not imply fewer total
advance instructions when another transformation adds loads.

## Raytrace: concrete code-growth regression

Wrapper→adapter1090→render is a9b19d0 or57819e0. Render calls the recursive
ray-colour merged SCC at2f10 or3130. This source-bound range covers rayColour
and colourAt plus inline work, not an independently named leaf rayColour.

|Static measure|a9b|578|
|---|---:|---:|
|Render lines including padding|999(2nop)|1181(1nop)|
|Render stack operands|118|166|
|Render local reservation bytes|472|472|
|SCC executable lines|2508|2807|
|SCC stack operands|353|413|
|SCC local reservation bytes|680|712|

SCC ranges end at PE unwind ends6178/6865; respectively8/11 following int3
alignment bytes are excluded. Both SCC bodies have two direct self-call sites,
with status checks retained. Renderer has75static descriptor read instructions,
including memory-operand compares and inline helper work. Context lives inR14
through the body; four initial fields read through incomingR8 are also counted.
Repeated F/top/status/length reads after stores are visible. The SCC has further
reads across complex register reuse; no displacement-only total is asserted.

The iteration proof still works. In firstIntersection, the old item-fetch
block[5292,52ab) takes6instructions including physical sign adjustment; the new
[4a1e,4a21) is one direct pointer load. Tuple payload cmov/signed addressing
remains at4a28–4a77, preserving the existing payload/sentinel rules. Generated
visibleLights and _lightIsVisible loops likewise use unsigned list header/data/
item slots; their tuple payloads remain signed. No blanket removal of every
sarq/cmov in the SCC is claimed: allocation and tuple payload paths still need
their existing contracts. Exact source and bounded machine excerpts are retained.

This is a concrete tradeoff: narrower recursive argument passing plus iterator
improvements coexist with many descriptor reads inside inline work. The new
renderer/SCC code growth and slower kernel motivate a separate strict followup
that carries existing heap SSA values into guaranteed inline helpers. No alias,
readonly or invariant metadata was added. Assembly cannot prove absence of
LLVM metadata; that claim rests on source review and executed native fixture
assertions, not relabeled actual-AOT LLVM.

## Fresh timing result

|Kernel ms|a9b|578|C|578/a9b time change|
|---|---:|---:|---:|---:|
|Barnes|35.1749|33.0258|9.088755|-6.11%|
|Raytrace|3.6208|3.8761|0.604391|+7.05%|

Barnes ranges34.9435–36.3557 versus32.7477–33.1943ms do not overlap. Raytrace
3.6102–3.7948 versus3.7885–3.9644ms overlap slightly; every paired ray sample is
slower. Report the regression. Process walls are separate: Barnes483.7466→
469.0332ms; ray399.6874→397.4985ms. Five fresh timing children per cell and
5050 total timingAOT, zero JIT/fallback. Static counts cannot assign the6.11%
gain or7.05%regression to a particular instruction class. No context-only timing
cell isolates the two changes. Background load and generic RP versus host-tuned
C remain limits; C ports also use different representations/assumptions.

The actually measured C binaries still hash4fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff
and3913b4bb6c6203042230c72da1fa46b6cad7899281c3cd3f2764fce29f7a2abc;
previous C excerpts therefore remain valid byte-identical references. Candidate
times remain3.634xC for Barnes and6.413xC for raytrace. No C-parity claim follows.
