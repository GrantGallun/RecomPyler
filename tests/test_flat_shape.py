from array import array
import pytest
native=pytest.importorskip("recompyler._flat_native")

@pytest.mark.parametrize("args,want",[
 (([1.25],),b"(F)"),(([1],),b"(I)"),(([],),b"(F)"),
 (((64,[1.25]*130),),b"((iF))"),((array("d",[1.25]),0,-0.0),b"(Dif)"),
 ((array("d"),None,True),b"(Dnb)"),(([1.0],-(2**63),2**63-1),b"(Fii)"),
 (([1.0],2**63),None),(([True],),None),(([1.0],[2.0]),None),
 ((array("i",[1]),),None),((array("f",[1.0]),),None),((array("w","x"),),None),
 ((1.25,),None),((None,),None),((object(),[1.0]),None),
])
def test_exact_native_shape_selection(args,want):
 assert native.shape(args)==want


def test_shape_does_not_walk_unaccessed_list_elements():
 class Unread:
  def __getattribute__(self,name):raise AssertionError("unread hook")
 assert native.shape(([1.25,Unread()],))==b"(F)"


def test_shape_declines_recursive_deep_or_oversize_tuple_tree():
 deep=[1.25]
 for _ in range(18):deep=(deep,)
 assert native.shape((deep,)) is None
 assert native.shape(tuple([1.25] for _ in range(80))) is None


def test_shape_export_is_released_on_supported_and_declined_arrays():
 for code in ('d','f','i','w'):
  values=array(code)
  native.shape((values,))
  values.append('x' if code=='w' else 1)


def test_native_import_refuses_python_array_name_imposter():
 import subprocess,sys
 code="""import array,importlib.util,sys
class Imposter:
    def __buffer__(self,flags):raise AssertionError('application buffer hook')
array.array=Imposter
spec=importlib.util.spec_from_file_location('_flat_native',sys.argv[1])
try:importlib.util.module_from_spec(spec)
except ImportError:pass
else:raise AssertionError('admitted application class as builtin array.array')
"""
 result=subprocess.run([sys.executable,'-c',code,native.__file__],capture_output=True,text=True)
 assert result.returncode==0,result.stderr
