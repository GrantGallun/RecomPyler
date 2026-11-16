"""Cold imports must not execute unrelated object protocols."""
import importlib,sys
from recompyler.libraries.hook import enable,disable
from recompyler.libraries.cache import DecisionCache


def test_module_enumeration_does_not_request_instance_class(tmp_path,monkeypatch):
    name='fixture_instance_class_lib'
    (tmp_path/(name+'.py')).write_text('events=[]\nclass Value:\n @property\n def __class__(self):\n  events.append("class")\n  raise RuntimeError("instance class callback")\nvalue=Value()\n')
    monkeypatch.syspath_prepend(str(tmp_path))
    session=enable(packages=(name,),cache=DecisionCache(tmp_path/'cache',compiler_tag='instance'))
    try:
        module=importlib.import_module(name)
        assert module.events==[]
    finally: disable();sys.modules.pop(name,None)


def test_import_with_deleted_module_name_does_not_call_getattr(tmp_path,monkeypatch):
    name='fixture_deleted_name_lib'
    (tmp_path/(name+'.py')).write_text('events=[]\ndel __name__\ndef __getattr__(name):\n events.append(name)\n raise AttributeError(name)\n')
    monkeypatch.syspath_prepend(str(tmp_path))
    enable(packages=(name,),cache=DecisionCache(tmp_path/'cache',compiler_tag='deleted-name'))
    try:
        module=importlib.import_module(name)
        assert module.events==[]
    finally: disable();sys.modules.pop(name,None)


def test_large_integer_timings_are_finite_and_do_not_crash_receipts(tmp_path):
    def target(): return 1
    cache=DecisionCache(tmp_path,compiler_tag='large-finite')
    cache.record(target,calls=100,cpython_ns=10**400,native_ns=10**399,verified=True)
    assert cache.eligible(target)


def test_enumeration_releases_unrelated_values_before_receipt_io(tmp_path):
    import gc,types,weakref
    name='fixture_incidental_lifetime_lib'
    module=types.ModuleType(name)
    exec('class Payload: pass\nresource=Payload()\ndef f(): return 1\n',module.__dict__)
    reference=weakref.ref(module.resource)
    observed=[]
    class WatchingCache(DecisionCache):
        def receipt(self,function):
            if not observed:
                del module.resource
                gc.collect()
            observed.append(reference() is None)
            return None
    sys.modules[name]=module
    try:
        enable(packages=(name,),cache=WatchingCache(tmp_path/'cache',compiler_tag='lifetime'))
        assert observed and all(observed),'import enumeration retained unrelated module values across receipt I/O'
    finally: disable();sys.modules.pop(name,None)
