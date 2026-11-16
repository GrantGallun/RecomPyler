p='src/recompyler/heap.py'; s=open(p,encoding='utf-8').read()
def rep(old,new):
    global s
    assert s.count(old)==1,(old,s.count(old)); s=s.replace(old,new)
rep('''            if kind == BOTTOM:
                kind, codes = ListT(), ["-1"]
            if isinstance(kind, RangeT):
                bounds = self.copy_codes(kind, codes)
                held.append((kind, bounds, self.temp(bounds[0])))
            else:''','''            if kind == BOTTOM:
                kind = ListT()
            if isinstance(kind, RangeT):
                bounds = self.copy_codes(kind, codes)
                # Counted, so that stepping past the end cannot overflow.
                held.append((kind, bounds + [self.range_length(bounds)], self.temp("0")))
            else:''')
rep('''            count = self.temp(f"np.int64({start})")
            self.program.arrays_used = True
''','''            count = self.temp(f"np.int64({start})")
''')
rep('''                self.emit(f"if ({position} >= {codes[1]}) if {codes[2]} > 0 else ({position} <= {codes[1]}):")''',
'''                self.emit(f"if {position} >= {codes[3]}:")''')
rep('''                items.append(self.temp(position))
                self.emit(f"{position} += {codes[2]}")
                continue''','''                items.append(self.temp(f"{codes[0]} + {position} * {codes[2]}"))
                self.emit(f"{position} += 1")
                continue''')
rep('''            if which == "enumerate":
                kinds.append(elem)
                items += read
            else:
                kinds.append(elem)
                items += read
''','''            kinds.append(elem)
            items += read
''')
open(p,'w',encoding='utf-8').write(s)
