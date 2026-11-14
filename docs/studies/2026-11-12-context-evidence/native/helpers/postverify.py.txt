"""Independent read-only per-checkpoint hash comparison of retained state audits."""
import argparse
from pathlib import Path
import common

def pair(left,right,allow_type_delta=False):
    a={r['step']:r for r in left['checkpoints']};b={r['step']:r for r in right['checkpoints']}
    missing=sorted(set(b)-set(a));steps=sorted(set(a)&set(b));metrics={}
    for name in ['numeric_sha256','types_sha256','aliases_sha256']:
        bad=[s for s in steps if a[s][name]!=b[s][name]]
        metrics[name]={'matched_steps':len(steps)-len(bad),'compared_steps':len(steps),'different_steps':bad}
    boundaries={where:{kind:left[where][kind]==right[where][kind] for kind in ['numbers','types','aliases']} for where in ['initial','final']}
    boundary_valid=all(v['numbers'] and v['aliases'] and (allow_type_delta or v['types']) for v in boundaries.values())
    valid=(boundary_valid and not missing and len(steps)==len(b) and not metrics['numeric_sha256']['different_steps']
           and not metrics['aliases_sha256']['different_steps'] and (allow_type_delta or not metrics['types_sha256']['different_steps']))
    return {'valid':valid,'missing_reference_steps':missing,'declared_type_relaxation':allow_type_delta,'metrics':metrics,'full_initial_final_vectors_equal':boundaries}

def main(args):
    out=args.output.resolve();m=common.read(out/'manifest.json');comparisons={};modes={}
    def check_modes(name,path,expected):
        evidence=common.read(path)['mode_evidence'];report=evidence['runner'];functions=report['functions'];t=evidence['totals']
        counts={k:sum(f.get(k,0) for f in functions) for k in ['compiled_calls','aot_calls','jit_calls','fallback_calls']}
        reconciles=(counts['compiled_calls']==sum(t[k] for k in ['aot_calls','jit_calls','unknown_native_calls']))
        matches=counts['aot_calls']==t['aot_calls'] and counts['jit_calls']==t['jit_calls'] and counts['fallback_calls']==t['fallback_calls']
        valid=(reconciles and matches and t['aot_calls']==expected and not any(t[k] for k in ['jit_calls','unknown_native_calls','fallback_calls','rejected_attempts'])
               and not report.get('not_found') and not report.get('batches') and not evidence['numba_imported'])
        modes[name]={'valid':valid,'expected_actual_aot_calls':expected,'audit_totals':t,'runner_counts':counts,
                     'compiled_total_reconciles':reconciles,'product_exact_counter_matches_audit':matches,'numba_imported':evidence['numba_imported']}
        flattened=dict(evidence,compiled_total_reconciles=reconciles,product_exact_counter_matches_audit=matches,
                       runner_report=report,source_state_audit=str(path),source_state_audit_sha256=common.digest(path.read_bytes()))
        common.save(path.with_name(path.stem+'-selected-audit.json'),flattened)
    if 'cases' in m:
        reference=common.read(out/'cases'/'current-direct'/'plain-state.json')
        for name,item in m['cases'].items():
            folder=out/'cases'/name
            plain=common.read(folder/'plain-state.json');native=common.read(folder/'native-state.json')
            comparisons[name+'-plain-vs-control']=pair(reference,plain,item['contract']=='fullfloat')
            comparisons[name+'-native-vs-own-plain']=pair(plain,native)
            comparisons[name+'-native-vs-control']=pair(reference,native,item['contract']=='fullfloat')
            check_modes(name,folder/'native-state.json',100//item['group'])
    else:
        reference=common.read(out/'plain-state.json')
        for source in m['sources']:
            comparisons[source+'-vs-plain']=pair(reference,common.read(out/(source+'-state.json')))
            check_modes(source,out/(source+'-state.json'),100)
        comparisons['candidate-vs-baseline']=pair(common.read(out/'baseline-state.json'),common.read(out/'candidate-state.json'))
    result={'manifest_sha256':common.digest((out/'manifest.json').read_bytes()),'all_valid':all(r['valid'] for r in [*comparisons.values(),*modes.values()]),'comparisons':comparisons,'actual_mode_reconciliation':modes,
            'note':'Numeric/type/alias hashes compared at every retained common logical step. Fullfloat cross-contract type deltas declared; native versus own plain types always required identical. Raw full initial/final vectors retained separately.'}
    common.save(out/'checkpoint-postverification.json',result)
    print('checkpoint postverification all_valid='+str(result['all_valid']))
    if not result['all_valid']: raise SystemExit(1)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);main(p.parse_args())
