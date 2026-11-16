"""AOT checks for native non-escaping sets and scalar-only outputs."""
from pathlib import Path
import json,os,subprocess,sys
from recompyler import aot,profiler
from recompyler.monitor import CallMonitor
from test_native_sets import difference_size,local_copy_size,local_summary


def test_verified_set_scalar_results_build_and_reload(tmp_path):
    entries=[]
    for fn,args in [(difference_size,({1,2},{2,3})),(local_copy_size,(3,)),(local_summary,(3,))]:
        path=Path(fn.__code__.co_filename)
        with CallMonitor([path],2,profiler.snapshot,backend='python',bias=0,yield_bias=0) as monitor:
            fn(*args)
        sampler=monitor.samplers[(str(path),fn.__qualname__,fn.__code__.co_firstlineno)]
        candidate=profiler.test_candidate(fn,sampler.samples,1,extra=())
        assert candidate['status']=='verified',candidate
        compiled=candidate['_lifted']
        assert compiled.compiled_calls
        entries.append(((fn.__qualname__,fn.__code__.co_firstlineno),fn,compiled,[args]))
    section=aot.build(entries,tmp_path)
    assert section and len(section['functions'])==3
    module=aot.load(section)
    for entry,(_,fn,_,rows) in zip(section['functions'],entries):
        compiled=aot.AotLifted(fn,entry,module)
        args=rows[0]
        assert compiled(*args)==fn(*args)
        assert compiled.compiled_calls==1
        if fn is difference_size:
            assert compiled({10000,2},{2})==1
            assert compiled({2**100},{2})==1
            assert args[0]=={1,2}
        else:
            assert compiled(2**100)==fn(2**100)
        assert compiled.fallback_calls==1
    code="import json,sys; sys.path.insert(0,'tests'); from test_native_sets import difference_size,local_copy_size,local_summary; from recompyler import aot; section=json.loads(sys.argv[1]); module=aot.load(section); assert 'numba' not in sys.modules; functions={'difference_size':difference_size,'local_copy_size':local_copy_size,'local_summary':local_summary}\n"
    code+="for entry in section['functions']:\n fn=functions[entry['qualname']]; wrapper=aot.AotLifted(fn,entry,module); args=({1,2},{2,3}) if fn is difference_size else (3,); assert wrapper(*args)==fn(*args); assert wrapper.compiled_calls==1\nassert 'numba' not in sys.modules\nprint('fresh AOT set calls without Numba')"
    done=subprocess.run([sys.executable,'-c',code,json.dumps(section)],text=True,capture_output=True,env=os.environ.copy(),timeout=60)
    assert done.returncode==0,(done.stdout,done.stderr)
    assert 'fresh AOT set calls without Numba' in done.stdout
