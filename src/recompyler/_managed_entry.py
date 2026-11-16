"""Borrow roots pinned by the synchronous Python native-entry wrapper.

Only generated managed roots use this boundary. Their operations store escaped
values through CPython protocols, which retain the objects themselves; these
handles never escape inside native containers. The ordinary managed unboxer
continues to own inputs for unrestricted Numba use.
"""
from numba import njit
from numba.core import types
from numba.core.datamodel import models
from numba.core.pythonapi import NativeValue, unbox
from numba.extending import intrinsic, register_model
from recompyler import _managed_native as refs

class RootArgument(types.Type):
    def __init__(self):super().__init__('recompyler.BorrowedRootArgument')
root_argument=RootArgument()
register_model(RootArgument)(models.OpaqueModel)
@unbox(RootArgument)
def unbox_root(typ,obj,c):
    return NativeValue(obj)

@intrinsic
def as_managed(tc,value):
    if value!=root_argument:return
    def codegen(context,builder,sig,args):
        return refs.borrow_root(context,builder,args[0])
    return refs.managed(value),codegen

def prepare(dispatcher):
    """Keep root arguments pinned through native execution and result boxing."""
    @njit
    def adapter(pool,frame,namespace,builtins,errors,counts):
        return dispatcher(as_managed(pool),as_managed(frame),as_managed(namespace),
                          as_managed(builtins),as_managed(errors),counts)
    signature=(root_argument,)*5+(types.Array(types.int64,1,'C'),)
    # Specialize the root with NULL input MemInfos in this one entry wrapper;
    # its reference bookkeeping can then disappear during native optimization.
    previous = dispatcher.targetoptions.get('inline')
    dispatcher.targetoptions['inline'] = 'always'
    try:
        adapter.compile(signature)
    finally:
        if previous is None:
            dispatcher.targetoptions.pop('inline', None)
        else:
            dispatcher.targetoptions['inline'] = previous
    return adapter.overloads[signature].entry_point,adapter
