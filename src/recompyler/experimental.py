"""Explicit, bounded integer experiments using the existing heap compiler.

Default ``lift_numeric`` is the ordinary strict lifter. Checked contracts retain
Python semantics through entry replay. ``unchecked-int64`` intentionally wraps
each +,-,*; invalid representations or unavailable native execution raise rather
than silently running different arithmetic in Python. See docs/experimental-numeric.md.
"""
import ast
from collections.abc import Mapping
from dataclasses import dataclass
import hashlib
import importlib.util
import inspect
import json
import keyword
import marshal
from pathlib import Path
import sys
from types import FunctionType

from . import heap

_SCHEMA = 1
_PROOF = 1
_MAX_TRIPS = 1024
_OPS = {ast.Add: "add", ast.Sub: "sub", ast.Mult: "mul"}
_FULL = (heap.INT_MIN, heap.INT_MAX)
# A real default may itself be inspect.Parameter.empty. Keep default presence
# distinct from Signature's missing-default marker until arguments are bound.
_PRESENT = object()

# LLVM instructions have empty flags: modulo arithmetic, with no nsw/nuw promise.
# The complete implementation is included in both generated source and identity.
_WRAP_RUNTIME = '''
from numba import types as _numeric_types
from numba.extending import intrinsic as _numeric_intrinsic

@_numeric_intrinsic
def _numeric_add(typingctx, left, right):
    if not isinstance(left, _numeric_types.Integer) or not isinstance(right, _numeric_types.Integer):
        return
    signature = _numeric_types.int64(_numeric_types.int64, _numeric_types.int64)
    def codegen(context, builder, sig, args):
        return builder.add(args[0], args[1], flags=())
    return signature, codegen

@_numeric_intrinsic
def _numeric_sub(typingctx, left, right):
    if not isinstance(left, _numeric_types.Integer) or not isinstance(right, _numeric_types.Integer):
        return
    signature = _numeric_types.int64(_numeric_types.int64, _numeric_types.int64)
    def codegen(context, builder, sig, args):
        return builder.sub(args[0], args[1], flags=())
    return signature, codegen

@_numeric_intrinsic
def _numeric_mul(typingctx, left, right):
    if not isinstance(left, _numeric_types.Integer) or not isinstance(right, _numeric_types.Integer):
        return
    signature = _numeric_types.int64(_numeric_types.int64, _numeric_types.int64)
    def codegen(context, builder, sig, args):
        return builder.mul(args[0], args[1], flags=())
    return signature, codegen

'''


class NumericContractError(ValueError):
    """An unchecked call cannot satisfy representation/execution requirements."""


class UnsupportedNumericRegion(heap.Unsupported):
    """The explicitly requested pilot grammar/proof is unavailable."""


@dataclass(frozen=True, init=False)
class IntIntervals(Mapping):
    """Immutable inclusive int64 parameter intervals, canonically name-sorted."""

    _items: tuple

    def __init__(self, **bounds):
        values = []
        for name, interval in bounds.items():
            if type(name) is not str:
                raise TypeError("interval names must be exact Python strings")
            if not name.isidentifier() or keyword.iskeyword(name):
                raise ValueError("interval names must be Python parameter names")
            if type(interval) not in (tuple, list) or len(interval) != 2:
                raise TypeError(f"{name}: interval must have two integer endpoints")
            low, high = interval
            if type(low) is not int or type(high) is not int:
                raise TypeError(f"{name}: interval endpoints must be exact Python ints")
            if not heap.INT_MIN <= low <= high <= heap.INT_MAX:
                raise ValueError(f"{name}: interval must be ordered and within signed int64")
            values.append((name, (low, high)))
        object.__setattr__(self, "_items", tuple(sorted(values)))

    def __getitem__(self, name):
        for key, value in self._items:
            if name == key:
                return value
        raise KeyError(name)

    def __iter__(self):
        return (name for name, _ in self._items)

    def __len__(self):
        return len(self._items)


def _origin(node, op):
    return (node.lineno, node.col_offset, node.end_lineno, node.end_col_offset, _OPS[op])


def _join(left, right):
    return min(left[0], right[0]), max(left[1], right[1])


