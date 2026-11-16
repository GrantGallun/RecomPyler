import importlib,json,sys
sys.path[:0]=sys.argv[1:3]
assert 'numba' not in sys.modules
module=importlib.import_module('wave17_unicode_bridge')
for fn in [module.dedent_boxed,module.dedent_borrowed]:
    assert fn('  a\n  \u03a9\n  \U0001f600')=='a\n\u03a9\n\U0001f600'
    value='unchanged';assert fn(value) is value
    try:fn(None)
    except TypeError as exc:assert 'expected str object' in str(exc)
    else:raise AssertionError('missing error')
assert 'numba' not in sys.modules
print(json.dumps({'unicode_aot_success_error_identity_no_numba':True}))
