"""Read-only analysis of frozen raw evidence; never launches workloads."""
from pathlib import Path
import argparse
import statistics

import common

def analyze(out):
    m=common.read(out/'manifest.json')
    summary=common.read(out/'SUMMARY.json')
    rows=summary['rows']
    failures=[]
    costs={}
    for name,item in m['cases'].items():
        folder=out/'cases'/name
        row=rows[name]
        row.update(contract=item['contract'],group=item['group'],target=item['target'],engine='heapRegion',policy='manual target-only --force diagnostic')
        row['expected_timing_aot_calls_total']=5*5*100//item['group']
        row['timing_modes_valid']=(row['records']==5 and row['aot_calls_total']==row['expected_timing_aot_calls_total'] and row['jit_calls_total']==row['fallback_calls_total']==0)
        if not row['timing_modes_valid']: failures.append(name+': unexpected timing execution modes')
        if not row['checks_valid']: failures.append(name+': timing check mismatch/incomplete')
        for kind in ['plain','native']:
            path=folder/(kind+'-state-comparison.json')
            if path.exists(): row[kind+'_state_comparison']=common.read(path)
            else: failures.append(name+': missing '+kind+' state comparison')
        path=folder/'native-state.json'
        if path.exists(): row['state_audit_modes']=common.read(path)['mode_evidence']
        phasepath=folder/'phase.json'
        if phasepath.exists():
            phase=common.read(phasepath);attempts=phase['attempts'];width=100//item['group']
            groups=[attempts[i:i+width] for i in range(0,len(attempts),width)]
            keys=['load_ns','guards_ns','native_ns','result_ns','writeback_ns','other_attempt_ns','attempt_ns']
            chunks=[{k:sum(a[k] for a in g)*1e-6 for k in keys} for g in groups]
            mode_rows=(phase.get('runner') or {}).get('functions',[])
            phase_aot=sum(r.get('aot_calls',0) for r in mode_rows)
            phase_jit=sum(r.get('jit_calls',0) for r in mode_rows)
            phase_fb=sum(r.get('fallback_calls',0) for r in mode_rows)
            valid=(len(groups)==6 and all(len(g)==width for g in groups) and all(a['ok'] for a in attempts)
                   and phase_aot==600//item['group'] and phase_jit==phase_fb==0 and not phase.get('error')
                   and all(e['aot'] for e in phase['arena_native_entries']))
            if not valid: failures.append(name+': phase count/mode/error')
            native_entries=phase['arena_native_entries']
            entrygroups=[];at=0
            for group in groups:
                n=sum(a['native_entries'] for a in group)
                es=native_entries[at:at+n];at+=n
                entrygroups.append({'native_entries':n,'growth_status2_exits':sum(e['status']==2 for e in es),
                    'max_capacity_slots':max((e['capacity_slots'] for e in es),default=0),
                    'max_top_slots':max((e['top_after'] for e in es),default=0),
                    'max_top_delta_slots':max((e['top_after']-e['top_before'] for e in es),default=0)})
            row['phase']={'valid':valid,'instrumented':True,'cold_and_warm_rep_component_ms':chunks,
                'warm_component_medians_ms':{k:statistics.median(g[k] for g in chunks[1:]) for k in keys},
                'whole_kernel_six_rep_median_s':None,'whole_kernel_note':'Not captured. stdout seconds is best-of-six, not warm median.',
                'actual_aot_calls':phase_aot,'actual_jit_calls':phase_jit,'fallback_calls':phase_fb,
                'numba_imported':phase['numba_imported'],'arena_by_rep':entrygroups,
                'max_capacity_bytes':phase['max_capacity_bytes'],'max_top_slots':phase['max_top_slots'],
                'growth_native_exits':phase['growth_native_exits'],'loaded_native_modules':phase['loaded_native_modules']}
        else: failures.append(name+': missing phase')
        if item['reused_profile']:
            costs[name]={'fresh':False,'profile_wall_s':m['reused_profile']['profile_record']['wall_s'],
                         'note':'Reused historical wave5 profile, not a wave6 fresh cost.'}
        elif (folder/'profile.json').exists():
            costs[name]={'fresh':True,'profile_wall_s':common.read(folder/'profile.json')['wall_s']}
        plan=common.read(folder/'plan.json')
        row['profile_target_candidates']=[r['candidate'] for r in plan['functions']]
        s=plan['plan']['aot_regions'];row['aot_plan']={'module':s['module'],'folder':s['folder'],'functions':s['functions']}
    for name,row in rows.items():
        if not row['checks_valid']: failures.append(name+': timing checks incomplete/mismatch')
        c=rows['c']['median_best_kernel_s'];plain=rows['plain']['median_best_kernel_s'];value=row['median_best_kernel_s']
        if value:
            row['kernel_time_over_C']=value/c
            row['kernel_speedup_over_plain']=plain/value
            row['kernel_time_vs_current_direct']=value/rows['current-direct']['median_best_kernel_s']
    def contrast(a,b):
        return {'before':a,'after':b,'kernel_time_ratio_after_over_before':rows[b]['median_best_kernel_s']/rows[a]['median_best_kernel_s'],
                'process_wall_ratio_after_over_before':rows[b]['median_process_wall_s']/rows[a]['median_process_wall_s']}
    costs['fresh_profiles_total_s']=sum(v['profile_wall_s'] for v in costs.values() if v['fresh'])
    costs['compile_only_warmup_total_s']=sum(common.read(out/(n+'.json'))['wall_s'] for n in ['warmup-before','warmup-final'])
    costs['all_state_audits_wall_s']=sum(common.read(out/'cases'/n/(k+'-state-process.json'))['wall_s'] for n in m['cases'] for k in ['plain','native'])
    costs['phase_processes_wall_s']=sum(common.read(out/'cases'/n/'phase-process.json')['wall_s'] for n in m['cases'])
    result={'schema':1,'manifest_sha256':common.digest((out/'manifest.json').read_bytes()),'source':m['source'],
        'rows':rows,'costs':costs,'failures':failures,'all_valid':not failures,
        'contrasts':[contrast('current-direct','current-wrapper1'),contrast('current-wrapper1','current-wrapper4'),
                     contrast('current-direct','forceonly-direct'),contrast('current-direct','fullfloat-direct'),
                     contrast('fullfloat-direct','fullfloat-wrapper4'),contrast('current-wrapper4','fullfloat-wrapper4')],
        'limits':['Manual numeric-type contracts, not production equivalence','Grouping includes callgraph/inlining/arena-retention effects',
                  'Instrumented phase component medians are not headline timings or additive counterfactuals',
                  'RP generic AOT target versus -march=native C; tuning impact unmeasured',
                  'Unknown external background CPU load; no OS-wide exclusivity','Fixed finite float/zero corpus oracle, not arbitrary-int equivalence']}
    common.save(out/'ANALYSIS.json',result)
    print('all_valid='+str(result['all_valid'])+' failures='+str(failures))

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);a=p.parse_args();analyze(a.output.resolve())
