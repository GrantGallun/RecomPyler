events=[]
class Special:
    def __new__(cls,value):
        events.append(value)
        return object.__new__(cls)
    def __init__(self,value):
        self.value=value
def work(value):
    return Special(value).value
