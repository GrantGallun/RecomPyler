# Executed Python language matrix

Installed interpreter: `3.14.4 (tags/v3.14.4:23116f9, Apr  7 2026, 14:10:54) [MSC v.1944 64 bit (AMD64)]`. Every verdict below comes from the recorded construct execution; it is specific to the supplied inputs.

| Group | Native | Declined | Wrong | Crash |
|---|---:|---:|---:|---:|
| aliases | 2 | 0 | 0 | 0 |
| async | 3 | 5 | 0 | 0 |
| augmented | 28 | 115 | 0 | 0 |
| boolean | 4 | 18 | 0 | 0 |
| boundaries | 0 | 5 | 0 | 0 |
| builtins | 14 | 134 | 0 | 0 |
| calls | 8 | 7 | 0 | 0 |
| comparisons | 56 | 66 | 0 | 0 |
| comprehensions | 4 | 4 | 0 | 0 |
| evaluation_order | 5 | 3 | 0 | 0 |
| identity | 0 | 4 | 0 | 0 |
| literals | 10 | 21 | 0 | 0 |
| methods | 39 | 163 | 0 | 0 |
| operators | 29 | 115 | 0 | 0 |
| patterns | 0 | 10 | 0 | 0 |
| range_values | 8 | 2 | 0 | 0 |
| review | 3 | 9 | 0 | 0 |
| statements | 21 | 34 | 0 | 0 |
| stdlib | 3 | 30 | 0 | 0 |
| unary | 17 | 27 | 0 | 0 |
| **Total** | 254 | 772 | 0 | 0 |

Native requires an observed successful native counter increment and matching value/type, exception/chaining, argument poststate, alias relationships, fixture events, stdout and stderr. Declined requires identical Python behavior with an observed decline/guard; hidden compiler failures remain crashes. The full source, input, reference, compiled outcome, reason and raw output path of each row are in [matrix.json](matrix.json).

## Every row

