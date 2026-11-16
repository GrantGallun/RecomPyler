; ModuleID = 'dict_loop'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.pickledata.57947fbe6c9f43dde2e3c0d5e383f78ecc433807 = internal constant [125 x i8] c"\80\04\95r\00\00\00\00\00\00\00\8C\08builtins\94\8C\0CRuntimeError\94\93\94\8CMmissing Environment: _ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject\94\85\94N\87\94."
@.const.pickledata.57947fbe6c9f43dde2e3c0d5e383f78ecc433807.sha1 = internal constant [20 x i8] c"W\94\7F\BEl\9FC\DD\E2\E3\C0\D5\E3\83\F7\8E\CCC8\07"
@.const.picklebuf.57947fbe6c9f43dde2e3c0d5e383f78ecc433807 = internal constant { ptr, i32, ptr, ptr, i32 } { ptr @.const.pickledata.57947fbe6c9f43dde2e3c0d5e383f78ecc433807, i32 125, ptr @.const.pickledata.57947fbe6c9f43dde2e3c0d5e383f78ecc433807.sha1, ptr null, i32 0 }
@".const.`env.consts` is NULL in `read_const`" = internal constant [37 x i8] c"`env.consts` is NULL in `read_const`\00"
@".const.global name 'dict' is not defined" = internal constant [34 x i8] c"global name 'dict' is not defined\00"
@PyExc_NameError = external global i8
@".const.name 'orig_dict' is not defined" = internal constant [32 x i8] c"name 'orig_dict' is not defined\00"
@".const.name '$58for_iter.1' is not defined" = internal constant [36 x i8] c"name '$58for_iter.1' is not defined\00"
@".const.name '$58for_iter.2' is not defined" = internal constant [36 x i8] c"name '$58for_iter.2' is not defined\00"
@".const.name '$58for_iter.3' is not defined" = internal constant [36 x i8] c"name '$58for_iter.3' is not defined\00"
@.const.pickledata.3448b75794b9e56c4df6e69aa3486608f50fe403 = internal constant [42 x i8] c"\80\04\95\1F\00\00\00\00\00\00\00\8C\08builtins\94\8C\0AValueError\94\93\94)N\87\94."
@.const.pickledata.3448b75794b9e56c4df6e69aa3486608f50fe403.sha1 = internal constant [20 x i8] c"4H\B7W\94\B9\E5lM\F6\E6\9A\A3Hf\08\F5\0F\E4\03"
@.const.picklebuf.3448b75794b9e56c4df6e69aa3486608f50fe403 = internal constant { ptr, i32, ptr, ptr, i32 } { ptr @.const.pickledata.3448b75794b9e56c4df6e69aa3486608f50fe403, i32 42, ptr @.const.pickledata.3448b75794b9e56c4df6e69aa3486608f50fe403.sha1, ptr null, i32 0 }
@".const.name 'random_source' is not defined" = internal constant [36 x i8] c"name 'random_source' is not defined\00"
@".const.global name 'sys' is not defined" = internal constant [33 x i8] c"global name 'sys' is not defined\00"
@".const.global name 'isinstance' is not defined" = internal constant [40 x i8] c"global name 'isinstance' is not defined\00"
@".const.global name 'int' is not defined" = internal constant [33 x i8] c"global name 'int' is not defined\00"
@".const.global name 'bytes' is not defined" = internal constant [35 x i8] c"global name 'bytes' is not defined\00"
@".const.global name 'str' is not defined" = internal constant [33 x i8] c"global name 'str' is not defined\00"
@".const.global name 'bool' is not defined" = internal constant [34 x i8] c"global name 'bool' is not defined\00"
@".const.global name 'type' is not defined" = internal constant [34 x i8] c"global name 'type' is not defined\00"
@.const.dict_loop = internal constant [10 x i8] c"dict_loop\00"
@_ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject = common local_unnamed_addr global ptr null
@PyExc_RuntimeError = external global i8
@".const.missing Environment: _ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject" = internal constant [78 x i8] c"missing Environment: _ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject\00"
@_Py_NoneStruct = external global i8
@".const.Error creating Python tuple from runtime exception arguments" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"

define range(i32 -1, 2) i32 @_ZN9prototype9dict_loopB2v5E8pyobject8pyobject(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr %arg.orig_dict, ptr %arg.random_source) local_unnamed_addr {
entry:
  %.6 = load ptr, ptr @_ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject, align 8
  %.7 = icmp eq ptr %.6, null
  br i1 %.7, label %entry.if, label %B0, !prof !0

B0:                                               ; preds = %entry
  %.16 = getelementptr i8, ptr %.6, i64 16
  tail call void @Py_IncRef(ptr %arg.orig_dict)
  tail call void @Py_IncRef(ptr %arg.random_source)
  %.35 = load ptr, ptr %.16, align 8
  %.36 = getelementptr i8, ptr %.6, i64 24
  %.37 = load ptr, ptr %.36, align 8
  %.41.not = icmp eq ptr %.37, null
  br i1 %.41.not, label %B0.endif.thread, label %B0.endif

B212:                                             ; preds = %B206.endif.endif.endif.en...endif.19.endif
  tail call void @Py_DecRef(ptr nonnull %.1851)
  %sunkaddr = getelementptr i8, ptr %.6, i64 16
  %.1902 = load ptr, ptr %sunkaddr, align 8
  %sunkaddr6448 = getelementptr i8, ptr %.6, i64 24
  %.1904 = load ptr, ptr %sunkaddr6448, align 8
  %.1908.not = icmp eq ptr %.1904, null
  br i1 %.1908.not, label %B212.endif.thread, label %B212.endif

B254:                                             ; preds = %B206.endif.endif.endif.en...endif.19.endif
  tail call void @Py_DecRef(ptr nonnull %.831)
  br label %B255

B255:                                             ; preds = %B212.endif.endif.endif.en...endif.endif.endif.endif, %B254
  %.2133.sink = phi ptr [ %.1851, %B254 ], [ %.2133, %B212.endif.endif.endif.en...endif.endif.endif.endif ]
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.2133.sink)
  br label %B62.endif

common.ret:                                       ; preds = %B257.endif.endif, %B212.endif.endif.endif.en...if.1, %B212.endif.endif.endif.en...if, %B212.endif.endif.endif.endif.endif.if, %B212.endif.endif.if.endif...endif.if, %B212.endif.endif.if.endif...if, %B212.endif.endif.if.endif.endif.endif.if, %B212.endif.endif.if.endif.if, %B212.endif.if, %B206.endif.endif.endif.en...if.19, %B206.endif.endif.endif.en...endif.18.if, %B206.endif.endif.endif.en...if.18, %B206.endif.endif.endif.en...endif.17.if, %B206.endif.endif.endif.en...endif.16.if.endif.if, %B206.endif.endif.endif.en...if.16, %B206.endif.endif.endif.en...endif.15.endif.if, %B206.endif.endif.endif.en...endif.14.endif.if, %B206.endif.endif.endif.en...endif.13.endif.if, %B206.endif.endif.endif.en...endif.13.if, %B206.endif.endif.endif.en...endif.12.endif.if, %B206.endif.endif.endif.en...if.12, %B206.endif.endif.endif.en...endif.11.if, %B206.endif.endif.endif.en...endif.10.if, %B206.endif.endif.endif.en...if.10, %B206.endif.endif.endif.en...endif.9.endif.if, %B206.endif.endif.endif.en...if.9, %B206.endif.endif.endif.en...endif.7.endif.if, %B206.endif.endif.endif.en...if.8.endif.endif.if, %B206.endif.endif.endif.en...if.8.endif.if, %B206.endif.endif.endif.en...if.7.endif.endif.endif.if, %B206.endif.endif.endif.en...if.7.endif.if, %B206.endif.endif.endif.en...endif.5.endif.endif.if, %B206.endif.endif.endif.en...endif.6.if.endif.endif.if, %B206.endif.endif.endif.en...endif.6.if.endif.if, %B206.endif.endif.endif.en...if.6, %B206.endif.endif.endif.en...endif.5.if.endif.if, %B206.endif.endif.endif.en...if.5, %B206.endif.endif.endif.en...endif.4.endif.if, %B206.endif.endif.endif.en...endif.3.endif.endif.if, %B206.endif.endif.endif.en...endif.3.endif.if, %B206.endif.endif.endif.en...endif.2.endif.endif.if, %B206.endif.endif.endif.en...endif.2.endif.if, %B206.endif.endif.endif.en...if.2, %B206.endif.endif.endif.en...endif.1.endif.if, %B206.endif.endif.endif.en...endif.1.if, %B206.endif.endif.endif.en...endif.endif.endif.if, %B206.endif.endif.endif.en...if, %B206.endif.endif.endif.endif.endif.endif.endif.if, %B206.endif.endif.endif.endif.endif.if, %B206.endif.endif.endif.endif.if, %B206.endif.endif.if, %B206.endif.if, %B62.endif.endif.endif.endif.endif.if, %B62.endif.endif.endif.endif.if, %B62.endif.endif.if, %B62.endif.else.if, %B58.endif.if, %B0.endif.endif.endif.endi...endif.endif.if, %B0.endif.endif.endif.endi...if, %B0.endif.endif.endif.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.if, %B0.endif.endif.if.endif.e...if, %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if, %B0.endif.endif.if.endif.endif.endif.if, %B0.endif.endif.if.endif.if, %B0.endif.if, %entry.if
  %common.ret.op = phi i32 [ 1, %entry.if ], [ -1, %B0.endif.if ], [ -1, %B0.endif.endif.if.endif.if ], [ -1, %B0.endif.endif.if.endif.endif.endif.if ], [ -1, %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if ], [ -1, %B0.endif.endif.if.endif.e...if ], [ -1, %B0.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...if ], [ -1, %B0.endif.endif.endif.endi...endif.endif.if ], [ -1, %B58.endif.if ], [ -1, %B62.endif.else.if ], [ -1, %B62.endif.endif.if ], [ -1, %B62.endif.endif.endif.endif.if ], [ -1, %B62.endif.endif.endif.endif.endif.if ], [ -1, %B206.endif.if ], [ 1, %B206.endif.endif.if ], [ -1, %B206.endif.endif.endif.endif.if ], [ -1, %B206.endif.endif.endif.endif.endif.if ], [ -1, %B206.endif.endif.endif.endif.endif.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...if ], [ -1, %B206.endif.endif.endif.en...endif.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.1.if ], [ -1, %B206.endif.endif.endif.en...endif.1.endif.if ], [ -1, %B206.endif.endif.endif.en...if.2 ], [ -1, %B206.endif.endif.endif.en...endif.2.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.2.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.3.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.3.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.4.endif.if ], [ -1, %B206.endif.endif.endif.en...if.5 ], [ -1, %B206.endif.endif.endif.en...endif.5.if.endif.if ], [ -1, %B206.endif.endif.endif.en...if.6 ], [ -1, %B206.endif.endif.endif.en...endif.6.if.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.6.if.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.5.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...if.7.endif.if ], [ -1, %B206.endif.endif.endif.en...if.7.endif.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...if.8.endif.if ], [ -1, %B206.endif.endif.endif.en...if.8.endif.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.7.endif.if ], [ -1, %B206.endif.endif.endif.en...if.9 ], [ -1, %B206.endif.endif.endif.en...endif.9.endif.if ], [ -1, %B206.endif.endif.endif.en...if.10 ], [ -1, %B206.endif.endif.endif.en...endif.10.if ], [ -1, %B206.endif.endif.endif.en...endif.11.if ], [ -1, %B206.endif.endif.endif.en...if.12 ], [ -1, %B206.endif.endif.endif.en...endif.12.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.13.if ], [ -1, %B206.endif.endif.endif.en...endif.13.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.14.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.15.endif.if ], [ -1, %B206.endif.endif.endif.en...if.16 ], [ -1, %B206.endif.endif.endif.en...endif.16.if.endif.if ], [ -1, %B206.endif.endif.endif.en...endif.17.if ], [ -1, %B206.endif.endif.endif.en...if.18 ], [ -1, %B206.endif.endif.endif.en...endif.18.if ], [ -1, %B206.endif.endif.endif.en...if.19 ], [ -1, %B212.endif.if ], [ -1, %B212.endif.endif.if.endif.if ], [ -1, %B212.endif.endif.if.endif.endif.endif.if ], [ -1, %B212.endif.endif.if.endif...if ], [ -1, %B212.endif.endif.if.endif...endif.if ], [ -1, %B212.endif.endif.endif.endif.endif.if ], [ -1, %B212.endif.endif.endif.en...if ], [ -1, %B212.endif.endif.endif.en...if.1 ], [ 0, %B257.endif.endif ]
  ret i32 %common.ret.op

