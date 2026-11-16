"""wave16 CHECKPOINT80: two callable-boundary fail-first cases.

The original tests live in wave16-inplace/inplace/step4b-preparation. A valid
provenance answer alone does not supply a C entry or prove native execution.
"""

def warm_no_python_entry(value):
    """Exact int1002 -> fresh int3013, distinct from input and other live calls.

    Once supported, one profiled warm Region call must have one actual native
    bank entry/completion and no Python frame; snapshots are outside the call.
    Missing C entry may decline. Product counters alone are insufficient proof.
    """
    return value*3+7

def checked_integer_overflow(value):
    """Exact int((1<<63)-1) -> exact big int27670116110564327428.

    Checked machine overflow must replay; no dummy native result can be boxed
    or credited. Raw adapter status0 still fails if heap st[0]!=0. A following
    small call must reset controls and produce its distinct correct fresh box.
    """
    return value*3+7
