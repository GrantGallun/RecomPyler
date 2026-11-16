"""Native T1 entry imports must not pay for an unused LLVM compiler."""
import subprocess
import sys
import pytest


@pytest.mark.slow
@pytest.mark.parametrize('statement', [
    'import recompyler.ir as package; assert set(package.__all__) <= set(dir(package))',
    'from recompyler.ir import _entry_native; assert callable(_entry_native._install_callback_free_entry)',
])
def test_ir_and_native_entry_import_without_llvm(statement):
    subprocess.run([sys.executable,'-c',statement+"; import sys; assert 'llvmlite' not in sys.modules; assert 'recompyler.ir.compiler' not in sys.modules"],check=True)


def test_lazy_public_exports_are_the_existing_objects():
    import recompyler.ir as package
    from recompyler.ir import builder, verifier, passes, compiler
    expected={'build':builder.build,'build_code':builder.build_code,
              'UnsupportedBytecode':builder.UnsupportedBytecode,'verify':verifier.verify,
              'VerificationError':verifier.VerificationError,'PassManager':passes.PassManager,
              'compile_function':compiler.compile_function,'compilation_info':compiler.compilation_info}
    assert set(package.__all__)==set(expected)
    for name,value in expected.items():
        assert getattr(package,name) is value
        assert getattr(package,name) is value
    with pytest.raises(AttributeError):getattr(package,'not_a_public_export')
