# Ordinary-source frequency

AST-only possible-import closure over conditional absolute/relative/from imports resolved under installed stdlib; dynamic/unresolvable imports are not enumerated; benchmark shim excluded; no imports executed. Unresolved features have null counts, not zero. Literal computations, runtime receiver kinds and boundary-input predicates are not inferred; boundary/review rows count only their visible syntactic operation. Nested-function count is a closure candidate count, not a captured-free-variable proof. Features shared across runtime kinds are possible occurrences, not inferred receiver types or binding proofs. Method names can denote user classes. Features overlap and are not additive.

40 held-out own files; 375 function definitions (including methods/nested/async); 340 total parsed own+stdlib source files. No dynamic compilation share is inferred from these counts.

| Construct | Own count | Own + imported stdlib | Current matrix verdicts |
|---|---:|---:|---|
| ast:Call | 4329 | 46747 | {'native': 1} |
| constant:str | 5062 | 44884 | {'native': 1} |
| call:positional | 3523 | 43121 | {'native': 1} |
| call:method | 3329 | 26413 | {'native': 1} |
| constant:int | 5200 | 17623 | {'declined': 1} |
| ast:If | 309 | 15977 | {'native': 2} |
| role:function_definition | 375 | 11219 | {'declined': 1} |
| ast:Return | 251 | 10836 | {'native': 1} |
| ast:Subscript | 4439 | 10749 | {'declined': 3} |
| constant:NoneType | 114 | 8663 | {'native': 1} |
| literal:Tuple | 320 | 5035 | {'native': 1} |
| value:named_reference | 536 | 4506 | {'declined': 1} |
| call:keywords | 801 | 3371 | {'native': 1} |
| ast:Raise | 31 | 3338 | {'declined': 1} |
| comparison:Eq | 123 | 3145 | {'native': 6, 'declined': 8} |
| binary:Add | 220 | 3010 | {'native': 5, 'declined': 8} |
| unary:Not | 23 | 2760 | {'native': 10, 'declined': 2} |
| value:bound_attribute | 101 | 2579 | {'declined': 1} |
| ast:Try | 9 | 2348 | {'declined': 1} |
| role:return_name | 82 | 2324 | {'native': 1} |
| comparison:Is | 23 | 2296 | {'declined': 7, 'native': 4} |
| signature:defaults | 22 | 2265 | {'native': 1} |
| try:except | 6 | 2080 | {'declined': 1} |
| boolean:And | 20 | 2041 | {'native': 3, 'declined': 11} |
| assignment:unpack | 431 | 1879 | {'native': 1} |
| comparison:IsNot | 19 | 1843 | {'declined': 7, 'native': 4} |
| literal:List | 109 | 1736 | {'native': 1} |
| ast:Import | 96 | 1608 | {'declined': 2} |
| call:method:append | 62 | 1582 | {'declined': 1, 'native': 2} |
| builtin:len | 73 | 1551 | {'native': 1} |
| binary:Mod | 51 | 1550 | {'native': 2, 'declined': 9} |
| ast:Slice | 31 | 1476 | {'native': 3} |
| call:method:sub | 1426 | 1475 | {'declined': 1} |
| builtin:isinstance | 8 | 1449 | {'declined': 1} |
| ast:ClassDef | 66 | 1445 | {'declined': 1} |
| ast:JoinedStr | 2 | 1238 | {'native': 1, 'declined': 1} |
| comparison:In | 15 | 1232 | {'declined': 10, 'native': 1} |
| unary:USub | 34 | 1208 | {'native': 3, 'declined': 8} |
| boolean:Or | 12 | 1185 | {'declined': 13, 'native': 2} |
| role:decorator | 14 | 1108 | {'declined': 1} |

## Top 40 matrix rows

Runtime-kind rows share syntactic counts; these rows overlap.

| Matrix row | Feature | Own | Own + stdlib | Verdict |
|---|---|---:|---:|---|
| order.arguments | ast:Call | 4329 | 46747 | native |
| literal.str | constant:str | 5062 | 44884 | native |
| call.positional | call:positional | 3523 | 43121 | native |
| call.method | call:method | 3329 | 26413 | native |
| literal.int64 | constant:int | 5200 | 17623 | declined |
| statement.if_else | ast:If | 309 | 15977 | native |
| statement.elif | ast:If | 309 | 15977 | native |
| statement.function_def | role:function_definition | 375 | 11219 | declined |
| statement.return | ast:Return | 251 | 10836 | native |
| boundary.index | ast:Subscript | 4439 | 10749 | declined |
| review.literal_index_high | ast:Subscript | 4439 | 10749 | declined |
| review.literal_index_low | ast:Subscript | 4439 | 10749 | declined |
| statement.none | constant:NoneType | 114 | 8663 | native |
| literal.tuple | literal:Tuple | 320 | 5035 | native |
| call.function_value | value:named_reference | 536 | 4506 | declined |
| call.keyword | call:keywords | 801 | 3371 | native |
| statement.raise | ast:Raise | 31 | 3338 | declined |
| operator.int.compare0 | comparison:Eq | 123 | 3145 | native |
| operator.float.compare0 | comparison:Eq | 123 | 3145 | native |
| operator.bool.compare0 | comparison:Eq | 123 | 3145 | native |
| operator.complex.compare0 | comparison:Eq | 123 | 3145 | declined |
| operator.str.compare0 | comparison:Eq | 123 | 3145 | native |
| operator.bytes.compare0 | comparison:Eq | 123 | 3145 | declined |
| operator.list.compare0 | comparison:Eq | 123 | 3145 | declined |
| operator.tuple.compare0 | comparison:Eq | 123 | 3145 | native |
| operator.dict.compare0 | comparison:Eq | 123 | 3145 | declined |
| operator.set.compare0 | comparison:Eq | 123 | 3145 | declined |
| operator.none.compare0 | comparison:Eq | 123 | 3145 | native |
| review.mixed0.eq | comparison:Eq | 123 | 3145 | declined |
| review.mixed1.eq | comparison:Eq | 123 | 3145 | declined |
| review.tuple_nan_shared | comparison:Eq | 123 | 3145 | declined |
| operator.int.binary0 | binary:Add | 220 | 3010 | native |
| operator.float.binary0 | binary:Add | 220 | 3010 | native |
| operator.bool.binary0 | binary:Add | 220 | 3010 | native |
| operator.complex.binary0 | binary:Add | 220 | 3010 | declined |
| operator.str.binary0 | binary:Add | 220 | 3010 | native |
| operator.bytes.binary0 | binary:Add | 220 | 3010 | declined |
| operator.list.binary0 | binary:Add | 220 | 3010 | declined |
| operator.tuple.binary0 | binary:Add | 220 | 3010 | native |
| operator.dict.binary0 | binary:Add | 220 | 3010 | declined |
