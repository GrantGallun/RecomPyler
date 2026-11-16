"""Lift non-adaptive CPython bytecode into a stack-parameter SSA CFG."""
import dis
import inspect
import sys
import types
from collections import deque
from .ops import Block, Edge, ExceptionRegion, FunctionIR, Operation, Value
from .types import PYOBJECT, INT64, NULL, Ownership, join_types
from .semantics import contract, UnsupportedBytecode, UNCONDITIONAL, CONDITIONAL, TERMINAL


def _layout(code, block_starts=()):
    instructions = tuple(dis.get_instructions(code, adaptive=False))
    if not instructions:
        raise UnsupportedBytecode('empty bytecode')
    by_offset = {i.offset: i for i in instructions}
    following = {i.offset: instructions[n+1].offset if n+1 < len(instructions) else None
                 for n,i in enumerate(instructions)}
    regions = tuple(ExceptionRegion(e.start,e.end,e.target,e.depth,e.lasti)
                    for e in dis.Bytecode(code).exception_entries)
    if type(block_starts) is not tuple:
        raise TypeError('block_starts must be a tuple of original instruction offsets')
    if any(type(offset) is not int or offset not in by_offset for offset in block_starts):
        raise UnsupportedBytecode('block start must be an original instruction offset')
    leaders = {instructions[0].offset, *block_starts}
    for i in instructions:
        if i.opname=='RESUME':leaders.add(i.offset)
        if i.opname in UNCONDITIONAL | CONDITIONAL | {'FOR_ITER','SEND'}:
            target = i.jump_target
            if target not in by_offset:
                raise UnsupportedBytecode(f'invalid jump target {target}')
            if i.opname == 'FOR_ITER':
                if by_offset[target].opname != 'END_FOR':
                    raise UnsupportedBytecode('FOR_ITER target must be END_FOR')
                target = following[target]
            leaders.add(target)
        if i.opname in UNCONDITIONAL | CONDITIONAL | TERMINAL | {'FOR_ITER','SEND','RETURN_GENERATOR','YIELD_VALUE'}:
            if following[i.offset] is not None: leaders.add(following[i.offset])
        if any(e.start <= i.offset < e.end for e in regions):
            leaders.add(i.offset)
            if following[i.offset] is not None: leaders.add(following[i.offset])
    for e in regions:
        leaders.add(e.target)
    blocks, current = {}, None
    for i in instructions:
        if i.offset in leaders:
            current = i.offset
            blocks[current] = []
        blocks[current].append(i)
    return instructions[0].offset, blocks, following, regions


