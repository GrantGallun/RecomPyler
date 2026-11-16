import sys, os
sys.path.insert(0, 'claude'); sys.argv = ['x', 'none']
from t_sci import m, lift_region
r = lift_region(m.MonteCarlo); r(1000)
p = [q for q in r.programs.values() if q][0]
src = p.source
open('claude/out/mc_source.py', 'w').write(src)
import re
for i, line in enumerate(src.splitlines()):
    if 'sr0' in line: print(i, line[:170])
