"""Native-sealed post-analysis runtime descriptions for saved heap regions.

The native seal is authoritative for metadata; JSON checksums alone never grant
entry. Binding resolves static recipes and creates current identity guards. It
never constructs inference functions or executes generated Python source.
"""
import builtins
from collections import deque
import hashlib
import importlib.machinery
import importlib.util
from pathlib import Path
import random
import sys
import weakref
from types import (BuiltinFunctionType, CellType, CodeType, FunctionType,
                   MethodType, ModuleType, SimpleNamespace, MemberDescriptorType,
                   GetSetDescriptorType, MethodDescriptorType, WrapperDescriptorType,
                   ClassMethodDescriptorType)

from ._prepared_keys import (SCHEMA, PreparedMiss, canonical, compiler_key, digest,
                             file_key, function_key, literal_key, plan_key,
                             runtime_key, unliteral)


def _is_type(actual, allowed):
    return any(actual is expected for expected in allowed)


class PreparedArtifactMismatch(PreparedMiss):
    pass


_LAST = None
_VERIFIED_MODULES = {}


def miss(reason, detail=''):
    global _LAST
    _LAST = dict(reason=reason, detail=str(detail)[:200])


def last_miss():
    return _LAST


def _plain_function(value):
    from ._runner_wrapper import original
    answer = original(value)
    if answer is None: raise PreparedMiss('untrusted function wrapper')
    return answer


def _static(value, name):
    if type(value) is ModuleType: return vars(value).get(name)
    if type(value) is type:
        for base in value.__mro__:
            if name in vars(base): return vars(base)[name]
        return None
    raise PreparedMiss('nonstatic attribute recipe')


def _runtime_infos(program):
    # Lowering can append scalar clones to order without registering them in
    # the original inference map. Preserve the actual native execution view.
    result=[]
    for info in [*program.functions.values(),program.entry,*program.order]:
        if not any(info is old for old in result): result.append(info)
    return result


