#include <stdint.h>
#include <stddef.h>
#if defined(_WIN32)
#define API __declspec(dllexport)
#define NI __declspec(noinline)
#else
#define API __attribute__((visibility("default")))
#define NI __attribute__((noinline))
#endif
API NI int64_t recurrence_1_exact(int64_t x, int64_t y, int64_t z, int64_t unused_n) {
    int64_t t = x;
    t = t * y + z;
    return t;
}
API NI uint64_t recurrence_1_wrap(int64_t x_in, int64_t y_in, int64_t z_in, int64_t unused_n) {
    uint64_t x=(uint64_t)x_in, y=(uint64_t)y_in, z=(uint64_t)z_in;
    uint64_t t = x;
    t = t * y + z;
    return t;
}
API NI int64_t recurrence_16_exact(int64_t x, int64_t y, int64_t z, int64_t unused_n) {
    int64_t t = x;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    return t;
}
API NI uint64_t recurrence_16_wrap(int64_t x_in, int64_t y_in, int64_t z_in, int64_t unused_n) {
    uint64_t x=(uint64_t)x_in, y=(uint64_t)y_in, z=(uint64_t)z_in;
    uint64_t t = x;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    return t;
}
API NI int64_t recurrence_64_exact(int64_t x, int64_t y, int64_t z, int64_t unused_n) {
    int64_t t = x;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    return t;
}
API NI uint64_t recurrence_64_wrap(int64_t x_in, int64_t y_in, int64_t z_in, int64_t unused_n) {
    uint64_t x=(uint64_t)x_in, y=(uint64_t)y_in, z=(uint64_t)z_in;
    uint64_t t = x;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    t = t * y + z;
    return t;
}
API NI int64_t loop_recurrence16_exact(int64_t x_in, int64_t y_in, int64_t z_in, int64_t n) {
    int64_t t=(int64_t)x_in, y=(int64_t)y_in, z=(int64_t)z_in;
    for (int64_t i=0; i<n; ++i) {
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
    }
    return t;
}
API NI uint64_t loop_recurrence16_wrap(int64_t x_in, int64_t y_in, int64_t z_in, int64_t n) {
    uint64_t t=(uint64_t)x_in, y=(uint64_t)y_in, z=(uint64_t)z_in;
    for (int64_t i=0; i<n; ++i) {
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
        t = t * y + z;
    }
    return t;
}
API NI int64_t fibonacci_exact(int64_t n, int64_t unused_y, int64_t unused_z, int64_t unused_n) {
    int64_t a=0, b=1;
    for (int64_t i=0; i<n; ++i) { int64_t next=a+b; a=b; b=next; }
    return a;
}
API NI uint64_t fibonacci_wrap(int64_t n, int64_t unused_y, int64_t unused_z, int64_t unused_n) {
    uint64_t a=0, b=1;
    for (int64_t i=0; i<n; ++i) { uint64_t next=a+b; a=b; b=next; }
    return a;
}
