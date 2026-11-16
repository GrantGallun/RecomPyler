class Node:
    def __init__(self, value):
        self.value = value
CALLS = [0]
def helper(node):
    node.value += 1
    return node.value
def choose(node):
    CALLS[0] += 1
    if node is None:
        return 1.5
    else:
        return helper(node)