class References:
    def __init__(self, entry, program=None):
        self.entry = _plain_function(entry)
        self.program = program
        self.known = {id(self.entry): (self.entry, ['entry']),
                      id(builtins): (builtins, ['builtins'])}
        self.queue = deque([(self.entry.__globals__, ['globals', ['entry']], 0),
                            (vars(builtins), ['globals', ['builtins']], 0)])
        entry_builtins=self.entry.__builtins__
        if type(entry_builtins) is dict:
            self.known[id(entry_builtins)]=(entry_builtins,['builtins-space',['entry']])
        self.seen = set()
        self.resolved = {}
        self.functions = {}
        self.classes = {}
        self.values = {}
        # Function namespaces/default dictionaries must have stable recipes.
        if program is not None:
            for info in _runtime_infos(program):
                fn = _plain_function(info.fn)
                self.ref(fn)
                self.known[id(fn.__globals__)] = (fn.__globals__, ['globals', self.ref(fn)])
                if fn.__kwdefaults__ is not None:
                    self.known[id(fn.__kwdefaults__)] = (fn.__kwdefaults__, ['kwdefaults', self.ref(fn)])
                for i, cell in enumerate(fn.__closure__ or ()):
                    self.known[id(cell)] = (cell, ['cell', self.ref(fn), i])
            for view in vars(program).get('cell_views', {}).values():
                self.known[id(view)] = (view, ['cell-view', self.ref(view.cell), view.name])
            strings = vars(program).get('str_constants')
            if strings is not None: self.known[id(strings)] = (strings, ['strings'])
            for holder in vars(program).get('generator_holders', {}).values():
                self.known[id(holder)] = (holder, ['holder', self.ref(holder['gen'])])

    def ref(self, value):
        t = type(value)
        if value is None or _is_type(t, (bool, int, float, complex, str, bytes, frozenset, slice)):
            return ['literal', literal_key(value)]
        if t is tuple: return ['tuple', [self.ref(v) for v in value]]
        known = self.known.get(id(value))
        if known is not None and known[0] is value: return known[1]
        # Search only exact dictionaries/modules/classes, never descriptors.
        while self.queue:
            space, recipe, depth = self.queue.popleft()
            if id(space) in self.seen: continue
            self.seen.add(id(space))
            for name, item in space.items():
                if type(name) is not str: continue
                path = ['item', recipe, name]
                self.known.setdefault(id(item), (item, path))
                if type(item) is FunctionType:
                    plain = _plain_function(item)
                    self.known.setdefault(id(plain), (plain, path))
                if type(item) is ModuleType and depth < 2:
                    self.known.setdefault(id(vars(item)), (vars(item), ['globals', path]))
                    self.queue.append((vars(item), ['globals', path], depth + 1))
                elif type(item) is type and depth < 3:
                    for base in item.__mro__:
                        base_path = path if base is item else ['mro', path, item.__mro__.index(base)]
                        self.known.setdefault(id(base), (base, base_path))
                        for attr, member in vars(base).items():
                            if type(attr) is str:
                                member_path = ['own', base_path, attr]
                                self.known.setdefault(id(member), (member, member_path))
                                if _is_type(type(member), (staticmethod, classmethod)):
                                    self.known.setdefault(id(member.__func__), (member.__func__, ['descriptor-function', member_path]))
                                if type(member) is FunctionType:
                                    plain = _plain_function(member)
                                    self.known.setdefault(id(plain), (plain, member_path))
                elif t is random.Random and _is_type(type(item), (MethodType, BuiltinFunctionType)):
                    if item.__self__ is value:
                        self.known[id(value)] = (value, ['method-self', path])
            known = self.known.get(id(value))
            if known is not None and known[0] is value: return known[1]
        raise PreparedMiss('unreachable binding')

    def resolve(self, recipe, depth=0):
        if depth > 40 or type(recipe) is not list or not recipe: raise PreparedMiss('recipe')
        cache_key = canonical(recipe)
        if cache_key in self.resolved: return self.resolved[cache_key]
        tag, *p = recipe
        sub = lambda v: self.resolve(v, depth + 1)
        if tag == 'entry': value = self.entry
        elif tag == 'builtins': value = builtins
        elif tag == 'literal': value = unliteral(p[0])
        elif tag == 'tuple': value = tuple(sub(v) for v in p[0])
        elif tag == 'globals':
            owner = sub(p[0])
            if type(owner) is FunctionType: value = _plain_function(owner).__globals__
            elif type(owner) is ModuleType: value = vars(owner)
            else: raise PreparedMiss('namespace owner')
        elif tag == 'builtins-space':
            fn=_plain_function(sub(p[0])); value=fn.__builtins__
            if type(value) is not dict: raise PreparedMiss('builtins namespace')
        elif tag == 'item':
            space = sub(p[0])
            if type(space) is not dict or type(p[1]) is not str: raise PreparedMiss('namespace')
            value = space.get(p[1])
        elif tag == 'own':
            cls = sub(p[0])
            if type(cls) is not type: raise PreparedMiss('class')
            value = vars(cls).get(p[1])
        elif tag == 'mro':
            cls = sub(p[0])
            if type(cls) is not type or type(p[1]) is not int: raise PreparedMiss('mro')
            value = cls.__mro__[p[1]]
        elif tag == 'descriptor-function':
            owner = sub(p[0])
            if not _is_type(type(owner), (staticmethod, classmethod)): raise PreparedMiss('descriptor function')
            value = owner.__func__
        elif tag == 'kwdefaults': value = _plain_function(sub(p[0])).__kwdefaults__
        elif tag == 'cell': value = _plain_function(sub(p[0])).__closure__[p[1]]
        elif tag == 'method-function':
            method=sub(p[0])
            if type(method) is not MethodType: raise PreparedMiss('method function')
            value=method.__func__
        elif tag == 'method-self':
            method = sub(p[0])
            if not _is_type(type(method), (MethodType, BuiltinFunctionType)) or type(method.__self__) is not random.Random:
                raise PreparedMiss('random method')
            value = method.__self__
        elif tag == 'cell-view':
            from .heap import _CellView
            cell=sub(p[0])
            if type(cell) is not CellType or type(p[1]) is not str: raise PreparedMiss('cell view')
            value=_CellView(cell,p[1])
        elif tag == 'holder':
            value = {'gen': sub(p[0])}
            if type(value['gen']) is not random.Random: raise PreparedMiss('random holder')
        elif tag == 'strings': value = {}
        else: raise PreparedMiss('unknown recipe')
        self.resolved[cache_key] = value
        return value

    def value(self, value):
        if type(value) is CodeType:
            # Guard code always belongs to a recorded function.
            if self.program:
                for guard in self.program.guards.values():
                    if guard[0] == 'code' and guard[2] is value:
                        return ['code', self.ref(guard[1])]
            raise PreparedMiss('unowned code')
        return self.ref(value)

    def expected(self, recipe):
        if recipe[0] == 'current-attr':
            owner=self.resolve(recipe[1]); name=recipe[2]
            if type(owner) is not FunctionType or name not in ('__defaults__','__kwdefaults__'):
                if type(owner) is not type or name!='__mro__': raise PreparedMiss('attribute identity')
            return getattr(owner,name)
        if recipe[0] == 'code': return _plain_function(self.resolve(recipe[1])).__code__
        return self.resolve(recipe)


def _native_builtin(cls):
    from . import heap
    helper=vars(heap._native).get('prepared_builtin') if heap._native else None
    if (type(helper) is not BuiltinFunctionType or helper.__self__ is not heap._native
            or helper.__name__!='prepared_builtin'):
        raise PreparedMiss('native builtin identity unavailable')
    return helper(cls)


def _class_items(cls):
    namespace=vars(cls)
    for name in namespace:
        if type(name) is not str: raise PreparedMiss('class dictionary key')
        if name=='__slotnames__':
            # copyreg memoizes [] for ordinary classes with no slots. Sampling
            # can populate this cache while an otherwise identical saved run
            # does not. It is omitted only when no executable observes it.
            if type(namespace[name]) is not list or len(namespace[name])!=0:
                raise PreparedMiss('nonempty or unsupported slot-name cache')
            if any('__slots__' in vars(base) for base in cls.__mro__):
                raise PreparedMiss('slot-name cache on slotted class')
            continue
        yield name,namespace[name]


