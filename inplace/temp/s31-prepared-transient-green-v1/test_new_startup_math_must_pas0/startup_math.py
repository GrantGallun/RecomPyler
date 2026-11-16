import math
class Node:
    def __init__(self, value):
        self.value = value
class State:
    def __init__(self):
        self.root = None
STATE = State()
def run(value):
    if STATE.root is None:
        STATE.root = Node(math.sin(value))
    return STATE.root.value
