"""Map independently audited successful AOT exports to actual loaded PE wrappers.

No kernel executes. Assembly tooling consumes artifact hashes and wrapper RVAs;
profiling JIT cache LLVM is never relabeled as this AOT artifact's LLVM.
"""
import argparse
import ctypes
import hashlib
import importlib
import json
from pathlib import Path
import struct
import sys


def map_artifact(plan_path, audit_path):
    data = json.loads(plan_path.read_text())
    audit = json.loads(audit_path.read_text())
    if not audit.get('compiled_total_reconciles') or audit['totals']['unknown_native_calls']:
        raise ValueError('An independently reconciled actual-mode audit is required.')
    selected = []
    for function in audit['functions']:
        for digest, calls in function.get('programs', {}).items():
            if not calls.get('aot_calls'):
                continue
            for section_name in ('aot_regions',):
                section = data.get('plan', {}).get(section_name, {})
                for row in section.get('functions', []):
                    if row.get('qualname', row['function']) == function['function'] and digest in row.get('exports', {}):
                        selected.append((section, row['exports'][digest], digest, function['function'], calls['aot_calls']))
    if not selected:
        raise ValueError('No successfully executed region AOT export found; do not infer it from artifact availability.')
    result = []
    get_fn = ctypes.pythonapi.PyCFunction_GetFunction
    get_fn.argtypes, get_fn.restype = [ctypes.py_object], ctypes.c_void_p
    kernel32 = ctypes.WinDLL('kernel32', use_last_error=True)
    module_handle = kernel32.GetModuleHandleW
    module_handle.argtypes, module_handle.restype = [ctypes.c_wchar_p], ctypes.c_void_p
    for section, export, digest, function, calls in selected:
        folder = Path(section['folder']).resolve()
        matches = list(folder.glob(section['module'] + '*.pyd'))
        if len(matches) != 1:
            raise ValueError('Need one exact Windows AOT artifact: ' + str(matches))
        artifact = matches[0]
        sys.path.insert(0, str(folder))
        try:
            module = importlib.import_module(section['module'])
        finally:
            sys.path.pop(0)
        base = module_handle(str(artifact)) or module_handle(artifact.name)
        if not base:
            raise OSError('Loaded module image base unavailable.')
        wrapper_rva = get_fn(getattr(module, export)) - base
        binary = artifact.read_bytes()
        pe = struct.unpack_from('<I', binary, 0x3c)[0]
        optional = pe + 24
        preferred = struct.unpack_from('<Q', binary, optional + 24)[0]
        result.append({'function': function, 'actual_aot_calls_in_audit': calls, 'selected_digest': digest,
            'selected_export': export, 'artifact': str(artifact), 'artifact_sha256': hashlib.sha256(binary).hexdigest(),
            'wrapper_rva': hex(wrapper_rva), 'preferred_image_base': hex(preferred),
            'wrapper_preferred_address': hex(preferred + wrapper_rva),
            'plan': str(plan_path), 'plan_sha256': hashlib.sha256(plan_path.read_bytes()).hexdigest(),
            'audit': str(audit_path), 'audit_sha256': hashlib.sha256(audit_path.read_bytes()).hexdigest(),
            'limitations': ['Wrapper address maps the actual measured artifact; follow its machine call targets to identify the internal body.',
                            'Static instruction/pattern counts do not measure cycles or establish hot-path frequency.',
                            'No kernel executed, compiled, profiled or timed by this mapping script.']})
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--plan', required=True, type=Path)
    parser.add_argument('--audit', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(map_artifact(args.plan.resolve(), args.audit.resolve()), indent=2) + '\n')
