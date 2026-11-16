"""Shared bytecode IR; importing native entry support does not load LLVM."""

_EXPORTS = {
    'build': '.builder', 'build_code': '.builder',
    'verify': '.verifier', 'PassManager': '.passes',
    'UnsupportedBytecode': '.builder', 'VerificationError': '.verifier',
    'compile_function': '.compiler', 'compilation_info': '.compiler',
}
__all__ = list(_EXPORTS)


def __getattr__(name):
    if name not in _EXPORTS:
        raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
    from importlib import import_module
    value = getattr(import_module(_EXPORTS[name], __name__), name)
    globals()[name] = value
    return value


def __dir__():
    return sorted(set(globals()) | set(__all__))
