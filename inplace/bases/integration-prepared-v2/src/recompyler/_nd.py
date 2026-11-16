"""numpy arrays inside a region: their elements read and written in place.

An array in the region's heap is a block of slots: the address of its first
element, its shape, its strides counted in elements, and the handle of the block of
the array it was loaded as (itself, for an array passed in). Compiled code reaches
the elements through these loads and stores by address, so nothing is copied and
every write is seen by Python at once. The loader keeps the arrays alive for the call.
"""

from numba import types
from numba.extending import intrinsic

# dtype name -> (Numba type of an element, bytes per element)
DTYPES = {"float64": (types.float64, 8), "int64": (types.int64, 8), "bool": (types.uint8, 1)}


def _load(nbtype):
    @intrinsic
    def load(typingctx, address):
        def codegen(context, builder, signature, args):
            pointer = builder.inttoptr(args[0], context.get_value_type(nbtype).as_pointer())
            return builder.load(pointer)

        return nbtype(types.int64), codegen

    return load


def _store(nbtype):
    @intrinsic
    def store(typingctx, address, value):
        def codegen(context, builder, signature, args):
            pointer = builder.inttoptr(args[0], context.get_value_type(nbtype).as_pointer())
            item = context.cast(builder, args[1], signature.args[1], nbtype)
            builder.store(item, pointer)
            return context.get_dummy_value()

        return types.void(types.int64, value), codegen

    return store


nd_ld_f8, nd_st_f8 = _load(types.float64), _store(types.float64)
nd_ld_i8, nd_st_i8 = _load(types.int64), _store(types.int64)
nd_ld_b1, nd_st_b1 = _load(types.uint8), _store(types.uint8)

IMPORT = "from recompyler._nd import nd_ld_f8, nd_st_f8, nd_ld_i8, nd_st_i8, nd_ld_b1, nd_st_b1\n"
