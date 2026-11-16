"""Compiled control flow for live, heterogeneous CPython data structures.

All operands use the canonical managed reference ABI. Operations may call Python,
but an entered body never replays, including after a partial store or exception.
"""
import ast
import functools
import operator

from ._call_bridge import _Compiler, CallRegion, UnsupportedCall


@functools.lru_cache(maxsize=64)
def _unpacker(count):
    # CPython performs exactly count+1 iterator advances, and checks the arity
    # before storing the outer targets. Nested patterns are unpacked later.
    names = ['a' + str(index) for index in range(count)]
    target = '(' + ','.join(names) + (',' if count == 1 else '') + ')'
    scope = {}
    exec('def unpack(value):\n    ' + target + ' = value\n    return ' + target, scope)
    return scope['unpack']


class _StructureCompiler(_Compiler):
    def __init__(self, fn):
        super().__init__(fn)
        class Bindings(ast.NodeVisitor):
            def __init__(self):self.names = set()
            def visit_Name(self, node):
                if isinstance(node.ctx, ast.Store):self.names.add(node.id)
            def visit_FunctionDef(self, node):self.names.add(node.name)
            def visit_AsyncFunctionDef(self, node):self.names.add(node.name)
            def visit_ClassDef(self, node):self.names.add(node.name)
            def visit_Lambda(self, node):pass
            def visit_ListComp(self, node):pass
            def visit_SetComp(self, node):pass
            def visit_DictComp(self, node):pass
            def visit_GeneratorExp(self, node):pass
        bindings = Bindings()
        for statement in self.node.body:bindings.visit(statement)
        temporary = {name.id for node in ast.walk(self.node)
                     if isinstance(node, (ast.ListComp, ast.SetComp, ast.DictComp, ast.GeneratorExp))
                     for gen in node.generators for name in ast.walk(gen.target) if isinstance(name, ast.Name)}
        parameters = {arg.arg for arg in self.node.args.posonlyargs + self.node.args.args + self.node.args.kwonlyargs}
        # PEP 709 gives comprehension temporaries slots in co_varnames without
        # making them function locals outside that comprehension's scope.
        self.locals = (self.locals - temporary) | bindings.names | parameters

    def assign(self, target, value):
        if isinstance(target, ast.Name):
            return super().assign(target, value)
        if isinstance(target, ast.Attribute):
            owner = self.expression(target.value)
            self.runtime_call(self.pooled(setattr), [owner, self.constant(target.attr), value], counted=True)
            return
        if isinstance(target, ast.Subscript) and not isinstance(target.slice, ast.Slice):
            owner = self.expression(target.value)
            index = self.expression(target.slice)
            self.runtime_call(self.pooled(operator.setitem), [owner, index, value], counted=True)
            return
        if isinstance(target, (ast.Tuple, ast.List)) and not any(isinstance(item, ast.Starred) for item in target.elts):
            unpacked = self.runtime_call(self.pooled(_unpacker(len(target.elts))), [value])
            for index, item in enumerate(target.elts):
                part = self.operation('_getitem_object', unpacked, self.pooled(index))
                self.assign(item, part)
            return
        raise UnsupportedCall('structure assignment: ' + type(target).__name__)

    def _truth_once(self, value, known, truth):
        self.line('if not ' + known + ':')
        self.indent += 1
        checked = self.operation('_truth_object', value)
        self.line(truth + ' = ' + checked)
        self.line(known + ' = True')
        self.indent -= 1
        return truth

    def condition(self, node):
        if isinstance(node, ast.IfExp):
            truth = self.condition(node.test)
            result = self.fresh()
            self.line('if ' + truth + ':')
            self.indent += 1
            self.line(result + ' = ' + self.condition(node.body))
            self.indent -= 1
            self.line('else:')
            self.indent += 1
            self.line(result + ' = ' + self.condition(node.orelse))
            self.indent -= 1
            return result
        if isinstance(node, ast.BoolOp):
            result = self.fresh()
            self.line(result + ' = ' + self.condition(node.values[0]))
            for operand in node.values[1:]:
                self.line('if ' + ('not ' if isinstance(node.op, ast.Or) else '') + result + ':')
                self.indent += 1
                self.line(result + ' = ' + self.condition(operand))
            self.indent -= len(node.values) - 1
            return result
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not):
            truth = self.condition(node.operand)
            result = self.fresh()
            self.line(result + ' = not ' + truth)
            return result
        if isinstance(node, (ast.BoolOp, ast.Compare)):
            value, known, truth = self.logical(node)
            return self._truth_once(value, known, truth)
        return self.operation('_truth_object', self.expression(node))

    def compare_value(self, op, left, right):
        operations = {ast.Is: operator.is_, ast.IsNot: operator.is_not,
                      ast.Eq: operator.eq, ast.NotEq: operator.ne,
                      ast.Lt: operator.lt, ast.LtE: operator.le,
                      ast.Gt: operator.gt, ast.GtE: operator.ge,
                      ast.In: operator.contains, ast.NotIn: operator.contains}
        fn = operations.get(type(op))
        if fn is None:raise UnsupportedCall('structure comparison')
        args = [right, left] if isinstance(op, (ast.In, ast.NotIn)) else [left, right]
        value = self.runtime_call(self.pooled(fn), args)
        if isinstance(op, ast.NotIn):
            value = self.runtime_call(self.pooled(operator.not_), [value])
        return value

    def logical(self, node):
        # CPython threads a short-circuit decision through nested boolean and
        # comparison syntax. Keep that decision beside its object: testing that
        # same object again can call stateful __bool__ a second time.
        result, known, truth = self.fresh(), self.fresh(), self.fresh()
        if isinstance(node, ast.BoolOp):
            value, seen, checked = self.logical(node.values[0])
            self.line(result + ' = ' + value)
            self.line(known + ' = ' + seen)
            self.line(truth + ' = ' + checked)
            for operand in node.values[1:]:
                self._truth_once(result, known, truth)
                self.line('if ' + ('not ' if isinstance(node.op, ast.Or) else '') + truth + ':')
                self.indent += 1
                value, seen, checked = self.logical(operand)
                self.line(result + ' = ' + value)
                self.line(known + ' = ' + seen)
                self.line(truth + ' = ' + checked)
            self.indent -= len(node.values) - 1
        elif isinstance(node, ast.Compare):
            left = self.expression(node.left)
            self.line(known + ' = False')
            self.line(truth + ' = False')
            for index, (op, operand) in enumerate(zip(node.ops, node.comparators)):
                if index:
                    self._truth_once(result, known, truth)
                    self.line('if ' + truth + ':')
                    self.indent += 1
                right = self.expression(operand)
                value = self.compare_value(op, left, right)
                self.line(result + ' = ' + value)
                self.line(known + ' = False')
                left = right
            self.indent -= len(node.ops) - 1
        else:
            value = self.expression(node)
            self.line(result + ' = ' + value)
            self.line(known + ' = False')
            self.line(truth + ' = False')
        return result, known, truth

    def expression(self, node):
        if isinstance(node, ast.IfExp):
            truth = self.condition(node.test)
            result = self.fresh()
            self.line('if ' + truth + ':')
            self.indent += 1
            self.line(result + ' = ' + self.expression(node.body))
            self.indent -= 1
            self.line('else:')
            self.indent += 1
            self.line(result + ' = ' + self.expression(node.orelse))
            self.indent -= 1
            return result
        if isinstance(node, ast.Dict) and not node.keys:
            return self.operation('_dict_object')
        if isinstance(node, ast.BinOp) and isinstance(node.op, (ast.BitAnd, ast.BitOr, ast.BitXor)):
            operation = {ast.BitAnd: operator.and_, ast.BitOr: operator.or_, ast.BitXor: operator.xor}[type(node.op)]
            return self.runtime_call(self.pooled(operation), [self.expression(node.left), self.expression(node.right)])
        if isinstance(node, (ast.SetComp, ast.ListComp, ast.DictComp)):
            return self.set_comprehension(node)
        if isinstance(node, (ast.BoolOp, ast.Compare)):
            return self.logical(node)[0]
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not):
            # Value-context UNARY_NOT tests the returned operand again; only
            # conditional jump contexts thread the earlier truth decision.
            return self.runtime_call(self.pooled(operator.not_), [self.expression(node.operand)])
        return super().expression(node)

    def comprehension_frame(self):
        return self.runtime_call(self.pooled(dict), ['_frame'])

    def clear_comprehension_name(self,frame,name):
        self.runtime_call(self.pooled(dict.pop),[frame,self.constant(name),self.pooled(None)])

    def set_comprehension(self, node):
        if any(gen.is_async for gen in node.generators):
            raise UnsupportedCall('async set comprehension')
        # The outer iterable is evaluated in the enclosing scope, before the
        # temporary induction bindings are installed or its iterator advances.
        outer = self.operation('_getiter_object', self.expression(node.generators[0].iter))
        saved = self.fresh()
        self.line(saved + ' = _frame')
        copied = self.comprehension_frame()
        bound = {name.id for gen in node.generators for name in ast.walk(gen.target) if isinstance(name, ast.Name)}
        for name in sorted(bound):
            self.clear_comprehension_name(copied,name)
        self.line('_frame = ' + copied)
        enclosing_locals = self.locals
        self.locals = enclosing_locals | bound
        constructor = dict if isinstance(node, ast.DictComp) else list if isinstance(node, ast.ListComp) else set
        result = self.runtime_call(self.pooled(constructor), [])
        def generate(index):
            if index == len(node.generators):
                if isinstance(node, ast.DictComp):
                    key = self.expression(node.key)
                    value = self.expression(node.value)
                    self.runtime_call(self.pooled(operator.setitem), [result, key, value], counted=True)
                else:
                    item = self.expression(node.elt)
                    method = 'append' if isinstance(node, ast.ListComp) else 'add'
                    add = self.operation('_getattr_object', result, self.pooled(method))
                    self.runtime_call(add, [item], counted=True)
                return
            gen = node.generators[index]
            iterator = outer if index == 0 else self.operation('_getiter_object', self.expression(gen.iter))
            self.line('while True:')
            self.indent += 1
            item = self.fresh()
            self.line(item + ', _ended, _ok = _next_object(' + iterator + ')')
            self.line('if not _ok:')
            self.indent += 1
            self.line('_capture_error(_errors)')
            self.line('return _errors, False')
            self.indent -= 1
            self.line('if _ended: break')
            self.assign(gen.target, item)
            for condition in gen.ifs:
                truth = self.condition(condition)
                self.line('if not ' + truth + ': continue')
            generate(index + 1)
            self.indent -= 1
        generate(0)
        self.locals = enclosing_locals
        self.line('_frame = ' + saved)
        return result

    def statements(self, body):
        for statement in body:
            if isinstance(statement, ast.While) and not statement.orelse:
                self.line('while True:')
                self.indent += 1
                condition = self.condition(statement.test)
                self.line('if not ' + condition + ': break')
                self.statements(statement.body)
                self.indent -= 1
            elif isinstance(statement, ast.If):
                self.line('if ' + self.condition(statement.test) + ':')
                self.indent += 1
                self.statements(statement.body)
                self.indent -= 1
                if statement.orelse:
                    self.line('else:')
                    self.indent += 1
                    self.statements(statement.orelse)
                    self.indent -= 1
            elif isinstance(statement, ast.AugAssign) and isinstance(statement.op, ast.Add):
                target = statement.target
                if isinstance(target, ast.Name):
                    prior = self.name(target.id)
                    owner = index = None
                elif isinstance(target, ast.Attribute):
                    owner = self.expression(target.value)
                    index = self.constant(target.attr)
                    prior = self.operation('_getattr_object', owner, index)
                elif isinstance(target, ast.Subscript) and not isinstance(target.slice, ast.Slice):
                    owner = self.expression(target.value)
                    index = self.expression(target.slice)
                    prior = self.operation('_getitem_object', owner, index)
                else:raise UnsupportedCall('augmented structure target')
                value = self.expression(statement.value)
                updated = self.runtime_call(self.pooled(operator.iadd), [prior, value], counted=True)
                if isinstance(target, ast.Name):self.assign(target, updated)
                else:
                    store = setattr if isinstance(target, ast.Attribute) else operator.setitem
                    self.runtime_call(self.pooled(store), [owner, index, updated], counted=True)
            elif isinstance(statement, ast.Raise) and statement.exc is not None and statement.cause is None:
                value = self.expression(statement.exc)
                self.runtime_call(self.pooled(operator.setitem), ['_errors', self.pooled(0), value])
                self.line('return _errors, False')
            elif isinstance(statement, ast.Break):self.line('break')
            elif isinstance(statement, ast.Continue):self.line('continue')
            else:super().statements([statement])



class StructureRegion(CallRegion):
    compiler_type = _StructureCompiler


def lift_structures(fn, *, call_kinds=False):
    import types
    if type(fn) is types.FunctionType and (fn.__code__.co_cellvars or fn.__code__.co_freevars or any(type(value) is types.CodeType for value in fn.__code__.co_consts)):
        from ._generators import GeneratorRegion
        return GeneratorRegion(fn,call_kinds=call_kinds)
    return StructureRegion(fn,call_kinds=call_kinds)

