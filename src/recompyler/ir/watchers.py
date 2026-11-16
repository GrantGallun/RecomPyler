"""Mutation-driven dependencies for native IR entries.

Subscriptions retain dictionaries until close/GC; types are weak dependencies.
A mutation or type destruction permanently invalidates a subscription. No Python code runs in mutation callbacks.
"""
from .symbols import require_runtime


def watch_dependencies(*, dicts=(), types=()):
    require_runtime()
    from . import _watchers_native
    return _watchers_native.watch(tuple(dicts), tuple(types))