entry.if:                                         ; preds = %entry
  store ptr @.const.picklebuf.57947fbe6c9f43dde2e3c0d5e383f78ecc433807, ptr %excinfo, align 8, !numba_exception_output !1
  br label %common.ret

B0.endif.thread:                                  ; preds = %B0
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.if

B0.endif:                                         ; preds = %B0
  %.43 = tail call ptr @PyList_GetItem(ptr nonnull %.37, i64 0)
  %.49 = icmp eq ptr %.43, null
  br i1 %.49, label %B0.endif.if, label %B0.endif.endif, !prof !2

B0.endif.if:                                      ; preds = %B0.endif.thread, %B0.endif
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %arg.orig_dict)
  br label %common.ret

B0.endif.endif:                                   ; preds = %B0.endif
  tail call void @Py_IncRef(ptr nonnull %.43)
  %.57 = tail call ptr @PyDict_GetItem(ptr %.35, ptr nonnull %.43)
  tail call void @Py_IncRef(ptr %.57)
  %.59 = icmp eq ptr %.57, null
  br i1 %.59, label %B0.endif.endif.if, label %B0.endif.endif.endif

B0.endif.endif.if:                                ; preds = %B0.endif.endif
  %sunkaddr6449 = getelementptr i8, ptr %.6, i64 24
  %.62 = load ptr, ptr %sunkaddr6449, align 8
  %.66.not = icmp eq ptr %.62, null
  br i1 %.66.not, label %B0.endif.endif.if.endif.thread, label %B0.endif.endif.if.endif

B0.endif.endif.endif:                             ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif, %B0.endif.endif.if.endif.endif.endif.endif, %B0.endif.endif
  %.141 = phi ptr [ %.57, %B0.endif.endif ], [ %.104, %B0.endif.endif.if.endif.endif.endif.endif ], [ %.129, %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif ]
  %.145 = icmp eq ptr %arg.orig_dict, null
  br i1 %.145, label %B0.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.if.endif.thread:                   ; preds = %B0.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.if.endif.if

B0.endif.endif.if.endif:                          ; preds = %B0.endif.endif.if
  %.68 = tail call ptr @PyList_GetItem(ptr nonnull %.62, i64 1)
  %.74 = icmp eq ptr %.68, null
  br i1 %.74, label %B0.endif.endif.if.endif.if, label %B0.endif.endif.if.endif.endif, !prof !2

B0.endif.endif.if.endif.if:                       ; preds = %B0.endif.endif.if.endif.thread, %B0.endif.endif.if.endif
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %arg.orig_dict)
  br label %common.ret

B0.endif.endif.if.endif.endif:                    ; preds = %B0.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.68)
  %.82 = tail call ptr @PyDict_GetItem(ptr %.35, ptr nonnull %.68)
  %sunkaddr6450 = getelementptr i8, ptr %.6, i64 24
  %.84 = load ptr, ptr %sunkaddr6450, align 8
  %.88.not = icmp eq ptr %.84, null
  br i1 %.88.not, label %B0.endif.endif.if.endif.endif.endif.thread, label %B0.endif.endif.if.endif.endif.endif

B0.endif.endif.if.endif.endif.endif.thread:       ; preds = %B0.endif.endif.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.if.endif.endif.endif.if

B0.endif.endif.if.endif.endif.endif:              ; preds = %B0.endif.endif.if.endif.endif
  %.90 = tail call ptr @PyList_GetItem(ptr nonnull %.84, i64 0)
  %.96 = icmp eq ptr %.90, null
  br i1 %.96, label %B0.endif.endif.if.endif.endif.endif.if, label %B0.endif.endif.if.endif.endif.endif.endif, !prof !2

B0.endif.endif.if.endif.endif.endif.if:           ; preds = %B0.endif.endif.if.endif.endif.endif.thread, %B0.endif.endif.if.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %arg.orig_dict)
  br label %common.ret

B0.endif.endif.if.endif.endif.endif.endif:        ; preds = %B0.endif.endif.if.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.90)
  %.104 = tail call ptr @PyDict_GetItem(ptr %.82, ptr nonnull %.90)
  tail call void @Py_IncRef(ptr %.104)
  %.106 = icmp eq ptr %.104, null
  br i1 %.106, label %B0.endif.endif.if.endif.endif.endif.endif.if, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.if.endif.endif.endif.endif.if:     ; preds = %B0.endif.endif.if.endif.endif.endif.endif
  %sunkaddr6451 = getelementptr i8, ptr %.6, i64 24
  %.109 = load ptr, ptr %sunkaddr6451, align 8
  %.113.not = icmp eq ptr %.109, null
  br i1 %.113.not, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.thread, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif

B0.endif.endif.if.endif.endif.endif.endif.if.endif.thread: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if

B0.endif.endif.if.endif.endif.endif.endif.if.endif: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if
  %.115 = tail call ptr @PyList_GetItem(ptr nonnull %.109, i64 0)
  %.121 = icmp eq ptr %.115, null
  br i1 %.121, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif, !prof !2

B0.endif.endif.if.endif.endif.endif.endif.if.endif.if: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif.thread, %B0.endif.endif.if.endif.endif.endif.endif.if.endif
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %arg.orig_dict)
  br label %common.ret

B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.115)
  %.129 = tail call ptr @PyObject_GetAttr(ptr %.82, ptr nonnull %.115)
  %.130 = icmp eq ptr %.129, null
  br i1 %.130, label %B0.endif.endif.if.endif.e...if, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.if.endif.e...if:                   ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'dict' is not defined")
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %arg.orig_dict)
  br label %common.ret

B0.endif.endif.endif.if:                          ; preds = %B0.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name 'orig_dict' is not defined")
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.141)
  tail call void @Py_DecRef(ptr null)
  br label %common.ret

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif
  %.166 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr nonnull %arg.orig_dict)
  %.167 = tail call ptr @PyObject_Call(ptr nonnull %.141, ptr %.166, ptr null)
  tail call void @Py_DecRef(ptr %.166)
  %.169 = icmp eq ptr %.167, null
  br i1 %.169, label %B0.endif.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif.endif.if:              ; preds = %B0.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.141)
  tail call void @Py_DecRef(ptr nonnull %arg.orig_dict)
  br label %common.ret

B0.endif.endif.endif.endif.endif.endif.endif:     ; preds = %B0.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %arg.orig_dict)
  tail call void @Py_DecRef(ptr nonnull %.141)
  %sunkaddr6452 = getelementptr i8, ptr %.6, i64 24
  %.196 = load ptr, ptr %sunkaddr6452, align 8
  %.200.not = icmp eq ptr %.196, null
  br i1 %.200.not, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.thread, label %B0.endif.endif.endif.endif.endif.endif.endif.endif

B0.endif.endif.endif.endif.endif.endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endif.endif.endif.endif.endif.if

B0.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif
  %.202 = tail call ptr @PyList_GetItem(ptr nonnull %.196, i64 2)
  %.208 = icmp eq ptr %.202, null
  br i1 %.208, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endif.endif.endif.endif.endif.if: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.thread, %B0.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  br label %common.ret

B0.endif.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.202)
  %.216 = tail call ptr @PyObject_GetAttr(ptr nonnull %.167, ptr nonnull %.202)
  %.217 = icmp eq ptr %.216, null
  br i1 %.217, label %B0.endif.endif.endif.endi...if, label %B0.endif.endif.endif.endi...endif.endif, !prof !0

B0.endif.endif.endif.endi...if:                   ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  br label %common.ret

B0.endif.endif.endif.endi...endif.endif:          ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif
  %.237 = tail call ptr (i64, ...) @PyTuple_Pack(i64 0)
  %.238 = tail call ptr @PyObject_Call(ptr nonnull %.216, ptr %.237, ptr null)
  tail call void @Py_DecRef(ptr %.237)
  %.240 = icmp eq ptr %.238, null
  br i1 %.240, label %B0.endif.endif.endif.endi...endif.endif.if, label %B58.endif, !prof !0

B0.endif.endif.endif.endi...endif.endif.if:       ; preds = %B0.endif.endif.endif.endi...endif.endif
  tail call void @Py_DecRef(ptr nonnull %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.216)
  br label %common.ret

B58.endif:                                        ; preds = %B0.endif.endif.endif.endi...endif.endif
  tail call void @Py_DecRef(ptr nonnull %.216)
  %.266 = tail call ptr @PyObject_GetIter(ptr nonnull %.238)
  %.267 = icmp eq ptr %.266, null
  tail call void @Py_DecRef(ptr nonnull %.238)
  br i1 %.267, label %B58.endif.if, label %B58.endif.endif.endif, !prof !0

