"""Preload globals before IR transformation, inspired by CinderX Jit/hir/preload.* @ f3dc0e8.
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
import dis
from types import FunctionType
import weakref
from .symbols import require_runtime
from .watchers import watch_dependencies


class PreloadUnsupported(ValueError):pass
class PreloadInvalidated(ValueError):pass


@dataclass(frozen=True)
class GlobalBinding:
    offset: int
    name: str
    origin: str | None
    identity: int


class PreloadedFunction:
    """Compilation-scoped state; close before publishing an execution owner.

    Bindings hold pointer identities, never application objects. resolve() hands
    a temporary strong reference to its caller, who owns its compilation scope.
    The function is weak, and close releases code/namespaces/subscription.
    """
    def __init__(self,function,code,subscription,bindings):
        self.code=code
        self._globals=function.__globals__
        self._builtins=function.__builtins__
        self.subscription=subscription
        self.bindings=tuple(bindings)
        self._closed=False
        prepared_ref=weakref.ref(self)
        def function_gone(_):
            prepared=prepared_ref()
            if prepared is not None:prepared.close()
        self._function=weakref.ref(function,function_gone)

    @property
    def valid(self):
        function=self._function()
        return (not self._closed and self.subscription is not None and self.subscription.valid and function is not None
                and function.__code__ is self.code)

    def resolve(self,binding):
        if not self.valid:raise PreloadInvalidated('preload dependencies changed')
        if binding not in self.bindings:raise ValueError('binding does not belong to preload')
        origin,value=_lookup(self._globals,self._builtins,binding.name)
        identity=0 if origin is None else id(value)
        if not self.valid or (origin,identity)!=(binding.origin,binding.identity):
            del value
            raise PreloadInvalidated('preloaded value changed')
        if origin is None:raise PreloadUnsupported('unresolved global: '+binding.name)
        return value

    def detach_dependencies(self):
        """Transfer the live subscription to the caller's execution keepalive."""
        if not self.valid:raise PreloadInvalidated('preload dependencies changed')
        subscription=self.subscription
        self.subscription=None
        self.close()
        return subscription

    def close(self):
        if self._closed:return
        self._closed=True
        if self.subscription is not None:self.subscription.close()
        self.code=None;self._globals=None;self._builtins=None;self.bindings=()

    def __enter__(self):
        if not self.valid:raise PreloadInvalidated('preload dependencies changed')
        return self

    def __exit__(self,*error):self.close()


def _lookup(globals_dict,builtins_dict,name):
    from . import _preload_native
    try:origin,value=_preload_native.lookup(globals_dict,builtins_dict,name)
    except (TypeError,ValueError) as error:
        raise PreloadUnsupported(str(error)) from None
    return {0:'globals',1:'builtins',-1:None}[origin],value


def preload_function(function):
    require_runtime()
    if type(function) is not FunctionType:raise PreloadUnsupported('exact Python function required')
    globals_dict=function.__globals__;builtins_dict=function.__builtins__;code=function.__code__
    if type(globals_dict) is not dict or type(builtins_dict) is not dict:
        raise PreloadUnsupported('exact namespace dictionaries required')
    subscription=watch_dependencies(dicts=(globals_dict,builtins_dict))
    bindings=[]
    try:
        for instruction in dis.get_instructions(code):
            if instruction.opname!='LOAD_GLOBAL':continue
            origin,value=_lookup(globals_dict,builtins_dict,instruction.argval)
            identity=0 if origin is None else id(value)
            bindings.append(GlobalBinding(instruction.offset,instruction.argval,origin,identity))
            del value
        if not subscription.valid or function.__code__ is not code:
            raise PreloadInvalidated('dependencies changed while preloading')
        prepared=PreloadedFunction(function,code,subscription,bindings)
        if not prepared.valid:
            prepared.close()
            raise PreloadInvalidated('dependencies changed while constructing preload')
        return prepared
    except BaseException:
        subscription.close()
        raise
