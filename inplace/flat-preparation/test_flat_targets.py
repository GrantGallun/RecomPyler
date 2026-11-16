from array import array
import struct
import pytest
from recompyler._flat import FlatLifted
from target_support import spectral,fft

def bits(v):return struct.pack("!d",v)

def test_original_spectral_parts_exact_and_native():
 ns=spectral()
 for name in ("part_A_times_u","part_At_times_u"):
  fn=ns[name];w=FlatLifted(fn)
  for values in ([1]*130,[float(i)/130 for i in range(130)]):
   for index in (0,64,129):
    want=fn((index,values));got=w((index,values))
    print(name,index,type(values[0]).__name__,w.problem,w.flat_calls,w.last_audit,flush=True)
    assert type(got) is type(want) and bits(got)==bits(want)
    assert w.fallback_calls==0 and w.last_audit["commits"]==1,w.problem
  assert w.flat_calls==6

def test_original_fft_exact_writable_buffer_native():
 ns=fft()
 for name in ("FFT_transform","FFT_inverse"):
  fn=ns[name];w=FlatLifted(fn)
  for n in (32,2048):
   initial=ns["Random"](7).RandomVector(n)
   want=array("d",initial);got=array("d",initial)
   expected=fn(n,want);actual=w(n,got)
   print(name,n,w.problem,w.flat_calls,w.last_audit,flush=True)
   assert actual is expected is None
   assert want.tobytes()==got.tobytes()
   assert w.fallback_calls==0 and w.last_audit["commits"]==1,w.problem
   got.append(1.0)
  assert w.flat_calls==2
