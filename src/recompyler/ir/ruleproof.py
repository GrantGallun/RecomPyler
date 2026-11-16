"""Fail-closed ruleopt-style proof front end for checked signed word rules.

Only raw integer expressions belong here; Python calls/ownership are not pure.
Translation is linear in rule text; each rule has two timeout-bounded solver
queries. The fixed catalogue is process-cached and never on default lowering.
Adapted from PyPy optimizeopt/intutils.py and ruleopt/proof.py (PyPy 8.0.1).
Copyright (c) the PyPy authors (see reference/pypy/LICENSE).
The MIT License
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"""
import ast
from dataclasses import dataclass
from functools import lru_cache
from hashlib import sha256
import json


class ProofFailure(ValueError):
    pass


@dataclass(frozen=True)
class Rule:
    name: str
    left: str
    right: str
    requires: str = 'True'


@dataclass(frozen=True)
class ProvedRule:
    rule: Rule
    width: int
    digest: str
    solver_version: str


class _Translator:
    def __init__(self,z3,width):
        self.z3=z3
        self.width=width
        self.variables={}

    def parse(self,source):
        try:return ast.parse(source,mode='eval').body
        except (SyntaxError,TypeError) as error:raise ProofFailure('invalid rule syntax') from error

    def integer(self,node):
        z3,width=self.z3,self.width
        if isinstance(node,ast.Name) and node.id not in ('True','False'):
            if node.id not in self.variables:self.variables[node.id]=z3.BitVec(node.id,width)
            return self.variables[node.id],z3.BoolVal(True)
        if isinstance(node,ast.Constant) and type(node.value) is int:
            if not -(1<<(width-1))<=node.value<(1<<(width-1)):
                raise ProofFailure('literal outside word range')
            return z3.BitVecVal(node.value,width),z3.BoolVal(True)
        # Treat a negative integer literal as a single constant, including MIN.
        if isinstance(node,ast.UnaryOp) and isinstance(node.op,ast.USub) and isinstance(node.operand,ast.Constant):
            return self.integer(ast.Constant(-node.operand.value))
        if isinstance(node,ast.BinOp):
            a,ad=self.integer(node.left);b,bd=self.integer(node.right)
            if isinstance(node.op,(ast.Add,ast.Sub,ast.Mult)):
                aa,bb=z3.SignExt(width,a),z3.SignExt(width,b)
                if isinstance(node.op,ast.Add):wide=aa+bb
                elif isinstance(node.op,ast.Sub):wide=aa-bb
                else:wide=aa*bb
                result=z3.Extract(width-1,0,wide)
                return result,z3.And(ad,bd,wide==z3.SignExt(width,result))
            if isinstance(node.op,ast.BitAnd):result=a&b
            elif isinstance(node.op,ast.BitOr):result=a|b
            elif isinstance(node.op,ast.BitXor):result=a^b
            else:raise ProofFailure('unsupported integer operator')
            return result,z3.And(ad,bd)
        raise ProofFailure('unsupported integer expression')

    def condition(self,node):
        z3=self.z3
        if isinstance(node,ast.Constant) and type(node.value) is bool:return z3.BoolVal(node.value)
        if isinstance(node,ast.BoolOp) and isinstance(node.op,ast.And):
            return z3.And(*(self.condition(n) for n in node.values))
        if isinstance(node,ast.Compare) and len(node.ops)==1:
            a,ad=self.integer(node.left);b,bd=self.integer(node.comparators[0])
            op=node.ops[0]
            if isinstance(op,ast.Lt):c=a<b
            elif isinstance(op,ast.LtE):c=a<=b
            elif isinstance(op,ast.Gt):c=a>b
            elif isinstance(op,ast.GtE):c=a>=b
            elif isinstance(op,ast.Eq):c=a==b
            elif isinstance(op,ast.NotEq):c=a!=b
            else:raise ProofFailure('unsupported precondition')
            return z3.And(ad,bd,c)
        raise ProofFailure('unsupported precondition')


@lru_cache(maxsize=256)
def prove(rule,*,width=64,timeout_ms=3000):
    """No rule is usable until both satisfiability and equivalence are proved.

    Equality includes definedness of every intermediate arithmetic operation.
    sat gives a counterexample; unknown, timeout and missing Z3 all refuse.
    """
    if not isinstance(rule,Rule) or type(width) is not int or not 2<=width<=64:
        raise ProofFailure('invalid rule or word width')
    if type(timeout_ms) is not int or timeout_ms<=0:
        raise ProofFailure('positive proof timeout required')
    try:import z3
    except ImportError as error:raise ProofFailure('z3-solver is required for rewrites') from error
    translator=_Translator(z3,width)
    left,ld=translator.integer(translator.parse(rule.left))
    left_names=set(translator.variables)
    right,rd=translator.integer(translator.parse(rule.right))
    if set(translator.variables)-left_names:
        raise ProofFailure('replacement introduces an unbound variable')
    condition=translator.condition(translator.parse(rule.requires))
    if set(translator.variables)-left_names:
        raise ProofFailure('precondition introduces an unbound variable')
    solver=z3.Solver();solver.set(timeout=timeout_ms)
    solver.add(condition)
    feasible=solver.check()
    if feasible==z3.unsat:raise ProofFailure('vacuous rule precondition')
    if feasible!=z3.sat:raise ProofFailure('precondition proof unknown: '+solver.reason_unknown())
    solver.add(z3.Or(ld!=rd,z3.And(ld,rd,left!=right)))
    verdict=solver.check()
    if verdict==z3.sat:raise ProofFailure('counterexample: '+str(solver.model()))
    if verdict!=z3.unsat:raise ProofFailure('equivalence proof unknown: '+solver.reason_unknown())
    version=z3.get_version_string()
    payload=(rule.name,rule.left,rule.right,rule.requires,width,version,'checked-word-v1')
    digest=sha256(json.dumps(payload,separators=(',',':')).encode()).hexdigest()
    return ProvedRule(rule,width,digest,version)


CATALOGUE=(
    Rule('add_zero','x + 0','x'),
    Rule('sub_zero','x - 0','x'),
    Rule('mul_one','x * 1','x'),
    Rule('and_self','x & x','x'),
    Rule('or_self','x | x','x'),
    Rule('xor_self','x ^ x','0'),
    Rule('and_zero','x & 0','0'),
    Rule('or_zero','x | 0','x'),
    Rule('xor_zero','x ^ 0','x'),
    Rule('sub_self','x - x','0'),
)


def prove_catalogue(*,width=64):
    return tuple(prove(rule,width=width) for rule in CATALOGUE)

