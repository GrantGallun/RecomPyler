/* One loop of bm_barnes_hut: 200 particles, 100 steps, theta 0.5, then the final
 * energy. Setup (the galaxy and its initial energy) is outside the timed region,
 * as in Python. The quadtree is rebuilt each step, as in Python. */
#include <math.h>

#include "common.h"

#define G 6.67430e-11
#define SOFTENING 5.0
#define TIME_STEP 0.1
#define PI 3.141592653589793
#define CAPACITY 4

typedef struct {
    double px, py, vx, vy, ax, ay, mass;
} Particle;

typedef struct Node {
    double bx, by, bw, bh;
    int count;
    int particles[CAPACITY];
    int divided;
    double cx, cy, total_mass;
    struct Node *child[4];   /* northeast, northwest, southeast, southwest */
} Node;

static Particle *P;

static Node *new_node(double x, double y, double w, double h) {
    Node *n = calloc(1, sizeof(Node));
    n->bx = x; n->by = y; n->bw = w; n->bh = h;
    return n;
}

static void free_tree(Node *n) {
    if (!n) return;
    for (int i = 0; i < 4; i++) free_tree(n->child[i]);
    free(n);
}

static int contains(const Node *n, const Particle *p) {
    return p->px >= n->bx - n->bw && p->px < n->bx + n->bw && p->py >= n->by - n->bh && p->py < n->by + n->bh;
}

static int insert(Node *n, int index);

static void subdivide(Node *n) {
    double x = n->bx, y = n->by, w = n->bw / 2, h = n->bh / 2;
    n->child[0] = new_node(x + w, y - h, w, h);
    n->child[1] = new_node(x - w, y - h, w, h);
    n->child[2] = new_node(x + w, y + h, w, h);
    n->child[3] = new_node(x - w, y + h, w, h);
    n->divided = 1;
    /* Each particle is offered to all four children; only one contains it. */
    for (int i = 0; i < n->count; i++) {
        for (int c = 0; c < 4; c++) insert(n->child[c], n->particles[i]);
    }
    n->count = 0;
}

static int insert(Node *n, int index) {
    Particle *p = &P[index];
    if (!contains(n, p)) return 0;
    if (n->count < CAPACITY && !n->divided) {
        n->particles[n->count++] = index;
        /* update_mass_distribution: total mass starts as int 0, which adds like 0.0 */
        double total = n->total_mass + p->mass;
        if (total > 0) {
            n->cx = (n->cx * n->total_mass + p->px * p->mass) / total;
            n->cy = (n->cy * n->total_mass + p->py * p->mass) / total;
        }
        n->total_mass = total;
        return 1;
    }
    if (!n->divided) subdivide(n);
    for (int c = 0; c < 4; c++) {
        if (insert(n->child[c], index)) return 1;
    }
    return 0;
}

static void calculate_force(const Node *n, int index, double theta, double *fx, double *fy) {
    *fx = 0;
    *fy = 0;
    if (n->total_mass == 0) return;
    if (n->count == 1 && n->particles[0] == index) return;
    const Particle *p = &P[index];
    double dx = n->cx - p->px;
    double dy = n->cy - p->py;
    double distance = sqrt(dx * dx + dy * dy);
    if (!n->divided || (n->bw * 2) / distance < theta) {
        if (distance < SOFTENING) distance = SOFTENING;
        double f = G * p->mass * n->total_mass / (distance * distance);
        *fx = f * dx / distance;
        *fy = f * dy / distance;
        return;
    }
    double sx = 0, sy = 0;
    for (int c = 0; c < 4; c++) {
        if (n->child[c]) {
            double cx, cy;
            calculate_force(n->child[c], index, theta, &cx, &cy);
            sx += cx;
            sy += cy;
        }
    }
    *fx = sx;
    *fy = sy;
}

