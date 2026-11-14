"""The vendored compiler must keep objects in the requested build directory."""
import os
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

try:
    from recompyler._pycc import platform
except ImportError:
    platform = None


ROOT = Path(__file__).resolve().parents[1]


@unittest.skipIf(platform is None, "optional AOT dependencies unavailable")
class ToolchainPathTests(unittest.TestCase):
    def test_absolute_and_relative_sources_compile_inside_output(self):
        # On Windows these roots deliberately use the system temp drive and the
        # checkout drive, respectively. No process-wide chdir is needed.
        with tempfile.TemporaryDirectory() as source_dir, tempfile.TemporaryDirectory(dir=ROOT) as build_dir:
            source = Path(source_dir)
            out = Path(build_dir)
            for name in ("one", "two"):
                (source / name).mkdir()
                (source / name / "sibling.h").write_text("#define SIBLING 7\n", encoding="utf-8")
            (out / "includes").mkdir()
            header = out / "includes" / "extra.h"
            header.write_text("#define EXTRA 3\n", encoding="utf-8")
            body = ('#include "sibling.h"\n#include <extra.h>\n'
                    '#if SIBLING != 7 || EXTRA != 3 || ENABLED != 9 || defined(DISABLED)\n'
                    '#error compiler options or quoted includes were lost\n#endif\n'
                    'int value(void) { return SIBLING + EXTRA + ENABLED; }\n')
            paths = [source / "one" / "same.c", source / "two" / "same.c",
                     source / "one" / "same.cpp", out / "relative.c"]
            for path in paths:
                path.write_text(body if path != paths[-1] else "int relative(void) { return 1; }\n",
                                encoding="utf-8")
            # Avoid the compiler probe here so this specifically tests compilation.
            with patch.object(platform, "external_compiler_works", return_value=True):
                toolchain = platform.Toolchain()
            original = toolchain._compiler.object_filenames

            def checked_names(*args, **kwargs):
                names = original(*args, **kwargs)
                for name in names:
                    self.assertTrue(Path(name).resolve().is_relative_to(out), name)
                return names

            cwd = Path.cwd()
            relative = os.path.relpath(paths[-1], cwd)
            with patch.object(toolchain._compiler, "object_filenames", checked_names):
                objects = toolchain.compile_objects(
                    [str(path) for path in paths[:-1]] + [relative], str(out),
                    include_dirs=[str(header.parent)], depends=[str(header)],
                    macros=[("ENABLED", "9"), ("DISABLED",)])
                self.assertIs(toolchain._compiler.object_filenames, checked_names)
            self.assertEqual(Path.cwd(), cwd)
            self.assertEqual(len(set(objects)), 4)
            for obj in objects:
                self.assertTrue(Path(obj).is_file(), obj)
                self.assertTrue(Path(obj).resolve().is_relative_to(out), obj)
            self.assertEqual([path.read_text(encoding="utf-8") for path in paths],
                             [body, body, body, "int relative(void) { return 1; }\n"])

    def test_failed_compile_restores_compiler_object_naming(self):
        with patch.object(platform, "external_compiler_works", return_value=True):
            toolchain = platform.Toolchain()
        original = toolchain._compiler.object_filenames
        with tempfile.TemporaryDirectory(dir=ROOT) as folder:
            with self.assertRaises(platform.setuptools.distutils.errors.UnknownFileError):
                toolchain.compile_objects([str(Path(folder) / "source.invalid")], folder)
        self.assertNotIn("object_filenames", toolchain._compiler.__dict__)
        self.assertEqual(toolchain._compiler.object_filenames, original)

    def test_compiler_probe_outputs_are_local_and_cleaned(self):
        compiler = platform.new_compiler()
        compile_original = compiler.compile
        outputs = []
        folders = []

        def checked_compile(sources, output_dir=None, **kwargs):
            folder = Path(sources[0]).parent
            folders.append(folder)
            self.assertEqual(Path(output_dir), folder)
            # Assert containment before the real compiler can create directories.
            names_original = compiler.object_filenames

            def checked_names(*args, **options):
                names = names_original(*args, **options)
                for name in names:
                    self.assertTrue(Path(name).resolve().is_relative_to(folder), name)
                return names

            with patch.object(compiler, "object_filenames", checked_names):
                result = compile_original(sources, output_dir=output_dir, **kwargs)
            outputs.extend(result)
            self.assertTrue(all(Path(path).is_file() for path in result))
            return result

        platform.external_compiler_works.cache_clear()
        try:
            with patch.object(platform, "new_compiler", return_value=compiler), patch.object(
                    compiler, "compile", checked_compile):
                self.assertTrue(platform.external_compiler_works())
            self.assertEqual(len(outputs), 2)  # C and C++ both really compiled.
            self.assertTrue(all(not Path(path).exists() for path in outputs))
            self.assertTrue(all(not folder.exists() for folder in folders))
        finally:
            platform.external_compiler_works.cache_clear()


if __name__ == "__main__":
    unittest.main()
