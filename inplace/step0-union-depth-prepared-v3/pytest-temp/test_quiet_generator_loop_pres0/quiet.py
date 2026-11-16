x = 0
def values():
    for i in range(3):
        yield x + 1
for x in values():
    pass
print(x)