class _Interpreter:
    def __init__(self, raw, following, regions):
        self.raw, self.following, self.regions = raw, following, regions
        self.next_value = 0

    def value(self, typ, ownership=Ownership.STACKREF):
        value = Value(self.next_value,typ, Ownership.NULL if typ == NULL else ownership)
        self.next_value += 1
        return value

    def run(self, offset, incoming, emit=False):
        stack = list(incoming)
        operations, edges = [], []
        def typ(value): return value.type if emit else value
        def fresh(value_type, ownership=Ownership.STACKREF):
            return self.value(value_type,ownership) if emit else value_type
        for instruction in self.raw[offset]:
            before = tuple(stack)
            consumed, types, name, attrs = contract(instruction)
            if len(stack) < consumed:
                raise UnsupportedBytecode(f'stack underflow at {instruction.offset}: {instruction.opname}')
            args = tuple(stack[-consumed:]) if consumed else ()
            if consumed: del stack[-consumed:]
            handler = next((r for r in self.regions if r.start <= instruction.offset < r.end), None)
            arg = instruction.arg or 0
            if name == 'copy':
                if arg < 1 or arg > len(stack): raise UnsupportedBytecode('COPY stack index')
                args = (stack[-arg],)
                types = (typ(args[0]),)
            elif name == 'swap':
                if arg < 1 or arg > len(stack): raise UnsupportedBytecode('SWAP stack index')
                args = (stack[-1],stack[-arg])
                stack[-1],stack[-arg] = stack[-arg],stack[-1]
            elif name == 'reraise' and arg:
                if arg > len(stack): raise UnsupportedBytecode('RERAISE lasti stack index')
                args += (stack[-arg],)
                attrs['lasti_depth'] = arg
            elif name=='send':
                if not stack:raise UnsupportedBytecode('SEND requires its receiver')
                args=(stack[-1],)+args
            elif name in ('for_iter','get_len','import_from','get_anext'):
                if not stack: raise UnsupportedBytecode(f'{name} requires stack owner')
                args = (stack[-1],)
            elif name in ('list_append','set_add','list_extend','set_update','dict_update','dict_merge','map_add'):
                if arg < 1 or arg > len(stack): raise UnsupportedBytecode(f'{name} owner depth')
                args = (stack[-arg],) + args
            elif name == 'with_except_start':
                if len(stack) < 5: raise UnsupportedBytecode('with_except_start stack')
                args = tuple(stack[-5:])
            ownership = Ownership.BORROWED if name in ('frame.borrow','frame.borrow_borrow','small_int') else Ownership.STACKREF
            results = tuple(fresh(t,ownership) for t in types)
            stack.extend(results)
            if emit:
                operations.append(Operation(name,args,results,instruction.offset,offset,instruction,attrs,handler))
            if handler:
                if handler.depth > len(before):
                    raise UnsupportedBytecode(f'exception depth exceeds stack at {instruction.offset}')
                exceptional = tuple(fresh(t) for t in ((INT64,) if handler.lasti else ()) + (PYOBJECT,))
                if emit:
                    operations.append(Operation('exception_state',(),exceptional,instruction.offset,offset,instruction,
                                                {'exceptional_only':True},handler))
                edges.append(Edge(handler.target,before[:handler.depth]+exceptional,'exception',instruction.offset))
            if instruction.opname in UNCONDITIONAL:
                edges.append(Edge(instruction.jump_target,tuple(stack),'jump',instruction.offset))
                return operations, edges
            if instruction.opname in CONDITIONAL:
                edges.append(Edge(instruction.jump_target,tuple(stack),'taken',instruction.offset))
                edges.append(Edge(self.following[instruction.offset],tuple(stack),'fallthrough',instruction.offset))
                return operations, edges
            if name in ('generator.start','yield'):
                # The next frame invocation supplies the result on this edge.
                edges.append(Edge(self.following[instruction.offset],tuple(stack),'resume',instruction.offset))
                return operations, edges
            if name=='send':
                edges.append(Edge(instruction.jump_target,tuple(stack),'send_return',instruction.offset))
                edges.append(Edge(self.following[instruction.offset],tuple(stack),'send_yield',instruction.offset))
                return operations,edges
            if name == 'for_iter':
                target = self.following[instruction.jump_target]
                edges.append(Edge(target,before,'exhausted',instruction.offset))
                edges.append(Edge(self.following[instruction.offset],tuple(stack),'next',instruction.offset))
                return operations, edges
            if instruction.opname in TERMINAL:
                return operations, edges
        last = self.raw[offset][-1]
        target = self.following[last.offset]
        if target is None:
            raise UnsupportedBytecode('bytecode falls off end without return')
        edges.append(Edge(target,tuple(stack),'normal',last.offset))
        return operations, edges


def build(function, *, block_starts=()):
    """Construct and verify IR without invoking the function or reading source."""
    if sys.implementation.name != 'cpython' or sys.version_info[:3] != (3,14,4):
        raise UnsupportedBytecode('IR bytecode ABI requires CPython 3.14.4')
    if not inspect.isfunction(function):
        raise TypeError('IR builder requires a Python function')
    return _build_code(function.__code__, function, block_starts)


def build_code(code, *, block_starts=()):
    """Construct callee IR from original code without a function or fake cells.

    The runtime still binds an actual original function and its live cells.
    This entry supplies only code-derived compilation facts.
    """
    if sys.implementation.name != 'cpython' or sys.version_info[:3] != (3,14,4):
        raise UnsupportedBytecode('IR bytecode ABI requires CPython 3.14.4')
    if type(code) is not types.CodeType:
        raise TypeError('IR builder requires an original code object')
    return _build_code(code, None, block_starts)


def _build_code(code, function, block_starts=()):
    entry, raw, following, regions = _layout(code, block_starts)
    interpreter = _Interpreter(raw,following,regions)
    incoming = {entry: ()}
    pending = deque([entry])
    while pending:
        offset = pending.popleft()
        _, edges = interpreter.run(offset,incoming[offset])
        for edge in edges:
            if edge.target not in raw:
                raise UnsupportedBytecode(f'invalid CFG target {edge.target}')
            new = tuple(edge.arguments)
            if len(new) > code.co_stacksize:
                raise UnsupportedBytecode(f'stack exceeds co_stacksize at {edge.target}')
            old = incoming.get(edge.target)
            if old is not None:
                if len(old) != len(new):
                    raise UnsupportedBytecode(f'inconsistent stack depth at {edge.target}')
                new = tuple(join_types(a,b) for a,b in zip(old,new))
            if new != old:
                incoming[edge.target] = new
                pending.append(edge.target)
    blocks = {}
    for offset in sorted(incoming):
        parameters = tuple(interpreter.value(t) for t in incoming[offset])
        operations,edges = interpreter.run(offset,parameters,emit=True)
        blocks[offset] = Block(offset,parameters,operations,edges)
    graph = FunctionIR(function,code,entry,blocks,regions)
    from .verifier import verify
    verify(graph)
    return graph
