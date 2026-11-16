"""Export M0.5 LLVM/assembly and static operations against the S75 C target."""
import collections,json,re
from pathlib import Path
import psutil
from llvmlite import binding
from recompyler import heap,_structure_ops_native
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls,specialize_structure_calls
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
folder=Path('matrix/s75-codegen');folder.mkdir(parents=True,exist_ok=True)
binding.initialize_native_target();binding.initialize_native_asmprinter()
target=binding.Target.from_default_triple().create_target_machine(opt=2)
summary={}
for name,fn in [('find',heap._find),('canon',heap._Program.canon)]:
    for lane in ['generic','selected','readonly']:
        graph=build(fn);adapter=None
        if lane!='generic':
            adapter=StructureCalls(CPythonSymbols(),_structure_ops_native)
            graph=specialize_structure_calls(graph,profile_types={op.offset:((dict,object) if op.name=='binary' else (dict,object) if op.name=='contains' else (heap._Cell,)) for block in graph.blocks.values() for op in block.operations})
        result=lower(graph,structure_calls=adapter,readonly_loops=lane=='readonly')
        llvm=str(result.native_module);assembly=target.emit_assembly(result.native_module)
        (folder/f'{name}-{lane}.ll').write_text(llvm)
        (folder/f'{name}-{lane}.asm').write_text(assembly)
        calls=collections.Counter(re.findall(r'call [^@\n]*@([^ (]+)',llvm))
        summary[name+'-'+lane]={'call_sites':dict(calls),'llvm_store_sites':len(re.findall(r'^\s*store ',llvm,re.M)), 'llvm_instruction_count':sum(1 for line in llvm.splitlines() if line.startswith('  ') and not line.lstrip().startswith(';')),'assembly_call_sites':len(re.findall(r'\bcallq?\b',assembly))}
(folder/'static-counts.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps(summary,indent=2))
# Reference machine listing is compiled only, never installed for semantic use.
import setuptools
from setuptools._distutils.sysconfig import customize_compiler
compiler=setuptools.distutils.ccompiler.new_compiler();customize_compiler(compiler)
compiler.force=True;compiler.compile(['matrix/s75-reference/rpspike.c'],output_dir=str(folder/'reference'),include_dirs=[__import__('sysconfig').get_path('include')],extra_postargs=['/O2','/GL-','/FAs','/Fa'+str((folder/'reference.asm').resolve())])
print('REFERENCE_ASSEMBLY',folder/'reference.asm')
