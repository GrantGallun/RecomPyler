import native_lib
from native_lib import work
assert work is native_lib.work
assert work(2)==3
assert work(2**80)==2**80+1
assert work is native_lib.work