B58.endif.if:                                     ; preds = %B58.endif
  tail call void @Py_DecRef(ptr nonnull %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  br label %common.ret

B58.endif.endif.endif:                            ; preds = %B58.endif
  tail call void @Py_IncRef(ptr nonnull %.266)
  tail call void @Py_DecRef(ptr nonnull %.266)
  br label %B62.endif

B62.endif:                                        ; preds = %B255, %B58.endif.endif.endif
  %.310 = tail call ptr @PyIter_Next(ptr %.266)
  %.311 = icmp ne ptr %.310, null
  %.312 = tail call ptr @PyTuple_New(i64 2)
  br i1 %.311, label %B62.endif.endif, label %B62.endif.else

B62.endif.else:                                   ; preds = %B62.endif
  %.316 = tail call ptr @PyErr_Occurred()
  %.317.not = icmp eq ptr %.316, null
  br i1 %.317.not, label %B62.endif.else.endif, label %B62.endif.else.if, !prof !3

B62.endif.endif:                                  ; preds = %B62.endif, %B62.endif.else.endif
  %_Py_NoneStruct.sink = phi ptr [ @_Py_NoneStruct, %B62.endif.else.endif ], [ %.310, %B62.endif ]
  %0 = icmp ne ptr %.310, null
  %.327 = tail call i32 @PyTuple_SetItem(ptr %.312, i64 0, ptr nonnull %_Py_NoneStruct.sink)
  %.329 = zext i1 %0 to i32
  %.330 = tail call ptr @PyBool_FromLong(i32 %.329)
  %.331 = tail call i32 @PyTuple_SetItem(ptr %.312, i64 1, ptr %.330)
  %.335 = icmp eq ptr %.312, null
  br i1 %.335, label %B62.endif.endif.if, label %B62.endif.endif.endif.endif, !prof !0

B62.endif.else.if:                                ; preds = %B62.endif.else
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  br label %common.ret

B62.endif.else.endif:                             ; preds = %B62.endif.else
  tail call void @Py_IncRef(ptr nonnull @_Py_NoneStruct)
  br label %B62.endif.endif

B62.endif.endif.if:                               ; preds = %B62.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name '$58for_iter.1' is not defined")
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  br label %common.ret

B62.endif.endif.endif.endif:                      ; preds = %B62.endif.endif
  %.347 = tail call ptr @PyTuple_GetItem(ptr nonnull %.312, i64 0)
  tail call void @Py_IncRef(ptr %.347)
  %.366 = tail call ptr @PyTuple_GetItem(ptr nonnull %.312, i64 1)
  tail call void @Py_IncRef(ptr %.366)
  tail call void @Py_DecRef(ptr nonnull %.312)
  %.374 = icmp eq ptr %.347, null
  br i1 %.374, label %B62.endif.endif.endif.endif.if, label %B62.endif.endif.endif.endif.endif, !prof !0

B62.endif.endif.endif.endif.if:                   ; preds = %B62.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name '$58for_iter.2' is not defined")
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr %.366)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B62.endif.endif.endif.endif.endif:                ; preds = %B62.endif.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.347)
  tail call void @Py_DecRef(ptr nonnull %.347)
  %.395 = icmp eq ptr %.366, null
  br i1 %.395, label %B62.endif.endif.endif.endif.endif.if, label %B62.endif.endif.endif.endif.endif.endif, !prof !0

B62.endif.endif.endif.endif.endif.if:             ; preds = %B62.endif.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name '$58for_iter.3' is not defined")
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.347)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B62.endif.endif.endif.endif.endif.endif:          ; preds = %B62.endif.endif.endif.endif.endif
  %.409 = tail call i32 @PyObject_IsTrue(ptr nonnull %.366)
  %.410.not = icmp eq i32 %.409, 0
  br i1 %.410.not, label %B257.endif.endif, label %B206.endif

B206.endif:                                       ; preds = %B62.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.366)
  %.428 = tail call ptr @PySequence_Tuple(ptr nonnull %.347)
  %.429 = icmp eq ptr %.428, null
  br i1 %.429, label %B206.endif.if, label %B206.endif.endif, !prof !0

B206.endif.if:                                    ; preds = %B206.endif
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr nonnull %.347)
  br label %common.ret

B206.endif.endif:                                 ; preds = %B206.endif
  %.440 = tail call i64 @PyTuple_Size(ptr nonnull %.428)
  %.441.not = icmp eq i64 %.440, 2
  br i1 %.441.not, label %B206.endif.endif.endif.endif, label %B206.endif.endif.if, !prof !3

B206.endif.endif.if:                              ; preds = %B206.endif.endif
  store ptr @.const.picklebuf.3448b75794b9e56c4df6e69aa3486608f50fe403, ptr %excinfo, align 8, !numba_exception_output !1
  br label %common.ret

B206.endif.endif.endif.endif:                     ; preds = %B206.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.347)
  %.468 = tail call ptr @PyLong_FromSsize_t(i64 0)
  %.471 = icmp eq ptr %.468, null
  br i1 %.471, label %B206.endif.endif.endif.endif.if, label %B206.endif.endif.endif.endif.endif, !prof !0

B206.endif.endif.endif.endif.if:                  ; preds = %B206.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr nonnull %.428)
  br label %common.ret

B206.endif.endif.endif.endif.endif:               ; preds = %B206.endif.endif.endif.endif
  %.482 = tail call ptr @PyObject_GetItem(ptr nonnull %.428, ptr nonnull %.468)
  tail call void @Py_DecRef(ptr nonnull %.468)
  %.484 = icmp eq ptr %.482, null
  br i1 %.484, label %B206.endif.endif.endif.endif.endif.if, label %B206.endif.endif.endif.endif.endif.endif.endif, !prof !0

B206.endif.endif.endif.endif.endif.if:            ; preds = %B206.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr nonnull %.428)
  br label %common.ret

B206.endif.endif.endif.endif.endif.endif.endif:   ; preds = %B206.endif.endif.endif.endif.endif
  %.514 = tail call ptr @PyLong_FromSsize_t(i64 1)
  %.517 = icmp eq ptr %.514, null
  br i1 %.517, label %B206.endif.endif.endif.endif.endif.endif.endif.if, label %B206.endif.endif.endif.endif.endif.endif.endif.endif, !prof !0

B206.endif.endif.endif.endif.endif.endif.endif.if: ; preds = %B206.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr nonnull %.428)
  tail call void @Py_DecRef(ptr nonnull %.482)
  br label %common.ret

B206.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B206.endif.endif.endif.endif.endif.endif.endif
  %.530 = tail call ptr @PyObject_GetItem(ptr nonnull %.428, ptr nonnull %.514)
  tail call void @Py_DecRef(ptr nonnull %.514)
  %.532 = icmp eq ptr %.530, null
  br i1 %.532, label %B206.endif.endif.endif.en...if, label %B206.endif.endif.endif.en...endif.endif.endif, !prof !0

B206.endif.endif.endif.en...if:                   ; preds = %B206.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr nonnull %.428)
  tail call void @Py_DecRef(ptr nonnull %.482)
  br label %common.ret

B206.endif.endif.endif.en...endif.endif.endif:    ; preds = %B206.endif.endif.endif.endif.endif.endif.endif.endif
  %1 = icmp eq ptr %arg.random_source, null
  tail call void @Py_DecRef(ptr nonnull %.428)
  tail call void @Py_IncRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_IncRef(ptr nonnull %.530)
  tail call void @Py_DecRef(ptr nonnull %.530)
  tail call void @Py_DecRef(ptr nonnull %.530)
  br i1 %1, label %B206.endif.endif.endif.en...endif.endif.endif.if, label %B206.endif.endif.endif.en...endif.endif.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name 'random_source' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.endif.endif
  %sunkaddr6453 = getelementptr i8, ptr %.6, i64 24
  %.609 = load ptr, ptr %sunkaddr6453, align 8
  %.613.not = icmp eq ptr %.609, null
  br i1 %.613.not, label %B206.endif.endif.endif.en...endif.1.thread, label %B206.endif.endif.endif.en...endif.1

B206.endif.endif.endif.en...endif.1.thread:       ; preds = %B206.endif.endif.endif.en...endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.1.if

B206.endif.endif.endif.en...endif.1:              ; preds = %B206.endif.endif.endif.en...endif.endif.endif.endif
  %.615 = tail call ptr @PyList_GetItem(ptr nonnull %.609, i64 3)
  %.621 = icmp eq ptr %.615, null
  br i1 %.621, label %B206.endif.endif.endif.en...endif.1.if, label %B206.endif.endif.endif.en...endif.1.endif, !prof !2

B206.endif.endif.endif.en...endif.1.if:           ; preds = %B206.endif.endif.endif.en...endif.1, %B206.endif.endif.endif.en...endif.1.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.1.endif:        ; preds = %B206.endif.endif.endif.en...endif.1
  tail call void @Py_IncRef(ptr nonnull %.615)
  %.633 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.random_source, ptr nonnull %.615)
  %.634 = icmp eq ptr %.633, null
  br i1 %.634, label %B206.endif.endif.endif.en...endif.1.endif.if, label %B206.endif.endif.endif.en...endif.1.endif.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.1.endif.if:     ; preds = %B206.endif.endif.endif.en...endif.1.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.1.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.1.endif
  %.662 = tail call ptr (i64, ...) @PyTuple_Pack(i64 0)
  %.663 = tail call ptr @PyObject_Call(ptr nonnull %.633, ptr %.662, ptr null)
  tail call void @Py_DecRef(ptr %.662)
  %.665 = icmp eq ptr %.663, null
  br i1 %.665, label %B206.endif.endif.endif.en...if.2, label %B206.endif.endif.endif.en...endif.2, !prof !0

B206.endif.endif.endif.en...if.2:                 ; preds = %B206.endif.endif.endif.en...endif.1.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.633)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.2:              ; preds = %B206.endif.endif.endif.en...endif.1.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.633)
  %sunkaddr6454 = getelementptr i8, ptr %.6, i64 16
  %.684 = load ptr, ptr %sunkaddr6454, align 8
  %sunkaddr6455 = getelementptr i8, ptr %.6, i64 24
  %.686 = load ptr, ptr %sunkaddr6455, align 8
  %.690.not = icmp eq ptr %.686, null
  br i1 %.690.not, label %B206.endif.endif.endif.en...endif.2.endif.thread, label %B206.endif.endif.endif.en...endif.2.endif

B206.endif.endif.endif.en...endif.2.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.2
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.2.endif.if

B206.endif.endif.endif.en...endif.2.endif:        ; preds = %B206.endif.endif.endif.en...endif.2
  %.692 = tail call ptr @PyList_GetItem(ptr nonnull %.686, i64 4)
  %.698 = icmp eq ptr %.692, null
  br i1 %.698, label %B206.endif.endif.endif.en...endif.2.endif.if, label %B206.endif.endif.endif.en...endif.2.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.2.endif.if:     ; preds = %B206.endif.endif.endif.en...endif.2.endif, %B206.endif.endif.endif.en...endif.2.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.663)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.2.endif.endif:  ; preds = %B206.endif.endif.endif.en...endif.2.endif
  tail call void @Py_IncRef(ptr nonnull %.692)
  %.712 = tail call ptr @PyDict_GetItem(ptr %.684, ptr nonnull %.692)
  tail call void @Py_IncRef(ptr %.712)
  %.714 = icmp eq ptr %.712, null
  br i1 %.714, label %B206.endif.endif.endif.en...endif.2.endif.endif.if, label %B206.endif.endif.endif.en...endif.3, !prof !0

