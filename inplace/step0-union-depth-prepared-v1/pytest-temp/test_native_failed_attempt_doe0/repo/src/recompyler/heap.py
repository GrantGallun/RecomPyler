
class _Program:
    ahead_of_time = True
    def compile(self): self.run = lambda: (_ for _ in ()).throw(ValueError('native failure'))
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
        try: program.run()
        except ValueError: return False, None
        unloader = _Unloader()
        answer = unloader.result()
        unloader.write_back()
        self.aot_calls += 1
        return True, answer