| Construct | Verdict | Decline / failure | Associated old self s |
|---|---|---|---:|
| statement.if_else | native |  | unknown |
| statement.for_else | native |  | unknown |
| statement.for_break | native |  | unknown |
| statement.while_else | native |  | unknown |
| statement.while_break | native |  | unknown |
| statement.continue | native |  | unknown |
| statement.pass | native |  | unknown |
| statement.assert | native |  | unknown |
| statement.assert_error | declined | Assert at line 2; runtime guard at ('construct', 10) | unknown |
| statement.raise | declined | runtime guard at ('construct', 10) | unknown |
| statement.raise_from | declined | runtime guard at ('construct', 10) | unknown |
| statement.raise_reraise | declined | Try at line 2; runtime guard at ('construct', 11) | unknown |
| statement.try_except | declined | as a region: it handed every captured call back to Python | unknown |
| statement.try_else | native |  | unknown |
| statement.try_finally | native |  | unknown |
| statement.try_all | native |  | unknown |
| statement.except_star | declined | as a region: TryStar at line 3 of 'construct' | unknown |
| statement.with_single | declined | as a region: With at line 2 of 'construct' | unknown |
| statement.with_multiple | declined | as a region: With at line 2 of 'construct' | unknown |
| statement.global | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| statement.nonlocal | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| statement.del_name | declined | as a region: this del at line 3 of 'construct' | unknown |
| statement.del_item | declined | as a region: del of an item of list[int] at line 3 of 'construct' | unknown |
| statement.del_slice | declined | as a region: this del at line 3 of 'construct' | unknown |
| statement.del_attr | declined | as a region: this del at line 3 of 'construct' | unknown |
| statement.import | declined | as a region: Import at line 2 of 'construct' | unknown |
| statement.import_alias | declined | as a region: Import at line 2 of 'construct' | unknown |
| statement.import_from | declined | as a region: ImportFrom at line 2 of 'construct' | unknown |
| statement.import_from_alias | declined | as a region: ImportFrom at line 2 of 'construct' | unknown |
| statement.class | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| statement.function_def | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| statement.annotated_assign | declined | as a region: AnnAssign at line 2 of 'construct' | 0.000544559 |
| statement.annotation_only | declined | as a region: AnnAssign at line 2 of 'construct' | unknown |
| statement.yield | native |  | unknown |
| statement.yield_from | native |  | unknown |
| statement.lambda | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| statement.boolean_roles | native |  | unknown |
| statement.none | native |  | unknown |
| statement.return | native |  | unknown |
| statement.elif | native |  | unknown |
| statement.not | native |  | unknown |
| statement.type_alias | declined | as a region: TypeAlias at line 2 of 'construct' | unknown |
| statement.type_parameters | declined | as a region: TypeAlias at line 2 of 'construct' | unknown |
| statement.type_var_tuple | declined | as a region: TypeAlias at line 2 of 'construct' | unknown |
| statement.param_spec | declined | as a region: TypeAlias at line 2 of 'construct' | unknown |
| statement.walrus | declined | as a region: NamedExpr at line 2 of 'construct' | unknown |
| statement.conditional | native |  | unknown |
| statement.unpack_assign | native |  | unknown |
| statement.star_assign | declined | as a region: unpacking list[int] into 2 names at line 2 of 'construct' | unknown |
| pattern.value | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.singleton | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.sequence | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.mapping | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.class | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.star | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.as | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.or | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.wildcard | declined | as a region: Match at line 2 of 'construct' | unknown |
| pattern.guard | declined | as a region: Match at line 2 of 'construct' | unknown |
| async.async_def | native |  | unknown |
| async.await | native |  | unknown |
| async.async_for | declined | as a region: async for over something other than an async generator at line 3 of 'construct' | unknown |
| async.async_with | declined | as a region: 'construct' uses async with, or yield outside a generator | unknown |
| async.async_comprehension | declined | as a region: an async comprehension in 'construct' | unknown |
| async.async_generator | native |  | unknown |
| operator.int.binary0 | native |  | unknown |
| operator.int.augmented0 | native |  | unknown |
| operator.int.binary1 | native |  | unknown |
| operator.int.augmented1 | native |  | unknown |
| operator.int.binary2 | native |  | unknown |
| operator.int.augmented2 | native |  | unknown |
| operator.int.binary3 | native |  | unknown |
| operator.int.augmented3 | native |  | unknown |
| operator.int.binary4 | native |  | unknown |
| operator.int.augmented4 | native |  | unknown |
| operator.int.binary5 | native |  | unknown |
| operator.int.augmented5 | native |  | unknown |
| operator.int.binary6 | native |  | unknown |
| operator.int.augmented6 | native |  | unknown |
| operator.int.binary7 | native |  | unknown |
| operator.int.augmented7 | native |  | unknown |
| operator.int.binary8 | native |  | unknown |
| operator.int.augmented8 | native |  | unknown |
| operator.int.binary9 | native |  | unknown |
| operator.int.augmented9 | native |  | unknown |
| operator.int.binary10 | native |  | unknown |
| operator.int.augmented10 | native |  | unknown |
| operator.int.binary11 | native |  | unknown |
| operator.int.augmented11 | native |  | unknown |
| operator.int.binary12 | declined | operator MatMult at line 2; operator MatMult on int and int at line 2 of 'construct' | unknown |
| operator.int.augmented12 | declined | operator MatMult at line 2; operator MatMult on int and int at line 2 of 'construct' | unknown |
| operator.int.compare0 | native |  | unknown |
| operator.int.compare1 | native |  | unknown |
| operator.int.compare2 | native |  | unknown |
| operator.int.compare3 | native |  | unknown |
| operator.int.compare4 | native |  | unknown |
| operator.int.compare5 | native |  | unknown |
| operator.int.compare6 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.int.compare7 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.int.compare8 | declined | comparison at line 2; 'in' on int at line 2 of 'construct' | unknown |
| operator.int.compare9 | declined | comparison at line 2; 'in' on int at line 2 of 'construct' | unknown |
| operator.int.unary0 | native |  | unknown |
| operator.int.unary1 | native |  | unknown |
| operator.int.unary2 | native |  | unknown |
| operator.int.unary3 | native |  | unknown |
| operator.int.chain | native |  | unknown |
| operator.int.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.int.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.float.binary0 | native |  | unknown |
| operator.float.augmented0 | native |  | unknown |
| operator.float.binary1 | native |  | unknown |
| operator.float.augmented1 | native |  | unknown |
| operator.float.binary2 | native |  | unknown |
| operator.float.augmented2 | native |  | unknown |
| operator.float.binary3 | native |  | unknown |
| operator.float.augmented3 | native |  | unknown |
| operator.float.binary4 | native |  | unknown |
| operator.float.augmented4 | native |  | unknown |
| operator.float.binary5 | native |  | unknown |
| operator.float.augmented5 | native |  | unknown |
| operator.float.binary6 | native |  | unknown |
| operator.float.augmented6 | native |  | unknown |
| operator.float.binary7 | declined | operator LShift on float and float at line 2 of 'construct' | unknown |
| operator.float.augmented7 | declined | operator LShift on float and float at line 2 of 'construct' | unknown |
| operator.float.binary8 | declined | operator RShift on float and float at line 2 of 'construct' | unknown |
| operator.float.augmented8 | declined | operator RShift on float and float at line 2 of 'construct' | unknown |
| operator.float.binary9 | declined | operator BitAnd on float and float at line 2 of 'construct' | unknown |
| operator.float.augmented9 | declined | operator BitAnd on float and float at line 2 of 'construct' | unknown |
| operator.float.binary10 | declined | operator BitOr on float and float at line 2 of 'construct' | unknown |
| operator.float.augmented10 | declined | operator BitOr on float and float at line 2 of 'construct' | unknown |
| operator.float.binary11 | declined | operator BitXor on float and float at line 2 of 'construct' | unknown |
| operator.float.augmented11 | declined | operator BitXor on float and float at line 2 of 'construct' | unknown |
| operator.float.binary12 | declined | operator MatMult at line 2; operator MatMult on float and float at line 2 of 'construct' | unknown |
| operator.float.augmented12 | declined | operator MatMult at line 2; operator MatMult on float and float at line 2 of 'construct' | unknown |
| operator.float.compare0 | native |  | unknown |
| operator.float.compare1 | native |  | unknown |
| operator.float.compare2 | native |  | unknown |
| operator.float.compare3 | native |  | unknown |
| operator.float.compare4 | native |  | unknown |
| operator.float.compare5 | native |  | unknown |
| operator.float.compare6 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.float.compare7 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.float.compare8 | declined | comparison at line 2; 'in' on float at line 2 of 'construct' | unknown |
| operator.float.compare9 | declined | comparison at line 2; 'in' on float at line 2 of 'construct' | unknown |
| operator.float.unary0 | native |  | unknown |
| operator.float.unary1 | native |  | unknown |
| operator.float.unary2 | declined | this unary operator at line 2 of 'construct' | unknown |
| operator.float.unary3 | native |  | unknown |
| operator.float.chain | native |  | unknown |
| operator.float.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.float.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.bool.binary0 | native |  | unknown |
| operator.bool.augmented0 | native |  | unknown |
| operator.bool.binary1 | native |  | unknown |
| operator.bool.augmented1 | native |  | unknown |
| operator.bool.binary2 | native |  | unknown |
| operator.bool.augmented2 | native |  | unknown |
| operator.bool.binary3 | declined | runtime guard at ('construct', 3) | unknown |
| operator.bool.augmented3 | declined | one value can be bool or float | unknown |
| operator.bool.binary4 | declined | capture snapshot or runtime type guard declined | unknown |
| operator.bool.augmented4 | declined | one value can be bool or int | unknown |
| operator.bool.binary5 | declined | capture snapshot or runtime type guard declined | unknown |
| operator.bool.augmented5 | declined | one value can be bool or int | unknown |
| operator.bool.binary6 | native |  | unknown |
| operator.bool.augmented6 | native |  | unknown |
| operator.bool.binary7 | native |  | unknown |
| operator.bool.augmented7 | native |  | unknown |
| operator.bool.binary8 | native |  | unknown |
| operator.bool.augmented8 | native |  | unknown |
| operator.bool.binary9 | native |  | unknown |
| operator.bool.augmented9 | native |  | unknown |
| operator.bool.binary10 | native |  | unknown |
| operator.bool.augmented10 | native |  | unknown |
| operator.bool.binary11 | native |  | unknown |
| operator.bool.augmented11 | native |  | unknown |
| operator.bool.binary12 | declined | operator MatMult at line 2; operator MatMult on bool and bool at line 2 of 'construct' | unknown |
| operator.bool.augmented12 | declined | operator MatMult at line 2; operator MatMult on bool and bool at line 2 of 'construct' | unknown |
| operator.bool.compare0 | native |  | unknown |
| operator.bool.compare1 | native |  | unknown |
| operator.bool.compare2 | native |  | unknown |
| operator.bool.compare3 | native |  | unknown |
| operator.bool.compare4 | native |  | unknown |
| operator.bool.compare5 | native |  | unknown |
| operator.bool.compare6 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.bool.compare7 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.bool.compare8 | declined | comparison at line 2; 'in' on bool at line 2 of 'construct' | unknown |
| operator.bool.compare9 | declined | comparison at line 2; 'in' on bool at line 2 of 'construct' | unknown |
| operator.bool.unary0 | native |  | unknown |
| operator.bool.unary1 | native |  | unknown |
| operator.bool.unary2 | native |  | unknown |
| operator.bool.unary3 | native |  | unknown |
| operator.bool.chain | native |  | unknown |
| operator.bool.and | native |  | unknown |
| operator.bool.or | native |  | unknown |
| operator.complex.binary0 | declined | as a region: an argument of type complex | unknown |
| operator.complex.augmented0 | declined | as a region: an argument of type complex | unknown |
| operator.complex.binary1 | declined | as a region: an argument of type complex | unknown |
| operator.complex.augmented1 | declined | as a region: an argument of type complex | unknown |
| operator.complex.binary2 | declined | as a region: an argument of type complex | unknown |
| operator.complex.augmented2 | declined | as a region: an argument of type complex | unknown |
| operator.complex.binary3 | declined | as a region: an argument of type complex | unknown |
| operator.complex.augmented3 | declined | as a region: an argument of type complex | unknown |
| operator.complex.binary4 | declined | an argument of type complex | unknown |
| operator.complex.augmented4 | declined | an argument of type complex | unknown |
| operator.complex.binary5 | declined | an argument of type complex | unknown |
| operator.complex.augmented5 | declined | an argument of type complex | unknown |
| operator.complex.binary6 | declined | as a region: an argument of type complex | unknown |
| operator.complex.augmented6 | declined | as a region: an argument of type complex | unknown |
| operator.complex.binary7 | declined | an argument of type complex | unknown |
| operator.complex.augmented7 | declined | an argument of type complex | unknown |
| operator.complex.binary8 | declined | an argument of type complex | unknown |
| operator.complex.augmented8 | declined | an argument of type complex | unknown |
| operator.complex.binary9 | declined | an argument of type complex | unknown |
| operator.complex.augmented9 | declined | an argument of type complex | unknown |
| operator.complex.binary10 | declined | an argument of type complex | unknown |
| operator.complex.augmented10 | declined | an argument of type complex | unknown |
| operator.complex.binary11 | declined | an argument of type complex | unknown |
| operator.complex.augmented11 | declined | an argument of type complex | unknown |
| operator.complex.binary12 | declined | operator MatMult at line 2; an argument of type complex | unknown |
| operator.complex.augmented12 | declined | operator MatMult at line 2; an argument of type complex | unknown |
| operator.complex.compare0 | declined | as a region: an argument of type complex | unknown |
| operator.complex.compare1 | declined | as a region: an argument of type complex | unknown |
| operator.complex.compare2 | declined | an argument of type complex | unknown |
| operator.complex.compare3 | declined | an argument of type complex | unknown |
| operator.complex.compare4 | declined | an argument of type complex | unknown |
| operator.complex.compare5 | declined | an argument of type complex | unknown |
| operator.complex.compare6 | declined | as a region: an argument of type complex | unknown |
| operator.complex.compare7 | declined | as a region: an argument of type complex | unknown |
| operator.complex.compare8 | declined | comparison at line 2; an argument of type complex | unknown |
| operator.complex.compare9 | declined | comparison at line 2; an argument of type complex | unknown |
| operator.complex.unary0 | declined | as a region: an argument of type complex | unknown |
| operator.complex.unary1 | declined | as a region: an argument of type complex | unknown |
| operator.complex.unary2 | declined | an argument of type complex | unknown |
| operator.complex.unary3 | declined | as a region: an argument of type complex | unknown |
| operator.complex.chain | declined | as a region: an argument of type complex | unknown |
| operator.complex.and | declined | as a region: an argument of type complex | unknown |
| operator.complex.or | declined | as a region: an argument of type complex | unknown |
| operator.str.binary0 | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| operator.str.augmented0 | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| operator.str.binary1 | declined | operator Sub on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented1 | declined | operator Sub on str and str at line 2 of 'construct' | unknown |
| operator.str.binary2 | declined | operator Mult on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented2 | declined | operator Mult on str and str at line 2 of 'construct' | unknown |
| operator.str.binary3 | declined | operator Div on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented3 | declined | operator Div on str and str at line 2 of 'construct' | unknown |
| operator.str.binary4 | declined | operator FloorDiv on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented4 | declined | operator FloorDiv on str and str at line 2 of 'construct' | unknown |
| operator.str.binary5 | declined | operator Mod on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented5 | declined | operator Mod on str and str at line 2 of 'construct' | unknown |
| operator.str.binary6 | declined | a power other than ** 2 at line 2 of 'construct' | unknown |
| operator.str.augmented6 | declined | operator Pow on str and str at line 2 of 'construct' | unknown |
| operator.str.binary7 | declined | operator LShift on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented7 | declined | operator LShift on str and str at line 2 of 'construct' | unknown |
| operator.str.binary8 | declined | operator RShift on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented8 | declined | operator RShift on str and str at line 2 of 'construct' | unknown |
| operator.str.binary9 | declined | operator BitAnd on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented9 | declined | operator BitAnd on str and str at line 2 of 'construct' | unknown |
| operator.str.binary10 | declined | operator BitOr on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented10 | declined | operator BitOr on str and str at line 2 of 'construct' | unknown |
| operator.str.binary11 | declined | operator BitXor on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented11 | declined | operator BitXor on str and str at line 2 of 'construct' | unknown |
| operator.str.binary12 | declined | operator MatMult at line 2; operator MatMult on str and str at line 2 of 'construct' | unknown |
| operator.str.augmented12 | declined | operator MatMult at line 2; operator MatMult on str and str at line 2 of 'construct' | unknown |
| operator.str.compare0 | native |  | unknown |
| operator.str.compare1 | native |  | unknown |
| operator.str.compare2 | native |  | unknown |
| operator.str.compare3 | native |  | unknown |
| operator.str.compare4 | native |  | unknown |
| operator.str.compare5 | native |  | unknown |
| operator.str.compare6 | declined | as a region: 'is' between strings at line 2 of 'construct' | unknown |
| operator.str.compare7 | declined | as a region: 'is' between strings at line 2 of 'construct' | unknown |
| operator.str.compare8 | native |  | unknown |
| operator.str.compare9 | native |  | unknown |
| operator.str.unary0 | declined | arithmetic on str at line 2 of 'construct' | unknown |
| operator.str.unary1 | declined | arithmetic on str at line 2 of 'construct' | unknown |
| operator.str.unary2 | declined | arithmetic on str at line 2 of 'construct' | unknown |
| operator.str.unary3 | native |  | unknown |
| operator.str.chain | native |  | unknown |
| operator.str.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.str.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.bytes.binary0 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.augmented0 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.binary1 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented1 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary2 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented2 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary3 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented3 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary4 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented4 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary5 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented5 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary6 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented6 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary7 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented7 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary8 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented8 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary9 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented9 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary10 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented10 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary11 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.augmented11 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.binary12 | declined | operator MatMult at line 2; an argument of type bytes | 1.255327471 |
| operator.bytes.augmented12 | declined | operator MatMult at line 2; an argument of type bytes | 1.255327471 |
| operator.bytes.compare0 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare1 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare2 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare3 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare4 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare5 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare6 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare7 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare8 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.compare9 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.unary0 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.unary1 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.unary2 | declined | an argument of type bytes | 1.255327471 |
| operator.bytes.unary3 | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.chain | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.and | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.bytes.or | declined | as a region: an argument of type bytes | 1.255327471 |
| operator.list.binary0 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented0 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary1 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented1 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary2 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented2 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary3 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented3 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary4 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented4 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary5 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented5 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary6 | declined | a power other than ** 2 at line 2 of 'construct' | unknown |
| operator.list.augmented6 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary7 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented7 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary8 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented8 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary9 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented9 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary10 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented10 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary11 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented11 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.binary12 | declined | operator MatMult at line 2; arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.augmented12 | declined | operator MatMult at line 2; arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.compare0 | declined | as a region: comparing lists at line 2 of 'construct' | unknown |
| operator.list.compare1 | declined | as a region: comparing lists at line 2 of 'construct' | unknown |
| operator.list.compare2 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.compare3 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.compare4 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.compare5 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.compare6 | native |  | unknown |
| operator.list.compare7 | native |  | unknown |
| operator.list.compare8 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.compare9 | declined | as a region: arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.unary0 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.unary1 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.unary2 | declined | arithmetic on list[int] at line 2 of 'construct' | unknown |
| operator.list.unary3 | native |  | unknown |
| operator.list.chain | declined | as a region: comparing lists at line 2 of 'construct' | unknown |
| operator.list.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.list.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.tuple.binary0 | native |  | unknown |
| operator.tuple.augmented0 | declined | as a region: arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary1 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented1 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary2 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented2 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary3 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented3 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary4 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented4 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary5 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented5 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary6 | declined | a power other than ** 2 at line 2 of 'construct' | unknown |
| operator.tuple.augmented6 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary7 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented7 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary8 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented8 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary9 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented9 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary10 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented10 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary11 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented11 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.binary12 | declined | operator MatMult at line 2; arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.augmented12 | declined | operator MatMult at line 2; arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.compare0 | native |  | unknown |
| operator.tuple.compare1 | native |  | unknown |
| operator.tuple.compare2 | native |  | unknown |
| operator.tuple.compare3 | native |  | unknown |
| operator.tuple.compare4 | native |  | unknown |
| operator.tuple.compare5 | native |  | unknown |
| operator.tuple.compare6 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.tuple.compare7 | declined | as a region: this comparison at line 2 of 'construct' | unknown |
| operator.tuple.compare8 | declined | as a region: 'in' on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.compare9 | declined | as a region: 'in' on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.unary0 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.unary1 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.unary2 | declined | arithmetic on (int, int) at line 2 of 'construct' | unknown |
| operator.tuple.unary3 | native |  | unknown |
| operator.tuple.chain | native |  | unknown |
| operator.tuple.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.tuple.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.dict.binary0 | declined | operator Add on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented0 | declined | operator Add on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary1 | declined | operator Sub on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented1 | declined | operator Sub on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary2 | declined | operator Mult on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented2 | declined | operator Mult on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary3 | declined | operator Div on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented3 | declined | operator Div on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary4 | declined | operator FloorDiv on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented4 | declined | operator FloorDiv on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary5 | declined | operator Mod on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented5 | declined | operator Mod on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary6 | declined | a power other than ** 2 at line 2 of 'construct' | unknown |
| operator.dict.augmented6 | declined | operator Pow on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary7 | declined | operator LShift on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented7 | declined | operator LShift on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary8 | declined | operator RShift on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented8 | declined | operator RShift on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary9 | declined | operator BitAnd on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented9 | declined | operator BitAnd on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary10 | declined | as a region: operator BitOr on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented10 | declined | as a region: operator BitOr on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary11 | declined | operator BitXor on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented11 | declined | operator BitXor on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.binary12 | declined | operator MatMult at line 2; operator MatMult on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.augmented12 | declined | operator MatMult at line 2; operator MatMult on dict[int, int] and dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare0 | declined | as a region: comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare1 | declined | as a region: comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare2 | declined | comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare3 | declined | comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare4 | declined | comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare5 | declined | comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.compare6 | native |  | unknown |
| operator.dict.compare7 | native |  | unknown |
| operator.dict.compare8 | declined | comparison at line 2; one value can be int or dict[int, int] | unknown |
| operator.dict.compare9 | declined | comparison at line 2; one value can be int or dict[int, int] | unknown |
| operator.dict.unary0 | declined | arithmetic on dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.unary1 | declined | arithmetic on dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.unary2 | declined | arithmetic on dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.unary3 | native |  | unknown |
| operator.dict.chain | declined | as a region: comparing dict[int, int] with dict[int, int] at line 2 of 'construct' | unknown |
| operator.dict.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.dict.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.set.binary0 | declined | operator Add on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented0 | declined | operator Add on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary1 | declined | as a region: operator Sub on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented1 | declined | as a region: operator Sub on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary2 | declined | operator Mult on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented2 | declined | operator Mult on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary3 | declined | operator Div on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented3 | declined | operator Div on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary4 | declined | operator FloorDiv on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented4 | declined | operator FloorDiv on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary5 | declined | operator Mod on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented5 | declined | operator Mod on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary6 | declined | a power other than ** 2 at line 2 of 'construct' | unknown |
| operator.set.augmented6 | declined | operator Pow on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary7 | declined | operator LShift on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented7 | declined | operator LShift on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary8 | declined | operator RShift on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented8 | declined | operator RShift on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary9 | declined | as a region: operator BitAnd on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented9 | declined | as a region: operator BitAnd on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary10 | declined | as a region: operator BitOr on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented10 | declined | as a region: operator BitOr on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary11 | declined | as a region: operator BitXor on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented11 | declined | as a region: operator BitXor on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.binary12 | declined | operator MatMult at line 2; operator MatMult on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.augmented12 | declined | operator MatMult at line 2; operator MatMult on set[int] and set[int] at line 2 of 'construct' | unknown |
| operator.set.compare0 | native |  | unknown |
| operator.set.compare1 | native |  | unknown |
| operator.set.compare2 | native |  | unknown |
| operator.set.compare3 | native |  | unknown |
| operator.set.compare4 | native |  | unknown |
| operator.set.compare5 | native |  | unknown |
| operator.set.compare6 | native |  | unknown |
| operator.set.compare7 | native |  | unknown |
| operator.set.compare8 | declined | as a region: one value can be int or set[int] | unknown |
| operator.set.compare9 | declined | as a region: one value can be int or set[int] | unknown |
| operator.set.unary0 | declined | arithmetic on set[int] at line 2 of 'construct' | unknown |
| operator.set.unary1 | declined | arithmetic on set[int] at line 2 of 'construct' | unknown |
| operator.set.unary2 | declined | arithmetic on set[int] at line 2 of 'construct' | unknown |
| operator.set.unary3 | native |  | unknown |
| operator.set.chain | native |  | unknown |
| operator.set.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.set.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| operator.none.binary0 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented0 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary1 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented1 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary2 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented2 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary3 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented3 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary4 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented4 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary5 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented5 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary6 | declined | a power other than ** 2 at line 2 of 'construct' | unknown |
| operator.none.augmented6 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary7 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented7 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary8 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented8 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary9 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented9 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary10 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented10 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary11 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.augmented11 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.binary12 | declined | operator MatMult at line 2; runtime guard at ('construct', 3) | unknown |
| operator.none.augmented12 | declined | operator MatMult at line 2; runtime guard at ('construct', 3) | unknown |
| operator.none.compare0 | native |  | unknown |
| operator.none.compare1 | native |  | unknown |
| operator.none.compare2 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.compare3 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.compare4 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.compare5 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.compare6 | native |  | unknown |
| operator.none.compare7 | native |  | unknown |
| operator.none.compare8 | declined | comparison at line 2; 'in' on None at line 2 of 'construct' | unknown |
| operator.none.compare9 | declined | comparison at line 2; 'in' on None at line 2 of 'construct' | unknown |
| operator.none.unary0 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.unary1 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.unary2 | declined | runtime guard at ('construct', 3) | unknown |
| operator.none.unary3 | native |  | unknown |
| operator.none.chain | native |  | unknown |
| operator.none.and | native |  | unknown |
| operator.none.or | native |  | unknown |
| literal.int64 | declined | as a region: a power other than ** 2 at line 2 of 'construct' | unknown |
| literal.bigint | declined | as a region: a power other than ** 2 at line 2 of 'construct' | unknown |
| literal.negative_bigint | declined | as a region: a power other than ** 2 at line 2 of 'construct' | unknown |
| literal.float | native |  | unknown |
| literal.inf | declined | as a region: float() on str at line 2 of 'construct' | unknown |
| literal.nan | declined | as a region: float() on str at line 2 of 'construct' | unknown |
| literal.negative_zero | native |  | unknown |
| literal.complex | declined | as a region: constant 3j at line 2 of 'construct' | unknown |
| literal.str | native |  | unknown |
| literal.bytes | declined | as a region: constant b'matrix\x00' at line 2 of 'construct' | 1.255327471 |
| literal.list | native |  | unknown |
| literal.tuple | native |  | unknown |
| literal.dict | native |  | unknown |
| literal.set | native |  | unknown |
| literal.list_star | declined | as a region: Starred at line 2 of 'construct' | unknown |
| literal.tuple_star | declined | as a region: Starred at line 2 of 'construct' | unknown |
| literal.set_star | declined | as a region: Starred at line 2 of 'construct' | unknown |
| literal.dict_unpack | declined | as a region: ** in a dict display at line 2 of 'construct' | unknown |
| literal.slice_step | native |  | unknown |
| literal.slice_negative | native |  | unknown |
| literal.slice_store | native |  | unknown |
| literal.fstring | declined | as a region: heap str/bytes result ownership is not proved | 0.000106518 |
| literal.fstring_s | declined | as a region: heap str/bytes result ownership is not proved | 0.000106518 |
| literal.fstring_r | declined | as a region: an f-string field with a format or conversion at line 2 of 'construct' | 0.000106518 |
| literal.fstring_a | declined | as a region: an f-string field with a format or conversion at line 2 of 'construct' | 0.000106518 |
| literal.fstring_spec | declined | as a region: an f-string field with a format or conversion at line 2 of 'construct' | 0.000106518 |
| literal.fstring_nested | declined | as a region: an f-string field with a format or conversion at line 2 of 'construct' | 0.000106518 |
| literal.fstring_debug | declined | as a region: an f-string field with a format or conversion at line 2 of 'construct' | 0.000106518 |
| literal.template | declined | TemplateStr at line 2; TemplateStr at line 2 of 'construct' | unknown |
| statement.slice_store | native |  | unknown |
| operator.matmul_valid | declined | as a region: arithmetic on Matrix at line 2 of 'construct' | unknown |
| comprehension.list | native |  | unknown |
| comprehension.set | declined | as a region: SetComp at line 2 of 'construct' | unknown |
| comprehension.dict | declined | as a region: DictComp at line 2 of 'construct' | unknown |
| comprehension.generator | native |  | unknown |
| comprehension.list_nested | native |  | unknown |
| comprehension.set_nested | declined | as a region: SetComp at line 2 of 'construct' | unknown |
| comprehension.dict_nested | declined | as a region: DictComp at line 2 of 'construct' | unknown |
| comprehension.generator_nested | native |  | unknown |
| call.positional | native |  | unknown |
| call.keyword | native |  | unknown |
| call.defaults | native |  | unknown |
| call.varargs | declined | 'construct' has a closure, keyword-only arguments, *args or is a generator; sum() on (int, int, int) at line 2 of 'construct' | 0.078009330 |
| call.varkw | declined | 'construct' has a closure, keyword-only arguments, *args or is a generator | 0.297035414 |
| call.kwonly | native |  | unknown |
| call.posonly | native |  | unknown |
| call.star | declined | as a region: *list[int] as arguments at line 2 of 'construct' | unknown |
| call.double_star | declined | as a region: ** in a call at line 2 of 'construct' | unknown |
| call.method | native |  | unknown |
| call.bound_value | declined | as a region: 'Box.read', which __init__ does not set at line 2 of 'construct' | unknown |
| call.function_value | native |  | unknown |
| call.closure | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| call.recursion | native |  | unknown |
| call.decorator | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| builtin.ArithmeticError | declined | call at line 2; ArithmeticError() on str at line 2 of 'construct' | unknown |
| builtin.AssertionError | declined | call at line 2; AssertionError() on str at line 2 of 'construct' | unknown |
| builtin.AttributeError | declined | call at line 2; AttributeError() on str at line 2 of 'construct' | unknown |
| builtin.BaseException | declined | call at line 2; BaseException() on str at line 2 of 'construct' | unknown |
| builtin.BaseExceptionGroup | declined | call at line 2; ValueError() on str at line 2 of 'construct' | unknown |
| builtin.BlockingIOError | declined | call at line 2; BlockingIOError() on str at line 2 of 'construct' | unknown |
| builtin.BrokenPipeError | declined | call at line 2; BrokenPipeError() on str at line 2 of 'construct' | unknown |
| builtin.BufferError | declined | call at line 2; BufferError() on str at line 2 of 'construct' | unknown |
| builtin.BytesWarning | declined | call at line 2; BytesWarning() on str at line 2 of 'construct' | unknown |
| builtin.ChildProcessError | declined | call at line 2; ChildProcessError() on str at line 2 of 'construct' | unknown |
| builtin.ConnectionAbortedError | declined | call at line 2; ConnectionAbortedError() on str at line 2 of 'construct' | unknown |
| builtin.ConnectionError | declined | call at line 2; ConnectionError() on str at line 2 of 'construct' | unknown |
| builtin.ConnectionRefusedError | declined | call at line 2; ConnectionRefusedError() on str at line 2 of 'construct' | unknown |
| builtin.ConnectionResetError | declined | call at line 2; ConnectionResetError() on str at line 2 of 'construct' | unknown |
| builtin.DeprecationWarning | declined | call at line 2; DeprecationWarning() on str at line 2 of 'construct' | unknown |
| builtin.EOFError | declined | call at line 2; EOFError() on str at line 2 of 'construct' | unknown |
| builtin.EncodingWarning | declined | call at line 2; EncodingWarning() on str at line 2 of 'construct' | unknown |
| builtin.EnvironmentError | declined | call at line 2; EnvironmentError() on str at line 2 of 'construct' | unknown |
| builtin.Exception | declined | call at line 2; Exception() on str at line 2 of 'construct' | unknown |
| builtin.ExceptionGroup | declined | call at line 2; ValueError() on str at line 2 of 'construct' | unknown |
| builtin.FileExistsError | declined | call at line 2; FileExistsError() on str at line 2 of 'construct' | unknown |
| builtin.FileNotFoundError | declined | call at line 2; FileNotFoundError() on str at line 2 of 'construct' | unknown |
| builtin.FloatingPointError | declined | call at line 2; FloatingPointError() on str at line 2 of 'construct' | unknown |
| builtin.FutureWarning | declined | call at line 2; FutureWarning() on str at line 2 of 'construct' | unknown |
| builtin.GeneratorExit | declined | call at line 2; GeneratorExit() on str at line 2 of 'construct' | unknown |
| builtin.IOError | declined | call at line 2; IOError() on str at line 2 of 'construct' | unknown |
| builtin.ImportError | declined | call at line 2; ImportError() on str at line 2 of 'construct' | unknown |
| builtin.ImportWarning | declined | call at line 2; ImportWarning() on str at line 2 of 'construct' | unknown |
| builtin.IndentationError | declined | call at line 2; IndentationError() on str at line 2 of 'construct' | unknown |
| builtin.IndexError | declined | call at line 2; IndexError() on str at line 2 of 'construct' | unknown |
| builtin.InterruptedError | declined | call at line 2; InterruptedError() on str at line 2 of 'construct' | unknown |
| builtin.IsADirectoryError | declined | call at line 2; IsADirectoryError() on str at line 2 of 'construct' | unknown |
| builtin.KeyError | declined | call at line 2; KeyError() on str at line 2 of 'construct' | unknown |
| builtin.KeyboardInterrupt | declined | call at line 2; KeyboardInterrupt() on str at line 2 of 'construct' | unknown |
| builtin.LookupError | declined | call at line 2; LookupError() on str at line 2 of 'construct' | unknown |
| builtin.MemoryError | declined | call at line 2; MemoryError() on str at line 2 of 'construct' | unknown |
| builtin.ModuleNotFoundError | declined | call at line 2; ModuleNotFoundError() on str at line 2 of 'construct' | unknown |
| builtin.NameError | declined | call at line 2; NameError() on str at line 2 of 'construct' | unknown |
| builtin.NotADirectoryError | declined | call at line 2; NotADirectoryError() on str at line 2 of 'construct' | unknown |
| builtin.NotImplementedError | declined | call at line 2; NotImplementedError() on str at line 2 of 'construct' | unknown |
| builtin.OSError | declined | call at line 2; OSError() on str at line 2 of 'construct' | unknown |
| builtin.OverflowError | declined | call at line 2; OverflowError() on str at line 2 of 'construct' | unknown |
| builtin.PendingDeprecationWarning | declined | call at line 2; PendingDeprecationWarning() on str at line 2 of 'construct' | unknown |
| builtin.PermissionError | declined | call at line 2; PermissionError() on str at line 2 of 'construct' | unknown |
| builtin.ProcessLookupError | declined | call at line 2; ProcessLookupError() on str at line 2 of 'construct' | unknown |
| builtin.PythonFinalizationError | declined | call at line 2; PythonFinalizationError() on str at line 2 of 'construct' | unknown |
| builtin.RecursionError | declined | call at line 2; RecursionError() on str at line 2 of 'construct' | unknown |
| builtin.ReferenceError | declined | call at line 2; ReferenceError() on str at line 2 of 'construct' | unknown |
| builtin.ResourceWarning | declined | call at line 2; ResourceWarning() on str at line 2 of 'construct' | unknown |
| builtin.RuntimeError | declined | call at line 2; RuntimeError() on str at line 2 of 'construct' | unknown |
| builtin.RuntimeWarning | declined | call at line 2; RuntimeWarning() on str at line 2 of 'construct' | unknown |
| builtin.StopAsyncIteration | declined | call at line 2; StopAsyncIteration() on str at line 2 of 'construct' | unknown |
| builtin.StopIteration | declined | call at line 2; StopIteration() on str at line 2 of 'construct' | unknown |
| builtin.SyntaxError | declined | call at line 2; SyntaxError() on str at line 2 of 'construct' | unknown |
| builtin.SyntaxWarning | declined | call at line 2; SyntaxWarning() on str at line 2 of 'construct' | unknown |
| builtin.SystemError | declined | call at line 2; SystemError() on str at line 2 of 'construct' | unknown |
| builtin.SystemExit | declined | call at line 2; SystemExit() on str at line 2 of 'construct' | unknown |
| builtin.TabError | declined | call at line 2; TabError() on str at line 2 of 'construct' | unknown |
| builtin.TimeoutError | declined | call at line 2; TimeoutError() on str at line 2 of 'construct' | unknown |
| builtin.TypeError | declined | call at line 2; TypeError() on str at line 2 of 'construct' | unknown |
| builtin.UnboundLocalError | declined | call at line 2; UnboundLocalError() on str at line 2 of 'construct' | unknown |
| builtin.UnicodeDecodeError | declined | constant b'x' at line 2; constant b'x' at line 2 of 'construct' | unknown |
| builtin.UnicodeEncodeError | declined | call at line 2; UnicodeEncodeError() on str, str, int, int, str at line 2 of 'construct' | unknown |
| builtin.UnicodeError | declined | call at line 2; UnicodeError() on str at line 2 of 'construct' | unknown |
| builtin.UnicodeTranslateError | declined | call at line 2; UnicodeTranslateError() on str, int, int, str at line 2 of 'construct' | unknown |
| builtin.UnicodeWarning | declined | call at line 2; UnicodeWarning() on str at line 2 of 'construct' | unknown |
| builtin.UserWarning | declined | call at line 2; UserWarning() on str at line 2 of 'construct' | unknown |
| builtin.ValueError | declined | call at line 2; ValueError() on str at line 2 of 'construct' | unknown |
| builtin.Warning | declined | call at line 2; Warning() on str at line 2 of 'construct' | unknown |
| builtin.WindowsError | declined | call at line 2; WindowsError() on str at line 2 of 'construct' | unknown |
| builtin.ZeroDivisionError | declined | call at line 2; ZeroDivisionError() on str at line 2 of 'construct' | unknown |
| builtin.abs | native |  | unknown |
| builtin.aiter | declined | as a region: aiter() on AsyncRange at line 2 of 'construct' | unknown |
| builtin.all | native |  | unknown |
| builtin.anext | declined | call at line 2; anext() on AsyncRange at line 2 of 'construct' | unknown |
| builtin.any | native |  | unknown |
| builtin.ascii | declined | as a region: ascii() on str at line 2 of 'construct' | unknown |
| builtin.bin | declined | as a region: bin() on int at line 2 of 'construct' | unknown |
| builtin.bool | declined | as a region: bool() on int at line 2 of 'construct' | unknown |
| builtin.breakpoint | declined | as a region: breakpoint() on nothing at line 2 of 'construct' | unknown |
| builtin.bytearray | declined | constant b'abc' at line 2; constant b'abc' at line 2 of 'construct' | unknown |
| builtin.bytes | declined | as a region: bytes() on list[int] at line 2 of 'construct' | 1.255327471 |
| builtin.callable | declined | as a region: name 'helper' used as a value at line 2 of 'construct' | unknown |
| builtin.chr | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| builtin.classmethod | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| builtin.compile | declined | as a region: compile() on str, str, str at line 2 of 'construct' | unknown |
| builtin.complex | declined | as a region: complex() on int, int at line 2 of 'construct' | unknown |
| builtin.copyright | declined | as a region: copyright() on nothing at line 2 of 'construct' | unknown |
| builtin.credits | declined | as a region: credits() on nothing at line 2 of 'construct' | unknown |
| builtin.delattr | declined | as a region: a 'Box' object with attributes its __init__ does not set | unknown |
| builtin.dict | declined | as a region: dict() on list[(int, int)] at line 2 of 'construct' | unknown |
| builtin.dir | declined | as a region: dir() on int at line 2 of 'construct' | unknown |
| builtin.divmod | declined | as a region: divmod() on int, int at line 2 of 'construct' | unknown |
| builtin.enumerate | native |  | unknown |
| builtin.eval | declined | as a region: eval() on str, dict[nothing, nothing] at line 2 of 'construct' | unknown |
| builtin.exec | declined | as a region: exec() on str, dict[nothing, nothing] at line 2 of 'construct' | unknown |
| builtin.exit | declined | call at line 2; exit() on int at line 2 of 'construct' | unknown |
| builtin.filter | declined | as a region: filter() on None, list[int] at line 2 of 'construct' | unknown |
| builtin.float | native |  | unknown |
| builtin.format | declined | as a region: format() on int, str at line 2 of 'construct' | unknown |
| builtin.frozenset | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| builtin.getattr | declined | as a region: getattr() on Box, str at line 2 of 'construct' | unknown |
| builtin.globals | declined | as a region: globals() on nothing at line 2 of 'construct' | unknown |
| builtin.hasattr | declined | as a region: hasattr() on Box, str at line 2 of 'construct' | unknown |
| builtin.hash | declined | as a region: hash() on (int, int) at line 2 of 'construct' | unknown |
| builtin.help | declined | as a region: name 'abs' used as a value at line 2 of 'construct' | unknown |
| builtin.hex | declined | as a region: hex() on int at line 2 of 'construct' | unknown |
| builtin.id | declined | as a region: id() on Box at line 2 of 'construct' | unknown |
| builtin.input | declined | as a region: input() on str at line 2 of 'construct' | unknown |
| builtin.int | declined | as a region: int() on str at line 2 of 'construct' | unknown |
| builtin.isinstance | native |  | unknown |
| builtin.issubclass | declined | as a region: name 'bool' used as a value at line 2 of 'construct' | unknown |
| builtin.iter | declined | as a region: iter() on list[int] at line 2 of 'construct' | unknown |
| builtin.len | native |  | unknown |
| builtin.license | declined | as a region: license() on nothing at line 2 of 'construct' | unknown |
| builtin.list | native |  | unknown |
| builtin.locals | declined | as a region: locals() on nothing at line 2 of 'construct' | unknown |
| builtin.map | declined | as a region: name 'abs' used as a value at line 2 of 'construct' | unknown |
| builtin.max | native |  | unknown |
| builtin.memoryview | declined | constant b'abc' at line 2; constant b'abc' at line 2 of 'construct' | unknown |
| builtin.min | native |  | unknown |
| builtin.next | declined | as a region: iter() on list[int] at line 2 of 'construct' | unknown |
| builtin.object | declined | as a region: object() on nothing at line 2 of 'construct' | unknown |
| builtin.oct | declined | as a region: oct() on int at line 2 of 'construct' | unknown |
| builtin.open | declined | as a region: With at line 2 of 'construct' | unknown |
| builtin.ord | native |  | unknown |
| builtin.pow | declined | as a region: pow() on int, int at line 2 of 'construct' | unknown |
| builtin.print | declined | as a region: print() on str at line 2 of 'construct' | unknown |
| builtin.property | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| builtin.quit | declined | call at line 2; quit() on int at line 2 of 'construct' | unknown |
| builtin.range | native |  | unknown |
| builtin.repr | declined | as a region: repr() on list[int] at line 2 of 'construct' | unknown |
| builtin.reversed | declined | as a region: reversed() on list[int] at line 2 of 'construct' | unknown |
| builtin.round | declined | as a region: round() on float, int at line 2 of 'construct' | unknown |
| builtin.set | native |  | unknown |
| builtin.setattr | declined | as a region: setattr() on Box, str, int at line 2 of 'construct' | unknown |
| builtin.slice | declined | call at line 2; slice() on int, int, int at line 2 of 'construct' | unknown |
| builtin.sorted | declined | as a region: sorted() on list[int] at line 2 of 'construct' | unknown |
| builtin.staticmethod | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| builtin.str | declined | as a region: heap str/bytes ownership is not proved; use the immutable lifter | unknown |
| builtin.sum | native |  | unknown |
| builtin.super | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| builtin.tuple | declined | as a region: tuple() on list[int] at line 2 of 'construct' | unknown |
| builtin.type | declined | call at line 2; type() on int at line 2 of 'construct' | unknown |
| builtin.vars | declined | as a region: vars() on Box at line 2 of 'construct' | unknown |
| builtin.zip | declined | as a region: zip() on list[int], list[int] at line 2 of 'construct' | unknown |
| method.str.capitalize | declined | as a region: str method 'capitalize' at line 3 of 'construct' | unknown |
| method.str.casefold | declined | as a region: str method 'casefold' at line 3 of 'construct' | unknown |
| method.str.center | declined | as a region: str method 'center' at line 3 of 'construct' | unknown |
| method.str.count | native |  | unknown |
| method.str.encode | declined | as a region: str method 'encode' at line 3 of 'construct' | unknown |
| method.str.endswith | native |  | unknown |
| method.str.expandtabs | declined | as a region: str method 'expandtabs' at line 3 of 'construct' | unknown |
| method.str.find | native |  | unknown |
| method.str.format | declined | as a region: str method 'format' at line 3 of 'construct' | unknown |
| method.str.format_map | declined | as a region: str method 'format_map' at line 3 of 'construct' | unknown |
| method.str.index | native |  | unknown |
| method.str.isalnum | native |  | unknown |
| method.str.isalpha | native |  | unknown |
| method.str.isascii | native |  | unknown |
| method.str.isdecimal | native |  | unknown |
| method.str.isdigit | native |  | unknown |
| method.str.isidentifier | native |  | unknown |
| method.str.islower | native |  | unknown |
| method.str.isnumeric | native |  | unknown |
| method.str.isprintable | native |  | unknown |
| method.str.isspace | native |  | unknown |
| method.str.istitle | native |  | unknown |
| method.str.isupper | native |  | unknown |
| method.str.join | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.ljust | declined | as a region: str method 'ljust' at line 3 of 'construct' | unknown |
| method.str.lower | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.lstrip | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.maketrans | declined | as a region: str method 'maketrans' at line 3 of 'construct' | unknown |
| method.str.partition | declined | as a region: str method 'partition' at line 3 of 'construct' | unknown |
| method.str.removeprefix | declined | as a region: str method 'removeprefix' at line 3 of 'construct' | unknown |
| method.str.removesuffix | declined | as a region: str method 'removesuffix' at line 3 of 'construct' | unknown |
| method.str.replace | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.rfind | native |  | unknown |
| method.str.rindex | native |  | unknown |
| method.str.rjust | declined | as a region: str method 'rjust' at line 3 of 'construct' | unknown |
| method.str.rpartition | declined | as a region: str method 'rpartition' at line 3 of 'construct' | unknown |
| method.str.rsplit | declined | as a region: str method 'rsplit' at line 3 of 'construct' | unknown |
| method.str.rstrip | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.split | declined | as a region: heap str/bytes result ownership is not proved | 0.000245116 |
| method.str.splitlines | declined | as a region: str method 'splitlines' at line 3 of 'construct' | unknown |
| method.str.startswith | native |  | unknown |
| method.str.strip | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.swapcase | declined | as a region: str method 'swapcase' at line 3 of 'construct' | unknown |
| method.str.title | declined | as a region: str method 'title' at line 3 of 'construct' | unknown |
| method.str.translate | declined | as a region: str method 'translate' at line 3 of 'construct' | unknown |
| method.str.upper | declined | as a region: heap str/bytes result ownership is not proved | unknown |
| method.str.zfill | declined | as a region: str method 'zfill' at line 3 of 'construct' | unknown |
| method.bytes.capitalize | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.center | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.count | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.decode | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.endswith | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.expandtabs | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.find | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.fromhex | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.hex | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.index | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.isalnum | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.isalpha | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.isascii | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.isdigit | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.islower | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.isspace | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.istitle | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.isupper | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.join | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.ljust | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.lower | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.lstrip | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.maketrans | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.partition | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.removeprefix | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.removesuffix | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.replace | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.rfind | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.rindex | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.rjust | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.rpartition | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.rsplit | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.rstrip | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.split | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.splitlines | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.startswith | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.strip | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.swapcase | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.title | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.translate | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.upper | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytes.zfill | declined | as a region: constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.append | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.capitalize | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.center | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.clear | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.copy | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.count | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.decode | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.endswith | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.expandtabs | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.extend | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.find | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.fromhex | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.hex | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.index | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.insert | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.isalnum | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.isalpha | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.isascii | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.isdigit | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.islower | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.isspace | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.istitle | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.isupper | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.join | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.ljust | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.lower | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.lstrip | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.maketrans | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.partition | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.pop | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.remove | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.removeprefix | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.removesuffix | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.replace | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.resize | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.reverse | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.rfind | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.rindex | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.rjust | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.rpartition | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.rsplit | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.rstrip | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.split | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.splitlines | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.startswith | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.strip | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.swapcase | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.title | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.translate | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.upper | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.bytearray.zfill | declined | constant b'Abc abc 12' at line 2; constant b'Abc abc 12' at line 2 of 'construct' | unknown |
| method.list.append | native |  | unknown |
| method.list.clear | native |  | unknown |
| method.list.copy | declined | as a region: list method 'copy' at line 3 of 'construct' | unknown |
| method.list.count | native |  | unknown |
| method.list.extend | native |  | unknown |
| method.list.index | native |  | unknown |
| method.list.insert | native |  | unknown |
| method.list.pop | native |  | unknown |
| method.list.remove | native |  | unknown |
| method.list.reverse | native |  | unknown |
| method.list.sort | declined | as a region: list method 'sort' at line 3 of 'construct' | unknown |
| method.tuple.count | declined | as a region: method 'count' of (int, int, int) at line 3 of 'construct' | unknown |
| method.tuple.index | declined | as a region: method 'index' of (int, int, int) at line 3 of 'construct' | unknown |
| method.dict.clear | native |  | unknown |
| method.dict.copy | native |  | unknown |
| method.dict.fromkeys | declined | as a region: dict method 'fromkeys' at line 3 of 'construct' | unknown |
| method.dict.get | native |  | unknown |
| method.dict.items | declined | as a region: dict method 'items' at line 3 of 'construct' | unknown |
| method.dict.keys | declined | as a region: dict method 'keys' at line 3 of 'construct' | unknown |
| method.dict.pop | native |  | unknown |
| method.dict.popitem | declined | as a region: dict method 'popitem' at line 3 of 'construct' | unknown |
| method.dict.setdefault | native |  | unknown |
| method.dict.update | native |  | unknown |
| method.dict.values | declined | as a region: dict method 'values' at line 3 of 'construct' | unknown |
| method.set.add | native |  | unknown |
| method.set.clear | native |  | unknown |
| method.set.copy | declined | as a region: set method 'copy' at line 3 of 'construct' | unknown |
| method.set.difference | declined | as a region: set method 'difference' at line 3 of 'construct' | unknown |
| method.set.difference_update | declined | as a region: set method 'difference_update' at line 3 of 'construct' | unknown |
| method.set.discard | native |  | unknown |
| method.set.intersection | declined | as a region: set method 'intersection' at line 3 of 'construct' | unknown |
| method.set.intersection_update | declined | as a region: set method 'intersection_update' at line 3 of 'construct' | unknown |
| method.set.isdisjoint | declined | as a region: set method 'isdisjoint' at line 3 of 'construct' | unknown |
| method.set.issubset | declined | as a region: set method 'issubset' at line 3 of 'construct' | unknown |
| method.set.issuperset | declined | as a region: set method 'issuperset' at line 3 of 'construct' | unknown |
| method.set.pop | declined | as a region: set method 'pop' at line 3 of 'construct' | unknown |
| method.set.remove | native |  | unknown |
| method.set.symmetric_difference | declined | as a region: set method 'symmetric_difference' at line 3 of 'construct' | unknown |
| method.set.symmetric_difference_update | declined | as a region: set method 'symmetric_difference_update' at line 3 of 'construct' | unknown |
| method.set.union | declined | as a region: set method 'union' at line 3 of 'construct' | unknown |
| method.set.update | declined | as a region: set method 'update' at line 3 of 'construct' | unknown |
| method.frozenset.copy | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.difference | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.intersection | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.isdisjoint | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.issubset | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.issuperset | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.symmetric_difference | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.frozenset.union | declined | as a region: frozenset() on list[int] at line 2 of 'construct' | unknown |
| method.int.as_integer_ratio | declined | as a region: method 'as_integer_ratio' of int at line 3 of 'construct' | unknown |
| method.int.bit_count | native |  | unknown |
| method.int.bit_length | declined | as a region: method 'bit_length' of int at line 3 of 'construct' | unknown |
| method.int.conjugate | declined | as a region: method 'conjugate' of int at line 3 of 'construct' | unknown |
| method.int.from_bytes | declined | as a region: method 'from_bytes' of int at line 3 of 'construct' | unknown |
| method.int.is_integer | declined | as a region: method 'is_integer' of int at line 3 of 'construct' | unknown |
| method.int.to_bytes | declined | as a region: method 'to_bytes' of int at line 3 of 'construct' | unknown |
| method.float.as_integer_ratio | declined | as a region: method 'as_integer_ratio' of float at line 3 of 'construct' | unknown |
| method.float.conjugate | declined | as a region: method 'conjugate' of float at line 3 of 'construct' | unknown |
| method.float.from_number | declined | as a region: method 'from_number' of float at line 3 of 'construct' | unknown |
| method.float.fromhex | declined | as a region: method 'fromhex' of float at line 3 of 'construct' | unknown |
| method.float.hex | declined | as a region: method 'hex' of float at line 3 of 'construct' | unknown |
| method.float.is_integer | declined | as a region: method 'is_integer' of float at line 3 of 'construct' | unknown |
| stdlib.math.sqrt | native |  | unknown |
| stdlib.math.frexp | declined | as a region: math.frexp at line 2 of 'construct' | unknown |
| stdlib.math.gcd | declined | as a region: math.gcd at line 2 of 'construct' | unknown |
| stdlib.math.sin | native |  | unknown |
| stdlib.itertools.chain | declined | as a region: 'chain' customises allocation | unknown |
| stdlib.itertools.repeat | declined | as a region: 'repeat' customises allocation | unknown |
| stdlib.itertools.product | declined | as a region: 'product' customises allocation | unknown |
| stdlib.functools.reduce | declined | as a region: a call of 'functools.reduce' at line 2 of 'construct' | unknown |
| stdlib.functools.partial | declined | as a region: 'partial' customises allocation | unknown |
| stdlib.collections.Counter | declined | as a region: 'Counter' customises allocation | unknown |
| stdlib.collections.deque | declined | as a region: 'deque' customises allocation | unknown |
| stdlib.collections.defaultdict | declined | as a region: 'defaultdict' customises allocation | unknown |
| stdlib.operator.add | native |  | unknown |
| stdlib.operator.itemgetter | declined | as a region: 'itemgetter' customises allocation | unknown |
| stdlib.re.match | declined | as a region: an argument of type type | unknown |
| stdlib.re.sub | declined | as a region: a call of 'sub' that relies on a default that is _ZeroSentinel at line 2 of 'construct' | unknown |
| stdlib.struct.pack | declined | as a region: a call of 'struct.pack' at line 2 of 'construct' | unknown |
| stdlib.struct.unpack | declined | as a region: a call of 'struct.unpack' at line 2 of 'construct' | unknown |
| statement.bare_except | declined | as a region: a check at construct line 4 sent it back to Python | unknown |
| statement.except_as | declined | as a region: a check at construct line 4 sent it back to Python | unknown |
| statement.raise_suppressed | declined | Try at line 2; runtime guard at ('construct', 4) | unknown |
| statement.raise_context | declined | Try at line 2; runtime guard at ('construct', 4) | unknown |
| statement.generator_return | declined | as a region: generator 'construct' returns a value at line 3 | unknown |
| async.with_multiple | declined | as a region: 'construct' uses async with, or yield outside a generator | unknown |
| async.for_else | declined | as a region: async for ... else, or a loop target that is not names at line 3 of 'construct' | unknown |
| builtin.anext_default | declined | call at line 2; anext() on AsyncRange, int at line 2 of 'construct' | unknown |
| builtin.anext_exhausted | declined | call at line 2; anext() on AsyncRange at line 2 of 'construct' | unknown |
| literal.format | declined | as a region: str method 'format' at line 2 of 'construct' | unknown |
| literal.format_map | declined | as a region: str method 'format_map' at line 2 of 'construct' | unknown |
| comparison.chain_true | native |  | unknown |
| boundary.int_overflow | declined | as a region: it handed every captured call back to Python | unknown |
| boundary.int_large | declined | as a region: an int argument too large for 64 bits | unknown |
| boundary.divide_zero | declined | runtime guard at ('construct', 3) | unknown |
| boundary.negative_shift | declined | operator LShift on int and int at line 2 of 'construct' | unknown |
| boundary.index | declined | runtime guard at ('construct', 3) | unknown |
| alias.return_argument | native |  | unknown |
| alias.mutation | native |  | unknown |
| order.arguments | native |  | unknown |
| order.and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| order.or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| order.conditional | native |  | unknown |
| order.chain | native |  | unknown |
| order.chain_short | native |  | unknown |
| order.dict | native |  | unknown |
| order.unpack | declined | as a region: *list[nothing] as arguments at line 2 of 'construct' | unknown |
| stdlib.re.compile | declined | as a region: an argument of type type | unknown |
| stdlib.re.escape | declined | as a region: isinstance() with something other than one class at line 5 of 'escape' | unknown |
| stdlib.re.findall | declined | as a region: an argument of type type | unknown |
| stdlib.re.finditer | declined | as a region: an argument of type type | unknown |
| stdlib.re.purge | declined | as a region: name '_compile_template' used as a value at line 5 of 'purge' | unknown |
| stdlib.re.search | declined | as a region: an argument of type type | unknown |
| stdlib.re.split | declined | as a region: a call of 'split' that relies on a default that is _ZeroSentinel at line 2 of 'construct' | unknown |
| stdlib.collections.namedtuple | declined | as a region: 'namedtuple' declares globals or defines functions inside itself | unknown |
| stdlib.functools.cache | declined | as a region: name 'helper' used as a value at line 2 of 'construct' | unknown |
| stdlib.functools.lru_cache | declined | as a region: 'lru_cache' declares globals or defines functions inside itself | unknown |
| stdlib.functools.wraps | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| stdlib.functools.update_wrapper | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| stdlib.functools.singledispatch | declined | as a region: 'singledispatch' declares globals or defines functions inside itself | unknown |
| stdlib.functools.cached_property | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| stdlib.functools.total_ordering | declined | as a region: 'construct' declares globals or defines functions inside itself | unknown |
| review.mixed0.eq | declined | as a region: a check at construct line 3 sent it back to Python | unknown |
| review.mixed0.gt | declined | as a region: a check at construct line 3 sent it back to Python | unknown |
| review.mixed0.le | declined | as a region: a check at construct line 3 sent it back to Python | unknown |
| review.mixed1.eq | declined | as a region: a check at construct line 3 sent it back to Python | unknown |
| review.mixed1.gt | declined | as a region: a check at construct line 3 sent it back to Python | unknown |
| review.mixed1.le | declined | as a region: a check at construct line 3 sent it back to Python | unknown |
| review.tuple_nan_shared | declined | as a region: arithmetic on (float) at line 2 of 'construct' | unknown |
| review.literal_index_high | declined | runtime guard at ('construct', 3) | unknown |
| review.literal_index_low | declined | runtime guard at ('construct', 3) | unknown |
| review.chain_call.0 | native |  | unknown |
| review.chain_call.1 | native |  | unknown |
| review.chain_call.2 | native |  | unknown |
| review.identity.float_or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| review.identity.negative_zero_and | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| review.identity.int_or | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| review.identity.float_right | declined | as a region: and/or whose result is used as a value, on values that are not bool at line 2 of 'construct' | unknown |
| range_value.assigned | native |  | unknown |
| range_value.repeated | native |  | unknown |
| range_value.argument | native |  | unknown |
| range_value.internal_argument | native |  | unknown |
| range_value.internal_return | native |  | unknown |
| range_value.length | native |  | unknown |
| range_value.index | native |  | unknown |
| range_value.contains | native |  | unknown |
| range_value.zero_step_unused | declined | Dict at line 2; runtime guard at ('construct', 4) | unknown |
| range_value.huge | declined | Dict at line 2 | unknown |

## Weight limits

Associations use retained wave14 own-self weights and actual first declines. Related rows repeat the same frames; row weights must not be summed. Primary hot-entry envelopes overlap and are retained individually in heldout-evidence.json. Base64 dominates bytes; FastAPI dominates With and its busy-wait is instrumentation sensitive. Leave-largest-program-out figures and top contributors are in heldout-evidence.json. No new wave14 profile was run to reconstruct unavailable C-target counts. All public builtin functions/types and public methods of the requested ten types are exercised.

The AST/keyword inventory is generated-source coverage, not a support verdict. Incompatible operator/type combinations intentionally test exception and fallback behavior. Native generator rows apply to complete draining; generator-return rows also compare StopIteration.value.