B206.endif.endif.endif.en...endif.2.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.2.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'sys' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.663)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.3:              ; preds = %B206.endif.endif.endif.en...endif.2.endif.endif
  %sunkaddr6456 = getelementptr i8, ptr %.6, i64 24
  %.748 = load ptr, ptr %sunkaddr6456, align 8
  %.752.not = icmp eq ptr %.748, null
  br i1 %.752.not, label %B206.endif.endif.endif.en...endif.3.endif.thread, label %B206.endif.endif.endif.en...endif.3.endif

B206.endif.endif.endif.en...endif.3.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.3
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.3.endif.if

B206.endif.endif.endif.en...endif.3.endif:        ; preds = %B206.endif.endif.endif.en...endif.3
  %.754 = tail call ptr @PyList_GetItem(ptr nonnull %.748, i64 5)
  %.760 = icmp eq ptr %.754, null
  br i1 %.760, label %B206.endif.endif.endif.en...endif.3.endif.if, label %B206.endif.endif.endif.en...endif.3.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.3.endif.if:     ; preds = %B206.endif.endif.endif.en...endif.3.endif, %B206.endif.endif.endif.en...endif.3.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.663)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.712)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.3.endif.endif:  ; preds = %B206.endif.endif.endif.en...endif.3.endif
  tail call void @Py_IncRef(ptr nonnull %.754)
  %.776 = tail call ptr @PyObject_GetAttr(ptr nonnull %.712, ptr nonnull %.754)
  %.777 = icmp eq ptr %.776, null
  br i1 %.777, label %B206.endif.endif.endif.en...endif.3.endif.endif.if, label %B206.endif.endif.endif.en...endif.4.endif, !prof !0

B206.endif.endif.endif.en...endif.3.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.3.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.663)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.712)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.4.endif:        ; preds = %B206.endif.endif.endif.en...endif.3.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.712)
  %.831 = tail call ptr @PyNumber_Multiply(ptr nonnull %.663, ptr nonnull %.776)
  %.832 = icmp eq ptr %.831, null
  br i1 %.832, label %B206.endif.endif.endif.en...endif.4.endif.if, label %B206.endif.endif.endif.en...endif.4.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.4.endif.if:     ; preds = %B206.endif.endif.endif.en...endif.4.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.776)
  tail call void @Py_DecRef(ptr nonnull %.663)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.4.endif.endif:  ; preds = %B206.endif.endif.endif.en...endif.4.endif
  tail call void @Py_DecRef(ptr nonnull %.663)
  tail call void @Py_DecRef(ptr nonnull %.776)
  %sunkaddr6457 = getelementptr i8, ptr %.6, i64 16
  %.856 = load ptr, ptr %sunkaddr6457, align 8
  %sunkaddr6458 = getelementptr i8, ptr %.6, i64 24
  %.858 = load ptr, ptr %sunkaddr6458, align 8
  %.862.not = icmp eq ptr %.858, null
  br i1 %.862.not, label %B206.endif.endif.endif.en...endif.4.endif.endif.endif.thread, label %B206.endif.endif.endif.en...endif.4.endif.endif.endif

B206.endif.endif.endif.en...endif.4.endif.endif.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.4.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.5

B206.endif.endif.endif.en...endif.4.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.4.endif.endif
  %.864 = tail call ptr @PyList_GetItem(ptr nonnull %.858, i64 6)
  %.870 = icmp eq ptr %.864, null
  br i1 %.870, label %B206.endif.endif.endif.en...if.5, label %B206.endif.endif.endif.en...endif.5, !prof !2

B206.endif.endif.endif.en...if.5:                 ; preds = %B206.endif.endif.endif.en...endif.4.endif.endif.endif, %B206.endif.endif.endif.en...endif.4.endif.endif.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.5:              ; preds = %B206.endif.endif.endif.en...endif.4.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.864)
  %.884 = tail call ptr @PyDict_GetItem(ptr %.856, ptr nonnull %.864)
  tail call void @Py_IncRef(ptr %.884)
  %.886 = icmp eq ptr %.884, null
  br i1 %.886, label %B206.endif.endif.endif.en...endif.5.if, label %B206.endif.endif.endif.en...endif.5.endif

B206.endif.endif.endif.en...endif.5.if:           ; preds = %B206.endif.endif.endif.en...endif.5
  %sunkaddr6459 = getelementptr i8, ptr %.6, i64 24
  %.889 = load ptr, ptr %sunkaddr6459, align 8
  %.893.not = icmp eq ptr %.889, null
  br i1 %.893.not, label %B206.endif.endif.endif.en...endif.5.if.endif.thread, label %B206.endif.endif.endif.en...endif.5.if.endif

B206.endif.endif.endif.en...endif.5.endif:        ; preds = %B206.endif.endif.endif.en...endif.6.if.endif.endif, %B206.endif.endif.endif.en...endif.6, %B206.endif.endif.endif.en...endif.5
  %.992 = phi ptr [ %.884, %B206.endif.endif.endif.en...endif.5 ], [ %.943, %B206.endif.endif.endif.en...endif.6 ], [ %.974, %B206.endif.endif.endif.en...endif.6.if.endif.endif ]
  %sunkaddr6460 = getelementptr i8, ptr %.6, i64 16
  %.996 = load ptr, ptr %sunkaddr6460, align 8
  %sunkaddr6461 = getelementptr i8, ptr %.6, i64 24
  %.998 = load ptr, ptr %sunkaddr6461, align 8
  %.1002.not = icmp eq ptr %.998, null
  br i1 %.1002.not, label %B206.endif.endif.endif.en...endif.5.endif.endif.thread, label %B206.endif.endif.endif.en...endif.5.endif.endif

B206.endif.endif.endif.en...endif.5.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.5.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.5.if.endif.if

B206.endif.endif.endif.en...endif.5.if.endif:     ; preds = %B206.endif.endif.endif.en...endif.5.if
  %.895 = tail call ptr @PyList_GetItem(ptr nonnull %.889, i64 1)
  %.901 = icmp eq ptr %.895, null
  br i1 %.901, label %B206.endif.endif.endif.en...endif.5.if.endif.if, label %B206.endif.endif.endif.en...endif.5.if.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.5.if.endif.if:  ; preds = %B206.endif.endif.endif.en...endif.5.if.endif, %B206.endif.endif.endif.en...endif.5.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.5.if.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.5.if.endif
  tail call void @Py_IncRef(ptr nonnull %.895)
  %.915 = tail call ptr @PyDict_GetItem(ptr %.856, ptr nonnull %.895)
  %sunkaddr6462 = getelementptr i8, ptr %.6, i64 24
  %.917 = load ptr, ptr %sunkaddr6462, align 8
  %.921.not = icmp eq ptr %.917, null
  br i1 %.921.not, label %B206.endif.endif.endif.en...endif.5.if.endif.endif.endif.thread, label %B206.endif.endif.endif.en...endif.5.if.endif.endif.endif

B206.endif.endif.endif.en...endif.5.if.endif.endif.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.5.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.6

B206.endif.endif.endif.en...endif.5.if.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.5.if.endif.endif
  %.923 = tail call ptr @PyList_GetItem(ptr nonnull %.917, i64 6)
  %.929 = icmp eq ptr %.923, null
  br i1 %.929, label %B206.endif.endif.endif.en...if.6, label %B206.endif.endif.endif.en...endif.6, !prof !2

B206.endif.endif.endif.en...if.6:                 ; preds = %B206.endif.endif.endif.en...endif.5.if.endif.endif.endif, %B206.endif.endif.endif.en...endif.5.if.endif.endif.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.6:              ; preds = %B206.endif.endif.endif.en...endif.5.if.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.923)
  %.943 = tail call ptr @PyDict_GetItem(ptr %.915, ptr nonnull %.923)
  tail call void @Py_IncRef(ptr %.943)
  %.945 = icmp eq ptr %.943, null
  br i1 %.945, label %B206.endif.endif.endif.en...endif.6.if, label %B206.endif.endif.endif.en...endif.5.endif, !prof !0

B206.endif.endif.endif.en...endif.6.if:           ; preds = %B206.endif.endif.endif.en...endif.6
  %sunkaddr6463 = getelementptr i8, ptr %.6, i64 24
  %.948 = load ptr, ptr %sunkaddr6463, align 8
  %.952.not = icmp eq ptr %.948, null
  br i1 %.952.not, label %B206.endif.endif.endif.en...endif.6.if.endif.thread, label %B206.endif.endif.endif.en...endif.6.if.endif

B206.endif.endif.endif.en...endif.6.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.6.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.6.if.endif.if

B206.endif.endif.endif.en...endif.6.if.endif:     ; preds = %B206.endif.endif.endif.en...endif.6.if
  %.954 = tail call ptr @PyList_GetItem(ptr nonnull %.948, i64 6)
  %.960 = icmp eq ptr %.954, null
  br i1 %.960, label %B206.endif.endif.endif.en...endif.6.if.endif.if, label %B206.endif.endif.endif.en...endif.6.if.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.6.if.endif.if:  ; preds = %B206.endif.endif.endif.en...endif.6.if.endif, %B206.endif.endif.endif.en...endif.6.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.6.if.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.6.if.endif
  tail call void @Py_IncRef(ptr nonnull %.954)
  %.974 = tail call ptr @PyObject_GetAttr(ptr %.915, ptr nonnull %.954)
  %.975 = icmp eq ptr %.974, null
  br i1 %.975, label %B206.endif.endif.endif.en...endif.6.if.endif.endif.if, label %B206.endif.endif.endif.en...endif.5.endif, !prof !0

B206.endif.endif.endif.en...endif.6.if.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.6.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'isinstance' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.5.endif.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.5.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.5.endif.endif.if

B206.endif.endif.endif.en...endif.5.endif.endif:  ; preds = %B206.endif.endif.endif.en...endif.5.endif
  %.1004 = tail call ptr @PyList_GetItem(ptr nonnull %.998, i64 7)
  %.1010 = icmp eq ptr %.1004, null
  br i1 %.1010, label %B206.endif.endif.endif.en...endif.5.endif.endif.if, label %B206.endif.endif.endif.en...endif.5.endif.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.5.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.5.endif.endif, %B206.endif.endif.endif.en...endif.5.endif.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.5.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.5.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.1004)
  %.1026 = tail call ptr @PyDict_GetItem(ptr %.996, ptr nonnull %.1004)
  tail call void @Py_IncRef(ptr %.1026)
  %.1028 = icmp eq ptr %.1026, null
  br i1 %.1028, label %B206.endif.endif.endif.en...if.7, label %B206.endif.endif.endif.en...endif.7

