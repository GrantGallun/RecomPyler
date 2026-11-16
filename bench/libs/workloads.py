"""Deterministic S85 library workloads; imports/setup are outside timed calls."""
import hashlib
import json
import struct
from dataclasses import dataclass


def _typed(value):
    kind = type(value)
    if value is None: return ['none']
    if kind is bool: return ['bool', value]
    if kind is int: return ['int', str(value)]
    if kind is float: return ['float', struct.pack('!d', value).hex()]
    if kind is complex: return ['complex', _typed(value.real), _typed(value.imag)]
    if kind is str: return ['str', value]
    if kind is bytes: return ['bytes', value.hex()]
    if kind in (list, tuple): return [kind.__name__, [_typed(x) for x in value]]
    if kind is dict: return ['dict', [[_typed(k), _typed(v)] for k, v in value.items()]]
    raise TypeError('unsupported benchmark output: ' + kind.__name__)


def output_digest(value):
    return hashlib.sha256(repr(_typed(value)).encode('utf-8')).hexdigest()


@dataclass(frozen=True)
class Workload:
    name: str
    package: str
    prepare: object
    repeats: int = 64


def _shortest():
    import networkx as nx
    graph = nx.DiGraph()
    graph.add_weighted_edges_from((i, (i + step) % 80, step) for i in range(80) for step in (1, 3, 7))
    return lambda: list(nx.single_source_dijkstra_path_length(graph, 0).items())


def _pagerank():
    import networkx as nx
    from networkx.algorithms.link_analysis.pagerank_alg import _pagerank_python
    graph = nx.DiGraph()
    graph.add_edges_from((i, (i + step) % 60) for i in range(60) for step in (1, 3, 7))
    return lambda: list(_pagerank_python(graph, alpha=0.85, max_iter=100, tol=1e-12).items())


def _sympy():
    import sympy as s
    x, y = s.symbols('x y')
    # New dummy symbols prevent the expression-result cache from replacing work.
    def run():
        a = s.Dummy('a')
        expanded = s.expand((x + y + a) ** 5)
        simplified = s.cancel((x*x - y*y) / (x-y))
        return [str(expanded.subs(a, 2)), str(simplified)]
    return run


def _jinja():
    import jinja2
    template = jinja2.Environment(autoescape=True).from_string('{% for r in rows %}{{r.name}}={{r.value * 2}};{% endfor %}')
    rows = [{'name': '<row%d>' % i, 'value': i} for i in range(30)]
    return lambda: template.render(rows=rows)


_CORPUS = '# RecomPyler\n\nA **fixed** corpus with [links](https://example.com).\n\n- alpha\n- beta\n\n```python\nx = 1 + 2\n```\n'


def _markdown():
    import markdown
    return lambda: markdown.markdown(_CORPUS, extensions=['fenced_code'])


def _pygments():
    from pygments import highlight
    from pygments.lexers import PythonLexer
    from pygments.formatters import HtmlFormatter
    lexer, formatter = PythonLexer(), HtmlFormatter()
    source = 'def square(x):\n    return x * x\n' * 25
    return lambda: highlight(source, lexer, formatter)


def _pyparsing():
    import pyparsing as p
    grammar = p.OneOrMore(p.Group(p.Word(p.alphas) + p.Suppress('=') + p.pyparsing_common.signed_integer + p.Suppress(';')))
    corpus = 'alpha=17; beta=-4; gamma=99; ' * 12
    return lambda: grammar.parse_string(corpus, parse_all=True).as_list()


def _dates():
    from dateutil.parser import parse
    from datetime import datetime
    corpus = ['2024-02-29T12:30:45+00:00', 'March 5, 2023 9:15 PM', '2001/07/08 04:05:06']
    default = datetime(2000, 1, 1)
    return lambda: [parse(text, default=default).isoformat() for text in corpus]


def _yaml():
    import yaml
    corpus = 'rows:\n  - name: alpha\n    value: 7\n  - name: beta\n    value: 9\nactive: true\n'
    return lambda: yaml.load(corpus, Loader=yaml.Loader)


def _schema():
    import jsonschema
    validator = jsonschema.Draft202012Validator({'type':'object', 'properties': {'name':{'type':'string'}, 'value':{'type':'integer', 'minimum':0}}, 'required':['name','value'], 'additionalProperties':False})
    docs = [{'name':'row%d' % i, 'value':i} for i in range(25)] + [{'name':7, 'value':-1}]
    return lambda: [[(list(e.path), e.validator) for e in validator.iter_errors(doc)] for doc in docs]


def _json():
    import json
    encoder = json.JSONEncoder(sort_keys=True, separators=(',', ':'))
    doc = {'a':[1,2,3], 'b':'caf\u00e9', 'nested':{'x':True}}
    # Explicit _one_shot=False takes _make_iterencode, without global patching.
    return lambda: ''.join(encoder.iterencode(doc, _one_shot=False))


def _diff():
    import difflib
    a = ['line %d\n' % i for i in range(100)]
    b = a[:]; b[12:15] = ['changed\n']; b[70] = 'other\n'
    return lambda: list(difflib.unified_diff(a, b, fromfile='old', tofile='new'))


def _email():
    from email.parser import Parser
    from email import policy
    parser = Parser(policy=policy.default)
    text = 'From: alice@example.com\nTo: bob@example.com\nSubject: fixed\nMIME-Version: 1.0\nContent-Type: text/plain; charset=utf-8\n\nHello library world.\n'
    def run():
        msg = parser.parsestr(text)
        return [[(k, str(v)) for k, v in msg.items()], msg.get_content()]
    return run


def _toml():
    import tomllib
    text = 'title="fixed"\n[project]\nname="recompyler"\nvalues=[1,2,3]\nenabled=true\n'
    return lambda: tomllib.loads(text)


def _numpy():
    import numpy as np
    a = np.arange(512, dtype=np.float64) / 8
    def run():
        total = 0.0
        for i in range(len(a)):
            total += float(a[i]) * 0.5
        return total
    return run


def workloads():
    rows = [('networkx_shortest_paths','networkx',_shortest), ('networkx_pagerank','networkx',_pagerank),
            ('sympy_expand_simplify','sympy',_sympy), ('jinja2_render','jinja2',_jinja),
            ('markdown_convert','markdown',_markdown), ('pygments_highlight','pygments',_pygments),
            ('pyparsing_parse','pyparsing',_pyparsing), ('dateutil_parse','dateutil',_dates),
            ('yaml_load','yaml',_yaml), ('jsonschema_validate','jsonschema',_schema),
            ('json_encode','json',_json), ('difflib_diff','difflib',_diff),
            ('email_parse','email',_email), ('tomllib_load','tomllib',_toml), ('numpy_loop','numpy',_numpy)]
    return {name:Workload(name, package, prepare) for name, package, prepare in rows}


