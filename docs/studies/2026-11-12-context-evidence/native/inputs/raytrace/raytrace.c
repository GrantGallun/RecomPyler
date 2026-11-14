/* One loop of bm_raytrace at 100 x 100: the same scene, rays and colour sums,
 * with Python's operation order, so the canvas bytes match exactly. */
#include <math.h>

#include "common.h"

#define EPSILON 0.00001
#define PI 3.141592653589793

typedef struct { double x, y, z; } V3;   /* Python's Vector and Point */

static V3 v3(double x, double y, double z) { V3 v = {x, y, z}; return v; }
static V3 add(V3 a, V3 b) { return v3(a.x + b.x, a.y + b.y, a.z + b.z); }
static V3 sub(V3 a, V3 b) { return v3(a.x - b.x, a.y - b.y, a.z - b.z); }
static V3 scale(V3 a, double f) { return v3(f * a.x, f * a.y, f * a.z); }
static double dot(V3 a, V3 b) { return (a.x * b.x) + (a.y * b.y) + (a.z * b.z); }
static V3 cross(V3 a, V3 b) {
    return v3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
}
static double magnitude(V3 a) { return sqrt(dot(a, a)); }
static V3 normalized(V3 a) { return scale(a, 1.0 / magnitude(a)); }
static V3 reflect_through(V3 a, V3 normal) {
    V3 d = scale(normal, dot(a, normal));
    return sub(a, scale(d, 2));
}

typedef struct { V3 point, vector; } Ray;
static Ray ray(V3 point, V3 vector) { Ray r = {point, normalized(vector)}; return r; }
static V3 point_at(Ray r, double t) { return add(r.point, scale(r.vector, t)); }

typedef struct { double r, g, b; } Colour;
static Colour colour(double r, double g, double b) { Colour c = {r, g, b}; return c; }
static Colour add_colours(Colour a, double s, Colour b) {
    return colour(a.r + s * b.r, a.g + s * b.g, a.b + s * b.b);
}

enum { SPHERE, HALFSPACE };
enum { SIMPLE, CHECKERBOARD };

typedef struct {
    int shape;
    V3 centre;          /* sphere centre, or halfspace point */
    double radius;
    V3 normal;          /* halfspace normal, normalised */
    int surface;
    Colour base, other;
    double specular, lambert, ambient, check_size;
} Object;

typedef struct {
    Object objects[8];
    int count;
    V3 lights[2];
    int light_count;
    V3 position, looking_at;
    double field_of_view;
    int depth;
} Scene;

/* Returns 0 for Python's None. */
static int intersection_time(const Object *o, Ray r, double *t) {
    if (o->shape == SPHERE) {
        V3 cp = sub(o->centre, r.point);
        double v = dot(cp, r.vector);
        double discriminant = (o->radius * o->radius) - (dot(cp, cp) - v * v);
        if (discriminant < 0) return 0;
        *t = v - sqrt(discriminant);
        return 1;
    }
    double v = dot(r.vector, o->normal);
    if (v != 0) {
        *t = 1 / -v;
        return 1;
    }
    return 0;
}

static V3 normal_at(const Object *o, V3 p) {
    return o->shape == SPHERE ? normalized(sub(p, o->centre)) : o->normal;
}

static Colour base_colour_at(const Object *o, V3 p) {
    if (o->surface == CHECKERBOARD) {
        V3 v = sub(p, v3(0, 0, 0));
        /* v.scale(1.0 / checkSize) is computed and thrown away in Python. */
        long sum = (long)(fabs(v.x) + 0.5) + (long)(fabs(v.y) + 0.5) + (long)(fabs(v.z) + 0.5);
        return sum % 2 ? o->other : o->base;
    }
    return o->base;
}

static Colour ray_colour(Scene *s, Ray r);

static int light_is_visible(Scene *s, V3 light, V3 p) {
    for (int i = 0; i < s->count; i++) {
        double t;
        if (intersection_time(&s->objects[i], ray(p, sub(light, p)), &t) && t > EPSILON) return 0;
    }
    return 1;
}

static Colour colour_at(Scene *s, const Object *o, Ray r, V3 p, V3 normal) {
    Colour b = base_colour_at(o, p);
    Colour c = colour(0, 0, 0);
    if (o->specular > 0) {
        Ray reflected = ray(p, reflect_through(r.vector, normal));
        c = add_colours(c, o->specular, ray_colour(s, reflected));
    }
    if (o->lambert > 0) {
        double lambert_amount = 0;
        for (int i = 0; i < s->light_count; i++) {
            if (!light_is_visible(s, s->lights[i], p)) continue;
            double contribution = dot(normalized(sub(s->lights[i], p)), normal);
            if (contribution > 0) lambert_amount = lambert_amount + contribution;
        }
        lambert_amount = lambert_amount < 1 ? lambert_amount : 1;   /* min(1, x) */
        c = add_colours(c, o->lambert * lambert_amount, b);
    }
    if (o->ambient > 0) c = add_colours(c, o->ambient, b);
    return c;
}

