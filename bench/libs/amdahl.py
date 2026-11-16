"""Observed bytecode-only ceilings, preserving unknown native attribution.

A representation rewrite may also reduce C-API and allocation work; this is not
an absolute ceiling for such a rewrite. None plus an unbounded flag represents
infinity without emitting nonstandard JSON values.
"""
import math
from .attribution import BUCKETS


def ceiling(counts,*,achieved=None):
    if set(counts)-set(BUCKETS):raise ValueError('unknown attribution bucket')
    if any(not math.isfinite(value) or value<0 for value in counts.values()):raise ValueError('finite nonnegative weights required')
    if counts.get('compiled_body',0) or counts.get('entry_exit',0):raise ValueError('plain CPython samples required')
    if achieved is not None and (not math.isfinite(achieved) or achieved<=0):raise ValueError('positive finite achieved ratio required')
    try: total=math.fsum(counts.values())
    except OverflowError:raise ValueError('sample weight overflow') from None
    if not math.isfinite(total):raise ValueError('finite total weight required')
    if not total:return dict(status='unavailable',reason='no native samples')
    known=counts.get('interpreter',0);unknown=counts.get('unknown',0)
    non_python=math.fsum(value for bucket,value in counts.items() if bucket!='interpreter')
    known_non_python=math.fsum(value for bucket,value in counts.items() if bucket not in ('interpreter','unknown'))
    lower=total/non_python if non_python else None
    upper=total/known_non_python if known_non_python else None
    result=dict(status='ok',python_fraction_lower=known/total,python_fraction_upper=min(1,(known+unknown)/total),
                python_fraction_unknown=unknown/total,ceiling_lower=lower,ceiling_upper=upper,
                lower_unbounded=lower is None,upper_unbounded=upper is None,
                achieved_over_ceiling_lower=(achieved/upper if upper is not None else 0) if achieved is not None else None,
                achieved_over_ceiling_upper=(achieved/lower if lower is not None else 0) if achieved is not None else None)

    # S106: a boxed-value rewrite can also remove arithmetic C-API calls,
    # refcounts and allocation. Not every C-API sample is actually removable: this
    # is a deliberately optimistic scope bound, not a promise about an optimizer.
    removable=('interpreter','c_api','allocation_gc')
    known_removable=math.fsum(counts.get(bucket,0) for bucket in removable)
    residual=math.fsum(value for bucket,value in counts.items() if bucket not in removable)
    known_residual=math.fsum(value for bucket,value in counts.items() if bucket not in (*removable,'unknown'))
    broad_lower=total/residual if residual else None
    broad_upper=total/known_residual if known_residual else None
    result['representation']=dict(removable_fraction_lower=known_removable/total,
        removable_fraction_upper=min(1,(known_removable+unknown)/total),
        ceiling_lower=broad_lower,ceiling_upper=broad_upper,
        lower_unbounded=broad_lower is None,upper_unbounded=broad_upper is None,
        achieved_over_ceiling_lower=(achieved/broad_upper if broad_upper is not None else 0) if achieved is not None else None,
        achieved_over_ceiling_upper=(achieved/broad_lower if broad_lower is not None else 0) if achieved is not None else None,
        scope='optimistic interpreter + C-API + allocation/refcount elimination; unknown bounded separately')
    return result



def attach_ceilings(timings,profiles):
    from statistics import median
    import copy
    result=copy.deepcopy(timings)
    indexed={}
    for profile in profiles:
        if profile.get('engine') not in ('cpython_off','cpython_on'):raise ValueError('plain CPython profile required')
        key=(profile['name'],profile['engine'])
        if key in indexed:raise ValueError('duplicate program profile')
        indexed[key]=profile
    for row in result['rows']:
        comparisons={}
        for engine in ('cpython_off','cpython_on'):
            profile=indexed.get((row['name'],engine))
            if not profile or profile.get('status')!='ok':
                comparisons[engine]=dict(status='unavailable',reason='plain CPython profile unavailable');continue
            if profile['source_sha256']!=timings['source_sha256'] or profile['split']!=timings['split']:
                raise ValueError('profile source/group differs from timing')
            if any(sample[engine].get('digest')!=profile['workload']['digest'] for sample in row['samples']):
                raise ValueError('profile output differs from timing')
            achieved=median(sample[engine]['seconds']/sample['recompyler']['seconds'] for sample in row['samples'])
            comparisons[engine]=dict(ceiling(profile['attribution']['counts'],achieved=achieved),achieved_ratio=achieved)
        row['amdahl']=comparisons
    result['ceiling_method']='plain CPython native samples; bytecode-only and optimistic boxed-value rewrite bounds preserve unknown leaves'
    return result


def main(argv=None):
    import argparse,json
    from pathlib import Path
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--timings',type=Path,required=True)
    parser.add_argument('--profiles',type=Path,nargs='+',required=True)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args(argv)
    profiles=[row for path in args.profiles for row in json.loads(path.read_text())]
    report=attach_ceilings(json.loads(args.timings.read_text()),profiles)
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(report,indent=2))
    return 0


if __name__=='__main__':raise SystemExit(main())
