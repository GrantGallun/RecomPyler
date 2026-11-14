/* Calls externally compiled kernels/adapters. No LTO; every input is runtime data. */
#include <stdint.h>
#include <stddef.h>
#if defined(_WIN32)
#define API __declspec(dllexport)
#else
#define API __attribute__((visibility("default")))
#endif

typedef int64_t (*exact_fn)(int64_t, int64_t, int64_t, int64_t);
typedef uint64_t (*wrap_fn)(int64_t, int64_t, int64_t, int64_t);
typedef int64_t (*rp_fn)(double *, int64_t *, int64_t *, uint8_t *,
                         int64_t, int64_t, int64_t, int64_t);

API uint64_t batch_exact(exact_fn fn, const int64_t *inputs, size_t count,
                         size_t repeats, uint64_t *completed) {
    uint64_t checksum = 0;
    *completed = 0;
    for (size_t r=0; r<repeats; ++r) {
        for (size_t i=0; i<count; ++i) {
            checksum += (uint64_t)fn(inputs[4*i], inputs[4*i+1], inputs[4*i+2], inputs[4*i+3]);
            ++*completed;
        }
    }
    return checksum;
}

API uint64_t batch_wrap(wrap_fn fn, const int64_t *inputs, size_t count,
                        size_t repeats, uint64_t *completed) {
    uint64_t checksum = 0;
    *completed = 0;
    for (size_t r=0; r<repeats; ++r) {
        for (size_t i=0; i<count; ++i) {
            checksum += fn(inputs[4*i], inputs[4*i+1], inputs[4*i+2], inputs[4*i+3]);
            ++*completed;
        }
    }
    return checksum;
}

API uint64_t batch_rp(rp_fn fn, const int64_t *inputs, size_t count,
                      size_t repeats, double *F, int64_t *I, int64_t *top,
                      uint8_t *status, int64_t loader_top, uint64_t *completed,
                      uint64_t *failures) {
    uint64_t checksum = 0;
    *completed = 0;
    *failures = 0;
    for (size_t r=0; r<repeats; ++r) {
        for (size_t i=0; i<count; ++i) {
            top[0] = loader_top;
            top[1] = 0;
            top[2] = 1024;
            top[3] = -1;
            status[0] = 0;
            int64_t result = fn(F, I, top, status, inputs[4*i], inputs[4*i+1], inputs[4*i+2], inputs[4*i+3]);
            if (status[0]) {
                ++*failures;
                return checksum;
            }
            checksum += (uint64_t)result;
            ++*completed;
        }
    }
    return checksum;
}
