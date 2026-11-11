"""Verify and time the public optimization API on the particle workload."""

import json

from recompyler import optimize
from workload import advance_particle


if __name__ == "__main__":
    rows = [(index / 1000, 0.5, 0.01) for index in range(512)]
    fast = optimize(advance_particle, samples=rows)
    assert fast.map(rows) == [advance_particle(*row) for row in rows]
    assert fast(10.0, 1.0, 0.02) == advance_particle(10.0, 1.0, 0.02)
    print(json.dumps(fast.report, indent=2))
