"""Generator construction and cell-reading comprehensions on real CPython cells.

Function/code/cell creation is the canonical provider. Generator advancement
runs its original Python body. Inline comprehensions may read outer cells;
bindings requiring a new PEP709 cell scope decline before application effects.
"""
import ast
from ._call_bridge import UnsupportedCall
from ._functions import _FunctionCompiler,FunctionRegion
from ._structures import _StructureCompiler

class GeneratorCompiler(_FunctionCompiler):
    def __init__(self,fn):
        super().__init__(fn)
        for node in ast.walk(self.node):
            if isinstance(node,(ast.ListComp,ast.SetComp,ast.DictComp)):
                bound={part.id for gen in node.generators for part in ast.walk(gen.target)
                       if isinstance(part,ast.Name)}
                if bound.intersection(self.cell_slots):
                    raise UnsupportedCall('inline comprehension cell binding requires scoped cell save/restore')

    def comprehension_frame(self):
        from ._managed_frames import Frame
        return self.runtime_call(self.pooled(Frame.comprehension_copy),['_frame'])

    def clear_comprehension_name(self,frame,name):
        from ._managed_frames import Frame
        self.runtime_call(self.pooled(Frame.pop),[frame,self.constant(name),self.pooled(None)])

    def expression(self,node):
        if isinstance(node,(ast.ListComp,ast.SetComp,ast.DictComp)):
            return _StructureCompiler.expression(self,node)
        return super().expression(node)

class GeneratorRegion(FunctionRegion):
    compiler_type=GeneratorCompiler
    generator_bodies='original CPython'
