"""Bookkeeping only: paired distributions from sealed kernel summary samples."""
from pathlib import Path
import itertools,json,random,statistics,sys
path=Path(sys.argv[1]);base=sys.argv[2];candidate=sys.argv[3]
data=json.loads(path.read_text());out={}
for name,variants in data.items():
 a=variants[base]['samples_ms'];b=variants[candidate]['samples_ms'];assert len(a)==len(b) and len(a)>=3
 d=[y-x for x,y in zip(a,b)];n=len(d);rng=random.Random(1600)
 bootstrap=sorted(statistics.mean(rng.choices(d,k=n)) for _ in range(20000))
 observed=abs(sum(d));permutations=[abs(sum(s*x for s,x in zip(signs,d))) for signs in itertools.product((-1,1),repeat=n)]
 out[name]=dict(pairs=n,base_median_ms=statistics.median(a),candidate_median_ms=statistics.median(b),
  independent_median_change_percent=100*(statistics.median(b)/statistics.median(a)-1),
  paired_differences_ms=d,paired_median_difference_ms=statistics.median(d),paired_mean_difference_ms=statistics.mean(d),
  mean_difference_bootstrap95_ms=[bootstrap[499],bootstrap[19499]],
  exact_two_sided_signflip_p=sum(x>=observed-1e-12 for x in permutations)/len(permutations),
  limitations='Fresh-process paired observations; descriptive bootstrap/exact sign flips assume exchangeable pair noise. No multiplicity correction; source causality also requires behavior/native gates.')
output=path.with_name('paired-analysis.json');assert not output.exists();output.write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
