def recurrence_1(x, y, z):
    t = x
    t = t * y + z
    return t

def recurrence_16(x, y, z):
    t = x
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    return t

def recurrence_64(x, y, z):
    t = x
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    t = t * y + z
    return t

def fibonacci(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a + b
    return a

def loop_recurrence16(x, y, z, n):
    t = x
    for i in range(n):
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
        t = t * y + z
    return t
