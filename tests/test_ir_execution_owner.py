"""Installed function watchers retain executable memory without retaining source."""
import gc,types,weakref
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower


def identity(value):return value


def test_execution_owner_retains_code_engine_without_graph_or_function():
 class Marker:pass
 marker=Marker();reference=weakref.ref(marker)
 function=types.FunctionType(identity.__code__,{'sentinel':marker})
 function_reference=weakref.ref(function)
 lowered=lower(build(function),frame_entry=True)
 owner=lowered.execution_owner
 assert owner.body_address==lowered.body_address
 assert owner.abi=='frame' and owner.entry_offset==lowered.entry_offset
 assert not hasattr(owner,'graph')
 del function,lowered,marker;gc.collect()
 assert function_reference() is None and reference() is None
 assert owner.engine.get_function_address('body')==owner.body_address
 assert owner.keepalive==(owner,)


def test_execution_owner_detaches_structure_adapter_profile_backreferences():
 from recompyler import heap,_structure_ops_native as provider
 from recompyler.ir.structure_lowerings import StructureCalls
 from recompyler.ir.symbols import CPythonSymbols
 function=types.FunctionType(heap._find.__code__,heap._find.__globals__)
 reference=weakref.ref(function)
 calls=StructureCalls(CPythonSymbols(),provider)
 calls.profile_source_owner=function
 lowered=lower(build(function),frame_entry=True,structure_calls=calls,owned_readonly_loops=True)
 owner=lowered.execution_owner
 assert calls not in owner.providers
 assert calls.provider in owner.providers
 del calls,lowered,function;gc.collect()
 assert reference() is None
 assert owner.engine.get_function_address('body')==owner.body_address


def test_execution_owner_owns_immutable_provider_snapshot():
 lowered=lower(build(identity),frame_entry=True)
 owner=lowered.execution_owner
 retained=owner.providers
 lowered.providers=()
 assert owner.providers is retained and retained
 with pytest.raises((AttributeError,TypeError)):owner.providers=()
