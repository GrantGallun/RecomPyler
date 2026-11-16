def step(values):
    values[0] += 1
    return values[0]
data = [0]
for _ in range(2):
    step(data)
print(data[0])