def _class_key(cls, refs):
    from . import heap
    if type(cls) is not type: raise PreparedMiss('custom metaclass')
    native_name=_native_builtin(cls)
    if native_name is not None: return dict(builtin=native_name)
    if not any(cls is c for c in (random.Random, *random.Random.__bases__)):
        problem = heap._object_problem(cls)
        if problem: raise PreparedMiss(problem)
    dictionary = []
    for name, value in _class_items(cls):
        if type(name) is not str: raise PreparedMiss('class dictionary key')
        if name in ('__dict__', '__weakref__'): continue
        t = type(value)
        if t is FunctionType:
            encoded = ['function', refs.ref(value)]
        elif t is type: raise PreparedMiss('nested class dictionary member')
        elif _is_type(t, (type(None), str, int, float, bool, tuple, bytes)):
            if name=='__module__' and value==refs.entry.__globals__.get('__name__'): value='$entry-module'
            encoded = ['literal', literal_key(value)]
        elif _is_type(t, (staticmethod, classmethod)):
            if type(value.__func__) is not FunctionType: raise PreparedMiss('descriptor function')
            encoded = [t.__name__, refs.ref(value.__func__)]
        elif _is_type(t, (MemberDescriptorType, GetSetDescriptorType, MethodDescriptorType,
                    WrapperDescriptorType, ClassMethodDescriptorType)):
            if value.__objclass__ is not cls: raise PreparedMiss('foreign class descriptor')
            encoded = ['descriptor', t.__name__, value.__name__, refs.ref(value.__objclass__)]
        elif t is BuiltinFunctionType:
            encoded = _binding_key(value)
        else: raise PreparedMiss('class dictionary member ' + name)
        dictionary.append([name, encoded])
    return dict(mro=[refs.ref(v) for v in cls.__mro__],
                layout=[cls.__basicsize__, cls.__itemsize__, cls.__dictoffset__, cls.__weakrefoffset__, cls.__flags__ & ~0x80000],
                dictionary=dictionary)


def _binding_key(value):
    t=type(value)
    if t is BuiltinFunctionType:
        owner=value.__self__
        if not _is_type(type(owner), (ModuleType,type,random.Random,type(None))):
            raise PreparedMiss('builtin owner')
        if type(owner) is type and type(type(owner)) is not type: raise PreparedMiss('builtin owner metaclass')
        return ['builtin',value.__module__,value.__name__,
                type(owner).__module__,type(owner).__qualname__]
    if t is MethodType:
        if type(value.__self__) is not random.Random: raise PreparedMiss('method owner')
        return ['method',value.__func__.__module__,value.__func__.__qualname__,
                type(value.__self__).__module__,type(value.__self__).__qualname__]
    if t is ModuleType:
        path=vars(value).get('__file__')
        return ['module',vars(value).get('__name__'),file_key(path) if type(path) is str and Path(path).is_file() else None]
    if _is_type(t, (FunctionType,type)): return [t.__name__]
    if t is tuple: return ['tuple',[_binding_key(v) for v in value]]
    if _is_type(t, (MemberDescriptorType,GetSetDescriptorType,MethodDescriptorType,WrapperDescriptorType,ClassMethodDescriptorType)):
        owner=value.__objclass__
        if type(owner) is not type: raise PreparedMiss('descriptor owner')
        return ['descriptor',t.__name__,value.__name__,owner.__module__,owner.__qualname__]
    if _is_type(t, (type(None),bool,int,float,str,bytes,complex,frozenset)): return ['literal',literal_key(value)]
    if t is random.Random: return ['random']
    if t is dict: return ['namespace']
    raise PreparedMiss('unsupported binding')


def _definitions(refs, program):
    functions, classes = {}, {}
    def add(value, binding=None):
        t = type(value)
        if t is FunctionType:
            fn = _plain_function(value)
            if '__slotnames__' in fn.__code__.co_names: raise PreparedMiss('observed slot-name cache')
            binding=refs.ref(fn) if binding is None else binding
            key = canonical(binding)
            if key in functions: return
            space=fn.__builtins__
            if type(space) is not dict: raise PreparedMiss('builtins namespace')
            if id(space) not in refs.known:
                refs.known[id(space)]=(space,['builtins-space',refs.ref(fn)])
            functions[key] = dict(binding=binding, key=function_key(fn, refs),
                                  builtins=refs.ref(space))
            for cell in fn.__closure__ or ():
                if type(cell.cell_contents) is type: add(cell.cell_contents)
        elif t is type:
            key = canonical(refs.ref(value))
            if key in classes: return
            classes[key] = dict(binding=refs.ref(value), key=_class_key(value, refs))
            for base in value.__mro__:
                if base is not value and base is not object: add(base)
        elif t is MethodType:
            recipe=refs.ref(value)
            add(value.__func__,['method-function',recipe])
        elif _is_type(t, (tuple, list)):
            for item in value: add(item)
    add(program.entry_fn)
    for info in _runtime_infos(program): add(info.fn)
    for cls in program.class_fields: add(cls)
    for guard in program.guards.values():
        for part in guard[1:]:
            if type(part) is str and part=='__slotnames__': raise PreparedMiss('guarded slot-name cache')
            add(part)
    values=[]
    for guard in program.guards.values():
        if guard[0] in ('item','own','attr','builtin') and not (guard[0]=='attr' and guard[2] in ('__mro__','__defaults__','__kwdefaults__')):
            value=guard[-1]
            if not _is_type(type(value), (CodeType,)):
                recipe=refs.ref(value)
                values.append(dict(binding=recipe,key=_binding_key(value)))
    return dict(functions=list(functions.values()), classes=list(classes.values()), namespaces=[], values=values, aliases=[])