def _literal(node):
    if isinstance(node, ast.Constant) and type(node.value) is int:
        return node.value
    if (isinstance(node, ast.UnaryOp) and isinstance(node.op, (ast.UAdd, ast.USub))
            and isinstance(node.operand, ast.Constant) and type(node.operand.value) is int):
        return -node.operand.value if isinstance(node.op, ast.USub) else node.operand.value
    return None


def _binding_signature(fn):
    """Real Python parameter binding without evaluating annotation/wrapper hooks."""
    code = fn.__code__
    defaults = fn.__defaults__
    kwdefaults = fn.__kwdefaults__
    defaults = () if defaults is None else defaults
    kwdefaults = {} if kwdefaults is None else kwdefaults
    default_count = tuple.__len__(defaults)
    parameters = []
    for index, name in enumerate(code.co_varnames[:code.co_argcount]):
        kind = inspect.Parameter.POSITIONAL_ONLY if index < code.co_posonlyargcount else inspect.Parameter.POSITIONAL_OR_KEYWORD
        default_index = index - code.co_argcount + default_count
        default = tuple.__getitem__(defaults, default_index) if default_index >= 0 else inspect.Parameter.empty
        if default_index >= 0 and default is inspect.Parameter.empty:
            default = _PRESENT
        parameters.append(inspect.Parameter(name, kind, default=default))
    for name in code.co_varnames[code.co_argcount:code.co_argcount+code.co_kwonlyargcount]:
        default = dict.get(kwdefaults, name, inspect.Parameter.empty)
        if dict.__contains__(kwdefaults, name) and default is inspect.Parameter.empty:
            default = _PRESENT
        parameters.append(inspect.Parameter(name, inspect.Parameter.KEYWORD_ONLY,
                                            default=default))
    return inspect.Signature(parameters)


@dataclass(frozen=True)
class IntervalCertificate:
    origin: tuple
    left: tuple
    right: tuple
    result: tuple