B206.endif.endif.endif.en...if.7:                 ; preds = %B206.endif.endif.endif.en...endif.5.endif.endif.endif
  %sunkaddr6464 = getelementptr i8, ptr %.6, i64 24
  %.1031 = load ptr, ptr %sunkaddr6464, align 8
  %.1035.not = icmp eq ptr %.1031, null
  br i1 %.1035.not, label %B206.endif.endif.endif.en...if.7.endif.thread, label %B206.endif.endif.endif.en...if.7.endif

B206.endif.endif.endif.en...endif.7:              ; preds = %B206.endif.endif.endif.en...if.8.endif.endif, %B206.endif.endif.endif.en...if.7.endif.endif.endif.endif, %B206.endif.endif.endif.en...endif.5.endif.endif.endif
  %.1142 = phi ptr [ %.1026, %B206.endif.endif.endif.en...endif.5.endif.endif.endif ], [ %.1089, %B206.endif.endif.endif.en...if.7.endif.endif.endif.endif ], [ %.1122, %B206.endif.endif.endif.en...if.8.endif.endif ]
  %sunkaddr6465 = getelementptr i8, ptr %.6, i64 16
  %.1146 = load ptr, ptr %sunkaddr6465, align 8
  %sunkaddr6466 = getelementptr i8, ptr %.6, i64 24
  %.1148 = load ptr, ptr %sunkaddr6466, align 8
  %.1152.not = icmp eq ptr %.1148, null
  br i1 %.1152.not, label %B206.endif.endif.endif.en...endif.7.endif.thread, label %B206.endif.endif.endif.en...endif.7.endif

B206.endif.endif.endif.en...if.7.endif.thread:    ; preds = %B206.endif.endif.endif.en...if.7
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.7.endif.if

B206.endif.endif.endif.en...if.7.endif:           ; preds = %B206.endif.endif.endif.en...if.7
  %.1037 = tail call ptr @PyList_GetItem(ptr nonnull %.1031, i64 1)
  %.1043 = icmp eq ptr %.1037, null
  br i1 %.1043, label %B206.endif.endif.endif.en...if.7.endif.if, label %B206.endif.endif.endif.en...if.7.endif.endif, !prof !2

B206.endif.endif.endif.en...if.7.endif.if:        ; preds = %B206.endif.endif.endif.en...if.7.endif, %B206.endif.endif.endif.en...if.7.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...if.7.endif.endif:     ; preds = %B206.endif.endif.endif.en...if.7.endif
  tail call void @Py_IncRef(ptr nonnull %.1037)
  %.1059 = tail call ptr @PyDict_GetItem(ptr %.996, ptr nonnull %.1037)
  %sunkaddr6467 = getelementptr i8, ptr %.6, i64 24
  %.1061 = load ptr, ptr %sunkaddr6467, align 8
  %.1065.not = icmp eq ptr %.1061, null
  br i1 %.1065.not, label %B206.endif.endif.endif.en...if.7.endif.endif.endif.thread, label %B206.endif.endif.endif.en...if.7.endif.endif.endif

B206.endif.endif.endif.en...if.7.endif.endif.endif.thread: ; preds = %B206.endif.endif.endif.en...if.7.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.7.endif.endif.endif.if

B206.endif.endif.endif.en...if.7.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...if.7.endif.endif
  %.1067 = tail call ptr @PyList_GetItem(ptr nonnull %.1061, i64 7)
  %.1073 = icmp eq ptr %.1067, null
  br i1 %.1073, label %B206.endif.endif.endif.en...if.7.endif.endif.endif.if, label %B206.endif.endif.endif.en...if.7.endif.endif.endif.endif, !prof !2

B206.endif.endif.endif.en...if.7.endif.endif.endif.if: ; preds = %B206.endif.endif.endif.en...if.7.endif.endif.endif, %B206.endif.endif.endif.en...if.7.endif.endif.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...if.7.endif.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...if.7.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.1067)
  %.1089 = tail call ptr @PyDict_GetItem(ptr %.1059, ptr nonnull %.1067)
  tail call void @Py_IncRef(ptr %.1089)
  %.1091 = icmp eq ptr %.1089, null
  br i1 %.1091, label %B206.endif.endif.endif.en...if.8, label %B206.endif.endif.endif.en...endif.7, !prof !0

B206.endif.endif.endif.en...if.8:                 ; preds = %B206.endif.endif.endif.en...if.7.endif.endif.endif.endif
  %sunkaddr6468 = getelementptr i8, ptr %.6, i64 24
  %.1094 = load ptr, ptr %sunkaddr6468, align 8
  %.1098.not = icmp eq ptr %.1094, null
  br i1 %.1098.not, label %B206.endif.endif.endif.en...if.8.endif.thread, label %B206.endif.endif.endif.en...if.8.endif

B206.endif.endif.endif.en...if.8.endif.thread:    ; preds = %B206.endif.endif.endif.en...if.8
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.8.endif.if

B206.endif.endif.endif.en...if.8.endif:           ; preds = %B206.endif.endif.endif.en...if.8
  %.1100 = tail call ptr @PyList_GetItem(ptr nonnull %.1094, i64 7)
  %.1106 = icmp eq ptr %.1100, null
  br i1 %.1106, label %B206.endif.endif.endif.en...if.8.endif.if, label %B206.endif.endif.endif.en...if.8.endif.endif, !prof !2

B206.endif.endif.endif.en...if.8.endif.if:        ; preds = %B206.endif.endif.endif.en...if.8.endif, %B206.endif.endif.endif.en...if.8.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...if.8.endif.endif:     ; preds = %B206.endif.endif.endif.en...if.8.endif
  tail call void @Py_IncRef(ptr nonnull %.1100)
  %.1122 = tail call ptr @PyObject_GetAttr(ptr %.1059, ptr nonnull %.1100)
  %.1123 = icmp eq ptr %.1122, null
  br i1 %.1123, label %B206.endif.endif.endif.en...if.8.endif.endif.if, label %B206.endif.endif.endif.en...endif.7, !prof !0

B206.endif.endif.endif.en...if.8.endif.endif.if:  ; preds = %B206.endif.endif.endif.en...if.8.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'int' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.7.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.7
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.7.endif.if

B206.endif.endif.endif.en...endif.7.endif:        ; preds = %B206.endif.endif.endif.en...endif.7
  %.1154 = tail call ptr @PyList_GetItem(ptr nonnull %.1148, i64 8)
  %.1160 = icmp eq ptr %.1154, null
  br i1 %.1160, label %B206.endif.endif.endif.en...endif.7.endif.if, label %B206.endif.endif.endif.en...endif.7.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.7.endif.if:     ; preds = %B206.endif.endif.endif.en...endif.7.endif, %B206.endif.endif.endif.en...endif.7.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.7.endif.endif:  ; preds = %B206.endif.endif.endif.en...endif.7.endif
  tail call void @Py_IncRef(ptr nonnull %.1154)
  %.1178 = tail call ptr @PyDict_GetItem(ptr %.1146, ptr nonnull %.1154)
  tail call void @Py_IncRef(ptr %.1178)
  %.1180 = icmp eq ptr %.1178, null
  br i1 %.1180, label %B206.endif.endif.endif.en...endif.7.endif.endif.if, label %B206.endif.endif.endif.en...endif.7.endif.endif.endif

B206.endif.endif.endif.en...endif.7.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif
  %sunkaddr6469 = getelementptr i8, ptr %.6, i64 24
  %.1183 = load ptr, ptr %sunkaddr6469, align 8
  %.1187.not = icmp eq ptr %.1183, null
  br i1 %.1187.not, label %B206.endif.endif.endif.en...endif.7.endif.endif.if.endif.thread, label %B206.endif.endif.endif.en...endif.7.endif.endif.if.endif

B206.endif.endif.endif.en...endif.7.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.10, %B206.endif.endif.endif.en...endif.9.endif.endif, %B206.endif.endif.endif.en...endif.7.endif.endif
  %.1302 = phi ptr [ %.1178, %B206.endif.endif.endif.en...endif.7.endif.endif ], [ %.1245, %B206.endif.endif.endif.en...endif.9.endif.endif ], [ %.1280, %B206.endif.endif.endif.en...endif.10 ]
  %sunkaddr6470 = getelementptr i8, ptr %.6, i64 16
  %.1306 = load ptr, ptr %sunkaddr6470, align 8
  %sunkaddr6471 = getelementptr i8, ptr %.6, i64 24
  %.1308 = load ptr, ptr %sunkaddr6471, align 8
  %.1312.not = icmp eq ptr %.1308, null
  br i1 %.1312.not, label %B206.endif.endif.endif.en...endif.11.thread, label %B206.endif.endif.endif.en...endif.11

B206.endif.endif.endif.en...endif.7.endif.endif.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.9

B206.endif.endif.endif.en...endif.7.endif.endif.if.endif: ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif.if
  %.1189 = tail call ptr @PyList_GetItem(ptr nonnull %.1183, i64 1)
  %.1195 = icmp eq ptr %.1189, null
  br i1 %.1195, label %B206.endif.endif.endif.en...if.9, label %B206.endif.endif.endif.en...endif.9, !prof !2

B206.endif.endif.endif.en...if.9:                 ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif.if.endif, %B206.endif.endif.endif.en...endif.7.endif.endif.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.9:              ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.1189)
  %.1213 = tail call ptr @PyDict_GetItem(ptr %.1146, ptr nonnull %.1189)
  %sunkaddr6472 = getelementptr i8, ptr %.6, i64 24
  %.1215 = load ptr, ptr %sunkaddr6472, align 8
  %.1219.not = icmp eq ptr %.1215, null
  br i1 %.1219.not, label %B206.endif.endif.endif.en...endif.9.endif.thread, label %B206.endif.endif.endif.en...endif.9.endif

B206.endif.endif.endif.en...endif.9.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.9
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.9.endif.if

B206.endif.endif.endif.en...endif.9.endif:        ; preds = %B206.endif.endif.endif.en...endif.9
  %.1221 = tail call ptr @PyList_GetItem(ptr nonnull %.1215, i64 8)
  %.1227 = icmp eq ptr %.1221, null
  br i1 %.1227, label %B206.endif.endif.endif.en...endif.9.endif.if, label %B206.endif.endif.endif.en...endif.9.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.9.endif.if:     ; preds = %B206.endif.endif.endif.en...endif.9.endif, %B206.endif.endif.endif.en...endif.9.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.9.endif.endif:  ; preds = %B206.endif.endif.endif.en...endif.9.endif
  tail call void @Py_IncRef(ptr nonnull %.1221)
  %.1245 = tail call ptr @PyDict_GetItem(ptr %.1213, ptr nonnull %.1221)
  tail call void @Py_IncRef(ptr %.1245)
  %.1247 = icmp eq ptr %.1245, null
  br i1 %.1247, label %B206.endif.endif.endif.en...endif.9.endif.endif.if, label %B206.endif.endif.endif.en...endif.7.endif.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.9.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.9.endif.endif
  %sunkaddr6473 = getelementptr i8, ptr %.6, i64 24
  %.1250 = load ptr, ptr %sunkaddr6473, align 8
  %.1254.not = icmp eq ptr %.1250, null
  br i1 %.1254.not, label %B206.endif.endif.endif.en...endif.9.endif.endif.if.endif.thread, label %B206.endif.endif.endif.en...endif.9.endif.endif.if.endif

