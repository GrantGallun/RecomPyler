import unittest
from recompyler.escape import FunctionIR, EscapeAnalysis


def ir(name,body,params=(),allocs=(),returned=False):
    return FunctionIR(name,'def '+name+'('+','.join(params)+'):\n'+''.join('    '+s+'\n' for s in body.splitlines()),tuple(params),dict(allocs),returned)


class EscapeSummaryTests(unittest.TestCase):
    def test_local_fields_do_not_capture_owner(self):
        a=EscapeAnalysis([ir('f','p=alloc(I,top,st,1)\nF[p+0]=1.0\nx=F[p+0]\nreturn x',allocs=[('p','Point')])])
        self.assertEqual(a.allocations['f:p']['class'],'a')

    def test_container_return_captures_both_aliases(self):
        a=EscapeAnalysis([ir('f','p=alloc(I,top,st,1)\nq=p\nI[10]=p\nI[11]=q\nreturn 10',allocs=[('p','Cell')])])
        self.assertIn(a.allocations['f:p']['class'],('d','e'))

    def test_recursive_returned_alias_and_mutation_fixed_point(self):
        funcs=[ir('r','q=r(p)\nF[q+0]=2.0\nreturn p',('p',),returned=True)]
        a=EscapeAnalysis(funcs)
        self.assertEqual(a.summaries['r']['return_aliases'],[0])
        self.assertTrue(a.summaries['r']['parameters'][0]['mutated'])

    def test_identity_after_join_observes_allocations(self):
        a=EscapeAnalysis([ir('f','p=alloc(I,top,st,1)\nq=alloc(I,top,st,1)\nx=p if flag else q\nreturn x==p',allocs=[('p','Cell'),('q','Cell')])])
        self.assertTrue(a.allocations['f:p']['identity_observed'])
        self.assertTrue(a.allocations['f:q']['identity_observed'])

    def test_read_only_callee_is_class_b(self):
        funcs=[ir('get','return F[p+0]',('p',)),ir('f','p=alloc(I,top,st,1)\nF[p+0]=1.0\nreturn get(p)',allocs=[('p','Cell')])]
        a=EscapeAnalysis(funcs)
        self.assertEqual(a.allocations['f:p']['class'],'b')

    def test_unknown_callee_escapes(self):
        a=EscapeAnalysis([ir('f','p=alloc(I,top,st,1)\nunknown(p)\nreturn 1',allocs=[('p','Cell')])])
        self.assertTrue(a.allocations['f:p']['captured'])

    def test_conditional_escape_retains_path_information(self):
        f=ir('f','p=alloc(I,top,st,1)\nif flag:\n    I[10]=p\nreturn 0',allocs=[('p','Cell')])
        a=EscapeAnalysis([f]);self.assertEqual(a.allocations['f:p']['class'],'d')

    def test_fresh_return_is_class_c(self):
        a=EscapeAnalysis([ir('make','p=alloc(I,top,st,1)\nF[p+0]=1.0\nreturn p',allocs=[('p','Cell')],returned=True)])
        self.assertEqual(a.allocations['make:p']['class'],'c')
        self.assertEqual(a.summaries['make']['fresh_returns'],['make:p'])

    def test_unknown_return_conservatively_aliases_object_arguments(self):
        funcs=[ir('get','return unknown()',('p',),returned=True),ir('f','p=alloc(I,top,st,1)\nq=get(p)\nI[10]=q\nreturn 0',allocs=[('p','Cell')])]
        a=EscapeAnalysis(funcs);self.assertTrue(a.allocations['f:p']['captured'])

    def test_constructor_substring_is_not_a_constructor(self):
        funcs=[ir('my__init__read','return F[p+0]',('p',)),ir('f','p=alloc(I,top,st,1)\nreturn my__init__read(p)',allocs=[('p','Cell')])]
        self.assertEqual(EscapeAnalysis(funcs).allocations['f:p']['class'],'b')

    def test_pointer_arithmetic_and_tuple_bindings_cannot_lose_origins(self):
        for binding in ('q=p+0','q=np.uint64(p)','q,x=(p,0)'):
            a=EscapeAnalysis([ir('f','p=alloc(I,top,st,1)\n'+binding+'\nI[10]=q\nreturn 0',allocs=[('p','Cell')])])
            self.assertTrue(a.allocations['f:p']['captured'],binding)

    def test_optimistic_fresh_return_through_known_callee_settles(self):
        funcs=[ir('caller','q=make()\nreturn q',returned=True),ir('make','p=alloc(I,top,st,1)\nreturn p',allocs=[('p','Cell')],returned=True)]
        a=EscapeAnalysis(funcs)
        self.assertEqual(a.summaries['caller']['fresh_returns'],['make:p'])
        self.assertFalse(a.summaries['caller']['return_unknown'])

    def test_capture_in_same_loop_is_unconditional_for_each_instance(self):
        f=ir('f','for i in range(n):\n    p=alloc(I,top,st,1)\n    I[10]=p\nreturn 0',allocs=[('p','Cell')])
        self.assertEqual(EscapeAnalysis([f]).allocations['f:p']['class'],'e')

    def test_signed_field_address_records_correct_mutation_offset(self):
        for address in ('np.int64(p+1)','np.uint64(np.int64(p+1))'):
            a=EscapeAnalysis([ir('change','I['+address+']=7\nreturn',('p',))])
            self.assertEqual(a.summaries['change']['parameters'][0]['mutated'],['I:1'])

    def test_nested_constant_field_offsets_include_tag_slot(self):
        a=EscapeAnalysis([ir('change','I[np.uint64(p+2+1)]=7\nreturn',('p',))])
        self.assertEqual(a.summaries['change']['parameters'][0]['mutated'],['I:3'])
