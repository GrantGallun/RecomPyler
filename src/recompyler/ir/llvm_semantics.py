"""Conservative facts for the pinned, GIL-held CPython object ABI.

Unknown calls keep full effects. A successful guard is a fact only after its
failure edge. Mutable version tags are deliberately NOT invariant loads.
TBAA labels describe physical fields, never the Python variable's inferred type.
"""
from llvmlite import binding, ir


# Only exports inspected in CPython 3.14.4 Objects/{type,object}.c.
# No generic protocol, allocation, decref, error or watcher helper is pure.
API_ATTRIBUTES={
    # Subtype walks indirect MRO/base objects, not just its direct arguments.
    'PyType_IsSubtype': ('readonly','nounwind'),
    'Py_NewRef': ('nounwind',),
    'Py_IncRef': ('nounwind',),
    'Py_Is': ('readnone','nounwind'),
    'Py_IsNone': ('readnone','nounwind'),
    'Py_IsTrue': ('readnone','nounwind'),
    'Py_IsFalse': ('readnone','nounwind'),
}
IMMUTABLE_FIELDS=frozenset({'type.basicsize'})


def annotate_api(function):
    for attribute in API_ATTRIBUTES.get(function.name,()):
        function.attributes.add(attribute)
    return function


def annotate_access(instruction,semantic,*,nonnull=False,value_range=None,immutable=False):
    """Attach only facts justified by this particular physical access site.

    The scalar tags are siblings under one conservative root; untagged accesses
    and unknown calls may alias everything. Do not label generic object payloads
    with mutually exclusive tags unless their representation was guarded.
    """
    if immutable and semantic not in IMMUTABLE_FIELDS:
        raise ValueError('mutable field cannot be invariant: '+semantic)
    module=instruction.parent.function.module
    root=module.add_metadata(['RecomPyler CPython 3.14.4 fields'])
    any_field=module.add_metadata(['any field',root,ir.Constant(ir.IntType(64),0)])
    field=module.add_metadata([semantic,any_field,ir.Constant(ir.IntType(64),0)])
    instruction.set_metadata('tbaa',module.add_metadata([field,field,ir.Constant(ir.IntType(64),0)]))
    if nonnull:instruction.set_metadata('nonnull',module.add_metadata([]))
    if immutable:instruction.set_metadata('invariant.load',module.add_metadata([]))
    if value_range is not None:
        kind=instruction.type
        if not isinstance(kind,ir.IntType):raise TypeError('range requires an integer load')
        instruction.set_metadata('range',module.add_metadata([ir.Constant(kind,item) for item in value_range]))
    return instruction


def assume(builder,condition):
    """A caller must place this after the guard's failing edge has exited."""
    function=builder.module.declare_intrinsic('llvm.assume')
    return builder.call(function,[condition])


def optimize_module(module,target):
    """One full new-PM O3 pipeline, shared by JIT and AOT; strict FP stays on."""
    module.verify()
    # llvmlite 0.50's IR attribute spelling table lacks willreturn, although
    # its bundled LLVM supports it through the public binding API.
    for function in module.functions:
        if function.is_declaration and function.name in API_ATTRIBUTES:
            function.add_function_attribute('willreturn')
    with binding.create_pipeline_tuning_options(speed_level=3) as tuning:
        with binding.create_pass_builder(target,tuning) as passes:
            with passes.getModulePassManager() as manager:
                manager.run(module,passes)
    module.verify()
    return module
