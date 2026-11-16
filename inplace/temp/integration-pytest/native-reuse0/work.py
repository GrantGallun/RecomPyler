class Node:
    def __init__(self, value, next):
        self.value = value
        self.next = next
    def score(self):
        return self.value
class Left(Node):
    def score(self):
        return self.value + 1
class Right(Node):
    def score(self):
        return self.value + 2
class Other(Node):
    pass
class State:
    def __init__(self):
        self.root = None
        self.calls = 0
STATE = State()
OFFSET = 3
def helper(value=2):
    return value + OFFSET
def step(value):
    STATE.calls += 1
    if STATE.root is None:
        STATE.root = Left(value, Right(value + 1, None))
    STATE.root.value += helper()
    return STATE.root
