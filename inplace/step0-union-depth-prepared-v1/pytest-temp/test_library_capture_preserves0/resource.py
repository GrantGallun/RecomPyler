events=[]
class Resource:
    def __init__(self,handle):
        self.handle=handle
    def __del__(self):
        events.append(self.handle)
def read(obj):
    return obj.handle
