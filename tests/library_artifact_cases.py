"""Fixtures for fresh-process relocatable library artifacts."""
def walk(value):
    while value.parent is not None:
        value = value.parent
    return value


def total(values):
    result = 0
    for value in values:
        result += value
    return result


def choose(value):
    while value.parent is not None:
        value = value.parent
    return value, 1000, 2000


def peek(value):
    return value.parent


def walk_retained(owner):
    current=owner
    while current.parent is not None:current=current.parent
    return current


def numeric_total(values):
    result=0
    for value in values:result=result+value
    return result
