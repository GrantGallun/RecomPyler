class Box:
    __slots__=('x','y')
    def __init__(self):
        self.x=2
        self.y=8
class Other:
    __slots__=('x','y')
def work(box):
    box.x=1
    return box.y
