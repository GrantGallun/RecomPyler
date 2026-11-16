; ModuleID = 'string_build'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.pickledata.1f5fb61c07ae948d056e9c40829cd708870beaf6 = internal constant [120 x i8] c"\80\04\95m\00\00\00\00\00\00\00\8C\08builtins\94\8C\0CRuntimeError\94\93\94\8CHmissing Environment: _ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject\94\85\94N\87\94."
@.const.pickledata.1f5fb61c07ae948d056e9c40829cd708870beaf6.sha1 = internal constant [20 x i8] c"\1F_\B6\1C\07\AE\94\8D\05n\9C@\82\9C\D7\08\87\0B\EA\F6"
@.const.picklebuf.1f5fb61c07ae948d056e9c40829cd708870beaf6 = internal constant { ptr, i32, ptr, ptr, i32 } { ptr @.const.pickledata.1f5fb61c07ae948d056e9c40829cd708870beaf6, i32 120, ptr @.const.pickledata.1f5fb61c07ae948d056e9c40829cd708870beaf6.sha1, ptr null, i32 0 }
@".const.`env.consts` is NULL in `read_const`" = internal constant [37 x i8] c"`env.consts` is NULL in `read_const`\00"
@".const.name 'self' is not defined" = internal constant [27 x i8] c"name 'self' is not defined\00"
@PyExc_NameError = external global i8
@.const.string_build = internal constant [13 x i8] c"string_build\00"
@_ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject = common local_unnamed_addr global ptr null
@PyExc_RuntimeError = external global i8
@".const.missing Environment: _ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject" = internal constant [73 x i8] c"missing Environment: _ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject\00"
@".const.Error creating Python tuple from runtime exception arguments" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"

define range(i32 -1, 2) i32 @_ZN9prototype12string_buildB2v2E8pyobject(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr %arg.self) local_unnamed_addr {
entry:
  %.5 = load ptr, ptr @_ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject, align 8
  %.6 = icmp eq ptr %.5, null
  br i1 %.6, label %entry.if, label %B0, !prof !0

B0:                                               ; preds = %entry
  tail call void @Py_IncRef(ptr %arg.self)
  %.25 = getelementptr i8, ptr %.5, i64 24
  %.26 = load ptr, ptr %.25, align 8
  %.30.not = icmp eq ptr %.26, null
  br i1 %.30.not, label %B0.endif.thread, label %B0.endif

common.ret:                                       ; preds = %B0.endif.endif.endif.endi...endif.2.endif.endif, %B0.endif.endif.endif.endi...endif.3.endif, %B0.endif.endif.endif.endi...if.2, %B0.endif.endif.endif.endi...if.1, %B0.endif.endif.endif.endi...endif.endif.endif.if, %B0.endif.endif.endif.endi...if, %B0.endif.endif.endif.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.endif.if, %B0.endif.endif.if, %B0.endif.if, %entry.if
  %common.ret.op = phi i32 [ 1, %entry.if ], [ -1, %B0.endif.if ], [ -1, %B0.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...if ], [ -1, %B0.endif.endif.endif.endi...endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...if.1 ], [ -1, %B0.endif.endif.endif.endi...if.2 ], [ 0, %B0.endif.endif.endif.endi...endif.3.endif ], [ -1, %B0.endif.endif.endif.endi...endif.2.endif.endif ]
  ret i32 %common.ret.op

entry.if:                                         ; preds = %entry
  store ptr @.const.picklebuf.1f5fb61c07ae948d056e9c40829cd708870beaf6, ptr %excinfo, align 8, !numba_exception_output !1
  br label %common.ret

B0.endif.thread:                                  ; preds = %B0
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.if

B0.endif:                                         ; preds = %B0
  %.32 = tail call ptr @PyList_GetItem(ptr nonnull %.26, i64 0)
  %.38 = icmp eq ptr %.32, null
  br i1 %.38, label %B0.endif.if, label %B0.endif.endif, !prof !2

B0.endif.if:                                      ; preds = %B0.endif.thread, %B0.endif
  tail call void @Py_DecRef(ptr %arg.self)
  br label %common.ret

B0.endif.endif:                                   ; preds = %B0.endif
  tail call void @Py_IncRef(ptr nonnull %.32)
  %.47 = icmp eq ptr %arg.self, null
  br i1 %.47, label %B0.endif.endif.if, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.if:                                ; preds = %B0.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name 'self' is not defined")
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif:                             ; preds = %B0.endif.endif
  %sunkaddr = getelementptr i8, ptr %.5, i64 24
  %.56 = load ptr, ptr %sunkaddr, align 8
  %.60.not = icmp eq ptr %.56, null
  br i1 %.60.not, label %B0.endif.endif.endif.endif.thread, label %B0.endif.endif.endif.endif

B0.endif.endif.endif.endif.thread:                ; preds = %B0.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endif.if

B0.endif.endif.endif.endif:                       ; preds = %B0.endif.endif.endif
  %.62 = tail call ptr @PyList_GetItem(ptr nonnull %.56, i64 1)
  %.68 = icmp eq ptr %.62, null
  br i1 %.68, label %B0.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endif.if:                    ; preds = %B0.endif.endif.endif.endif.thread, %B0.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.62)
  %.76 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.self, ptr nonnull %.62)
  %.77 = icmp eq ptr %.76, null
  br i1 %.77, label %B0.endif.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif.endif.if:              ; preds = %B0.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif.endif.endif.endif.endif:     ; preds = %B0.endif.endif.endif.endif.endif
  %sunkaddr1 = getelementptr i8, ptr %.5, i64 24
  %.98 = load ptr, ptr %sunkaddr1, align 8
  %.102.not = icmp eq ptr %.98, null
  br i1 %.102.not, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.thread, label %B0.endif.endif.endif.endif.endif.endif.endif.endif

