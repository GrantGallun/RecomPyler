def make():
    value=3
    def work(x):
        return x+value
    return work
work=make()
