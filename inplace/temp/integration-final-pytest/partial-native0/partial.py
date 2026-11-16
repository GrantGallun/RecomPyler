class Node:
    def __init__(self, value):
        self.value = value
class Plain:
    def __init__(self, value):
        self.value = value
CALLS = [0]
def helper(node, unused=0):
    node.value += 1
    return sum(i for i in [node.value])
def choose(node):
    CALLS[0] += 1
    if node is None:
        return 1.5
    elif isinstance(node, Node):
        return helper(node, 0)
    else:
        node.value += 1.0
        return node.value
def other(value):
    return value + 2
