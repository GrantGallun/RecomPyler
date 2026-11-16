"""Report-first optimization experiments for Python workloads."""

__all__ = ["optimize", "enable", "disable"]


def __getattr__(name):
    # Loaded on first use: the lifter's imports would otherwise add to the start-up
    # of every ``recompyler run``, which may compile nothing.
    if name == "optimize":
        from ._optimize import optimize

        return optimize
    if name in ('enable', 'disable'):
        from .libraries.hook import enable, disable
        return enable if name == 'enable' else disable
    raise AttributeError(f"module 'recompyler' has no attribute {name!r}")

