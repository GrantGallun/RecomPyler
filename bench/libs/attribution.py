"""Native leaf attribution. Unknown native frames are never called interpreter."""
import argparse
from collections import Counter
import json
import math
from pathlib import Path
import re

BUCKETS=('interpreter','compiled_body','entry_exit','c_api','allocation_gc','c_extensions','unknown')


def classify(frames,bodies):
    for frame in reversed(frames):
        name=frame.get('name','');address=frame.get('address')
        if address is None:
            found=re.search(r'0x[0-9a-fA-F]+',name)
            if found: address=int(found[0],16)
        if isinstance(address,str): address=int(address,0)
        if address is not None:
            for body in bodies:
                if body['start']<=address<body['start']+body['size']: return 'compiled_body',body['function']
        if frame.get('file','').endswith(('.py','.pyc')) or frame.get('file','').startswith('<'): return 'interpreter',None
        file=frame.get('file','').replace('\\','/').lower()
        if file.endswith('.dll') and any(folder in file for folder in ('/site-packages/','/dist-packages/')):
            return 'c_extensions',None
        if re.search(r'Malloc|Calloc|Realloc|Free|_PyObject_GC|gc_collect|collect_generations',name,re.I): return 'allocation_gc',None
        if re.search(r'rc_ir_frame_(enter|leave)|run_vectorcall|vectorcall_entry|eval_frame_handle|frame_entry|reifyFrame',name): return 'entry_exit',None
        if re.search(r'_PyEval_|_PyInterpreter|_PyEvalFrame|PyEval_Eval',name): return 'interpreter',None
        if re.match(r'(_?Py[A-Z]|_?PyObject_|_?PyLong_|_?PyFloat_)',name): return 'c_api',None
        if '.pyd' in frame.get('file','').lower() or '.pyd' in name.lower() or '.so' in frame.get('file',''): return 'c_extensions',None
        # An unknown leaf must remain unknown, even when an ancestor is Python.
        if name and not name.startswith(('Thread ', 'thread ', 'process ')): return 'unknown',None
    return 'unknown',None


def summarize(profile,bodies):
    frames=profile['shared']['frames'];counts=Counter();functions=Counter();total=0
    for record in profile['profiles']:
        if record['type']!='sampled': raise ValueError('sampled speedscope input required')
        weights=record.get('weights',[1]*len(record['samples']))
        if len(weights)!=len(record['samples']): raise ValueError('invalid sample weights')
        for stack,weight in zip(record['samples'],weights):
            if not math.isfinite(weight) or weight<0: raise ValueError('invalid sample weight')
            bucket,function=classify([frames[i] for i in stack],bodies)
            counts[bucket]+=weight;total+=weight
            if function: functions[function]+=weight
    return dict(counts=dict(counts),shares={k:v/total for k,v in counts.items()} if total else {},
                compiled_functions=dict(functions),total_weight=total,unit=profile['profiles'][0].get('unit') if profile['profiles'] else None)


def opportunities(counts,evidence):
    total=sum(counts.values());rows=[]
    for bucket,count in counts.items():
        share=count/total if total else 0;proof=evidence.get(bucket);speed=proof.get('speedup') if proof else None
        if speed is not None and (not math.isfinite(speed) or speed<1): raise ValueError('achievable speedup must be finite and >=1')
        rows.append(dict(bucket=bucket,time_share=share,speedup=speed,source=proof.get('source') if proof else None,
            share_times_speedup=share*speed if speed is not None else None,
            recoverable_share=share*(1-1/speed) if speed is not None else None))
    rows.sort(key=lambda r:r['share_times_speedup'] if r['share_times_speedup'] is not None else -1,reverse=True)
    for i,row in enumerate(rows,1): row['priority']=i
    return rows


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('profile',type=Path);p.add_argument('--bodies',type=Path)
    p.add_argument('--evidence',type=Path);p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    report=summarize(json.loads(args.profile.read_text()),json.loads(args.bodies.read_text()) if args.bodies else [])
    report['opportunities']=opportunities(report['counts'],json.loads(args.evidence.read_text()) if args.evidence else {})
    args.output.write_text(json.dumps(report,indent=2))


if __name__=='__main__':main()
