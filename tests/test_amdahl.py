import pytest


def test_amdahl_known_bytecode_fraction_and_achieved_ratio():
    from bench.libs.amdahl import ceiling
    report=ceiling({'interpreter':75,'c_api':25},achieved=2)
    assert report['python_fraction_lower']==.75
    assert report['ceiling_lower']==report['ceiling_upper']==4
    assert report['achieved_over_ceiling_lower']==report['achieved_over_ceiling_upper']==.5


def test_unknown_native_time_bounds_are_never_called_interpreter():
    from bench.libs.amdahl import ceiling
    report=ceiling({'interpreter':50,'c_api':25,'unknown':25},achieved=2)
    assert report['ceiling_lower']==2 and report['ceiling_upper']==4
    assert report['achieved_over_ceiling_lower']==.5 and report['achieved_over_ceiling_upper']==1


def test_unbounded_and_empty_profiles_remain_explicit():
    from bench.libs.amdahl import ceiling
    report=ceiling({'interpreter':100},achieved=2)
    assert report['upper_unbounded'] and report['ceiling_upper'] is None
    assert report['achieved_over_ceiling_lower']==0
    assert ceiling({})['status']=='unavailable'
    with pytest.raises(ValueError):ceiling({'unknown':-1})
    with pytest.raises(ValueError):ceiling({'invented':1})



def test_ceiling_join_checks_source_group_digest_and_preserves_timings():
    from bench.libs.amdahl import attach_ceilings
    import copy
    timing=dict(source_sha256='source',split='cpu',rows=[dict(name='nbody',samples=[dict(cpython_off={'seconds':2,'digest':'d'},cpython_on={'seconds':2,'digest':'d'},recompyler={'seconds':1,'digest':'d'})]*3)])
    profile=dict(name='nbody',engine='cpython_off',status='ok',source_sha256='source',split='cpu',workload={'digest':'d'},attribution={'counts':{'interpreter':75,'c_api':25}})
    original=copy.deepcopy(timing)
    result=attach_ceilings(timing,[profile])
    assert result['rows'][0]['amdahl']['cpython_off']['achieved_over_ceiling_lower']==.5
    assert timing==original
    profile['source_sha256']='changed'
    with pytest.raises(ValueError,match='source'):attach_ceilings(timing,[profile])

def test_representation_ceiling_includes_c_api_and_allocation():
    from bench.libs.amdahl import ceiling
    result=ceiling({'interpreter':15,'c_api':40,'allocation_gc':10,'c_extensions':25,'unknown':10},achieved=2)
    broad=result['representation']
    assert broad['removable_fraction_lower']==.65 and broad['removable_fraction_upper']==.75
    assert broad['ceiling_lower']==pytest.approx(100/35)
    assert broad['ceiling_upper']==4
    assert broad['achieved_over_ceiling_lower']==.5
    assert broad['achieved_over_ceiling_upper']==pytest.approx(.7)
