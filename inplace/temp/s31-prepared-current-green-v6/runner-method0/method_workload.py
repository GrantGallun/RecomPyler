class Box:
    def __init__(self,value): self.value=value
    def read(self): return self.value
if __name__=='__main__': print(Box(10).read())
