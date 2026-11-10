"""A normal Python script with a numeric helper for the profiler to discover."""


def advance_particle(position, velocity, dt):
    for _ in range(128):
        velocity += (-9.81 - 0.04 * velocity) * dt
        position += velocity * dt
        if position < 0.0:
            position = -position
            velocity *= -0.7
    return position


if __name__ == "__main__":
    total = sum(advance_particle(i / 1000, 0.5, 0.01) for i in range(5_000))
    print(f"Total final height: {total:.6f}")
