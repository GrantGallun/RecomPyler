"""A recurrence whose number type is chosen by a flag: --exact keeps it in integers."""

import argparse


def walk(position, step, n):
    total = position
    for _ in range(n):
        position = (position * 3 + step) % 1000003
        total += position
    return total


def scaled(values, factor):
    return [value * factor for value in values]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--exact", action="store_true", help="use integers instead of floats")
    parser.add_argument("--rounds", type=int, default=3000)
    args = parser.parse_args()
    start = 1 if args.exact else 1.0
    step = 7 if args.exact else 7.0
    total = 0
    for k in range(args.rounds):
        total += walk(start + k, step, 400)
    print(total, scaled([1, 2], args.rounds))