class _Analysis:
    def __init__(self, fn, node, contract, checked):
        self.fn, self.node, self.contract, self.checked = fn, node, contract, checked
        self.sites, self.certificates, self.loop_stops = set(), {}, []
        self.loop_seen = False

    def reject(self, message):
        raise UnsupportedNumericRegion(message)

    def expression(self, node, env, structural=False):
        literal = _literal(node)
        if literal is not None:
            if not heap.INT_MIN <= literal <= heap.INT_MAX:
                self.reject("integer literal is outside signed int64")
            return literal, literal
        if isinstance(node, ast.Name):
            if node.id not in env:
                self.reject(f"'{node.id}' is not definitely bound to an integer")
            return env.get(node.id, _FULL)
        if isinstance(node, ast.BinOp) and type(node.op) in _OPS:
            left = self.expression(node.left, env, structural)
            right = self.expression(node.right, env, structural)
            return self.operation(node, type(node.op), left, right, structural)
        self.reject("only scalar integer names, literals and +,-,* expressions are supported")

    def operation(self, node, op, left, right, structural):
        key = _origin(node, op)
        self.sites.add(key)
        if structural:
            return _FULL
        if op is ast.Add:
            result = left[0] + right[0], left[1] + right[1]
        elif op is ast.Sub:
            result = left[0] - right[1], left[1] - right[0]
        else:
            products = [a*b for a in left for b in right]
            result = min(products), max(products)
        if not heap.INT_MIN <= result[0] <= result[1] <= heap.INT_MAX:
            if self.checked:
                self.reject(f"unproved int64 intermediate at line {node.lineno} ({_OPS[op]})")
            result = _FULL
        if self.checked:
            current = result
            previous = self.certificates.get(key)
            if previous is not None:
                left, right, result = (_join(previous.left, left), _join(previous.right, right),
                                       _join(previous.result, result))
            self.certificates[key] = IntervalCertificate(key, left, right, result)
            return current
        return result

    def assignment(self, target, value, env, structural):
        if isinstance(target, ast.Name):
            env[target.id] = self.expression(value, env, structural)
        elif (isinstance(target, ast.Tuple) and isinstance(value, ast.Tuple)
              and len(target.elts) == len(value.elts) and target.elts
              and all(isinstance(part, ast.Name) for part in target.elts)):
            values = [self.expression(part, env, structural) for part in value.elts]
            for name, interval in zip(target.elts, values):
                env[name.id] = interval
        else:
            self.reject("only name and parallel scalar tuple assignments are supported")

    def statements(self, body, env, structural=False, in_loop=False):
        for node in body:
            if isinstance(node, ast.Assign) and len(node.targets) == 1:
                self.assignment(node.targets[0], node.value, env, structural)
            elif isinstance(node, ast.AugAssign) and isinstance(node.target, ast.Name) and type(node.op) in _OPS:
                left = self.expression(node.target, env, structural)
                right = self.expression(node.value, env, structural)
                env[node.target.id] = self.operation(node, type(node.op), left, right, structural)
            elif isinstance(node, ast.For) and not in_loop:
                self.loop(node, env, structural)
            else:
                self.reject("unsupported statement in experimental integer region")

    def loop(self, node, env, structural):
        if structural:
            if self.loop_seen:
                self.reject("only one nonnested counted loop is supported")
            self.loop_seen = True
        call = node.iter
        if not (isinstance(node.target, ast.Name) and not node.orelse
                and isinstance(call, ast.Call) and isinstance(call.func, ast.Name)
                and call.func.id == "range" and len(call.args) == 1 and not call.keywords
                and "range" not in self.fn.__globals__ and "range" not in self.contract
                and not any(isinstance(item, ast.Name) and item.id == "range" and isinstance(item.ctx, ast.Store)
                            for item in ast.walk(self.node))
                and self.fn.__builtins__.get("range") is range):
            self.reject("only builtin range(stop) loops without else are supported")
        stop = call.args[0]
        literal = _literal(stop)
        if isinstance(stop, ast.Name) and stop.id in self.contract:
            writes = {item.id for item in ast.walk(self.node)
                      if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store)}
            if stop.id in writes:
                self.reject("loop stop must be an unrebound entry parameter")
            interval = self.contract[stop.id]
            name = stop.id
        elif literal is not None and heap.INT_MIN <= literal <= heap.INT_MAX:
            interval, name = (literal, literal), None
        else:
            self.reject("loop stop must be an integer literal or unrebound entry parameter")
        low, high = max(0, interval[0]), max(0, interval[1])
        if high > _MAX_TRIPS:
            self.reject(f"loop proof exceeds {_MAX_TRIPS} trips")
        if structural:
            self.loop_stops.append((name, literal))
            nested = dict(env)
            nested[node.target.id] = _FULL
            self.statements(node.body, nested, True, True)
            env.update(nested)
            return
        state = dict(env)
        exits = [dict(state)] if low == 0 else []
        for index in range(high):
            state[node.target.id] = index, index
            self.statements(node.body, state, False, True)
            if index+1 >= low:
                exits.append(dict(state))
        common = set.intersection(*(set(state) for state in exits))
        joined = {name: (min(state[name][0] for state in exits), max(state[name][1] for state in exits))
                  for name in common}
        env.clear()
        env.update(joined)

    def run(self):
        body = self.node.body
        if body and isinstance(body[0], ast.Expr) and isinstance(body[0].value, ast.Constant) and type(body[0].value.value) is str:
            body = body[1:]
        if not body or not isinstance(body[-1], ast.Return) or body[-1].value is None:
            self.reject("experimental region needs one terminal scalar return")
        env = dict(self.contract)
        structural_env = dict(env)
        self.statements(body[:-1], structural_env, True)
        self.expression(body[-1].value, structural_env, True)
        self.statements(body[:-1], env)
        self.expression(body[-1].value, env)
        return tuple(self.certificates.values())


@dataclass(frozen=True)
class _Policy:
    function: object
    code: object
    mode: str
    contract: IntIntervals
    certificates: tuple
    sites: frozenset
    loop_stops: tuple
    metadata: str
    identity: str
    source: str

    def lower(self, gen, op, left, right, node):
        if gen.info.fn is not self.function or self.function.__code__ is not self.code:
            raise UnsupportedNumericRegion("experimental function identity changed")
        key = _origin(node, op)
        allowed = self.sites if self.mode == "unchecked-int64" else {proof.origin for proof in self.certificates}
        if key not in allowed:
            return None
        return gen.temp(f"_numeric_{_OPS[op]}({left}, {right})")


