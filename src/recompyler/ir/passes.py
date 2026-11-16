"""Verifying pass pipeline. Passes never silently bypass graph invariants."""
from .verifier import verify
from .ops import FunctionIR

class PassManager:
    def __init__(self, passes=()):
        self.passes = tuple(passes)
    def run(self, graph):
        verify(graph)
        for transform in self.passes:
            graph = transform(graph)
            if not isinstance(graph, FunctionIR):
                raise TypeError('IR pass must return FunctionIR')
            verify(graph)
        return graph
