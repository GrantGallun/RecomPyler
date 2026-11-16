import sys,json
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
from catalogue import Case
from run_matrix import run_case
for body in ['return 0<=int(x)<20','return not 0<=int(x)<20','if not 0<=int(x)<20: return .5\nreturn .25','return [0]*5','s=[0]*5\ns[int(x)>>2]+=1\nreturn s[0]']:
    print(body, json.dumps(run_case(Case('chain.'+str(len(body)),'review',body))),flush=True)
