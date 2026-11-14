"""Default-only streaming minimum: removes records plus their private list/consumer."""
import ast

def stream_source(source):
 tree=ast.parse(source);fn=tree.body[0];assert isinstance(fn,ast.FunctionDef)
 prefix=source[:source.index('def ')];fn.decorator_list=[]
 best=[f'_diag_best{k}' for k in range(5)]
 initial=ast.parse('_diag_best0=-1\n_diag_best1=0.0\n_diag_best2=False\n_diag_best3=-1\n_diag_best4=False').body
 creations=[i for i,s in enumerate(fn.body) if isinstance(s,ast.Assign) and isinstance(s.value,ast.Call) and isinstance(s.value.func,ast.Name) and s.value.func.id=='list_new']
 assert len(creations)==1;at=creations[0]
 assert isinstance(fn.body[at+1],ast.If) and isinstance(fn.body[at+2],ast.Assign) and isinstance(fn.body[at+2].value,ast.Name)
 listname=fn.body[at+2].targets[0].id;assert listname=='v__c0_list'
 fn.body[at:at+3]=initial
 calls=[0];consumers=[0]
 class Rewrite(ast.NodeTransformer):
  def visit_While(self,node):
   self.generic_visit(node);body=node.body;indices=[i for i,s in enumerate(body) if isinstance(s,ast.Assign) and isinstance(s.value,ast.Call) and isinstance(s.value.func,ast.Name) and s.value.func.id=='list_room' and isinstance(s.value.args[-1],ast.Name) and s.value.args[-1].id==listname]
   for i in reversed(indices):
    room=body[i].targets[0].id;allocate=body[i+2];assert isinstance(allocate,ast.Assign) and isinstance(allocate.value,ast.Call) and allocate.value.func.id=='alloc' and allocate.value.args[-1].value==4
    block=allocate.targets[0].id;stores=body[i+4:i+9];assert len(stores)==5 and all(isinstance(s,ast.Assign) and isinstance(s.targets[0],ast.Subscript) for s in stores)
    assert ast.unparse(stores[-1].targets[0])=='I['+room+']' and isinstance(stores[-1].value,ast.Name) and stores[-1].value.id==block
    expected=['I['+block+' + 0]','F['+block+' + 1]','I['+block+' + 1 + 1]','I['+block+' + 3]'];assert [ast.unparse(s.targets[0]) for s in stores[:4]]==expected
    assert all(isinstance(s.value,ast.Name) for s in stores[:4]);a,t,flag,surface=[ast.unparse(s.value) for s in stores[:4]]
    code=f'if {flag} and {t} > -1e-05:\n    if not _diag_best4 or {t} < _diag_best1:\n        _diag_best0={a}\n        _diag_best1={t}\n        _diag_best2={flag}\n        _diag_best3={surface}\n        _diag_best4=True'
    body[i:i+9]=ast.parse(code).body;calls[0]+=1
   return node
  def visit_Assign(self,node):
   if isinstance(node.value,ast.Name) and node.value.id==listname:return None
   if isinstance(node.value,ast.Call) and isinstance(node.value.func,ast.Name) and 'firstIntersection' in node.value.func.id:
    assert isinstance(node.targets[0],ast.Tuple) and len(node.targets[0].elts)==5
    node.value=ast.Tuple(elts=[ast.Name(id=n,ctx=ast.Load()) for n in best],ctx=ast.Load());consumers[0]+=1
   return node
 Rewrite().visit(fn);assert calls==[1] and consumers==[1]
 assert not any(isinstance(x,ast.Name) and x.id==listname for x in ast.walk(fn))
 return prefix+ast.unparse(ast.fix_missing_locations(fn))+'\n'
