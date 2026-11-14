"""Render final Markdown from accepted evidence and the fresh current ladder."""
from pathlib import Path
import json,re
D=Path(__file__).resolve().parent
load=lambda n:json.loads((D/n).read_text())
a3=load('item3-accept-analysis.json');a4=load('item4-accept-analysis.json');assert a3['accepted'] and a4['accepted']
s0=load('step0-summary.json');s1=load('item1-final-summary.json');s2=load('item2-accept-summary.json');s3=load('item3-accept-summary.json');s4=load('item4-accept-summary.json');ray=load('ray-current-summary.json');counts=load('ray-current-counts.json')
rv=ray['variants'];med=lambda n:rv[n]['median_ms']
wave13={'fannkuch':18.3529,'scimark':2.2289,'barnes_hut':36.5457,'raytrace':3.6536}
hand={'fannkuch':12.2603,'scimark':.6335,'barnes_hut':10.9361,'raytrace':med('hand')}
# Stage0 key names are read explicitly rather than inferred from a filename.
stepzero={n:vs for n,vs in s0.items()}
lines=['# Wave15 depth2: measured compiler rules','',
'All four build items are complete and locally committed. The shared range rules save FFT 0.6919 ms and fannkuch 3.3132 ms; scalar replacement saves raytrace 0.5887 ms; guarded numeric bodies save raytrace a paired 0.25585 ms; stable owners save fannkuch a paired 1.82905 ms. These are separate matched experiments, not additive intrinsic cost shares. Strict behavior remains the default.',
'', '## Accepted changes and validation','',
'| Item | Achieved | Against bound | Native reach in fixed 49 selections |',
'|---|---|---|---|',
'| Step0 accepted wave13 lift | fann 23.1959 ->17.8968 ms; FFT 2.76575 ->2.09565 ms | reproduced copy reuse + unsigned physical index; multiply-flag experiment excluded | existing lift backend |',
'| R5+R6 shared ranges | FFT 2.0957 ->1.4038 ms (33.02%); fann17.8634 ->14.55025 (18.55%) | 99.0% of FFT0.4354+0.2634 ms;91.1% of fann3.6375 ms | R5:44ASTsites/5functions;R6:30sites/4functions;2workloads |',
'| R8 scalar a+b+c | ray3.7069 ->3.1182 ms (15.88%);451466/734941bumps removed |79.32% of conditional0.7422ms |10original Python allocation sites/9Pythonfunctions/2workloads;13typedcontexts/12inferencefunctions |',
'| R7 guarded numeric versions | ray paired0.25585ms/8.07%,95%[0.21160,0.35140] |28.80% of historical0.8883ms; old rung unavailable post-R8 |37emittedcontexts/16Pythonfunctions/2workloads;17raycontexts/10Pythonfunctions actually entered |',
'| R4 stable owners | fann paired1.82905ms/12.46%,95%[1.77255,1.91060] |90.81% of fresh2.0141ms;96.97% of historical1.8862ms |1copy site/1Pythonfunction/1workload |','',
'Every acceptance cell checks exact outputs, exact selected AOT counts and zero JIT/fallback/missing selection/batches. Each rule has one ten-pair four-kernel acceptance cohort, with original Python best-of-five state resets and C best-of-twenty; final R7/R4 pair ordering alternates and C placement rotates. R7/R4 use the predeclared paired median,50,000 paired bootstrap resamples/seed30/95% intervals; no control is resolved slower. Short three-pair diagnostics use the established6% variation convention and are descriptive.',
'',
'Full suites: Step0 733tests/131subtests; final ranges766/131; scalar797/131; numeric810/131; final owner813/131 in502.66s. Focused fail-first proofs and independent source reviews precede native acceptance. A recursive R7 wrapper ABI regression found by the final suite was repaired and revalidated before accepting. The final owner cleanup tests require real compiled signatures and40actual native attempts per case, including status-error replay; balanced NRT and meminfo counts cover normal/early/guard-miss/error exits.',
'', '## Per-stage context (milliseconds)','',
'Columns below come from the named separate cohorts and must not be subtracted to claim gains. Wave13 is its published final acceptance. Step0 is this run reproduction; item1 is its final three-pair S20confirmation; items2-4 are their respective ten-pair final medians. C is matched to item4. Hand fann/FFT are historical strict generic ceilings; Barnes uses the state-checked ceiling from this run; ray hand is freshly retimed below.',
'', '| Kernel | Base | Wave13 | Step0 | Item1 | Item2 | Item3 | Item4 | Hand | C |','|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|']
# Original step0 summary may wrap medians under kernel/variant keys; enforce known accepted context.
base={'fannkuch':23.1959,'scimark':2.76575,'barnes_hut':32.9877,'raytrace':3.4710};zero={'fannkuch':17.8968,'scimark':2.09565,'barnes_hut':32.90425,'raytrace':3.45535}
for n in ('fannkuch','scimark','barnes_hut','raytrace'):
 vals=[base[n],wave13[n],zero[n],s1[n]['item1-final']['median_ms'],s2[n]['scalar-abc-v1']['median_ms'],s3[n]['numeric-final-v2']['median_ms'],s4[n]['owner-v1']['median_ms'],hand[n],s4[n]['c']['median_ms']]
 lines.append('|'+n+'|'+'|'.join(f'{v:.5f}' for v in vals)+'|')
