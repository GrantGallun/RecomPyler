"""Interpreter-derived construct catalogue. No compiler verdict is inferred here."""
import ast, builtins, keyword, textwrap
from dataclasses import dataclass

@dataclass
class Case:
    id: str
    group: str
    body: str
    params: str = 'x'
    args: str = '(3,)'
    setup: str = ''
    kwargs: str = '{}'
    def source(self):
        return self.setup + '\n' + 'def construct(' + self.params + '):\n' + textwrap.indent(textwrap.dedent(self.body).strip(), '    ') + '\n'

def cases():
    out=[]
    def add(id,group,body,params='x',args='(3,)',setup=''):
        out.append(Case(id,group,body,params,args,setup))
    statements={
      'if_else':'if x > 2:\n    return x+1\nelse:\n    return x-1',
      'for_else':'s=0\nfor i in range(x):\n    s+=i\nelse:\n    s+=10\nreturn s',
      'for_break':'s=0\nfor i in range(x):\n    if i==2:\n        break\n    s+=i\nelse:\n    s=-1\nreturn s',
      'while_else':'s=0\nwhile x>0:\n    x-=1\n    s+=x\nelse:\n    s+=10\nreturn s',
      'while_break':'while x>0:\n    x-=1\n    if x==1:\n        break\nelse:\n    return 0\nreturn x',
      'continue':'s=0\nfor i in range(x):\n    if i==1:\n        continue\n    s+=i\nreturn s',
      'pass':'if x:\n    pass\nreturn x',
      'assert':'assert x>0, "positive"\nreturn x',
      'assert_error':'assert x<0, "negative"\nreturn x',
      'raise':'raise ValueError("matrix")',
      'raise_from':'raise ValueError("matrix") from TypeError("cause")',
      'raise_reraise':'try:\n    raise ValueError("matrix")\nexcept ValueError:\n    raise',
      'try_except':'try:\n    return x//0\nexcept ZeroDivisionError:\n    return x',
      'try_else':'try:\n    y=x+1\nexcept ValueError:\n    y=-1\nelse:\n    y+=2\nreturn y',
      'try_finally':'try:\n    return x\nfinally:\n    x+=1',
      'try_all':'s=0\ntry:\n    s=x+1\nexcept ValueError:\n    s=-1\nelse:\n    s+=2\nfinally:\n    s+=3\nreturn s',
      'except_star':'s=0\ntry:\n    raise ExceptionGroup("matrix", [ValueError("a"),TypeError("b")])\nexcept* ValueError:\n    s+=1\nexcept* TypeError:\n    s+=2\nreturn s',
      'with_single':'with Context(x) as y:\n    return y+1',
      'with_multiple':'with Context(x) as a, Context(x+1) as b:\n    return a+b',
      'global':'global COUNTER\nCOUNTER+=x\nreturn COUNTER',
      'nonlocal':'y=x\ndef inner():\n    nonlocal y\n    y+=1\ninner()\nreturn y',
      'del_name':'y=x\ndel y\nreturn x',
      'del_item':'y=[x,x+1]\ndel y[0]\nreturn y',
      'del_slice':'y=[x,x+1,x+2]\ndel y[::2]\nreturn y',
      'del_attr':'y=Box(x)\ndel y.value\nreturn hasattr(y,"value")',
      'import':'import math\nreturn math.sqrt(x)',
      'import_alias':'import math as m\nreturn m.sqrt(x)',
      'import_from':'from math import sqrt\nreturn sqrt(x)',
      'import_from_alias':'from math import sqrt as s\nreturn s(x)',
      'class':'class Local:\n    def __init__(self,value):\n        self.value=value\nreturn Local(x).value',
      'function_def':'def inner(y):\n    return y+1\nreturn inner(x)',
      'annotated_assign':'y: int=x+1\nreturn y',
      'annotation_only':'y: MissingType\ny=x\nreturn y',
      'yield':'yield x\nyield x+1',
      'yield_from':'yield from [x,x+1]',
      'lambda':'f=lambda y:y+1\nreturn f(x)',
      'boolean_roles':'return (True and x>0) or False',
      'none':'return None if x<0 else x',
      'return':'return x',
      'elif':'if x<0:\n    return -1\nelif x==0:\n    return 0\nelse:\n    return 1',
      'not':'return not x',
      'type_alias':'type Vector=list[int]\nreturn Vector.__value__.__name__',
      'type_parameters':'type Vector[T]=list[T]\nreturn len(Vector.__type_params__)',
      'type_var_tuple':'type Vector[*Ts]=tuple[*Ts]\nreturn len(Vector.__type_params__)',
      'param_spec':'type CallableAlias[**P]=tuple[P]\nreturn len(CallableAlias.__type_params__)',
      'walrus':'return (y:=x+1)+y',
      'conditional':'return x if x>0 else -x',
      'unpack_assign':'a,b=(x,x+1)\nreturn a+b',
      'star_assign':'a,*b=[x,x+1,x+2]\nreturn a+sum(b)',
    }
    context='COUNTER=0\nclass Context:\n    def __init__(self,value): self.value=value\n    def __enter__(self): EVENTS.append("enter"); return self.value\n    def __exit__(self,*args): EVENTS.append("exit"); return False\nclass Box:\n    def __init__(self,value): self.value=value\n'
    for id,body in statements.items():add('statement.'+id,'statements',body,setup=context)
    patterns={
      'value':'case 3: return 1', 'singleton':'case None: return 1',
      'sequence':'case [a,b]: return a+b', 'mapping':'case {"a":a,**rest}: return a+len(rest)',
      'class':'case Box(value=a): return a', 'star':'case [a,*rest]: return a+len(rest)',
      'as':'case int() as a: return a', 'or':'case 2|3: return 1',
      'wildcard':'case _: return 1', 'guard':'case a if a>0: return a',
    }
    pargs={'singleton':'(None,)','sequence':'([2,3],)','mapping':'({"a":2,"b":3},)','class':'(Box(3),)','star':'([2,3,4],)'}
    for id,body in patterns.items():add('pattern.'+id,'patterns','match x:\n    '+body+'\nreturn 0',args=pargs.get(id,'(3,)'),setup=context)
    for id,body in {
      'async_def':'return x+1', 'await':'return await async_helper(x)',
      'async_for':'s=0\nasync for y in AsyncRange(x):\n    s+=y\nreturn s',
      'async_with':'async with AsyncContext(x) as y:\n    return y+1',
      'async_comprehension':'return [y async for y in AsyncRange(x)]',
      'async_generator':'yield x\nyield x+1',
    }.items():
        setup='async def async_helper(x): return x+1\nclass AsyncRange:\n    def __init__(self,n): self.n=n; self.i=0\n    def __aiter__(self): return self\n    async def __anext__(self):\n        if self.i>=self.n: raise StopAsyncIteration\n        self.i+=1\n        return self.i\nclass AsyncContext:\n    def __init__(self,x): self.x=x\n    async def __aenter__(self): EVENTS.append("enter"); return self.x\n    async def __aexit__(self,*a): EVENTS.append("exit"); return False\n'
        setup_async=setup
        c=Case('async.'+id,'async',body,setup=setup)
        c.setup+='\n'
        # source() below recognizes this marker without changing the tested body.
        out.append(c)
    vals={'int':('7','2'),'float':('7.5','2.0'),'bool':('True','False'),'complex':('(2+3j)','(1+1j)'),
          'str':("'abc'","'b'"),'bytes':("b'abc'","b'b'"),'list':('[1,2]','[2,3]'),
          'tuple':('(1,2)','(2,3)'),'dict':('{1:2}','{2:3}'),'set':('{1,2}','{2,3}'),'none':('None','None')}
    binary=['+','-','*','/','//','%','**','<<','>>','&','|','^','@']
    compare=['==','!=','<','<=','>','>=','is','is not','in','not in']
    unary=['+','-','~','not ']
    for kind,(a,b) in vals.items():
        for i,op in enumerate(binary):
            add(f'operator.{kind}.binary{i}','operators',f'return a {op} b','a,b',f'({a},{b})')
            add(f'operator.{kind}.augmented{i}','augmented',f'a {op}= b\nreturn a','a,b',f'({a},{b})')
        for i,op in enumerate(compare):add(f'operator.{kind}.compare{i}','comparisons',f'return a {op} b','a,b',f'({a},{b})')
        for i,op in enumerate(unary):add(f'operator.{kind}.unary{i}','unary',f'return {op}a','a',f'({a},)')
        add(f'operator.{kind}.chain','comparisons','return a == b == a','a,b',f'({a},{b})')
        add(f'operator.{kind}.and','boolean','return a and b','a,b',f'({a},{b})')
        add(f'operator.{kind}.or','boolean','return a or b','a,b',f'({a},{b})')
    for id,expr in {
      'int64':'2**62','bigint':'2**100+7','negative_bigint':'-(2**100+7)', 'float':'1.25','inf':'float("inf")','nan':'float("nan")','negative_zero':'-0.0',
      'complex':'2+3j','str':'"matrix Ω"','bytes':'b"matrix\\x00"','list':'[x,x+1]','tuple':'(x,x+1)', 'dict':'{x:x+1}','set':'{x,x+1}',
      'list_star':'[0,*[x,x+1]]','tuple_star':'(0,*(x,x+1))','set_star':'{0,*[x,x+1]}','dict_unpack':'{0:1,**{x:x+1}}',
      'slice_step':'[0,1,2,3,4][::2]','slice_negative':'[0,1,2,3,4][::-1]', 'slice_store':'[0,1,2,3]',
      'fstring':'f"value={x}"','fstring_s':'f"{x!s}"','fstring_r':'f"{x!r}"','fstring_a':'f"{x!a}"',
      'fstring_spec':'f"{x:04d}"','fstring_nested':'f"{x:{x}d}"','fstring_debug':'f"{x=}"','template':'t"value={x}"',
    }.items():add('literal.'+id,'literals','return '+expr)
    add('statement.slice_store','statements','y=[0,1,2,3]\ny[::2]=[x,x+1]\nreturn y')
    add('operator.matmul_valid','operators','return (Matrix(x) @ Matrix(2)).value',setup='class Matrix:\n    def __init__(self,value): self.value=value\n    def __matmul__(self,other): return Matrix(self.value*other.value)\n')
    for id,expr in {
      'list':'[i*i for i in range(x)]','set':'{i*i for i in range(x)}','dict':'{i:i*i for i in range(x)}','generator':'sum(i*i for i in range(x))',
      'list_nested':'[i+j for i in range(x) for j in range(i) if j%2==0]',
      'set_nested':'{i+j for i in range(x) for j in range(i) if j%2==0}',
      'dict_nested':'{(i,j):i+j for i in range(x) for j in range(i) if j%2==0}',
      'generator_nested':'sum(i+j for i in range(x) for j in range(i) if j%2==0)',
    }.items():add('comprehension.'+id,'comprehensions','return '+expr)
    calls={
      'positional':'return helper(x,2)','keyword':'return helper(b=2,a=x)','defaults':'return helper(x)',
      'varargs':'return sum(args)','varkw':'return sum(kwargs.values())', 'kwonly':'return x+y','posonly':'return x+y',
      'star':'return helper(*[x,2])','double_star':'return helper(**{"a":x,"b":2})',
      'method':'return Box(x).read()','bound_value':'f=Box(x).read\nreturn f()',
      'function_value':'f=helper\nreturn f(x,2)','closure':'def inner(y):\n    return x+y\nreturn inner(2)',
      'recursion':'return recursive(x)','decorator':'@identity\ndef inner(y):\n    return y+1\nreturn inner(x)',
    }
    setup='def helper(a,b=2): return a+b\ndef recursive(x): return 1 if x<=1 else x*recursive(x-1)\ndef identity(f): return f\nclass Box:\n    def __init__(self,x): self.x=x\n    def read(self): return self.x+1\n'
    for id,body in calls.items():
        params,args={'varargs':('*args','(1,2,3)'),'varkw':('**kwargs','()'),'kwonly':('x,*,y=2','(3,)'),'posonly':('x,/,y=2','(3,)')}.get(id,('x','(3,)'))
        add('call.'+id,'calls',body,params,args,setup)
    builtin_args={
      'abs':'-3','aiter':'AsyncRange(3)','all':'[True,False]','anext':'AsyncRange(1)','any':'[False,True]', 'ascii':'"Ω"','bin':'7','bool':'3','breakpoint':'',
      'bytearray':'b"abc"','bytes':'[65,66]','callable':'helper','chr':'65','classmethod':'helper','compile':'"1+2","<matrix>","eval"','complex':'2,3',
      'delattr':'box,"value"','dict':'[(1,2)]','dir':'3','divmod':'7,2','enumerate':'[2,3]','eval':'"1+2",{}','exec':'"a=1",{}',
      'filter':'None,[0,1,2]','float':'3','format':'3,"04d"','frozenset':'[1,2]','getattr':'box,"value"','globals':'','hasattr':'box,"value"',
      'hash':'(1,2)','help':'abs','hex':'15','id':'box','input':'"prompt:"','int':'"12"','isinstance':'3,int','issubclass':'bool,int','iter':'[1,2]',
      'len':'[1,2]','list':'(1,2)','locals':'','map':'abs,[-1,2]','max':'[1,2]','memoryview':'b"abc"','min':'[1,2]','next':'iter([1,2])',
      'object':'','oct':'15','open':'TEMP_FILE,"r"','ord':'"A"','pow':'2,5','print':'"matrix"','property':'helper','range':'3','repr':'[1,2]',
      'reversed':'[1,2]','round':'1.25,1','set':'[1,2]','setattr':'box,"value",7','slice':'1,5,2','sorted':'[3,1,2]','staticmethod':'helper',
      'str':'3','sum':'[1,2]','super':'Box,box','tuple':'[1,2]','type':'3','vars':'box','zip':'[1,2],[3,4]',
      '__import__':'"math"', 'ExceptionGroup':'"matrix",[ValueError("a")]','BaseExceptionGroup':'"matrix",[ValueError("a")]',
      'UnicodeDecodeError':'"utf-8",b"x",0,1,"matrix"','UnicodeEncodeError':'"ascii","?",0,1,"matrix"','UnicodeTranslateError':'"?",0,1,"matrix"','exit':'0','quit':'0','copyright':'','credits':'','license':'',
    }
    bsetup=setup_async+'\n'+context+'\nbox=Box(3)\ndef helper(x): return x\n'+setup.split('class Box:')[0]+'\n'
    # Use harmless, deterministic arguments; return summary only for inherently identity-bearing results.
    drain={'enumerate','filter','map','range','reversed','zip','iter'}
    summary={'classmethod','staticmethod','property','object','super','compile','aiter'}
    for name in sorted(n for n in dir(builtins) if not n.startswith('_') and callable(getattr(builtins,n))):
        value=getattr(builtins,name)
        arg=builtin_args.get(name,'"matrix"' if isinstance(value,type) and issubclass(value,BaseException) else '')
        expr=f'{name}({arg})'
        if name in drain:expr=f'list({expr})'
        if name in summary:expr=f'type({expr}).__name__'
        if name=='aiter':body='return aiter(AsyncRange(3))'
        elif name=='compile':body='return eval(compile("1+2","<matrix>","eval"),{})'
        elif name=='classmethod':body='class C:\n    @classmethod\n    def read(cls): return cls.__name__\nreturn C.read(), C().read()'
        elif name=='staticmethod':body='class C:\n    @staticmethod\n    def read(x): return x+1\nreturn C.read(x), C().read(x)'
        elif name=='property':body='class C:\n    @property\n    def read(self): return 7\nreturn C().read'
        elif name=='object':body='a=object()\nb=object()\nreturn type(a).__name__,a is b'
        elif name=='super':body='class Base:\n    def read(self): return 7\nclass C(Base):\n    def read(self): return super().read()+1\nreturn C().read()'
        elif name=='anext':body='return anext(AsyncRange(1))'
        elif name=='open':body='with open(TEMP_FILE,"r") as f:\n    return f.read()'
        elif name=='id':body='return id(box)==id(box)'
        elif name in {'globals','locals'}:body='return "x" in '+expr
        else:body='return '+expr
        add('builtin.'+name,'builtins',body,setup=bsetup)
    methods={
      str:('"Abc abc 12"',{'capitalize':'','casefold':'','center':'15','count':'"a"','encode':'"utf-8"','endswith':'"12"','expandtabs':'4','find':'"a"','format':'','format_map':'{}','index':'"a"','join':'["a","b"]','ljust':'15','lower':'','lstrip':'','maketrans':'"a","b"','partition':'" "','removeprefix':'"Abc"','removesuffix':'"12"','replace':'"a","b"','rfind':'"a"','rindex':'"a"','rjust':'15','rpartition':'" "','rsplit':'" "','rstrip':'','split':'" "','splitlines':'','startswith':'"Abc"','strip':'','swapcase':'','title':'','translate':'{65:66}','upper':'','zfill':'15'}),
      bytes:('b"Abc abc 12"',{'center':'15','count':'b"a"','decode':'"ascii"','endswith':'b"12"','expandtabs':'4','find':'b"a"','fromhex':'"4142"','hex':'','index':'b"a"','join':'[b"a",b"b"]','ljust':'15','lstrip':'','maketrans':'b"a",b"b"','partition':'b" "','removeprefix':'b"Abc"','removesuffix':'b"12"','replace':'b"a",b"b"','rfind':'b"a"','rindex':'b"a"','rjust':'15','rpartition':'b" "','rsplit':'b" "','rstrip':'','split':'b" "','startswith':'b"Abc"','strip':'','translate':'None','zfill':'15'}),
      bytearray:('bytearray(b"Abc abc 12")',{'append':'65','clear':'','copy':'','extend':'b"xy"','insert':'1,65','pop':'','remove':'65','reverse':'','resize':'4'}),
      list:('[3,1,2]',{'append':'4','clear':'','copy':'','count':'1','extend':'[4,5]','index':'1','insert':'1,7','pop':'','remove':'1','reverse':'','sort':''}),
      tuple:('(3,1,2)',{'count':'1','index':'1'}),
      dict:('{1:2,3:4}',{'clear':'','copy':'','fromkeys':'[1,2],0','get':'1','items':'','keys':'','pop':'1','popitem':'','setdefault':'5,6','update':'{5:6}','values':''}),
      set:('{1,2}',{'add':'3','clear':'','copy':'','difference':'{2,3}','difference_update':'{2,3}','discard':'2','intersection':'{2,3}','intersection_update':'{2,3}','isdisjoint':'{3,4}','issubset':'{1,2,3}','issuperset':'{1}','pop':'','remove':'1','symmetric_difference':'{2,3}','symmetric_difference_update':'{2,3}','union':'{2,3}','update':'{2,3}'}),
      frozenset:('frozenset([1,2])',{}),
      int:('7',{'as_integer_ratio':'','bit_count':'','bit_length':'','conjugate':'','from_bytes':'b"AB","big"','is_integer':'','to_bytes':'2,"big"'}),
      float:('1.25',{'as_integer_ratio':'','conjugate':'','from_number':'3','fromhex':'"0x1.4p+0"','hex':'','is_integer':''}),
    }
    for cls,(value,recipes) in methods.items():
        if cls is bytearray:recipes={**methods[bytes][1],**recipes}
        if cls is frozenset:recipes=methods[set][1]
        for name in sorted(n for n in dir(cls) if not n.startswith('_') and callable(getattr(cls,n))):
            arg=recipes.get(name,'')
            body=f'y={value}\nr=y.{name}({arg})\nreturn r,y'
            if cls is dict and name in {'items','keys','values'}:body=f'y={value}\nreturn list(y.{name}())'
            add(f'method.{cls.__name__}.{name}','methods',body)
    stdlib={'math.sqrt':'math.sqrt(x)','math.frexp':'math.frexp(x)','math.gcd':'math.gcd(x,6)', 'math.sin':'math.sin(x)',
      'itertools.chain':'list(itertools.chain([x],[x+1]))','itertools.repeat':'list(itertools.repeat(x,2))','itertools.product':'list(itertools.product([x],[1,2]))',
      'functools.reduce':'functools.reduce(operator.add,[x,1,2])','functools.partial':'functools.partial(helper,x)(2)',
      'collections.Counter':'dict(collections.Counter([x,x,2]))','collections.deque':'list(collections.deque([x,2]))','collections.defaultdict':'dict(collections.defaultdict(int,{x:2}))',
      'operator.add':'operator.add(x,2)','operator.itemgetter':'operator.itemgetter(0)([x,2])',
      're.match':'re.match("a+","aaa").group(0)','re.sub':'re.sub("a","b","aaa")','struct.pack':'struct.pack("<i",x)','struct.unpack':'struct.unpack("<i",b"\\x03\\0\\0\\0")'}
    for id,expr in stdlib.items():add('stdlib.'+id,'stdlib','return '+expr,setup='import math,itertools,functools,collections,operator,re,struct\ndef helper(a,b): return a+b\n')
    add('statement.bare_except','statements','try:\n    raise ValueError("matrix")\nexcept:\n    return x')
    add('statement.except_as','statements','try:\n    raise ValueError("matrix")\nexcept ValueError as error:\n    return str(error)')
    add('statement.raise_suppressed','statements','try:\n    raise TypeError("context")\nexcept TypeError:\n    raise ValueError("matrix") from None')
    add('statement.raise_context','statements','try:\n    raise TypeError("context")\nexcept TypeError:\n    raise ValueError("matrix")')
    add('statement.generator_return','statements','yield x\nreturn x+1')
    add('async.with_multiple','async','async with AsyncContext(x) as a, AsyncContext(x+1) as b:\n    return a+b',setup=setup_async)
    add('async.for_else','async','s=0\nasync for y in AsyncRange(x):\n    s+=y\nelse:\n    s+=10\nreturn s',setup=setup_async)
    add('builtin.anext_default','builtins','return anext(AsyncRange(0),7)',setup=setup_async)
    add('builtin.anext_exhausted','builtins','return anext(AsyncRange(0))',setup=setup_async)
    for id in ['fstring_s','fstring_r','fstring_a']:
        row=next(r for r in out if r.id=='literal.'+id);row.args='("\\u03a9",)'
    for id,body in {'format':'return "{:04d}".format(x)','format_map':'return "{value:04d}".format_map({"value":x})'}.items():
        add('literal.'+id,'literals',body)
    for row in out:
        if row.id=='call.varkw':row.kwargs='{"a":2,"b":3}'
        if row.id=='call.kwonly':row.kwargs='{"y":7}'
    add('comparison.chain_true','comparisons','return 0<x<10')
    add('boundary.int_overflow','boundaries','return x+1',args='(2**63-1,)')
    add('boundary.int_large','boundaries','return x+1',args='(2**100,)')
    add('boundary.divide_zero','boundaries','return x/0')
    add('boundary.negative_shift','boundaries','return x << -1')
    add('boundary.index','boundaries','return [1,2][x]')
    add('alias.return_argument','aliases','return x',args='([1,2],)')
    add('alias.mutation','aliases','x.append(3)\nreturn x',args='([1,2],)')
    events='def mark(value):\n    EVENTS.append(value)\n    return value\n'
    for id,body in {
      'arguments':'return helper(mark(1),mark(2))',
      'and':'return mark(0) and mark(2)',
      'or':'return mark(1) or mark(2)',
      'conditional':'return mark(1) if mark(3) else mark(2)',
      'chain':'return mark(1)<mark(2)<mark(3)',
      'chain_short':'return mark(3)<mark(2)<mark(1)',
      'dict':'return {mark(1):mark(2),mark(3):mark(4)}',
      'unpack':'return helper(*[mark(1)],**{"b":mark(2)})',
    }.items():add('order.'+id,'evaluation_order',body,setup=events+'def helper(a,b): return a+b\n')
    for name,expr in {'compile':'re.compile("a+").pattern','escape':'re.escape("a.b")','findall':'re.findall("a+","a aa")','finditer':'[m.group(0) for m in re.finditer("a+","a aa")]','purge':'re.purge()','search':'re.search("a+","baaa").group(0)','split':'re.split("a+","baac")'}.items():
        add('stdlib.re.'+name,'stdlib','return '+expr,setup='import re\n')
    add('stdlib.collections.namedtuple','stdlib','Point=collections.namedtuple("Point","x y")\nreturn Point(x,2).x',setup='import collections\n')
    for name in ['cache','lru_cache','wraps','update_wrapper','singledispatch','cached_property','total_ordering']:
        bodies={
          'cache':'f=functools.cache(helper)\nreturn f(x),f(x)',
          'lru_cache':'f=functools.lru_cache(maxsize=2)(helper)\nreturn f(x),f(x)',
          'wraps':'@functools.wraps(helper)\ndef wrapper(y): return helper(y)\nreturn wrapper(x),wrapper.__name__',
          'update_wrapper':'def wrapper(y): return helper(y)\nfunctools.update_wrapper(wrapper,helper)\nreturn wrapper(x),wrapper.__name__',
          'singledispatch':'f=functools.singledispatch(helper)\nreturn f(x)',
          'cached_property':'class C:\n    @functools.cached_property\n    def value(self): return 7\nc=C()\nreturn c.value,c.value',
          'total_ordering':'@functools.total_ordering\nclass C:\n    def __init__(self,x): self.x=x\n    def __eq__(self,other): return self.x==other.x\n    def __lt__(self,other): return self.x<other.x\nreturn C(x)<=C(x+1)',
        }
        add('stdlib.functools.'+name,'stdlib',bodies[name],setup='import functools\ndef helper(x): return x+1\n')
    for n,(a,b) in enumerate([('2**53+1','float(2**53)'),('2**63-1','float(2**63)')]):
        for op,label in [('==','eq'),('>','gt'),('<=','le')]:
            add('review.mixed'+str(n)+'.'+label,'review','return a '+op+' b','a,b','('+a+','+b+')')
    add('review.tuple_nan_shared','review','return a==b','a,b','((NAN,),(NAN,))','NAN=float("nan")')
    add('review.literal_index_high','review','return [1,2][3]')
    add('review.literal_index_low','review','return [1,2][-3]')
    for n,body in enumerate(['return 0<=int(x)<20','return not 0<=int(x)<20','if not 0<=int(x)<20: return .5\nreturn .25']):
        add('review.chain_call.'+str(n),'review',body)
    for label,op,args in [('float_or','or','(float("1.25"),0.0)'),('negative_zero_and','and','(float("-0.0"),1.0)'),('int_or','or','(int("1000"),0)'),('float_right','or','(0.0,float("1.25"))')]:
        add('review.identity.'+label,'identity','return a '+op+' b','a,b',args)
    from range_cases import RANGE_CASES
    out.extend(RANGE_CASES)
    return out

