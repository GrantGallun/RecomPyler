"""Holds the record classes that lifted functions generate.

Numba's disk cache stores a compiled function's types by module and name, so the
classes need an importable home. ``recompyler.lift`` adds them here as it builds.
"""
