import importlib.util


def test_direct_proof_mechanism_exists():
    assert importlib.util.find_spec('recompyler.direct') is not None, 'typed direct effects and identity proof mechanism is missing'
