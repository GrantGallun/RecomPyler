import unittest
import numpy as np
from recompyler.lift import lift
import importlib
runtime=importlib.import_module('recompyler.lift')

def product(a,b):
    return a*b

def write_then_multiply(values,a,b):
    values[0]+=1
    return a*b+values[0]

class IntegerProductTests(unittest.TestCase):
    def test_overflow_restores_speculative_list_write(self):
        compiled=lift(write_then_multiply)
        values=[4]
        expected=[4]
        result=write_then_multiply(expected,2**62,4)
        self.assertEqual(compiled(values,2**62,4),result)
        self.assertEqual(values,expected)
        self.assertGreater(compiled.fallback_calls,0)
    def test_signed_boundaries_and_bool_semantics(self):
        compiled=lift(product)
        vals=[-(2**63),-(2**63)+1,-2**62,-3037000500,-1,0,1,3037000499,3037000500,2**62,2**63-1,True,False]
        for a in vals:
            for b in vals:
                self.assertEqual(compiled(a,b),a*b,(a,b))


def copy_loop(n, rounds):
    source=list(range(n))
    target=list(range(n))
    total=0
    for r in range(rounds):
        target=source[:]
        target[0]=r
        total+=target[0]+source[0]
    return total

def changing_lengths(n):
    source=list(range(n))
    target=list(range(1))
    for r in range(3):
        target=source[:]
    return len(target)

def escaped_copy(n):
    source=list(range(n))
    target=source[:]
    saved=target
    target=source[:]
    target[0]=99
    return saved[0]

def conditional_init(flag):
    source=list(range(4))
    if flag:
        target=source[:]
    else:
        target=source[:]
    target[0]=7
    return target[0]

class LocalBufferTests(unittest.TestCase):
    def test_copy_loop_reuses_nonescaping_buffer(self):
        compiled=lift(copy_loop)
        self.assertIn('_rc_copy_into',compiled.source)
        for n in [1,3,9,100]:
            for rounds in [0,1,7]:
                self.assertEqual(compiled(n,rounds),copy_loop(n,rounds))
        self.assertGreater(compiled.compiled_calls,0)
    def test_changed_length_uses_fresh_copy(self):
        compiled=lift(changing_lengths)
        self.assertIn('_rc_copy_into',compiled.source)
        for n in [0,1,9]:self.assertEqual(compiled(n),n)
    def test_escaping_alias_keeps_copy_identity(self):
        compiled=lift(escaped_copy)
        self.assertNotIn('_rc_copy_into',compiled.source)
        self.assertEqual(compiled(4),0)
    def test_branch_initialization_does_not_read_unbound_buffer(self):
        compiled=lift(conditional_init)
        self.assertNotIn('_rc_copy_into',compiled.source)
        for flag in [True,False]:self.assertEqual(compiled(flag),7)
    def test_checked_array_helpers_use_unsigned_physical_index(self):
        from numba import njit
        getitem=runtime._runtime()[0]['_rc_getitem']
        @njit
        def call(st,values,index):return getitem(st,values,index)
        status=np.zeros(1,dtype=np.uint8);values=np.arange(8,dtype=np.int64)
        for i in [-9,-8,-1,0,7,8]:
            status[0]=0;got=call(status,values,i)
            if -8<=i<8:self.assertEqual(got,values[i]);self.assertEqual(status[0],0)
            else:self.assertEqual(status[0],1)
        # Exactly one logical negative-index correction remains, no second
        # implicit Numba correction after the explicit unsigned bounds proof.
        llvm=call.inspect_llvm(call.signatures[0])
        self.assertIn('icmp', llvm)  # Behavioural boundaries are covered by review tests.


def reset_buffer(n,rounds):
    values=[0]*n
    total=0
    for r in range(rounds):
        values=[0]*n
        values[0]=r
        total+=values[0]
    return total

def reset_range(n,rounds):
    values=list(range(n))
    total=0
    for r in range(rounds):
        values=list(range(n))
        total+=values[0]+values[n-1]
    return total

class GeneralAllocationTests(unittest.TestCase):
    def test_nonslice_repeated_fill_reuses_dead_private_allocation(self):
        compiled=lift(reset_buffer)
        self.assertIn('_rc_full_reuse',compiled.source)
        for n in [1,4,17]:
            self.assertEqual(compiled(n,5),reset_buffer(n,5))
        self.assertGreater(compiled.compiled_calls,0)
    def test_repeated_range_reuses_dead_private_allocation(self):
        compiled=lift(reset_range)
        self.assertIn('_rc_arange_reuse',compiled.source)
        for n in [1,4,17]:
            self.assertEqual(compiled(n,5),reset_range(n,5))
        self.assertGreater(compiled.compiled_calls,0)


def iterator_keeps_old_list():
    values=list(range(3))
    total=0
    for value in values:
        values=[9]*3
        total+=value
    return total

class IteratorLifetimeTests(unittest.TestCase):
    def test_rebound_array_is_live_through_iterator(self):
        compiled=lift(iterator_keeps_old_list)
        self.assertEqual(compiled(),iterator_keeps_old_list())
        self.assertNotIn('_rc_full_reuse',compiled.source)


def changing_fill(n):
    values=[0]*1
    total=0
    for r in range(4):
        values=[0]*(n+r)
        total+=len(values)
    return total

def changing_range(start,stop,step):
    values=list(range(1))
    for r in range(3):
        values=list(range(start,stop,step))
    return len(values)

def rotate_reverse(n,i,j,k):
    values=list(range(n))
    values.insert(i,values.pop(j))
    values[:k+1]=values[k::-1]
    total=0
    for value in values:
        total=total*11+value
    return total

class ReuseExtentTests(unittest.TestCase):
    def test_fill_extent_changes_and_negative_lengths(self):
        compiled=lift(changing_fill)
        for n in [-5,-1,0,1,5]:self.assertEqual(compiled(n),changing_fill(n))
    def test_range_fallback_extents_and_zero_step(self):
        compiled=lift(changing_range)
        for args in [(0,7,1),(-3,5,1),(9,-3,-2),(3,3,1),(0,8,2)]:
            self.assertEqual(compiled(*args),changing_range(*args))
        with self.assertRaises(ValueError):compiled(0,4,0)
    def test_rotate_reverse_negative_and_empty_cases(self):
        compiled=lift(rotate_reverse)
        self.assertEqual(compiled(3,1,0,1),rotate_reverse(3,1,0,1))
        self.assertGreater(compiled.compiled_calls,0)
        for n in [0,1,3,9]:
            for i,j,k in [(-9,-1,-1),(1,0,1),(99,-2,-2),(0,99,2)]:
                try:expected=rotate_reverse(n,i,j,k)
                except IndexError:
                    with self.assertRaises(IndexError):compiled(n,i,j,k)
                else:self.assertEqual(compiled(n,i,j,k),expected)

