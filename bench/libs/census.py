"""Enumerate Python definitions without invoking descriptors or importing extras."""
import sys
import types


def modules(package):
    return [m for name, m in sorted(list(sys.modules.items()))
            if (name == package or name.startswith(package + '.')) and type(m) is types.ModuleType]


def functions(module_set):
    seen = set()
    for module in module_set:
        if type(module) is not types.ModuleType: continue
        module_name=vars(module).get('__name__')
        if type(module_name) is not str: continue
        def visit(obj, qual):
            if type(obj) in (staticmethod, classmethod): obj = obj.__func__
            if type(obj) is property:
                for label, f in [('get',obj.fget),('set',obj.fset),('del',obj.fdel)]:
                    if f is not None: yield from visit(f, qual + ':' + label)
            elif type(obj) is types.FunctionType and type(obj.__module__) is str and obj.__module__ == module_name and id(obj) not in seen:
                seen.add(id(obj)); yield module_name + '.' + qual, obj
        for name, obj in list(vars(module).items()):
            if issubclass(type(obj),type):
                members = type.__dict__['__dict__'].__get__(obj)
                if type(members.get('__module__')) is str and members['__module__'] == module_name:
                    for attr, value in list(members.items()):
                        yield from visit(value, name + '.' + attr)
            else: yield from visit(obj, name)


def journal_event(path, phase, event, **details):
    if path:
        import json
        from pathlib import Path
        with Path(path).open('a', encoding='utf-8') as stream:
            stream.write(json.dumps(dict(phase=phase, event=event, **details)) + '\n')
            stream.flush()


def compile_library(package, module_names=None, install=False, budget=120, journal=None, count_entries=False, hotness=None):
    """Compile the explicit loaded-module scope, retaining honest partial counts."""
    import time
    from recompyler.ir import compile_function, compilation_info
    from tools.ir_self_host import install_candidate
    module_set = modules(package)
    if module_names is not None:
        module_set = [m for m in module_set if m.__name__ in module_names]
    targets = list(functions(module_set))
    if hotness:
        targets.sort(key=lambda pair: -hotness.get(pair[1].__module__+'.'+pair[1].__code__.co_qualname,0))
    rows = []
    compiled_functions = []
    counters = {}
    start = time.monotonic()
    for qual, function in targets:
        if time.monotonic() - start > budget: break
        row = {'function':qual}
        journal_event(journal,'compile','begin',function=qual)
        try:
            compile_function(function, strict=True)
            info = compilation_info(function)
            if info is None: raise RuntimeError('no native compilation metadata')
            row.update(status='compiled', kind=info.get('compilation_kind'), prefix=info.get('native_prefix', False))
            if count_entries:
                # Reuse the owner-authored harness; counters never enter timed code.
                from tools.ir_self_host import CountedBody
                from recompyler.ir._entry_native import _compilation_owner, forget_compilation, prepare_frame_entry
                code, owner = _compilation_owner(function)
                counted = CountedBody(owner)
                forget_compilation(function)
                prepare_frame_entry(function, counted.body_address, counted, code)
                counters[qual] = counted
                info = compilation_info(function)
            compiled_functions.append((function, info['body_address']))
        except Exception as exc:
            row.update(status='declined', reason=type(exc).__name__ + ': ' + str(exc)[:300])
        rows.append(row)
        journal_event(journal,'compile','end',**row)
    def live():
        return sum(bool((compilation_info(f) or {}).get('installed')) for f, _ in compiled_functions)
    before = live()
    installed = 0
    if install:
        names = {id(f): qual for qual, f in targets}
        for function, address in compiled_functions:
            qual = names[id(function)]
            journal_event(journal,'install','begin',function=qual)
            reason = None
            try:
                if (compilation_info(function) or {}).get('body_address') != address:
                    raise ValueError('prepared body address changed')
                accepted = install_candidate(function)
                if not accepted: reason = 'canonical entry declined'
            except Exception as exc:
                accepted = False
                reason = type(exc).__name__+': '+str(exc)
            if accepted: installed += 1
            journal_event(journal,'install','end',function=qual,installed=accepted,reason=reason)
    after = live()
    report = {'scope':'loaded modules after workload execution', 'modules':[m.__name__ for m in module_set],
              'total':len(targets), 'attempted':len(rows), 'compiled':len(compiled_functions),
              'declined':sum(r['status']=='declined' for r in rows), 'not_attempted':len(targets)-len(rows),
              'installed_before':before, 'installed_after':after, 'install_successes':installed,
              'percentage':100*len(compiled_functions)/len(targets) if targets else None, 'rows':rows}
    return report, [f for f, _ in compiled_functions], counters


def profile_workload(run, package):
    """Count library calls in this isolated correctness worker; retain no frames."""
    counts = {}
    previous = sys.getprofile()
    def called(frame, event, argument):
        if event == 'call':
            module = frame.f_globals.get('__name__','')
            if module == package or module.startswith(package+'.'):
                name = module+'.'+frame.f_code.co_qualname
                counts[name] = counts.get(name,0)+1
    sys.setprofile(called)
    try: return run(), counts
    finally: sys.setprofile(previous)



