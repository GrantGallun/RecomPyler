from keyword_lib import work
assert work(2,scale=4)==8
assert work(2)==6
work.__kwdefaults__["scale"]=5
assert work(2)==10
work.__kwdefaults__={"scale":7}
assert work(2)==14
assert work(2**80,scale=4)==2**82
try:
    work(2,4)
except TypeError:
    pass
else:
    raise AssertionError("invalid binding accepted")
