"""Predeclared S30 criterion: median paired saved milliseconds, 95% bootstrap CI."""
from pathlib import Path
import json,math
import numpy as np
D=Path(__file__).resolve().parent
s=json.loads((D/'item3-accept-summary.json').read_text());out={}
for n,vs in s.items():
 b=np.array(vs['scalar-abc-v1']['samples_ms']);a=np.array(vs['numeric-final-v2']['samples_ms']);delta=b-a
 rng=np.random.default_rng(30);indices=rng.integers(0,len(delta),size=(50000,len(delta)))
 ci=np.quantile(np.median(delta[indices],axis=1),[.025,.975]).tolist()
 positive=int(np.sum(delta>0));negative=int(np.sum(delta<0));nonzero=positive+negative;k=min(positive,negative)
 signp=min(1.0,2*sum(math.comb(nonzero,j) for j in range(k+1))/2**nonzero) if nonzero else 1.0
 out[n]={'paired_saved_ms':delta.tolist(),'median_paired_saved_ms':float(np.median(delta)),'median_paired_percent_saved':float(np.median(100*delta/b)),'paired_bootstrap_95_ms':ci,'bootstrap_resamples':50000,'seed':30,'exact_sign_test_two_sided_p':signp,'resolved_faster':ci[0]>0,'resolved_slower':ci[1]<0}
accept=out['raytrace']['resolved_faster'] and not any(v['resolved_slower'] for n,v in out.items() if n!='raytrace')
result={'criterion':'Accept only if paired-bootstrap95% median ray savings lower>0 and no control upper<0; otherwise leave numeric code uncommitted on named branch. No further optimization development.','accepted':bool(accept),'kernels':out}
(D/'item3-accept-analysis.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
