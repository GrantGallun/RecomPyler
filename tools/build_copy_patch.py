"""Build immutable Windows x64 T1 stencils using the existing local LLVM 19.

Run with the target interpreter. CPython's own COFF parser is a build dependency,
not vendored runtime code. All compiler processes are serial. No tools download.
"""
import argparse
import asyncio
import ctypes
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


async def build(options):
    fork = options.cpython.resolve()
    tools = fork/'externals/llvm-19.1.7.0/bin'
    compiler = tools/'clang.exe'
    for name in ('clang.exe', 'llvm-readobj.exe', 'llvm-objdump.exe'):
        if not (tools/name).is_file():
            raise SystemExit('DEVIATION: missing local LLVM 19 tool: ' + str(tools/name))
    version = subprocess.check_output([str(compiler), '--version'], text=True).splitlines()[0]
    if 'version 19.' not in version:
        raise SystemExit('LLVM 19 required')
    os.environ['EXTERNALS_DIR'] = str(fork/'externals')
    sys.path.insert(0, str(fork/'Tools/jit'))
    import _targets
    import _stencils
    target = _targets.get_target('x86_64-pc-windows-msvc')
    source = ROOT/'src/recompyler/stencils/templates.c'
    options.work.mkdir(parents=True, exist_ok=True)
    stencils = {}
    for name in ('entry', 'arg', 'const', 'return'):
        obj = options.work/(name+'.obj')
        command = [str(compiler), '--target=x86_64-pc-windows-msvc', '-DNDEBUG',
            '-DRP_'+name.upper(), '-I'+str(options.config.resolve()),
            '-I'+str(options.include.resolve()), '-O2', '-c',
            '-fno-asynchronous-unwind-tables', '-fno-builtin', '-fno-plt',
            '-fno-stack-protector', '-fms-runtime-lib=dll', '-std=c11',
            '-o', str(obj), str(source)]
        subprocess.run(command, check=True)
        group = await target._parse(obj)
        if group.code.holes:
            group.process_relocations({}, alignment=1, nop=b'')
        elif group.data.holes:
            raise ValueError('data-only relocations require explicit processing')
        holes = []
        for section in ('code', 'data'):
            stencil = getattr(group, section)
            for hole in stencil.holes:
                kind = {'IMAGE_REL_AMD64_REL32': 'rel32', 'R_X86_64_64': 'abs64'}[hole.kind]
                addend = _stencils._signed(hole.addend) + (4 if kind == 'rel32' else 0)
                source_name = {'CODE': '$code', 'DATA': '$data', 'CONTINUE': '$next',
                    'OPERAND0': 'operand0', 'OPERAND1': 'operand1', 'ZERO': 'zero'}[hole.value.name]
                if hole.symbol:
                    if hole.value.name != 'ZERO':
                        raise ValueError('unsupported combined symbolic relocation')
                    source_name = 'external:'+hole.symbol
                holes.append(dict(section=section, offset=hole.offset, kind=kind,
                    source=source_name, addend=addend))
        stencils[name] = dict(code=bytes(group.code.body).hex(),
            data=bytes(group.data.body).hex(), holes=holes)
        (options.work/(name+'.asm')).write_text('\n'.join(group.code.disassembly))
    document = dict(schema=1, runtime=sys.version, platform=sys.platform,
        pointer_bits=ctypes.sizeof(ctypes.c_void_p)*8, compiler=version,
        source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(), stencils=stencils)
    document['digest'] = hashlib.sha256(encoded(document)).hexdigest()
    name = hashlib.sha256(sys.version.encode()).hexdigest()[:16]+'.json'
    output = ROOT/'src/recompyler/stencils'/name
    output.write_text(json.dumps(document, sort_keys=True, indent=2)+'\n', encoding='utf-8')
    print(output)
    print({name: (len(bytes.fromhex(s['code'])), len(s['holes'])) for name,s in stencils.items()})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cpython', type=Path, required=True)
    parser.add_argument('--include', type=Path, required=True)
    parser.add_argument('--config', type=Path, required=True)
    parser.add_argument('--work', type=Path, default=ROOT/'.cache/t1-build')
    options = parser.parse_args()
    if sys.platform != 'win32' or ctypes.sizeof(ctypes.c_void_p) != 8:
        parser.error('Windows x64 interpreter required')
    ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
    asyncio.run(build(options))


if __name__ == '__main__': main()