def _policy(fn, mode, contract):
    if not isinstance(fn, FunctionType) or fn.__closure__ or fn.__code__.co_flags & (0x04 | 0x08 | 0x20 | 0x80 | 0x200):
        raise UnsupportedNumericRegion("only fixed-parameter plain synchronous functions are supported")
    if "__signature__" in vars(fn) or "__wrapped__" in vars(fn):
        raise UnsupportedNumericRegion("custom signature/wrapped metadata is unsupported")
    signature = _binding_signature(fn)
    if set(signature.parameters) != set(contract):
        raise ValueError("interval contract must name every parameter exactly once")
    try:
        program = heap._Program(fn)
    except heap.Unsupported as exc:
        raise UnsupportedNumericRegion(str(exc)) from exc
    analysis = _Analysis(fn, program.entry.node, contract, mode == "checked")
    certificates = analysis.run()
    native = getattr(heap._native, "__file__", None)
    metadata = json.dumps({
        "schema": _SCHEMA, "proof": _PROOF, "mode": mode,
        "contract": list(contract._items), "max_trips": _MAX_TRIPS,
        "origin": hashlib.sha256(marshal.dumps(fn.__code__) + ast.dump(program.entry.node, include_attributes=True).encode()).hexdigest(),
        "implementation": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "intrinsics": hashlib.sha256(_WRAP_RUNTIME.encode()).hexdigest(),
        "native_abi": hashlib.sha256(Path(native).read_bytes()).hexdigest() if native else None,
        "certificates": [(proof.origin, proof.left, proof.right, proof.result) for proof in certificates],
    }, sort_keys=True, separators=(",", ":"))
    identity = hashlib.sha256(metadata.encode()).hexdigest()
    return _Policy(fn, fn.__code__, mode, contract, certificates, frozenset(analysis.sites),
                   tuple(analysis.loop_stops), metadata, identity,
                   "# experimental numeric policy: " + metadata + "\n" + _WRAP_RUNTIME)


