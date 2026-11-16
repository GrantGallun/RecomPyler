import capture_dispatch_lib as lib
from capture_dispatch_lib import work
assert work is lib.work
assert work(2)==3
assert lib.work(2.5)==3.5
assert lib.work is work