lines+=['','## Fresh raytrace ladder from final owner-v1 source','',
'All values here are new measurements in one lock hold, not carried over from wave13. Three fresh alternating processes per variant validate complete default pixels; direct native timers exclude setup/load/validation/writeback, while whole product includes them. Hand core and whole hand are both retimed through the existing strict generic AOT pipeline; no fastmath or false F/I alias metadata. Diagnostic source/runtime/native/hand hashes are frozen in ray-current-input-manifest-v2.json.',
'', '| Stage | Median ms | Scope |','|---|---:|---|']
scopes={'product':'whole current product','current':'identical current native body; boundary/setup excluded','lists':'scene/light list capacity reserved upfront; growth removed','tuples':'tuple bumps batched; payload/handle stores retained','float':'standalone default fixedFLOAT fields/RGB; layout/scalar ABI changes together','float-tuples':'fixedFLOAT plus batched tuple storage','float-stream':'all temporary records/list and consumer fused into ordered minimum','calls-replay':'unmodified LLVM reoptimization control after stream','calls-inline':'constant-selector SCC split; colourAt call/packed-return edge inlined','hand-core':'typed hand native core','hand':'typed hand with setup','c':'C reference'}
for n in ('product','current','lists','tuples','float','float-tuples','float-stream','calls-replay','calls-inline','hand-core','hand','c'):
 lines.append(f"| {n} | {med(n):.5f} | {scopes[n]} |")
lines+=['','| Conditional comparison | Median difference ms | Interpretation |','|---|---:|---|']
for step in ray['conditional_steps']:
 lines.append(f"| {step['from']} -> {step['to']} | {step['median_difference_ms']:+.5f} | {step['scope']} |")
