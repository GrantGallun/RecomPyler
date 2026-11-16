"""Closed, primitive proof IR for live Python-object access.

This module proves effects and identity demand, not pointer validity. A runtime
must additionally supply the installed-header layout, ownership, native-entry
and observation-free execution certificates. Nothing here activates direct
execution or authorizes a Python-level rollback after a native call.
"""
from dataclasses import dataclass, field


def _name(value):
    if type(value) is not str:
        raise ValueError('proof names and operands require primitive strings')



@dataclass(frozen=True, order=True)
class Place:
    space: str
    owner: int
    field: str = '*'

    def __post_init__(self):
        if type(self.space) is not str:
            raise ValueError('locations require primitive memory-space names')
        if self.space not in ('field', 'list', 'array', 'unknown'):
            raise ValueError('unknown memory space')
        if type(self.owner) is not int or self.owner < 0 or type(self.field) is not str:
            raise ValueError('locations require primitive owner IDs and field names')


@dataclass(frozen=True)
class Operation:
    opcode: str
    place: Place | None = None
    callee: str | None = None
    helper: str | None = None
    failure: str = 'checked'

    def __post_init__(self):
        for value in (self.opcode, self.failure):
            _name(value)
        for value in (self.callee, self.helper):
            if value is not None:
                _name(value)
        if self.place is not None and type(self.place) is not Place:
            raise ValueError('proof locations require primitive Place values')


@dataclass(frozen=True)
class FunctionIR:
    name: str
    operations: tuple

    def __post_init__(self):
        _name(self.name)
        if type(self.operations) is not tuple or any(type(op) is not Operation for op in self.operations):
            raise ValueError('function operations require a primitive typed tuple')


@dataclass(frozen=True)
class Summary:
    reads: frozenset = field(default_factory=frozenset)
    writes: frozenset = field(default_factory=frozenset)
    topology: frozenset = field(default_factory=frozenset)
    helpers: frozenset = field(default_factory=frozenset)
    observers: frozenset = field(default_factory=frozenset)
    failures: frozenset = field(default_factory=frozenset)
    unknown: frozenset = field(default_factory=frozenset)
    private_allocation: bool = False
    arrays_read: bool = False
    arrays_written: bool = False
    rng: bool = False
    recursive: bool = False

    def __post_init__(self):
        for name in ('reads', 'writes', 'topology', 'helpers', 'observers', 'failures', 'unknown'):
            values = getattr(self, name)
            wanted = Place if name in ('reads', 'writes', 'topology') else str
            if type(values) is not frozenset or any(type(v) is not wanted for v in values):
                raise ValueError('summary facts require primitive typed frozensets')
        for name in ('private_allocation', 'arrays_read', 'arrays_written', 'rng', 'recursive'):
            if type(getattr(self, name)) is not bool:
                raise ValueError('summary facts require primitive booleans')

    @property
    def read_only(self):
        return not (self.writes or self.topology or self.observers or self.unknown
                    or self.arrays_written or self.rng)

    def union(self, other):
        return Summary(**{name: (getattr(self, name) | getattr(other, name))
                          for name in self.__dataclass_fields__})


@dataclass(frozen=True)
class Helper:
    """A compiler-supplied audited native-helper contract, never a profile fact.

    Registration is explicit. It is not a proof of a callable's machine code;
    native binding must check its separately authenticated implementation.
    """
    name: str
    reads: frozenset = field(default_factory=frozenset)
    writes: frozenset = field(default_factory=frozenset)
    topology: frozenset = field(default_factory=frozenset)
    failures: frozenset = field(default_factory=frozenset)
    observers: frozenset = field(default_factory=frozenset)
    private_allocation: bool = False
    arrays_read: bool = False
    arrays_written: bool = False
    rng: bool = False

    def __post_init__(self):
        _name(self.name)
        for name in ('reads', 'writes', 'topology'):
            value = getattr(self, name)
            if type(value) is not frozenset or any(type(p) is not Place for p in value):
                raise ValueError('helper memory contracts require primitive places')
        for name in ('failures', 'observers'):
            value = getattr(self, name)
            if type(value) is not frozenset:
                raise ValueError('helper contracts require primitive sets')
            for item in value:
                _name(item)
        for name in ('private_allocation', 'arrays_read', 'arrays_written', 'rng'):
            if type(getattr(self, name)) is not bool:
                raise ValueError('helper contracts require primitive booleans')


