from census_report import aggregate, rankings


def root(name, events=(), unknown=True, native=False, weight=1, wrapper=False):
    return dict(key=['p',name,1],program='p',function=name,line=1,qualname=name,
                already_native=native,inclusive_s=weight,wrapper=wrapper,current_reason='',
                analysis_status='analysed',unknown_remainder=unknown,
                diagnostics=[dict(events=list(events))])


def event(family,line=1,after=False):
    return dict(family=family,scope='callee',source='x.py',absolute_line=line,
                reason=family,category='unsupported',after_unknown=after,structural=False)


def test_root_credit_is_unique_across_samples_and_callee_events():
    row=root('f',[event('A'),event('A',2),event('B')])
    row['diagnostics']*=2
    result=aggregate([row])
    assert result['families']['A']['functions']==1
    assert result['families']['A']['inclusive_s']==1
    assert result['families']['A']['programs']==1
    assert result['rows'][0]['families']==['A','B']
    assert not result['rows'][0]['forecast_eligible']
    assert rankings(result['rows'])['strict']==[]


def test_optimistic_completion_is_conditional_and_missing_capture_gets_none():
    good=root('f',[event('A')]);missing=root('g',[event('B')])
    missing['analysis_status']='missing_or_ambiguous_capture'
    native=root('h',native=True)
    choices=rankings(aggregate([good,missing,native])['rows'])
    assert choices['observed_only'][0]['marginal']==1
    assert choices['observed_only'][0]['cumulative_native']==61
    assert len(choices['observed_only'])==1


def test_only_and_after_unknown_are_explicit_and_wrapper_split():
    result=aggregate([root('f',[event('A',after=True)],wrapper=True),root('g',[event('A')],unknown=False,weight=None)])
    a=result['families']['A']
    assert a['only_observed']==2 and a['only_reliable']==1
    assert a['after_unknown_functions']==1 and a['wrapper_functions']==1
    assert a['missing_weight_functions']==1
    assert len(rankings(result['rows'])['strict'])==1
