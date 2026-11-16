"""Load shared cases, treating frozen experiment scripts as source witnesses.

The *_pending.py and *[-_]red.py files are peer experiments with arbitrary
module-level setup, not executable corpus fixtures. Their original function
bodies still receive provenance analysis with unavailable globals left unknown.
"""
import ast
import importlib.util
import types


def load_corpus_module(path):
    if path.name.endswith(('_pending.py', '_red.py', '-red.py')):
        tree = ast.parse(path.read_text(encoding='utf-8-sig'), str(path))
        definitions = []
        for node in tree.body:
            if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                continue
            for value in node.args.defaults + [v for v in node.args.kw_defaults if v is not None]:
                ast.literal_eval(value)
            node.decorator_list = []
            definitions.append(node)
        module = types.ModuleType(path.stem)
        exec(compile(ast.Module(body=definitions, type_ignores=[]), str(path), 'exec'), module.__dict__)
        return module
    spec = importlib.util.spec_from_file_location(path.stem, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module