B0.endif.endif.endif.endif.endif.endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endif.endif.endif.endif.endif.if

B0.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif
  %.104 = tail call ptr @PyList_GetItem(ptr nonnull %.98, i64 2)
  %.110 = icmp eq ptr %.104, null
  br i1 %.110, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endif.endif.endif.endif.endif.if: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.thread, %B0.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  tail call void @Py_DecRef(ptr nonnull %.76)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.104)
  %.120 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.self, ptr nonnull %.104)
  %.121 = icmp eq ptr %.120, null
  br i1 %.121, label %B0.endif.endif.endif.endi...if, label %B0.endif.endif.endif.endi...endif.endif, !prof !0

B0.endif.endif.endif.endi...if:                   ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  tail call void @Py_DecRef(ptr nonnull %.76)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif.endi...endif.endif:          ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif
  %sunkaddr2 = getelementptr i8, ptr %.5, i64 24
  %.146 = load ptr, ptr %sunkaddr2, align 8
  %.150.not = icmp eq ptr %.146, null
  br i1 %.150.not, label %B0.endif.endif.endif.endi...endif.endif.endif.thread, label %B0.endif.endif.endif.endi...endif.endif.endif

B0.endif.endif.endif.endi...endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endi...endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...endif.endif.endif.if

B0.endif.endif.endif.endi...endif.endif.endif:    ; preds = %B0.endif.endif.endif.endi...endif.endif
  %.152 = tail call ptr @PyList_GetItem(ptr nonnull %.146, i64 3)
  %.158 = icmp eq ptr %.152, null
  br i1 %.158, label %B0.endif.endif.endif.endi...endif.endif.endif.if, label %B0.endif.endif.endif.endi...endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endi...endif.endif.endif.if: ; preds = %B0.endif.endif.endif.endi...endif.endif.endif.thread, %B0.endif.endif.endif.endi...endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.120)
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  tail call void @Py_DecRef(ptr nonnull %.76)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif.endi...endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.152)
  %.170 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.self, ptr nonnull %.152)
  %.171 = icmp eq ptr %.170, null
  br i1 %.171, label %B0.endif.endif.endif.endi...if.1, label %B0.endif.endif.endif.endi...endif.1.endif.endif.endif, !prof !0

