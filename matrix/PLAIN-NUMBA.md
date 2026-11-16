# Plain Numba reuse diagnostic (S35.1)

Installed Numba0.68.1; all781 current product declines executed as unchanged catalogue functions with the exact fixture arguments. No rewriting, automatic typed-container conversion, objmode, or RecomPyler lowering. The original655-decline subset is matched by row ID, not order.

| Population | Compiles and matches | Compiles but differs | Does not compile | Unresolved harness errors |
|---|---:|---:|---:|---:|
| All current781 declines |170|37|574|0|
| Original655 declines |153|23|479|0|

| Group | Matches | Differs | Does not compile |
|---|---:|---:|---:|
|statements|9|2|23|
|patterns|5|0|5|
|async|0|0|5|
|operators|11|2|101|
|augmented|11|2|101|
|comparisons|34|0|40|
|boolean|12|2|4|
|unary|4|0|23|
|literals|8|3|8|
|comprehensions|0|2|2|
|calls|2|0|6|
|builtins|14|4|115|
|methods|55|6|109|
|stdlib|2|0|28|
|boundaries|1|3|1|
|evaluation_order|0|0|3|
|review|2|7|0|
|identity|0|4|0|

The170 matches are fixture-local evidence of reusable backend support, not a claim that these constructs are fully sound over all Python values. Identity, overflow, mixed numeric comparisons and exception behavior still require product guards. For example numeric and/or fixture rows match here, while the dedicated scalar identity rows all differ. Likewise integer/float is/is-not can coincide on these unequal fixtures without preserving object identity in general. Plain Numba default bounds/overflow semantics remain visible.

Top reusable groups and the product layer that blocks them:

- **55 methods:**23 str,12 bytes,12 set,3 dict,2 list,1 tuple and2 conjugate methods. Product reasons explicitly reject the method name or the bytes literal/type before existing Numba lowering. The arena receiver kind and finite method recognizers need a native type adapter or an object-API operation; adding names alone does not supply ownership/identity guards.
- **34 comparisons:** represented-list/set comparisons, complex kinds, bytes membership/identity, tuple chains and identity operators are blocked by product operand-kind/recognizer rules. A native Numba representation already handles these fixtures, but product heap aliasing, mixed-number precision, NaN and identity tests explain why a blanket passthrough is unsafe.
- **14 builtins:** bool, complex, divmod, filter, hash, isinstance-with-tuple, iter/map/next, pow, print, round, sorted and zip execute correctly here. Product builtin overload lists and callable-as-value/iterator handling reject them. These are specific lowering/representation gaps rather than evidence that all nopython calls require a new backend.
- **12 selected-value boolean rows,11 operators and11 augmented rows:** complex is absent from the represented scalar set; list/set operations and non-bool selected-value identity are guarded/rejected by the product. Plain numeric/list/set fixture values may match while added identity/overflow witnesses fail.
- **9 statement rows:** annotated assignment, nested function/lambda/nonlocal, list deletion and exception paths are rejected by product AST/region restrictions or runtime status guards. Existing Numba supports these particular fixtures; general closures and exceptions still need sound binding and propagation rules.

The37 differing rows are retained as differences, including five string predicate results boxed as int0/1 rather than bool; five typed-dict outputs with identical contents but a different public runtime type; bigint/overflow and mixed int/float errors; tuple/scalar alias loss; generator StopIteration return loss; repr of a list; negative shifts; and exception-message differences. Typed dict outputs are not silently converted to Python dict for the comparison.

Seven initial oracle failures were actual unfamiliar return representations (typed Dict, NumPy dtype and Numba generator). An isolated seven-row rerun with explicit type-preserving projections resolves all seven as compiled-but-different. Raw v1 and rerun artifacts are retained; final rows merge by ID. Program stdout/stderr, exception chain, mutation/events and stable type-aware aliases use the existing matrix oracle. Compiler warnings are recorded separately. Every compiled classification has a real nopython signature.

Source/hash manifests: plain-numba-source-seal-plain-numba-v1.json, plain-numba-source-seal-plain-numba-oracle-v2.json and plain-numba-summary.json. Receipts/audits: logs/s35-plain-numba-v1.* and logs/s35-plain-numba-oracle-v2.*. The direct run does not change any production verdict or the pinned matrix.

