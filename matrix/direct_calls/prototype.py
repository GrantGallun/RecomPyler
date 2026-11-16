"""Hand-reexpressed complete held-out bodies for Numba object-mode feasibility.
No product backend is changed. All object operations are emitted by Numba's
existing object-mode lowering as CPython calls; loop lifting is disabled.
"""
import sys

def string_build(self):
    # chaos.GVector.__str__, exact original body
    return "<%f, %f, %f>" % (self.x, self.y, self.z)

def dict_loop(orig_dict, random_source):
    # json_loads.mutate_dict, exact original body
    new_dict = dict(orig_dict)
    for key, value in new_dict.items():
        rand_val = random_source.random() * sys.maxsize
        if isinstance(key, (int, bytes, str)):
            new_dict[key] = type(key)(rand_val)
    return new_dict

def mixed_calls(hstate, change):
    # mdp.applyHPChange, exact original body
    hp = min(hstate.fixed.maxhp, max(0, hstate.hp + change))
    return hstate._replace(hp=hp)
