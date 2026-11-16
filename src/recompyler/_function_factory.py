"""Shared original-CodeType function and generator construction hooks.

Consumers supply the existing compiler binding/operation/pooled/expression APIs
and real CellAccess.cell_slots. This mixin adds no value/owner representation.
Generator construction creates the original Python generator body; advancing
that body remains managed. Creation precedes eager outer-iterator evaluation.
Unsupported annotations/type parameters decline during preparation.
"""
import ast
import types
from . import provenance
from ._call_bridge import UnsupportedCall


class FunctionFactory:
    def original_code(self,node):
        code=self.binding.nested_codes.get(provenance.site(node))
        if type(code) is not types.CodeType:raise UnsupportedCall('original nested code site is not uniquely bound')
        return code
    def function_value(self,node):
        if not isinstance(node,(ast.FunctionDef,ast.GeneratorExp)):
            raise UnsupportedCall('unsupported function-creation scope')
        site=provenance.site(node)
        code=self.original_code(node)
        from ._managed_calls import function_object
        self.intrinsics['_function_object']=function_object
        defaults=self.pooled(None);keywords=self.pooled(None)
        if isinstance(node,ast.FunctionDef):
            args=node.args
            if node.returns is not None or getattr(node,'type_params',()) or any(arg.annotation is not None for arg in args.posonlyargs+args.args+args.kwonlyargs+([args.vararg] if args.vararg else [])+([args.kwarg] if args.kwarg else [])):
                raise UnsupportedCall('lazy annotations/type parameters require function annotation creation')
            constant_defaults=self.binding.definition_defaults.get(site)
            if constant_defaults is not None:defaults=self.pooled(constant_defaults)
            elif args.defaults:defaults=self.operation('_tuple_object',*[self.expression(value) for value in args.defaults])
            items=[]
            for index,value in enumerate(args.kw_defaults):
                if value is None:continue
                name=code.co_varnames[code.co_argcount+index]
                candidates=[key for key in self.binding.definition_keywords.get(site,()) if key==name]
                if not candidates or any(key is not candidates[0] for key in candidates):
                    raise UnsupportedCall('original keyword-default key owner is not uniquely bound')
                items += [self.pooled(candidates[0]),self.expression(value)]
            if items:keywords=self.operation('_dict_object',*items)
        # CPython evaluates positional/keyword defaults before BUILD_TUPLE
        # for closure cells. Default callbacks may observe those owners.
        if code.co_freevars:
            closure=self.operation('_tuple_object',*[self.cell_slots[name] for name in code.co_freevars])
        else:closure=self.pooled(None)
        return self.operation('_function_object',self.pooled(code),'_namespace',closure,defaults,keywords)

    def generator_value(self, node):
        if not isinstance(node, ast.GeneratorExp):
            raise UnsupportedCall('generator factory requires an original generator expression')
        if any(gen.is_async for gen in node.generators):
            raise UnsupportedCall('async generator construction')
        function = self.function_value(node)
        iterator = self.operation('_getiter_object', self.expression(node.generators[0].iter))
        return self.runtime_call(function, [iterator], counted=True)
