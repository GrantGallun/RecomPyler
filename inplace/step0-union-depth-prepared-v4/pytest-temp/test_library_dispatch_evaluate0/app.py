import capture_order_lib as lib
events=[]
def getfn():
    events.append("callee")
    return lib.work
def arg():
    events.append("arg")
    return 2
assert getfn()(arg())==3
assert events==["callee","arg"]
