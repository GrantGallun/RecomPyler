"""Ahead-of-time compilation into extension modules, vendored from ``numba.pycc``.

Copied from Numba 0.65.1 (BSD 2-clause licence, see LICENSE.numba), because Numba
has deprecated ``numba.pycc``. Changes: relative imports; ``modulemixin.c`` includes
Numba's headers by name, with the installed Numba package added to the include path,
and Numba's C runtime sources are compiled from the installed package; the
deprecated ``export``/``exportmany`` decorators and the deprecation warning are left
out. It still uses Numba's compiler and runtime, which are not deprecated.
"""

from .cc import CC

__all__ = ["CC"]
