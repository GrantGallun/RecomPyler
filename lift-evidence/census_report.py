"""Report a deliberately partial S51 census; never credit unknown completion."""
from pathlib import Path
from collections import Counter
import json,sys
from all_blockers import family,choose
D=Path(__file__).resolve().parent


def aggregate(rows):
    output=[];buckets={}
    keys=[tuple(r['key']) for r in rows]
    if len(set(keys))!=len(keys):raise ValueError('duplicate population root')
    for original in rows:
        r=dict(original);events={}
        for sample in r.get('diagnostics',[]):
            for e in sample.get('events',[]):
                key=(e.get('source'),e.get('scope'),e.get('absolute_line'),e['reason'],e['category'],e.get('structural',False))
                events.setdefault(key,e)
        r.pop('diagnostics',None)
        r.pop('source_excerpt',None)
        r['distinct_events']=list(events.values())
        usable=[e for e in events.values() if e['category'] in ('unsupported','declaration') and e['family']!='analysis unknown']
        families={e['family'] for e in usable}
        # Authoritative product first refusal is independently known, even if the
        # diagnostic could not recover that path. Its exact original text stays.
        reason=r.get('current_reason','')
        if reason and not r.get('already_native'):
            families.add(family(reason.removeprefix('as a region: ')))
        r['families']=sorted(families)
        r['forecast_eligible']=not r.get('unknown_remainder',True) and r.get('analysis_status')=='analysed' and not r.get('already_native')
        r['optimistic_eligible']=r.get('analysis_status')=='analysed' and not r.get('already_native') and bool(families)
        output.append(r)
        for f in families:
            b=buckets.setdefault(f,dict(functions=0,programs=set(),only_observed=0,only_reliable=0,after_unknown_functions=0,structural_functions=0,wrapper_functions=0,inclusive_s=0,missing_weight_functions=0,contributors=[]))
            b['functions']+=1;b['programs'].add(r['program'])
            b['only_observed']+=len(families)==1
            b['only_reliable']+=len(families)==1 and r['forecast_eligible']
            b['after_unknown_functions']+=any(e['family']==f and e.get('after_unknown') for e in usable)
            b['structural_functions']+=any(e['family']==f and e.get('structural') for e in usable)
            b['wrapper_functions']+=bool(r.get('wrapper'))
            weight=r.get('inclusive_s')
            if weight is None:b['missing_weight_functions']+=1
            else:b['inclusive_s']+=weight
            b['contributors'].append(dict(key=r['key'],qualname=r.get('qualname'),inclusive_s=weight,wrapper=r.get('wrapper',False)))
    for b in buckets.values():
        b['programs']=len(b['programs'])
        b['contributors'].sort(key=lambda r:-(r['inclusive_s'] or 0))
    return dict(rows=output,families=buckets)


def rankings(rows):
    optimistic=[dict(r,forecast_eligible=r['optimistic_eligible']) for r in rows]
    weighted=[r for r in optimistic if r.get('inclusive_s') is not None]
    largest=max(weighted,key=lambda r:r['inclusive_s'],default=None)
    totals=Counter()
    for r in weighted:totals[r['program']]+=r['inclusive_s']
    largest_program=totals.most_common(1)[0][0] if totals else None
    return dict(strict=choose(rows),observed_only=choose(optimistic),
                observed_only_weighted=choose(optimistic,weighted=True),
                observed_only_without_wrappers=choose([r for r in optimistic if not r.get('wrapper')]),
                observed_only_weighted_without_wrappers=choose([r for r in optimistic if not r.get('wrapper')],weighted=True),
                leave_largest_function=None if largest is None else dict(removed=largest['key'],choices=choose([r for r in optimistic if r['key']!=largest['key']],weighted=True)),
                leave_largest_program=None if largest_program is None else dict(removed=largest_program,choices=choose([r for r in optimistic if r['program']!=largest_program],weighted=True)))


def load(folder,population):
    by={tuple(r['key']):dict(r,analysis_status='collection_unavailable',unknown_remainder=True,diagnostics=[]) for r in population['rows']}
    attempts=json.loads((folder/'summary.json').read_text())['program_attempts']
    failed=[]
    for attempt in attempts:
        p=folder/attempt['program']/'results.json'
        if attempt['exit_code']!=0 or not p.exists():failed.append(attempt['program']);continue
        for r in json.loads(p.read_text())['rows']:
            key=tuple(r['key'])
            if key not in by:raise ValueError('unexpected root')
            by[key]=r
    return list(by.values()),failed


def text(value):return str(value).replace('|','/').replace('\n',' ')