def _signature(program):
    from . import heap as h
    return dict(args=h._param_kinds(program.entry), ret=h._machine_types(program.entry.ret))


def capture(program, *, seed=None, export, plan_key, build_key, variant=None):
    from . import heap as h
    refs = References(program.entry_fn, program)
    definitions = _definitions(refs, program)
    cells, ids = [], {}
    def cell(c):
        c = h._find(c)
        if id(c) not in ids:
            ids[id(c)] = len(cells)
            cells.append(None)
            cells[ids[id(c)]] = dict(elem=kind(c.elem), mutated=c.mutated)
        return ids[id(c)]
    def kind(v):
        if type(v) is str: return v
        if type(v) is h.ObjT: return ['object', refs.ref(v.cls), v.nullable, [refs.ref(c) for c in sorted(v.classes, key=program.tag)]]
        if _is_type(type(v), (h.ListT, h.ArrT)): return ['array' if type(v) is h.ArrT else 'list', cell(v.cell)]
        if type(v) is h.TupT: return ['tuple', [kind(i) for i in v.items], v.nullable]
        if type(v) is h.OptT: return ['optional', kind(v.base)]
        if type(v) is h.StrT: return ['string', v.nullable]
        if type(v) is h.DictT: return ['dict', cell(v.kcell), cell(v.vcell), v.nullable]
        if type(v) is h.SetT: return ['set', cell(v.cell), v.nullable]
        if type(v) is h.NdT: return ['ndarray', v.dtype, v.ndim, v.writable]
        if type(v) is h.RngT: return ['random']
        raise PreparedMiss('kind')
    infos = _runtime_infos(program)
    def guard(g):
        result=[g[0]]+[refs.value(v) for v in g[1:]]
        if g[0]=='attr' and g[2] in ('__mro__','__defaults__','__kwdefaults__'):
            result[3]=['current-attr',refs.ref(g[1]),g[2]]
        return result
    execution = dict(entry_function=infos.index(program.entry),
        functions=[dict(binding=refs.ref(i.fn), owner=refs.ref(i.owner) if i.owner else None,
            name=i.name, params=i.params, vars=[[n, kind(v)] for n, v in i.vars.items()], ret=kind(i.ret),
            constant=literal_key(i.constant), sink=i.sink, generator=i.generator, coroutine=i.coroutine,
            recursive=i.recursive) for i in infos],
        order=[infos.index(i) for i in program.order], cells=cells,
        classes=[dict(binding=refs.ref(c), assigned_names=sorted(names)) for c,names in program.class_fields.items()],
        families=[dict(root=refs.ref(c), members=[refs.ref(m) for m in program.members[c]],
            fields=[[n, kind(v)] for n,v in fields.items()], layout=list(program.layout(c)[0].items()),
            slots=program.layout(c)[1]) for c, fields in program.fields.items()],
        aliases=[[refs.ref(a), refs.ref(b)] for a,b in program.alias.items()],
        written=[[refs.ref(c), n] for c,n in sorted(program.written, key=lambda v:(v[0].__qualname__,v[1]))],
        globals=[dict(namespace=refs.ref(ns), name=n, kind=kind(v)) for ns,n,v in program.global_objects],
        strings=list(vars(program).get('str_constants', {})),
        guards=[guard(g) for g in program.guards.values()],
        flags={n:bool(getattr(program,n,False)) for n in ('arrays_used','arrays_written','array_views','rng_used','fast_mixed','saw_mixed','mixed_kind_used','zero_optimized')},
        reports={})
    for name in ('scalar_report','numeric_report','owner_report'):
        if name in vars(program):
            import json
            execution['reports'][name]=json.loads(canonical(vars(program)[name]))
    # kind() may add cells while constructing later metadata.
    execution['cells'] = cells
    core = dict(schema=SCHEMA, backend='heap', variant=variant or ('legacy' if seed is None else 'strict-seed'),
        entry_id=dict(file=str(Path(program.entry_fn.__code__.co_filename).resolve()),qualname=program.entry_fn.__qualname__,line=program.entry_fn.__code__.co_firstlineno),
        export=export, plan_key=plan_key, build_key=build_key, seed=seed,
        seed_identity=None if seed is None else digest(seed), definitions=definitions,
        generated=dict(digest=program.digest,source=program.source,source_sha256=hashlib.sha256(program.source.encode()).hexdigest(),
                       entry_symbol=program.entry.name,signature=_signature(program)), execution=execution)
    # JSON round trip also removes tuple/list incidental distinctions.
    import json
    core = json.loads(canonical(core))
    validate_core(core)
    return core


def core_id(core): return digest(core)


def bundle(cores, manifest=None, build_key=None):
    payload = dict(schema=SCHEMA, cores=cores)
    if manifest is not None: payload['manifest'] = manifest
    if build_key is not None: payload['build_key'] = build_key
    import json
    payload=json.loads(canonical(payload))
    return dict(payload, bundle_seal=digest(payload), seal_export='_prepared_seal')


