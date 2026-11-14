"""Independent calls of one numeric function, written the ways scripts usually write them."""

from concurrent.futures import ThreadPoolExecutor
import multiprocessing


def advance_particle(position, velocity, dt):
    for _ in range(128):
        velocity += (-9.81 - 0.04 * velocity) * dt
        position += velocity * dt
        if position < 0.0:
            position = -position
            velocity *= -0.7
    return position


def bounce(start):
    return advance_particle(start, 0.5, 0.01)


if __name__ == "__main__":
    n = 200_000
    heights = [advance_particle(i / n, 0.5, 0.01) for i in range(n)]
    total = sum(advance_particle(i / n, -0.25, 0.02) for i in range(n))
    starts = [i / n for i in range(n)]
    with multiprocessing.Pool(4) as pool:
        pooled = pool.map(bounce, starts, chunksize=4096)
    with ThreadPoolExecutor(4) as executor:
        threaded = list(executor.map(advance_particle, starts, [0.5] * n, [0.01] * n))
    print(f"{sum(heights):.12f} {total:.12f} {sum(pooled):.12f} {sum(threaded):.12f}")