def report(folder):
    pop=json.loads((D/'census-population-v2.json').read_text())
    rows,failed=load(folder,pop);data=aggregate(rows);ranks=rankings(data['rows'])
    data.update(rankings=ranks,failed_programs=failed,baseline_native=60,denominator=375,
                warning='PARTIAL: unknown paths have no reliable completion forecast. Observed-only sequences assume every unobserved blocker away; inclusive times overlap and are not unlocked wall time.')
    (D/'ALL-BLOCKERS.json').write_text(json.dumps(data,indent=2))
    statuses=Counter(r['analysis_status'] for r in rows)
    lines=['# Partial all-blockers census (S51)', '',
        'This is a bounded diagnostic, not an exhaustive list or a completion forecast. It walks past refusals without compiling code. Once a refusal makes a type/state unknown, subsequent reasons are labelled after-unknown or structural. Unknown paths receive no completion credit.', '',
        f"Historical captured-not-native population: **{len(rows)} functions**, {len({r['program'] for r in rows})} programs. Current reference baseline: **60/375 fully native**, **0/375 native with fallback (0 sites)**. One historical member is already native; it is not counted again. No product capability or deployment changes in this census.", '',
        f"Collection status: {dict(statuses)}. Failed programs: {failed or 'none'}. Inclusive weights exist for {sum(r.get('inclusive_s') is not None for r in rows)} roots; {sum(r.get('inclusive_s') is None for r in rows)} are missing. Timing wrappers (bench_* with perf_counter/range/elapsed return): {sum(bool(r.get('wrapper')) for r in rows)}.", '',
        'The inclusive weights are existing capture cumulative times, counted once per root per family. They overlap across callers and callees, are specific to those captures, and cannot be added as whole-program time saved. Missing weights stay missing. This does not measure native/Python time shares in fallback regions.', '',
        '## At-all and ONLY observed families', '',
        'ONLY observed means exactly one family was seen. ONLY reliable additionally requires no unknown remainder; it alone could support a completion claim. At-all includes the authoritative current product first refusal plus diagnostic reasons. The JSON retains exact source, scope, line, call chain, reason and unknown flags for every distinct event.', '',
        '| Family | Functions | Programs | ONLY observed | ONLY reliable | After unknown | Structural | Wrappers | Inclusive s | Missing weights |',
        '|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|']
    for f,b in sorted(data['families'].items(),key=lambda x:(-x[1]['functions'],x[0])):
        lines.append('| '+text(f)+' | '+' | '.join(str(b[k]) if k!='inclusive_s' else f"{b[k]:.6f}" for k in ('functions','programs','only_observed','only_reliable','after_unknown_functions','structural_functions','wrapper_functions','inclusive_s','missing_weight_functions'))+' |')
    lines+=['','## Completion choices','','Reliable greedy sequence: '+('no eligible rows; baseline stays **60/375**.' if not ranks['strict'] else text(ranks['strict'])), '',
        'The next tables are **optimistic observed-only conditional scenarios**, not predictions: they assume no additional blocker on every unknown path. Completion requires the entire observed family set, including callees, to be selected. Marginal counts are newly completed roots after prior choices; ties use known inclusive weight, then incidence, then family name. A zero marginal choice remains zero. Cumulative counts start at 60 and cannot count a root twice. Unsupported constructors/kwargs/defaults are not automatically solved by fallback calls. Broad call-family membership does not establish fallback safety.', '']
    for key in ('observed_only','observed_only_weighted','observed_only_without_wrappers','observed_only_weighted_without_wrappers'):
        lines += ['### '+key.replace('_',' '),'','| Step | Family | Marginal | Conditional cumulative /375 | Known inclusive s newly covered | Missing weights |','|---:|---|---:|---:|---:|---:|']
        for i,c in enumerate(ranks[key],1):lines.append(f"| {i} | {text(c['family'])} | {c['marginal']} | {c['cumulative_native']} | {c['weighted_s']:.6f} | {c['missing_weight_functions']} |")
        if not ranks[key]:lines.append('| - | none | 0 | 60 | 0 | 0 |')
        lines.append('')
    lines+=['## Weight concentration and sensitivity','','Top five contributors per family (also in JSON):','']
    for f,b in sorted(data['families'].items(),key=lambda x:-x[1]['inclusive_s'])[:10]:
        contrib='; '.join(f"{v['key'][0]}.{v['qualname']}:{v['key'][2]} {v['inclusive_s'] if v['inclusive_s'] is not None else 'missing'}s" for v in b['contributors'][:5])
        lines.append('- '+text(f)+': '+text(contrib))
    for key in ('leave_largest_function','leave_largest_program'):
        v=ranks[key];lines+=['',key.replace('_',' ')+': '+('none' if v is None else text(v['removed']))]
        if v:lines.append('Recomputed weighted sequence: '+ '; '.join(f"{c['family']} (+{c['marginal']}, {c['cumulative_native']}/375)" for c in v['choices']))
    lines += ['','## S50 and next capability','','The S54 construct-level fallback capability is next by steering, ahead of native table choices. The function-value target is spectral_norm eval_times_u; constructor-helper target is scimark Random.__init__ calling initialize. They must be tested on those programs, regardless of count-only table rank. The diagnostic does not prove that either outer function completes. Exact fallbacks, callable guards, constructor state, opaque lifetime and post-effect guard handling remain requirements.', '',
        'Existing three-pair, 20-loop unmodified selection: scimark CPython 7.454360s / RecomPyler 4.408065s (1.6911x); spectral_norm 1.593662s / 1.369898s (1.1633x). Both deploy two fully native functions, with 0 fallback sites; test activity was recorded. No census gain or newly unlocked wall time is inferred. A new S54 result must remeasure these programs and newly deploying programs.', '',
        '## Limits and steering request','','The strict completion table is empty because the bounded continuation does not recover sound types/state beyond every refusal. Treat the observed-only ordering as leads for tests, not reliable marginal benefit. Please accept this partial census under S51.3 and let S54 proceed using executable target cases; exhaustive forecasts would require a separate analysis capability. This diagnostic does not change default product acceptance.', '',
        'A captured function in a nested input path may be omitted by the collector basename prefilter and stays unknown. Structural traversal may visit unreachable branches and nested declarations. Inlined reasons carry callsite locations separately from callee source. None of these are proof of a supported or unsupported executable path.']
    (D/'ALL-BLOCKERS.md').write_text('\n'.join(lines)+'\n')
    print(json.dumps(dict(roots=len(rows),statuses=statuses,families=len(data['families']),strict_choices=len(ranks['strict']),failed_programs=failed)))


if __name__=='__main__':report(Path(sys.argv[1]).resolve())
