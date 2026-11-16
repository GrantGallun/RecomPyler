class BaseA:
    pass
class A(BaseA):
    def __init__(self, value):
        self.x = value
class C(A):
    pass
class BaseB:
    pass
class B(BaseB):
    def __init__(self, value):
        self.x = value
        self.y = value
CALLS = [0]
def read(a, b, c):
    CALLS[0] += 1
    return a.x + b.y + c.x
def merged(values):
    total = 0
    for value in values:
        total += value.x
    return total
