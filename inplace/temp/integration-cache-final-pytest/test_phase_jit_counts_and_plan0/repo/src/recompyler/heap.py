
class _Program:
    ahead_of_time = False
    def compile(self): self.run = lambda: 42
    def guards_hold(self): return True
class _Unloader:
    def result(self): return 42
    def write_back(self): pass
class Region:
    aot_calls = jit_calls = 0
    def __init__(self, fn): self.original = fn
    def load(self, program, args): return None
    def attempt(self, args, kwargs=None):
        program = _Program()
        program.compile()
        self.load(program, args)
        assert program.guards_hold()
        program.run()
        unloader = _Unloader()
        answer = unloader.result()
        unloader.write_back()
        self.jit_calls += 1
        return True, answer