## Actual matching rows and product reasons

| Row | Product decline reason |
|---|---|
|statement.assert_error|Assert at line 2; runtime guard at ('construct', 10)|
|statement.raise|runtime guard at ('construct', 10)|
|statement.nonlocal|as a region: 'construct' declares globals or defines functions inside itself|
|statement.del_item|as a region: del of an item of list[int] at line 3 of 'construct'|
|statement.function_def|as a region: 'construct' declares globals or defines functions inside itself|
|statement.annotated_assign|as a region: AnnAssign at line 2 of 'construct'|
|statement.annotation_only|as a region: AnnAssign at line 2 of 'construct'|
|statement.lambda|as a region: 'construct' declares globals or defines functions inside itself|
|pattern.value|as a region: Match at line 2 of 'construct'|
|pattern.singleton|as a region: Match at line 2 of 'construct'|
|pattern.or|as a region: Match at line 2 of 'construct'|
|pattern.wildcard|as a region: Match at line 2 of 'construct'|
|pattern.guard|as a region: Match at line 2 of 'construct'|
|operator.int.compare6|as a region: this comparison at line 2 of 'construct'|
|operator.int.compare7|as a region: this comparison at line 2 of 'construct'|
|operator.int.and|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.int.or|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.float.compare6|as a region: this comparison at line 2 of 'construct'|
|operator.float.compare7|as a region: this comparison at line 2 of 'construct'|
|operator.float.and|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.float.or|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.bool.binary3|runtime guard at ('construct', 3)|
|operator.bool.augmented3|one value can be bool or float|
|operator.bool.compare6|as a region: this comparison at line 2 of 'construct'|
|operator.bool.compare7|as a region: this comparison at line 2 of 'construct'|
|operator.complex.binary0|as a region: an argument of type complex|
|operator.complex.augmented0|as a region: an argument of type complex|
|operator.complex.binary1|as a region: an argument of type complex|
|operator.complex.augmented1|as a region: an argument of type complex|
|operator.complex.binary2|as a region: an argument of type complex|
|operator.complex.augmented2|as a region: an argument of type complex|
|operator.complex.binary3|as a region: an argument of type complex|
|operator.complex.augmented3|as a region: an argument of type complex|
|operator.complex.binary6|as a region: an argument of type complex|
|operator.complex.augmented6|as a region: an argument of type complex|
|operator.complex.compare0|as a region: an argument of type complex|
|operator.complex.compare1|as a region: an argument of type complex|
|operator.complex.compare6|as a region: an argument of type complex|
|operator.complex.compare7|as a region: an argument of type complex|
|operator.complex.unary0|as a region: an argument of type complex|
|operator.complex.unary1|as a region: an argument of type complex|
|operator.complex.unary3|as a region: an argument of type complex|
|operator.complex.chain|as a region: an argument of type complex|
|operator.complex.and|as a region: an argument of type complex|
|operator.complex.or|as a region: an argument of type complex|
|operator.str.compare6|as a region: 'is' between strings at line 2 of 'construct'|
|operator.str.compare7|as a region: 'is' between strings at line 2 of 'construct'|
|operator.str.and|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.str.or|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.bytes.compare6|as a region: an argument of type bytes|
|operator.bytes.compare7|as a region: an argument of type bytes|
|operator.bytes.compare8|as a region: an argument of type bytes|
|operator.bytes.compare9|as a region: an argument of type bytes|
|operator.bytes.unary3|as a region: an argument of type bytes|
|operator.list.binary0|as a region: arithmetic on list[int] at line 2 of 'construct'|
|operator.list.augmented0|as a region: arithmetic on list[int] at line 2 of 'construct'|
|operator.list.compare0|as a region: comparing lists at line 2 of 'construct'|
|operator.list.compare1|as a region: comparing lists at line 2 of 'construct'|
|operator.list.compare2|as a region: arithmetic on list[int] at line 2 of 'construct'|
|operator.list.compare3|as a region: arithmetic on list[int] at line 2 of 'construct'|
|operator.list.compare4|as a region: arithmetic on list[int] at line 2 of 'construct'|
|operator.list.compare5|as a region: arithmetic on list[int] at line 2 of 'construct'|
|operator.list.chain|as a region: comparing lists at line 2 of 'construct'|
|operator.list.and|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.list.or|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.tuple.compare6|as a region: this comparison at line 2 of 'construct'|
|operator.tuple.compare7|as a region: this comparison at line 2 of 'construct'|
|operator.tuple.chain|as a region: arithmetic on (int, int) at line 2 of 'construct'|
|operator.set.binary1|as a region: operator Sub on set[int] and set[int] at line 2 of 'construct'|
|operator.set.augmented1|as a region: operator Sub on set[int] and set[int] at line 2 of 'construct'|
|operator.set.binary9|as a region: operator BitAnd on set[int] and set[int] at line 2 of 'construct'|
|operator.set.augmented9|as a region: operator BitAnd on set[int] and set[int] at line 2 of 'construct'|
|operator.set.binary10|as a region: operator BitOr on set[int] and set[int] at line 2 of 'construct'|
|operator.set.augmented10|as a region: operator BitOr on set[int] and set[int] at line 2 of 'construct'|
|operator.set.binary11|as a region: operator BitXor on set[int] and set[int] at line 2 of 'construct'|
|operator.set.augmented11|as a region: operator BitXor on set[int] and set[int] at line 2 of 'construct'|
|operator.set.compare0|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.compare1|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.compare2|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.compare3|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.compare4|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.compare5|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.chain|as a region: comparing set[int] with set[int] at line 2 of 'construct'|
|operator.set.and|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|operator.set.or|as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct'|
|literal.int64|as a region: a power other than ** 2 at line 2 of 'construct'|
|literal.inf|as a region: float() on str at line 2 of 'construct'|
|literal.nan|as a region: float() on str at line 2 of 'construct'|
|literal.complex|as a region: constant 3j at line 2 of 'construct'|
|literal.bytes|as a region: constant b'matrix\x00' at line 2 of 'construct'|
|literal.list_star|as a region: Starred at line 2 of 'construct'|
|literal.tuple_star|as a region: Starred at line 2 of 'construct'|
|literal.set_star|as a region: Starred at line 2 of 'construct'|
|call.varargs|'construct' has a closure, keyword-only arguments, *args or is a generator; sum() on (int, int, int) at line 2 of 'construct'|
|call.closure|as a region: 'construct' declares globals or defines functions inside itself|
|builtin.bool|as a region: bool() on int at line 2 of 'construct'|
|builtin.complex|as a region: complex() on int, int at line 2 of 'construct'|
|builtin.divmod|as a region: divmod() on int, int at line 2 of 'construct'|
|builtin.filter|as a region: filter() on None, list[int] at line 2 of 'construct'|
|builtin.hash|as a region: hash() on (int, int) at line 2 of 'construct'|
|builtin.isinstance|as a region: isinstance() with something other than one class at line 2 of 'construct'|
|builtin.iter|as a region: iter() on list[int] at line 2 of 'construct'|
|builtin.map|as a region: name 'abs' used as a value at line 2 of 'construct'|
|builtin.next|as a region: iter() on list[int] at line 2 of 'construct'|
|builtin.pow|as a region: pow() on int, int at line 2 of 'construct'|
|builtin.print|as a region: print() on str at line 2 of 'construct'|
|builtin.round|as a region: round() on float, int at line 2 of 'construct'|
|builtin.sorted|as a region: sorted() on list[int] at line 2 of 'construct'|
|builtin.zip|as a region: zip() on list[int], list[int] at line 2 of 'construct'|
|method.str.capitalize|as a region: str method 'capitalize' at line 3 of 'construct'|
|method.str.casefold|as a region: str method 'casefold' at line 3 of 'construct'|
|method.str.center|as a region: str method 'center' at line 3 of 'construct'|
|method.str.expandtabs|as a region: str method 'expandtabs' at line 3 of 'construct'|
|method.str.index|as a region: str method 'index' at line 3 of 'construct'|
|method.str.isidentifier|as a region: str method 'isidentifier' at line 3 of 'construct'|
|method.str.islower|as a region: str method 'islower' at line 3 of 'construct'|
|method.str.isnumeric|as a region: str method 'isnumeric' at line 3 of 'construct'|
|method.str.isprintable|as a region: str method 'isprintable' at line 3 of 'construct'|
|method.str.isspace|as a region: str method 'isspace' at line 3 of 'construct'|
|method.str.istitle|as a region: str method 'istitle' at line 3 of 'construct'|
|method.str.isupper|as a region: str method 'isupper' at line 3 of 'construct'|
|method.str.ljust|as a region: str method 'ljust' at line 3 of 'construct'|
|method.str.partition|as a region: str method 'partition' at line 3 of 'construct'|
|method.str.rfind|as a region: str method 'rfind' at line 3 of 'construct'|
|method.str.rindex|as a region: str method 'rindex' at line 3 of 'construct'|
|method.str.rjust|as a region: str method 'rjust' at line 3 of 'construct'|
|method.str.rpartition|as a region: str method 'rpartition' at line 3 of 'construct'|
|method.str.rsplit|as a region: str method 'rsplit' at line 3 of 'construct'|
|method.str.splitlines|as a region: str method 'splitlines' at line 3 of 'construct'|
|method.str.swapcase|as a region: str method 'swapcase' at line 3 of 'construct'|
|method.str.title|as a region: str method 'title' at line 3 of 'construct'|
|method.str.zfill|as a region: str method 'zfill' at line 3 of 'construct'|
|method.bytes.center|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.endswith|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.isascii|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.join|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.ljust|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.lstrip|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.rjust|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.rstrip|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.split|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.startswith|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.strip|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.bytes.zfill|as a region: constant b'Abc abc 12' at line 2 of 'construct'|
|method.list.copy|as a region: list method 'copy' at line 3 of 'construct'|
|method.list.sort|as a region: list method 'sort' at line 3 of 'construct'|
|method.tuple.index|as a region: method 'index' of (int, int, int) at line 3 of 'construct'|
|method.dict.items|as a region: dict method 'items' at line 3 of 'construct'|
|method.dict.keys|as a region: dict method 'keys' at line 3 of 'construct'|
|method.dict.values|as a region: dict method 'values' at line 3 of 'construct'|
|method.set.copy|as a region: set method 'copy' at line 3 of 'construct'|
|method.set.difference|as a region: set method 'difference' at line 3 of 'construct'|
|method.set.difference_update|as a region: set method 'difference_update' at line 3 of 'construct'|
|method.set.intersection|as a region: set method 'intersection' at line 3 of 'construct'|
|method.set.intersection_update|as a region: set method 'intersection_update' at line 3 of 'construct'|
|method.set.isdisjoint|as a region: set method 'isdisjoint' at line 3 of 'construct'|
|method.set.issubset|as a region: set method 'issubset' at line 3 of 'construct'|
|method.set.pop|as a region: set method 'pop' at line 3 of 'construct'|
|method.set.symmetric_difference|as a region: set method 'symmetric_difference' at line 3 of 'construct'|
|method.set.symmetric_difference_update|as a region: set method 'symmetric_difference_update' at line 3 of 'construct'|
|method.set.union|as a region: set method 'union' at line 3 of 'construct'|
|method.set.update|as a region: set method 'update' at line 3 of 'construct'|
|method.int.conjugate|as a region: method 'conjugate' of int at line 3 of 'construct'|
|method.float.conjugate|as a region: method 'conjugate' of float at line 3 of 'construct'|
|stdlib.math.frexp|as a region: math.frexp at line 2 of 'construct'|
|stdlib.math.gcd|as a region: math.gcd at line 2 of 'construct'|
|statement.bare_except|as a region: a check at construct line 4 sent it back to Python|
|boundary.divide_zero|runtime guard at ('construct', 3)|
|review.mixed1.gt|as a region: a check at construct line 3 sent it back to Python|
|review.mixed1.le|as a region: a check at construct line 3 sent it back to Python|
