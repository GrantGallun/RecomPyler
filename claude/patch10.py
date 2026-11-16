p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new,n=1):
    global s
    assert s.count(old)==n,(old,s.count(old)); s=s.replace(old,new)
rep('''        if isinstance(kind, NdT):
            return self.nd_attribute(kind, codes, node.attr, node)
        fields, offset = self.field(kind, node, node.attr)
        if fields is None:
            if kind == NONE:
                self.fail("True")
            return BOTTOM, ["0"]''','''        if isinstance(kind, NdT):
            return self.nd_attribute(kind, codes, node.attr, node)
        shared = self.class_number(kind, node.attr)
        if shared is not None:
            # A number the class holds, read through an instance.
            self.handle(kind, codes, node)
            return self.constant(shared[0], node)
        fields, offset = self.field(kind, node, node.attr)
        if fields is None:
            if kind == NONE:
                self.fail("True")
            return BOTTOM, ["0"]''')
rep('''    def field(self, kind, node, attr):
        if kind == BOTTOM:
            return None, None''','''    def class_number(self, kind, attr):
        """(value,) when ``attr`` of an object of ``kind`` is not an instance attribute
        of any of its classes and every class holds the same number (or None) there."""
        if not isinstance(kind, ObjT) or any(attr in self.program.class_fields.get(cls, (attr,))
                                             for cls in kind.classes):
            return None
        missing = object()
        found = missing
        for cls in kind.classes:
            definer = next((klass for klass in cls.__mro__[:-1] if attr in vars(klass)), None)
            if definer is None:
                return None
            value = vars(definer)[attr]
            if not (type(value) in (int, float, bool) or value is None):
                return None
            if found is not missing and (type(found) is not type(value) or repr(found) != repr(value)):
                return None
            found = value
        if found is missing:
            return None
        for cls in kind.classes:
            for klass in cls.__mro__[:-1]:
                self.program.guard("own", klass, attr, vars(klass).get(attr))
                if attr in vars(klass):
                    break
        return (found,)

    def field(self, kind, node, attr):
        if kind == BOTTOM:
            return None, None''')
# class reads in init helpers must not be instance attributes set later
rep('''        if stores == made:
            return made
    raise Unsupported''','''        if stores == made:
            return made, reads
    raise Unsupported''')
rep('''    assigned, made = set(assigned), set()
    for position, statement in enumerate(node.body):''','''    assigned, made, reads = set(assigned), set(), set()
    for position, statement in enumerate(node.body):''')
rep('''                    if type(held) in (int, float, bool) or held is None:
                        allowed += 1''','''                    if type(held) in (int, float, bool) or held is None:
                        allowed += 1
                        reads.add(item.attr)''')
rep('''            made = _helper_assigned(cls, helper, assigned, names)
            names |= made
            assigned |= made
            continue''','''            made, reads = _helper_assigned(cls, helper, assigned, names)
            names |= made
            assigned |= made
            class_reads |= reads
            continue''')
rep('''    assigned, escaped = set(), False
    for statement in node.body:
        found = _super_init(statement, init, cls)''','''    assigned, escaped, class_reads = set(), False, set()
    for statement in node.body:
        found = _super_init(statement, init, cls)''')
rep('''    if assigned != names:
        raise Unsupported(f"'{cls.__name__}.__init__' does not always set every attribute")''','''    if assigned != names:
        raise Unsupported(f"'{cls.__name__}.__init__' does not always set every attribute")
    if class_reads & names:
        raise Unsupported(f"'{cls.__name__}.__init__' uses the new object before setting all its attributes")''')
open(p,'w',encoding='utf-8').write(s)
