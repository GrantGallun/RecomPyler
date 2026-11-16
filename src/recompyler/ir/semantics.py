"""Pinned bytecode stack contracts, not inferred from net stack deltas.

RETURN_VALUE transfers to another frame, and FOR_ITER skips END_FOR on
exhaustion; dis.stack_effect alone cannot describe these semantics.
"""
from .types import PYOBJECT, NULL, OBJECT_OR_NULL, INT64, ValueType, exact_type, Ownership

class UnsupportedBytecode(ValueError):
    pass

# Inputs consumed, outputs produced, shared semantic operation family.
SIMPLE = {
    'RESUME': (0,0,'resume'), 'NOP': (0,0,'nop'),
    'NOT_TAKEN': (0,0,'nop'), 'EXTENDED_ARG': (0,0,'nop'),
    'POP_TOP': (1,0,'pop'), 'POP_ITER': (1,0,'pop_iter'),
    'END_FOR': (1,0,'end_for'),
    'END_SEND': (2,1,'end_send'),
    'CLEANUP_THROW': (3,2,'cleanup_throw'),
    'STORE_FAST': (1,0,'frame.store'), 'DELETE_FAST': (0,0,'frame.delete'),
    'STORE_FAST_LOAD_FAST': (1,1,'frame.store_load'),
    'STORE_FAST_STORE_FAST': (2,0,'frame.store_store'),
    'LOAD_FAST': (0,1,'frame.load'), 'LOAD_FAST_CHECK': (0,1,'frame.load_check'),
    'LOAD_FAST_BORROW': (0,1,'frame.borrow'),
    'LOAD_FAST_AND_CLEAR': (0,1,'frame.take'),
    'LOAD_FAST_LOAD_FAST': (0,2,'frame.load_load'),
    'LOAD_FAST_BORROW_LOAD_FAST_BORROW': (0,2,'frame.borrow_borrow'),
    'STORE_NAME': (1,0,'name.store'), 'DELETE_NAME': (0,0,'name.delete'),
    'LOAD_NAME': (0,1,'name.load'), 'STORE_GLOBAL': (1,0,'global.store'),
    'DELETE_GLOBAL': (0,0,'global.delete'),
    'LOAD_DEREF': (0,1,'cell.get'), 'STORE_DEREF': (1,0,'cell.set'),
    'DELETE_DEREF': (0,0,'cell.delete'), 'MAKE_CELL': (0,0,'cell.new'),
    'COPY_FREE_VARS': (0,0,'cell.copy_free'),
    'BINARY_OP': (2,1,'binary'), 'BINARY_SUBSCR': (2,1,'subscr'),
    'STORE_SUBSCR': (3,0,'store_subscr'), 'DELETE_SUBSCR': (2,0,'delete_subscr'),
    'STORE_ATTR': (2,0,'store_attr'), 'DELETE_ATTR': (1,0,'delete_attr'),
    'UNARY_NEGATIVE': (1,1,'unary'), 'UNARY_INVERT': (1,1,'unary'),
    'UNARY_NOT': (1,1,'unary'), 'TO_BOOL': (1,1,'to_bool'),
    'COMPARE_OP': (2,1,'compare'), 'CONTAINS_OP': (2,1,'contains'),
    'IS_OP': (2,1,'is'), 'GET_ITER': (1,1,'get_iter'),
    'GET_YIELD_FROM_ITER': (1,1,'get_yield_from_iter'),
    'GET_AITER': (1,1,'get_aiter'), 'GET_ANEXT': (0,1,'get_anext'),
    'GET_AWAITABLE': (1,1,'get_awaitable'), 'END_ASYNC_FOR': (2,0,'end_async_for'),
    'RETURN_VALUE': (1,0,'return'), 'RAISE_VARARGS': (None,0,'raise'),
    'RERAISE': (1,0,'reraise'), 'POP_EXCEPT': (1,0,'pop_except'),
    'PUSH_EXC_INFO': (1,2,'push_exc_info'),
    'CHECK_EXC_MATCH': (2,2,'check_exc_match'),
    'MATCH_CLASS': (3,1,'match_class'),
    'WITH_EXCEPT_START': (0,1,'with_except_start'),
    'BEFORE_WITH': (1,2,'with_enter'),
    'MAKE_FUNCTION': (1,1,'make_function'),
    'SET_FUNCTION_ATTRIBUTE': (2,1,'set_function_attribute'),
    'BUILD_TEMPLATE': (2,1,'build_template'),
    'FORMAT_SIMPLE': (1,1,'format_simple'), 'FORMAT_WITH_SPEC': (2,1,'format_spec'),
    'CONVERT_VALUE': (1,1,'convert'),
    'IMPORT_NAME': (2,1,'import_name'), 'IMPORT_FROM': (0,1,'import_from'),
    'LOAD_BUILD_CLASS': (0,1,'load_build_class'),
    'LOAD_LOCALS': (0,1,'load_locals'),
    'LOAD_FROM_DICT_OR_DEREF': (1,1,'load_dict_or_deref'),
    'LOAD_FROM_DICT_OR_GLOBALS': (1,1,'load_dict_or_globals'),
    'BINARY_SLICE': (3,1,'binary_slice'), 'STORE_SLICE': (4,0,'store_slice'),
}

UNCONDITIONAL = {'JUMP_FORWARD','JUMP_BACKWARD','JUMP_BACKWARD_NO_INTERRUPT'}
CONDITIONAL = {'POP_JUMP_IF_TRUE','POP_JUMP_IF_FALSE','POP_JUMP_IF_NONE','POP_JUMP_IF_NOT_NONE'}
TERMINAL = {'RETURN_VALUE','RAISE_VARARGS','RERAISE'}