def validate_core(core):
    """Validate the bounded primitive grammar; native seal validation is separate."""
    def require(test, reason='metadata'):
        if not test: raise PreparedMiss(reason)
    def primitive(v, depth=0):
        require(depth <= 100, 'nesting')
        if type(v) is dict:
            require(len(v) <= 100000)
            for k,x in v.items(): require(type(k) is str); primitive(x, depth+1)
        elif type(v) is list:
            require(len(v) <= 100000)
            for x in v: primitive(x, depth+1)
        else: require(_is_type(type(v), (type(None), str, bool, int, float)))
    primitive(core)
    require(len(canonical(core)) <= 32 * 1024 * 1024, 'size')
    require(type(core) is dict and type(core.get('schema')) is int and core['schema'] == SCHEMA)
    require(core.get('backend') == 'heap')
    require(core.get('variant') in ('legacy','strict-seed','wide-seed'))
    require(type(core['export']) is str and core['export'].startswith('r'))
    e = core['execution']
    require(type(e) is dict and set(e) == {'entry_function','functions','order','cells','classes','families','aliases','written','globals','strings','guards','flags','reports'})
    for n in ('functions','order','cells','classes','families','aliases','written','globals','strings','guards'):
        require(type(e[n]) is list)
    def index(n, values): require(type(n) is int and 0 <= n < len(values), 'index')
    index(e['entry_function'], e['functions'])
    require(bool(e['order']))
    for n in e['order']: index(n, e['functions'])
    require(len(set(e['order'])) == len(e['order']))
    def names(rows):
        require(type(rows) is list)
        require(all(type(v) is list and len(v)==2 and type(v[0]) is str for v in rows))
        require(len({v[0] for v in rows})==len(rows), 'duplicate name')
    scalar = {'i','f','b','n','m','?','F','I','B','Fq','Iq','Bq'}
    def kind(v, depth=0):
        require(depth < 80, 'kind recursion')
        if type(v) is str: require(v in scalar, 'scalar kind'); return
        require(type(v) is list and bool(v) and type(v[0]) is str)
        t,p = v[0],v[1:]
        if t == 'object':
            require(len(p)==3 and type(p[1]) is bool and type(p[2]) is list and bool(p[2]))
        elif t in ('list','array'): require(len(p)==1); index(p[0],e['cells'])
        elif t == 'tuple':
            require(len(p)==2 and type(p[0]) is list and type(p[1]) is bool)
            for k in p[0]: kind(k,depth+1)
        elif t == 'optional': require(len(p)==1); kind(p[0],depth+1)
        elif t == 'string': require(len(p)==1 and type(p[0]) is bool)
        elif t == 'dict':
            require(len(p)==3 and type(p[2]) is bool); index(p[0],e['cells']); index(p[1],e['cells'])
        elif t == 'set': require(len(p)==2 and type(p[1]) is bool); index(p[0],e['cells'])
        elif t == 'ndarray': require(len(p)==3 and p[0] in ('float64','int64','bool') and type(p[1]) is int and 0 < p[1] <= 32 and type(p[2]) is bool)
        elif t == 'random': require(not p)
        else: raise PreparedMiss('kind')
    for c in e['cells']:
        require(type(c) is dict and set(c)=={'elem','mutated'} and type(c['mutated']) is bool); kind(c['elem'])
    for f in e['functions']:
        require(type(f) is dict and type(f['name']) is str)
        require(type(f['params']) is list and all(type(n) is str for n in f['params']) and len(f['params'])==len(set(f['params'])))
        names(f['vars'])
        for _,v in f['vars']: kind(v)
        kind(f['ret'])
        for n in ('sink','generator','coroutine','recursive'): require(type(f[n]) is bool)
    roots, members = set(), set()
    for f in e['families']:
        r=canonical(f['root']); require(r not in roots); roots.add(r)
        names(f['fields']); names(f['layout'])
        require(type(f['slots']) is int and f['slots']>0)
        require([n for n,_ in f['fields']]==[n for n,_ in f['layout']])
        for _,v in f['fields']: kind(v)
        for m in f['members']:
            m=canonical(m); require(m not in members, 'overlapping families'); members.add(m)
    require(members=={canonical(c['binding']) for c in e['classes']}, 'incomplete families')
    aliases={canonical(a):canonical(b) for a,b in e['aliases']}
    require(len(aliases)==len(e['aliases']))
    for a in aliases:
        seen=set(); cur=a
        while cur in aliases:
            require(cur not in seen,'alias cycle'); seen.add(cur); cur=aliases[cur]
        require(cur in roots)
    for g in e['globals']: require(type(g['name']) is str); kind(g['kind'])
    arity={'code':3,'lifetime':2,'attr':4,'own':4,'item':4,'builtin':5,'const':4,'kwdefaults':4}
    for g in e['guards']: require(type(g) is list and g and len(g)==arity.get(g[0]),'guard')
    require(type(e['flags']) is dict and all(type(v) is bool for v in e['flags'].values()))
    require(type(e['reports']) is dict)
    require(all(type(s) is str for s in e['strings']))
    generated=core['generated']
    require(type(generated['source']) is str and hashlib.sha256(generated['source'].encode()).hexdigest()==generated['source_sha256'],'source digest')
    require(type(generated['digest']) is str and len(generated['digest'])==64)
    require(type(generated['signature']) is dict)