static Colour ray_colour(Scene *s, Ray r) {
    if (s->depth > 3) return colour(0, 0, 0);
    s->depth++;
    int found = -1;
    double best = 0;
    for (int i = 0; i < s->count; i++) {
        double t;
        if (intersection_time(&s->objects[i], r, &t) && t > -EPSILON && (found < 0 || t < best)) {
            found = i;
            best = t;
        }
    }
    Colour result = colour(0, 0, 0);
    if (found >= 0) {
        V3 p = point_at(r, best);
        result = colour_at(s, &s->objects[found], r, p, normal_at(&s->objects[found], p));
    }
    s->depth--;
    return result;
}

static unsigned char clamp_byte(double value) {
    long v = (long)(value * 255);   /* int() truncates toward zero */
    return (unsigned char)(v < 0 ? 0 : v > 255 ? 255 : v);
}

static void render(Scene *s, unsigned char *bytes, int width, int height) {
    double fov = PI * (s->field_of_view / 2.0) / 180.0;
    double half_width = tan(fov);
    double half_height = 0.75 * half_width;
    double w = half_width * 2, h = half_height * 2;
    double pixel_width = w / (width - 1), pixel_height = h / (height - 1);
    Ray eye = ray(s->position, sub(s->looking_at, s->position));
    V3 vp_right = normalized(cross(eye.vector, v3(0, 1, 0)));
    V3 vp_up = normalized(cross(vp_right, eye.vector));
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            V3 xcomp = scale(vp_right, x * pixel_width - half_width);
            V3 ycomp = scale(vp_up, y * pixel_height - half_height);
            Ray r = ray(eye.point, add(add(eye.vector, xcomp), ycomp));
            Colour c = ray_colour(s, r);
            int i = ((height - y - 1) * width + x) * 3;
            bytes[i] = clamp_byte(c.r);
            bytes[i + 1] = clamp_byte(c.g);
            bytes[i + 2] = clamp_byte(c.b);
        }
    }
}

static Object simple(int shape, V3 centre, double radius, V3 normal, Colour base) {
    Object o;
    memset(&o, 0, sizeof(o));
    o.shape = shape;
    o.centre = centre;
    o.radius = radius;
    o.normal = shape == HALFSPACE ? normalized(normal) : normal;
    o.surface = SIMPLE;
    o.base = base;
    o.specular = 0.2;
    o.lambert = 0.6;
    o.ambient = 1.0 - o.specular - o.lambert;
    o.other = colour(0, 0, 0);
    o.check_size = 1;
    return o;
}

static void bench(unsigned char *bytes, int width, int height) {
    /* Canvas: zeroes with blue 255; every pixel is then plotted. */
    for (int i = 0; i < width * height * 3; i++) bytes[i] = (i % 3 == 2) ? 255 : 0;
    Scene s;
    memset(&s, 0, sizeof(s));
    s.position = v3(0, 1.8, 10);
    s.field_of_view = 45;
    s.lights[s.light_count++] = v3(30, 30, 10);
    s.lights[s.light_count++] = v3(-10, 100, 30);
    s.looking_at = v3(0, 3, 0);
    s.objects[s.count++] = simple(SPHERE, v3(1, 3, -10), 2, v3(0, 0, 0), colour(1, 1, 0));
    for (int y = 0; y < 6; y++) {
        s.objects[s.count++] = simple(SPHERE, v3(-3 - y * 0.4, 2.3, -5), 0.4, v3(0, 0, 0),
                                      colour(y / 6.0, 1 - y / 6.0, 0.5));
    }
    Object floor = simple(HALFSPACE, v3(0, 0, 0), 0, v3(0, 1, 0), colour(1, 1, 1));
    floor.surface = CHECKERBOARD;
    s.objects[s.count++] = floor;
    render(&s, bytes, width, height);
}

int main(int argc, char **argv) {
    int repeats = repeats_from(argc, argv, 10);
    int width = 100, height = 100;
    unsigned char *bytes = malloc(width * height * 3);
    double best = 1e30;
    for (int rep = 0; rep < repeats; rep++) {
        double t0 = now_seconds();
        bench(bytes, width, height);
        double dt = now_seconds() - t0;
        if (dt < best) best = dt;
    }
    unsigned long long total = 0;
    for (int i = 0; i < width * height * 3; i++) total += bytes[i];
    printf("check byte_sum %llu\n", total);
    printf("check fnv %llu\n", (unsigned long long)fnv1a(bytes, width * height * 3));
    printf("seconds %.9f\n", best);
    free(bytes);
    return 0;
}
