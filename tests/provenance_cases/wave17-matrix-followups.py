"""Further executed wave17 reviewer witnesses. Unknown is a required refusal."""
GLOBAL='original'

def discarded_format(value,selected):
    """Formatting invokes value.__format__ even though its result is discarded."""
    f'{value}'
    return selected

def keyword_expansion(callback,mapping):
    """Mapping expansion may replace GLOBAL before later keyword evaluation."""
    return callback(**mapping,later=GLOBAL)

def starred_unpack(xs,middle,zs):
    """xs=(), middle=9, zs=(1,2) returns (9,1,2); AST child positions are not slots."""
    a,b,c=[*xs,middle,*zs]
    return a,b,c