class Effects:
    """Finite union fixed point over canonical memory families/list cells.

    Distinct arguments do not establish disjointness: locations refer to shared
    canonical families/cells. An unknown helper, operation or location blocks
    borrowing. No recursive access-path truncation can manufacture purity.
    """
    _scalar = frozenset(('parameter', 'constant', 'move', 'phi', 'return',
                         'numeric_unary', 'numeric_binary', 'comparison'))

    def __init__(self, functions, *, helpers=(), canonical=None):
        functions = tuple(functions)
        if any(type(f) is not FunctionIR for f in functions):
            raise ValueError('functions require primitive typed IR records')
        self.functions = {f.name: f for f in functions}
        if len(self.functions) != len(functions):
            raise ValueError('duplicate function identity')
        contracts = tuple(helpers)
        if any(type(h) is not Helper for h in contracts):
            raise ValueError('helpers require primitive typed contracts')
        self.helpers = {h.name: h for h in contracts}
        if len(self.helpers) != len(contracts):
            raise ValueError('duplicate helper identity')
        self.canonical = dict(canonical or {})
        for (space, owner), target in self.canonical.items():
            Place(space, owner)
            Place(space, target)
            self._place(Place(space, owner))
        self.calls = {name: frozenset(op.callee for op in f.operations
                                     if op.opcode == 'call' and op.callee in self.functions)
                      for name, f in self.functions.items()}
        self.summaries = {name: self._local(f) for name, f in self.functions.items()}
        # A union lattice over the finite operation/place/helper sets settles
        # even for recursive SCCs. Read from the previous iteration so traversal
        # order cannot change which iteration discovers a fact.
        self.iterations = 0
        while True:
            self.iterations += 1
            updated = {}
            for name in sorted(self.functions):
                summary = self.summaries[name]
                for callee in sorted(self.calls[name]):
                    summary = summary.union(self.summaries[callee])
                updated[name] = summary
            if updated == self.summaries:
                break
            self.summaries = updated

    def _place(self, place):
        if type(place) is not Place:
            raise ValueError('location is not a typed Place')
        owner, seen = place.owner, set()
        while (place.space, owner) in self.canonical:
            if owner in seen:
                raise ValueError('canonical alias cycle')
            seen.add(owner)
            owner = self.canonical[place.space, owner]
        return Place(place.space, owner, place.field)

    def _recursive(self, name):
        pending, seen = list(self.calls[name]), set()
        while pending:
            callee = pending.pop()
            if callee == name:
                return True
            if callee not in seen:
                seen.add(callee)
                pending.extend(self.calls[callee])
        return False

    def _local(self, function):
        result = Summary(recursive=self._recursive(function.name))
        for index, op in enumerate(function.operations):
            tag = f'{function.name}:{index}:{op.opcode}'
            code = op.opcode
            part = Summary()
            if code in ('load_numeric', 'load_reference', 'store_numeric', 'store_reference', 'resize'):
                if type(op.place) is not Place or op.place.space == 'unknown':
                    part = Summary(unknown=frozenset((tag + ':missing/unknown location',)))
                else:
                    where = frozenset((self._place(op.place),))
                    if code.startswith('load_'):
                        part = Summary(reads=where)
                    elif code == 'store_numeric':
                        part = Summary(writes=where)
                    else:
                        part = Summary(writes=where, topology=where)
            elif code == 'call':
                if op.callee not in self.functions:
                    part = Summary(unknown=frozenset((tag + ':unknown callee',)))
            elif code == 'helper':
                helper = self.helpers.get(op.helper)
                if helper is None:
                    part = Summary(unknown=frozenset((tag + ':unknown helper',)))
                else:
                    data = {name: getattr(helper, name) for name in helper.__dataclass_fields__ if name != 'name'}
                    for name in ('reads', 'writes', 'topology'):
                        data[name] = frozenset(self._place(p) for p in data[name])
                    part = Summary(**data, helpers=frozenset((helper.name,)))
                    if any(p.space == 'unknown' for p in part.reads | part.writes | part.topology):
                        part = part.union(Summary(unknown=frozenset((tag + ':unknown helper location',))))
            elif code == 'observer':
                part = Summary(observers=frozenset((tag,)))
            elif code == 'rng':
                part = Summary(rng=True)
            elif code == 'array_read':
                part = Summary(arrays_read=True)
            elif code == 'array_write':
                part = Summary(arrays_written=True)
            elif code == 'alloc_private':
                part = Summary(private_allocation=True)
            elif code == 'checked_exit':
                part = Summary(failures=frozenset((op.failure,)))
            elif code not in self._scalar:
                part = Summary(unknown=frozenset((tag + ':unknown operation',)))
            result = result.union(part)
        return result

    def summary(self, name):
        return self.summaries[name]

    @staticmethod
    def _overlap(a, b, *, topology=False):
        if a.space == 'unknown' or b.space == 'unknown':
            return True
        if (a.space, a.owner) != (b.space, b.owner):
            return False
        return topology or a.field == '*' or b.field == '*' or a.field == b.field

    def borrowable(self, name):
        summary = self.summary(name)
        if summary.observers or summary.unknown or summary.rng or summary.arrays_written or summary.topology:
            return frozenset()
        return frozenset(p for p in summary.reads
                         if not any(self._overlap(p, w) for w in summary.writes)
                         and not any(self._overlap(p, w, topology=True) for w in summary.topology))

    def report(self):
        def primitive(value):
            if type(value) is bool:
                return value
            return [dict(space=p.space, owner=p.owner, field=p.field) if type(p) is Place else p
                    for p in sorted(value)]
        return {name: {key: primitive(getattr(summary, key))
                       for key in summary.__dataclass_fields__}
                for name, summary in sorted(self.summaries.items())}


