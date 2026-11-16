"""Positive shared-layer consumer queries; no private source analysis."""
from pathlib import Path
import runpy,sys
import pytest
from recompyler import provenance as p

class Record:
    def read(self):return self.value
    def store(self,value):
        self.value=value
        return self

@pytest.mark.parametrize('fn',[Record.read,Record.store])
def test_original_record_method_has_source_bound_summary(fn):
    summary=p.analyze(fn)
    assert summary.valid,summary.reason

@pytest.mark.parametrize('name',['Task.qpkt','DeviceTask.fn','HandlerTask.fn','Task.runTask'])
def test_real_s46_richards_method_has_source_bound_summary(name):
    clone=Path(__file__).resolve().parents[2]
    sys.path.insert(0,str(clone/'inplace/s46-ten-components-v8/shim'))
    namespace=runpy.run_path(str(clone/'inplace/s46-ten-components-v8/richards_super/input/run_benchmark.py'),run_name='wave16_method_source_test')
    owner,member=name.split('.');fn=getattr(namespace[owner],member)
    summary=p.analyze(fn)
    assert summary.valid,summary.reason