B0.endif.endif.endif.endi...if.1:                 ; preds = %B0.endif.endif.endif.endi...endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.120)
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  tail call void @Py_DecRef(ptr nonnull %.76)
  tail call void @Py_DecRef(ptr nonnull %.32)
  br label %common.ret

B0.endif.endif.endif.endi...endif.1.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %arg.self)
  %.226 = tail call ptr (i64, ...) @PyTuple_Pack(i64 3, ptr nonnull %.76, ptr nonnull %.120, ptr nonnull %.170)
  %.227 = icmp eq ptr %.226, null
  br i1 %.227, label %B0.endif.endif.endif.endi...if.2, label %B0.endif.endif.endif.endi...endif.2.endif.endif, !prof !0

B0.endif.endif.endif.endi...if.2:                 ; preds = %B0.endif.endif.endif.endi...endif.1.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.120)
  tail call void @Py_DecRef(ptr nonnull %.32)
  tail call void @Py_DecRef(ptr nonnull %.76)
  tail call void @Py_DecRef(ptr nonnull %.170)
  br label %common.ret

B0.endif.endif.endif.endi...endif.2.endif.endif:  ; preds = %B0.endif.endif.endif.endi...endif.1.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.76)
  tail call void @Py_DecRef(ptr nonnull %.170)
  tail call void @Py_DecRef(ptr nonnull %.120)
  %.267 = tail call ptr @PyNumber_Remainder(ptr nonnull %.32, ptr nonnull %.226)
  %.268 = icmp eq ptr %.267, null
  tail call void @Py_DecRef(ptr nonnull %.32)
  tail call void @Py_DecRef(ptr nonnull %.226)
  br i1 %.268, label %common.ret, label %B0.endif.endif.endif.endi...endif.3.endif, !prof !0

B0.endif.endif.endif.endi...endif.3.endif:        ; preds = %B0.endif.endif.endif.endi...endif.2.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.267)
  tail call void @Py_DecRef(ptr nonnull %.267)
  store ptr %.267, ptr %retptr, align 8
  br label %common.ret
}

declare void @Py_IncRef(ptr) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

declare ptr @PyList_GetItem(ptr, i64) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare ptr @PyObject_GetAttr(ptr, ptr) local_unnamed_addr

declare ptr @PyTuple_Pack(i64, ...) local_unnamed_addr

declare ptr @PyNumber_Remainder(ptr, ptr) local_unnamed_addr

