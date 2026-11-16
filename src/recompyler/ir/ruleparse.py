"""Strict subset of PyPy ruleopt's pattern/check/=> language.

Unsupported constructs refuse the entire catalogue; no rule is registered
until Z3 proves both its value and checked-overflow behavior.
Adapted from PyPy ruleopt/parse.py and proof.py (PyPy 8.0.1).
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
import re
from .ruleproof import Rule, ProofFailure, prove

OPERATORS={'int_add':ast.Add,'int_sub':ast.Sub,'int_mul':ast.Mult,
           'int_and':ast.BitAnd,'int_or':ast.BitOr,'int_xor':ast.BitXor}
HEADER=re.compile(r'^([a-zA-Z_][a-zA-Z_0-9]*):[ \t]*(.+)$')


class _Expressions(ast.NodeTransformer):
    def visit_Call(self,node):
        if not isinstance(node.func,ast.Name) or node.func.id not in OPERATORS:
            raise ProofFailure('unsupported ruleopt operation')
        if len(node.args)!=2 or node.keywords:raise ProofFailure('ruleopt operation needs two operands')
        return ast.BinOp(self.visit(node.args[0]),OPERATORS[node.func.id](),self.visit(node.args[1]))

    def visit_Attribute(self,node):
        raise ProofFailure('abstract-domain method predicates need an explicit proof adapter')


def _expression(source):
    try:node=ast.parse(source,mode='eval')
    except SyntaxError as error:raise ProofFailure('invalid ruleopt expression') from error
    transformed=_Expressions().visit(node)
    return ast.unparse(ast.fix_missing_locations(transformed))


def parse_rules(source):
    if type(source) is not str:raise ProofFailure('rule source must be text')
    rules=[];names=set();current=None;checks=[];target=None
    def finish():
        if current is None:return
        name,pattern=current
        if target is None:raise ProofFailure('rule has no replacement: '+name)
        requires=' and '.join('('+_expression(c)+')' for c in checks) if checks else 'True'
        rules.append(Rule(name,_expression(pattern),_expression(target),requires))
    for number,line in enumerate(source.splitlines(),1):
        line=line.partition('#')[0].strip()
        if not line:continue
        header=HEADER.fullmatch(line)
        if header:
            finish()
            name,pattern=header.groups()
            if name in names:raise ProofFailure('duplicate rule name: '+name)
            names.add(name);current=(name,pattern);checks=[];target=None
        elif current is None:raise ProofFailure('rule header required at line '+str(number))
        elif line.startswith('check ') and target is None:checks.append(line[6:])
        elif line.startswith('=>') and target is None:
            target=line[2:].strip()
            if not target:raise ProofFailure('replacement required')
        else:raise ProofFailure('unsupported ruleopt statement at line '+str(number))
    finish()
    if not rules:raise ProofFailure('empty rule catalogue')
    return tuple(rules)


def parse_proved_rules(source,*,width=64):
    return tuple(prove(rule,width=width) for rule in parse_rules(source))

