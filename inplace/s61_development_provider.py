"""Explicit unaccepted sibling injection for development, never full-suite use."""
import importlib.util
from pathlib import Path
import sys
import recompyler
workspace = Path(__file__).resolve().parents[2]
for peer in ('wave17-matrix', 'wave18-lift'):
    path = str(workspace / peer / 'src/recompyler')
    if path not in recompyler.__path__:recompyler.__path__.append(path)
from recompyler import provenance
if not hasattr(provenance, 'bind_source'):
    path = workspace / 'wave17-matrix/src/recompyler/provenance.py'
    spec = importlib.util.spec_from_file_location('recompyler.provenance', path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    recompyler.provenance = module
    spec.loader.exec_module(module)