@dataclass(frozen=True)
class Producer:
    rule: str
    operands: tuple = ()

    def __post_init__(self):
        _name(self.rule)
        if type(self.operands) is not tuple:
            raise ValueError('producer operands require a primitive tuple')
        for value in self.operands:
            _name(value)


class Identity:
    """Backward numeric-box demand over a closed producer/transfer graph.

    Fresh entries identify producer *sites*, not reusable boxes. The emitter
    must allocate a new dynamic token on each execution of a demanded fresh
    site and materialize each dynamic token once. Equal bits never merge sites.
    """
    def __init__(self, values, roots):
        self.values = dict(values)
        if any(type(p) is not Producer for p in self.values.values()):
            raise ValueError('identity facts require primitive typed producers')
        roots = tuple(roots)
        for value in (*self.values, *roots):
            _name(value)
        demanded, existing, fresh, recipes, problems, transfers = set(), set(), set(), set(), set(), {}
        pending = list(roots)
        while pending:
            value = pending.pop()
            if value in demanded:
                continue
            demanded.add(value)
            producer = self.values.get(value)
            if type(producer) is not Producer:
                problems.add(f'{value}: missing producer')
                continue
            rule, operands = producer.rule, tuple(producer.operands)
            if rule == 'existing':
                existing.add(value)
            elif rule == 'independent':
                fresh.add(value)
            elif rule in ('forward', 'select', 'exact'):
                if not operands:
                    problems.add(f'{value}: {rule} requires operands')
                    continue
                if rule == 'forward' and len(operands) != 1:
                    problems.add(f'{value}: forward requires one operand')
                    continue
                transfers[value] = operands
                if rule == 'exact':
                    recipes.add(value)
                pending.extend(operands)
            else:
                problems.add(f'{value}: unsupported producer')
        # An SCC needs an existing or dynamic producer origin. Reaching an
        # anchored SCC is necessary, not a CFG definite-initialization proof;
        # the emitter must additionally check phi entry/back-edge assignments.
        anchored = existing | fresh
        while True:
            added = {value for value, operands in transfers.items()
                     if any(operand in anchored for operand in operands)}
            if added <= anchored:
                break
            anchored |= added
        for value in transfers.keys() - anchored:
            problems.add(f'{value}: no origin for demanded transfer')
        self.demanded = frozenset(demanded)
        self.existing = frozenset(existing)
        self.fresh = frozenset(fresh)
        self.recipes = frozenset(recipes)
        self.transfers = dict(sorted(transfers.items()))
        self.problems = tuple(sorted(problems))