def _function_snapshot(fn):
    kw=fn.__kwdefaults__
    if kw is not None and (type(kw) is not dict or any(type(k) is not str for k in kw)):
        raise PreparedMiss('keyword defaults')
    return (weakref.ref(fn),fn.__code__,fn.__defaults__,id(kw),None if kw is None else tuple(kw.items()),
            tuple(c.cell_contents for c in fn.__closure__ or ()))


def _function_unchanged(snapshot):
    reference,code,defaults,kw_id,items,closure=snapshot
    fn=reference()
    if fn is None: return False
    kw=fn.__kwdefaults__
    if kw is not None and (type(kw) is not dict or any(type(k) is not str for k in kw)): return False
    if fn.__code__ is not code or fn.__defaults__ is not defaults or id(kw)!=kw_id:
        return False
    if kw is not None and (len(kw)!=len(items) or any(kw.get(n) is not v for n,v in items)):
        return False
    for cell,value in zip(fn.__closure__ or (),closure):
        try:
            if cell.cell_contents is not value: return False
        except ValueError: return False
    return True


def _class_snapshot(cls):
    if type(cls) is not type: raise PreparedMiss('class binding')
    if _native_builtin(cls) is not None: return cls,cls.__mro__,None
    # Validate without retaining a container of arbitrary program-owned objects.
    for name,value in _class_items(cls):
        if type(name) is not str: raise PreparedMiss('class dictionary key')
        t=type(value)
        if t is type: raise PreparedMiss('nested class dictionary member')
        if _is_type(t, (FunctionType,MemberDescriptorType,GetSetDescriptorType,
                 MethodDescriptorType,WrapperDescriptorType,ClassMethodDescriptorType)): continue
        if _is_type(t, (staticmethod,classmethod)):
            if type(value.__func__) is not FunctionType: raise PreparedMiss('descriptor function')
            continue
        if t is BuiltinFunctionType:
            _binding_key(value); continue
        literal_key(value)
    items=[]
    for name,value in _class_items(cls):
        t=type(value)
        if t is FunctionType:
            saved=('weak',weakref.ref(value))
        elif _is_type(t, (staticmethod,classmethod)):
            saved=('method',t,id(value),weakref.ref(value.__func__))
        else:
            if _is_type(t, (MemberDescriptorType,GetSetDescriptorType,MethodDescriptorType,
                     WrapperDescriptorType,ClassMethodDescriptorType)) and value.__objclass__ is not cls:
                raise PreparedMiss('foreign class descriptor')
            saved=('strong',value)
        items.append((name,saved))
    return cls,cls.__mro__,tuple(items)


def _class_unchanged(snapshot):
    cls,mro,items=snapshot
    if items is None: return _native_builtin(cls) is not None and cls.__mro__ is mro
    try: current=dict(_class_items(cls))
    except PreparedMiss: return False
    if cls.__mro__ is not mro or len(current)!=len(items): return False
    for name,saved in items:
        value=current.get(name)
        if saved[0]=='weak':
            if saved[1]() is None or value is not saved[1](): return False
        elif saved[0]=='method':
            if type(value) is not saved[1] or id(value)!=saved[2] or value.__func__ is not saved[3](): return False
        elif value is not saved[1]: return False
    return True