B206.endif.endif.endif.en...endif.9.endif.endif.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.9.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.10

B206.endif.endif.endif.en...endif.9.endif.endif.if.endif: ; preds = %B206.endif.endif.endif.en...endif.9.endif.endif.if
  %.1256 = tail call ptr @PyList_GetItem(ptr nonnull %.1250, i64 8)
  %.1262 = icmp eq ptr %.1256, null
  br i1 %.1262, label %B206.endif.endif.endif.en...if.10, label %B206.endif.endif.endif.en...endif.10, !prof !2

B206.endif.endif.endif.en...if.10:                ; preds = %B206.endif.endif.endif.en...endif.9.endif.endif.if.endif, %B206.endif.endif.endif.en...endif.9.endif.endif.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.10:             ; preds = %B206.endif.endif.endif.en...endif.9.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.1256)
  %.1280 = tail call ptr @PyObject_GetAttr(ptr %.1213, ptr nonnull %.1256)
  %.1281 = icmp eq ptr %.1280, null
  br i1 %.1281, label %B206.endif.endif.endif.en...endif.10.if, label %B206.endif.endif.endif.en...endif.7.endif.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.10.if:          ; preds = %B206.endif.endif.endif.en...endif.10
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'bytes' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.11.thread:      ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.11.if

B206.endif.endif.endif.en...endif.11:             ; preds = %B206.endif.endif.endif.en...endif.7.endif.endif.endif
  %.1314 = tail call ptr @PyList_GetItem(ptr nonnull %.1308, i64 9)
  %.1320 = icmp eq ptr %.1314, null
  br i1 %.1320, label %B206.endif.endif.endif.en...endif.11.if, label %B206.endif.endif.endif.en...endif.11.endif, !prof !2

B206.endif.endif.endif.en...endif.11.if:          ; preds = %B206.endif.endif.endif.en...endif.11, %B206.endif.endif.endif.en...endif.11.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.11.endif:       ; preds = %B206.endif.endif.endif.en...endif.11
  tail call void @Py_IncRef(ptr nonnull %.1314)
  %.1340 = tail call ptr @PyDict_GetItem(ptr %.1306, ptr nonnull %.1314)
  tail call void @Py_IncRef(ptr %.1340)
  %.1342 = icmp eq ptr %.1340, null
  br i1 %.1342, label %B206.endif.endif.endif.en...endif.11.endif.if, label %B206.endif.endif.endif.en...endif.14.endif

B206.endif.endif.endif.en...endif.11.endif.if:    ; preds = %B206.endif.endif.endif.en...endif.11.endif
  %sunkaddr6474 = getelementptr i8, ptr %.6, i64 24
  %.1345 = load ptr, ptr %sunkaddr6474, align 8
  %.1349.not = icmp eq ptr %.1345, null
  br i1 %.1349.not, label %B206.endif.endif.endif.en...endif.11.endif.if.endif.thread, label %B206.endif.endif.endif.en...endif.11.endif.if.endif

B206.endif.endif.endif.en...endif.11.endif.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.11.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.12

B206.endif.endif.endif.en...endif.11.endif.if.endif: ; preds = %B206.endif.endif.endif.en...endif.11.endif.if
  %.1351 = tail call ptr @PyList_GetItem(ptr nonnull %.1345, i64 1)
  %.1357 = icmp eq ptr %.1351, null
  br i1 %.1357, label %B206.endif.endif.endif.en...if.12, label %B206.endif.endif.endif.en...endif.12, !prof !2

B206.endif.endif.endif.en...if.12:                ; preds = %B206.endif.endif.endif.en...endif.11.endif.if.endif, %B206.endif.endif.endif.en...endif.11.endif.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.12:             ; preds = %B206.endif.endif.endif.en...endif.11.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.1351)
  %.1377 = tail call ptr @PyDict_GetItem(ptr %.1306, ptr nonnull %.1351)
  %sunkaddr6475 = getelementptr i8, ptr %.6, i64 24
  %.1379 = load ptr, ptr %sunkaddr6475, align 8
  %.1383.not = icmp eq ptr %.1379, null
  br i1 %.1383.not, label %B206.endif.endif.endif.en...endif.12.endif.thread, label %B206.endif.endif.endif.en...endif.12.endif

B206.endif.endif.endif.en...endif.12.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.12
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.12.endif.if

B206.endif.endif.endif.en...endif.12.endif:       ; preds = %B206.endif.endif.endif.en...endif.12
  %.1385 = tail call ptr @PyList_GetItem(ptr nonnull %.1379, i64 9)
  %.1391 = icmp eq ptr %.1385, null
  br i1 %.1391, label %B206.endif.endif.endif.en...endif.12.endif.if, label %B206.endif.endif.endif.en...endif.12.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.12.endif.if:    ; preds = %B206.endif.endif.endif.en...endif.12.endif, %B206.endif.endif.endif.en...endif.12.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.12.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.12.endif
  tail call void @Py_IncRef(ptr nonnull %.1385)
  %.1411 = tail call ptr @PyDict_GetItem(ptr %.1377, ptr nonnull %.1385)
  tail call void @Py_IncRef(ptr %.1411)
  %.1413 = icmp eq ptr %.1411, null
  br i1 %.1413, label %B206.endif.endif.endif.en...endif.12.endif.endif.if, label %B206.endif.endif.endif.en...endif.14.endif, !prof !0

B206.endif.endif.endif.en...endif.12.endif.endif.if: ; preds = %B206.endif.endif.endif.en...endif.12.endif.endif
  %sunkaddr6476 = getelementptr i8, ptr %.6, i64 24
  %.1416 = load ptr, ptr %sunkaddr6476, align 8
  %.1420.not = icmp eq ptr %.1416, null
  br i1 %.1420.not, label %B206.endif.endif.endif.en...endif.13.thread, label %B206.endif.endif.endif.en...endif.13

B206.endif.endif.endif.en...endif.13.thread:      ; preds = %B206.endif.endif.endif.en...endif.12.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.13.if

B206.endif.endif.endif.en...endif.13:             ; preds = %B206.endif.endif.endif.en...endif.12.endif.endif.if
  %.1422 = tail call ptr @PyList_GetItem(ptr nonnull %.1416, i64 9)
  %.1428 = icmp eq ptr %.1422, null
  br i1 %.1428, label %B206.endif.endif.endif.en...endif.13.if, label %B206.endif.endif.endif.en...endif.13.endif, !prof !2

B206.endif.endif.endif.en...endif.13.if:          ; preds = %B206.endif.endif.endif.en...endif.13, %B206.endif.endif.endif.en...endif.13.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.13.endif:       ; preds = %B206.endif.endif.endif.en...endif.13
  tail call void @Py_IncRef(ptr nonnull %.1422)
  %.1448 = tail call ptr @PyObject_GetAttr(ptr %.1377, ptr nonnull %.1422)
  %.1449 = icmp eq ptr %.1448, null
  br i1 %.1449, label %B206.endif.endif.endif.en...endif.13.endif.if, label %B206.endif.endif.endif.en...endif.14.endif, !prof !0

B206.endif.endif.endif.en...endif.13.endif.if:    ; preds = %B206.endif.endif.endif.en...endif.13.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'str' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.14.endif:       ; preds = %B206.endif.endif.endif.en...endif.11.endif, %B206.endif.endif.endif.en...endif.12.endif.endif, %B206.endif.endif.endif.en...endif.13.endif
  %.1472 = phi ptr [ %.1340, %B206.endif.endif.endif.en...endif.11.endif ], [ %.1411, %B206.endif.endif.endif.en...endif.12.endif.endif ], [ %.1448, %B206.endif.endif.endif.en...endif.13.endif ]
  %.1544 = tail call ptr (i64, ...) @PyTuple_Pack(i64 3, ptr nonnull %.1142, ptr nonnull %.1302, ptr nonnull %.1472)
  %.1545 = icmp eq ptr %.1544, null
  br i1 %.1545, label %B206.endif.endif.endif.en...endif.14.endif.if, label %B206.endif.endif.endif.en...endif.15, !prof !0

B206.endif.endif.endif.en...endif.14.endif.if:    ; preds = %B206.endif.endif.endif.en...endif.14.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1472)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.15:             ; preds = %B206.endif.endif.endif.en...endif.14.endif
  tail call void @Py_DecRef(ptr nonnull %.1472)
  tail call void @Py_DecRef(ptr nonnull %.1302)
  tail call void @Py_DecRef(ptr nonnull %.1142)
  %.1634 = tail call ptr (i64, ...) @PyTuple_Pack(i64 2, ptr nonnull %.482, ptr nonnull %.1544)
  %.1635 = tail call ptr @PyObject_Call(ptr nonnull %.992, ptr %.1634, ptr null)
  tail call void @Py_DecRef(ptr %.1634)
  %.1637 = icmp eq ptr %.1635, null
  br i1 %.1637, label %B206.endif.endif.endif.en...endif.15.endif.if, label %B206.endif.endif.endif.en...endif.15.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.15.endif.if:    ; preds = %B206.endif.endif.endif.en...endif.15
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.992)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr nonnull %.1544)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.15.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.15
  tail call void @Py_DecRef(ptr nonnull %.1544)
  tail call void @Py_DecRef(ptr nonnull %.992)
  %sunkaddr6477 = getelementptr i8, ptr %.6, i64 16
  %.1663 = load ptr, ptr %sunkaddr6477, align 8
  %sunkaddr6478 = getelementptr i8, ptr %.6, i64 24
  %.1665 = load ptr, ptr %sunkaddr6478, align 8
  %.1669.not = icmp eq ptr %.1665, null
  br i1 %.1669.not, label %B206.endif.endif.endif.en...endif.15.endif.endif.endif.thread, label %B206.endif.endif.endif.en...endif.15.endif.endif.endif

B206.endif.endif.endif.en...endif.15.endif.endif.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.15.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.16

B206.endif.endif.endif.en...endif.15.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.15.endif.endif
  %.1671 = tail call ptr @PyList_GetItem(ptr nonnull %.1665, i64 10)
  %.1677 = icmp eq ptr %.1671, null
  br i1 %.1677, label %B206.endif.endif.endif.en...if.16, label %B206.endif.endif.endif.en...endif.16, !prof !2

B206.endif.endif.endif.en...if.16:                ; preds = %B206.endif.endif.endif.en...endif.15.endif.endif.endif, %B206.endif.endif.endif.en...endif.15.endif.endif.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.16:             ; preds = %B206.endif.endif.endif.en...endif.15.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.1671)
  %.1693 = tail call ptr @PyDict_GetItem(ptr %.1663, ptr nonnull %.1671)
  tail call void @Py_IncRef(ptr %.1693)
  %.1695 = icmp eq ptr %.1693, null
  br i1 %.1695, label %B206.endif.endif.endif.en...endif.16.if, label %B206.endif.endif.endif.en...endif.16.endif.endif.endif

