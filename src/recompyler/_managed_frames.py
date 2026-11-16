"""Dependency-light source-slot/cell ownership shared by managed frontends.

Keep the Frame itself in the Python carrier through return, exception and any
captured traceback. native_data supplies an exact dict for noncell execution;
context snapshots use the owner mapping's original source-name order. This
owner is not a materialized CPython activation and does not claim f_back identity.
"""
import types
from collections.abc import MutableMapping


class Frame(MutableMapping):
    def __init__(self, fn, values):
        code=fn.__code__
        self.data=dict(values)
        self.cells={}
        for name in code.co_cellvars:
            self.cells[name]=types.CellType(self.data.pop(name)) if name in self.data else types.CellType()
        self.cells.update(zip(code.co_freevars,fn.__closure__ or ()))
        self.order=tuple(dict.fromkeys(code.co_varnames+code.co_cellvars+code.co_freevars))

    def __del__(self):
        # Drop frame references in CPython localsplus order. Escaping closure
        # cells keep their contents; only this frame's reference is removed.
        for name in reversed(getattr(self,'order',())):
            self.cells.pop(name,None)
            self.data.pop(name,None)

    def comprehension_copy(self):
        """Copy scoped locals while sharing the original live closure cells."""
        scoped=Frame.__new__(Frame)
        scoped.data=self.data.copy()
        scoped.cells=self.cells.copy()
        scoped.order=self.order
        return scoped

    @property
    def native_data(self):
        """Execution view only; the Python carrier must retain this owner."""
        return self if self.cells else self.data

    def __getitem__(self,name):
        if name in self.cells:
            try:return self.cells[name].cell_contents
            except ValueError:raise KeyError(name) from None
        return self.data[name]

    def __setitem__(self,name,value):
        if name in self.cells:self.cells[name].cell_contents=value
        else:self.data[name]=value

    def __delitem__(self,name):
        if name in self.cells:
            try:del self.cells[name].cell_contents
            except ValueError:raise KeyError(name) from None
        else:del self.data[name]

    def __iter__(self):
        for name in dict.fromkeys(self.order+tuple(self.data)):
            try:self[name]
            except KeyError:continue
            yield name

    def __len__(self):return sum(1 for _ in self)




def native_activation_available(function=None):
    """Whether a native source activation has the canonical exact-frame proof.

    Ordered ownership alone does not establish Python frame/traceback identity.
    No actual activation provider exists yet, so every unproved source callable
    refuses without inspecting it or executing application protocols. Consumers
    must route the call before child effects and report interpreter calls honestly.
    """
    return False
