events=[]
class Base:
    def __del__(self):
        events.append(self.handle)
class Resource(Base):
    def __init__(self,handle):
        self.handle=handle