class NumericRegion(heap.Region):
    """An explicitly requested, guarded numeric policy on the ordinary Region ABI."""

    experimental_numeric = True

    def __init__(self, fn, policy, ahead_of_time=None):
        super().__init__(fn, ahead_of_time)
        self._policy = policy
        code = policy.code
        self._parameter_names = code.co_varnames[:code.co_argcount+code.co_kwonlyargcount]
        positions = {name: index for index, name in enumerate(self._parameter_names)}
        self._contract_guards = tuple((positions[name], name, interval) for name, interval in policy.contract._items)
        self._loop_guards = tuple((positions[name] if name is not None else None, literal)
                                  for name, literal in policy.loop_stops)
        self.contract_native_calls = self.guard_misses = self.representation_rejections = 0
        self.loop_limit_rejections = self.native_failures = 0

    @property
    def policy(self):
        return self._policy

    @property
    def mode(self):
        return self.policy.mode

    @property
    def contract(self):
        return self.policy.contract

    @property
    def identity(self):
        return self.policy.identity

    @property
    def proof_certificates(self):
        return self.policy.certificates

    def _make_program(self):
        program = heap._Program(self.original, numeric_policy=self.policy)
        origin = hashlib.sha256(marshal.dumps(self.original.__code__)
                                + ast.dump(program.entry.node, include_attributes=True).encode()).hexdigest()
        if self.original.__code__ is not self.policy.code or origin != json.loads(self.policy.metadata)["origin"]:
            raise UnsupportedNumericRegion("experimental source no longer matches the certified origin")
        program.guard("code", self.original, self.policy.code)
        class SignedLiterals(ast.NodeTransformer):
            def visit_UnaryOp(self, node):
                value = _literal(node)
                return ast.copy_location(ast.Constant(value=value), node) if value is not None else node
        program.entry.node = SignedLiterals().visit(program.entry.node)
        return program

    def load(self, program, args):
        if program.numeric_policy is not self.policy:
            raise heap._Mismatch()
        return super().load(program, args)

    def _reject(self, reason, kind="representation"):
        if self.mode == "checked":
            self.guard_misses += 1
            return False, None
        if kind == "loop":
            self.loop_limit_rejections += 1
        else:
            self.representation_rejections += 1
        raise NumericContractError(reason)

    def attempt(self, args, kwargs=None):
        policy = self._policy
        if (self.original.__code__ is not policy.code
                or "__signature__" in vars(self.original) or "__wrapped__" in vars(self.original)):
            return self._reject("experimental function code/binding metadata changed")
        code = policy.code
        if (type(args) is tuple and not code.co_kwonlyargcount
                and (kwargs is None or (type(kwargs) is dict and not kwargs))):
            # Fixed positional binding needs only arity and the current trailing
            # defaults. Tuple base operations bypass possible default-subclass hooks.
            defaults = self.original.__defaults__
            default_count = 0 if defaults is None else tuple.__len__(defaults)
            missing = code.co_argcount - tuple.__len__(args)
            if missing < 0 or missing > default_count:
                return self._reject("arguments do not bind")
            passed = args if not missing else args + tuple.__getitem__(defaults, slice(default_count-missing, default_count))
        else:
            # Keep general binding, including live keyword-only defaults, separate.
            try:
                bound = _binding_signature(self.original).bind(*args, **(kwargs or {}))
            except TypeError:
                return self._reject("arguments do not bind")
            provided = frozenset(bound.arguments)
            bound.apply_defaults()
            values = bound.arguments
            for name in values.keys() - provided:
                if values[name] is _PRESENT:
                    values[name] = inspect.Parameter.empty
            passed = tuple(values[name] for name in self._parameter_names)
        mode = policy.mode
        for position, name, interval in self._contract_guards:
            value = passed[position]
            if mode == "checked":
                # The validated tight interval already lies within signed int64.
                if type(value) is not int or not interval[0] <= value <= interval[1]:
                    return self._reject(f"{name} is outside the checked exact-int interval")
            elif type(value) is not int or not heap.INT_MIN <= value <= heap.INT_MAX:
                return self._reject(f"{name} must be an exact Python int representable in signed int64")
        if mode == "unchecked-int64":
            # Checked stop intervals/literals already imply this cap. Unchecked
            # tight bounds are documentary and need the independent runtime guard.
            for position, literal in self._loop_guards:
                value = passed[position] if position is not None else literal
                if max(0, value) > _MAX_TRIPS:
                    return self._reject(f"loop exceeds the {_MAX_TRIPS}-trip operational limit", "loop")
        try:
            ok, value = super().attempt(passed, _bound_entry=True)
        except Exception as exc:
            if mode == "unchecked-int64":
                self.native_failures += 1
                raise NumericContractError("unchecked native execution is unavailable") from exc
            raise
        if ok:
            self.contract_native_calls += 1
        elif mode == "unchecked-int64":
            self.native_failures += 1
            raise NumericContractError("unchecked native execution is unavailable: " + (self.problem or "guard/status failure"))
        return ok, value

    def __call__(self, *args, **kwargs):
        if self.mode == "checked":
            return super().__call__(*args, **kwargs)
        try:
            ok, value = self.attempt(args, kwargs)
        except RecursionError as exc:
            self.native_failures += 1
            raise NumericContractError("unchecked native execution is unavailable") from exc
        if not ok:
            self.native_failures += 1
            raise NumericContractError("unchecked native execution is unavailable")
        self.compiled_calls += 1
        return value


def lift_numeric(fn, *, mode="strict", contract=None):
    """Lift normally, or explicitly select a checked/wrapping integer pilot."""
    if mode == "strict":
        return heap.lift_region(fn)
    if mode not in ("checked", "unchecked-int64"):
        raise ValueError("mode must be strict, checked or unchecked-int64")
    if type(contract) is not IntIntervals:
        raise ValueError("an exact IntIntervals contract is required")
    return NumericRegion(fn, _policy(fn, mode, contract))


class _SourceOnly:
    def __bool__(self):
        return True

    def get(self, digest, default=None):
        return object()


class _ExactExport(dict):
    def get(self, digest, default=None):
        if digest not in self:
            raise NumericContractError("experimental AOT source digest does not match the sealed artifact")
        return super().get(digest, default)