B206.endif.endif.endif.en...endif.16.if:          ; preds = %B206.endif.endif.endif.en...endif.16
  %sunkaddr6479 = getelementptr i8, ptr %.6, i64 24
  %.1698 = load ptr, ptr %sunkaddr6479, align 8
  %.1702.not = icmp eq ptr %.1698, null
  br i1 %.1702.not, label %B206.endif.endif.endif.en...endif.16.if.endif.thread, label %B206.endif.endif.endif.en...endif.16.if.endif

B206.endif.endif.endif.en...endif.16.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.16.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.16.if.endif.if

B206.endif.endif.endif.en...endif.16.if.endif:    ; preds = %B206.endif.endif.endif.en...endif.16.if
  %.1704 = tail call ptr @PyList_GetItem(ptr nonnull %.1698, i64 1)
  %.1710 = icmp eq ptr %.1704, null
  br i1 %.1710, label %B206.endif.endif.endif.en...endif.16.if.endif.if, label %B206.endif.endif.endif.en...endif.16.if.endif.endif, !prof !2

B206.endif.endif.endif.en...endif.16.if.endif.if: ; preds = %B206.endif.endif.endif.en...endif.16.if.endif, %B206.endif.endif.endif.en...endif.16.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.16.if.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.16.if.endif
  tail call void @Py_IncRef(ptr nonnull %.1704)
  %.1726 = tail call ptr @PyDict_GetItem(ptr %.1663, ptr nonnull %.1704)
  %sunkaddr6480 = getelementptr i8, ptr %.6, i64 24
  %.1728 = load ptr, ptr %sunkaddr6480, align 8
  %.1732.not = icmp eq ptr %.1728, null
  br i1 %.1732.not, label %B206.endif.endif.endif.en...endif.17.thread, label %B206.endif.endif.endif.en...endif.17

B206.endif.endif.endif.en...endif.17.thread:      ; preds = %B206.endif.endif.endif.en...endif.16.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...endif.17.if

B206.endif.endif.endif.en...endif.17:             ; preds = %B206.endif.endif.endif.en...endif.16.if.endif.endif
  %.1734 = tail call ptr @PyList_GetItem(ptr nonnull %.1728, i64 10)
  %.1740 = icmp eq ptr %.1734, null
  br i1 %.1740, label %B206.endif.endif.endif.en...endif.17.if, label %B206.endif.endif.endif.en...endif.17.endif, !prof !2

B206.endif.endif.endif.en...endif.17.if:          ; preds = %B206.endif.endif.endif.en...endif.17, %B206.endif.endif.endif.en...endif.17.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.17.endif:       ; preds = %B206.endif.endif.endif.en...endif.17
  tail call void @Py_IncRef(ptr nonnull %.1734)
  %.1756 = tail call ptr @PyDict_GetItem(ptr %.1726, ptr nonnull %.1734)
  tail call void @Py_IncRef(ptr %.1756)
  %.1758 = icmp eq ptr %.1756, null
  br i1 %.1758, label %B206.endif.endif.endif.en...endif.17.endif.if, label %B206.endif.endif.endif.en...endif.16.endif.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.17.endif.if:    ; preds = %B206.endif.endif.endif.en...endif.17.endif
  %sunkaddr6481 = getelementptr i8, ptr %.6, i64 24
  %.1761 = load ptr, ptr %sunkaddr6481, align 8
  %.1765.not = icmp eq ptr %.1761, null
  br i1 %.1765.not, label %B206.endif.endif.endif.en...endif.17.endif.if.endif.thread, label %B206.endif.endif.endif.en...endif.17.endif.if.endif

B206.endif.endif.endif.en...endif.17.endif.if.endif.thread: ; preds = %B206.endif.endif.endif.en...endif.17.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B206.endif.endif.endif.en...if.18

B206.endif.endif.endif.en...endif.17.endif.if.endif: ; preds = %B206.endif.endif.endif.en...endif.17.endif.if
  %.1767 = tail call ptr @PyList_GetItem(ptr nonnull %.1761, i64 10)
  %.1773 = icmp eq ptr %.1767, null
  br i1 %.1773, label %B206.endif.endif.endif.en...if.18, label %B206.endif.endif.endif.en...endif.18, !prof !2

B206.endif.endif.endif.en...if.18:                ; preds = %B206.endif.endif.endif.en...endif.17.endif.if.endif, %B206.endif.endif.endif.en...endif.17.endif.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.18:             ; preds = %B206.endif.endif.endif.en...endif.17.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.1767)
  %.1789 = tail call ptr @PyObject_GetAttr(ptr %.1726, ptr nonnull %.1767)
  %.1790 = icmp eq ptr %.1789, null
  br i1 %.1790, label %B206.endif.endif.endif.en...endif.18.if, label %B206.endif.endif.endif.en...endif.16.endif.endif.endif, !prof !0

B206.endif.endif.endif.en...endif.18.if:          ; preds = %B206.endif.endif.endif.en...endif.18
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'bool' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.16.endif.endif.endif: ; preds = %B206.endif.endif.endif.en...endif.16, %B206.endif.endif.endif.en...endif.17.endif, %B206.endif.endif.endif.en...endif.18
  %.1809 = phi ptr [ %.1693, %B206.endif.endif.endif.en...endif.16 ], [ %.1756, %B206.endif.endif.endif.en...endif.17.endif ], [ %.1789, %B206.endif.endif.endif.en...endif.18 ]
  %.1850 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr nonnull %.1635)
  %.1851 = tail call ptr @PyObject_Call(ptr nonnull %.1809, ptr %.1850, ptr null)
  tail call void @Py_DecRef(ptr %.1850)
  %.1853 = icmp eq ptr %.1851, null
  br i1 %.1853, label %B206.endif.endif.endif.en...if.19, label %B206.endif.endif.endif.en...endif.19.endif, !prof !0

B206.endif.endif.endif.en...if.19:                ; preds = %B206.endif.endif.endif.en...endif.16.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr nonnull %.1809)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B206.endif.endif.endif.en...endif.19.endif:       ; preds = %B206.endif.endif.endif.en...endif.16.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.1809)
  tail call void @Py_DecRef(ptr nonnull %.1635)
  %.1895 = tail call i32 @PyObject_IsTrue(ptr nonnull %.1851)
  %.1896.not = icmp eq i32 %.1895, 0
  br i1 %.1896.not, label %B254, label %B212

B212.endif.thread:                                ; preds = %B212
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B212.endif.if

B212.endif:                                       ; preds = %B212
  %.1910 = tail call ptr @PyList_GetItem(ptr nonnull %.1904, i64 11)
  %.1916 = icmp eq ptr %.1910, null
  br i1 %.1916, label %B212.endif.if, label %B212.endif.endif, !prof !2

B212.endif.if:                                    ; preds = %B212.endif, %B212.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif:                                 ; preds = %B212.endif
  tail call void @Py_IncRef(ptr nonnull %.1910)
  %.1930 = tail call ptr @PyDict_GetItem(ptr %.1902, ptr nonnull %.1910)
  tail call void @Py_IncRef(ptr %.1930)
  %.1932 = icmp eq ptr %.1930, null
  br i1 %.1932, label %B212.endif.endif.if, label %B212.endif.endif.endif.endif.endif

B212.endif.endif.if:                              ; preds = %B212.endif.endif
  %sunkaddr6482 = getelementptr i8, ptr %.6, i64 24
  %.1935 = load ptr, ptr %sunkaddr6482, align 8
  %.1939.not = icmp eq ptr %.1935, null
  br i1 %.1939.not, label %B212.endif.endif.if.endif.thread, label %B212.endif.endif.if.endif

B212.endif.endif.if.endif.thread:                 ; preds = %B212.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B212.endif.endif.if.endif.if

B212.endif.endif.if.endif:                        ; preds = %B212.endif.endif.if
  %.1941 = tail call ptr @PyList_GetItem(ptr nonnull %.1935, i64 1)
  %.1947 = icmp eq ptr %.1941, null
  br i1 %.1947, label %B212.endif.endif.if.endif.if, label %B212.endif.endif.if.endif.endif, !prof !2

B212.endif.endif.if.endif.if:                     ; preds = %B212.endif.endif.if.endif, %B212.endif.endif.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif.if.endif.endif:                  ; preds = %B212.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.1941)
  %.1961 = tail call ptr @PyDict_GetItem(ptr %.1902, ptr nonnull %.1941)
  %sunkaddr6483 = getelementptr i8, ptr %.6, i64 24
  %.1963 = load ptr, ptr %sunkaddr6483, align 8
  %.1967.not = icmp eq ptr %.1963, null
  br i1 %.1967.not, label %B212.endif.endif.if.endif.endif.endif.thread, label %B212.endif.endif.if.endif.endif.endif

B212.endif.endif.if.endif.endif.endif.thread:     ; preds = %B212.endif.endif.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B212.endif.endif.if.endif.endif.endif.if

B212.endif.endif.if.endif.endif.endif:            ; preds = %B212.endif.endif.if.endif.endif
  %.1969 = tail call ptr @PyList_GetItem(ptr nonnull %.1963, i64 11)
  %.1975 = icmp eq ptr %.1969, null
  br i1 %.1975, label %B212.endif.endif.if.endif.endif.endif.if, label %B212.endif.endif.if.endif.endif.endif.endif, !prof !2

B212.endif.endif.if.endif.endif.endif.if:         ; preds = %B212.endif.endif.if.endif.endif.endif, %B212.endif.endif.if.endif.endif.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif.if.endif.endif.endif.endif:      ; preds = %B212.endif.endif.if.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.1969)
  %.1989 = tail call ptr @PyDict_GetItem(ptr %.1961, ptr nonnull %.1969)
  tail call void @Py_IncRef(ptr %.1989)
  %.1991 = icmp eq ptr %.1989, null
  br i1 %.1991, label %B212.endif.endif.if.endif.endif.endif.endif.if, label %B212.endif.endif.endif.endif.endif, !prof !0

B212.endif.endif.if.endif.endif.endif.endif.if:   ; preds = %B212.endif.endif.if.endif.endif.endif.endif
  %sunkaddr6484 = getelementptr i8, ptr %.6, i64 24
  %.1994 = load ptr, ptr %sunkaddr6484, align 8
  %.1998.not = icmp eq ptr %.1994, null
  br i1 %.1998.not, label %B212.endif.endif.if.endif.endif.endif.endif.if.endif.thread, label %B212.endif.endif.if.endif.endif.endif.endif.if.endif

B212.endif.endif.if.endif.endif.endif.endif.if.endif.thread: ; preds = %B212.endif.endif.if.endif.endif.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B212.endif.endif.if.endif...if