define ptr @_ZN7cpython9prototype12string_buildB2v2E8pyobject(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.string_build, i64 1, i64 1, ptr nonnull %.5)
  %.7 = icmp eq i32 %.6, 0
  %.22 = alloca ptr, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  br i1 %.7, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.endif.endif, %entry.endif.endif.endif, %entry.endif.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif.if.endif.if, %entry.endif.endif.endif.endif.if.endif, %entry, %entry.endif.endif.endif.endif.if.if.if, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.endif.if.if.if ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.endif.endif.endif.endif ], [ null, %entry ], [ %.36, %entry.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.if.endif ], [ null, %entry.endif.endif.endif.endif.if.endif.if ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.11 = load ptr, ptr @_ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject, align 8
  %.14 = icmp eq ptr %.11, null
  br i1 %.14, label %entry.endif.if, label %entry.endif.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv9prototype12string_buildB2v2E8pyobject")
  br label %common.ret

entry.endif.endif.endif:                          ; preds = %entry.endif
  %.18 = load ptr, ptr %.5, align 8
  store ptr null, ptr %.22, align 8
  %.26 = call i32 @_ZN9prototype12string_buildB2v2E8pyobject(ptr nonnull %.22, ptr nonnull %excinfo, ptr %.18) #0
  %.27 = load ptr, ptr %excinfo, align 8
  %.36 = load ptr, ptr %.22, align 8
  %cond = icmp eq i32 %.26, 0
  br i1 %cond, label %common.ret, label %entry.endif.endif.endif.endif, !prof !3

entry.endif.endif.endif.endif:                    ; preds = %entry.endif.endif.endif
  %.34 = icmp sgt i32 %.26, 0
  br i1 %.34, label %entry.endif.endif.endif.endif.if, label %entry.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.if:                 ; preds = %entry.endif.endif.endif.endif
  call void @PyErr_Clear()
  %.45 = load { ptr, i32, ptr, ptr, i32 }, ptr %.27, align 8
  %.46 = extractvalue { ptr, i32, ptr, ptr, i32 } %.45, 4
  %.47 = icmp sgt i32 %.46, 0
  %.50 = extractvalue { ptr, i32, ptr, ptr, i32 } %.45, 0
  %.52 = extractvalue { ptr, i32, ptr, ptr, i32 } %.45, 1
  br i1 %.47, label %entry.endif.endif.endif.endif.if.if, label %entry.endif.endif.endif.endif.if.else

entry.endif.endif.endif.endif.endif:              ; preds = %entry.endif.endif.endif.endif
  %cond1 = icmp eq i32 %.26, -1
  br i1 %cond1, label %common.ret, label %entry.endif.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.if.if:              ; preds = %entry.endif.endif.endif.endif.if
  %.53 = sext i32 %.52 to i64
  %.54 = call ptr @PyBytes_FromStringAndSize(ptr %.50, i64 %.53)
  %.55 = load { ptr, i32, ptr, ptr, i32 }, ptr %.27, align 8
  %.56 = extractvalue { ptr, i32, ptr, ptr, i32 } %.55, 2
  %.58 = extractvalue { ptr, i32, ptr, ptr, i32 } %.55, 3
  %.60 = call ptr %.58(ptr %.56)
  %.61 = icmp eq ptr %.60, null
  br i1 %.61, label %entry.endif.endif.endif.endif.if.if.if, label %entry.endif.endif.endif.endif.if.if.endif, !prof !0

entry.endif.endif.endif.endif.if.else:            ; preds = %entry.endif.endif.endif.endif.if
  %.74 = extractvalue { ptr, i32, ptr, ptr, i32 } %.45, 2
  %.75 = call ptr @numba_unpickle(ptr %.50, i32 %.52, ptr %.74)
  br label %entry.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.if.endif:           ; preds = %entry.endif.endif.endif.endif.if.if.endif, %entry.endif.endif.endif.endif.if.else
  %.77 = phi ptr [ %.65, %entry.endif.endif.endif.endif.if.if.endif ], [ %.75, %entry.endif.endif.endif.endif.if.else ]
  %.78.not = icmp eq ptr %.77, null
  br i1 %.78.not, label %common.ret, label %entry.endif.endif.endif.endif.if.endif.if, !prof !0

entry.endif.endif.endif.endif.if.if.if:           ; preds = %entry.endif.endif.endif.endif.if.if
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.Error creating Python tuple from runtime exception arguments")
  br label %common.ret

entry.endif.endif.endif.endif.if.if.endif:        ; preds = %entry.endif.endif.endif.endif.if.if
  %.65 = call ptr @numba_runtime_build_excinfo_struct(ptr %.54, ptr nonnull %.60)
  call void @NRT_Free(ptr nonnull %.27)
  br label %entry.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.if.endif.if:        ; preds = %entry.endif.endif.endif.endif.if.endif
  call void @numba_do_raise(ptr nonnull %.77)
  br label %common.ret

entry.endif.endif.endif.endif.endif.endif.endif:  ; preds = %entry.endif.endif.endif.endif.endif
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
!3 = !{!"branch_weights", i32 49, i32 1}
