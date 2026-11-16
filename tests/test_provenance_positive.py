"""Useful real-code positives remain separate from defensive unknown contracts."""
import hashlib,importlib.util,json
from pathlib import Path
R=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('wave17_positive_audit',R/'matrix/provenance_positive.py')
audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)


def test_real_consumer_queries_report_proof_or_specific_missing_fact(tmp_path):
    report=audit.evaluate()
    assert 30<=report['should_prove']['total']<=50
    assert len({r['id'] for r in report['rows']})==len(report['rows'])
    assert len({(r['module'],r['function']) for r in report['rows']})>=10
    assert all(r['consumer'] and r['expression'] for r in report['rows'])
    assert all(r['blocking_fact'] and r['reason'] or r['valid'] for r in report['rows'] if r['verdict']=='missing')
    assert sum(r['cases'] for r in report['missing_facts_ranked'])==sum(r['verdict']=='missing' for r in report['rows'])
    assert all(r['obligations'] for r in report['rows'] if r['verdict']=='proved')
    assert not any(r['verdict']=='proved' for r in report['rows'] if r['action'] in ('physical','journal','virtual','callee'))
    (tmp_path/'positive.json').write_text(json.dumps(report,indent=2),encoding='utf-8')


def positive_field_owner(value, other):
    return value.field


def test_positive_proof_rejects_wrong_path_root_and_scope():
    import ast,inspect,textwrap
    from recompyler import provenance as p
    fn=positive_field_owner
    node=next(n for n in ast.walk(ast.parse(textwrap.dedent(inspect.getsource(fn)))) if isinstance(n,ast.Attribute))
    summary=p.analyze(fn)
    case={'expected_roots':[['argument',0]],'expected_kind':'attribute','expected_fields':['field'],'action':'origin'}
    value=summary.expressions[p.site(node)]
    assert audit.origin_contract(case,node,value,summary,fn)
    root=p.Origin('argument',(0,));foreign=p.Origin('argument',(1,))
    for name,parents,scope in [('other',(root,),id(fn.__code__)),('field',(foreign,),id(fn.__code__)),('field',(root,foreign),id(fn.__code__)),('field',(root,),id(fn.__code__)+1)]:
        wrong=p.Value(frozenset((p.Origin('attribute',(name,*p.site(node)),parents,scope),)))
        assert not audit.origin_contract(case,node,wrong,summary,fn)


def test_corpus_snapshot_survives_live_addition_but_detects_copy_mutation(tmp_path,monkeypatch):
    spec=importlib.util.spec_from_file_location('snapshot_inputs',R/'matrix/correctness_inputs.py')
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    clone=tmp_path/'clone';clone.mkdir();live=tmp_path/'provenance-cases';live.mkdir()
    (live/'sample.py').write_text('original')
    folder=clone/'attempt';folder.mkdir();monkeypatch.setattr(module,'R',clone)
    frozen,hashes=module.freeze_corpus(folder)
    (live/'sample.py').write_text('changed');(live/'added.py').write_text('new')
    assert module.corpus_matches(frozen,hashes)
    assert (frozen/'sample.py').read_text()=='original'
    (frozen/'sample.py').write_text('tampered')
    assert not module.corpus_matches(frozen,hashes)


def test_explicit_missing_corpus_never_falls_back(tmp_path,monkeypatch):
    import pytest
    monkeypatch.setenv('PROVENANCE_CORPUS',str(tmp_path/'missing'))
    with pytest.raises(FileNotFoundError):audit.evaluate()


def test_positive_loader_restores_import_block_sentinel(monkeypatch):
    import sys
    monkeypatch.setitem(sys.modules,'pyperf',None)
    audit.evaluate()
    assert 'pyperf' in sys.modules and sys.modules['pyperf'] is None


def test_positive_proof_rejects_unscoped_or_foreign_global_path():
    import ast,inspect,textwrap
    from recompyler import provenance as p
    fn=positive_field_owner
    node=next(n for n in ast.walk(ast.parse(textwrap.dedent(inspect.getsource(fn)))) if isinstance(n,ast.Attribute))
    summary=p.analyze(fn)
    case={'expected_roots':[['global','global','state']],'expected_kind':'attribute','expected_fields':['field'],'action':'origin'}
    for scope in (0,id(fn.__code__)+1):
        parent=p.Origin('global',('global','state'),scope=scope)
        wrong=p.Value(frozenset((p.Origin('attribute',('field',*p.site(node)),(parent,),id(fn.__code__)),)))
        assert not audit.origin_contract(case,node,wrong,summary,fn)
