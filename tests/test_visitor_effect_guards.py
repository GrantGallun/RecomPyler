import ast
from recompyler._visitors import lift_visitors
from recompyler.managed import lift_managed

CHECK_KIND=ast.Name
class Rebinder:
    def __iter__(self):
        globals()['CHECK_KIND']=ast.Constant
        return iter(())
TRIGGER=Rebinder()

def callback_before_local_helper(node):
    list(TRIGGER)
    def visit(item):return isinstance(item,CHECK_KIND)
    return visit(node)


def test_callback_after_entry_does_not_keep_old_class_binding():
    global CHECK_KIND
    node=ast.Name(id='owner')
    CHECK_KIND=ast.Name;expected=callback_before_local_helper(node)
    CHECK_KIND=ast.Name
    try:
        native=lift_visitors(callback_before_local_helper)
        assert native(node)==expected
    finally:CHECK_KIND=ast.Name


def test_unknown_callback_protocol_uses_general_compiled_parent():
    global CHECK_KIND
    node=ast.Name(id='owner');CHECK_KIND=ast.Name
    try:
        fast=lift_managed(callback_before_local_helper)
        assert fast(node) is False
        assert fast.compiled_calls==1 and fast.fallback_calls==0
    finally:CHECK_KIND=ast.Name


def hashing_before_class_test(node):
    found=set()
    def visit(item):
        found.add(item)
        return isinstance(item,CHECK_KIND)
    return visit(node)


def test_custom_ast_hash_cannot_invalidate_read_only_entry_proof():
    global CHECK_KIND
    node=ast.Name(id='owner');had='__hash__' in vars(ast.Name);previous=vars(ast.Name).get('__hash__')
    def changed_hash(item):
        globals()['CHECK_KIND']=ast.Constant
        return id(item)
    try:
        ast.Name.__hash__=changed_hash
        CHECK_KIND=ast.Name;expected=hashing_before_class_test(node)
        CHECK_KIND=ast.Name;native=lift_visitors(hashing_before_class_test)
        assert CHECK_KIND is ast.Name
        assert native(node)==expected is False
        assert native.compiled_calls==0 and native.fallback_calls==1
    finally:
        CHECK_KIND=ast.Name
        if had:ast.Name.__hash__=previous
        else:del ast.Name.__hash__
