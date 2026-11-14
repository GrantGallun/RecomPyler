"""Report-first optimization experiments for Python workloads."""

__all__ = ["optimize"]


def __getattr__(name):
    # Loaded on first use: the lifter's imports would otherwise add to the start-up
    # of every ``recompyler run``, which may compile nothing.
    if name == "optimize":
        from ._optimize import optimize

        return optimize
    raise AttributeError(f"module 'recompyler' has no attribute {name!r}")