static void advance_system(int count, double theta, double time_step, int width, int height) {
    Node *root = new_node(width / 2.0, height / 2.0, width / 2.0, height / 2.0);
    for (int i = 0; i < count; i++) insert(root, i);
    for (int i = 0; i < count; i++) {
        double fx, fy;
        calculate_force(root, i, theta, &fx, &fy);
        P[i].ax += fx / P[i].mass;
        P[i].ay += fy / P[i].mass;
    }
    for (int i = 0; i < count; i++) {
        Particle *p = &P[i];
        p->vx += p->ax * time_step;
        p->vy += p->ay * time_step;
        p->px += p->vx * time_step;
        p->py += p->vy * time_step;
        p->ax = 0;
        p->ay = 0;
    }
    free_tree(root);
}

static double system_energy(int count) {
    double energy = 0.0;
    for (int i = 0; i < count; i++) {
        for (int j = i + 1; j < count; j++) {
            double dx = P[i].px - P[j].px, dy = P[i].py - P[j].py;
            double distance = sqrt(dx * dx + dy * dy);
            if (distance < SOFTENING) distance = SOFTENING;
            energy -= G * P[i].mass * P[j].mass / distance;
        }
    }
    for (int i = 0; i < count; i++) {
        double v2 = P[i].vx * P[i].vx + P[i].vy * P[i].vy;
        energy += 0.5 * P[i].mass * v2;
    }
    return energy;
}

static int create_galaxy(int num, double cx, double cy) {
    double radius = 300, spiral_factor = 0.1;
    int n = 0;
    int bulge = (int)(num * 0.3);
    for (int i = 0; i < bulge; i++) {
        double df = (double)i / bulge;
        double r = radius / 5 * df;
        double angle = 2 * PI * i / bulge * 7;
        Particle p = {cx + r * cos(angle), cy + r * sin(angle), 0, 0, 0, 0, 50 + (50 * (1 - df))};
        P[n++] = p;
    }
    int spiral = num - bulge, arms = 2, per_arm = spiral / arms;
    for (int arm = 0; arm < arms; arm++) {
        double base = 2 * PI * arm / arms;
        for (int i = 0; i < per_arm; i++) {
            double df = (double)i / per_arm;
            double distance = radius * (0.2 + 0.8 * df);
            double angle = base + spiral_factor * distance;
            double variation = 0.2 * sin(i * 0.1);
            angle += variation;
            Particle p = {cx + distance * cos(angle), cy + distance * sin(angle), 0, 0, 0, 0, 1 + 9 * (1 - df)};
            P[n++] = p;
        }
    }
    int remaining = spiral - per_arm * arms;
    for (int i = 0; i < remaining; i++) {
        double angle = 2 * PI * i / remaining, distance = radius * 0.5;
        Particle p = {cx + distance * cos(angle), cy + distance * sin(angle), 0, 0, 0, 0, 5.0};
        P[n++] = p;
    }
    for (int i = 0; i < n; i++) {
        double dx = P[i].px - cx, dy = P[i].py - cy;
        double distance = sqrt(dx * dx + dy * dy);
        if (distance > 0) {
            double perp_x = -dy / distance, perp_y = dx / distance;
            double orbital = sqrt(0.1 * (distance + 100)) * 0.3;
            P[i].vx = perp_x * orbital;
            P[i].vy = perp_y * orbital;
        }
    }
    return n;
}

int main(int argc, char **argv) {
    int repeats = repeats_from(argc, argv, 10);
    int num = 200, iterations = 100, width = 1000, height = 800;
    double theta = 0.5, best = 1e30, initial = 0, final_energy = 0, position_sum = 0;
    P = malloc(sizeof(Particle) * num);
    for (int rep = 0; rep < repeats; rep++) {
        int count = create_galaxy(num, width / 2.0, height / 2.0);
        initial = system_energy(count);
        double t0 = now_seconds();
        for (int it = 0; it < iterations; it++) advance_system(count, theta, TIME_STEP, width, height);
        final_energy = system_energy(count);
        double dt = now_seconds() - t0;
        if (dt < best) best = dt;
        position_sum = 0;
        for (int i = 0; i < count; i++) position_sum += P[i].px + P[i].py;
    }
    print_hex("initial_energy", initial);
    print_hex("final_energy", final_energy);
    print_hex("position_sum", position_sum);
    printf("seconds %.9f\n", best);
    free(P);
    return 0;
}