def from_program(program):
    """Conservative input-memory facts from the settled checked heap compiler.

    Every numeric field of an input-reachable family and each input list cell
    is treated as read, even if a particular body does not load it. Writes come
    from the compiler's whole-graph canonical written set and shared mutation
    cells, never from sample identities. List mutation conservatively invalidates
    all its storage. This memory certificate still requires the separate raw
    machine/helper, layout, identity and ownership certificates before execution.
    The returned facts retain no Program, class, function, cell or input object.
    """
    import ast
    from . import heap as h
    operations, families, cells, visited = [], {}, {}, set()

    def family(root):
        root = program.canon(root)
        if root not in families:
            families[root] = len(families)
        return families[root]

    def location(root, name):
        return Place('field', family(root), name)

    def visit(kind, read=False):
        if isinstance(kind, str):
            if kind not in h.NUMBERS and kind not in (h.NONE, h.BOTTOM):
                operations.append(Operation('unsupported_numeric_shape'))
            return
        if isinstance(kind, h.OptT):
            visit(kind.base, read)
        elif isinstance(kind, h.ObjT):
            root = program.family(kind.cls)
            key = ('field', family(root), read)
            if key in visited:
                return
            visited.add(key)
            for name, part in program.fields.get(root, {}).items():
                numeric = isinstance(part, str) and part in h.NUMBERS
                if read:
                    operations.append(Operation('load_numeric' if numeric else 'load_reference',
                                                place=location(root, name)))
                visit(part, read)
        elif type(kind) is h.ListT:
            cell = h._find(kind.cell)
            if cell not in cells:
                cells[cell] = len(cells)
            key = ('list', cells[cell], read)
            if key in visited:
                return
            visited.add(key)
            place = Place('list', cells[cell])
            if read:
                operations.append(Operation('load_numeric' if isinstance(cell.elem, str)
                                            and cell.elem in h.NUMBERS else 'load_reference', place=place))
            if cell.mutated:
                operations.append(Operation('resize', place=place))
            visit(cell.elem, read)
        elif isinstance(kind, h.TupT):
            for part in kind.items:
                visit(part, read)
        elif isinstance(kind, h.NdT):
            operations.append(Operation('array_read'))
        elif isinstance(kind, h.RngT):
            operations.append(Operation('rng'))
        else:
            operations.append(Operation('unsupported_object_shape'))

    for name in program.entry.params:
        visit(program.entry.vars.get(name, h.BOTTOM), True)
    for _, _, kind in program.global_objects:
        visit(kind, True)
    # Include writes through all internal call paths, including cells not first
    # encountered at an entry parameter. Canonical cells propagate aliases.
    for info in program.order:
        # The legacy written set elides self stores in constructors. A call to
        # __init__ need not have a freshly allocated receiver; until allocation
        # origins accompany each call edge, do not certify any such graph.
        if info.owner is not None and info.fn.__name__ == '__init__':
            operations.append(Operation('constructor_receiver_origin_unproved'))
        for kind in info.vars.values():
            visit(kind)
        if getattr(info, 'object_allocations', None):
            operations.append(Operation('alloc_private'))
        if info.generator or info.coroutine:
            operations.append(Operation('observer'))
        if any(isinstance(node, ast.Call) and isinstance(node.func, ast.Name)
               and node.func.id == 'print' for node in ast.walk(ast.parse(info.source))):
            operations.append(Operation('observer'))
    for root, name in program.written_set():
        part = program.fields.get(program.canon(root), {}).get(name, h.BOTTOM)
        numeric = isinstance(part, str) and part in h.NUMBERS
        operations.append(Operation('store_numeric' if numeric else 'store_reference',
                                    place=location(root, name)))
    if getattr(program, 'arrays_written', False):
        operations.append(Operation('array_write'))
    if any(info.recursive for info in program.order):
        operations.append(Operation('call', callee='entry'))
    return Effects((FunctionIR('entry', tuple(operations)),))
