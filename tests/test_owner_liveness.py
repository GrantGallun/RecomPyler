import ast
import unittest
from recompyler.lift import lift,Unsupported
from recompyler.facts import RULES


def private_copy(n,rounds,stop):
    source=list(range(n))
    target=list(range(n))
    total=0
    for k in range(rounds):
        target=source[:]
        if k==stop:
            return total+target[0]
        total+=target[0]
    return total


def copy_after_error(n,rounds,divisor):
    source=list(range(n))
    target=list(range(n))
    total=0
    for k in range(rounds):
        total=1//divisor
        target=source[:]
        total+=target[0]
    return total


def copy_late_error(n,rounds):
    source=list(range(n))
    target=list(range(n))
    for k in range(rounds):
        target=source[:]
    return target[n]


def changing_extent(n,rounds):
    source=list(range(n))
    target=list(range(1))
    for k in range(rounds):target=source[:]
    return len(target)


def foreign_kind(n,rounds):
    source=list(range(n))
    target=list(range(n))
    source[0]=1.5
    for k in range(rounds):target=source[:]
    return target[0]


def branch_owner(n,flag):
    source=list(range(n))
    if flag:target=source[:]
    else:target=source[:]
    target=source[:]
    return target[0]


def captured_owner(n):
    p=list(range(n));q=list(range(n))
    ins=p.insert;pop=p.pop
    p=q[:]
    ins(0,pop(1))
    return p[0]


def fast_text(compiled):
    node=next(n for n in ast.parse(compiled.source).body if isinstance(n,ast.FunctionDef))
    first=node.body[0]
    return ast.unparse(ast.Module(body=first.body if isinstance(first,ast.If) else node.body,type_ignores=[]))

class OwnerLivenessTests(unittest.TestCase):
    def test_proved_copy_keeps_its_owner(self):
        compiled=lift(private_copy)
        self.assertIn('_rc_copy_into',fast_text(compiled))
        self.assertNotIn('_rc_copy_fits',fast_text(compiled))
        self.assertNotIn('target = _rc_copy(',fast_text(compiled))
        report=compiled._unit.rule_reports
        self.assertEqual(sum(r['rules'].get('R4',{}).get('fired',0) for r in report),1)
        self.assertTrue({'F1','F2','F3','F9'}<=set(RULES['R4'].requires))
    def test_uncertain_shape_kind_and_dominance_keep_checked_route(self):
        self.assertIn('_rc_copy_fits',lift(changing_extent).source)
        self.assertIn('_rc_copy_fits',lift(foreign_kind).source)
        self.assertNotIn('_rc_copy_into',lift(branch_owner).source)
        with self.assertRaises(Unsupported):lift(captured_owner)
    def test_native_cleanup_for_return_guard_miss_and_checked_failure(self):
        from numba.core.runtime import _nrt_python,rtsys
        _nrt_python.memsys_enable_stats();self.addCleanup(_nrt_python.memsys_disable_stats)
        for fn,args in ((private_copy,(5,4,-1)),(private_copy,(5,4,1)),(private_copy,(0,0,-1)),(private_copy,(-1,0,-1)),(private_copy,(-1,4,-1)),(copy_after_error,(5,4,0)),(copy_late_error,(5,4)),(private_copy,(0,4,-1))):
            compiled=lift(fn)
            warm_failed=False
            try:compiled(*args)
            except (ZeroDivisionError,IndexError):warm_failed=True
            self.assertTrue(compiled._compiled.signatures,(fn.__name__,args))
            self.assertTrue(any(compiled._shapes.values()),(fn.__name__,args))
            if not warm_failed:self.assertGreater(compiled.compiled_calls,0)
            native_run=compiled._run;native_calls=[0]
            def counted(packed):
                native_calls[0]+=1
                return native_run(packed)
            compiled._run=counted
            before=rtsys.get_allocation_stats()
            for _ in range(40):
                try:got=compiled(*args)
                except (ZeroDivisionError,IndexError) as e:
                    with self.assertRaises(type(e)):fn(*args)
                else:self.assertEqual(got,fn(*args))
            after=rtsys.get_allocation_stats()
            self.assertEqual(native_calls[0],40,(fn.__name__,args))
            self.assertEqual(after.alloc-after.free,before.alloc-before.free)
            self.assertEqual(after.mi_alloc-after.mi_free,before.mi_alloc-before.mi_free)
