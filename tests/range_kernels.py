"""Equivalent copies of the existing numeric kernel functions for regression tests."""

import math

def int_log2(n):
    k = 1
    log = 0
    while k < n:
        k *= 2
        log += 1
    if n != 1 << log:
        raise Exception('FFT: Data length is not a power of 2: %s' % n)
    return log

def FFT_transform_internal(N, data, direction):
    n = N // 2
    bit = 0
    dual = 1
    if n == 1:
        return
    logn = int_log2(n)
    if N == 0:
        return
    FFT_bitreverse(N, data)
    bit = 0
    while bit < logn:
        w_real = 1.0
        w_imag = 0.0
        theta = 2.0 * direction * math.pi / (2.0 * float(dual))
        s = math.sin(theta)
        t = math.sin(theta / 2.0)
        s2 = 2.0 * t * t
        for b in range(0, n, 2 * dual):
            i = 2 * b
            j = 2 * (b + dual)
            wd_real = data[j]
            wd_imag = data[j + 1]
            data[j] = data[i] - wd_real
            data[j + 1] = data[i + 1] - wd_imag
            data[i] += wd_real
            data[i + 1] += wd_imag
        for a in range(1, dual):
            tmp_real = w_real - s * w_imag - s2 * w_real
            tmp_imag = w_imag + s * w_real - s2 * w_imag
            w_real = tmp_real
            w_imag = tmp_imag
            for b in range(0, n, 2 * dual):
                i = 2 * (b + a)
                j = 2 * (b + a + dual)
                z1_real = data[j]
                z1_imag = data[j + 1]
                wd_real = w_real * z1_real - w_imag * z1_imag
                wd_imag = w_real * z1_imag + w_imag * z1_real
                data[j] = data[i] - wd_real
                data[j + 1] = data[i + 1] - wd_imag
                data[i] += wd_real
                data[i + 1] += wd_imag
        bit += 1
        dual *= 2

def FFT_bitreverse(N, data):
    n = N // 2
    nm1 = n - 1
    j = 0
    for i in range(nm1):
        ii = i << 1
        jj = j << 1
        k = n >> 1
        if i < j:
            tmp_real = data[ii]
            tmp_imag = data[ii + 1]
            data[ii] = data[jj]
            data[ii + 1] = data[jj + 1]
            data[jj] = tmp_real
            data[jj + 1] = tmp_imag
        while k <= j:
            j -= k
            k >>= 1
        j += k

def FFT_transform(N, data):
    FFT_transform_internal(N, data, -1)

def FFT_inverse(N, data):
    n = N / 2
    norm = 0.0
    FFT_transform_internal(N, data, +1)
    norm = 1 / float(n)
    for i in range(N):
        data[i] *= norm

def fannkuch(n):
    count = list(range(1, n + 1))
    max_flips = 0
    m = n - 1
    r = n
    perm1 = list(range(n))
    perm = list(range(n))
    perm1_ins = perm1.insert
    perm1_pop = perm1.pop
    while 1:
        while r != 1:
            count[r - 1] = r
            r -= 1
        if perm1[0] != 0 and perm1[m] != m:
            perm = perm1[:]
            flips_count = 0
            k = perm[0]
            while k:
                perm[:k + 1] = perm[k::-1]
                flips_count += 1
                k = perm[0]
            if flips_count > max_flips:
                max_flips = flips_count
        while r != n:
            perm1_ins(r, perm1_pop(0))
            count[r] -= 1
            if count[r] > 0:
                break
            r += 1
        else:
            return max_flips