B212.endif.endif.if.endif.endif.endif.endif.if.endif: ; preds = %B212.endif.endif.if.endif.endif.endif.endif.if
  %.2000 = tail call ptr @PyList_GetItem(ptr nonnull %.1994, i64 11)
  %.2006 = icmp eq ptr %.2000, null
  br i1 %.2006, label %B212.endif.endif.if.endif...if, label %B212.endif.endif.if.endif...endif, !prof !2

B212.endif.endif.if.endif...if:                   ; preds = %B212.endif.endif.if.endif.endif.endif.endif.if.endif, %B212.endif.endif.if.endif.endif.endif.endif.if.endif.thread
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif.if.endif...endif:                ; preds = %B212.endif.endif.if.endif.endif.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.2000)
  %.2020 = tail call ptr @PyObject_GetAttr(ptr %.1961, ptr nonnull %.2000)
  %.2021 = icmp eq ptr %.2020, null
  br i1 %.2021, label %B212.endif.endif.if.endif...endif.if, label %B212.endif.endif.endif.endif.endif, !prof !0

B212.endif.endif.if.endif...endif.if:             ; preds = %B212.endif.endif.if.endif...endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'type' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif.endif.endif.endif:               ; preds = %B212.endif.endif, %B212.endif.endif.if.endif.endif.endif.endif, %B212.endif.endif.if.endif...endif
  %.2038 = phi ptr [ %.1930, %B212.endif.endif ], [ %.1989, %B212.endif.endif.if.endif.endif.endif.endif ], [ %.2020, %B212.endif.endif.if.endif...endif ]
  %.2075 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr nonnull %.482)
  %.2076 = tail call ptr @PyObject_Call(ptr nonnull %.2038, ptr %.2075, ptr null)
  tail call void @Py_DecRef(ptr %.2075)
  %.2078 = icmp eq ptr %.2076, null
  br i1 %.2078, label %B212.endif.endif.endif.endif.endif.if, label %B212.endif.endif.endif.endif.endif.endif.endif.endif, !prof !0

B212.endif.endif.endif.endif.endif.if:            ; preds = %B212.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.2038)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B212.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.2038)
  %.2132 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr nonnull %.831)
  %.2133 = tail call ptr @PyObject_Call(ptr nonnull %.2076, ptr %.2132, ptr null)
  tail call void @Py_DecRef(ptr %.2132)
  %.2135 = icmp eq ptr %.2133, null
  br i1 %.2135, label %B212.endif.endif.endif.en...if, label %B212.endif.endif.endif.en...endif.endif.endif.endif, !prof !0

B212.endif.endif.endif.en...if:                   ; preds = %B212.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.2076)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B212.endif.endif.endif.en...endif.endif.endif.endif: ; preds = %B212.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.831)
  tail call void @Py_DecRef(ptr nonnull %.2076)
  %.2203 = tail call i32 @PyObject_SetItem(ptr %.167, ptr nonnull %.482, ptr nonnull %.2133)
  %.2204 = icmp slt i32 %.2203, 0
  br i1 %.2204, label %B212.endif.endif.endif.en...if.1, label %B255, !prof !0

B212.endif.endif.endif.en...if.1:                 ; preds = %B212.endif.endif.endif.en...endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.482)
  tail call void @Py_DecRef(ptr nonnull %.2133)
  tail call void @Py_DecRef(ptr %.167)
  tail call void @Py_DecRef(ptr nonnull %arg.random_source)
  tail call void @Py_DecRef(ptr %.266)
  br label %common.ret

B257.endif.endif:                                 ; preds = %B62.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.random_source)
  tail call void @Py_DecRef(ptr nonnull %.347)
  tail call void @Py_DecRef(ptr %.266)
  tail call void @Py_DecRef(ptr nonnull %.366)
  tail call void @Py_IncRef(ptr %.167)
  tail call void @Py_DecRef(ptr %.167)
  store ptr %.167, ptr %retptr, align 8
  br label %common.ret
}

declare void @Py_IncRef(ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

declare ptr @PyList_GetItem(ptr, i64) local_unnamed_addr

declare ptr @PyDict_GetItem(ptr, ptr) local_unnamed_addr

declare ptr @PyObject_GetAttr(ptr, ptr) local_unnamed_addr

declare ptr @PyTuple_Pack(i64, ...) local_unnamed_addr

declare ptr @PyObject_Call(ptr, ptr, ptr) local_unnamed_addr

declare ptr @PyObject_GetIter(ptr) local_unnamed_addr

declare ptr @PyIter_Next(ptr) local_unnamed_addr

declare ptr @PyTuple_New(i64) local_unnamed_addr

declare ptr @PyErr_Occurred() local_unnamed_addr

declare i32 @PyTuple_SetItem(ptr, i64, ptr) local_unnamed_addr

declare ptr @PyBool_FromLong(i32) local_unnamed_addr

declare ptr @PyTuple_GetItem(ptr, i64) local_unnamed_addr

declare i32 @PyObject_IsTrue(ptr) local_unnamed_addr

declare ptr @PySequence_Tuple(ptr) local_unnamed_addr

declare i64 @PyTuple_Size(ptr) local_unnamed_addr

declare ptr @PyLong_FromSsize_t(i64) local_unnamed_addr

declare ptr @PyObject_GetItem(ptr, ptr) local_unnamed_addr

declare ptr @PyNumber_Multiply(ptr, ptr) local_unnamed_addr

declare i32 @PyObject_SetItem(ptr, ptr, ptr) local_unnamed_addr

define ptr @_ZN7cpython9prototype9dict_loopB2v5E8pyobject8pyobject(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.dict_loop, i64 2, i64 2, ptr nonnull %.5, ptr nonnull %.6)
  %.8 = icmp eq i32 %.7, 0
  %.27 = alloca ptr, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  br i1 %.8, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif, %entry.endif.endif.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif.endif.if.endif.if, %entry.endif.endif.endif.endif.endif.if.endif, %entry, %entry.endif.endif.endif.endif.endif.if.if.if, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.endif.endif.if.if.if ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.endif.endif.endif.endif.endif ], [ null, %entry ], [ %.41, %entry.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.endif.if.endif ], [ null, %entry.endif.endif.endif.endif.endif.if.endif.if ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.12 = load ptr, ptr @_ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject, align 8
  %.15 = icmp eq ptr %.12, null
  br i1 %.15, label %entry.endif.if, label %entry.endif.endif.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv9prototype9dict_loopB2v5E8pyobject8pyobject")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif
  %.19 = load ptr, ptr %.5, align 8
  %.23 = load ptr, ptr %.6, align 8
  store ptr null, ptr %.27, align 8
  %.31 = call i32 @_ZN9prototype9dict_loopB2v5E8pyobject8pyobject(ptr nonnull %.27, ptr nonnull %excinfo, ptr %.19, ptr %.23) #0
  %.32 = load ptr, ptr %excinfo, align 8
  %.41 = load ptr, ptr %.27, align 8
  %cond = icmp eq i32 %.31, 0
  br i1 %cond, label %common.ret, label %entry.endif.endif.endif.endif.endif, !prof !4

entry.endif.endif.endif.endif.endif:              ; preds = %entry.endif.endif.endif.endif
  %.39 = icmp sgt i32 %.31, 0
  br i1 %.39, label %entry.endif.endif.endif.endif.endif.if, label %entry.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.endif.if:           ; preds = %entry.endif.endif.endif.endif.endif
  call void @PyErr_Clear()
  %.50 = load { ptr, i32, ptr, ptr, i32 }, ptr %.32, align 8
  %.51 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 4
  %.52 = icmp sgt i32 %.51, 0
  %.55 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 0
  %.57 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 1
  br i1 %.52, label %entry.endif.endif.endif.endif.endif.if.if, label %entry.endif.endif.endif.endif.endif.if.else

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif.endif
  %cond1 = icmp eq i32 %.31, -1
  br i1 %cond1, label %common.ret, label %entry.endif.endif.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.endif.if.if:        ; preds = %entry.endif.endif.endif.endif.endif.if
  %.58 = sext i32 %.57 to i64
  %.59 = call ptr @PyBytes_FromStringAndSize(ptr %.55, i64 %.58)
  %.60 = load { ptr, i32, ptr, ptr, i32 }, ptr %.32, align 8
  %.61 = extractvalue { ptr, i32, ptr, ptr, i32 } %.60, 2
  %.63 = extractvalue { ptr, i32, ptr, ptr, i32 } %.60, 3
  %.65 = call ptr %.63(ptr %.61)
  %.66 = icmp eq ptr %.65, null
  br i1 %.66, label %entry.endif.endif.endif.endif.endif.if.if.if, label %entry.endif.endif.endif.endif.endif.if.if.endif, !prof !0

entry.endif.endif.endif.endif.endif.if.else:      ; preds = %entry.endif.endif.endif.endif.endif.if
  %.79 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 2
  %.80 = call ptr @numba_unpickle(ptr %.55, i32 %.57, ptr %.79)
  br label %entry.endif.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.endif.if.endif:     ; preds = %entry.endif.endif.endif.endif.endif.if.if.endif, %entry.endif.endif.endif.endif.endif.if.else
  %.82 = phi ptr [ %.70, %entry.endif.endif.endif.endif.endif.if.if.endif ], [ %.80, %entry.endif.endif.endif.endif.endif.if.else ]
  %.83.not = icmp eq ptr %.82, null
  br i1 %.83.not, label %common.ret, label %entry.endif.endif.endif.endif.endif.if.endif.if, !prof !0

entry.endif.endif.endif.endif.endif.if.if.if:     ; preds = %entry.endif.endif.endif.endif.endif.if.if
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.Error creating Python tuple from runtime exception arguments")
  br label %common.ret

entry.endif.endif.endif.endif.endif.if.if.endif:  ; preds = %entry.endif.endif.endif.endif.endif.if.if
  %.70 = call ptr @numba_runtime_build_excinfo_struct(ptr %.59, ptr nonnull %.65)
  call void @NRT_Free(ptr nonnull %.32)
  br label %entry.endif.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.endif.if.endif.if:  ; preds = %entry.endif.endif.endif.endif.endif.if.endif
  call void @numba_do_raise(ptr nonnull %.82)
  br label %common.ret

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare ptr @PyBytes_FromStringAndSize(ptr, i64) local_unnamed_addr

declare ptr @numba_unpickle(ptr, i32, ptr) local_unnamed_addr

declare ptr @numba_runtime_build_excinfo_struct(ptr, ptr) local_unnamed_addr

declare void @NRT_Free(ptr) local_unnamed_addr

declare void @numba_do_raise(ptr) local_unnamed_addr

attributes #0 = { noinline }

!0 = !{!"branch_weights", i32 1, i32 99}
!1 = !{i1 true}
!2 = !{!"branch_weights", i32 0, i32 -2147483648}
!3 = !{!"branch_weights", i32 99, i32 1}
!4 = !{!"branch_weights", i32 49, i32 1}
