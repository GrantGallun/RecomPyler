
import json
from . import heap
def recommended(plan, force=False): return {('target', 1)}
def regional(plan): return {('target', 1)} if json.loads(plan.read_text()).get('region') else set()
def run_script(script, script_args, plan, force=False):
    ns = {}; exec(compile(script.read_text(), str(script), 'exec'), ns)
    region = heap.Region(ns['target'])
    ok, value = region.attempt(())
    print('check answer', value if ok else ns['target']())
    return {'functions': [{'function': 'target', 'region': True, 'aot_calls': region.aot_calls, 'jit_calls': 0, 'fallback_calls': int(not ok)}], 'exit_code': None, 'batches': {}}
