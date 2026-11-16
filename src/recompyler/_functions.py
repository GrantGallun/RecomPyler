"""Original-code function creation with real, shared CPython closure cells."""
import ast

from . import provenance
from ._call_bridge import CallRegion, UnsupportedCall
from ._structures import _StructureCompiler
from ._managed_frames import Frame as _Frame
from ._managed_cells import CellAccess
from ._function_factory import FunctionFactory
from ._text_owners import observers_clear


def _closure_at(frame,names):return tuple(frame.cells[name] for name in names)


def _read_free(frame,name):
    if name not in frame:
        raise NameError(f"cannot access free variable '{name}' where it is not associated with a value in enclosing scope",name=name)
    return frame[name]


class _FunctionCompiler(FunctionFactory,CellAccess,_StructureCompiler):
    allow_closure_cells=True

    def __init__(self,fn):
        super().__init__(fn)
        self.names+=list(fn.__code__.co_cellvars)+list(fn.__code__.co_freevars)
        self.constants+=list(fn.__code__.co_cellvars)+list(fn.__code__.co_freevars)
        self.free_names=set(fn.__code__.co_freevars)
        self.configure_cells(fn.__code__.co_cellvars+fn.__code__.co_freevars,fn.__code__.co_freevars)


    def lower(self,lines):
        return super().lower(self.cell_prefix(lines))

    def name(self,name):
        if name in self.cell_slots:return self.read_cell(name)
        return super().name(name)

    def assign(self,target,value):
        if isinstance(target,ast.Name) and target.id in self.cell_slots:return self.write_cell(target.id,value)
        return super().assign(target,value)


    def expression(self,node):
        if isinstance(node,ast.GeneratorExp):
            return self.generator_value(node)
        if isinstance(node,(ast.ListComp,ast.SetComp,ast.DictComp)):
            raise UnsupportedCall('inline comprehension cell scope requires shared frame support')
        return super().expression(node)

    def statements(self,body):
        for node in body:
            if isinstance(node,ast.FunctionDef):
                decorators=[self.expression(value) for value in node.decorator_list]
                function=self.function_value(node)
                for decorator in reversed(decorators):function=self.runtime_call(decorator,[function],counted=True)
                self.assign(ast.Name(id=node.name,ctx=ast.Store()),function)
            else:super().statements([node])



class FunctionRegion(CallRegion):
    compiler_type=_FunctionCompiler

    def admit_entry(self,passed):
        fn=self.original
        if not observers_clear((fn,)) or not provenance._inert_namespaces(fn):return False
        return True

    def make_frame(self,passed):
        return _Frame(self.original,zip(self.entry.names,passed))


def lift_functions(fn):return FunctionRegion(fn)