def build_numeric(region, folder):
    """Build one executed experimental specialization and its sealed manifest.

    This is explicit and separate from the strict runner's plans/type seeds.
    The caller must first complete a native call of the requested region.
    """
    if not isinstance(region, NumericRegion) or region.contract_native_calls == 0:
        raise ValueError("build_numeric requires a successfully executed experimental region")
    program = region.latest
    if (program is None or program.broken or program.numeric_policy is not region.policy
            or program.ahead_of_time or not program.guards_hold()):
        raise ValueError("a current successful JIT specialization is required")
    overloads = list(getattr(program.run, "overloads", {}).values())
    if len(overloads) != 1:
        raise ValueError("exactly one native machine signature is required")
    folder = Path(folder).resolve()
    folder.mkdir(parents=True, exist_ok=True)
    module_name = "rcnumeric_" + program.digest[:24]
    manifest_path = folder / (module_name + ".json")
    if manifest_path.exists():
        # Reusing an artifact requires the same sealed checks as loading it.
        load_numeric(region.original, manifest_path, mode=region.mode, contract=region.contract)
        return manifest_path
    from ._pycc import CC
    cc = CC(module_name)
    cc.output_dir, cc.verbose = str(folder), False
    cc.export("entry", overloads[0].signature)(heap._inlined_entry(program))
    cc.compile()
    binaries = [path for path in folder.glob(module_name + ".*") if path.suffix in (".pyd", ".so")]
    if len(binaries) != 1:
        raise NumericContractError("experimental AOT build did not produce one native extension")
    binary = binaries[0]
    manifest = {"schema": _SCHEMA, "kind": "recompyler-experimental-numeric",
                "policy": json.loads(region.policy.metadata), "identity": region.identity,
                "source_digest": program.digest, "module": module_name, "export": "entry",
                "binary": binary.name, "binary_sha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
                "python": sys.version}
    manifest_path.write_text(json.dumps(manifest, sort_keys=True, indent=2) + "\n", encoding="utf-8")
    return manifest_path


def load_numeric(fn, manifest, *, mode, contract):
    """Explicitly restore the same policy/source/ABI, without importing Numba."""
    if mode not in ("checked", "unchecked-int64"):
        raise NumericContractError("experimental artifacts require explicit checked or unchecked-int64 mode")
    region = lift_numeric(fn, mode=mode, contract=contract)
    manifest_path = Path(manifest).resolve()
    try:
        record = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        raise NumericContractError("experimental manifest is unreadable") from exc
    if (not isinstance(record, dict) or record.get("schema") != _SCHEMA
            or record.get("kind") != "recompyler-experimental-numeric"
            or record.get("python") != sys.version or record.get("identity") != region.identity
            or record.get("policy") != json.loads(region.policy.metadata)):
        raise NumericContractError("experimental artifact policy/source/ABI identity mismatch")
    # Regenerate exact-int code and digest with no compiler/runtime import.
    program = region._make_program()
    program.entry.vars.update((name, heap.INT) for name in program.entry.params)
    program.compile(_SourceOnly())
    if program.digest != record.get("source_digest"):
        raise NumericContractError("experimental artifact source digest mismatch")
    module_name, filename = record.get("module"), record.get("binary")
    if (module_name != "rcnumeric_" + program.digest[:24] or not isinstance(filename, str)
            or Path(filename).name != filename or not filename.startswith(module_name + ".")
            or Path(filename).suffix not in (".pyd", ".so") or record.get("export") != "entry"):
        raise NumericContractError("experimental artifact native entry metadata mismatch")
    binary = manifest_path.parent / filename
    try:
        binary_hash = hashlib.sha256(binary.read_bytes()).hexdigest()
    except OSError as exc:
        raise NumericContractError("experimental artifact native binary is missing") from exc
    if binary_hash != record.get("binary_sha256"):
        raise NumericContractError("experimental artifact native binary hash mismatch")
    try:
        spec = importlib.util.spec_from_file_location(module_name, binary)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        entry = module.entry
    except (OSError, ImportError, AttributeError) as exc:
        raise NumericContractError("experimental artifact native entry cannot be loaded") from exc
    region.ahead_of_time = _ExactExport({program.digest: entry})
    return region