def source(case):
    result=case.source()
    if case.group=='async':result=result.replace('def construct(', 'async def construct(')
    return result

def inventory(rows):
    nodes={};tokens=set()
    for row in rows:
        tree=ast.parse(source(row))
        for node in ast.walk(tree):nodes.setdefault(type(node).__name__,[]).append(row.id)
        import tokenize,io
        tokens.update(t.string for t in tokenize.generate_tokens(io.StringIO(source(row)).readline) if t.type==tokenize.NAME)
    families=(ast.stmt,ast.expr,ast.operator,ast.unaryop,ast.boolop,ast.cmpop,ast.comprehension,ast.pattern,ast.excepthandler,ast.type_param)
    concrete=[]
    for name in dir(ast):
        value=getattr(ast,name)
        if isinstance(value,type) and value not in families and issubclass(value,families) and name not in {'Num','Str','Bytes','NameConstant','Ellipsis'}:concrete.append(name)
    concrete.append('comprehension')
    return {'python_keywords':keyword.kwlist,'python_soft_keywords':keyword.softkwlist,'missing_keyword_tokens':sorted(set(keyword.kwlist+keyword.softkwlist)-tokens), 'ast_nodes':{n:sorted(set(nodes.get(n,[]))) for n in concrete},'missing_ast_nodes':[n for n in concrete if n not in nodes], 'public_builtins':[n for n in dir(builtins) if not n.startswith('_') and callable(getattr(builtins,n))]}
