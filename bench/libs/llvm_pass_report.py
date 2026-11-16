"""LLVM pass diagnostics; keep unknown timing exponents explicit."""
import math
from .compile_scaling import growth_exponent
import re
from collections import defaultdict

ROW=re.compile(r'^\s*((?:[\d.]+\s+\(\s*[\d.]+%\)\s+)+)(\S.*)$')


def parse_report(text):
    per=defaultdict(float);totals={};section=None
    for line in text.splitlines():
        if 'Pass execution timing report' in line: section='pass'
        elif 'Analysis execution timing report' in line: section='analysis'
        match=ROW.match(line)
        if not match or section is None: continue
        values=re.findall(r'([\d.]+)\s+\(',match[1])
        if not values: continue
        wall=float(values[-1])
        if not math.isfinite(wall) or wall<0: raise ValueError('invalid pass wall time')
        name=re.sub(r'\s+on\s+.*$','',match[2]).strip()
        if name=='Total': totals[section]=wall
        else: per[section+':'+name]+=wall
    if 'pass' not in totals or not any(key.startswith('pass:') for key in per):
        raise ValueError('missing or unrecognized LLVM pass timing report')
    return dict(per=dict(per),totals=totals)


def summarize(rows):
    sizes=[row['bytecodes'] for row in rows]
    if len(sizes)<3 or len(set(sizes))!=len(sizes) or min(sizes)<=0:
        raise ValueError('three distinct bytecode sizes required')
    passes={}
    for name in sorted(set().union(*(row['per'] for row in rows))):
        values=[row['per'].get(name) for row in rows]
        exponent=growth_exponent(sizes,values)
        passes[name]=dict(exponent=exponent,seconds=values)
    volume=max(row['llvm_lines']/row['bytecodes'] for row in rows)
    lcssa=passes.get('pass:LCSSAPass',{}).get('exponent')
    verdict=False if volume>=10 else None if lcssa is None else lcssa<=1.1
    return dict(passes=passes,max_llvm_lines_per_bytecode=volume,shape_budget_ok=verdict)


from contextlib import contextmanager
import hashlib


@contextmanager
def capture_passes(binding):
    """Diagnostic-only factory instrumentation; retain the actual LLVM builder."""
    original=binding.create_pass_builder
    rows=[]
    @contextmanager
    def timed_factory(*args,**kwargs):
        with original(*args,**kwargs) as builder:
            modules=[];saved={}
            for method in ('getModulePassManager','getFunctionPassManager'):
                if not hasattr(builder,method): continue
                create=getattr(builder,method);saved[method]=(method in vars(builder),vars(builder).get(method))
                def wrapped(create=create,kind=method):
                    manager=create()
                    class Manager:
                        def __enter__(self): manager.__enter__();return self
                        def __exit__(self,*error): return manager.__exit__(*error)
                        def __getattr__(self,name): return getattr(manager,name)
                        def run(self,module,actual_builder,*args,**kwargs):
                            text=str(module)
                            instructions=None
                            if hasattr(module,'functions'):
                                instructions=sum(1 for function in module.functions if not function.is_declaration for block in function.blocks for instruction in block.instructions)
                            modules.append(dict(kind=kind,llvm_lines=sum(line.startswith('  ') and not line.lstrip().startswith(';') for line in text.splitlines()),llvm_text_nonblank_lines=sum(bool(line.strip()) for line in text.splitlines()),llvm_instructions=instructions,ir_sha256=hashlib.sha256(text.encode()).hexdigest()))
                            return manager.run(module,actual_builder,*args,**kwargs)
                    return Manager()
                setattr(builder,method,wrapped)
            builder.start_pass_timing()
            try: yield builder
            finally:
                try: raw=builder.finish_pass_timing()
                finally:
                    for method,(present,value) in saved.items():
                        if present:setattr(builder,method,value)
                        else:delattr(builder,method)
                rows.append(dict(modules=modules,raw=raw,**parse_report(raw)))
    binding.create_pass_builder=timed_factory
    try: yield rows
    finally: binding.create_pass_builder=original
