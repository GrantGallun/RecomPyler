"""random.Random inside a region: CPython's Mersenne Twister, bit for bit.

A generator in the region's heap is a block of RNG_SLOTS int64 slots: the 624
state words, the position in them, and a flag that the region seeded it. The
block is copied from the Python generator on entry and back after a call that
finished compiled, so a call handed back to Python leaves the generator as it was.

The state is read and written in place, straight from the generator object's
memory (CPython's RandomObject: a 32-bit position, then 624 32-bit words), once
that layout has been checked against getstate() and setstate() on this
interpreter. Where it does not match, getstate() and setstate() are used.

The methods follow Lib/random.py and Modules/_randommodule.c exactly: random()
takes two words, getrandbits(k) one word per 32 bits from the least significant,
and _randbelow(n) draws getrandbits(n.bit_length()) until the value is below n.
"""

import ctypes
import random

import numpy as np

N = 624
RNG_SLOTS = N + 2
# The Python methods whose compiled forms follow; their code is guarded.
METHODS = ("random", "getrandbits", "randrange", "randint", "choice", "shuffle", "uniform", "sample", "seed")


def _probe():
    """(position offset, state offset) in a generator object, or None."""
    try:
        made = random.Random(20261111)
        for _ in range(5):
            made.random()
        version, state, gauss = made.getstate()
        base, position = id(made), 16
        index = ctypes.c_int.from_address(base + position)
        words = np.frombuffer((ctypes.c_uint32 * N).from_address(base + position + 4), dtype=np.uint32)
        if index.value != state[-1] or words.tolist() != list(state[:N]):
            return None
        # Writing through the view must be what setstate would have done.
        other = random.Random(7)
        other.random()
        wanted = other.getstate()
        words[:] = np.array(wanted[1][:N], dtype=np.uint32)
        index.value = wanted[1][-1]
        if made.getstate() != wanted or made.random() != other.random():
            return None
        return position, position + 4
    except Exception:
        return None


_LAYOUT = _probe()


def supported(value):
    """True if ``value`` is a plain random.Random whose methods are the standard ones."""
    if type(value) is not random.Random:
        return False
    extra = getattr(value, "__dict__", {})
    return set(extra) <= {"gauss_next"}


def state_of(value):
    """The block of RNG_SLOTS int64 values that stands for generator ``value``."""
    block = np.zeros(RNG_SLOTS, dtype=np.int64)
    if _LAYOUT is not None:
        base = id(value)
        block[:N] = np.frombuffer((ctypes.c_uint32 * N).from_address(base + _LAYOUT[1]), dtype=np.uint32)
        block[N] = ctypes.c_int.from_address(base + _LAYOUT[0]).value
    else:
        words = value.getstate()[1]
        block[:N] = words[:N]
        block[N] = words[N]
    return block


def store(value, I, handle):
    """Put the heap block at ``handle`` back into generator ``value``."""
    words = I[handle:handle + N]
    position = int(I[handle + N])
    if _LAYOUT is not None:
        base = id(value)
        view = np.frombuffer((ctypes.c_uint32 * N).from_address(base + _LAYOUT[1]), dtype=np.uint32)
        np.copyto(view, words, casting="unsafe")
        ctypes.c_int.from_address(base + _LAYOUT[0]).value = position
    else:
        gauss = value.getstate()[2]
        value.setstate((3, tuple(int(word) for word in words) + (position,), gauss))
    if I[handle + N + 1]:
        # Random.seed() clears the saved second normal deviate.
        value.gauss_next = None


def guards():
    """(class, name, function) for every method the compiled forms stand for."""
    found = [(random.Random, name, getattr(random.Random, name)) for name in METHODS]
    found.append((random.Random, "_randbelow", random.Random._randbelow_with_getrandbits))
    return found


