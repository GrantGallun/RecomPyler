class Node:
    def __init__(self, value):
        self.value = value + 1
class State:
    def __init__(self):
        self.root = None
        self.calls = 0
STATE = State()
def make_node(value, *, sentinel=None):
    return Node(value)
def step(value):
    STATE.calls += 1
    if STATE.root is None:
        STATE.root = make_node(value)
    return STATE.root
