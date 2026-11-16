"""Opt-in ndarray StructureCalls adapter; canonical operations own effects."""
import ctypes
from llvmlite import ir
from recompyler.ir.structure_lowerings import StructureCalls,PTR,STATUS


class NumpyCalls(StructureCalls):
    def __init__(self,symbols,provider,*,count_hits=False):
        super().__init__(symbols,provider)
        from . import _numpy_native
        self.numpy_provider=_numpy_native
        self.numpy_library=ctypes.PyDLL(_numpy_native.__file__)
        self.hits=ctypes.c_uint64() if count_hits else None
        for name,address in _numpy_native.addresses().items():
            symbols.register_external('rc_numpy_try_'+name,address,(_numpy_native,self.numpy_library))

    @property
    def keepalive(self):
        return super().keepalive+(self.numpy_provider,self.numpy_library,self.hits)

    def _try(self,builder,name,result,arguments,fallback):
        with builder.goto_entry_block():
            matched=builder.alloca(STATUS,name='ndarray_matched')
        function=self.symbols.declare(builder.module,'rc_numpy_try_'+name,result,
                                      [value.type for value in arguments]+[STATUS.as_pointer()])
        value=builder.call(function,[*arguments,matched])
        yes=builder.function.append_basic_block('ndarray_hit')
        no=builder.function.append_basic_block('ndarray_fallback')
        done=builder.function.append_basic_block('ndarray_done')
        builder.cbranch(builder.icmp_signed('!=',builder.load(matched),ir.Constant(STATUS,0)),yes,no)
        builder.position_at_end(yes)
        if self.hits is not None:
            word=ir.IntType(64)
            counter=builder.inttoptr(ir.Constant(word,ctypes.addressof(self.hits)),word.as_pointer())
            builder.store(builder.add(builder.load(counter),ir.Constant(word,1)),counter)
        yes_end=builder.block;builder.branch(done)
        builder.position_at_end(no)
        other=fallback()
        no_end=builder.block;builder.branch(done)
        builder.position_at_end(done)
        joined=builder.phi(result)
        joined.add_incoming(value,yes_end);joined.add_incoming(other,no_end)
        return joined

    def getitem(self,builder,owner,key):
        return self._try(builder,'load',PTR,[owner,key],lambda:super(NumpyCalls,self).getitem(builder,owner,key))

    def setitem(self,builder,owner,key,value):
        return self._try(builder,'store',STATUS,[owner,key,value],lambda:super(NumpyCalls,self).setitem(builder,owner,key,value))

    def length(self,builder,owner):
        word=ir.IntType(64)
        return self._try(builder,'length',word,[owner],lambda:self.capi(builder,'PyObject_Length',word,[owner]))
