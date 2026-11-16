"""Optional operand mapping and deterministic inline candidate planning.

Adapted from CinderX Jit/hir/inliner.cpp @ f3dc0e8.
MIT License

Copyright (c) Meta Platforms, Inc. and affiliates.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"""
from dataclasses import dataclass
from types import CodeType
import dis
import inspect


class InlineRefused(ValueError):pass


def _natural(value,name):
    if type(value) is not int or value<0:raise InlineRefused(name+' must be a nonnegative exact int')
    return value


@dataclass(frozen=True)
class DefaultArgument:
    """Index into a separately guarded original defaults tuple, never its value."""
    index:int
    def __post_init__(self):_natural(self.index,'default index')


@dataclass(frozen=True)
class CallMapping:
    code:CodeType
    positional_count:int
    keyword_names:tuple[str,...]
    parameters:tuple[int|DefaultArgument,...]
    varargs:tuple[int,...]|None
    varkw:tuple[tuple[str,int],...]|None


def map_call_args(code,positional_count,keyword_names=(),*,positional_defaults=0):
    """Map vectorcall operands; decline instead of replacing CPython diagnostics.

    Operands contain positional values followed by keyword values. Missing
    positional defaults are described by tuple index. Keyword calls require
    every named parameter; keyword defaults and positional-only names in
    **kwargs deliberately stay on canonical binding. No application values run
    or remain owned here. Consumers must guard function/code/default identity
    and retain original argument retirement and pre-call frame state.
    """
    if type(code) is not CodeType:raise InlineRefused('exact code required')
    _natural(positional_count,'positional count');_natural(positional_defaults,'defaults count')
    if type(keyword_names) is not tuple or any(type(n) is not str for n in keyword_names):
        raise InlineRefused('constant exact-string keyword tuple required')
    if len(set(keyword_names))!=len(keyword_names):raise InlineRefused('duplicate keyword')
    count=code.co_argcount;kwonly=code.co_kwonlyargcount
    names=code.co_varnames[:count+kwonly]
    if len(names)!=count+kwonly or any(type(n) is not str for n in names):
        raise InlineRefused('invalid parameter names')
    varargs=bool(code.co_flags&inspect.CO_VARARGS);varkw=bool(code.co_flags&inspect.CO_VARKEYWORDS)
    if positional_count>count and not varargs:raise InlineRefused('too many positional operands')
    parameters=[None]*(count+kwonly)
    for i in range(min(count,positional_count)):parameters[i]=i
    excess=[]
    for j,name in enumerate(keyword_names):
        if name in names[:code.co_posonlyargcount]:raise InlineRefused('positional-only keyword')
        try:index=names.index(name,code.co_posonlyargcount)
        except ValueError:
            if not varkw:raise InlineRefused('unknown keyword') from None
            excess.append((name,positional_count+j));continue
        if parameters[index] is not None:raise InlineRefused('duplicate parameter')
        parameters[index]=positional_count+j
    if keyword_names and any(p is None for p in parameters):
        raise InlineRefused('keyword calls must provide every parameter')
    first_default=count-positional_defaults
    for i in range(count):
        if parameters[i] is None:
            if i<first_default:raise InlineRefused('missing positional operand')
            parameters[i]=DefaultArgument(i-first_default)
    if any(p is None for p in parameters):raise InlineRefused('missing keyword-only operand')
    return CallMapping(code,positional_count,keyword_names,tuple(parameters),
                       tuple(range(count,positional_count)) if varargs else None,
                       tuple(excess) if varkw else None)


def code_cost(code):
    if type(code) is not CodeType:raise InlineRefused('exact code required')
    return sum(1 for _ in dis.get_instructions(code))


@dataclass(frozen=True)
class InlineCandidate:
    code:CodeType
    site:int
    stack:tuple[CodeType,...]
    call_count:int=0
    def __post_init__(self):
        if type(self.code) is not CodeType or type(self.stack) is not tuple or not self.stack or any(type(c) is not CodeType for c in self.stack):
            raise InlineRefused('code and nonempty original-code stack required')
        _natural(self.site,'call site');_natural(self.call_count,'call count')


@dataclass(frozen=True)
class InlineSelection:
    accepted:tuple[InlineCandidate,...]
    refused:tuple[tuple[InlineCandidate,str],...]
    cost:int


def plan_inlining(caller,candidates,*,cost_limit,depth_limit=3,caller_count=0,cold_threshold=100):
    """Plan smaller callees first; this neither splices graphs nor admits code.

    Costs are selection reservations. An emitter must replan after a failed
    splice, so a failed transformation never consumes its eventual budget.
    Original code identity, not structural code equality, detects recursion.
    """
    _natural(cost_limit,'cost limit');_natural(depth_limit,'depth limit');_natural(caller_count,'caller count')
    _natural(cold_threshold,'cold threshold')
    if cold_threshold==0:raise InlineRefused('cold threshold must be positive')
    cost=code_cost(caller);accepted=[];refused=[]
    candidates=tuple(candidates)
    if any(type(c) is not InlineCandidate or c.stack[0] is not caller for c in candidates):
        raise InlineRefused('candidate stack must start at original caller')
    suspended=inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR
    for _,c in sorted(enumerate(candidates),key=lambda pair:(code_cost(pair[1].code),pair[0])):
        reason=None
        if caller.co_flags&suspended or c.code.co_flags&suspended:reason='suspending'
        elif any(c.code is code for code in c.stack):reason='recursive'
        elif len(c.stack)>depth_limit:reason='depth'
        elif caller_count and (not c.call_count or caller_count//c.call_count>=cold_threshold):reason='cold'
        elif cost+code_cost(c.code)>cost_limit:reason='cost'
        if reason is not None:refused.append((c,reason));continue
        accepted.append(c);cost+=code_cost(c.code)
    return InlineSelection(tuple(accepted),tuple(refused),cost)