RUNTIME = '''

@njit(error_model="numpy")
def mt_twist(I, h):
    for kk in range(624):
        y = (I[h + kk] & 0x80000000) | (I[h + (kk + 1) % 624] & 0x7fffffff)
        v = I[h + (kk + 397) % 624] ^ (y >> 1)
        if y & 1:
            v ^= 0x9908b0df
        I[h + kk] = v


@njit(error_model="numpy", inline="always")
def mt_next(I, h):
    i = I[h + 624]
    if i >= 624:
        mt_twist(I, h)
        i = 0
    y = I[h + i]
    I[h + 624] = i + 1
    y ^= y >> 11
    y ^= (y << 7) & 0x9d2c5680
    y ^= (y << 15) & 0xefc60000
    y ^= y >> 18
    return y


@njit(error_model="numpy", inline="always")
def mt_random(I, h):
    a = mt_next(I, h) >> 5
    b = mt_next(I, h) >> 6
    return (a * 67108864.0 + b) * (1.0 / 9007199254740992.0)


@njit(error_model="numpy", inline="always")
def mt_bits(I, h, k):
    if k <= 0:
        return 0
    if k <= 32:
        return mt_next(I, h) >> (32 - k)
    low = mt_next(I, h)
    high = mt_next(I, h) >> (64 - k)
    return low | (high << 32)


@njit(error_model="numpy")
def mt_below(I, h, n):
    k = 0
    while (n >> k) != 0:
        k += 1
    r = mt_bits(I, h, k)
    while r >= n:
        r = mt_bits(I, h, k)
    return r


@njit(error_model="numpy")
def mt_shuffle(I, h, lst):
    data = I[lst + 2]
    i = I[lst] - 1
    while i >= 1:
        j = mt_below(I, h, i + 1)
        held = I[data + i]
        I[data + i] = I[data + j]
        I[data + j] = held
        i -= 1


@njit(error_model="numpy")
def mt_sample(I, top, st, h, lst, k):
    n = I[lst]
    if k < 0 or k > n:
        st[0] = 1
        return 0
    setsize = 21
    if k > 5:
        power = math.ceil(math.log(float(k * 3)) / math.log(4.0))
        size = 1
        for _ in range(power):
            size *= 4
        setsize += size
    out = list_new(I, top, st, k, k)
    if st[0]:
        return 0
    source, target = I[lst + 2], I[out + 2]
    if n <= setsize:
        pool = alloc(I, top, st, n if n > 0 else 1)
        if st[0]:
            return 0
        for p in range(n):
            I[pool + p] = I[source + p]
        for i in range(k):
            j = mt_below(I, h, n - i)
            I[target + i] = I[pool + j]
            I[pool + j] = I[pool + n - i - 1]
    else:
        chosen = alloc(I, top, st, n)
        if st[0]:
            return 0
        for p in range(n):
            I[chosen + p] = 0
        for i in range(k):
            j = mt_below(I, h, n)
            while I[chosen + j] != 0:
                j = mt_below(I, h, n)
            I[chosen + j] = 1
            I[target + i] = I[source + j]
    return out


@njit(error_model="numpy")
def mt_seed(I, h, a):
    if a < 0:
        a = -a
    low, high = a & 0xffffffff, (a >> 32) & 0xffffffff
    length = 2 if high else 1
    I[h] = 19650218
    for m in range(1, 624):
        prev = I[h + m - 1]
        I[h + m] = (1812433253 * (prev ^ (prev >> 30)) + m) & 0xffffffff
    i, j = 1, 0
    for _ in range(624):
        prev = I[h + i - 1]
        key = low if j == 0 else high
        I[h + i] = ((I[h + i] ^ (((prev ^ (prev >> 30)) * 1664525) & 0xffffffff)) + key + j) & 0xffffffff
        i += 1
        j += 1
        if i >= 624:
            I[h] = I[h + 623]
            i = 1
        if j >= length:
            j = 0
    for _ in range(623):
        prev = I[h + i - 1]
        I[h + i] = ((I[h + i] ^ (((prev ^ (prev >> 30)) * 1566083941) & 0xffffffff)) - i) & 0xffffffff
        i += 1
        if i >= 624:
            I[h] = I[h + 623]
            i = 1
    I[h] = 0x80000000
    I[h + 624] = 624
    I[h + 625] = 1

'''
