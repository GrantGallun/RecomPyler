def scan(self, name):
    f, tree = (self.functions[name], self.trees[name])
    params = [a.arg for a in tree.args.args]
    env = {p: {'@' + str(i)} for i, p in enumerate(params) if p in f.object_params}
    for variable in f.allocations:
        env[variable] = {name + ':' + variable}
    events = set()
    aliases = set()
    fresh = set()
    unknown = False
    parents = self._structural[name][1]

    def origin(node):
        if isinstance(node, ast.Name):
            return env.get(node.id, set())
        if isinstance(node, ast.Subscript):
            return {'?'}
        if isinstance(node, ast.IfExp):
            return origin(node.body) | origin(node.orelse)
        if isinstance(node, ast.BinOp):
            return origin(node.left) | origin(node.right)
        if isinstance(node, ast.UnaryOp):
            return origin(node.operand)
        if isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute) and (self._cached_unparse(node.func) in ('np.uint64', 'np.int64')):
            return origin(node.args[0])
        if isinstance(node, (ast.Tuple, ast.List, ast.Set)):
            return set().union(*(origin(x) for x in node.elts)) if node.elts else set()
        if isinstance(node, ast.Call) and self.callee(node) in self.functions:
            callee = self.callee(node)
            s = self.summaries[callee]
            if not self.functions[callee].object_return:
                return set()
            result = set(s['fresh_returns'])
            for i in s['return_aliases']:
                if i < len(node.args):
                    result |= origin(node.args[i])
            if s['return_unknown']:
                result.add('?')
                for arg in node.args:
                    result |= origin(arg)
            return result
        return set()
    for _ in range(len(list(self._structural[name][0])) + 1):
        changed = False
        for x in self._structural[name][0]:
            if isinstance(x, ast.Assign):
                values = origin(x.value)
                for target in x.targets:
                    if isinstance(target, ast.Name):
                        old = env.setdefault(target.id, set())
                        new = old | values
                        if new != old:
                            env[target.id] = new
                            changed = True
        if not changed:
            break

    def conditional(node):
        p = parents.get(node)
        while p is not None and p is not tree:
            if isinstance(p, (ast.If, ast.IfExp, ast.For, ast.While, ast.Try)):
                return True
            p = parents.get(p)
        return False
    allocation_nodes = {}
    for x in self._structural[name][0]:
        if isinstance(x, ast.Assign) and len(x.targets) == 1 and isinstance(x.targets[0], ast.Name) and (x.targets[0].id in f.allocations):
            allocation_nodes[name + ':' + x.targets[0].id] = x

    def controls(node):
        result = set()
        p = parents.get(node)
        while p is not None and p is not tree:
            if isinstance(p, (ast.If, ast.IfExp, ast.For, ast.While, ast.Try)):
                result.add(id(p))
            p = parents.get(p)
        return result

    def emit(origins, kind, node, detail='', force_conditional=False):
        for token in origins:
            local = allocation_nodes.get(token)
            is_conditional = bool(controls(node) - controls(local)) if local is not None else conditional(node)
            if token != '?':
                events.add((token, kind, force_conditional or is_conditional, detail))

    def address(node):
        while isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute) and (self._cached_unparse(node.func) in ('np.uint64', 'np.int64')) and (len(node.args) == 1):
            node = node.args[0]
        offset = 0
        while isinstance(node, ast.BinOp) and isinstance(node.op, ast.Add) and isinstance(node.right, ast.Constant) and (type(node.right.value) is int):
            offset += node.right.value
            node = node.left
            while isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute) and (self._cached_unparse(node.func) in ('np.uint64', 'np.int64')) and (len(node.args) == 1):
                node = node.args[0]
        return (origin(node), offset)
    for x in self._structural[name][0]:
        if isinstance(x, ast.Assign):
            for target in x.targets:
                if isinstance(target, ast.Subscript):
                    base, offset = address(target.slice)
                    emit(base, 'mutated', x, self._cached_unparse(target.value) + ':' + str(offset))
                    emit(origin(x.value), 'captured', x, 'store')
                elif isinstance(target, ast.Attribute):
                    emit(origin(x.value), 'captured', x, 'attribute store')
                elif not isinstance(target, ast.Name):
                    emit(origin(x.value), 'captured', x, 'unsupported binding')
        elif isinstance(x, ast.AugAssign) and isinstance(x.target, ast.Subscript):
            base, offset = address(x.target.slice)
            emit(base, 'mutated', x, self._cached_unparse(x.target.value) + ':' + str(offset))
        elif isinstance(x, ast.Call):
            callee = self.callee(x)
            if isinstance(x.func, ast.Attribute) and self._cached_unparse(x.func) in ('np.uint64', 'np.int64'):
                continue
            if callee in self.functions:
                summary = self.summaries[callee]
                for i, arg in enumerate(x.args):
                    sources = origin(arg)
                    emit(sources, 'passed', x, callee + ':' + str(i))
                    if i >= len(summary['parameters']):
                        emit(sources, 'captured', x, 'unknown arity')
                        continue
                    effect = summary['parameters'][i]
                    if effect['captured']:
                        emit(sources, 'captured', x, 'callee ' + callee, effect['capture_conditional'])
                    if effect['identity_observed']:
                        emit(sources, 'identity', x, 'callee ' + callee)
                    for field in effect['mutated']:
                        emit(sources, 'mutated', x, field)
            elif callee != 'alloc':
                for arg in x.args:
                    emit(origin(arg), 'captured', x, 'unknown callee ' + self._cached_unparse(x.func))
        elif isinstance(x, ast.Compare):
            sentinel = len(x.ops) == 1 and isinstance(x.ops[0], (ast.Lt, ast.GtE)) and (len(x.comparators) == 1) and isinstance(x.comparators[0], ast.Constant) and (x.comparators[0].value == 0)
            if not sentinel:
                emit(origin(x.left), 'identity', x, 'compare')
                for rhs in x.comparators:
                    emit(origin(rhs), 'identity', x, 'compare')
        elif isinstance(x, ast.Return) and x.value is not None:
            if isinstance(x.value, ast.UnaryOp) and isinstance(x.value.op, ast.USub) and isinstance(x.value.operand, ast.Constant) and (x.value.operand.value == 1):
                continue
            sources = origin(x.value)
            if f.object_return:
                for token in sources:
                    if token.startswith('@'):
                        aliases.add(int(token[1:]))
                    elif token == '?':
                        unknown = True
                    else:
                        fresh.add(token)
                if not sources and (not isinstance(x.value, ast.Constant)) and (not (isinstance(x.value, ast.Name) and x.value.id in env)):
                    unknown = True
            elif sources:
                emit(sources, 'captured', x, 'aggregate or untyped return')
    self.origins[name] = {key: set(value) for key, value in env.items()}
    result = self.empty(name)
    for token, kind, cond, detail in events:
        if not token.startswith('@'):
            continue
        effect = result['parameters'][int(token[1:])]
        if kind == 'captured':
            effect['captured'] = True
        elif kind == 'identity':
            effect['identity_observed'] = True
        elif kind == 'mutated':
            effect['mutated'].append(detail)
        elif kind == 'passed':
            effect['passed_to'].append(detail)
    for i, effect in enumerate(result['parameters']):
        effect['returned'] = i in aliases
        capture_events = [cond for token, kind, cond, detail in events if token == '@' + str(i) and kind == 'captured']
        effect['capture_conditional'] = bool(capture_events) and all(capture_events)
        effect['mutated'] = sorted(set(effect['mutated']))
        effect['passed_to'] = sorted(set(effect['passed_to']))
    result.update(return_aliases=sorted(aliases), fresh_returns=sorted(fresh), return_unknown=unknown)
    return (result, events)
