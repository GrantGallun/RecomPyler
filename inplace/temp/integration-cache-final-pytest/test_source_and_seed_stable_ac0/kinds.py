class Base:
    def __init__(self):
        self.n = 1
class Left(Base):
    def __init__(self):
        self.n = 1
        self.extra = 2
class Leaf(Left):
    pass
class Right(Base):
    pass
def subset(nodes):
    total = 0
    for node in nodes:
        if isinstance(node, Left):
            total += node.n
        total += node.extra
    return total
