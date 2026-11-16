import random
GLOBAL = 3

def helper(value=4):
    return abs(value) + 1

class Base:
    def offset(self):
        return 1

class Box(Base):
    def __init__(self, value):
        self.value = value

def work(box, items, scale=2, *, bias=1):
    box.value += scale + bias + helper(GLOBAL) + box.offset()
    items.append(box.value)
    return box, items, box.value

def alias(box, left, right):
    left.append(box)
    return left, right, left[-1]

def random_step(n):
    return random.randrange(n)

def read(box):
    return box.value

GLOBAL_BOX=Box(10)
def global_read():
    return GLOBAL_BOX.value
