"""Real original frames retain mortal COPY retirement and error state."""
import sys
from functools import partial
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive


def install(function,args):
 body=lower(build(function),frame_entry=True);owner=Keepalive(body)
 handle=install_frame_entry(function,owner.address,owner,seed_arguments=args)
 owner.lowered=body.execution_owner
 return owner,handle


def owned(make,right):
 mapping={'key':None}
 return right is make() is right,mapping


def case_owned_copy():
 events=[];right=object()
 class Marker:
  def __del__(self):
   frame=sys._getframe(1)
   events.append((frame.f_code is owned.__code__,frame.f_lasti,frame.f_locals.get('right') is right))
 def make():return Marker()
 expected=owned(make,right);gold=events.copy();events.clear()
 owner,handle=install(owned,(make,right));target=partial(owned)
 try:
  for _ in range(4):
   assert target(make,right)==expected
   assert events==gold;events.clear()
  assert owner.calls.value==4
 finally:handle.close()


def erroneous(value,callback):
 mapping={'key':value}
 flag=value is None
 callback()
 return flag,mapping


def case_error():
 marker=object();error=LookupError('tagged error')
 def fail():raise error
 owner,handle=install(erroneous,(marker,None))
 try:
  try:partial(erroneous)(marker,fail)
  except LookupError as caught:
   assert caught is error and owner.calls.value==1
   tb=caught.__traceback__
   while tb and tb.tb_frame.f_code is not erroneous.__code__:tb=tb.tb_next
   assert tb is not None
   assert tb.tb_frame.f_locals['mapping']['key'] is marker
   assert tb.tb_frame.f_locals['flag'] is False
   del tb;error.__traceback__=None
  else:raise AssertionError('missing original error')
 finally:handle.close()

if __name__=='__main__':
 name=sys.argv[1];globals()['case_'+name]();print('PASS '+name,flush=True)