lines+=['',f"The current whole-product minus full-hand gap is {med('product')-med('hand'):.5f} ms. Native current minus hand-core is {med('current')-med('hand-core'):.5f} ms. After the grouped representation/call stages, {med('calls-inline')-med('hand-core'):.5f} ms remains unclosed native representation/control/recursive-ABI work. Restoring typed setup costs {med('hand')-med('hand-core'):+.5f} ms; replay reoptimization changes the preceding stream point by {med('float-stream')-med('calls-replay'):+.5f} ms. These signed conditional values are not independent causal shares. Small/reversing paired samples remain unresolved, and adding the standalone float branch would double-count interaction.",
'', '| Actual diagnostic removal | Successful arena bumps | High-water slots |','|---|---:|---:|']
for n,row in counts.items():lines.append(f"| {n} | {row['successful_bumps']} | {row['highwater_slots']} |")
lines+=['',
'All counter rows have instrument-off/on full-pixel and highwater equality. Batched tuples remove individual allocation operations while retaining every record payload; streamed minimum removes the record stores and private list/consumer as a group. The original current render has122120intersection tuple blocks,35776list-growth blocks and20598list-storage/header blocks. FLOAT diagnostics intentionally change numeric kinds on this known valid scene; builder metadata records remaining MIXED fields, scalar-return ABI and numeric versions. The call diagnostic requires optimized zero colourAt-edge calls plus a surviving self-recursive rayColour edge; its benefit includes dispatch/DCE/return-ABI propagation, not isolated machine call latency. No diagnostic is product code.',
'', '## Rule details and remaining work','',
'Ranges use affine/geometric dependent-stride and permutation facts behind one proven/guarded/unknown API. Guards select a fast region, with original checks on a miss. FFT butterfly16indexed sites are proved; bitreverse carry-dependent j/k and unproven numeric-domain/step checks remain. Fann flip-count growth and count-element decrement retain checks. Typed float arithmetic was already raw and receives no new range credit. R5/R6 static counts are AST sites, not machine instructions or measured per-site time. Leaving FFT out leaves6R5 and9R6sites.',
'',
'Scalar replacement uses monotone recursive origin/effect summaries and checked local/field-passing/fresh-return clones, preserving aliases and real tags where required. Ray removes451466bumps (61.43%), including98172a+b,319199c and34095safe contexts from a partially escaping scale site. Remaining instances are99648Vectors and5333Points. Barnes removes100/75348root bumps; chaos removes5000/90521source-only bumps; float0/100004,go/nbody typed roots decline. Forty-five workloads have no selected native region; these source analyses are not new deployment. The corrected original Python reach is10sites/9functions;13/12in earlier results denoted typed allocation/function contexts. Independent normalization confirms four Vector.scale contexts share one source constructor.',
'',
'Conditional first-escape classd remains candidate underS26: current chaos60000immediate real-list stores and ray5333real-child-handle Points cannot lose allocations without virtual receiving containers/child slots. No zero-reach general materializer was built. Designs, scope review and deferred regressions are preserved.',
'',
'R7 guards actual input/field tags and immutable integer conversion bounds, keeps checked miss bodies and int-only results, and directs only guard-implied callee versions. Logical predicate evaluations drop4399585 ->431538 (90.19%) for ~0.17msdevelopment and0.25585msaccepted paired savings. The wave13 0.8883ms rung used original arena code regenerated whole-graph fixedFLOAT beforeR8; it was not available in that form for post-R8 guarded function bodies retaining MIXED storage and same-width miss/join ABI. Branch prediction is unmeasured. Seven direct ray and three Barnes MIXED fields plus colour channels remain in product. Fann/FFT have no MIXED-field backend. Emitted37contexts/16Pythonfunctions are separate from17entered raycontexts/10Pythonfunctions; Barnes inner-version execution weights are unmeasured.',
'',
'R4 proves both physical private int64-permutation buffers have equal guarded stable extents and earlier dominating owners, using existingF2/F3. F9 certifies the copy safe even after earlier unrelated failure, not whole-region freedom from error. Fast-loop NRT sites6 ->0; only llvm.smin/smax/memmove remain there. Two exit blocks each retain4decrefs (three arrays+status); fallback cycles retain6NRTsites. No manual NRT suppression enters product.',
'',
'The strict Barnes ordered-quadtree hand ceiling preserves original parent-COM behavior and all200particles/100steps/sevenfinal-fieldbytes and energyhex. Same cohort whole product/hand/C33.5300/10.9361/9.082556ms. Instrumented native16.1071ms is48.04%ofwhole; the typed native10.8937ms leaves5.2134ms (32.37%native, roughly15.5%whole), not the22.59mswhole gap. Diagnostic phase timers add overhead.',
'', '| Kernel | Closed/measured | Remaining values and scope |','|---|---|---|',
'| FFT | combined numeric/bounds0.6919ms against0.6988ms | Historical boundary0.5772,status0.0764,ABI0.0912,pipeline0.2058ms remain context; current residuals not separately retimed. Remaining carry and float/domain checks are listed, not asserted free. |',
'| fann | range/control3.3132ms; owner paired1.82905ms,fast-loop NRT-free | Fresh ownerbound2.0141ms before rule; do not subtract unrelated cohort endpoints to invent a residual. Initial/exit work and retained checked control/call/pipeline differences remain; Cparity is not established. |',
'| ray | scalar0.5887ms; guarded numeric paired0.25585ms | Fresh current ladder above supplies boundary, records/lists, FLOAT/scalarABI and partialcall opportunities; unclosed remainder explicit. |',
'| Barnes |100root bumps removed; no resolved control gain |5.2134msnative representation opportunity; boundary about52%of instrumented whole, outside this brief. |','',
'Boundary/in-place and target/vectorizer changes are outside this build brief. Record/list fusion remains an open candidate requiring effect/identity/range/failure proofs. The tested selector-edge inline has no resolved gain; remaining recursive ABI work stays open. These are not shipped optimizations.',
'', '## Evidence, commits and isolation','',
'Local branch codex/integrated-coverage in standalone wave15-depth2 starts at087c0dda. Accepted commits:4d5ef903(Step0),65c5ba48(ranges),d86f4e3(scalar),2455034(numeric),cb70f90(owners). No push. RULES.md records facts, accepted rules, corrected reach/bounds and follow-up candidates. The root ledger ../WAVE15-DEPTH2-PLAN.md contains every checkpoint, steering ACK and timing lock acquisition/release, including yields to wave14/wave16.',
'',
'Primary results: [item1](depth2/item1-result.md),[item2](depth2/item2-final-result.md),[item3](depth2/item3-final-result.md),[item4](depth2/item4-final-result.md),[fresh ray ladder](depth2/ray-current-summary.json),[independent evidence verification](depth2/accepted-evidence-review.md),[ray diagnostic review](depth2/ray-current-review.md). Raw process/stdout/stderr/count/validity receipts remain in depth2/raw/step0-confirm,item1-accept,item2-accept,item3-accept,item4-accept,owner-current-bound andray-current. Failed/intermediate experiments remain intact and are excluded from final aggregates.',
'',
'Windows commands used reviewed ordinary-user execution around the broken sandbox helper. No privilege elevation, ACL changes, global installs, edits to other waves/original checkout/tools/prior results, or remote publication. Product source/tests match the final owner-v1 frozen manifest; all diagnostic work stays in this clone.']
report='\n'.join(lines)+'\n'
report=re.sub(r'(?<=\d)(?=(?:ms|tests|subtests|bumps|sites|functions|contexts|Python|typed|AST|workload|particles|steps|root|original|emitted|inference|ray|copy|actual|decrefs|NRT))',' ',report)
for old,new in [('Pythonfunction','Python function'),('ASTsites','AST sites'),('inferencefunctions','inference functions'),('typedcontexts','typed contexts'),('emittedcontexts','emitted contexts'),('raycontexts','ray contexts'),('fullpixels','full pixels'),('nativeonly','native only'),('wholegraph','whole graph'),('%of','% of')]:report=report.replace(old,new)
report=re.sub(r'\b(fann|ray|FFT|Barnes|paired|conditional|historical|fresh|bounds|against|scalar|native|retain|drop|under|Emitted|from|all|owner|ranges|numeric)(?=\d)',r'\1 ',report)
report=re.sub(r'(?<=\d)s\b',' s',report)
report=re.sub(r'(?<=%)(?=[A-Za-z])',' ',report)
for old,new in [('beforeR8','before R8'),('underS26','under S26'),('existingF2','existing F2'),('Cparity','C parity'),('andray-current','and ray-current'),('S20confirmation','S20 confirmation'),('sevenfinal-fieldbytes','seven final-field byte arrays')]:report=report.replace(old,new)
(D.parent/'REPORT.md').write_text(report,encoding='utf-8')
print('WROTE REPORT.md',len(lines),'lines')
