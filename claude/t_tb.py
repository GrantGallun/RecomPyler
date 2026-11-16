import sys, os, tempfile, traceback
sys.path.insert(0, 'src'); sys.path.insert(0,'claude')
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="rc-claude-"))
from recompyler import heap
orig = heap.Unsupported.__init__
def init(self,*a):
    orig(self,*a)
    if 'both ints' in str(a): traceback.print_stack(limit=9)
heap.Unsupported.__init__ = init
import importlib; m = importlib.import_module(sys.argv[1])
