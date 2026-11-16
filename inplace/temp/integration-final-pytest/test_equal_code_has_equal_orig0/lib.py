SCALE=0.999
def step(values,k):
    for _ in range(50):
        for i in range(len(values)):
            values[i]=values[i]*k*SCALE+0.001
    if k>10.0:
        raise ValueError("k too large")
    return len(values)+float(k)
