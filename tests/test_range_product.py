import array
import copy
import unittest
from recompyler.lift import lift
from range_kernels import FFT_transform_internal, FFT_inverse, fannkuch


def overflowing_cancel(n):
    p=list(range(1))
    j=(n*9223372036854775807-(n-1)*9223372036854775807)-9223372036854775807
    p[j]=1
    return p[0]


def helper(n, data):
    total=0
    for i in range(n):
        total+=data[i]
    return total


def two_calls(n, data):
    return helper(n, data)+helper(n, data)


class NativeRangeTests(unittest.TestCase):
    def compare(self, fn, args):
        compiled=lift(fn)
        actual,expected=copy.deepcopy(args),copy.deepcopy(args)
        try:result=fn(*expected)
        except Exception as error:
            with self.assertRaises(type(error)):compiled(*actual)
        else:self.assertEqual(compiled(*actual),result)
        for a,b in zip(actual,expected):
            if isinstance(a,array.array):self.assertEqual(a.tobytes(),b.tobytes())
            else:self.assertEqual(a,b)
        return compiled

    def test_full_fft_vectors_and_guard_misses(self):
        for n in (4,8,16,64,256):
            values=array.array('d',[(i%11-5)*0.125 for i in range(n)])
            for direction in (-1,1):
                compiled=self.compare(FFT_transform_internal,(n,values,direction))
                self.assertGreater(compiled.compiled_calls,0)
                self.assertIn('_rc_proven_getitem',compiled.source)
        for n,size,direction in ((6,6,-1),(3,3,-1),(8,7,-1),(8,8,float('inf')),(8,8,2**30)):
            self.compare(FFT_transform_internal,(n,array.array('d',[0.0]*size),direction))

    def test_inverse_signed_zero_and_extents(self):
        for n,size in ((8,8),(16,16),(8,7)):
            values=array.array('d',[-0.0 if i%2 else 0.25 for i in range(size)])
            self.compare(FFT_inverse,(n,values))

    def test_permutation_content_and_control(self):
        compiled=lift(fannkuch)
        self.assertIn('_rc_proven_flip',compiled.source)
        self.assertIn('_rc_proven_rotate',compiled.source)
        for n in (1,2,3,5,7):
            self.assertEqual(compiled(n),fannkuch(n))
        self.assertGreater(compiled.compiled_calls,0)

    def test_invalid_intermediate_replays_before_unsafe_access(self):
        compiled=lift(overflowing_cancel)
        for n in (-1,0,1,2,9):self.assertEqual(compiled(n),overflowing_cancel(n))
        self.assertGreater(compiled.fallback_calls,0)

    def test_multiple_guarded_calls_keep_function_identity(self):
        self.compare(two_calls,(40,list(range(40))))
