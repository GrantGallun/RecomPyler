p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''def _init_assigned(cls, init):''','''def _init_helper(statement, me, cls):
    """The method ``__init__`` runs as a statement ``self.method(...)`` to set
    attributes for it, or None. The arguments must not hold the new object."""
    if not (isinstance(statement, ast.Expr) and isinstance(statement.value, ast.Call)):
        return None
    call = statement.value
    func = call.func
    if not (isinstance(func, ast.Attribute) and isinstance(func.value, ast.Name) and func.value.id == me):
        return None
    inside = [item for part in list(call.args) + [keyword.value for keyword in call.keywords]
              for item in ast.walk(part)]
    if any(isinstance(item, ast.Name) and item.id == me for item in inside):
        return None
    found = next((vars(klass)[func.attr] for klass in cls.__mro__[:-1] if func.attr in vars(klass)), None)
    if type(found) is not FunctionType or found.__code__.co_flags & (inspect.CO_GENERATOR | inspect.CO_COROUTINE
                                                                      | inspect.CO_ASYNC_GENERATOR):
        return None
    return found


def _helper_assigned(cls, fn, assigned, names):
    """The attributes method ``fn`` always sets when ``__init__`` calls it on the new
    object, which so far has only the attributes in ``assigned``. As in __init__, the
    object is used only to set attributes, to read ones already set, and to read
    numbers the class holds."""
    try:
        node = ast.parse(textwrap.dedent(inspect.getsource(fn.__code__))).body[0]
    except (OSError, TypeError, SyntaxError):
        raise Unsupported(f"no source for '{cls.__name__}.{fn.__name__}'") from None
    if not isinstance(node, ast.FunctionDef) or not node.args.args or node.decorator_list:
        raise Unsupported(f"'{cls.__name__}.__init__' uses the new object before setting all its attributes")
    me = node.args.args[0].arg
    stores = {item.attr for item in ast.walk(node) if isinstance(item, ast.Attribute) and isinstance(
        item.value, ast.Name) and item.value.id == me and not isinstance(item.ctx, ast.Load)}
    assigned, made = set(assigned), set()
    for position, statement in enumerate(node.body):
        mentions = [item for item in ast.walk(statement) if isinstance(item, ast.Name) and item.id == me]
        if isinstance(statement, ast.Return):
            if mentions or position != len(node.body) - 1:
                break
            continue
        if any(isinstance(item, (ast.Return, ast.Yield, ast.YieldFrom, ast.Await, ast.Global, ast.Nonlocal,
                                 ast.FunctionDef, ast.Lambda, ast.ClassDef, ast.Try))
               for item in ast.walk(statement)):
            # It may leave early, or hold the object in another scope.
            break
        if any(isinstance(item, ast.Name) and item.id == me and not isinstance(item.ctx, ast.Load)
               for item in ast.walk(statement)):
            break
        own = []
        if isinstance(statement, ast.Assign):
            own = [target for target in statement.targets if isinstance(target, ast.Attribute)
                   and isinstance(target.value, ast.Name) and target.value.id == me]
        allowed = 0
        for item in ast.walk(statement):
            if isinstance(item, ast.Attribute) and isinstance(item.value, ast.Name) and item.value.id == me:
                if item in own or item.attr in assigned:
                    allowed += 1
                elif isinstance(item.ctx, ast.Load) and item.attr not in names and item.attr not in stores:
                    held = next((vars(klass)[item.attr] for klass in cls.__mro__[:-1] if item.attr in vars(klass)),
                                _init_helper)
                    if type(held) in (int, float, bool) or held is None:
                        allowed += 1
        if allowed != len(mentions):
            break
        assigned.update(target.attr for target in own)
        made.update(target.attr for target in own)
    else:
        if stores == made:
            return made
    raise Unsupported(f"'{cls.__name__}.__init__' uses the new object before setting all its attributes")


def _init_assigned(cls, init):''')
rep('''        mentions = [item for item in ast.walk(statement) if isinstance(item, ast.Name) and item.id == me]
        if found is not None:
            # ``super().__init__(...)``: what the next __init__ sets, it sets here.''','''        helper = _init_helper(statement, me, cls)
        if helper is not None and found is None and _base_init(statement, me, init, cls) is None:
            # ``self.setup(...)``: what that method always sets, __init__ sets here.
            made = _helper_assigned(cls, helper, assigned, names)
            names |= made
            assigned |= made
            continue
        mentions = [item for item in ast.walk(statement) if isinstance(item, ast.Name) and item.id == me]
        if found is not None:
            # ``super().__init__(...)``: what the next __init__ sets, it sets here.''')
open(p,'w',encoding='utf-8').write(s)