def contract(instruction):
    """Return consumed count, result types and semantic name for one opcode."""
    name, arg = instruction.opname, instruction.arg or 0
    attrs = {'oparg': instruction.arg, 'argval': instruction.argval}
    # These results arrive from CPython when this generator frame resumes;
    # they are not values produced during the preceding body invocation.
    if name == 'RETURN_GENERATOR':
        return 0, (exact_type(type(None)),), 'generator.start', {**attrs,'resume_only':True}
    if name == 'YIELD_VALUE':
        return 1, (PYOBJECT,), 'yield', {**attrs,'resume_only':True}
    if name == 'CALL_INTRINSIC_1' and arg == 3:
        return 1, (PYOBJECT,), 'generator.stop_error', attrs
    if name == 'CALL_INTRINSIC_1' and 0 < arg <= 11:
        return 1, (PYOBJECT,), 'intrinsic_unary', attrs
    if name == 'CALL_INTRINSIC_2' and 0 < arg <= 5:
        return 2, (PYOBJECT,), 'intrinsic_binary', attrs
    if name == 'LOAD_SPECIAL' and 0 <= arg < 4:
        return 1, (PYOBJECT, OBJECT_OR_NULL), 'load_special', attrs
    if name == 'PUSH_NULL': return 0, (NULL,), 'null', attrs
    if name == 'LOAD_CONST': return 0, (exact_type(type(instruction.argval)),), 'constant', attrs
    if name == 'LOAD_COMMON_CONSTANT':
        if not 0 <= arg < 5:raise UnsupportedBytecode('invalid common constant index')
        return 0, (PYOBJECT,), 'common_constant', attrs
    if name == 'LOAD_SMALL_INT': return 0, (exact_type(int),), 'small_int', attrs
    if name == 'LOAD_GLOBAL':
        return 0, (PYOBJECT, NULL) if arg & 1 else (PYOBJECT,), 'global.load', attrs
    if name == 'LOAD_ATTR':
        attrs['method'] = bool(arg & 1)
        return 1, (PYOBJECT, OBJECT_OR_NULL) if arg & 1 else (PYOBJECT,), 'load_attr', attrs
    if name == 'LOAD_SUPER_ATTR':
        attrs['method'] = bool(arg & 1)
        return 3, (PYOBJECT, OBJECT_OR_NULL) if arg & 1 else (PYOBJECT,), 'load_super_attr', attrs
    if name in ('CALL','CALL_KW'):
        attrs['positional'] = arg if name == 'CALL' else None
        attrs['argument_count'] = arg
        return arg + (2 if name == 'CALL' else 3), (PYOBJECT,), 'call' if name == 'CALL' else 'call_kw', attrs
    if name == 'CALL_FUNCTION_EX':
        return 4, (PYOBJECT,), 'call_ex', attrs
    if name in ('BUILD_TUPLE','BUILD_LIST','BUILD_SET','BUILD_STRING','BUILD_SLICE'):
        return arg, (PYOBJECT,), name.lower(), attrs
    if name == 'BUILD_MAP': return arg * 2, (PYOBJECT,), 'build_map', attrs
    if name == 'BUILD_CONST_KEY_MAP': return arg + 1, (PYOBJECT,), 'build_const_key_map', attrs
    if name == 'UNPACK_SEQUENCE': return 1, (PYOBJECT,) * arg, 'unpack', attrs
    if name == 'UNPACK_EX': return 1, (PYOBJECT,) * ((arg & 255) + (arg >> 8) + 1), 'unpack_ex', attrs
    if name in ('LIST_APPEND','SET_ADD','LIST_EXTEND','SET_UPDATE','DICT_UPDATE','DICT_MERGE'):
        return 1, (), name.lower(), attrs
    if name == 'MAP_ADD': return 2, (), 'map_add', attrs
    if name in UNCONDITIONAL: return 0, (), 'jump', attrs
    if name in CONDITIONAL: return 1, (), 'branch', attrs
    if name == 'FOR_ITER': return 0, (PYOBJECT,), 'for_iter', attrs
    if name == 'SEND': return 1, (PYOBJECT,), 'send', attrs
    if name == 'CLEANUP_THROW': return 3, (exact_type(type(None)),PYOBJECT), 'cleanup_throw', attrs
    if name == 'COPY': return 0, (PYOBJECT,), 'copy', attrs
    if name == 'SWAP': return 0, (), 'swap', attrs
    if name == 'GET_LEN': return 0, (PYOBJECT,), 'get_len', attrs
    if name in SIMPLE:
        consumed, produced, semantic = SIMPLE[name]
        if consumed is None: consumed = arg
        if name.startswith(('STORE_FAST_','LOAD_FAST_')) and produced == 2 or name in ('STORE_FAST_LOAD_FAST','STORE_FAST_STORE_FAST'):
            attrs['slots'] = (arg >> 4, arg & 15)
        if name == 'LOAD_FAST_AND_CLEAR':
            types = (ValueType('object-or-null',maybe_unbound=True),)
        elif name == 'TO_BOOL' or name in ('IS_OP','CONTAINS_OP') or name=='COMPARE_OP' and arg&16:
            types = (exact_type(bool),)
        else: types = (PYOBJECT,) * produced
        return consumed, types, semantic, attrs
    raise UnsupportedBytecode(f'unsupported CPython 3.14.4 opcode {name} at {instruction.offset}')
