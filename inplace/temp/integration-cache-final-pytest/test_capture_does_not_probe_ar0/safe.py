def work(x):
    return x+1
alias=work
class Trap:
    def __getattribute__(self,name):
        if name=="__code__":
            raise AssertionError("capture ran a user hook")
        return object.__getattribute__(self,name)
work=Trap()
assert alias(2)==3