def _restore(core, entry, run):
    from . import heap as h
    refs=References(entry)
    definitions=core['definitions']
    snapshots=[]
    wrappers=[]
    for row in definitions['functions']:
        raw=refs.resolve(row['binding']); fn=_plain_function(raw)
        snapshot=_function_snapshot(fn)
        if fn.__builtins__ is not refs.resolve(row['builtins']): raise PreparedMiss('builtin namespace alias')
        actual_key=function_key(fn,refs)
        if not _function_unchanged(snapshot): raise PreparedMiss('function changed during validation')
        if actual_key!=row['key']:
            raise PreparedMiss('function key '+fn.__qualname__+': '+','.join(k for k in actual_key if actual_key[k]!=row['key'].get(k)))
        if raw is not fn: wrappers.append(weakref.ref(raw))
        snapshots.append(snapshot)
    for row in definitions['values']:
        if _binding_key(refs.resolve(row['binding']))!=row['key']: raise PreparedMiss('binding key')
    class_snapshots=[]
    for row in definitions['classes']:
        cls=refs.resolve(row['binding'])
        snapshot=_class_snapshot(cls)
        actual=_class_key(cls,refs)
        if actual!=row['key']:
            differences=[k for k in actual if actual[k]!=row['key'].get(k)]
            if 'dictionary' in differences:
                old=dict(row['key']['dictionary']); new=dict(actual['dictionary'])
                differences+=['member:'+k for k in new if new[k]!=old.get(k)]
            raise PreparedMiss('class key '+cls.__qualname__+': '+','.join(differences))
        if not _class_unchanged(snapshot): raise PreparedMiss('class changed during validation')
        class_snapshots.append(snapshot)
    e=core['execution']
    cells=[h._Cell() for _ in e['cells']]
    def cls(r):
        c=refs.resolve(r)
        if type(c) is not type: raise PreparedMiss('class binding')
        return c
    def kind(v):
        if type(v) is str: return v
        t,*p=v
        if t=='object': return h.ObjT(cls(p[0]),p[1],[cls(c) for c in p[2]])
        if t=='list': return h.ListT(cells[p[0]])
        if t=='array': return h.ArrT(cells[p[0]])
        if t=='tuple': return h.TupT([kind(i) for i in p[0]],p[1])
        if t=='optional': return h.OptT(kind(p[0]))
        if t=='string': return h.StrT(p[0])
        if t=='dict': return h.DictT(cells[p[0]],cells[p[1]],p[2])
        if t=='set': return h.SetT(cells[p[0]],p[1])
        if t=='ndarray': return h.NdT(*p)
        if t=='random': return h.RngT()
        raise PreparedMiss('kind')
    for c,row in zip(cells,e['cells']): c.elem,c.mutated=kind(row['elem']),row['mutated']
    class RuntimeProgram(h._Program):
        def guards_hold(self):
            from ._runner_wrapper import guard as wrapper_guard
            for reference in wrappers:
                wrapper=reference()
                if wrapper is None or not wrapper_guard(wrapper): return False
            if not all(_class_unchanged(s) for s in class_snapshots): return False
            if not all(_function_unchanged(s) for s in snapshots): return False
            # Recheck every binding identity without retaining a second globals map.
            for recipe,value in binding_guards:
                try:
                    fresh=References(entry).resolve(recipe)
                    if type(value) is weakref.ReferenceType:
                        expected=value()
                        if expected is None or _plain_function(fresh) is not _plain_function(expected): return False
                    elif fresh is not value: return False
                except (PreparedMiss,KeyError,IndexError,TypeError,AttributeError): return False
            return super().guards_hold()
    p=object.__new__(RuntimeProgram)
    p.entry_fn=entry; p.numeric_policy=None; p.broken=False
    p.class_fields={cls(r['binding']):set(r['assigned_names']) for r in e['classes']}
    p.fields={cls(r['root']):{n:kind(v) for n,v in r['fields']} for r in e['families']}
    p.members={cls(r['root']):[cls(c) for c in r['members']] for r in e['families']}
    p.alias={cls(a):cls(b) for a,b in e['aliases']}
    p.written={(cls(c),n) for c,n in e['written']}
    infos=[]
    for row in e['functions']:
        info=SimpleNamespace(**{k:v for k,v in row.items() if k not in ('binding','owner','vars','ret','constant')})
        info.fn=_plain_function(refs.resolve(row['binding'])); info.owner=cls(row['owner']) if row['owner'] else None
        info.vars={n:kind(v) for n,v in row['vars']}; info.ret=kind(row['ret']); info.constant=unliteral(row['constant'])
        infos.append(info)
    p.entry=infos[e['entry_function']]; p.order=[infos[i] for i in e['order']]
    p.functions={i:info for i,info in enumerate(infos)}
    p.global_objects=[(refs.resolve(r['namespace']),r['name'],kind(r['kind'])) for r in e['globals']]
    p.global_index={}; p.calls={}; p.guards={}
    strings=refs.resolve(['strings'])
    strings.update((s,s) for s in e['strings']); p.str_constants=strings
    for row in e['guards']:
        g=[row[0]]+[refs.expected(v) for v in row[1:]]
        if g[0]=='code': g[1]=_plain_function(g[1]); g[2]=g[1].__code__
        if g[0]=='item' and type(g[3]) is FunctionType:
            # Store the actual adapter identity while guarding its registered behavior.
            if _plain_function(g[3]) is not g[3]: wrappers.append(weakref.ref(g[3]))
        p.guard(*g)
    for n,v in e['flags'].items(): setattr(p,n,v)
    for n,v in e['reports'].items():
        if n in ('scalar_report','numeric_report','owner_report'): setattr(p,n,v)
    p.source=core['generated']['source']; p.digest=core['generated']['digest']
    p.run=run; p.module=None; p.cached=p.ahead_of_time=True; p.prepared=True
    for f in e['families']:
        offsets,size=p.layout(cls(f['root']))
        if list(map(list,offsets.items()))!=f['layout'] or size!=f['slots']: raise PreparedMiss('layout')
    if _signature(p)!=core['generated']['signature']: raise PreparedMiss('signature')
    binding_guards=[]
    for row in definitions['functions']+definitions['classes']:
        value=refs.resolve(row['binding'])
        binding_guards.append((row['binding'],weakref.ref(value) if type(value) is FunctionType else value))
    if not p.guards_hold(): raise PreparedMiss('live guards')
    return p


class VerifiedExports(dict):
    allow_jit=False
    def __init__(self, values, signatures):
        import json
        super().__init__(values); self.signatures=json.loads(canonical(signatures))
    def resolve_program(self, program):
        run=self.get(program.digest)
        if run is None: raise PreparedMiss('no exact AOT export')
        if _signature(program)!=self.signatures[program.digest]: raise PreparedMiss('AOT signature changed')
        return run


_AUTHORITY = object()


