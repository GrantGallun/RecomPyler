class Box:
    def __init__(self, value): self.value = value
    def read(self): return self.value
    def work(self): return self.read() + 1
if __name__ == '__main__': print(Box(10).work())
