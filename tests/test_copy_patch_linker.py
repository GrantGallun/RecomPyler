"""Copy-and-patch linking is bounded, symbolic, and independent of LLVM."""
import struct
import pytest


def api():
    from recompyler.copy_patch import Hole, Stencil, Operation, Target, Symbol, link
    return Hole, Stencil, Operation, Target, Symbol, link


def test_final_pass_resolves_forward_backward_and_data_relocations():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    jump=Stencil(b'\xe9'+bytes(4),bytes(8),(
        Hole('code',1,'rel32','target'),Hole('data',0,'abs64','literal')))
    last=Stencil(b'\xc3',b'',())
    image=link([Operation(jump,{'target':Target('end'),'literal':Symbol('value')},'start'),
                Operation(jump,{'target':Target('start'),'literal':17},'middle'),
                Operation(last,{},'end')],base=0x100000000,symbols={'value':0x123456789abcdef0})
    assert image.code_size==11
    assert struct.unpack_from('<i',image.body,1)[0]==5
    assert struct.unpack_from('<i',image.body,6)[0]==-10
    assert struct.unpack_from('<Q',image.body,image.data_offsets[0])[0]==0x123456789abcdef0
    assert struct.unpack_from('<Q',image.body,image.data_offsets[1])[0]==17
    assert image.labels['end']==0x10000000a
    assert image.patches==4


def test_symbolic_image_can_be_relocated_in_two_engines_without_mutation():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    template=Stencil(bytes(16),b'constant',(
        Hole('code',0,'abs64','$data'),Hole('code',8,'abs64','callee')))
    program=[Operation(template,{'callee':Symbol('helper')},0)]
    first=link(program,base=0x1000,symbols={'helper':0x7000})
    second=link(program,base=0x8000,symbols={'helper':0x9000})
    assert struct.unpack_from('<QQ',first.body)==(0x1010,0x7000)
    assert struct.unpack_from('<QQ',second.body)==(0x8010,0x9000)
    assert template.code==bytes(16)


def test_next_hole_targets_next_code_not_interleaved_readonly_data():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    first=Stencil(bytes(8),bytes(16),(Hole('code',0,'abs64','$next'),))
    terminal=Stencil(b'\xc3',b'',())
    image=link([Operation(first,{}),Operation(terminal,{})],base=0x2000)
    assert struct.unpack_from('<Q',image.body)[0]==0x2008
    assert image.data_offsets[0]>=image.code_size


@pytest.mark.parametrize('holes',[
    lambda Hole:(Hole('code',1,'abs64','x'),),
    lambda Hole:(Hole('code',0,'abs64','x'),Hole('code',4,'rel32','y')),
    lambda Hole:(Hole('unknown',0,'abs64','x'),),
])
def test_out_of_bounds_or_overlapping_holes_are_rejected_before_linking(holes):
    Hole, Stencil, Operation, Target, Symbol, link = api()
    with pytest.raises(ValueError):Stencil(bytes(8),b'',holes(Hole))


def test_missing_labels_duplicate_labels_and_far_relative_targets_decline():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    template=Stencil(bytes(4),b'',(Hole('code',0,'rel32','to'),))
    with pytest.raises(ValueError,match='label'):
        link([Operation(template,{'to':Target('missing')},0)],base=0x1000)
    with pytest.raises(ValueError,match='duplicate'):
        link([Operation(template,{'to':0},0),Operation(template,{'to':0},0)],base=0)
    with pytest.raises(ValueError,match='rel32'):
        link([Operation(template,{'to':1<<40})],base=0)
    next_template=Stencil(bytes(8),b'',(Hole('code',0,'abs64','$next'),))
    with pytest.raises(ValueError,match='successor'):
        link([Operation(next_template,{})],base=0)


def test_binding_validation_never_invokes_user_conversion_or_retains_mutable_map():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    class Value:
        def __index__(self):raise AssertionError('user conversion executed')
    template=Stencil(bytes(8),b'',(Hole('code',0,'abs64','value'),))
    with pytest.raises(TypeError):Operation(template,{'value':Value()})
    bindings={'value':3};operation=Operation(template,bindings);bindings['value']=4
    assert struct.unpack_from('<Q',link([operation],base=0).body)[0]==3
    with pytest.raises(ValueError):link([Operation(template,{'value':-1})],base=0)


def test_link_work_counts_scale_with_operations_and_patches():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    template=Stencil(bytes(8),b'',(Hole('code',0,'abs64','value'),))
    a=link([Operation(template,{'value':n},n) for n in range(128)],base=0)
    b=link([Operation(template,{'value':n},n) for n in range(256)],base=0)
    assert (b.operations,b.patches,b.copied_bytes)==tuple(2*x for x in (a.operations,a.patches,a.copied_bytes))


def test_absolute_overflow_and_image_limit_are_rejected():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    template=Stencil(bytes(8),b'',(Hole('code',0,'abs64','value',1),))
    with pytest.raises(ValueError,match='abs64'):
        link([Operation(template,{'value':(1<<64)-1})],base=0)
    with pytest.raises(ValueError,match='image'):
        link([Operation(Stencil(bytes(16),b'',()),{})],base=0,max_bytes=8)


def test_relocation_metadata_never_calls_user_equality_and_negative_targets_reject():
    Hole, Stencil, Operation, Target, Symbol, link = api()
    class Value:
        def __eq__(self, other):raise AssertionError('user equality executed')
    with pytest.raises((TypeError,ValueError)):
        Hole(Value(),0,'abs64','x')
    template=Stencil(bytes(4),b'',(Hole('code',0,'rel32','target'),))
    with pytest.raises(ValueError):link([Operation(template,{'target':-1})],base=0)


@pytest.mark.slow
def test_import_does_not_load_llvm_or_the_ir_compiler():
    import subprocess,sys
    subprocess.run([sys.executable,'-c',
        "import sys,recompyler.copy_patch; assert 'llvmlite' not in sys.modules; assert 'recompyler.ir.compiler' not in sys.modules"],check=True)

def test_prepared_layout_computes_allocation_before_single_patch_pass():
    from recompyler.copy_patch import Hole, Stencil, Operation, prepare, link
    operation=Operation(Stencil(bytes(8),b'constant',(Hole('code',0,'abs64','$data'),)),{})
    layout=prepare([operation])
    assert layout.size==16
    assert layout.link(base=0x1000)==link([operation],base=0x1000)
    assert layout.link(base=0x8000).body!=layout.link(base=0x1000).body