class PreparedIndex:
    def __init__(self, module, exports, cores, snapshot_key, build_key, *, _authority=None):
        if _authority is not _AUTHORITY: raise PreparedMiss('unverified prepared index')
        import json
        self.module,self.exports,self.cores=module,exports,json.loads(canonical(cores))
        self._core_ids=tuple(core_id(c) for c in self.cores)
        self.snapshot_key,self.build_key=snapshot_key,build_key
        self.reasons=[]
    def bind(self, entry):
        programs=[]
        for core,sealed_id in zip(self.cores,self._core_ids):
            try:
                if core_id(core)!=sealed_id: raise PreparedMiss('changed bound metadata')
                if core['plan_key']!=self.snapshot_key: miss('plan'); self.reasons.append(last_miss()); continue
                if core['build_key']!=self.build_key: miss('compiler'); self.reasons.append(last_miss()); continue
                programs.append(_restore(core,entry,self.exports[core['generated']['digest']]))
            except (PreparedMiss,OSError,KeyError,IndexError,TypeError,ValueError,AttributeError,RecursionError) as exc:
                miss('binding',exc); self.reasons.append(last_miss())
        return programs


def _manifest_rows(section):
    import json
    return json.loads(canonical([{k:v for k,v in row.items() if k!='prepared'} | {'prepared':row.get('prepared',[])} for row in section['functions']]))


def _native_callable(fn, name, module_name, path):
    from . import heap
    helper=vars(heap._native).get('prepared_origin') if heap._native else None
    if (type(helper) is not BuiltinFunctionType or helper.__self__ is not heap._native
            or helper.__name__!='prepared_origin'):
        raise PreparedArtifactMismatch('native provenance unavailable')
    if type(fn) is not BuiltinFunctionType or fn.__name__!=name or fn.__module__!=module_name:
        raise PreparedArtifactMismatch('native callable')
    origins=helper(fn)
    if (type(origins) is not tuple or len(origins)!=2
            or any(type(p) is not str or Path(p).resolve()!=path for p in origins)):
        raise PreparedArtifactMismatch('native binary provenance')


def open_index(section, function_row, *, plan_snapshot, module=None):
    """Return verified exports even on a live-key miss; never bypass a bad seal."""
    try:
        data=section['prepared']
        if type(data) is not dict or data.get('schema')!=SCHEMA: raise PreparedArtifactMismatch('schema')
        artifact=data['artifact']; path=(Path(section['folder'])/artifact['file']).resolve()
        if path.parent!=Path(section['folder']).resolve() or path.name!=section['module']+sysconfig_extension():
            raise PreparedArtifactMismatch('artifact path')
        blob=path.read_bytes()
        if len(blob)!=artifact['length'] or hashlib.sha256(blob).hexdigest()!=artifact['sha256']:
            raise PreparedArtifactMismatch('artifact bytes')
        if _manifest_rows(section)!=data['manifest']['functions']: raise PreparedArtifactMismatch('export manifest')
        if function_row not in section['functions']: raise PreparedArtifactMismatch('foreign function row')
        payload={k:data[k] for k in ('schema','cores','manifest','build_key')}
        if digest(payload)!=data['bundle_seal']:
            miss('seal', 'bundle hash'); return None
        for c in data['cores']: validate_core(c)
        build=dict(compiler=compiler_key(),runtime=runtime_key())
        if build['runtime']!=data['build_key']['runtime']: miss('runtime'); return None
        old=sys.modules.get(section['module'])
        if old is not None:
            if type(old) is not ModuleType or vars(old).get('__file__')!=str(path): raise PreparedArtifactMismatch('module collision')
            spec=vars(old).get('__spec__')
            if not spec or type(spec.loader) is not importlib.machinery.ExtensionFileLoader: raise PreparedArtifactMismatch('module loader')
            prior=_VERIFIED_MODULES.get(section['module'])
            if prior is None or prior[0] is not old or any(vars(old).get(n) is not f for n,f in prior[1].items()):
                raise PreparedArtifactMismatch('unverified or changed loaded module')
            native=old
        else:
            spec=importlib.util.spec_from_file_location(section['module'],path)
            if not spec or type(spec.loader) is not importlib.machinery.ExtensionFileLoader: raise PreparedArtifactMismatch('native loader')
            native=importlib.util.module_from_spec(spec)
            spec.loader.exec_module(native); sys.modules[section['module']]=native
        seal=vars(native).get(data['seal_export'])
        _native_callable(seal,data['seal_export'],section['module'],path)
        actual=seal()
        expected=tuple(int(data['bundle_seal'][i:i+8],16) for i in range(0,64,8))
        if (type(actual) is not tuple or len(actual)!=8 or any(type(v) is not int or not 0<=v<=0xffffffff for v in actual) or actual!=expected):
            miss('seal'); return None
        values={}; signatures={}
        for row in data['manifest']['functions']:
            for d,name in row['exports'].items():
                fn=vars(native).get(name)
                _native_callable(fn,name,section['module'],path)
                values[d]=fn; signatures[d]=data['manifest']['signatures'][d]
        _VERIFIED_MODULES[section['module']] = (native, {n:f for n,f in vars(native).items() if type(f) is BuiltinFunctionType})
        ids=function_row.get('prepared',[])
        cores=[c for c in data['cores'] if core_id(c) in ids]
        return PreparedIndex(native,VerifiedExports(values,signatures),cores,plan_key(plan_snapshot),build,_authority=_AUTHORITY)
    except PreparedArtifactMismatch as exc:
        miss('artifact',exc); return None
    except (PreparedMiss,OSError,KeyError,IndexError,TypeError,ValueError,AttributeError,RecursionError) as exc:
        miss('metadata',exc); return None


def sysconfig_extension():
    import sysconfig
    return sysconfig.get_config_var('EXT_SUFFIX')
